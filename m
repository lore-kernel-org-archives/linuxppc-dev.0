Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7A15FDE035
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 02:16:59 +1100 (EST)
Message-ID: <4798ABB3.4060809@scram.de>
Date: Thu, 24 Jan 2008 16:16:03 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCHv3 1/7] [POWERPC] Remove unused m8xx_cpm_hostalloc/free/dump()
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

m8xx_cpm_hostalloc is still defined in commproc.c, but no users are left
in the kernel tree. m8xx_cpm_hostfree and m8xx_cpm_hostdump are only
defined in the headers. Remove this dead code.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/powerpc/sysdev/commproc.c |   37 -------------------------------------
 arch/ppc/8xx_io/commproc.c     |   38 --------------------------------------
 include/asm-powerpc/commproc.h |    4 ----
 include/asm-ppc/commproc.h     |    4 ----
 4 files changed, 0 insertions(+), 83 deletions(-)

diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index 621bc6c..818d4b0 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -48,8 +48,6 @@
 #ifndef CONFIG_PPC_CPM_NEW_BINDING
 static void m8xx_cpm_dpinit(void);
 #endif
-static uint host_buffer; /* One page of host buffer */
-static uint host_end;    /* end + 1 */
 cpm8xx_t __iomem *cpmp;  /* Pointer to comm processor space */
 immap_t __iomem *mpc8xx_immr;
 static cpic8xx_t __iomem *cpic_reg;
@@ -268,41 +266,6 @@ out:
 }
 EXPORT_SYMBOL(cpm_command);
 
-/* We used to do this earlier, but have to postpone as long as possible
- * to ensure the kernel VM is now running.
- */
-static void
-alloc_host_memory(void)
-{
-	dma_addr_t	physaddr;
-
-	/* Set the host page for allocation.
-	*/
-	host_buffer = (uint)dma_alloc_coherent(NULL, PAGE_SIZE, &physaddr,
-			GFP_KERNEL);
-	host_end = host_buffer + PAGE_SIZE;
-}
-
-/* We also own one page of host buffer space for the allocation of
- * UART "fifos" and the like.
- */
-uint
-m8xx_cpm_hostalloc(uint size)
-{
-	uint	retloc;
-
-	if (host_buffer == 0)
-		alloc_host_memory();
-
-	if ((host_buffer + size) >= host_end)
-		return(0);
-
-	retloc = host_buffer;
-	host_buffer += size;
-
-	return(retloc);
-}
-
 /* Set a baud rate generator.  This needs lots of work.  There are
  * four BRGs, any of which can be wired to any channel.
  * The internal baud rate clock is the system clock divided by 16.
diff --git a/arch/ppc/8xx_io/commproc.c b/arch/ppc/8xx_io/commproc.c
index 9da880b..3f93af8 100644
--- a/arch/ppc/8xx_io/commproc.c
+++ b/arch/ppc/8xx_io/commproc.c
@@ -55,8 +55,6 @@
 })
 
 static void m8xx_cpm_dpinit(void);
-static	uint	host_buffer;	/* One page of host buffer */
-static	uint	host_end;	/* end + 1 */
 cpm8xx_t	*cpmp;		/* Pointer to comm processor space */
 
 /* CPM interrupt vector functions.
@@ -68,7 +66,6 @@ struct	cpm_action {
 static	struct	cpm_action cpm_vecs[CPMVEC_NR];
 static	irqreturn_t cpm_interrupt(int irq, void * dev);
 static	irqreturn_t cpm_error_interrupt(int irq, void *dev);
-static	void	alloc_host_memory(void);
 /* Define a table of names to identify CPM interrupt handlers in
  * /proc/interrupts.
  */
@@ -158,21 +155,6 @@ m8xx_cpm_reset(void)
 	cpmp = (cpm8xx_t *)commproc;
 }
 
-/* We used to do this earlier, but have to postpone as long as possible
- * to ensure the kernel VM is now running.
- */
-static void
-alloc_host_memory(void)
-{
-	dma_addr_t	physaddr;
-
-	/* Set the host page for allocation.
-	*/
-	host_buffer = (uint)dma_alloc_coherent(NULL, PAGE_SIZE, &physaddr,
-			GFP_KERNEL);
-	host_end = host_buffer + PAGE_SIZE;
-}
-
 /* This is called during init_IRQ.  We used to do it above, but this
  * was too early since init_IRQ was not yet called.
  */
@@ -319,26 +301,6 @@ cpm_free_handler(int cpm_vec)
 	cpm_vecs[cpm_vec].dev_id = NULL;
 }
 
-/* We also own one page of host buffer space for the allocation of
- * UART "fifos" and the like.
- */
-uint
-m8xx_cpm_hostalloc(uint size)
-{
-	uint	retloc;
-
-	if (host_buffer == 0)
-		alloc_host_memory();
-
-	if ((host_buffer + size) >= host_end)
-		return(0);
-
-	retloc = host_buffer;
-	host_buffer += size;
-
-	return(retloc);
-}
-
 /* Set a baud rate generator.  This needs lots of work.  There are
  * four BRGs, any of which can be wired to any channel.
  * The internal baud rate clock is the system clock divided by 16.
diff --git a/include/asm-powerpc/commproc.h b/include/asm-powerpc/commproc.h
index 9e3b864..9757521 100644
--- a/include/asm-powerpc/commproc.h
+++ b/include/asm-powerpc/commproc.h
@@ -87,10 +87,6 @@ extern uint cpm_dpram_phys(u8* addr);
 
 extern void cpm_setbrg(uint brg, uint rate);
 
-extern uint m8xx_cpm_hostalloc(uint size);
-extern int  m8xx_cpm_hostfree(uint start);
-extern void m8xx_cpm_hostdump(void);
-
 extern void cpm_load_patch(cpm8xx_t *cp);
 
 /* Buffer descriptors used by many of the CPM protocols.
diff --git a/include/asm-ppc/commproc.h b/include/asm-ppc/commproc.h
index 462abb1..5418d6d 100644
--- a/include/asm-ppc/commproc.h
+++ b/include/asm-ppc/commproc.h
@@ -75,10 +75,6 @@ extern void *cpm_dpram_addr(unsigned long offset);
 extern uint cpm_dpram_phys(u8* addr);
 extern void cpm_setbrg(uint brg, uint rate);
 
-extern uint m8xx_cpm_hostalloc(uint size);
-extern int  m8xx_cpm_hostfree(uint start);
-extern void m8xx_cpm_hostdump(void);
-
 extern void cpm_load_patch(volatile immap_t *immr);
 
 /* Buffer descriptors used by many of the CPM protocols.
-- 
1.5.3.8
