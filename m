Return-Path: <B16394@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0070A2C00D5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 13:49:40 +1000 (EST)
From: Vakul Garg <vakul@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCHv2] powerpc/crypto: Add property for 'era' in SEC dts crypto
 node
Date: Thu, 11 Apr 2013 09:15:23 +0530
Message-ID: <1365651923-24017-1-git-send-email-vakul@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaveta Leekha <shaveta@freescale.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Andy Fleming <afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The crypto node now contains a new property 'fsl,sec-era'.
This is required so that applications can retrieve era info without
having to be able to read SEC's register space.

Signed-off-by: Vakul Garg <vakul@freescale.com>
---
Changelog:

	v2: Added era in p1023si-post.dtsi as per Kim's comments.

 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi   |    1 +
 arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi   |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-sec4.0-0.dtsi |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-sec5.0-0.dtsi |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-sec5.3-0.dtsi |    1 +
 7 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
index 941fa15..f1105bf 100644
--- a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
@@ -148,6 +148,7 @@
 
 	crypto: crypto@300000 {
 		compatible = "fsl,sec-v4.2", "fsl,sec-v4.0";
+		fsl,sec-era = <3>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x30000 0x10000>;
diff --git a/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi
index ffadcb5..bb3d826 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi
@@ -34,6 +34,7 @@
 
 crypto@30000 {
 	compatible = "fsl,sec-v4.4", "fsl,sec-v4.0";
+	fsl,sec-era = <3>;
 	#address-cells = <1>;
 	#size-cells = <1>;
 	ranges		 = <0x0 0x30000 0x10000>;
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec4.0-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sec4.0-0.dtsi
index 0cbbac3..02bee5f 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-sec4.0-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-sec4.0-0.dtsi
@@ -34,6 +34,7 @@
 
 crypto: crypto@300000 {
 	compatible = "fsl,sec-v4.0";
+	fsl,sec-era = <1>;
 	#address-cells = <1>;
 	#size-cells = <1>;
 	reg = <0x300000 0x10000>;
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi
index 7990e0d..7f7574e 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi
@@ -34,6 +34,7 @@
 
 crypto: crypto@300000 {
 	compatible = "fsl,sec-v4.2", "fsl,sec-v4.0";
+	fsl,sec-era = <3>;
 	#address-cells = <1>;
 	#size-cells = <1>;
 	reg		 = <0x300000 0x10000>;
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec5.0-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sec5.0-0.dtsi
index ffd458f..e298efb 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-sec5.0-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-sec5.0-0.dtsi
@@ -34,6 +34,7 @@
 
 crypto: crypto@300000 {
 	compatible = "fsl,sec-v5.0", "fsl,sec-v4.0";
+	fsl,sec-era = <5>;
 	#address-cells = <1>;
 	#size-cells = <1>;
 	reg		 = <0x300000 0x10000>;
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi
index 7b2ab8a..33ff09d 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi
@@ -34,6 +34,7 @@
 
 crypto: crypto@300000 {
 	compatible = "fsl,sec-v5.2", "fsl,sec-v5.0", "fsl,sec-v4.0";
+	fsl,sec-era = <5>;
 	#address-cells = <1>;
 	#size-cells = <1>;
 	reg		 = <0x300000 0x10000>;
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec5.3-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sec5.3-0.dtsi
index 0339825..0877822 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-sec5.3-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-sec5.3-0.dtsi
@@ -34,6 +34,7 @@
 
 crypto: crypto@300000 {
 	compatible = "fsl,sec-v5.3", "fsl,sec-v5.0", "fsl,sec-v4.0";
+	fsl,sec-era = <4>;
 	#address-cells = <1>;
 	#size-cells = <1>;
 	reg		 = <0x300000 0x10000>;
-- 
1.7.7.6
