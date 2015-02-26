Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0137.outbound.protection.outlook.com [157.56.110.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4004D1A0001
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 02:32:25 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>
Subject: [PATCH 3/3] powerpc/mpc85xx: Add FSL QorIQ DPAA FMan support to the
 SoC device tree(s)
Date: Thu, 26 Feb 2015 09:26:57 -0600
Message-ID: <1424964417-13760-3-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1424964417-13760-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1424964417-13760-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shruti Kanetkar <Kanetkar.Shruti@gmail.com>,
 Igal Liberman <Igal.Liberman@Freescale.com>, afleming@gmail.com,
 Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Igal Liberman <Igal.Liberman@freescale.com>

Based on prior work by Andy Fleming <afleming@gmail.com>

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
Signed-off-by: Shruti Kanetkar <Kanetkar.Shruti@gmail.com>
Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  |   9 ++-
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  20 ++++-
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  |  12 ++-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |  31 +++++++-
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi | 115 +++++++++++++++++++++++++++-
 arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi  |   5 +-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |  29 ++++++-
 arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi  |  10 ++-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |  29 ++++++-
 arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi  |  10 ++-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |  48 +++++++++++-
 arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi  |  15 +++-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |  29 ++++++-
 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi  |  10 ++-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi |  56 +++++++++++++-
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi  |  17 +++-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi |  31 ++++++++
 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi  |   9 ++-
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi |  43 +++++++++++
 arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi  |  11 +++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |  88 ++++++++++++++++++++-
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi  |  22 +++++-
 22 files changed, 629 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
index 338af7e..70e2096 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
@@ -1,7 +1,7 @@
 /*
  * B4420 Silicon/SoC Device Tree Source (pre include)
  *
- * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012 - 2015 Freescale Semiconductor, Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -54,8 +54,13 @@
 		dma0 = &dma0;
 		dma1 = &dma1;
 		sdhc = &sdhc;
-	};
 
+		fman0 = &fman0;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+	};
 
 	cpus {
 		#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
index 02ccde6..006e95c 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * B4860 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2012 - 2014 Freescale Semiconductor Inc.
+ * Copyright 2012 - 2015 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -260,6 +260,24 @@
 		compatible = "fsl,b4860-rcpm", "fsl,qoriq-rcpm-2.0";
 	};
 
+/include/ "qoriq-fman3-0-1g-4.dtsi"
+/include/ "qoriq-fman3-0-1g-5.dtsi"
+/include/ "qoriq-fman3-0-10g-0.dtsi"
+/include/ "qoriq-fman3-0-10g-1.dtsi"
+	fman@400000 {
+		enet4: ethernet@e8000 {
+		};
+
+		enet5: ethernet@ea000 {
+		};
+
+		enet6: ethernet@f0000 {
+		};
+
+		enet7: ethernet@f2000 {
+		};
+	};
+
 	L2: l2-cache-controller@c20000 {
 		compatible = "fsl,b4860-l2-cache-controller";
 	};
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
index 1948f73..0fbda72 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
@@ -1,7 +1,7 @@
 /*
  * B4860 Silicon/SoC Device Tree Source (pre include)
  *
- * Copyright 2012 Freescale Semiconductor Inc.
+ * Copyright 2012 - 2015 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -54,6 +54,16 @@
 		dma0 = &dma0;
 		dma1 = &dma1;
 		sdhc = &sdhc;
+
+		fman0 = &fman0;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		ethernet4 = &enet4;
+		ethernet5 = &enet5;
+		ethernet6 = &enet6;
+		ethernet7 = &enet7;
 	};
 
 
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index 38621ef..b2ff0cb 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * B4420 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2012 - 2014 Freescale Semiconductor, Inc.
+ * Copyright 2012 - 2015 Freescale Semiconductor, Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -477,6 +477,35 @@
 		interrupts = <16 2 1 29>;
 	};
 
+/include/ "qoriq-fman3-0.dtsi"
+/include/ "qoriq-fman3-0-1g-0.dtsi"
+/include/ "qoriq-fman3-0-1g-1.dtsi"
+/include/ "qoriq-fman3-0-1g-2.dtsi"
+/include/ "qoriq-fman3-0-1g-3.dtsi"
+	fman@400000 {
+		interrupts = <96 2 0 0>, <16 2 1 30>;
+
+		enet0: ethernet@e0000 {
+		};
+
+		enet1: ethernet@e2000 {
+		};
+
+		enet2: ethernet@e4000 {
+		};
+
+		enet3: ethernet@e6000 {
+		};
+
+		mdio@fc000 {
+			interrupts = <100 1 0 0>;
+		};
+
+		mdio@fd000 {
+			interrupts = <101 1 0 0>;
+		};
+	};
+
 	L2: l2-cache-controller@c20000 {
 		compatible = "fsl,b4-l2-cache-controller";
 		reg = <0xc20000 0x1000>;
diff --git a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
index 8a09cbb..365aa26 100644
--- a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * P1023/P1017 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2011 - 2014 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2015 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -304,4 +304,117 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+	fman@100000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		cell-index = <0>;
+		ranges = <0 0x100000 0x100000>;
+		compatible = "fsl,fman";
+		reg = <0x100000 0x100000>;
+		interrupts = <24 2 0 0>, <16 2 1 30>;
+		clock-frequency = <0>;
+		fsl,qman-channel-range = <0x40 0x7>;
+
+		muram@0 {
+			compatible = "fsl,fman-muram";
+			reg = <0x0 0x10000>;
+		};
+
+		fman0_oh_0x2: port@82000 {
+			cell-index = <0x2>;
+			compatible = "fsl,fman-v2-port-oh";
+			reg = <0x82000 0x1000>;
+		};
+
+		fman0_oh_0x3: port@83000 {
+			cell-index = <0x3>;
+			compatible = "fsl,fman-v2-port-oh";
+			reg = <0x83000 0x1000>;
+		};
+
+		fman0_oh_0x4: port@84000 {
+			cell-index = <0x4>;
+			compatible = "fsl,fman-v2-port-oh";
+			reg = <0x84000 0x1000>;
+		};
+
+		fman0_oh_0x5: port@85000 {
+			cell-index = <0x5>;
+			compatible = "fsl,fman-v2-port-oh";
+			reg = <0x85000 0x1000>;
+		};
+
+		fman0_rx_0x08: port@88000 {
+			cell-index = <0x8>;
+			compatible = "fsl,fman-v2-port-rx";
+			reg = <0x88000 0x1000>;
+		};
+
+		fman0_rx_0x09: port@89000 {
+			cell-index = <0x9>;
+			compatible = "fsl,fman-v2-port-rx";
+			reg = <0x89000 0x1000>;
+		};
+
+		fman0_tx_0x28: port@a8000 {
+			cell-index = <0x28>;
+			compatible = "fsl,fman-v2-port-tx";
+			reg = <0xa8000 0x1000>;
+		};
+
+		fman0_tx_0x29: port@a9000 {
+			cell-index = <0x29>;
+			compatible = "fsl,fman-v2-port-tx";
+			reg = <0xa9000 0x1000>;
+		};
+
+		enet0: ethernet@e0000 {
+			cell-index = <0>;
+			compatible = "fsl,fman-dtsec";
+			reg = <0xe0000 0x1000>;
+			fsl,fman-ports = <&fman0_rx_0x08 &fman0_tx_0x28>;
+			tbi-handle = <&tbi0>;
+			ptp-timer = <&ptp_timer0>;
+		};
+
+		mdio@e1120 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,fman-mdio";
+			reg = <0xe1120 0xee0>;
+			interrupts = <26 1 0 0>;
+
+			tbi0: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		enet1: ethernet@e2000 {
+			cell-index = <1>;
+			compatible = "fsl,fman-dtsec";
+			reg = <0xe2000 0x1000>;
+			fsl,fman-ports = <&fman0_rx_0x09 &fman0_tx_0x29>;
+			tbi-handle = <&tbi1>;
+			ptp-timer = <&ptp_timer0>;
+		};
+
+		mdio@e3120 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,fman-mdio";
+			reg = <0xe3120 0xee0>;
+
+			tbi1: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ptp_timer0: ptp_timer@fe000 {
+			compatible = "fsl,fman-ptp-timer";
+			reg = <0xfe000 0x1000>;
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi
index 132a152..811a73e 100644
--- a/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi
@@ -1,7 +1,7 @@
 /*
  * P1023/P1017 Silicon/SoC Device Tree Source (pre include)
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2015 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -58,6 +58,9 @@
 		rtic_b = &rtic_b;
 		rtic_c = &rtic_c;
 		rtic_d = &rtic_d;
+
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
 	};
 
 	cpus {
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 60f63dc..09a5483 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * P2041/P2040 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2011 - 2014 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2015 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -437,4 +437,31 @@ crypto: crypto@300000 {
 
 /include/ "qoriq-qman1.dtsi"
 /include/ "qoriq-bman1.dtsi"
+
+/include/ "qoriq-fman-0.dtsi"
+/include/ "qoriq-fman-0-1g-0.dtsi"
+/include/ "qoriq-fman-0-1g-1.dtsi"
+/include/ "qoriq-fman-0-1g-2.dtsi"
+/include/ "qoriq-fman-0-1g-3.dtsi"
+/include/ "qoriq-fman-0-1g-4.dtsi"
+/include/ "qoriq-fman-0-10g-0.dtsi"
+	fman@400000 {
+		enet0: ethernet@e0000 {
+		};
+
+		enet1: ethernet@e2000 {
+		};
+
+		enet2: ethernet@e4000 {
+		};
+
+		enet3: ethernet@e6000 {
+		};
+
+		enet4: ethernet@e8000 {
+		};
+
+		enet5: ethernet@f0000 {
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
index b1ea147..941274c 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
@@ -1,7 +1,7 @@
 /*
  * P2041 Silicon/SoC Device Tree Source (pre include)
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2015 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -72,6 +72,14 @@
 		rtic_c = &rtic_c;
 		rtic_d = &rtic_d;
 		sec_mon = &sec_mon;
+
+		fman0 = &fman0;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		ethernet4 = &enet4;
+		ethernet5 = &enet5;
 	};
 
 	cpus {
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index d4e6677..8390e51 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * P3041 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2011 - 2014 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2015 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -464,4 +464,31 @@ crypto: crypto@300000 {
 
 /include/ "qoriq-qman1.dtsi"
 /include/ "qoriq-bman1.dtsi"
+
+/include/ "qoriq-fman-0.dtsi"
+/include/ "qoriq-fman-0-1g-0.dtsi"
+/include/ "qoriq-fman-0-1g-1.dtsi"
+/include/ "qoriq-fman-0-1g-2.dtsi"
+/include/ "qoriq-fman-0-1g-3.dtsi"
+/include/ "qoriq-fman-0-1g-4.dtsi"
+/include/ "qoriq-fman-0-10g-0.dtsi"
+	fman@400000 {
+		enet0: ethernet@e0000 {
+		};
+
+		enet1: ethernet@e2000 {
+		};
+
+		enet2: ethernet@e4000 {
+		};
+
+		enet3: ethernet@e6000 {
+		};
+
+		enet4: ethernet@e8000 {
+		};
+
+		enet5: ethernet@f0000 {
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
index dc5f4b3..50b73e8 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
@@ -1,7 +1,7 @@
 /*
  * P3041 Silicon/SoC Device Tree Source (pre include)
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2015 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -73,6 +73,14 @@
 		rtic_c = &rtic_c;
 		rtic_d = &rtic_d;
 		sec_mon = &sec_mon;
+
+		fman0 = &fman0;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		ethernet4 = &enet4;
+		ethernet5 = &enet5;
 	};
 
 	cpus {
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index d1cb691..d7779c5 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * P4080/P4040 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2011 - 2014 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2015 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -528,4 +528,50 @@ crypto: crypto@300000 {
 
 /include/ "qoriq-qman1.dtsi"
 /include/ "qoriq-bman1.dtsi"
+
+/include/ "qoriq-fman-0.dtsi"
+/include/ "qoriq-fman-0-1g-0.dtsi"
+/include/ "qoriq-fman-0-1g-1.dtsi"
+/include/ "qoriq-fman-0-1g-2.dtsi"
+/include/ "qoriq-fman-0-1g-3.dtsi"
+/include/ "qoriq-fman-0-10g-0.dtsi"
+	fman@400000 {
+		enet0: ethernet@e0000 {
+		};
+
+		enet1: ethernet@e2000 {
+		};
+
+		enet2: ethernet@e4000 {
+		};
+
+		enet3: ethernet@e6000 {
+		};
+
+		enet4: ethernet@f0000 {
+		};
+	};
+
+/include/ "qoriq-fman-1.dtsi"
+/include/ "qoriq-fman-1-1g-0.dtsi"
+/include/ "qoriq-fman-1-1g-1.dtsi"
+/include/ "qoriq-fman-1-1g-2.dtsi"
+/include/ "qoriq-fman-1-1g-3.dtsi"
+/include/ "qoriq-fman-1-10g-0.dtsi"
+	fman@500000 {
+		enet5: ethernet@e0000 {
+		};
+
+		enet6: ethernet@e2000 {
+		};
+
+		enet7: ethernet@e4000 {
+		};
+
+		enet8: ethernet@e6000 {
+		};
+
+		enet9: ethernet@f0000 {
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
index 38bde09..d56a546 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
@@ -1,7 +1,7 @@
 /*
  * P4080/P4040 Silicon/SoC Device Tree Source (pre include)
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2015 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -72,6 +72,19 @@
 		rtic_c = &rtic_c;
 		rtic_d = &rtic_d;
 		sec_mon = &sec_mon;
+
+		fman0 = &fman0;
+		fman1 = &fman1;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		ethernet4 = &enet4;
+		ethernet5 = &enet5;
+		ethernet6 = &enet6;
+		ethernet7 = &enet7;
+		ethernet8 = &enet8;
+		ethernet9 = &enet9;
 	};
 
 	cpus {
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index 9f3049d..efd97aa 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * P5020/5010 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2011 - 2014 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2015 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -460,4 +460,31 @@
 	raideng@320000 {
 		fsl,iommu-parent = <&pamu1>;
 	};
+
+/include/ "qoriq-fman-0.dtsi"
+/include/ "qoriq-fman-0-1g-0.dtsi"
+/include/ "qoriq-fman-0-1g-1.dtsi"
+/include/ "qoriq-fman-0-1g-2.dtsi"
+/include/ "qoriq-fman-0-1g-3.dtsi"
+/include/ "qoriq-fman-0-1g-4.dtsi"
+/include/ "qoriq-fman-0-10g-0.dtsi"
+	fman@400000 {
+		enet0: ethernet@e0000 {
+		};
+
+		enet1: ethernet@e2000 {
+		};
+
+		enet2: ethernet@e4000 {
+		};
+
+		enet3: ethernet@e6000 {
+		};
+
+		enet4: ethernet@e8000 {
+		};
+
+		enet5: ethernet@f0000 {
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
index 1cc61e1..bfba0b4 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
@@ -1,7 +1,7 @@
 /*
  * P5020/P5010 Silicon/SoC Device Tree Source (pre include)
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011 - 2015 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -79,6 +79,14 @@
 		raideng_jr1 = &raideng_jr1;
 		raideng_jr2 = &raideng_jr2;
 		raideng_jr3 = &raideng_jr3;
+
+		fman0 = &fman0;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		ethernet4 = &enet4;
+		ethernet5 = &enet5;
 	};
 
 	cpus {
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index 3dea4b6..1481265 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * P5040 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2012 - 2014 Freescale Semiconductor Inc.
+ * Copyright 2012 - 2015 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -447,4 +447,58 @@
 
 /include/ "qoriq-qman1.dtsi"
 /include/ "qoriq-bman1.dtsi"
+
+/include/ "qoriq-fman-0.dtsi"
+/include/ "qoriq-fman-0-1g-0.dtsi"
+/include/ "qoriq-fman-0-1g-1.dtsi"
+/include/ "qoriq-fman-0-1g-2.dtsi"
+/include/ "qoriq-fman-0-1g-3.dtsi"
+/include/ "qoriq-fman-0-1g-4.dtsi"
+/include/ "qoriq-fman-0-10g-0.dtsi"
+	fman@400000 {
+		enet0: ethernet@e0000 {
+		};
+
+		enet1: ethernet@e2000 {
+		};
+
+		enet2: ethernet@e4000 {
+		};
+
+		enet3: ethernet@e6000 {
+		};
+
+		enet4: ethernet@e8000 {
+		};
+
+		enet5: ethernet@f0000 {
+		};
+	};
+
+/include/ "qoriq-fman-1.dtsi"
+/include/ "qoriq-fman-1-1g-0.dtsi"
+/include/ "qoriq-fman-1-1g-1.dtsi"
+/include/ "qoriq-fman-1-1g-2.dtsi"
+/include/ "qoriq-fman-1-1g-3.dtsi"
+/include/ "qoriq-fman-1-1g-4.dtsi"
+/include/ "qoriq-fman-1-10g-0.dtsi"
+	fman@500000 {
+		enet6: ethernet@e0000 {
+		};
+
+		enet7: ethernet@e2000 {
+		};
+
+		enet8: ethernet@e4000 {
+		};
+
+		enet9: ethernet@e6000 {
+		};
+
+		enet10: ethernet@e8000 {
+		};
+
+		enet11: ethernet@f0000 {
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
index b048a2be..0659d5b 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
@@ -1,7 +1,7 @@
 /*
  * P5040 Silicon/SoC Device Tree Source (pre include)
  *
- * Copyright 2012 Freescale Semiconductor Inc.
+ * Copyright 2012 - 2015 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -72,6 +72,21 @@
 		rtic_c = &rtic_c;
 		rtic_d = &rtic_d;
 		sec_mon = &sec_mon;
+
+		fman0 = &fman0;
+		fman1 = &fman1;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		ethernet4 = &enet4;
+		ethernet5 = &enet5;
+		ethernet6 = &enet6;
+		ethernet7 = &enet7;
+		ethernet8 = &enet8;
+		ethernet9 = &enet9;
+		ethernet10 = &enet10;
+		ethernet11 = &enet11;
 	};
 
 	cpus {
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 8f718c6..0ac080a 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -550,4 +550,35 @@
 /include/ "qoriq-sec5.0-0.dtsi"
 /include/ "qoriq-qman3.dtsi"
 /include/ "qoriq-bman1.dtsi"
+
+/include/ "qoriq-fman3-0.dtsi"
+/include/ "qoriq-fman3-0-1g-0.dtsi"
+/include/ "qoriq-fman3-0-1g-1.dtsi"
+/include/ "qoriq-fman3-0-1g-2.dtsi"
+/include/ "qoriq-fman3-0-1g-3.dtsi"
+/include/ "qoriq-fman3-0-1g-4.dtsi"
+	fman@400000 {
+		enet0: ethernet@e0000 {
+		};
+
+		enet1: ethernet@e2000 {
+		};
+
+		enet2: ethernet@e4000 {
+		};
+
+		enet3: ethernet@e6000 {
+		};
+
+		enet4: ethernet@e8000 {
+		};
+
+		mdio@fc000 {
+			interrupts = <100 1 0 0>;
+		};
+
+		mdio@fd000 {
+			status = "disabled";
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi b/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
index bbb7025..fcfa38a 100644
--- a/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
@@ -1,7 +1,7 @@
 /*
  * T1040/T1042 Silicon/SoC Device Tree Source (pre include)
  *
- * Copyright 2013 Freescale Semiconductor Inc.
+ * Copyright 2013-2014 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -58,6 +58,13 @@
 		sdhc = &sdhc;
 
 		crypto = &crypto;
+
+		fman0 = &fman0;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		ethernet4 = &enet4;
 	};
 
 	cpus {
diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
index 06e76ec..05fd542 100644
--- a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
@@ -641,6 +641,49 @@
 /include/ "qoriq-qman3.dtsi"
 /include/ "qoriq-bman1.dtsi"
 
+/include/ "qoriq-fman3-0.dtsi"
+/include/ "qoriq-fman3-0-1g-0.dtsi"
+/include/ "qoriq-fman3-0-1g-1.dtsi"
+/include/ "qoriq-fman3-0-1g-2.dtsi"
+/include/ "qoriq-fman3-0-1g-3.dtsi"
+/include/ "qoriq-fman3-0-1g-4.dtsi"
+/include/ "qoriq-fman3-0-1g-5.dtsi"
+/include/ "qoriq-fman3-0-10g-0.dtsi"
+/include/ "qoriq-fman3-0-10g-1.dtsi"
+	fman@400000 {
+		enet0: ethernet@e0000 {
+		};
+
+		enet1: ethernet@e2000 {
+		};
+
+		enet2: ethernet@e4000 {
+		};
+
+		enet3: ethernet@e6000 {
+		};
+
+		enet4: ethernet@e8000 {
+		};
+
+		enet5: ethernet@ea000 {
+		};
+
+		enet6: ethernet@f0000 {
+		};
+
+		enet7: ethernet@f2000 {
+		};
+
+		mdio@fc000 {
+			interrupts = <100 1 0 0>;
+		};
+
+		mdio@fd000 {
+			interrupts = <101 1 0 0>;
+		};
+	};
+
 	L2_1: l2-cache-controller@c20000 {
 		/* Cluster 0 L2 cache */
 		compatible = "fsl,t2080-l2-cache-controller";
diff --git a/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi b/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
index e71ceb0..c2e5720 100644
--- a/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
@@ -51,6 +51,17 @@
 		serial3 = &serial3;
 
 		crypto = &crypto;
+
+		fman0 = &fman0;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		ethernet4 = &enet4;
+		ethernet5 = &enet5;
+		ethernet6 = &enet6;
+		ethernet7 = &enet7;
+
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index 5ef5ff0..21fce60 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * T4240 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2012 - 2014 Freescale Semiconductor Inc.
+ * Copyright 2012 - 2015 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -1088,6 +1088,92 @@
 /include/ "qoriq-qman3.dtsi"
 /include/ "qoriq-bman1.dtsi"
 
+/include/ "qoriq-fman3-0.dtsi"
+/include/ "qoriq-fman3-0-1g-0.dtsi"
+/include/ "qoriq-fman3-0-1g-1.dtsi"
+/include/ "qoriq-fman3-0-1g-2.dtsi"
+/include/ "qoriq-fman3-0-1g-3.dtsi"
+/include/ "qoriq-fman3-0-1g-4.dtsi"
+/include/ "qoriq-fman3-0-1g-5.dtsi"
+/include/ "qoriq-fman3-0-10g-0.dtsi"
+/include/ "qoriq-fman3-0-10g-1.dtsi"
+	fman@400000 {
+		enet0: ethernet@e0000 {
+		};
+
+		enet1: ethernet@e2000 {
+		};
+
+		enet2: ethernet@e4000 {
+		};
+
+		enet3: ethernet@e6000 {
+		};
+
+		enet4: ethernet@e8000 {
+		};
+
+		enet5: ethernet@ea000 {
+		};
+
+		enet6: ethernet@f0000 {
+		};
+
+		enet7: ethernet@f2000 {
+		};
+
+		mdio@fc000 {
+			status = "disabled";
+		};
+
+		mdio@fd000 {
+			status = "disabled";
+		};
+	};
+
+/include/ "qoriq-fman3-1.dtsi"
+/include/ "qoriq-fman3-1-1g-0.dtsi"
+/include/ "qoriq-fman3-1-1g-1.dtsi"
+/include/ "qoriq-fman3-1-1g-2.dtsi"
+/include/ "qoriq-fman3-1-1g-3.dtsi"
+/include/ "qoriq-fman3-1-1g-4.dtsi"
+/include/ "qoriq-fman3-1-1g-5.dtsi"
+/include/ "qoriq-fman3-1-10g-0.dtsi"
+/include/ "qoriq-fman3-1-10g-1.dtsi"
+	fman@500000 {
+		enet8: ethernet@e0000 {
+		};
+
+		enet9: ethernet@e2000 {
+		};
+
+		enet10: ethernet@e4000 {
+		};
+
+		enet11: ethernet@e6000 {
+		};
+
+		enet12: ethernet@e8000 {
+		};
+
+		enet13: ethernet@ea000 {
+		};
+
+		enet14: ethernet@f0000 {
+		};
+
+		enet15: ethernet@f2000 {
+		};
+
+		mdio@fc000 {
+			interrupts = <100 1 0 0>;
+		};
+
+		mdio@fd000 {
+			interrupts = <101 1 0 0>;
+		};
+	};
+
 	L2_1: l2-cache-controller@c20000 {
 		compatible = "fsl,t4240-l2-cache-controller";
 		reg = <0xc20000 0x40000>;
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
index 261a3abb..1184a74 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
@@ -1,7 +1,7 @@
 /*
  * T4240 Silicon/SoC Device Tree Source (pre include)
  *
- * Copyright 2012 Freescale Semiconductor Inc.
+ * Copyright 2012 - 2015 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -51,6 +51,7 @@
 		serial2 = &serial2;
 		serial3 = &serial3;
 		crypto = &crypto;
+
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
@@ -59,6 +60,25 @@
 		dma1 = &dma1;
 		dma2 = &dma2;
 		sdhc = &sdhc;
+
+		fman0 = &fman0;
+		fman1 = &fman1;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		ethernet4 = &enet4;
+		ethernet5 = &enet5;
+		ethernet6 = &enet6;
+		ethernet7 = &enet7;
+		ethernet8 = &enet8;
+		ethernet9 = &enet9;
+		ethernet10 = &enet10;
+		ethernet11 = &enet11;
+		ethernet12 = &enet12;
+		ethernet13 = &enet13;
+		ethernet14 = &enet14;
+		ethernet15 = &enet15;
 	};
 
 	cpus {
-- 
2.3.0
