Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0106.outbound.protection.outlook.com [157.56.111.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B20071A2C32
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 19:01:52 +1000 (AEST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
CC: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <alison.wang@freescale.com>, <jason.jin@freescale.com>, Wang Dongsheng
 <dongsheng.wang@freescale.com>
Subject: [PATCH v2 2/2] arm/layerscape: add RCPM device tree support for
 ls1021a.
Date: Tue, 15 Sep 2015 16:55:39 +0800
Message-ID: <1442307339-15225-2-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1442307339-15225-1-git-send-email-dongsheng.wang@freescale.com>
References: <1442307339-15225-1-git-send-email-dongsheng.wang@freescale.com>
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

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
*v2*: No changes.
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 973a496..deb1271 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -139,6 +139,7 @@
 			sdhci,auto-cmd12;
 			big-endian;
 			bus-width = <4>;
+			rcpm-wakeup = <&rcpm 0x00000080 0x0>;
 			status = "disabled";
 		};
 
@@ -186,6 +187,11 @@
 			};
 		};
 
+		rcpm: rcpm@1ee2000 {
+			compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1";
+			reg = <0x0 0x1ee2000 0x0 0x10000>;
+		};
+
 		dspi0: dspi@2100000 {
 			compatible = "fsl,ls1021a-v1.0-dspi";
 			#address-cells = <1>;
@@ -287,6 +293,7 @@
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&sysclk>;
 			clock-names = "ipg";
+			rcpm-wakeup = <&rcpm 0x0 0x40000000>;
 			status = "disabled";
 		};
 
-- 
2.1.0.27.g96db324
