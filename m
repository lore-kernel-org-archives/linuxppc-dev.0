Return-Path: <B35336@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B9F1EB6FEC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 20:05:03 +1100 (EST)
Received: from mail34-am1 (localhost [127.0.0.1])	by mail34-am1-R.bigfish.com
 (Postfix) with ESMTP id B674E2E046A	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2012 09:04:57 +0000 (UTC)
Received: from AM1EHSMHS004.bigfish.com (unknown [10.3.201.240])	by
 mail34-am1.bigfish.com (Postfix) with ESMTP id A4B3F260045	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 09:04:55 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 5/9] powerpc/mpc8548cds: Add RapidIO node to dts
Date: Tue, 6 Mar 2012 17:06:41 +0800
Message-ID: <1331024805-15926-4-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
References: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: chenhui zhao <chenhui.zhao@freescale.com>

Enable RapidIO and add rapidio and rmu nodes to dts.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi |   16 ++++++++++++++++
 arch/powerpc/boot/dts/mpc8548cds.dts          |    7 +++++++
 arch/powerpc/platforms/85xx/Kconfig           |    1 +
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi
index 9d8023a..579d76c 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi
@@ -89,6 +89,21 @@
 	};
 };
 
+&rio {
+	compatible = "fsl,srio";
+	interrupts = <48 2 0 0>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+	fsl,srio-rmu-handle = <&rmu>;
+	ranges;
+
+	port1 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <1>;
+	};
+};
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -134,6 +149,7 @@
 
 /include/ "pq3-sec2.1-0.dtsi"
 /include/ "pq3-mpic.dtsi"
+/include/ "pq3-rmu-0.dtsi"
 
 	global-utilities@e0000 {
 		compatible = "fsl,mpc8548-guts";
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index c3c8741..8d4df8e 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -339,6 +339,13 @@
 				  0x0 0x100000>;
 		};
 	};
+
+	rio: rapidio@e00c0000 {
+		reg = <0x0 0xe00c0000 0x0 0x20000>;
+		port1 {
+			ranges = <0x0 0x0 0x0 0xc0000000 0x0 0x20000000>;
+		};
+	};
 };
 
 /include/ "fsl/mpc8548si-post.dtsi"
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index d7946be..631dfd8 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -30,6 +30,7 @@ config MPC85xx_CDS
 	bool "Freescale MPC85xx CDS"
 	select DEFAULT_UIMAGE
 	select PPC_I8259
+	select HAS_RAPIDIO
 	help
 	  This option enables support for the MPC85xx CDS board
 
-- 
1.6.4.1
