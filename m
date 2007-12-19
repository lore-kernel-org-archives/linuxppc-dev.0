Return-Path: <Tony.Li@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BD5FCDDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 20:03:02 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lBJ8x0id017148
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 02:02:59 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lBJ8wwel017984
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 02:58:59 -0600 (CST)
Subject: [PATCH] powerpc: Add MPC837x PCIE RC mode support
From: Li Li <r64360@freescale.com>
To: Kumar Gala <kumar.gala@freescale.com>,
	kim phillips <Kim.Phillips@freescale.com>,
	Wood Scott <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 19 Dec 2007 16:46:01 +0800
Message-Id: <1198053961.6787.2.camel@Guyver>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The MPC837x PCIE controller hardware resources are initiated in u-boot.

Merge the MPC837x PCIE code into arch/powerpc/sysdev/fsl_pci.c

The MPC837x PCIE controller`s configure address bit field is uniqe:
	bus number:		bits 31-24
	device number:		bits 23-19
	function number:	bits 18-16
	ext reg number:		bits 11-8
	reg number:		bits 7-2
This controller implements direct configure space access mode via outbound window.
Only map first 16M configure space at boot time. Remap the outbound window target address when 
want access another 16M configure space.

Add MPC837x PCIE controller specific fixup.

Add flag variant to mpc83xx_add_bridge function.

Signed-off-by: Tony Li <tony.li@freescale.com>
---
 arch/powerpc/boot/dts/mpc8377_mds.dts     |   54 ++++++++--
 arch/powerpc/boot/dts/mpc8378_mds.dts     |   54 ++++++++--
 arch/powerpc/platforms/83xx/Kconfig       |    2 +
 arch/powerpc/platforms/83xx/mpc8313_rdb.c |   10 ++-
 arch/powerpc/platforms/83xx/mpc832x_mds.c |   12 ++-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |   10 ++-
 arch/powerpc/platforms/83xx/mpc834x_itx.c |   10 ++-
 arch/powerpc/platforms/83xx/mpc834x_mds.c |   10 ++-
 arch/powerpc/platforms/83xx/mpc836x_mds.c |   12 ++-
 arch/powerpc/platforms/83xx/mpc837x_mds.c |   39 +++++++-
 arch/powerpc/platforms/83xx/mpc83xx.h     |    6 +-
 arch/powerpc/platforms/83xx/pci.c         |   29 ++++--
 arch/powerpc/sysdev/fsl_pci.c             |  159 +++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_pci.h             |    3 +
 include/asm-powerpc/pci-bridge.h          |    1 +
 include/linux/pci_ids.h                   |    4 +
 16 files changed, 375 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 4402e39..5b6177a 100644
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
@@ -279,4 +271,50 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pcie@e0009000 {
+		interrupt-map-mask = <f800 0 0 7>;
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
+		       b0000000 01000000>;
+		compatible = "fsl,mpc8377-pcie";
+		device_type = "pci";
+	};
+
+	pcie@e000a000 {
+		interrupt-map-mask = <f800 0 0 7>;
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
+		       d0000000 01000000>;
+		compatible = "fsl,mpc8377-pcie";
+		device_type = "pci";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index 54171f4..83ad974 100644
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
@@ -261,4 +253,50 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pcie@e0009000 {
+		interrupt-map-mask = <f800 0 0 7>;
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
+		       b0000000 01000000>;
+		compatible = "fsl,mpc8377-pcie";
+		device_type = "pci";
+	};
+
+	pcie@e000a000 {
+		interrupt-map-mask = <f800 0 0 7>;
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
+		       d0000000 01000000>;
+		compatible = "fsl,mpc8377-pcie";
+		device_type = "pci";
+	};
 };
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 0c61e7a..0b4bfb5 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -86,4 +86,6 @@ config PPC_MPC837x
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
 	select FSL_SERDES
+	select FSL_PCI if PCI
 	default y if MPC837x_MDS
+
diff --git a/arch/powerpc/platforms/83xx/mpc8313_rdb.c b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
index 33766b8..25d8df4 100644
--- a/arch/powerpc/platforms/83xx/mpc8313_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
@@ -37,14 +37,20 @@ static void __init mpc8313_rdb_setup_arch(void)
 {
 #ifdef CONFIG_PCI
 	struct device_node *np;
+	int primary_pci_bus = 1;
 #endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc8313_rdb_setup_arch()", 0);
 
 #ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci") {
+		if (primary_pci_bus) {
+			mpc83xx_add_bridge(np, PPC_83XX_PCI | PPC_83XX_PCI_PRIMARY);
+			primary_pci_bus = 0;
+		} else
+			mpc83xx_add_bridge(np, PPC_83XX_PCI);
+	}
 #endif
 	mpc831x_usb_cfg();
 }
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 972fa85..ddb0b2e 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -58,6 +58,9 @@ static u8 *bcsr_regs = NULL;
 static void __init mpc832x_sys_setup_arch(void)
 {
 	struct device_node *np;
+#ifdef CONFIG_PCI
+	int primary_pci_bus = 1;
+#endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc832x_sys_setup_arch()", 0);
@@ -73,8 +76,13 @@ static void __init mpc832x_sys_setup_arch(void)
 	}
 
 #ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci") {
+		if (primary_pci_bus) {
+			mpc83xx_add_bridge(np, PPC_83XX_PCI | PPC_83XX_PCI_PRIMARY);
+			primary_pci_bus = 0;
+		} else
+			mpc83xx_add_bridge(np, PPC_83XX_PCI);
+	}
 #endif
 
 #ifdef CONFIG_QUICC_ENGINE
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index fbca336..aef35f5 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -87,14 +87,20 @@ static void __init mpc832x_rdb_setup_arch(void)
 {
 #if defined(CONFIG_PCI) || defined(CONFIG_QUICC_ENGINE)
 	struct device_node *np;
+	int primary_pci_bus = 1;
 #endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc832x_rdb_setup_arch()", 0);
 
 #ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci") {
+		if (primary_pci_bus) {
+			mpc83xx_add_bridge(np, PPC_83XX_PCI | PPC_83XX_PCI_PRIMARY);
+			primary_pci_bus = 0;
+		} else
+			mpc83xx_add_bridge(np, PPC_83XX_PCI);
+	}
 #endif
 
 #ifdef CONFIG_QUICC_ENGINE
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index aa76819..c428f62 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -46,14 +46,20 @@ static void __init mpc834x_itx_setup_arch(void)
 {
 #ifdef CONFIG_PCI
 	struct device_node *np;
+	int primary_pci_bus = 1;
 #endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc834x_itx_setup_arch()", 0);
 
 #ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci") {
+		if (primary_pci_bus) {
+			mpc83xx_add_bridge(np, PPC_83XX_PCI | PPC_83XX_PCI_PRIMARY);
+			primary_pci_bus = 0;
+		} else
+			mpc83xx_add_bridge(np, PPC_83XX_PCI);
+	}
 #endif
 
 	mpc834x_usb_cfg();
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 00aed7c..e86dce8 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -77,14 +77,20 @@ static void __init mpc834x_mds_setup_arch(void)
 {
 #ifdef CONFIG_PCI
 	struct device_node *np;
+	int primary_pci_bus = 1;
 #endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc834x_mds_setup_arch()", 0);
 
 #ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci") {
+		if (primary_pci_bus) {
+			mpc83xx_add_bridge(np, PPC_83XX_PCI | PPC_83XX_PCI_PRIMARY);
+			primary_pci_bus = 0;
+		} else
+			mpc83xx_add_bridge(np, PPC_83XX_PCI);
+	}
 #endif
 
 	mpc834xemds_usb_cfg();
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 0f3855c..6e6670c 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -64,6 +64,9 @@ static u8 *bcsr_regs = NULL;
 static void __init mpc836x_mds_setup_arch(void)
 {
 	struct device_node *np;
+#ifdef CONFIG_PCI
+	int primary_pci_bus = 1;
+#endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc836x_mds_setup_arch()", 0);
@@ -79,8 +82,13 @@ static void __init mpc836x_mds_setup_arch(void)
 	}
 
 #ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci") {
+		if (primary_pci_bus) {
+			mpc83xx_add_bridge(np, PPC_83XX_PCI | PPC_83XX_PCI_PRIMARY);
+			primary_pci_bus = 0;
+		} else
+			mpc83xx_add_bridge(np, PPC_83XX_PCI);
+	}
 #endif
 
 #ifdef CONFIG_QUICC_ENGINE
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index 166c111..ec2fa9f 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -25,8 +25,27 @@
 #ifndef CONFIG_PCI
 unsigned long isa_io_base = 0;
 unsigned long isa_mem_base = 0;
+
 #endif
 
+#ifdef CONFIG_PCI
+static int mpc837x_exclude_device(struct pci_controller *hose,
+					u_char bus, u_char devfn)
+{
+	struct pci_bus *pci_bus;
+
+	if (hose->indirect_type & PPC_INDIRECT_TYPE_MPC83XX_PCIE) {
+		pci_bus = pci_find_bus(hose->global_number, bus);
+		if ((bus == hose->first_busno) ||
+			(pci_bus->primary == hose->first_busno)) {
+			if (devfn & 0xf8)
+				return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+#endif
 /* ************************************************************************
  *
  * Setup the architecture
@@ -36,14 +55,30 @@ static void __init mpc837x_mds_setup_arch(void)
 {
 #ifdef CONFIG_PCI
 	struct device_node *np;
+	int primary_pci_bus = 1;
 #endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc837x_mds_setup_arch()", 0);
 
 #ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
-		mpc83xx_add_bridge(np);
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci") {
+		if (primary_pci_bus) {
+			mpc83xx_add_bridge(np, PPC_83XX_PCI | PPC_83XX_PCI_PRIMARY);
+			primary_pci_bus = 0;
+		} else
+			mpc83xx_add_bridge(np, PPC_83XX_PCI);
+	}
+
+	for_each_compatible_node(np, "pci", "fsl,mpc8377-pcie") {
+		if (primary_pci_bus) {
+			mpc83xx_add_bridge(np, PPC_83XX_PCIE | PPC_83XX_PCI_PRIMARY);
+			primary_pci_bus = 0;
+		} else
+			mpc83xx_add_bridge(np, PPC_83XX_PCIE);
+	}
+
+	ppc_md.pci_exclude_device = mpc837x_exclude_device;
 #endif
 }
 
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index b778cb4..552e9bf 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -47,8 +47,10 @@
  * Declaration for the various functions exported by the
  * mpc83xx_* files. Mostly for use by mpc83xx_setup
  */
-
-extern int mpc83xx_add_bridge(struct device_node *dev);
+#define PPC_83XX_PCI_PRIMARY	0x1
+#define PPC_83XX_PCI		0x2
+#define PPC_83XX_PCIE		0x4
+extern int mpc83xx_add_bridge(struct device_node *dev, int flags);
 extern void mpc83xx_restart(char *cmd);
 extern long mpc83xx_time_init(void);
 extern int mpc834x_usb_cfg(void);
diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
index 80425d7..7a3382a 100644
--- a/arch/powerpc/platforms/83xx/pci.c
+++ b/arch/powerpc/platforms/83xx/pci.c
@@ -24,6 +24,9 @@
 #include <asm/pci-bridge.h>
 #include <asm/prom.h>
 #include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+
+#include "mpc83xx.h"
 
 #undef DEBUG
 
@@ -33,13 +36,13 @@
 #define DBG(x...)
 #endif
 
-int __init mpc83xx_add_bridge(struct device_node *dev)
+int __init mpc83xx_add_bridge(struct device_node *dev, int flags)
 {
 	int len;
 	struct pci_controller *hose;
 	struct resource rsrc;
 	const int *bus_range;
-	int primary = 1, has_address = 0;
+	int has_address = 0;
 	phys_addr_t immr = get_immrbase();
 
 	DBG("Adding PCI host bridge %s\n", dev->full_name);
@@ -63,16 +66,23 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
 	/* MPC83xx supports up to two host controllers one at 0x8500 from immrbar
-	 * the other at 0x8600, we consider the 0x8500 the primary controller
+	 * the other at 0x8600.
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
+	if (flags & PPC_83XX_PCIE) {
+		struct resource cfg_space;
+
+		if (of_address_to_resource(dev, 1, &cfg_space)) {
+			printk("PCIE RC losts configure space. Skip it\n");
+			return 1;
+		}
+		mpc83xx_setup_pcie(hose, &rsrc, &cfg_space);
 	}
 
 	printk(KERN_INFO "Found MPC83xx PCI host bridge at 0x%016llx. "
@@ -85,7 +95,10 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 
 	/* Interpret the "ranges" property */
 	/* This also maps the I/O region and sets isa_io/mem_base */
-	pci_process_bridge_OF_ranges(hose, dev, primary);
+	if (flags & PPC_83XX_PCI_PRIMARY)
+		pci_process_bridge_OF_ranges(hose, dev, 1);
+	else
+		pci_process_bridge_OF_ranges(hose, dev, 0);
 
 	return 0;
 }
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 33df4c3..dfd9a40 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -240,6 +240,165 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	return 0;
 }
 
+/* MPC83xx PCIE routines*/
+/* PCIE Registers */
+#define PEX_LTSSM_STAT          0x404
+#define PEX_LTSSM_STAT_L0       0x16
+#define PEX_GCLK_RATIO          0x440
+
+/* With the convention of u-boot, the PCIE outbound window 0 serves
+ * as configuration transactions outbound */
+#define PEX_OUTWIN0_TAL		0xCA8
+#define PEX_OUTWIN0_TAH		0xCAC
+
+void remap_cfg_outbound(void * __iomem reg_base, u32 tal, u32 tah)
+{
+	out_le32(reg_base + PEX_OUTWIN0_TAL, tal);
+	out_le32(reg_base + PEX_OUTWIN0_TAH, tah);
+}
+
+static int mpc83xx_read_config_pcie(struct pci_bus *bus,
+			uint devfn, int offset, int len, u32 *val)
+{
+	struct pci_controller *hose = bus->sysdata;
+	void __iomem *cfg_addr;
+	static u32 orig_busno = 0;
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
+	if ((bus->number == hose->first_busno) &&
+		(hose->indirect_type & PPC_INDIRECT_TYPE_MPC83XX_PCIE))
+		cfg_addr = (void __iomem *)((ulong) hose->cfg_data + (offset & 0xfff));
+	else {
+		bus_no = bus->number - hose->first_busno;
+		if (bus_no != orig_busno) {
+			remap_cfg_outbound((void __iomem *)hose->cfg_data, bus_no, 0);
+			orig_busno = bus_no;
+		}
+		cfg_addr = (void __iomem *)((ulong) hose->cfg_addr +
+			((devfn << 16) | (offset & 0xfff)));
+	}
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
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int mpc83xx_write_config_pcie(struct pci_bus *bus,
+			uint devfn, int offset, int len, u32 val)
+{
+	struct pci_controller *hose = bus->sysdata;
+	void __iomem *cfg_addr;
+	static u32 orig_busno = 0;
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
+
+	if ((bus->number == hose->first_busno) &&
+		(hose->indirect_type & PPC_INDIRECT_TYPE_MPC83XX_PCIE))
+		cfg_addr = (void __iomem *)((ulong) hose->cfg_data + (offset & 0xfff));
+	else {
+		bus_no = bus->number - hose->first_busno;
+		if (bus_no != orig_busno) {
+			remap_cfg_outbound((void __iomem *)hose->cfg_data, bus_no, 0);
+			orig_busno = bus_no;
+		}
+		cfg_addr = (void __iomem *)((ulong) hose->cfg_addr +
+			((devfn << 16) | (offset & 0xfff)));
+	}
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
+static struct pci_ops mpc83xx_pcie_ops = {
+	mpc83xx_read_config_pcie,
+	mpc83xx_write_config_pcie
+};
+
+void __init mpc83xx_setup_pcie(struct pci_controller *hose,
+			struct resource *reg, struct resource *cfg_space)
+{
+	void __iomem *hose_cfg_header, *mbase;
+	u32 val;
+
+	hose_cfg_header = ioremap(reg->start, reg->end - reg->start + 1);
+
+	val = in_le32(hose_cfg_header + PEX_LTSSM_STAT);
+	if (val < PEX_LTSSM_STAT_L0)
+		hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+	hose->indirect_type |= PPC_INDIRECT_TYPE_MPC83XX_PCIE;
+
+	mbase = ioremap(cfg_space->start & PAGE_MASK, cfg_space->end - cfg_space->start + 1);
+	hose->ops = &mpc83xx_pcie_ops;
+	hose->cfg_addr = mbase + (cfg_space->start & ~PAGE_MASK);
+
+	/* The MPC83xx PCIE implements direct access configure space
+	 * routines instead of indirect ones. So, the cfg_data field is free.
+	 * The MPC83xx PCIE RC configure header is memory-mapped,
+	 * we use cfg_data as this header pointer */
+	hose->cfg_data = hose_cfg_header;
+}
+
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8377E, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8377, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8378E, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8378, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8548E, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8548, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8543E, quirk_fsl_pcie_transparent);
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index 37b04ad..a70ee0f 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -84,5 +84,8 @@ struct ccsr_pci {
 extern int fsl_add_bridge(struct device_node *dev, int is_primary);
 extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
 
+extern void mpc83xx_setup_pcie(struct pci_controller *hose,
+		struct resource *reg, struct resource *cfg_space);
+
 #endif /* __POWERPC_FSL_PCI_H */
 #endif /* __KERNEL__ */
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index dc31845..372598b 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -56,6 +56,7 @@ struct pci_controller {
 #define PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS	(0x00000004)
 #define PPC_INDIRECT_TYPE_NO_PCIE_LINK		(0x00000008)
 #define PPC_INDIRECT_TYPE_BIG_ENDIAN		(0x00000010)
+#define PPC_INDIRECT_TYPE_MPC83XX_PCIE		(0x00000020)
 	u32 indirect_type;
 
 	/* Currently, we limit ourselves to 1 IO range and 3 mem
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1ee009e..f84caa7 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2111,6 +2111,10 @@
 #define PCI_DEVICE_ID_TDI_EHCI          0x0101
 
 #define PCI_VENDOR_ID_FREESCALE		0x1957
+#define PCI_DEVICE_ID_MPC8378E		0x00c4
+#define PCI_DEVICE_ID_MPC8378		0x00c5
+#define PCI_DEVICE_ID_MPC8377E		0x00c6
+#define PCI_DEVICE_ID_MPC8377		0x00c7
 #define PCI_DEVICE_ID_MPC8548E		0x0012
 #define PCI_DEVICE_ID_MPC8548		0x0013
 #define PCI_DEVICE_ID_MPC8543E		0x0014
-- 
1.5.2
