Return-Path: <B32736@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 53C242C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 18:17:09 +1000 (EST)
From: Zhicheng <B32736@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/dts: Add ucc uart support for p1025rdb
Date: Tue, 10 Jul 2012 15:52:10 +0800
Message-ID: <1341906730-31300-1-git-send-email-B32736@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhicheng Fan <B32736@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Zhicheng Fan <B32736@freescale.com>

Signed-off-by: Zhicheng Fan <B32736@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p1021si-post.dtsi |   16 ++++++++++-
 arch/powerpc/boot/dts/p1025rdb.dtsi         |   40 +++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
index a78e7ed..8a5993f 100644
--- a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * P1021/P1012 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -210,6 +210,20 @@
 		interrupt-parent = <&qeic>;
 	};
 
+	ucc@2600 {
+		cell-index = <7>;
+		reg = <0x2600 0x200>;
+		interrupts = <42>;
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
 	muram@10000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/p1025rdb.dtsi b/arch/powerpc/boot/dts/p1025rdb.dtsi
index 3875661..257adf9 100644
--- a/arch/powerpc/boot/dts/p1025rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1025rdb.dtsi
@@ -272,5 +272,45 @@
 				0x1  0x4  0x2  0x0  0x2  0x0    /* ENET5_RX_DV_SER5_CTS_B */
 				0x1  0x8  0x2  0x0  0x2  0x0>;    /* ENET5_RX_ER_SER5_CD_B */
 		};
+
+		pio3: ucc_pin@03 {
+			pio-map = <
+		/* port  pin  dir  open_drain  assignment  has_irq */
+				0x0  0x16 0x2  0x0  0x2  0x0    /* SER7_CD_B*/
+				0x0  0x12 0x2  0x0  0x2  0x0    /* SER7_CTS_B*/
+				0x0  0x13 0x1  0x0  0x2  0x0    /* SER7_RTS_B*/
+				0x0  0x14 0x2  0x0  0x2  0x0    /* SER7_RXD0*/
+				0x0  0x15 0x1  0x0  0x2  0x0>;    /* SER7_TXD0*/
+		};
+
+		pio4: ucc_pin@04 {
+			pio-map = <
+		/* port  pin  dir  open_drain  assignment  has_irq */
+				0x1  0x0  0x2  0x0  0x2  0x0    /* SER3_CD_B*/
+				0x0  0x1c 0x2  0x0  0x2  0x0    /* SER3_CTS_B*/
+				0x0  0x1d 0x1  0x0  0x2  0x0    /* SER3_RTS_B*/
+				0x0  0x1e 0x2  0x0  0x2  0x0    /* SER3_RXD0*/
+				0x0  0x1f 0x1  0x0  0x2  0x0>;    /* SER3_TXD0*/
+		};
+	};
+};
+
+&qe {
+	serial2: ucc@2600 {
+		device_type = "serial";
+		compatible = "ucc_uart";
+		port-number = <0>;
+		rx-clock-name = "brg6";
+		tx-clock-name = "brg6";
+		pio-handle = <&pio3>;
+	};
+
+	serial3: ucc@2200 {
+		device_type = "serial";
+		compatible = "ucc_uart";
+		port-number = <1>;
+		rx-clock-name = "brg2";
+		tx-clock-name = "brg2";
+		pio-handle = <&pio4>;
 	};
 };
-- 
1.6.4
