Return-Path: <prvs=03676dbd9c=valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 117731A0382
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 20:33:07 +1100 (AEDT)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: Linux PowerPC Kernel <linuxppc-dev@lists.ozlabs.org>,
 Linux device trees <devicetree@vger.kernel.org>,
 Linux I2C <linux-i2c@vger.kernel.org>, Scott Wood <scottwood@freescale.com>
Subject: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
Date: Fri, 17 Oct 2014 11:27:06 +0200
Message-Id: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>
Cc: Rainer Boschung <rainer.boschung@keymile.com>,
 Valentin Longchamp <valentin.longchamp@keymile.com>,
 Holger Brunck <holger.brunck@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With "fsl-i2c" compatibility the i2c frequency is not set
correctly, because it sets no prescaler. According to the AN2919 from
Freescale and the QorIQ (P2041) documentation, the source clock is 1/2
the platform clock. This implies that a prescaler of 2 must be used.

This changes the compatibility of the qoriq-i2c .dtsi files to pick the
mpc8543, which uses the same driver but sets the correct prescaler.

Signed-off-by: Rainer Boschung <rainer.boschung@keymile.com>
Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---

 arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi | 4 ++--
 arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
index 5f9bf7d..aa6c366 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
@@ -36,7 +36,7 @@ i2c@118000 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	cell-index = <0>;
-	compatible = "fsl-i2c";
+	compatible = "fsl,mpc8543-i2c", "fsl-i2c";
 	reg = <0x118000 0x100>;
 	interrupts = <38 2 0 0>;
 	dfsrr;
@@ -46,7 +46,7 @@ i2c@118100 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	cell-index = <1>;
-	compatible = "fsl-i2c";
+	compatible = "fsl,mpc8543-i2c", "fsl-i2c";
 	reg = <0x118100 0x100>;
 	interrupts = <38 2 0 0>;
 	dfsrr;
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi
index 7989bf5..b697a3b 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi
@@ -36,7 +36,7 @@ i2c@119000 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	cell-index = <2>;
-	compatible = "fsl-i2c";
+	compatible = "fsl,mpc8543-i2c", "fsl-i2c";
 	reg = <0x119000 0x100>;
 	interrupts = <39 2 0 0>;
 	dfsrr;
@@ -46,7 +46,7 @@ i2c@119100 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	cell-index = <3>;
-	compatible = "fsl-i2c";
+	compatible = "fsl,mpc8543-i2c", "fsl-i2c";
 	reg = <0x119100 0x100>;
 	interrupts = <39 2 0 0>;
 	dfsrr;
-- 
1.8.0.1
