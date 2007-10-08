Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E588ADE11D
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 07:08:41 +1000 (EST)
Date: Mon, 8 Oct 2007 16:08:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 3/3] mpc85xx: Add cpm nodes for 8541/8555 CDS
Message-ID: <20071008210852.GB24445@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071008210829.GA24428@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We don't use any CPM devices on these boards, but the muram node on these
chips is different from the 8560, so it's helpful to people working with
custom boards based on these chips.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/mpc8541cds.dts |   36 ++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8555cds.dts |   36 ++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 6633e07..f3f4d79 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -145,6 +145,42 @@
 			device_type = "open-pic";
                         big-endian;
 		};
+
+		cpm@919c0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8541-cpm", "fsl,cpm2";
+			reg = <919c0 30>;
+			ranges;
+
+			muram@80000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 80000 10000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 2000 9000 1000>;
+				};
+			};
+
+			brg@919f0 {
+				compatible = "fsl,mpc8541-brg",
+				             "fsl,cpm2-brg",
+				             "fsl,cpm-brg";
+				reg = <919f0 10 915f0 10>;
+			};
+
+			cpmpic: pic@90c00 {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				interrupts = <2e 2>;
+				interrupt-parent = <&mpic>;
+				reg = <90c00 80>;
+				compatible = "fsl,mpc8541-cpm-pic", "fsl,cpm2-pic";
+			};
+		};
 	};
 
 	pci1: pci@e0008000 {
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 9919929..57029cc 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -145,6 +145,42 @@
 			device_type = "open-pic";
                         big-endian;
 		};
+
+		cpm@919c0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8555-cpm", "fsl,cpm2";
+			reg = <919c0 30>;
+			ranges;
+
+			muram@80000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 80000 10000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 2000 9000 1000>;
+				};
+			};
+
+			brg@919f0 {
+				compatible = "fsl,mpc8555-brg",
+				             "fsl,cpm2-brg",
+				             "fsl,cpm-brg";
+				reg = <919f0 10 915f0 10>;
+			};
+
+			cpmpic: pic@90c00 {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				interrupts = <2e 2>;
+				interrupt-parent = <&mpic>;
+				reg = <90c00 80>;
+				compatible = "fsl,mpc8555-cpm-pic", "fsl,cpm2-pic";
+			};
+		};
 	};
 
 	pci1: pci@e0008000 {
-- 
1.5.3.4
