Return-Path: <tmarri@amcc.com>
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F0467B7BD1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 19:49:44 +1100 (EST)
From: tmarri@amcc.com
To: jwboyer@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] Adding PCI-E support for PowerPC 460SX based SOC.
Date: Tue, 22 Dec 2009 00:49:41 -0800
Message-Id: <1261471781-330-1-git-send-email-tmarri@amcc.com>
Cc: linuxppc-dev@ozlabs.org, writetomarri@yahoo.com, tmarri@amcc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tirumala Marri <tmarri@amcc.com>


Signed-off-by: Tirumala Marri <tmarri@amcc.com>
---
Kerenl:2.6.33-rc1
Testing: This patch has been tested on 460SX based redwood board . One board configured as  
root complex and other as Endpoint. Checked for link up . From root complex lspci command
shows the end point. Also programmed IO tested using loop back as well as board to board.
---
 arch/powerpc/boot/dts/redwood.dts |  122 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/ppc4xx_pci.c  |  119 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/ppc4xx_pci.h  |   58 +++++++++++++++++
 3 files changed, 299 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/redwood.dts b/arch/powerpc/boot/dts/redwood.dts
index d2af32e..81636c0 100644
--- a/arch/powerpc/boot/dts/redwood.dts
+++ b/arch/powerpc/boot/dts/redwood.dts
@@ -234,10 +234,132 @@
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 			};
+		};
+		PCIE0: pciex@d00000000 {
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb-pciex-460sx", "ibm,plb-pciex";
+			primary;
+			port = <0x0>; /* port number */
+			reg = <0x0000000d 0x00000000 0x20000000	/* Config space access */
+			       0x0000000c 0x10000000 0x00001000>;	/* Registers */
+			dcr-reg = <0x100 0x020>;
+			sdr-base = <0x300>;
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed
+			 */
+			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x00000000 0x00000000 0x80000000
+				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80000000 0x00000000 0x00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
+			/* This drives busses 10 to 0x1f */
+			bus-range = <0x10 0x1f>;
+
+			/* Legacy interrupts (note the weird polarity, the bridge seems
+			 * to invert PCIe legacy interrupts).
+			 * We are de-swizzling here because the numbers are actually for
+			 * port of the root complex virtual P2P bridge. But I want
+			 * to avoid putting a node for it in the tree, so the numbers
+			 * below are basically de-swizzled numbers.
+			 * The real slot is on idsel 0, so the swizzling is 1:1
+			 */
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <
+				0x0 0x0 0x0 0x1 &UIC3 0x0 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC3 0x1 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC3 0x2 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC3 0x3 0x4 /* swizzled int D */>;
+		};
+
+		PCIE1: pciex@d20000000 {
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb-pciex-460sx", "ibm,plb-pciex";
+			primary;
+			port = <0x1>; /* port number */
+			reg = <0x0000000d 0x20000000 0x20000000	/* Config space access */
+			       0x0000000c 0x10001000 0x00001000>;	/* Registers */
+			dcr-reg = <0x120 0x020>;
+			sdr-base = <0x340>;
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed
+			 */
+			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x80000000 0x00000000 0x80000000
+				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80010000 0x00000000 0x00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
+
+			/* This drives busses 10 to 0x1f */
+			bus-range = <0x20 0x2f>;
+
+			/* Legacy interrupts (note the weird polarity, the bridge seems
+			 * to invert PCIe legacy interrupts).
+			 * We are de-swizzling here because the numbers are actually for
+			 * port of the root complex virtual P2P bridge. But I want
+			 * to avoid putting a node for it in the tree, so the numbers
+			 * below are basically de-swizzled numbers.
+			 * The real slot is on idsel 0, so the swizzling is 1:1
+			 */
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <
+				0x0 0x0 0x0 0x1 &UIC3 0x4 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC3 0x5 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC3 0x6 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC3 0x7 0x4 /* swizzled int D */>;
+		};
+
+		PCIE2: pciex@d40000000 {
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb-pciex-460sx", "ibm,plb-pciex";
+			primary;
+			port = <0x2>; /* port number */
+			reg = <0x0000000d 0x40000000 0x20000000	/* Config space access */
+			       0x0000000c 0x10002000 0x00001000>;	/* Registers */
+			dcr-reg = <0x140 0x020>;
+			sdr-base = <0x370>;
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed
+			 */
+			ranges = <0x02000000 0x00000000 0x80000000 0x0000000f 0x00000000 0x00000000 0x80000000
+				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80020000 0x00000000 0x00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
+
+			/* This drives busses 10 to 0x1f */
+			bus-range = <0x30 0x3f>;
+
+			/* Legacy interrupts (note the weird polarity, the bridge seems
+			 * to invert PCIe legacy interrupts).
+			 * We are de-swizzling here because the numbers are actually for
+			 * port of the root complex virtual P2P bridge. But I want
+			 * to avoid putting a node for it in the tree, so the numbers
+			 * below are basically de-swizzled numbers.
+			 * The real slot is on idsel 0, so the swizzling is 1:1
+			 */
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <
+				0x0 0x0 0x0 0x1 &UIC3 0x8 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC3 0x9 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC3 0xa 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC3 0xb 0x4 /* swizzled int D */>;
 		};
 
 	};
