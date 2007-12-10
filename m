Return-Path: <SRS0=6/a2=RB=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id EA6AFDDDE7
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 18:43:33 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Add 440SPe revA runtime detection to PCIe
	driver
Date: Mon, 10 Dec 2007 08:37:34 +0100
Message-Id: <1197272254-11691-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds runtime detection of the 440SPe revision A chips. These
chips are equipped with a slighly different PCIe core and need special/
different initialization. The compatible node is changed to
"plb-pciex-440spe" ("A" and "B" dropped). This is needed for boards that
can be equipped with both PPC revisions like the AMCC Yucca.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/katmai.dts |    6 +++---
 arch/powerpc/sysdev/ppc4xx_pci.c |   25 +++++++++++++++++--------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
index 2bea84f..824cf4e 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -269,7 +269,7 @@
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			compatible = "ibm,plb-pciex-440speB", "ibm,plb-pciex";
+			compatible = "ibm,plb-pciex-440spe", "ibm,plb-pciex";
 			primary;
 			port = <0>; /* port number */
 			reg = <d 00000000 20000000	/* Config space access */
@@ -310,7 +310,7 @@
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			compatible = "ibm,plb-pciex-440speB", "ibm,plb-pciex";
+			compatible = "ibm,plb-pciex-440spe", "ibm,plb-pciex";
 			primary;
 			port = <1>; /* port number */
 			reg = <d 20000000 20000000	/* Config space access */
@@ -351,7 +351,7 @@
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			compatible = "ibm,plb-pciex-440speB", "ibm,plb-pciex";
+			compatible = "ibm,plb-pciex-440spe", "ibm,plb-pciex";
 			primary;
 			port = <2>; /* port number */
 			reg = <d 40000000 20000000	/* Config space access */
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index bd85a40..744b5ca 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
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
@@ -521,8 +530,7 @@ static void __init ppc4xx_probe_pcix_bridge(struct device_node *np)
  *
  * We support 3 parts currently based on the compatible property:
  *
- * ibm,plb-pciex-440speA
- * ibm,plb-pciex-440speB
+ * ibm,plb-pciex-440spe
  * ibm,plb-pciex-405ex
  *
  * Anything else will be rejected for now as they are all subtly
@@ -693,7 +701,7 @@ static int ppc440spe_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 
 	mtdcri(SDR0, port->sdr_base + PESDRn_DLPSET, val);
 	mtdcri(SDR0, port->sdr_base + PESDRn_UTLSET1, 0x20222222);
-	if (of_device_is_compatible(port->node, "ibm,plb-pciex-440speA"))
+	if (ppc440spe_revA())
 		mtdcri(SDR0, port->sdr_base + PESDRn_UTLSET2, 0x11000000);
 	mtdcri(SDR0, port->sdr_base + PESDRn_440SPE_HSSL0SET1, 0x35000000);
 	mtdcri(SDR0, port->sdr_base + PESDRn_440SPE_HSSL1SET1, 0x35000000);
@@ -772,7 +780,6 @@ static struct ppc4xx_pciex_hwops ppc440speB_pcie_hwops __initdata =
 	.setup_utl	= ppc440speB_pciex_init_utl,
 };
 
-
 #endif /* CONFIG_44x */
 
 #ifdef CONFIG_40x
@@ -888,10 +895,12 @@ static int __init ppc4xx_pciex_check_core_init(struct device_node *np)
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
-- 
1.5.3.7.949.g2221a6
