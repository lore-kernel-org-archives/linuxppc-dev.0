Return-Path: <qiang.zhao@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0058.outbound.protection.outlook.com [157.56.111.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A24F91A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 13:40:56 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
CC: <Priyanka.Jain@freescale.com>, <oss@buserror.net>, Zhao Qiang
 <qiang.zhao@nxp.com>
Subject: [PATCH 6/6] T104xQDS: Add qe node to t104xqds
Date: Fri, 8 Jan 2016 10:18:14 +0800
Message-ID: <1452219494-31947-6-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1452219494-31947-1-git-send-email-qiang.zhao@nxp.com>
References: <1452219494-31947-1-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

add qe node to t104xqds.dtsi

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 arch/powerpc/boot/dts/fsl/t104xqds.dtsi | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/t104xqds.dtsi b/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
index 1498d1e..8ebd574 100644
--- a/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
@@ -190,4 +190,48 @@
 				  0 0x00010000>;
 		};
 	};
+
+	qe: qe@ffe140000 {
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
+		ucc_hdlc: ucc@2000 {
+			compatible = "fsl,ucc_hdlc";
+			rx-clock-name = "clk8";
+			tx-clock-name = "clk9";
+			fsl,rx-sync-clock = "rsync_pin";
+			fsl,tx-sync-clock = "tsync_pin";
+			fsl,tx-timeslot = <0xfffffffe>;
+			fsl,rx-timeslot = <0xfffffffe>;
+			fsl,tdm-framer-type = "e1";
+			fsl,tdm-mode = "normal";
+			fsl,tdm-id = <0>;
+			fsl,siram-entry-id = <0>;
+			fsl,tdm-interface;
+		};
+
+		ucc_serial: ucc@2200 {
+			device_type = "serial";
+			compatible = "ucc_uart";
+			port-number = <1>;
+			rx-clock-name = "brg2";
+			tx-clock-name = "brg2";
+		};
+	};
 };
-- 
2.1.0.27.g96db324
