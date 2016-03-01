Return-Path: <qiang.zhao@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0100.outbound.protection.outlook.com [157.56.111.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7E501A0D2D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 18:33:29 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <robh+dt@kernel.org>
CC: <oss@buserror.net>, <leoyang.li@nxp.com>, <xiaobo.xie@nxp.com>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH v3 6/7] T104xRDB: Add qe node to t104xrdb
Date: Tue, 1 Mar 2016 15:09:42 +0800
Message-ID: <1456816183-22340-6-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1456816183-22340-1-git-send-email-qiang.zhao@nxp.com>
References: <1456816183-22340-1-git-send-email-qiang.zhao@nxp.com>
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

add qe node to t104xrdb.dtsi

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
Changes for v2
	- rebase
Changes for v3
	- rebase

 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi | 39 +++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
index 830ea48..79d923e 100644
--- a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
@@ -186,4 +186,43 @@
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
+			compatible = "fsl,t1040-qe-si";
+			reg = <0x700 0x80>;
+		};
+
+		siram1: siram@1000 {
+			compatible = "fsl,t1040-qe-siram";
+			reg = <0x1000 0x800>;
+		};
+
+		ucc_hdlc: ucc@2000 {
+			compatible = "fsl,ucc-hdlc";
+			rx-clock-name = "clk8";
+			tx-clock-name = "clk9";
+			fsl,rx-sync-clock = "rsync_pin";
+			fsl,tx-sync-clock = "tsync_pin";
+			fsl,tx-timeslot-mask = <0xfffffffe>;
+			fsl,rx-timeslot-mask = <0xfffffffe>;
+			fsl,tdm-framer-type = "e1";
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