+
 	chosen {
 		linux,stdout-path = "/plb/opb/serial@ef600200";
 	};
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 6ff9d71..64cd020 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -972,6 +972,123 @@ static struct ppc4xx_pciex_hwops ppc460ex_pcie_hwops __initdata =
 	.setup_utl	= ppc460ex_pciex_init_utl,
 };
 
+static int __init ppc460sx_pciex_core_init(struct device_node *np)
+{
+	/* HSS drive amplitude */
+	mtdcri(SDR0, PESDR0_460SX_HSSL0DAMP, 0xB9843211);
+	mtdcri(SDR0, PESDR0_460SX_HSSL1DAMP, 0xB9843211);
+	mtdcri(SDR0, PESDR0_460SX_HSSL2DAMP, 0xB9843211);
+	mtdcri(SDR0, PESDR0_460SX_HSSL3DAMP, 0xB9843211);
+	mtdcri(SDR0, PESDR0_460SX_HSSL4DAMP, 0xB9843211);
+	mtdcri(SDR0, PESDR0_460SX_HSSL5DAMP, 0xB9843211);
+	mtdcri(SDR0, PESDR0_460SX_HSSL6DAMP, 0xB9843211);
+	mtdcri(SDR0, PESDR0_460SX_HSSL7DAMP, 0xB9843211);
+
+	mtdcri(SDR0, PESDR1_460SX_HSSL0DAMP, 0xB9843211);
+	mtdcri(SDR0, PESDR1_460SX_HSSL1DAMP, 0xB9843211);
+	mtdcri(SDR0, PESDR1_460SX_HSSL2DAMP, 0xB9843211);
+	mtdcri(SDR0, PESDR1_460SX_HSSL3DAMP, 0xB9843211);
+
+	mtdcri(SDR0, PESDR2_460SX_HSSL0DAMP, 0xB9843211);
+	mtdcri(SDR0, PESDR2_460SX_HSSL1DAMP, 0xB9843211);
+	mtdcri(SDR0, PESDR2_460SX_HSSL2DAMP, 0xB9843211);
+	mtdcri(SDR0, PESDR2_460SX_HSSL3DAMP, 0xB9843211);
+
+	/* HSS TX pre-emphasis */
+	mtdcri(SDR0, PESDR0_460SX_HSSL0COEFA, 0xDCB98987);
+	mtdcri(SDR0, PESDR0_460SX_HSSL1COEFA, 0xDCB98987);
+	mtdcri(SDR0, PESDR0_460SX_HSSL2COEFA, 0xDCB98987);
+	mtdcri(SDR0, PESDR0_460SX_HSSL3COEFA, 0xDCB98987);
+	mtdcri(SDR0, PESDR0_460SX_HSSL4COEFA, 0xDCB98987);
+	mtdcri(SDR0, PESDR0_460SX_HSSL5COEFA, 0xDCB98987);
+	mtdcri(SDR0, PESDR0_460SX_HSSL6COEFA, 0xDCB98987);
+	mtdcri(SDR0, PESDR0_460SX_HSSL7COEFA, 0xDCB98987);
+
+	mtdcri(SDR0, PESDR1_460SX_HSSL0COEFA, 0xDCB98987);
+	mtdcri(SDR0, PESDR1_460SX_HSSL1COEFA, 0xDCB98987);
+	mtdcri(SDR0, PESDR1_460SX_HSSL2COEFA, 0xDCB98987);
+	mtdcri(SDR0, PESDR1_460SX_HSSL3COEFA, 0xDCB98987);
+
+	mtdcri(SDR0, PESDR2_460SX_HSSL0COEFA, 0xDCB98987);
+	mtdcri(SDR0, PESDR2_460SX_HSSL1COEFA, 0xDCB98987);
+	mtdcri(SDR0, PESDR2_460SX_HSSL2COEFA, 0xDCB98987);
+	mtdcri(SDR0, PESDR2_460SX_HSSL3COEFA, 0xDCB98987);
+
+	/* HSS TX calibration control */
+	mtdcri(SDR0, PESDR0_460SX_HSSL1CALDRV, 0x22222222);
+	mtdcri(SDR0, PESDR1_460SX_HSSL1CALDRV, 0x22220000);
+	mtdcri(SDR0, PESDR2_460SX_HSSL1CALDRV, 0x22220000);
+
+	/* HSS TX slew control */
+	mtdcri(SDR0, PESDR0_460SX_HSSSLEW, 0xFFFFFFFF);
+	mtdcri(SDR0, PESDR1_460SX_HSSSLEW, 0xFFFF0000);
+	mtdcri(SDR0, PESDR2_460SX_HSSSLEW, 0xFFFF0000);
+
+	udelay(100);
+
+	/* De-assert PLLRESET */
+	dcri_clrset(SDR0, PESDR0_PLLLCT2, 0x00000100, 0);
+
+	/* Reset DL, UTL, GPL before configuration */
+	mtdcri(SDR0, PESDR0_460SX_RCSSET,
+			PESDRx_RCSSET_RSTDL | PESDRx_RCSSET_RSTGU);
+	mtdcri(SDR0, PESDR1_460SX_RCSSET,
+			PESDRx_RCSSET_RSTDL | PESDRx_RCSSET_RSTGU);
+	mtdcri(SDR0, PESDR2_460SX_RCSSET,
+			PESDRx_RCSSET_RSTDL | PESDRx_RCSSET_RSTGU);
+
+	udelay(100);
+
+	/*
+	 * If bifurcation is not enabled, u-boot would have disabled the
+	 * third PCIe port
+	 */
+	if (((mfdcri(SDR0, PESDR1_460SX_HSSCTLSET) & 0x00000001) ==
+				0x00000001)) {
+		printk(KERN_INFO "PCI: PCIE bifurcation setup successfully.\n");
+		printk(KERN_INFO "PCI: Total 3 PCIE ports are present\n");
+		return 3;
+	}
+
+	printk(KERN_INFO "PCI: Total 2 PCIE ports are present\n");
+	return 2;
+}
+
+static int ppc460sx_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
+{
+
+	if (port->endpoint)
+		dcri_clrset(SDR0, port->sdr_base + PESDRn_UTLSET2,
+				0x01000000, 0);
+	else
+		dcri_clrset(SDR0, port->sdr_base + PESDRn_UTLSET2,
+				0, 0x01000000);
+
+	/*Gen-1*/
+	mtdcri(SDR0, port->sdr_base + PESDRn_460SX_RCEI, 0x08000000);
+
+	dcri_clrset(SDR0, port->sdr_base + PESDRn_RCSSET,
+			(PESDRx_RCSSET_RSTGU | PESDRx_RCSSET_RSTDL),
+			PESDRx_RCSSET_RSTPYN);
+
+	port->has_ibpre = 1;
+
+	return 0;
+}
+
+static int ppc460sx_pciex_init_utl(struct ppc4xx_pciex_port *port)
+{
+	/* Max 128 Bytes */
+	out_be32 (port->utl_base + PEUTL_PBBSZ,   0x00000000);
+	return 0;
+}
+
+static struct ppc4xx_pciex_hwops ppc460sx_pcie_hwops __initdata = {
+	.core_init	= ppc460sx_pciex_core_init,
+	.port_init_hw	= ppc460sx_pciex_init_port_hw,
+	.setup_utl	= ppc460sx_pciex_init_utl,
+};
+
 #endif /* CONFIG_44x */
 
 #ifdef CONFIG_40x
