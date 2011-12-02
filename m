Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 8D699100B5F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2011 03:29:13 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 04/10] powerpc/mpic: Save computed phys_addr for
 board-specific code
Date: Fri,  2 Dec 2011 11:28:01 -0500
Message-Id: <1322843287-2745-5-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <1322795058.3729.48.camel@pasglop>
References: <1322795058.3729.48.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <michaele@au1.ibm.com>,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The MPIC code can already perform an automatic OF address translation
step as part of mpic_alloc(), but several boards need to use that base
address when they perform mpic_assign_isu().

The easiest solution is to save the computed physical address into the
"struct mpic" for later use by the board code.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/include/asm/mpic.h                   |    3 +++
 arch/powerpc/platforms/embedded6xx/holly.c        |   15 +++------------
 arch/powerpc/platforms/embedded6xx/linkstation.c  |   14 ++++----------
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   16 +++-------------
 arch/powerpc/platforms/embedded6xx/storcenter.c   |   16 +++-------------
 arch/powerpc/platforms/pasemi/setup.c             |    2 +-
 arch/powerpc/sysdev/mpic.c                        |   11 ++++++-----
 7 files changed, 23 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index e6fae49..ba0b204 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -293,6 +293,9 @@ struct mpic
 	/* Register access method */
 	enum mpic_reg_type	reg_type;
 
+	/* The physical base address of the MPIC */
+	phys_addr_t paddr;
+
 	/* The various ioremap'ed bases */
 	struct mpic_reg_bank	gregs;
 	struct mpic_reg_bank	tmregs;
diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index 2e9bcf6..d4fb41e 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -148,7 +148,6 @@ static void __init holly_setup_arch(void)
 static void __init holly_init_IRQ(void)
 {
 	struct mpic *mpic;
-	phys_addr_t mpic_paddr = 0;
 	struct device_node *tsi_pic;
 #ifdef CONFIG_PCI
 	unsigned int cascade_pci_irq;
@@ -157,20 +156,12 @@ static void __init holly_init_IRQ(void)
 #endif
 
 	tsi_pic = of_find_node_by_type(NULL, "open-pic");
-	if (tsi_pic) {
-		unsigned int size;
-		const void *prop = of_get_property(tsi_pic, "reg", &size);
-		mpic_paddr = of_translate_address(tsi_pic, prop);
-	}
-
-	if (mpic_paddr == 0) {
+	if (!tsi_pic) {
 		printk(KERN_ERR "%s: No tsi108 PIC found !\n", __func__);
 		return;
 	}
 
-	pr_debug("%s: tsi108 pic phys_addr = 0x%x\n", __func__, (u32) mpic_paddr);
-
-	mpic = mpic_alloc(tsi_pic, mpic_paddr,
+	mpic = mpic_alloc(tsi_pic, 0,
 			MPIC_PRIMARY | MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
 			MPIC_SPV_EOI | MPIC_NO_PTHROU_DIS | MPIC_REGSET_TSI108,
 			24,
@@ -179,7 +170,7 @@ static void __init holly_init_IRQ(void)
 
 	BUG_ON(mpic == NULL);
 
-	mpic_assign_isu(mpic, 0, mpic_paddr + 0x100);
+	mpic_assign_isu(mpic, 0, mpic->paddr + 0x100);
 
 	mpic_init(mpic);
 
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index 244f997..72b3685 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -82,28 +82,22 @@ static void __init linkstation_init_IRQ(void)
 {
 	struct mpic *mpic;
 	struct device_node *dnp;
-	const u32 *prop;
-	int size;
-	phys_addr_t paddr;
 
 	dnp = of_find_node_by_type(NULL, "open-pic");
 	if (dnp == NULL)
 		return;
 
-	prop = of_get_property(dnp, "reg", &size);
-	paddr = (phys_addr_t)of_translate_address(dnp, prop);
-
-	mpic = mpic_alloc(dnp, paddr, MPIC_PRIMARY | MPIC_WANTS_RESET, 4, 32, " EPIC     ");
+	mpic = mpic_alloc(dnp, 0, MPIC_PRIMARY | MPIC_WANTS_RESET, 4, 32, " EPIC     ");
 	BUG_ON(mpic == NULL);
 
 	/* PCI IRQs */
-	mpic_assign_isu(mpic, 0, paddr + 0x10200);
+	mpic_assign_isu(mpic, 0, mpic->paddr + 0x10200);
 
 	/* I2C */
-	mpic_assign_isu(mpic, 1, paddr + 0x11000);
+	mpic_assign_isu(mpic, 1, mpic->paddr + 0x11000);
 
 	/* ttyS0, ttyS1 */
-	mpic_assign_isu(mpic, 2, paddr + 0x11100);
+	mpic_assign_isu(mpic, 2, mpic->paddr + 0x11100);
 
 	mpic_init(mpic);
 }
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index f8f33e1..c8ce204 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -102,7 +102,6 @@ static void __init mpc7448_hpc2_setup_arch(void)
 static void __init mpc7448_hpc2_init_IRQ(void)
 {
 	struct mpic *mpic;
-	phys_addr_t mpic_paddr = 0;
 	struct device_node *tsi_pic;
 #ifdef CONFIG_PCI
 	unsigned int cascade_pci_irq;
@@ -111,21 +110,12 @@ static void __init mpc7448_hpc2_init_IRQ(void)
 #endif
 
 	tsi_pic = of_find_node_by_type(NULL, "open-pic");
-	if (tsi_pic) {
-		unsigned int size;
-		const void *prop = of_get_property(tsi_pic, "reg", &size);
-		mpic_paddr = of_translate_address(tsi_pic, prop);
-	}
-
-	if (mpic_paddr == 0) {
+	if (!tsi_pic) {
 		printk("%s: No tsi108 PIC found !\n", __func__);
 		return;
 	}
 
-	DBG("%s: tsi108 pic phys_addr = 0x%x\n", __func__,
-	    (u32) mpic_paddr);
-
-	mpic = mpic_alloc(tsi_pic, mpic_paddr,
+	mpic = mpic_alloc(tsi_pic, 0,
 			MPIC_PRIMARY | MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
 			MPIC_SPV_EOI | MPIC_NO_PTHROU_DIS | MPIC_REGSET_TSI108,
 			24,
@@ -134,7 +124,7 @@ static void __init mpc7448_hpc2_init_IRQ(void)
 
 	BUG_ON(mpic == NULL);
 
-	mpic_assign_isu(mpic, 0, mpic_paddr + 0x100);
+	mpic_assign_isu(mpic, 0, mpic->paddr + 0x100);
 
 	mpic_init(mpic);
 
diff --git a/arch/powerpc/platforms/embedded6xx/storcenter.c b/arch/powerpc/platforms/embedded6xx/storcenter.c
index f1eebca..084f0fc 100644
--- a/arch/powerpc/platforms/embedded6xx/storcenter.c
+++ b/arch/powerpc/platforms/embedded6xx/storcenter.c
@@ -84,22 +84,12 @@ static void __init storcenter_init_IRQ(void)
 {
 	struct mpic *mpic;
 	struct device_node *dnp;
-	const void *prop;
-	int size;
-	phys_addr_t paddr;
 
 	dnp = of_find_node_by_type(NULL, "open-pic");
 	if (dnp == NULL)
 		return;
 
-	prop = of_get_property(dnp, "reg", &size);
-	if (prop == NULL) {
-		of_node_put(dnp);
-		return;
-	}
-
-	paddr = (phys_addr_t)of_translate_address(dnp, prop);
-	mpic = mpic_alloc(dnp, paddr, MPIC_PRIMARY | MPIC_WANTS_RESET,
+	mpic = mpic_alloc(dnp, 0, MPIC_PRIMARY | MPIC_WANTS_RESET,
 			16, 32, " OpenPIC  ");
 
 	of_node_put(dnp);
@@ -110,8 +100,8 @@ static void __init storcenter_init_IRQ(void)
 	 * 16 Serial Interrupts followed by 16 Internal Interrupts.
 	 * I2C is the second internal, so it is at 17, 0x11020.
 	 */
-	mpic_assign_isu(mpic, 0, paddr + 0x10200);
-	mpic_assign_isu(mpic, 1, paddr + 0x11000);
+	mpic_assign_isu(mpic, 0, mpic->paddr + 0x10200);
+	mpic_assign_isu(mpic, 1, mpic->paddr + 0x11000);
 
 	mpic_init(mpic);
 }
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 6f35582..baf20a9 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -234,7 +234,7 @@ static __init void pas_init_IRQ(void)
 			  mpic_flags, 0, 0, "PASEMI-OPIC");
 	BUG_ON(!mpic);
 
-	mpic_assign_isu(mpic, 0, openpic_addr + 0x10000);
+	mpic_assign_isu(mpic, 0, mpic->paddr + 0x10000);
 	mpic_init(mpic);
 	/* The NMI/MCK source needs to be prio 15 */
 	if (nmiprop) {
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 59564dc..ef721c3 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1164,6 +1164,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 		return NULL;
 
 	mpic->name = name;
+	mpic->paddr = phys_addr;
 
 	mpic->hc_irq = mpic_irq_chip;
 	mpic->hc_irq.name = name;
@@ -1250,8 +1251,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 #endif
 
 	/* Map the global registers */
-	mpic_map(mpic, node, phys_addr, &mpic->gregs, MPIC_INFO(GREG_BASE), 0x1000);
-	mpic_map(mpic, node, phys_addr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);
+	mpic_map(mpic, node, mpic->paddr, &mpic->gregs, MPIC_INFO(GREG_BASE), 0x1000);
+	mpic_map(mpic, node, mpic->paddr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);
 
 	/* Reset */
 
@@ -1306,7 +1307,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	for_each_possible_cpu(i) {
 		unsigned int cpu = get_hard_smp_processor_id(i);
 
-		mpic_map(mpic, node, phys_addr, &mpic->cpuregs[cpu],
+		mpic_map(mpic, node, mpic->paddr, &mpic->cpuregs[cpu],
 			 MPIC_INFO(CPU_BASE) + cpu * MPIC_INFO(CPU_STRIDE),
 			 0x1000);
 	}
@@ -1314,7 +1315,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	/* Initialize main ISU if none provided */
 	if (mpic->isu_size == 0) {
 		mpic->isu_size = mpic->num_sources;
-		mpic_map(mpic, node, phys_addr, &mpic->isus[0],
+		mpic_map(mpic, node, mpic->paddr, &mpic->isus[0],
 			 MPIC_INFO(IRQ_BASE), MPIC_INFO(IRQ_STRIDE) * mpic->isu_size);
 	}
 	mpic->isu_shift = 1 + __ilog2(mpic->isu_size - 1);
@@ -1346,7 +1347,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	}
 	printk(KERN_INFO "mpic: Setting up MPIC \"%s\" version %s at %llx,"
 	       " max %d CPUs\n",
-	       name, vers, (unsigned long long)phys_addr, num_possible_cpus());
+	       name, vers, (unsigned long long)mpic->paddr, num_possible_cpus());
 	printk(KERN_INFO "mpic: ISU size: %d, shift: %d, mask: %x\n",
 	       mpic->isu_size, mpic->isu_shift, mpic->isu_mask);
 
-- 
1.7.2.5
