Return-Path: <R64188@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A72D2C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 19:35:57 +1000 (EST)
From: Jason Jin <Jason.Jin@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH] Add a vga alias node for P1022
Date: Fri, 6 Sep 2013 17:32:37 +0800
Message-ID: <1378459957-26334-1-git-send-email-Jason.Jin@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Jason Jin <Jason.jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jason Jin <Jason.jin@freescale.com>

When the vga was set as the stdout and stderr in u-boot, the stdout fixup
code in u-boot need to find out the vga alias node in dtb.

Signed-off-by: Jason Jin <Jason.jin@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
index 1f189a9..c907c8e 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
@@ -175,7 +175,7 @@
 
 /include/ "pq3-gpio-0.dtsi"
 
-	display@10000 {
+	display: display@10000 {
 		compatible = "fsl,diu", "fsl,p1022-diu";
 		reg = <0x10000 1000>;
 		interrupts = <64 2 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
index 1956dea..cb8d816 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
@@ -50,6 +50,7 @@
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
+		vga = &display;
 	};
 
 	cpus {
-- 
1.8.0
