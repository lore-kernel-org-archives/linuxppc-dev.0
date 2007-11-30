Return-Path: <Tony.Li@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 92210DDE03
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 14:55:17 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lAU3tAe8004894
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 20:55:11 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id lAU3t99O021863
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 21:55:09 -0600 (CST)
Subject: [PATCH] Add MPC837xEMDS PCIE RC mode support
From: Li Li <r64360@freescale.com>
To: Kumar Gala <kumar.gala@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 30 Nov 2007 11:45:34 +0800
Message-Id: <1196394334.29683.5.camel@Guyver>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PCIE controller is initiated in u-boot.

This patch is based on Leo`s mpc837xe patches.


Signed-off-by: Tony Li <tony.li@freescale.com>
---
 arch/powerpc/boot/dts/mpc8377_mds.dts     |   56 ++++++++--
 arch/powerpc/boot/dts/mpc8378_mds.dts     |   56 ++++++++--
 arch/powerpc/platforms/83xx/Kconfig       |    7 ++
 arch/powerpc/platforms/83xx/mpc8313_rdb.c |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |    2 +-
 arch/powerpc/platforms/83xx/mpc834x_itx.c |    2 +-
 arch/powerpc/platforms/83xx/mpc834x_mds.c |    2 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c |    2 +-
 arch/powerpc/platforms/83xx/mpc837x_mds.c |    7 +-
 arch/powerpc/platforms/83xx/mpc83xx.h     |   10 ++-
 arch/powerpc/platforms/83xx/pci.c         |  166 +++++++++++++++++++++++++++-
 12 files changed, 283 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 4402e39..1f7819e 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -197,14 +197,6 @@
 			clock = <d#100>;
 		};
 
-		serdes2:serdes@e3100 {
-			compatible = "fsl,serdes";
-			reg = <e3100 100>;
-			vdd-1v;
-			protocol = "pcie";
-			clock = <d#100>;
-		};
-
 		/* IPIC
 		 * interrupts cell = <intr #, sense>
 		 * sense values match linux IORESOURCE_IRQ_* defines:
@@ -279,4 +271,52 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci2@e0009000 {
+		interrupt-map-mask = <f800 0 0 7>;
+		msi-available-ranges = <43 4 51 52 56 57 58 59>;
+		interrupt-map = <
+			0000 0 0 1 &ipic 1 8
+			0000 0 0 2 &ipic 1 8
+			0000 0 0 3 &ipic 1 8
+			0000 0 0 4 &ipic 1 8
+		>;
+		interrupt-parent = < &ipic >;
+		interrupts = <1 8>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 A8000000 A8000000 0 10000000
+		          01000000 0 00000000 B8000000 0 00800000>;
+		clock-frequency = <0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0009000 00001000
+		       a0000000 08000000>;
+		compatible = "fsl,mpc8377-pcie";
+		device_type = "pci";
+	};
+
+	pci3@e000a000 {
+		interrupt-map-mask = <f800 0 0 7>;
+		msi-available-ranges = <43 4 51 52 56 57 58 59>;
+		interrupt-map = <
+			0000 0 0 1 &ipic 2 8
+			0000 0 0 2 &ipic 2 8
+			0000 0 0 3 &ipic 2 8
+			0000 0 0 4 &ipic 2 8
+		>;
+		interrupt-parent = < &ipic >;
+		interrupts = <2 8>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 C8000000 C8000000 0 10000000
+			  01000000 0 00000000 D8000000 0 00800000>;
+		clock-frequency = <0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e000a000 00001000
+		       c0000000 08000000>;
+		compatible = "fsl,mpc8377-pcie";
+		device_type = "pci";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index 54171f4..1503ae3 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -179,14 +179,6 @@
 			clock = <d#100>;
 		};
 
-		serdes2:serdes@e3100 {
-			compatible = "fsl,serdes";
-			reg = <e3100 100>;
-			vdd-1v;
-			protocol = "pcie";
-			clock = <d#100>;
-		};
-
 		/* IPIC
 		 * interrupts cell = <intr #, sense>
 		 * sense values match linux IORESOURCE_IRQ_* defines:
@@ -261,4 +253,52 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci2@e0009000 {
+		interrupt-map-mask = <f800 0 0 7>;
+		msi-available-ranges = <43 4 51 52 56 57 58 59>;
+		interrupt-map = <
+			0000 0 0 1 &ipic 1 8
+			0000 0 0 2 &ipic 1 8
+			0000 0 0 3 &ipic 1 8
+			0000 0 0 4 &ipic 1 8
+		>;
+		interrupt-parent = < &ipic >;
+		interrupts = <1 8>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 A8000000 A8000000 0 10000000
+		          01000000 0 00000000 B8000000 0 00800000>;
+		clock-frequency = <0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0009000 00001000
+		       a0000000 08000000>;
+		compatible = "fsl,mpc8377-pcie";
+		device_type = "pci";
+	};
+
+	pci3@e000a000 {
+		interrupt-map-mask = <f800 0 0 7>;
+		msi-available-ranges = <43 4 51 52 56 57 58 59>;
+		interrupt-map = <
+			0000 0 0 1 &ipic 2 8
+			0000 0 0 2 &ipic 2 8
+			0000 0 0 3 &ipic 2 8
+			0000 0 0 4 &ipic 2 8
+		>;
+		interrupt-parent = < &ipic >;
+		interrupts = <2 8>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 C8000000 C8000000 0 10000000
+			  01000000 0 00000000 D8000000 0 00800000>;
+		clock-frequency = <0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e000a000 00001000
+		       c0000000 08000000>;
+		compatible = "fsl,mpc8377-pcie";
+		device_type = "pci";
+	};
 };
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 0c61e7a..00154c5 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -87,3 +87,10 @@ config PPC_MPC837x
 	select PPC_INDIRECT_PCI
 	select FSL_SERDES
 	default y if MPC837x_MDS
+
+config PPC_MPC83XX_PCIE
+	bool "MPC837X PCI Express support"
+	depends on PCIEPORTBUS && PPC_MPC837x
+	default n
+	help
+	  Enables MPC837x PCI express RC mode
diff --git a/arch/powerpc/platforms/83xx/mpc8313_rdb.c b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
index 33766b8..1a86a66 100644
--- a/arch/powerpc/platforms/83xx/mpc8313_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
@@ -44,7 +44,7 @@ static void __init mpc8313_rdb_setup_arch(void)
 
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
+		mpc83xx_add_bridge(np, PPC_83XX_PCI);
 #endif
 	mpc831x_usb_cfg();
 }
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 972fa85..8c5afaf 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -74,7 +74,7 @@ static void __init mpc832x_sys_setup_arch(void)
 
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
+		mpc83xx_add_bridge(np, PPC_83XX_PCI);
 #endif
 
 #ifdef CONFIG_QUICC_ENGINE
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index fbca336..91a01bd 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -94,7 +94,7 @@ static void __init mpc832x_rdb_setup_arch(void)
 
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
+		mpc83xx_add_bridge(np, PPC_83XX_PCI);
 #endif
 
 #ifdef CONFIG_QUICC_ENGINE
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index aa76819..377f946 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -53,7 +53,7 @@ static void __init mpc834x_itx_setup_arch(void)
 
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
+		mpc83xx_add_bridge(np, PPC_83XX_PCI);
 #endif
 
 	mpc834x_usb_cfg();
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 00aed7c..4dc17a5 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -84,7 +84,7 @@ static void __init mpc834x_mds_setup_arch(void)
 
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
+		mpc83xx_add_bridge(np, PPC_83XX_PCI);
 #endif
 
 	mpc834xemds_usb_cfg();
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 0f3855c..5b13b34 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -80,7 +80,7 @@ static void __init mpc836x_mds_setup_arch(void)
 
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
+		mpc83xx_add_bridge(np, PPC_83XX_PCI);
 #endif
 
 #ifdef CONFIG_QUICC_ENGINE
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index 166c111..6048f1b 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -43,7 +43,12 @@ static void __init mpc837x_mds_setup_arch(void)
 
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
+		mpc83xx_add_bridge(np, PPC_83XX_PCI);
+#endif
+#ifdef CONFIG_PPC_MPC83XX_PCIE
+	for_each_compatible_node(np, "pci", "fsl,mpc8377-pcie") {
+		mpc83xx_add_bridge(np, PPC_83XX_PCIE);
+	}
 #endif
 }
 
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index b778cb4..2078da7 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -43,12 +43,18 @@
 #define PORTSCX_PTS_UTMI           0x00000000
 #define PORTSCX_PTS_ULPI           0x80000000
 
+/* PCIE Registers */
+#define PEX_LTSSM_STAT		0x404
+#define PEX_LTSSM_STAT_L0	0x16
+#define PEX_GCLK_RATIO		0x440
+
 /*
  * Declaration for the various functions exported by the
  * mpc83xx_* files. Mostly for use by mpc83xx_setup
  */
-
-extern int mpc83xx_add_bridge(struct device_node *dev);
+#define PPC_83XX_PCI	0x1
+#define PPC_83XX_PCIE	0x2
+extern int mpc83xx_add_bridge(struct device_node *dev, int flags);
 extern void mpc83xx_restart(char *cmd);
 extern long mpc83xx_time_init(void);
 extern int mpc834x_usb_cfg(void);
diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
index 80425d7..0b52b2e 100644
--- a/arch/powerpc/platforms/83xx/pci.c
+++ b/arch/powerpc/platforms/83xx/pci.c
@@ -25,6 +25,8 @@
 #include <asm/prom.h>
 #include <sysdev/fsl_soc.h>
 
+#include "mpc83xx.h"
+
 #undef DEBUG
 
 #ifdef DEBUG
@@ -33,13 +35,157 @@
 #define DBG(x...)
 #endif
 
-int __init mpc83xx_add_bridge(struct device_node *dev)
+#if defined(CONFIG_PPC_MPC83XX_PCIE)
+
+/* PCIE config space Read/Write routines */
+static int direct_read_config_pcie(struct pci_bus *bus,
+			uint devfn, int offset, int len, u32 *val)
+{
+	struct pci_controller *hose = bus->sysdata;
+	void __iomem *cfg_addr;
+	u32 bus_no;
+
+	if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+	switch (len) {
+	case 2:
+		if (offset & 1)
+			return -EINVAL;
+		break;
+	case 4:
+	if (offset & 3)
+		return -EINVAL;
+		break;
+	}
+
+	pr_debug("_read_cfg_pcie: bus=%d devfn=%x off=%x len=%x\n",
+		bus->number, devfn, offset, len);
+
+	if (bus->number == hose->first_busno) {
+		if (devfn & 0xf8)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		bus_no = hose->self_busno;
+	} else
+		bus_no = bus->number;
+
+	cfg_addr = (void __iomem *)((ulong) hose->cfg_addr +
+		((bus_no << 20) | (devfn << 12) | (offset & 0xfff)));
+
+	switch (len) {
+	case 1:
+		*val = in_8(cfg_addr);
+		break;
+	case 2:
+		*val = in_le16(cfg_addr);
+		break;
+	default:
+		*val = in_le32(cfg_addr);
+		break;
+	}
+	pr_debug("_read_cfg_pcie: val=%x cfg_addr=%p\n", *val, cfg_addr);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int direct_write_config_pcie(struct pci_bus *bus,
+			uint devfn, int offset, int len, u32 val)
+{
+	struct pci_controller *hose = bus->sysdata;
+	void __iomem *cfg_addr;
+	u32 bus_no;
+
+	if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+	switch (len) {
+	case 2:
+		if (offset & 1)
+			return -EINVAL;
+		break;
+	case 4:
+		if (offset & 3)
+			return -EINVAL;
+		break;
+	}
+
+	if (bus->number == hose->first_busno) {
+		if (devfn & 0xf8)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		bus_no = hose->self_busno;
+	} else
+		bus_no = bus->number;
+
+	cfg_addr = (void __iomem *)((ulong) hose->cfg_addr +
+		((bus_no << 20) | (devfn << 12) | (offset & 0xfff)));
+
+	switch (len) {
+	case 1:
+		out_8(cfg_addr, val);
+		break;
+	case 2:
+		out_le16(cfg_addr, val);
+		break;
+	default:
+		out_le32(cfg_addr, val);
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops direct_pcie_ops = {
+	direct_read_config_pcie,
+	direct_write_config_pcie
+};
+
+void __init setup_direct_pcie(struct pci_controller *hose, u32 cfg_addr, u32 cfg_size)
+{
+	ulong base = cfg_addr & PAGE_MASK;
+	void __iomem *mbase, *addr;
+
+	mbase = ioremap(base, cfg_size);
+	addr = mbase + (cfg_addr & ~PAGE_MASK);
+	hose->cfg_addr = addr;
+	hose->ops = &direct_pcie_ops;
+}
+
+static void __init mpc83xx_setup_pcie(struct pci_controller *hose,
+			struct resource *reg, struct resource *cfg_space)
+{
+	void __iomem *hose_cfg_base;
+	u32 val;
+
+	hose_cfg_base = ioremap(reg->start, reg->end - reg->start + 1);
+
+	val = in_le32(hose_cfg_base + PEX_LTSSM_STAT);
+	if (val < PEX_LTSSM_STAT_L0)
+		hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+
+	setup_direct_pcie(hose, cfg_space->start,
+			cfg_space->end - cfg_space->start + 1);
+}
+#endif /* CONFIG_PPC_MPC83XX_PCIE */
+
+int __init mpc83xx_add_bridge(struct device_node *dev, int flags)
 {
 	int len;
 	struct pci_controller *hose;
 	struct resource rsrc;
+#if defined(CONFIG_PPC_MPC83XX_PCIE)
+	struct resource cfg_space;
+#endif
 	const int *bus_range;
-	int primary = 1, has_address = 0;
+	static int primary = 1;
+	int has_address = 0;
 	phys_addr_t immr = get_immrbase();
 
 	DBG("Adding PCI host bridge %s\n", dev->full_name);
@@ -66,14 +212,21 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	 * the other at 0x8600, we consider the 0x8500 the primary controller
 	 */
 	/* PCI 1 */
-	if ((rsrc.start & 0xfffff) == 0x8500) {
+	if ((rsrc.start & 0xfffff) == 0x8500)
 		setup_indirect_pci(hose, immr + 0x8300, immr + 0x8304, 0);
-	}
 	/* PCI 2 */
-	if ((rsrc.start & 0xfffff) == 0x8600) {
+	if ((rsrc.start & 0xfffff) == 0x8600)
 		setup_indirect_pci(hose, immr + 0x8380, immr + 0x8384, 0);
-		primary = 0;
+
+#if defined(CONFIG_PPC_MPC83XX_PCIE)
+	if (flags & PPC_83XX_PCIE) {
+		if (of_address_to_resource(dev, 1, &cfg_space)) {
+			printk("PCIE RC losts configure space. Skip it\n");
+			return 1;
+		}
+		mpc83xx_setup_pcie(hose, &rsrc, &cfg_space);
 	}
+#endif
 
 	printk(KERN_INFO "Found MPC83xx PCI host bridge at 0x%016llx. "
 	       "Firmware bus number: %d->%d\n",
@@ -86,6 +239,7 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	/* Interpret the "ranges" property */
 	/* This also maps the I/O region and sets isa_io/mem_base */
 	pci_process_bridge_OF_ranges(hose, dev, primary);
+	primary = 0;
 
 	return 0;
 }
-- 
1.5.2
