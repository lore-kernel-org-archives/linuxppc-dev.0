Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id EC14A2C0089
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2013 09:34:37 +1100 (EST)
From: Timur Tabi <timur@tabi.org>
To: Scott Wood <scottwood@freescale.com>,
 Kumar Gala <kumar.gala@freescale.com>, stuart.yoder@freescale.com,
 linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/85xx: fix various PCI node compatible strings
Date: Thu, 17 Jan 2013 16:34:32 -0600
Message-Id: <1358462073-2558-1-git-send-email-timur@tabi.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Timur Tabi <timur@freescale.com>

Fix and/or improve the compatible strings of the PCI device tree nodes for
some Freescale SOCs.  This fixes some issues and improves consistency among
the SOCs.

Specifically:

1) The P1022 has a v1 PCIe controller, so the compatible property should just
say "fsl,mpc8548-pcie".  U-Boot does not look for "fsl,p1022-pcie", so it
wasn't fixing up the node.

2) The P4080 has a v2.1 PCIe controller, so add that version-specific string
to the device tree.  Update the kernel to also look for that string.
Currently, the kernel looks for "fsl,p4080-pcie" specifically, but
eventually that check should be deleted.

3) The P1010 device tree claims compatibility with v2.2 and v2.3, but that's
redundant.  No other device tree does this.  Remove the v2.2 string.

4) The kernel looks for both "fsl,p1023-pcie" and "fsl,qoriq-pcie-v2.2",
even though the P1023 device trees has always included both strings.  Remove
the search for "fsl,p1023-pcie".

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi |    4 ++--
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi |    6 +++---
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |    6 +++---
 arch/powerpc/sysdev/fsl_pci.c               |   15 ++++++++++-----
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
index 0bde9ee..af12ead 100644
--- a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
@@ -41,7 +41,7 @@
 
 /* controller at 0x9000 */
 &pci0 {
-	compatible = "fsl,p1010-pcie", "fsl,qoriq-pcie-v2.3", "fsl,qoriq-pcie-v2.2";
+	compatible = "fsl,p1010-pcie", "fsl,qoriq-pcie-v2.3";
 	device_type = "pci";
 	#size-cells = <2>;
 	#address-cells = <3>;
@@ -69,7 +69,7 @@
 
 /* controller at 0xa000 */
 &pci1 {
-	compatible = "fsl,p1010-pcie", "fsl,qoriq-pcie-v2.3", "fsl,qoriq-pcie-v2.2";
+	compatible = "fsl,p1010-pcie", "fsl,qoriq-pcie-v2.3";
 	device_type = "pci";
 	#size-cells = <2>;
 	#address-cells = <3>;
diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
index 06216b8..e179803 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
@@ -45,7 +45,7 @@
 
 /* controller at 0x9000 */
 &pci0 {
-	compatible = "fsl,p1022-pcie";
+	compatible = "fsl,mpc8548-pcie";
 	device_type = "pci";
 	#size-cells = <2>;
 	#address-cells = <3>;
@@ -73,7 +73,7 @@
 
 /* controller at 0xa000 */
 &pci1 {
-	compatible = "fsl,p1022-pcie";
+	compatible = "fsl,mpc8548-pcie";
 	device_type = "pci";
 	#size-cells = <2>;
 	#address-cells = <3>;
@@ -102,7 +102,7 @@
 
 /* controller at 0xb000 */
 &pci2 {
-	compatible = "fsl,p1022-pcie";
+	compatible = "fsl,mpc8548-pcie";
 	device_type = "pci";
 	#size-cells = <2>;
 	#address-cells = <3>;
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index 4f9c9f6..cf4f538 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -41,7 +41,7 @@
 
 /* controller at 0x200000 */
 &pci0 {
-	compatible = "fsl,p4080-pcie";
+	compatible = "fsl,p4080-pcie", "fsl,qoriq-pcie-v2.1";
 	device_type = "pci";
 	#size-cells = <2>;
 	#address-cells = <3>;
@@ -68,7 +68,7 @@
 
 /* controller at 0x201000 */
 &pci1 {
-	compatible = "fsl,p4080-pcie";
+	compatible = "fsl,p4080-pcie", "fsl,qoriq-pcie-v2.1";
 	device_type = "pci";
 	#size-cells = <2>;
 	#address-cells = <3>;
@@ -95,7 +95,7 @@
 
 /* controller at 0x202000 */
 &pci2 {
-	compatible = "fsl,p4080-pcie";
+	compatible = "fsl,p4080-pcie", "fsl,qoriq-pcie-v2.1";
 	device_type = "pci";
 	#size-cells = <2>;
 	#address-cells = <3>;
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 92a5915..f213fb6 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -827,13 +827,18 @@ static const struct of_device_id pci_ids[] = {
 	{ .compatible = "fsl,mpc8548-pcie", },
 	{ .compatible = "fsl,mpc8610-pci", },
 	{ .compatible = "fsl,mpc8641-pcie", },
+	{ .compatible = "fsl,qoriq-pcie-v2.1", },
+	{ .compatible = "fsl,qoriq-pcie-v2.2", },
+	{ .compatible = "fsl,qoriq-pcie-v2.3", },
+	{ .compatible = "fsl,qoriq-pcie-v2.4", },
+
+	/*
+	 * The following entries are for compatibility with older device
+	 * trees.
+	 */
 	{ .compatible = "fsl,p1022-pcie", },
-	{ .compatible = "fsl,p1010-pcie", },
-	{ .compatible = "fsl,p1023-pcie", },
 	{ .compatible = "fsl,p4080-pcie", },
-	{ .compatible = "fsl,qoriq-pcie-v2.4", },
-	{ .compatible = "fsl,qoriq-pcie-v2.3", },
-	{ .compatible = "fsl,qoriq-pcie-v2.2", },
+
 	{},
 };
 
-- 
1.7.3.4
