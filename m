Return-Path: <qiang.zhao@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3C01C2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 19:27:50 +1100 (EST)
Received: from mail157-co9 (localhost [127.0.0.1])	by
 mail157-co9-R.bigfish.com (Postfix) with ESMTP id 6988E4001C9	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 08:27:46 +0000 (UTC)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <B07421@freescale.com>
Subject: [PATCH] T1040RDB: add qe node for T1040RDB dts
Date: Wed, 12 Mar 2014 16:26:02 +0800
Message-ID: <1394612762-36308-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>, R63061@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 arch/powerpc/boot/dts/t1040rdb.dts | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/powerpc/boot/dts/t1040rdb.dts b/arch/powerpc/boot/dts/t1040rdb.dts
index e2eee18..6ff0412 100644
--- a/arch/powerpc/boot/dts/t1040rdb.dts
+++ b/arch/powerpc/boot/dts/t1040rdb.dts
@@ -268,6 +268,49 @@
 			fsl,fman-mac = <&enet4>;
 		};
 	};
+
+	qe: qe@ffe139999 {
+		ranges = <0x0 0xf 0xfe140000 0x40000>;
+		reg = <0xf 0xfe140000 0 0x480>;
+		brg-frequency = <0>;
+		bus-frequency = <0>;
+
+		si1: si@700 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,qe-si";
+			reg = <0x700 0x80>;
+		};
+
+		siram1: siram@1000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,qe-siram";
+			reg = <0x1000 0x800>;
+		};
+
+		tdma: ucc@2000 {
+			compatible = "fsl,ucc-tdm";
+			rx-clock-name = "clk3";
+			tx-clock-name = "clk4";
+			fsl,rx-sync-clock = "rsync_pin";
+			fsl,tx-sync-clock = "tsync_pin";
+			fsl,tx-timeslot = <0xfffffffe>;
+			fsl,rx-timeslot = <0xfffffffe>;
+			fsl,tdm-framer-type = "e1";
+			fsl,tdm-mode = "normal";
+			fsl,tdm-id = <0>;
+			fsl,siram-entry-id = <0>;
+		};
+
+		serial: ucc@2200 {
+			device_type = "serial";
+			compatible = "ucc_uart";
+			port-number = <1>;
+			rx-clock-name = "brg2";
+			tx-clock-name = "brg2";
+		};
+	};
 };
 /include/ "fsl/t1040si-post.dtsi"
 /include/ "fsl/qoriq-dpaa-res3.dtsi"
-- 
1.8.5
