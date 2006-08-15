Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 125F167B5C
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 07:24:37 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k7FLOaea005375
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 14:24:36 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7FLOZ1K020587
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 16:24:35 -0500 (CDT)
Subject: [PATCH] Allow MPC8641 HPCN to build with CONFIG_PCI disabled too.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1155676741.10054.105.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 15 Aug 2006 16:19:02 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

 arch/powerpc/kernel/prom_parse.c           |    5 ++++-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    9 +++++++--
 arch/powerpc/platforms/86xx/pci.c          |    3 ++-
 include/asm-powerpc/mpc86xx.h              |    2 --
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 59f69d3..1dd6aef 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -601,10 +601,12 @@ static struct device_node *of_irq_find_p
 	return p;
 }
 
+#ifdef CONFIG_PCI
 static u8 of_irq_pci_swizzle(u8 slot, u8 pin)
 {
 	return (((pin - 1) + slot) % 4) + 1;
 }
+#endif	/* CONFIG_PCI */
 
 /* This doesn't need to be called if you don't have any special workaround
  * flags to pass
@@ -895,6 +897,7 @@ int of_irq_map_one(struct device_node *d
 }
 EXPORT_SYMBOL_GPL(of_irq_map_one);
 
+#ifdef CONFIG_PCI
 int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
 {
 	struct device_node *dn, *ppnode;
@@ -971,4 +974,4 @@ #endif
 	return of_irq_map_raw(ppnode, &lspec, laddr, out_irq);
 }
 EXPORT_SYMBOL_GPL(of_irq_map_pci);
-
+#endif	/* CONFIG_PCI */
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 4a33d95..496cc7c 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -52,6 +52,7 @@ unsigned long pci_dram_offset = 0;
 #endif
 
 
+#ifdef CONFIG_PCI
 static void mpc86xx_8259_cascade(unsigned int irq, struct irq_desc *desc,
 				 struct pt_regs *regs)
 {
@@ -60,14 +61,18 @@ static void mpc86xx_8259_cascade(unsigne
 		generic_handle_irq(cascade_irq, regs);
 	desc->chip->eoi(irq);
 }
+#endif	/* CONFIG_PCI */
 
 void __init
 mpc86xx_hpcn_init_irq(void)
 {
 	struct mpic *mpic1;
-	struct device_node *np, *cascade_node = NULL;
-	int cascade_irq;
+	struct device_node *np;
 	phys_addr_t openpic_paddr;
+#ifdef CONFIG_PCI
+	struct device_node *cascade_node = NULL;
+	int cascade_irq;
+#endif
 
 	np = of_find_node_by_type(NULL, "open-pic");
 	if (np == NULL)
diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index d7050c1..481e18e 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -188,7 +188,8 @@ int __init add_bridge(struct device_node
 
 	printk(KERN_INFO "Found MPC86xx PCIE host bridge at 0x%08lx. "
 	       "Firmware bus number: %d->%d\n",
-		rsrc.start, hose->first_busno, hose->last_busno);
+	       (unsigned long) rsrc.start,
+	       hose->first_busno, hose->last_busno);
 
 	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
 		hose, hose->cfg_addr, hose->cfg_data);
diff --git a/include/asm-powerpc/mpc86xx.h b/include/asm-powerpc/mpc86xx.h
index f260382..2d6ad85 100644
--- a/include/asm-powerpc/mpc86xx.h
+++ b/include/asm-powerpc/mpc86xx.h
@@ -23,8 +23,6 @@ #define _IO_BASE        isa_io_base
 #define _ISA_MEM_BASE   isa_mem_base
 #ifdef CONFIG_PCI
 #define PCI_DRAM_OFFSET pci_dram_offset
-#else
-#define PCI_DRAM_OFFSET 0
 #endif
 
 #define CPU0_BOOT_RELEASE 0x01000000
-- 
2006_06_07.01.gittree_pull-dirty
