Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6632DDEE1
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:51:03 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 14/25] [POWERPC] Make endianess of cfg_addr for indirect pci
	ops runtime
Date: Mon, 23 Jul 2007 15:50:01 -0500
Message-Id: <11852238333649-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11852238322319-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
	<11852238193371-git-send-email-galak@kernel.crashing.org>
	<1185223821183-git-send-email-galak@kernel.crashing.org>
	<11852238233066-git-send-email-galak@kernel.crashing.org>
	<11852238241475-git-send-email-galak@kernel.crashing.org>
	<11852238253550-git-send-email-galak@kernel.crashing.org>
	<11852238271141-git-send-email-galak@kernel.crashing.org>
	<11852238283648-git-send-email-galak@kernel.crashing.org>
	<1185223830411-git-send-email-galak@kernel.crashing.org>
	<11852238322319-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make it so we do a runtime check to know if we need to write cfg_addr
as big or little endian.  This is needed if we want to allow 86xx support
to co-exist in the same kernel as other 6xx PPCs.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig                             |    5 -----
 arch/powerpc/platforms/82xx/mpc82xx_ads.c        |    3 ++-
 arch/powerpc/platforms/83xx/pci.c                |    4 ++--
 arch/powerpc/platforms/85xx/Kconfig              |    1 -
 arch/powerpc/platforms/86xx/Kconfig              |    1 -
 arch/powerpc/platforms/chrp/pci.c                |    7 ++++---
 arch/powerpc/platforms/embedded6xx/linkstation.c |    2 +-
 arch/powerpc/sysdev/fsl_pci.c                    |    3 ++-
 arch/powerpc/sysdev/grackle.c                    |    2 +-
 arch/powerpc/sysdev/indirect_pci.c               |   20 +++++++++++++++++---
 arch/powerpc/sysdev/mv64x60_pci.c                |    2 +-
 include/asm-powerpc/pci-bridge.h                 |    6 +++++-
 12 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3ff90f0..00099ef 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -411,11 +411,6 @@ config PPC_INDIRECT_PCI
 	default y if 40x || 44x
 	default n
 
-config PPC_INDIRECT_PCI_BE
-	bool
-	depends PPC_INDIRECT_PCI
-	default n
-
 config EISA
 	bool
 
diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index da20832..2d1b05b 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -553,7 +553,8 @@ static void __init mpc82xx_add_bridge(struct device_node *np)
 
 	setup_indirect_pci(hose,
 			   r.start + offsetof(pci_cpm2_t, pci_cfg_addr),
-			   r.start + offsetof(pci_cpm2_t, pci_cfg_data));
+			   r.start + offsetof(pci_cpm2_t, pci_cfg_data),
+			   0);
 
 	pci_process_bridge_OF_ranges(hose, np, 1);
 }
diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
index c0e2b89..9206946 100644
--- a/arch/powerpc/platforms/83xx/pci.c
+++ b/arch/powerpc/platforms/83xx/pci.c
@@ -74,11 +74,11 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	 */
 	/* PCI 1 */
 	if ((rsrc.start & 0xfffff) == 0x8500) {
-		setup_indirect_pci(hose, immr + 0x8300, immr + 0x8304);
+		setup_indirect_pci(hose, immr + 0x8300, immr + 0x8304, 0);
 	}
 	/* PCI 2 */
 	if ((rsrc.start & 0xfffff) == 0x8600) {
-		setup_indirect_pci(hose, immr + 0x8380, immr + 0x8384);
+		setup_indirect_pci(hose, immr + 0x8380, immr + 0x8384, 0);
 		primary = 0;
 	}
 
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 526ddde..4661fcc 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -51,7 +51,6 @@ config MPC85xx
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI if PCI
-	select PPC_INDIRECT_PCI_BE if PCI
 	select MPIC
 	select FSL_PCI if PCI
 	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index d1c8115..343b76d 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -14,7 +14,6 @@ endchoice
 
 config MPC8641
 	bool
-	select PPC_INDIRECT_PCI_BE if PCI
 	select FSL_PCI if PCI
 	select PPC_UDBG_16550
 	select MPIC
diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index 3690624..28d1647 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -181,7 +181,7 @@ setup_python(struct pci_controller *hose, struct device_node *dev)
 	}
 	iounmap(reg);
 
-	setup_indirect_pci(hose, r.start + 0xf8000, r.start + 0xf8010);
+	setup_indirect_pci(hose, r.start + 0xf8000, r.start + 0xf8010, 0);
 }
 
 /* Marvell Discovery II based Pegasos 2 */
@@ -277,13 +277,14 @@ chrp_find_bridges(void)
 			hose->cfg_data = p;
 			gg2_pci_config_base = p;
 		} else if (is_pegasos == 1) {
-			setup_indirect_pci(hose, 0xfec00cf8, 0xfee00cfc);
+			setup_indirect_pci(hose, 0xfec00cf8, 0xfee00cfc, 0);
 		} else if (is_pegasos == 2) {
 			setup_peg2(hose, dev);
 		} else if (!strncmp(model, "IBM,CPC710", 10)) {
 			setup_indirect_pci(hose,
 					   r.start + 0x000f8000,
-					   r.start + 0x000f8010);
+					   r.start + 0x000f8010,
+					   0);
 			if (index == 0) {
 				dma = of_get_property(dev, "system-dma-base",
 							&len);
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index f4d0a7a..bd5ca58 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -73,7 +73,7 @@ static int __init linkstation_add_bridge(struct device_node *dev)
 		return -ENOMEM;
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
-	setup_indirect_pci(hose, 0xfec00000, 0xfee00000);
+	setup_indirect_pci(hose, 0xfec00000, 0xfee00000, 0);
 
 	/* Interpret the "ranges" property */
 	/* This also maps the I/O region and sets isa_io/mem_base */
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index c6a30f9..1426642 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -185,7 +185,8 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	hose->first_busno = bus_range ? bus_range[0] : 0x0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
-	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4);
+	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
+		INDIRECT_PCI_BIG_ENDIAN);
 	setup_pci_cmd(hose);
 
 	/* check PCI express link status */
