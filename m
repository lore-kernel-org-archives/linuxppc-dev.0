Return-Path: <B37400@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 12FEA2C043A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 22:28:14 +1100 (EST)
From: Sandeep Singh <Sandeep@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 4/4] Added device tree entries for Legerity SLIC node on
 various Freescale Platforms
Date: Thu, 7 Mar 2013 16:57:48 +0530
Message-ID: <1362655668-26721-4-git-send-email-Sandeep@freescale.com>
In-Reply-To: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
References: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Sandeep Singh <Sandeep@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SLIC device is connected on SPI bus on these platforms

Signed-off-by: Sandeep Singh <Sandeep@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
---
 arch/powerpc/boot/dts/p1010rdb.dtsi    |   13 ++++++++++++-
 arch/powerpc/boot/dts/p1020mbg-pc.dtsi |   19 +++++++++++++++++++
 arch/powerpc/boot/dts/p1020rdb-pc.dtsi |   18 ++++++++++++++++++
 arch/powerpc/boot/dts/p1020rdb.dtsi    |   17 +++++++++++++++++
 arch/powerpc/boot/dts/p1022ds.dtsi     |   17 +++++++++++++++++
 arch/powerpc/boot/dts/p1024rdb.dtsi    |   18 ++++++++++++++++++
 6 files changed, 101 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
index ec7c27a..b0a5908 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -1,7 +1,7 @@
 /*
  * P1010 RDB Device Tree Source stub (no addresses or top-level ranges)
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -184,8 +184,19 @@
 				label = "SPI Flash JFFS2 RFS";
 			};
 		};
+
+		tdm_phy_0: slic@0 {
+			compatible = "zarlink,le88266", "tdm-phy-slic";
+			reg = <0>;
+			spi-max-frequency = <8000000>;
+		};
 	};
 
+        tdm@16000 {
+		num-phy = <1>;
+		phy-handle = <&tdm_phy_0>;
+        };
+
 	usb@22000 {
 		phy_type = "utmi";
 		dr_mode = "host";
diff --git a/arch/powerpc/boot/dts/p1020mbg-pc.dtsi b/arch/powerpc/boot/dts/p1020mbg-pc.dtsi
index a24699c..9119387 100644
--- a/arch/powerpc/boot/dts/p1020mbg-pc.dtsi
+++ b/arch/powerpc/boot/dts/p1020mbg-pc.dtsi
@@ -93,6 +93,25 @@
 		};
 	};
 
+	spi@7000 {
+		tdm_phy_0: slic@0 {
+			compatible = "zarlink,le88266", "tdm-phy-slic";
+			reg = <1>;
+			spi-max-frequency = <8000000>;
+		};
+
+		tdm_phy_1: slic@1 {
+			compatible = "zarlink,le88266", "tdm-phy-slic";
+			reg = <2>;
+			spi-max-frequency = <8000000>;
+		};
+	};
+
+	tdm@16000 {
+		num-phy = <2>;
+		phy-handle = <&tdm_phy_0>, <&tdm_phy_1>;
+	};
+
 	mdio@24000 {
 		phy0: ethernet-phy@0 {
 			interrupts = <3 1 0 0>;
diff --git a/arch/powerpc/boot/dts/p1020rdb-pc.dtsi b/arch/powerpc/boot/dts/p1020rdb-pc.dtsi
index c952cd3..3a7fdd9 100644
--- a/arch/powerpc/boot/dts/p1020rdb-pc.dtsi
+++ b/arch/powerpc/boot/dts/p1020rdb-pc.dtsi
@@ -186,6 +186,24 @@
 				label = "file system jffs2";
 			};
 		};
+
+		tdm_phy_0: slic@0 {
+			compatible = "zarlink,le88266", "tdm-phy-slic";
+			reg = <1>;
+			spi-max-frequency = <8000000>;
+		};
+
+		tdm_phy_1: slic@1 {
+			compatible = "zarlink,le88266", "tdm-phy-slic";
+			reg = <2>;
+			spi-max-frequency = <8000000>;
+		};
+
+	};
+
+	tdm@16000 {
+		num-phy = <2>;
+		phy-handle = <&tdm_phy_0>, <&tdm_phy_1>;
 	};
 
 	usb@22000 {
diff --git a/arch/powerpc/boot/dts/p1020rdb.dtsi b/arch/powerpc/boot/dts/p1020rdb.dtsi
index 1fb7e0e..f1a3431 100644
--- a/arch/powerpc/boot/dts/p1020rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1020rdb.dtsi
@@ -186,6 +186,23 @@
 				label = "file system jffs2";
 			};
 		};
+
+		tdm_phy_0: slic@0 {
+			compatible = "zarlink,le88266", "tdm-phy-slic";
+			reg = <1>;
+			spi-max-frequency = <8000000>;
+		};
+
+		tdm_phy_1: slic@1 {
+			compatible = "zarlink,le88266", "tdm-phy-slic";
+			reg = <2>;
+			spi-max-frequency = <8000000>;
+		};
+	};
+
+	tdm@16000 {
+		num-phy = <2>;
+		phy-handle = <&tdm_phy_0>, <&tdm_phy_1>;
 	};
 
 	usb@22000 {
diff --git a/arch/powerpc/boot/dts/p1022ds.dtsi b/arch/powerpc/boot/dts/p1022ds.dtsi
index 873da35..af2d4e1 100644
--- a/arch/powerpc/boot/dts/p1022ds.dtsi
+++ b/arch/powerpc/boot/dts/p1022ds.dtsi
@@ -183,6 +183,18 @@
 				reg = <0x00700000 0x00900000>;
 			};
 		};
+
+		tdm_phy_0: slic@0 {
+			compatible = "zarlink,le88266", "tdm-phy-slic";
+			reg = <1>;
+			spi-max-frequency = <8000000>;
+		};
+
+		tdm_phy_1: slic@1 {
+			compatible = "zarlink,le88266", "tdm-phy-slic";
+			reg = <2>;
+			spi-max-frequency = <8000000>;
+		};
 	};
 
 	ssi@15000 {
@@ -191,6 +203,11 @@
 		fsl,ssi-asynchronous;
 	};
 
+	tdm@16000 {
+		num-phy = <2>;
+		phy-handle = <&tdm_phy_0>, <&tdm_phy_1>;
+	};
+
 	usb@22000 {
 		phy_type = "ulpi";
 	};
diff --git a/arch/powerpc/boot/dts/p1024rdb.dtsi b/arch/powerpc/boot/dts/p1024rdb.dtsi
index b05dcb4..cec36a3 100644
--- a/arch/powerpc/boot/dts/p1024rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1024rdb.dtsi
@@ -164,6 +164,19 @@
 				label = "SPI JFFS2 RFS";
 			};
 		};
+
+                tdm_phy_0: slic@0 {
+                        compatible = "zarlink,le88266", "tdm-phy-slic";
+			reg = <1>;
+			spi-max-frequency = <8000000>;
+		};
+
+                tdm_phy_1: slic@1 {
+                        compatible = "zarlink,le88266", "tdm-phy-slic";
+			reg = <2>;
+			spi-max-frequency = <8000000>;
+		};
+
 	};
 
 	i2c@3000 {
@@ -173,6 +186,11 @@
 		};
 	};
 
+        tdm@16000 {
+                num-phy = <2>;
+                phy-handle = <&tdm_phy_0>, <&tdm_phy_1>;
+        };
+
 	usb@22000 {
 		phy_type = "ulpi";
 	};
-- 
1.7.6.GIT
