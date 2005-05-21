Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ADAFE679F4
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 22 May 2005 13:51:15 +1000 (EST)
Date: Sat, 21 May 2005 19:27:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050521222713.GA28813@logos.cnet>
References: <20050520141244.GD24923@logos.cnet>
	<e503cf4ab6d2d389b29474561048f2f2@embeddededge.com>
	<20050520175152.GB26221@logos.cnet>
	<5d184282e7d324fb009b8dcf6e6f967d@embeddededge.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
In-Reply-To: <5d184282e7d324fb009b8dcf6e6f967d@embeddededge.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [RFT] 8xx cpm_hostalloc patch was: allow coherent DMA API to work
	before main page allocator is set up
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Can someone with 8xx using the cpm_uart driver please test 
the attached patch? It should avoid corruption of the pinned
8Mbyte CONFIG_PIN_TLB entry, as noted by Dan. 

On Sat, May 21, 2005 at 05:21:47PM -0400, Dan Malek wrote:
> 
> On May 20, 2005, at 1:51 PM, Marcelo Tosatti wrote:
> 
> >I must be missing something very obvious here, can you explain how
> >did you arrange things in v2.4 such that the console's ->setup
> >method is called _after_ mem_init() ?
> 
> The driver used to use the serial port configuration as left by the
> boot rom until very late into the initialization.  As I have said many
> times in the past, the serial driver went through three different
> levels of configuration.  There was an early configuration that was
> used for kgdb, a later one used by the serial kernel printk, and
> finally a full configuration by the serial driver. 

I have missed your statements about that in the past.

OK, the v2.4 driver is using the dual port RAM: 

        /* Allocate space for two FIFOs.  We can't allocate from host
         * memory yet because vm allocator isn't initialized
         * during this early console init.
         */
        dp_addr = m8xx_cpm_dpalloc(2*EARLY_BUF_SIZE);
        mem_addr = (uint)(&cpmp->cp_dpmem[dp_addr]);

> It's sad that "moving forward" is done at a cost of throwing away
> features that were important. 

Now that I think of it, no v2.6 driver should be calling
dma_alloc_coherent() before mem_init(). I was seeing the problem
because we're still using the old uart driver, which does that, and 
our timer setup routine also.

> is a quick fix, but this further ensures features like pinned TLB
> entries won't work. 

Actually, the quick fix to use bootmem allocator ensures that the 
pinned TLB is _preserved_ (by using a pagetableentry from the consistent 
DMA address space to mark as uncached and invalidate, instead of a pte 
from the kernel direct mapped virtual space which blows away the 8Mbyte
entry - current v2.6 state).

Why do you say that "further ensures that features like pinned TLB 
entries won't work" ? 

If there is really a problem with using the bootmem allocator for 
noncacheable purposes (which I can't see), it should be pretty easy 
to modify cpm_uart to use dpram instead of host bootmem RAM, right?


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="8xx.patch"

--- linux-2.6.11.orig/arch/ppc/syslib/m8xx_setup.c	2005-05-20 13:53:17.000000000 -0300
+++ linux-2.6.11/arch/ppc/syslib/m8xx_setup.c	2005-05-20 15:59:24.000000000 -0300
@@ -57,7 +57,7 @@
 extern void m8xx_ide_init(void);
 
 extern unsigned long find_available_memory(void);
-extern void m8xx_cpm_reset(uint cpm_page);
+extern void m8xx_cpm_reset();
 extern void m8xx_wdt_handler_install(bd_t *bp);
 extern void rpxfb_alloc_pages(void);
 extern void cpm_interrupt_init(void);
@@ -70,13 +70,9 @@
 void __init
 m8xx_setup_arch(void)
 {
-	int	cpm_page;
-
-	cpm_page = (int) alloc_bootmem_pages(PAGE_SIZE);
-
 	/* Reset the Communication Processor Module.
 	*/
-	m8xx_cpm_reset(cpm_page);
+	m8xx_cpm_reset();
 
 #ifdef CONFIG_FB_RPX
 	rpxfb_alloc_pages();
--- linux-2.6.11.orig/arch/ppc/8xx_io/commproc.c	2005-05-20 13:53:17.000000000 -0300
+++ linux-2.6.11/arch/ppc/8xx_io/commproc.c	2005-05-22 00:29:42.000000000 -0300
@@ -39,8 +39,6 @@
 #include <asm/tlbflush.h>
 #include <asm/rheap.h>
 
-extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep);
-
 static void m8xx_cpm_dpinit(void);
 static	uint	host_buffer;	/* One page of host buffer */
 static	uint	host_end;	/* end + 1 */
@@ -111,11 +109,10 @@
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 
 void
-m8xx_cpm_reset(uint bootpage)
+m8xx_cpm_reset(void)
 {
 	volatile immap_t	 *imp;
 	volatile cpm8xx_t	*commproc;
-	pte_t *pte;
 
 	imp = (immap_t *)IMAP_ADDR;
 	commproc = (cpm8xx_t *)&imp->im_cpm;
@@ -143,17 +140,6 @@
 	/* Reclaim the DP memory for our use. */
 	m8xx_cpm_dpinit();
 
-	/* get the PTE for the bootpage */
-	if (!get_pteptr(&init_mm, bootpage, &pte))
-	       panic("get_pteptr failed\n");
-																							
-	/* and make it uncachable */
-	pte_val(*pte) |= _PAGE_NO_CACHE;
-	_tlbie(bootpage);
-
-	host_buffer = bootpage;
-	host_end = host_buffer + PAGE_SIZE;
-
 	/* Tell everyone where the comm processor resides.
 	*/
 	cpmp = (cpm8xx_t *)commproc;

--Kj7319i9nmIyA2yE--
