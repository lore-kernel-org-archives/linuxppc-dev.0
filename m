Return-Path: <qiang.zhao@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0066.outbound.protection.outlook.com [207.46.100.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E5F11A0335
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 12:47:58 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <robh+dt@kernel.org>
CC: <oss@buserror.net>, <leoyang.li@nxp.com>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang
 <qiang.zhao@nxp.com>
Subject: [PATCH v2 5/7] T104xD4RDB: Add qe node to t104xd4rdb
Date: Thu, 18 Feb 2016 09:06:10 +0800
Message-ID: <1455757572-44955-5-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1455757572-44955-1-git-send-email-qiang.zhao@nxp.com>
References: <1455757572-44955-1-git-send-email-qiang.zhao@nxp.com>
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

add qe node to t104xd4rdb.dtsi and t1040si-post.dtsi.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
Changes for v2
	- rebase

 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi | 45 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi   | 40 +++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index e0f4da5..012f813 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -673,3 +673,48 @@
 		};
 	};
 };
+
+&qe {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "qe";
+	compatible = "fsl,qe";
+	fsl,qe-num-riscs = <1>;
+	fsl,qe-num-snums = <28>;
+
+	qeic: interrupt-controller@80 {
+		interrupt-controller;
+		compatible = "fsl,qe-ic";
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		reg = <0x80 0x80>;
+		interrupts = <95 2 0 0  94 2 0 0>; //high:79 low:78
+	};
+
+	ucc@2000 {
+		cell-index = <1>;
+		reg = <0x2000 0x200>;
+		interrupts = <32>;
+		interrupt-parent = <&qeic>;
+	};
+
+	ucc@2200 {
+		cell-index = <3>;
+		reg = <0x2200 0x200>;
+		interrupts = <34>;
+		interrupt-parent = <&qeic>;
+	};
+
+	muram@10000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,qe-muram", "fsl,cpm-muram";
+		ranges = <0x0 0x10000 0x6000>;
+
+		data-only@0 {
+			compatible = "fsl,qe-muram-data",
+			"fsl,cpm-muram-data";
+			reg = <0x0 0x6000>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi b/arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi
index 3f6d7c6..2e24322 100644
--- a/arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi
@@ -212,4 +212,44 @@
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
+			compatible = "fsl,qe-si";
+			reg = <0x700 0x80>;
+		};
+
+		siram1: siram@1000 {
+			compatible = "fsl,qe-siram";
+			reg = <0x1000 0x800>;
+		};
+
+		ucc_hdlc: ucc@2000 {
+			compatible = "fsl,ucc-hdlc";
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
