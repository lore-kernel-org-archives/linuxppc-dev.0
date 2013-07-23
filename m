Return-Path: <B42677@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CAD732C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 13:50:35 +1000 (EST)
From: Haijun Zhang <Haijun.Zhang@freescale.com>
To: <linux-mmc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] Powerpc: Add voltage support in dts file
Date: Tue, 23 Jul 2013 10:59:04 +0800
Message-ID: <1374548345-15017-1-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: r39252@freescale.com, AFLEMING@freescale.com, cbouatmailru@gmail.com,
 scottwood@freescale.com, cjb@laptop.org,
 Haijun Zhang <haijun.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

eSDHC of T4240 had 1.8v voltage support. Add this node to specify
eSDHC voltage capacity. If this node not specified eSDHC driver
still can read from eSDHC host capacity register.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
changes for this patch set:
	- split from patch [PATCH 1/2] Powerpc: Add 
	- voltage ranges support for T4

 Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 3 +++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi         | 1 +
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
index bd9be0b..f1ac253 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
@@ -19,6 +19,8 @@ Optional properties:
     "bus-width = <1>" property.
   - sdhci,auto-cmd12: specifies that a controller can only handle auto
     CMD12.
+  - 3300 3300: specifies that eSDHC controller can support voltages ranges
+    from 3300 to 3300.
 
 Example:
 
@@ -29,4 +31,5 @@ sdhci@2e000 {
 	interrupt-parent = <&ipic>;
 	/* Filled in by U-Boot */
 	clock-frequency = <0>;
+	voltage-ranges = <3300 3300>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index bd611a9..567d0fb 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -399,6 +399,7 @@
 	sdhc@114000 {
 		compatible = "fsl,t4240-esdhc", "fsl,esdhc";
 		sdhci,auto-cmd12;
+		voltage-ranges = <1800 1800>;
 	};
 /include/ "qoriq-i2c-0.dtsi"
 /include/ "qoriq-i2c-1.dtsi"
-- 
1.8.0
