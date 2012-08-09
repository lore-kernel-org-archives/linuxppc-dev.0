Return-Path: <r63875@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 491452C0091
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2012 18:09:28 +1000 (EST)
Received: from mail8-tx2 (localhost [127.0.0.1])	by mail8-tx2-R.bigfish.com
 (Postfix) with ESMTP id B9CCB4A0071	for <linuxppc-dev@ozlabs.org>; Thu,  9
 Aug 2012 08:09:24 +0000 (UTC)
Received: from TX2EHSMHS029.bigfish.com (unknown [10.9.14.245])	by
 mail8-tx2.bigfish.com (Postfix) with ESMTP id 13EBA2000C2	for
 <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2012 08:09:22 +0000 (UTC)
From: Olivia Yin <hong-hua.yin@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3,
 v2] powerpc/e500v2: Add Power ISA properties to comply with ePAPR 1.1
Date: Thu, 9 Aug 2012 15:42:34 +0800
Message-ID: <1344498156-25127-1-git-send-email-hong-hua.yin@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Olivia Yin <hong-hua.yin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

power-isa-version and power-isa-* are cpu node general properties defined in ePAPR.

If the power-isa-version property exists, then for each category from the 
Categories section of Book I of the Power ISA version indicated, the 
existence of a property named power-isa-[CAT], where [CAT] is the 
abbreviated category name with all uppercase letters converted to 
lowercase, indicates that the category is supported by the implementation.

The patch update all e500v2 platforms.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
Signed-off-by: Olivia Yin <hong-hua.yin@freescale.com>
---
git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
branch: next

 arch/powerpc/boot/dts/fsl/e500v2_power_isa.dtsi |   52 +++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi    |    3 +
 arch/powerpc/boot/dts/fsl/mpc8544si-pre.dtsi    |    3 +
 arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi    |    3 +
 arch/powerpc/boot/dts/fsl/mpc8568si-pre.dtsi    |    3 +
 arch/powerpc/boot/dts/fsl/mpc8569si-pre.dtsi    |    3 +
 arch/powerpc/boot/dts/fsl/mpc8572si-pre.dtsi    |    3 +
 arch/powerpc/boot/dts/fsl/p1010si-pre.dtsi      |    3 +
 arch/powerpc/boot/dts/fsl/p1020si-pre.dtsi      |    3 +
 arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi      |    3 +
 arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi      |    3 +
 arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi      |    3 +
 arch/powerpc/boot/dts/fsl/p2020si-pre.dtsi      |    3 +
 arch/powerpc/boot/dts/mpc8540ads.dts            |    2 +
 arch/powerpc/boot/dts/mpc8541cds.dts            |    2 +
 arch/powerpc/boot/dts/mpc8555cds.dts            |    2 +
 arch/powerpc/boot/dts/mpc8560ads.dts            |    2 +
 17 files changed, 96 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/e500v2_power_isa.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/e500v2_power_isa.dtsi b/arch/powerpc/boot/dts/fsl/e500v2_power_isa.dtsi
new file mode 100644
index 0000000..efd6c73
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/e500v2_power_isa.dtsi
@@ -0,0 +1,52 @@
+/*
+ * e500v2 Power ISA Device Tree Source (include)
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/ {
+	cpus {
+		power-isa-version = "2.03";
+		power-isa-b;		// Base
+		power-isa-e;		// Embedded
+		power-isa-atb;		// Alternate Time Base
+		power-isa-cs;		// Cache Specification
+		power-isa-e.le;		// Embedded.Little-Endian
+		power-isa-e.pm;		// Embedded.Performance Monitor
+		power-isa-ecl;		// Embedded Cache Locking
+		power-isa-mmc;		// Memory Coherence
+		power-isa-sp;		// Signal Processing Engine
+		power-isa-sp.fd;	// SPE.Embedded Float Scalar Double
+		power-isa-sp.fs;	// SPE.Embedded Float Scalar Single
+		power-isa-sp.fv;	// SPE.Embedded Float Vector
+		mmu-type = "power-embedded";
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi b/arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi
index 7de45a7..152906f 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi
@@ -33,6 +33,9 @@
  */
 
 /dts-v1/;
