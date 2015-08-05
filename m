Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0126.outbound.protection.outlook.com [65.55.169.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F00CE1A1BFA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 17:45:31 +1000 (AEST)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC: <scottwood@freescale.com>, <madalin.bucur@freescale.com>,
 <shaohui.xie@freescale.com>, Igal Liberman <Igal.Liberman@freescale.com>
Subject: [v4, 2/2] powerpc/mpc85xx: Add FSL QorIQ DPAA FMan support to the SoC
 device tree(s)
Date: Wed, 5 Aug 2015 06:42:07 +0300
Message-ID: <1438746127-6176-1-git-send-email-igal.liberman@freescale.com>
Reply-To: <igal.liberman@freescale.com>
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

From: Igal Liberman <Igal.Liberman@freescale.com>

Based on prior work by Andy Fleming <afleming@freescale.com>

Signed-off-by: Shruti Kanetkar <Shruti@freescale.com>
Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
---

v3 ---> v4:
	- No changes in this patch

v2 ---> v3:
	- Removed P1023 support

v1 ---> v2:
	- Added T1024 support
	
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  |    9 ++-
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |   20 +++++-
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  |   12 +++-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |   31 +++++++++-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |   29 ++++++++-
 arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi  |   10 ++-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |   29 ++++++++-
 arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi  |   10 ++-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |   48 ++++++++++++++-
 arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi  |   15 ++++-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |   29 ++++++++-
 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi  |   10 ++-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi |   56 ++++++++++++++++-
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi  |   17 +++++-
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi |   19 ++++++
 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi  |    6 ++
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi |   31 ++++++++++
 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi  |    9 ++-
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi |   43 +++++++++++++
 arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi  |   11 ++++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |   88 ++++++++++++++++++++++++++-
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi  |   22 ++++++-
 22 files changed, 536 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
index 9cfeaef..5d54ec7 100644
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
index 26585d6..3065833 100644
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
@@ -271,6 +271,24 @@
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
index bc914f2..a738f7c 100644
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
index 164fdfc..d51e2bb 100644
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
@@ -465,6 +465,35 @@
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
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 9c16a16..872e448 100644
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
@@ -412,4 +412,31 @@ crypto: crypto@300000 {
 
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
index 0babd84..6318962 100644
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
index eeefc09..81bc75a 100644
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
@@ -439,4 +439,31 @@ crypto: crypto@300000 {
 
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
index 2b331b2..db92f11 100644
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
index b4403dd..4da49b6 100644
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
@@ -443,4 +443,50 @@ crypto: crypto@300000 {
 
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
index a3ea73c..0a7c65a 100644
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
index b77923a..cd008cd 100644
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
@@ -448,4 +448,31 @@
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
index f3b2188..2d74ea8 100644
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
index 8ba35ca..df694ec 100644
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
@@ -404,4 +404,58 @@
 
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
index a32e256..95f5c27 100644
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
diff --git a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
index 61aea79..858974a 100644
--- a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
@@ -311,4 +311,23 @@
 	};
 
 /include/ "qoriq-sec5.0-0.dtsi"
+
+/include/ "qoriq-fman3l-0.dtsi"
+/include/ "qoriq-fman3-0-10g-0-best-effort.dtsi"
+/include/ "qoriq-fman3-0-1g-1.dtsi"
+/include/ "qoriq-fman3-0-1g-2.dtsi"
+/include/ "qoriq-fman3-0-1g-3.dtsi"
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
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi b/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi
index cc52fa4..34f92cf 100644
--- a/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi
@@ -59,6 +59,12 @@
 		sdhc = &sdhc;
 
 		crypto = &crypto;
+
+		fman0 = &fman0;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
 	};
 
 	cpus {
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 6ebf311..b578af4 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -508,4 +508,35 @@
 /include/ "qoriq-sec5.0-0.dtsi"
 /include/ "qoriq-qman3.dtsi"
 /include/ "qoriq-bman1.dtsi"
+
+/include/ "qoriq-fman3l-0.dtsi"
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
index 74538ae..28a407a 100644
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
index 8bcdb35..cbb8a72 100644
--- a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
@@ -626,6 +626,49 @@
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
index 1b4139f..3f745de 100644
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
index a4b4a23..3455017 100644
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
@@ -1057,6 +1057,92 @@
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
index ae6752d..b817aef 100644
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
1.7.9.5