@@ -1087,6 +1204,8 @@ static int __init ppc4xx_pciex_check_core_init(struct device_node *np)
 	}
 	if (of_device_is_compatible(np, "ibm,plb-pciex-460ex"))
 		ppc4xx_pciex_hwops = &ppc460ex_pcie_hwops;
+	if (of_device_is_compatible(np, "ibm,plb-pciex-460sx"))
+		ppc4xx_pciex_hwops = &ppc460sx_pcie_hwops;
 #endif /* CONFIG_44x    */
 #ifdef CONFIG_40x
 	if (of_device_is_compatible(np, "ibm,plb-pciex-405ex"))
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.h b/arch/powerpc/sysdev/ppc4xx_pci.h
index d04e40b..56d9e5d 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.h
+++ b/arch/powerpc/sysdev/ppc4xx_pci.h
@@ -324,6 +324,64 @@
 #define PESDR0_460EX_IHS2		0x036D
 
 /*
+ * 460SX addtional DCRs
+ */
+#define PESDRn_460SX_RCEI		0x02
+
+#define PESDR0_460SX_HSSL0DAMP		0x320
+#define PESDR0_460SX_HSSL1DAMP		0x321
+#define PESDR0_460SX_HSSL2DAMP		0x322
+#define PESDR0_460SX_HSSL3DAMP		0x323
+#define PESDR0_460SX_HSSL4DAMP		0x324
+#define PESDR0_460SX_HSSL5DAMP		0x325
+#define PESDR0_460SX_HSSL6DAMP		0x326
+#define PESDR0_460SX_HSSL7DAMP		0x327
+
+#define PESDR1_460SX_HSSL0DAMP		0x354
+#define PESDR1_460SX_HSSL1DAMP		0x355
+#define PESDR1_460SX_HSSL2DAMP		0x356
+#define PESDR1_460SX_HSSL3DAMP		0x357
+
+#define PESDR2_460SX_HSSL0DAMP		0x384
+#define PESDR2_460SX_HSSL1DAMP		0x385
+#define PESDR2_460SX_HSSL2DAMP		0x386
+#define PESDR2_460SX_HSSL3DAMP		0x387
+
+#define PESDR0_460SX_HSSL0COEFA		0x328
+#define PESDR0_460SX_HSSL1COEFA		0x329
+#define PESDR0_460SX_HSSL2COEFA		0x32A
+#define PESDR0_460SX_HSSL3COEFA		0x32B
+#define PESDR0_460SX_HSSL4COEFA		0x32C
+#define PESDR0_460SX_HSSL5COEFA		0x32D
+#define PESDR0_460SX_HSSL6COEFA		0x32E
+#define PESDR0_460SX_HSSL7COEFA		0x32F
+
+#define PESDR1_460SX_HSSL0COEFA		0x358
+#define PESDR1_460SX_HSSL1COEFA		0x359
+#define PESDR1_460SX_HSSL2COEFA		0x35A
+#define PESDR1_460SX_HSSL3COEFA		0x35B
+
+#define PESDR2_460SX_HSSL0COEFA		0x388
+#define PESDR2_460SX_HSSL1COEFA		0x389
+#define PESDR2_460SX_HSSL2COEFA		0x38A
+#define PESDR2_460SX_HSSL3COEFA		0x38B
+
+#define PESDR0_460SX_HSSL1CALDRV	0x339
+#define PESDR1_460SX_HSSL1CALDRV	0x361
+#define PESDR2_460SX_HSSL1CALDRV	0x391
+
+#define PESDR0_460SX_HSSSLEW		0x338
+#define PESDR1_460SX_HSSSLEW		0x360
+#define PESDR2_460SX_HSSSLEW		0x390
+
+#define PESDR0_460SX_HSSCTLSET		0x31E
+#define PESDR1_460SX_HSSCTLSET		0x352
+#define PESDR2_460SX_HSSCTLSET		0x382
+
+#define PESDR0_460SX_RCSSET		0x304
+#define PESDR1_460SX_RCSSET		0x344
+#define PESDR2_460SX_RCSSET		0x374
+/*
  * Of the above, some are common offsets from the base
  */
 #define PESDRn_UTLSET1			0x00
-- 
1.6.1.rc3