diff --git a/arch/powerpc/sysdev/grackle.c b/arch/powerpc/sysdev/grackle.c
index 4205362..11ad562 100644
--- a/arch/powerpc/sysdev/grackle.c
+++ b/arch/powerpc/sysdev/grackle.c
@@ -55,7 +55,7 @@ static inline void grackle_set_loop_snoop(struct pci_controller *bp, int enable)
 
 void __init setup_grackle(struct pci_controller *hose)
 {
-	setup_indirect_pci(hose, 0xfec00000, 0xfee00000);
+	setup_indirect_pci(hose, 0xfec00000, 0xfee00000, 0);
 	if (machine_is_compatible("PowerMac1,1"))
 		pci_assign_all_buses = 1;
 	if (machine_is_compatible("AAPL,PowerBook1998"))
diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index ad341f5..33b9b69 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -26,6 +26,16 @@
 #define PCI_CFG_OUT out_le32
 #endif
 
+static void pci_cfg_out_le(volatile u32 __iomem *addr, u32 val)
+{
+	out_le32(addr, val);
+}
+
+static void pci_cfg_out_be(volatile u32 __iomem *addr, u32 val)
+{
+	out_be32(addr, val);
+}
+
 static int
 indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		     int len, u32 *val)
@@ -58,7 +68,7 @@ indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	else
 		reg = offset & 0xfc;
 
-	PCI_CFG_OUT(hose->cfg_addr,
+	hose->pci_cfg_out(hose->cfg_addr,
 		 (0x80000000 | (bus_no << 16)
 		  | (devfn << 8) | reg | cfg_type));
 
@@ -113,7 +123,7 @@ indirect_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	else
 		reg = offset & 0xfc;
 
-	PCI_CFG_OUT(hose->cfg_addr,
+	hose->pci_cfg_out(hose->cfg_addr,
 		 (0x80000000 | (bus_no << 16)
 		  | (devfn << 8) | reg | cfg_type));
 
@@ -149,7 +159,7 @@ static struct pci_ops indirect_pci_ops =
 };
 
 void __init
-setup_indirect_pci(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data)
+setup_indirect_pci(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data, u32 flags)
 {
 	unsigned long base = cfg_addr & PAGE_MASK;
 	void __iomem *mbase;
@@ -160,4 +170,8 @@ setup_indirect_pci(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data)
 		mbase = ioremap(cfg_data & PAGE_MASK, PAGE_SIZE);
 	hose->cfg_data = mbase + (cfg_data & ~PAGE_MASK);
 	hose->ops = &indirect_pci_ops;
+	if (flags & INDIRECT_PCI_BIG_ENDIAN)
+		hose->pci_cfg_out = pci_cfg_out_be;
+	else
+		hose->pci_cfg_out = pci_cfg_out_le;
 }
diff --git a/arch/powerpc/sysdev/mv64x60_pci.c b/arch/powerpc/sysdev/mv64x60_pci.c
index 45db86c..9b3baa7 100644
--- a/arch/powerpc/sysdev/mv64x60_pci.c
+++ b/arch/powerpc/sysdev/mv64x60_pci.c
@@ -144,7 +144,7 @@ static int __init mv64x60_add_bridge(struct device_node *dev)
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
-	setup_indirect_pci(hose, rsrc.start, rsrc.start + 4);
+	setup_indirect_pci(hose, rsrc.start, rsrc.start + 4, 0);
 	hose->self_busno = hose->first_busno;
 
 	printk(KERN_INFO "Found MV64x60 PCI host bridge at 0x%016llx. "
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index 13cb0a9..435bfe8 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -36,6 +36,7 @@ struct pci_controller {
 	struct pci_ops *ops;
 	volatile unsigned int __iomem *cfg_addr;
 	volatile void __iomem *cfg_data;
+	void (*pci_cfg_out)(volatile u32 __iomem *cfg_addr, u32 val);
 
 	/*
 	 * Used for variants of PCI indirect handling and possible quirks:
@@ -87,8 +88,10 @@ int early_write_config_dword(struct pci_controller *hose, int bus, int dev_fn,
 extern int early_find_capability(struct pci_controller *hose, int bus,
 				 int dev_fn, int cap);
 
+/* Set this for a big-endian cfg_addr */
+#define INDIRECT_PCI_BIG_ENDIAN			0x00000001
 extern void setup_indirect_pci(struct pci_controller* hose,
-			       u32 cfg_addr, u32 cfg_data);
+			       u32 cfg_addr, u32 cfg_data, u32 flags);
 extern void setup_grackle(struct pci_controller *hose);
 
 #else
@@ -128,6 +131,7 @@ struct pci_controller {
 	struct pci_ops *ops;
 	volatile unsigned int __iomem *cfg_addr;
 	volatile void __iomem *cfg_data;
+	void (*pci_cfg_out)(volatile u32 __iomem *cfg_addr, u32 val);
 
 	/* Currently, we limit ourselves to 1 IO range and 3 mem
 	 * ranges since the common pci_bus structure can't handle more
-- 
1.5.2.2
