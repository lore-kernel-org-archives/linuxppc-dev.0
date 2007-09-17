Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8E92DE04B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 02:58:47 +1000 (EST)
Date: Mon, 17 Sep 2007 11:58:07 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 20/28] cpm2: Infrastructure code cleanup.
Message-ID: <20070917165807.GT6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165643.GA6545@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mostly sparse fixes (__iomem annotations, etc); also, cpm2_immr
is used rather than creating many temporary mappings.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/cpm2_common.c |   52 ++++++++++++++++++++++++++----------
 arch/powerpc/sysdev/cpm2_pic.c    |    2 +-
 include/asm-powerpc/cpm2.h        |    2 +-
 include/asm-powerpc/fs_pd.h       |   19 ++-----------
 include/asm-powerpc/immap_cpm2.h  |    4 ++-
 5 files changed, 45 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index 3bf89b3..b4d8bd2 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -33,6 +33,8 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/of.h>
+
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/mpc8260.h>
@@ -45,13 +47,12 @@
 #include <sysdev/fsl_soc.h>
 
 static void cpm2_dpinit(void);
-cpm_cpm2_t	*cpmp;		/* Pointer to comm processor space */
+cpm_cpm2_t __iomem *cpmp; /* Pointer to comm processor space */
 
 /* We allocate this here because it is used almost exclusively for
  * the communication processor devices.
  */
-cpm2_map_t *cpm2_immr;
-intctl_cpm2_t *cpm2_intctl;
+cpm2_map_t __iomem *cpm2_immr;
 
 #define CPM_MAP_SIZE	(0x40000)	/* 256k - the PQ3 reserve this amount
 					   of space for CPM as it is larger
@@ -60,8 +61,7 @@ intctl_cpm2_t *cpm2_intctl;
 void
 cpm2_reset(void)
 {
-	cpm2_immr = (cpm2_map_t *)ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);
-	cpm2_intctl = cpm2_map(im_intctl);
+	cpm2_immr = ioremap(get_immrbase(), CPM_MAP_SIZE);
 
 	/* Reclaim the DP memory for our use.
 	 */
@@ -91,7 +91,7 @@ cpm2_reset(void)
 void
 cpm_setbrg(uint brg, uint rate)
 {
-	volatile uint	*bp;
+	u32 __iomem *bp;
 
 	/* This is good enough to get SMCs running.....
 	*/
@@ -113,7 +113,8 @@ cpm_setbrg(uint brg, uint rate)
 void
 cpm2_fastbrg(uint brg, uint rate, int div16)
 {
-	volatile uint	*bp;
+	u32 __iomem *bp;
+	u32 val;
 
 	if (brg < 4) {
 		bp = cpm2_map_size(im_brgc1, 16);
@@ -123,10 +124,11 @@ cpm2_fastbrg(uint brg, uint rate, int div16)
 		brg -= 4;
 	}
 	bp += brg;
-	*bp = ((BRG_INT_CLK / rate) << 1) | CPM_BRG_EN;
+	val = ((BRG_INT_CLK / rate) << 1) | CPM_BRG_EN;
 	if (div16)
-		*bp |= CPM_BRG_DIV16;
+		val |= CPM_BRG_DIV16;
 
+	out_be32(bp, val);
 	cpm2_unmap(bp);
 }
 
@@ -135,8 +137,8 @@ int cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode)
 	int ret = 0;
 	int shift;
 	int i, bits = 0;
