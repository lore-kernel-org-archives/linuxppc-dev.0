Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0147.outbound.protection.outlook.com [157.56.111.147])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 901851A0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 16:07:58 +1100 (AEDT)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
 <B07421@freescale.com>
Subject: [PATCH 2/3] ls1021aqds: add qe node to ls1021aqds dts
Date: Wed, 22 Oct 2014 13:07:02 +0800
Message-ID: <1413954422-13044-1-git-send-email-B45475@freescale.com>
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

add qe node(qe-tdm and qe-uart) into ls1021a-qds.dts

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 arch/arm/boot/dts/ls1021a-qds.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index e24a5bc..4231daa 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -308,6 +308,30 @@
 	};
 };
 
+&uqe {
+	tdma: ucc@2000 {
+		compatible = "fsl,ucc-tdm";
+		rx-clock-name = "brg1";
+		tx-clock-name = "brg1";
+		fsl,rx-sync-clock = "none";
+		fsl,tx-sync-clock = "none";
+		fsl,tx-timeslot = <0xfffffffe>;
+		fsl,rx-timeslot = <0xfffffffe>;
+		fsl,tdm-framer-type = "e1";
+		fsl,tdm-mode = "internal-loopback";
+		fsl,tdm-id = <0>;
+		fsl,siram-entry-id = <0>;
+	};
+
+	serial: ucc@2200 {
+		device_type = "serial";
+		compatible = "ucc_uart";
+		port-number = <1>;
+		rx-clock-name = "brg2";
+		tx-clock-name = "brg2";
+	};
+};
+
 &pwm3 {
 	status = "okay";
 };
-- 
2.1.0.27.g96db324