+
+/include/ "e500v2_power_isa.dtsi"
+
 / {
 	compatible = "fsl,MPC8536";
 	#address-cells = <2>;
diff --git a/arch/powerpc/boot/dts/fsl/mpc8544si-pre.dtsi b/arch/powerpc/boot/dts/fsl/mpc8544si-pre.dtsi
index 8777f92..5a69baf 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8544si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8544si-pre.dtsi
@@ -33,6 +33,9 @@
  */
 
 /dts-v1/;
+
+/include/ "e500v2_power_isa.dtsi"
+
 / {
 	compatible = "fsl,MPC8544";
 	#address-cells = <2>;
diff --git a/arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi b/arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi
index 720422d..fc1ce97 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi
@@ -33,6 +33,9 @@
  */
 
 /dts-v1/;
+
+/include/ "e500v2_power_isa.dtsi"
+
 / {
 	compatible = "fsl,MPC8548";
 	#address-cells = <2>;
diff --git a/arch/powerpc/boot/dts/fsl/mpc8568si-pre.dtsi b/arch/powerpc/boot/dts/fsl/mpc8568si-pre.dtsi
index eacd62c..122ca3b 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8568si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8568si-pre.dtsi
@@ -33,6 +33,9 @@
  */
 
 /dts-v1/;
+
+/include/ "e500v2_power_isa.dtsi"
+
 / {
 	compatible = "fsl,MPC8568";
 	#address-cells = <2>;
diff --git a/arch/powerpc/boot/dts/fsl/mpc8569si-pre.dtsi b/arch/powerpc/boot/dts/fsl/mpc8569si-pre.dtsi
index b07064d..2cd15a2 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8569si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8569si-pre.dtsi
@@ -33,6 +33,9 @@
  */
 
 /dts-v1/;
+
+/include/ "e500v2_power_isa.dtsi"
+
 / {
 	compatible = "fsl,MPC8569";
 	#address-cells = <2>;
diff --git a/arch/powerpc/boot/dts/fsl/mpc8572si-pre.dtsi b/arch/powerpc/boot/dts/fsl/mpc8572si-pre.dtsi
index ca18832..28c2a86 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8572si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8572si-pre.dtsi
@@ -33,6 +33,9 @@
  */
 
 /dts-v1/;
+
+/include/ "e500v2_power_isa.dtsi"
+
 / {
 	compatible = "fsl,MPC8572";
 	#address-cells = <2>;
diff --git a/arch/powerpc/boot/dts/fsl/p1010si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1010si-pre.dtsi
index 7354a8f..6e76f9b 100644
--- a/arch/powerpc/boot/dts/fsl/p1010si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010si-pre.dtsi
@@ -33,6 +33,9 @@
  */
 
 /dts-v1/;
+
+/include/ "e500v2_power_isa.dtsi"
+
 / {
 	compatible = "fsl,P1010";
 	#address-cells = <2>;
diff --git a/arch/powerpc/boot/dts/fsl/p1020si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1020si-pre.dtsi
index 6f0376e..fed9c4c 100644
--- a/arch/powerpc/boot/dts/fsl/p1020si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1020si-pre.dtsi
@@ -33,6 +33,9 @@
  */
 
 /dts-v1/;
+
+/include/ "e500v2_power_isa.dtsi"
+
 / {
 	compatible = "fsl,P1020";
 	#address-cells = <2>;
diff --git a/arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi
index 4abd54b..36161b5 100644
--- a/arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi
@@ -33,6 +33,9 @@
  */
 
 /dts-v1/;
+
+/include/ "e500v2_power_isa.dtsi"
+
 / {
 	compatible = "fsl,P1021";
 	#address-cells = <2>;
diff --git a/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
index e930f4f..1956dea 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
@@ -33,6 +33,9 @@
  */
 
 /dts-v1/;
+
+/include/ "e500v2_power_isa.dtsi"
+
 / {
 	compatible = "fsl,P1022";
 	#address-cells = <2>;
diff --git a/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi
index ac45f6d..132a152 100644
--- a/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi
@@ -33,6 +33,9 @@
  */
 
 /dts-v1/;
+
+/include/ "e500v2_power_isa.dtsi"
+
 / {
 	compatible = "fsl,P1023";
 	#address-cells = <2>;
diff --git a/arch/powerpc/boot/dts/fsl/p2020si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p2020si-pre.dtsi
index 3213288..42bf3c6 100644
--- a/arch/powerpc/boot/dts/fsl/p2020si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2020si-pre.dtsi
@@ -33,6 +33,9 @@
  */
 
 /dts-v1/;
+
+/include/ "e500v2_power_isa.dtsi"
+
 / {
 	compatible = "fsl,P2020";
 	#address-cells = <2>;
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index f99fb11..2d31863 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -11,6 +11,8 @@
 
 /dts-v1/;
 
+/include/ "fsl/e500v2_power_isa.dtsi"
+
 / {
 	model = "MPC8540ADS";
 	compatible = "MPC8540ADS", "MPC85xxADS";
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 0f5e939..1c03c26 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -11,6 +11,8 @@
 
 /dts-v1/;
 
+/include/ "fsl/e500v2_power_isa.dtsi"
+
 / {
 	model = "MPC8541CDS";
 	compatible = "MPC8541CDS", "MPC85xxCDS";
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index fe10438..36a7ea1 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -11,6 +11,8 @@
 
 /dts-v1/;
 
+/include/ "fsl/e500v2_power_isa.dtsi"
+
 / {
 	model = "MPC8555CDS";
 	compatible = "MPC8555CDS", "MPC85xxCDS";
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 6e85e1b..1a43f5a 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -11,6 +11,8 @@
 
 /dts-v1/;
 
+/include/ "fsl/e500v2_power_isa.dtsi"
+
 / {
 	model = "MPC8560ADS";
 	compatible = "MPC8560ADS", "MPC85xxADS";
-- 
1.6.4
