Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 13 Dec 2007 18:38:47 +1100
Subject: [PATCH 20/20] [POWERPC] 4xx: Add 440SPe revA runtime detection to PCIe
Message-Id: <20071213073852.93DF2DE0FF@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stefan Roese <sr@denx.de>

This patch adds runtime detection of the 440SPe revision A chips. These
chips are equipped with a slighly different PCIe core and need special/
different initialization. The compatible node is changed to
"plb-pciex-440spe" ("A" and "B" dropped). This is needed for boards that
can be equipped with both PPC revisions like the AMCC Yucca.

Signed-off-by: Stefan Roese <sr@denx.de>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/boot/dts/katmai.dts |    6 +++---
 arch/powerpc/sysdev/ppc4xx_pci.c |   25 +++++++++++++++++--------
 2 files changed, 20 insertions(+), 11 deletions(-)

--- linux-merge.orig/arch/powerpc/boot/dts/katmai.dts	2007-12-11 17:11:37.000000000 +1100
+++ linux-merge/arch/powerpc/boot/dts/katmai.dts	2007-12-11 17:11:37.000000000 +1100
@@ -268,7 +268,7 @@
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			compatible = "ibm,plb-pciex-440speB", "ibm,plb-pciex";
+			compatible = "ibm,plb-pciex-440spe", "ibm,plb-pciex";
 			primary;
 			port = <0>; /* port number */
 			reg = <d 00000000 20000000	/* Config space access */
@@ -309,7 +309,7 @@
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			compatible = "ibm,plb-pciex-440speB", "ibm,plb-pciex";
+			compatible = "ibm,plb-pciex-440spe", "ibm,plb-pciex";
 			primary;
 			port = <1>; /* port number */
 			reg = <d 20000000 20000000	/* Config space access */
@@ -350,7 +350,7 @@
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			compatible = "ibm,plb-pciex-440speB", "ibm,plb-pciex";
+			compatible = "ibm,plb-pciex-440spe", "ibm,plb-pciex";
 			primary;
 			port = <2>; /* port number */
 			reg = <d 40000000 20000000	/* Config space access */
Index: linux-merge/arch/powerpc/sysdev/ppc4xx_pci.c
===================================================================
--- linux-merge.orig/arch/powerpc/sysdev/ppc4xx_pci.c	2007-12-11 17:11:37.000000000 +1100
+++ linux-merge/arch/powerpc/sysdev/ppc4xx_pci.c	2007-12-11 17:11:37.000000000 +1100
@@ -49,6 +49,15 @@ extern unsigned long total_memory;
 #define RES_TO_U32_HIGH(val)	(0)
 #endif
 
+static inline int ppc440spe_revA(void)
+{
+	/* Catch both 440SPe variants, with and without RAID6 support */
+        if ((mfspr(SPRN_PVR) & 0xffefffff) == 0x53421890)
+                return 1;
+        else
+                return 0;
+}
+
 static void fixup_ppc4xx_pci_bridge(struct pci_dev *dev)
 {
 	struct pci_controller *hose;
@@ -516,8 +525,7 @@ static void __init ppc4xx_probe_pcix_bri
  *
  * We support 3 parts currently based on the compatible property:
  *
- * ibm,plb-pciex-440speA
- * ibm,plb-pciex-440speB
+ * ibm,plb-pciex-440spe
  * ibm,plb-pciex-405ex
  *
  * Anything else will be rejected for now as they are all subtly
@@ -688,7 +696,7 @@ static int ppc440spe_pciex_init_port_hw(
 
 	mtdcri(SDR0, port->sdr_base + PESDRn_DLPSET, val);
 	mtdcri(SDR0, port->sdr_base + PESDRn_UTLSET1, 0x20222222);
-	if (of_device_is_compatible(port->node, "ibm,plb-pciex-440speA"))
+	if (ppc440spe_revA())
 		mtdcri(SDR0, port->sdr_base + PESDRn_UTLSET2, 0x11000000);
 	mtdcri(SDR0, port->sdr_base + PESDRn_440SPE_HSSL0SET1, 0x35000000);
 	mtdcri(SDR0, port->sdr_base + PESDRn_440SPE_HSSL1SET1, 0x35000000);
@@ -767,7 +775,6 @@ static struct ppc4xx_pciex_hwops ppc440s
 	.setup_utl	= ppc440speB_pciex_init_utl,
 };
 
-
 #endif /* CONFIG_44x */
 
 #ifdef CONFIG_40x
@@ -881,10 +888,12 @@ static int __init ppc4xx_pciex_check_cor
 		return 0;
 
 #ifdef CONFIG_44x
-	if (of_device_is_compatible(np, "ibm,plb-pciex-440speA"))
-		ppc4xx_pciex_hwops = &ppc440speA_pcie_hwops;
-	else if (of_device_is_compatible(np, "ibm,plb-pciex-440speB"))
-		ppc4xx_pciex_hwops = &ppc440speB_pcie_hwops;
+	if (of_device_is_compatible(np, "ibm,plb-pciex-440spe")) {
+		if (ppc440spe_revA())
+			ppc4xx_pciex_hwops = &ppc440speA_pcie_hwops;
+		else
+			ppc4xx_pciex_hwops = &ppc440speB_pcie_hwops;
+	}
 #endif /* CONFIG_44x    */
 #ifdef CONFIG_40x
 	if (of_device_is_compatible(np, "ibm,plb-pciex-405ex"))
