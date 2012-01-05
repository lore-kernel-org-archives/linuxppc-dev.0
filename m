Return-Path: <r66093@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D8F0A1007D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2012 13:31:31 +1100 (EST)
Received: from mail118-ch1 (localhost [127.0.0.1])	by
 mail118-ch1-R.bigfish.com (Postfix) with ESMTP id E6A91520146	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2012 02:31:25 +0000 (UTC)
Received: from CH1EHSMHS022.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.241])	by mail118-ch1.bigfish.com (Postfix) with ESMTP id
 B9A66100048	for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2012 02:31:23
 +0000 (UTC)
From: <r66093@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] DTS: fix cmd12 bug and add the chip compatible for eSDHC
Date: Thu, 5 Jan 2012 09:40:56 +0800
Message-ID: <1325727656-18672-1-git-send-email-r66093@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

Accordint to latest kernel, the auto-cmd12 property should be
"sdhci,auto-cmd12", and according to the SDHC binding and the workaround for
the special chip, add the chip compatible for eSDHC: "fsl,p1022-esdhc",
"fsl,mpc8536-esdhc", "fsl,p2020-esdhc" and "fsl,p1010-esdhc".

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
changes for v2:
	- reverse the special compatible entries

 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi |    4 ++++
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi   |    3 ++-
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi   |    3 ++-
 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi   |    4 ++++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
index 89af626..44e0ed9 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
@@ -236,6 +236,10 @@
 	};
 
 /include/ "pq3-esdhc-0.dtsi"
+	sdhc@2e000 {
+		compatible = "fsl,mpc8536-esdhc", "fsl,esdhc";
+	};
+
 /include/ "pq3-sec3.0-0.dtsi"
 /include/ "pq3-mpic.dtsi"
 /include/ "pq3-mpic-timer-B.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
index bd9e163..8ebe79c 100644
--- a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
@@ -158,7 +158,8 @@
 /include/ "pq3-usb2-dr-0.dtsi"
 /include/ "pq3-esdhc-0.dtsi"
 	sdhc@2e000 {
-		fsl,sdhci-auto-cmd12;
+		compatible = "fsl,p1010-esdhc", "fsl,esdhc";
+		sdhci,auto-cmd12;
 	};
 
 /include/ "pq3-sec4.4-0.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
index 16239b1..9999e56 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
@@ -203,7 +203,8 @@
 
 /include/ "pq3-esdhc-0.dtsi"
 	sdhc@2e000 {
-		fsl,sdhci-auto-cmd12;
+		compatible = "fsl,p1022-esdhc", "fsl,esdhc";
+		sdhci,auto-cmd12;
 	};
 
 /include/ "pq3-sec3.3-0.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
index c041050..8ec1b13 100644
--- a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
@@ -182,6 +182,10 @@
 /include/ "pq3-etsec1-1.dtsi"
 /include/ "pq3-etsec1-2.dtsi"
 /include/ "pq3-esdhc-0.dtsi"
+	sdhc@2e000 {
+		compatible = "fsl,p2020-esdhc", "fsl,esdhc";
+	};
+
 /include/ "pq3-sec3.1-0.dtsi"
 /include/ "pq3-mpic.dtsi"
 /include/ "pq3-mpic-timer-B.dtsi"
-- 
1.7.5.4