-	cpmux_t *im_cpmux;
-	u32 *reg;
+	cpmux_t __iomem *im_cpmux;
+	u32 __iomem *reg;
 	u32 mask = 7;
 	u8 clk_map [24][3] = {
 		{CPM_CLK_FCC1, CPM_BRG5, 0},
@@ -228,13 +230,33 @@ static spinlock_t cpm_dpmem_lock;
  * until the memory subsystem goes up... */
 static rh_block_t cpm_boot_dpmem_rh_block[16];
 static rh_info_t cpm_dpmem_info;
-static u8* im_dprambase;
+static u8 __iomem *im_dprambase;
 
 static void cpm2_dpinit(void)
 {
-	spin_lock_init(&cpm_dpmem_lock);
+	struct resource r;
+
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,cpm2");
+	if (!np)
+		panic("Cannot find CPM2 node");
 
-	im_dprambase = ioremap(CPM_MAP_ADDR, CPM_DATAONLY_BASE + CPM_DATAONLY_SIZE);
+	if (of_address_to_resource(np, 1, &r))
+		panic("Cannot get CPM2 resource 1");
+
+	of_node_put(np);
+#else
+	r.start = CPM_MAP_ADDR + CPM_DATAONLY_BASE;
+	r.end = r.start + CPM_DATAONLY_SIZE - 1;
+#endif
+
+	im_dprambase = ioremap(r.start, r.end - r.start + 1);
+	if (!im_dprambase)
+		panic("Cannot map DPRAM");
+
+	spin_lock_init(&cpm_dpmem_lock);
 
 	/* initialize the info header */
 	rh_init(&cpm_dpmem_info, 1,
@@ -248,7 +270,7 @@ static void cpm2_dpinit(void)
 	 * varies with the processor and the microcode patches activated.
 	 * But the following should be at least safe.
 	 */
-	rh_attach_region(&cpm_dpmem_info, CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
+	rh_attach_region(&cpm_dpmem_info, 0, r.end - r.start + 1);
 }
 
 /* This function returns an index into the DPRAM area.
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index d5b36e0..5fe65b2 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -48,7 +48,7 @@
 #define CPM2_IRQ_PORTC15	48
 #define CPM2_IRQ_PORTC0		63
 
-static intctl_cpm2_t *cpm2_intctl;
+static intctl_cpm2_t __iomem *cpm2_intctl;
 
 static struct irq_host *cpm2_pic_host;
 #define NR_MASK_WORDS   ((NR_IRQS + 31) / 32)
diff --git a/include/asm-powerpc/cpm2.h b/include/asm-powerpc/cpm2.h
index 12a2860..c036506 100644
--- a/include/asm-powerpc/cpm2.h
+++ b/include/asm-powerpc/cpm2.h
@@ -107,7 +107,7 @@
 /* Export the base address of the communication processor registers
  * and dual port ram.
  */
-extern		cpm_cpm2_t	*cpmp;	 /* Pointer to comm processor */
+extern cpm_cpm2_t __iomem *cpmp; /* Pointer to comm processor */
 
 extern unsigned long cpm_dpalloc(uint size, uint align);
 extern int cpm_dpfree(unsigned long offset);
diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
index 77e04d0..64706a0 100644
--- a/include/asm-powerpc/fs_pd.h
+++ b/include/asm-powerpc/fs_pd.h
@@ -23,22 +23,9 @@
 #include <asm/mpc85xx.h>
 #endif
 
-#define cpm2_map(member)						\
-({									\
-	u32 offset = offsetof(cpm2_map_t, member);			\
-	void *addr = ioremap (CPM_MAP_ADDR + offset,			\
-			      sizeof( ((cpm2_map_t*)0)->member));	\
-	addr;								\
-})
-
-#define cpm2_map_size(member, size)					\
-({									\
-	u32 offset = offsetof(cpm2_map_t, member);			\
-	void *addr = ioremap (CPM_MAP_ADDR + offset, size);		\
-	addr;								\
-})
-
-#define cpm2_unmap(addr)	iounmap(addr)
+#define cpm2_map(member) (&cpm2_immr->member)
+#define cpm2_map_size(member, size) (&cpm2_immr->member)
+#define cpm2_unmap(addr) do {} while(0)
 #endif
 
 #ifdef CONFIG_8xx
diff --git a/include/asm-powerpc/immap_cpm2.h b/include/asm-powerpc/immap_cpm2.h
index f316a91..4080bab 100644
--- a/include/asm-powerpc/immap_cpm2.h
+++ b/include/asm-powerpc/immap_cpm2.h
@@ -10,6 +10,8 @@
 #ifndef __IMMAP_CPM2__
 #define __IMMAP_CPM2__
 
+#include <linux/types.h>
+
 /* System configuration registers.
 */
 typedef	struct sys_82xx_conf {
@@ -642,7 +644,7 @@ typedef struct immap {
 	u8		res11[4096];
 } cpm2_map_t;
 
-extern cpm2_map_t	*cpm2_immr;
+extern cpm2_map_t __iomem *cpm2_immr;
 
 #endif /* __IMMAP_CPM2__ */
 #endif /* __KERNEL__ */
-- 
1.5.3.1
