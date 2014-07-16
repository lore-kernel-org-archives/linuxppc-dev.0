Return-Path: <Shruti@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 333A91A01D9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 06:31:47 +1000 (EST)
From: Shruti Kanetkar <Shruti@Freescale.com>
To: <scottwood@Freescale.com>
Subject: [PATCH v2 4/7] powerpc/corenet: Add DPAA FMan support to the SoC
 device tree(s)
Date: Wed, 16 Jul 2014 15:17:08 -0500
Message-ID: <1405541831-1277-4-git-send-email-Shruti@Freescale.com>
In-Reply-To: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
References: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shruti Kanetkar <Shruti@Freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FMan 1 Gb/s MACs (dTSEC and mEMAC) have support for SGMII PHYs.
Add support for the internal SerDes TBI PHYs

Based on prior work by Andy Fleming <afleming@gmail.com>

Signed-off-by: Shruti Kanetkar <Shruti@Freescale.com>
---
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  28 +++++
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |  51 +++++++++
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi |  14 +++
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |  64 ++++++++++++
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |  64 ++++++++++++
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 104 +++++++++++++++++++
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |  64 ++++++++++++
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 128 +++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 154 ++++++++++++++++++++++++++++
 9 files changed, 671 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
index 582381d..a60669e 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -168,6 +168,34 @@
 		compatible = "fsl,b4860-rcpm", "fsl,qoriq-rcpm-2.0";
 	};
 
+/include/ "qoriq-fman3-0-1g-4.dtsi"
+/include/ "qoriq-fman3-0-1g-5.dtsi"
+/include/ "qoriq-fman3-0-10g-0.dtsi"
+/include/ "qoriq-fman3-0-10g-1.dtsi"
+	fman@400000 {
+		ethernet@e8000 {
+			tbi-handle = <&tbi4>;
+		};
+
+		mdio@e9000 {
+			tbi4: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@ea000 {
+			tbi-handle = <&tbi5>;
+		};
+
+		mdio@eb000 {
+			tbi5: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+	};
+
 	L2: l2-cache-controller@c20000 {
 		compatible = "fsl,b4860-l2-cache-controller";
 	};
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index 1a54ba7..4cd4a31 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -261,6 +261,57 @@
 /include/ "qoriq-duart-1.dtsi"
 /include/ "qoriq-sec5.3-0.dtsi"
 
+/include/ "qoriq-fman3-0.dtsi"
+/include/ "qoriq-fman3-0-1g-0.dtsi"
+/include/ "qoriq-fman3-0-1g-1.dtsi"
+/include/ "qoriq-fman3-0-1g-2.dtsi"
+/include/ "qoriq-fman3-0-1g-3.dtsi"
+	fman@400000 {
+		ethernet@e0000 {
+			tbi-handle = <&tbi0>;
+		};
+
+		mdio@e1000 {
+			tbi0: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e2000 {
+			tbi-handle = <&tbi1>;
+		};
+
+		mdio@e3000 {
+			tbi1: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e4000 {
+			tbi-handle = <&tbi2>;
+		};
+
+		mdio@e5000 {
+			tbi2: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e6000 {
+			tbi-handle = <&tbi3>;
+		};
+
+		mdio@e7000 {
+			tbi3: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+	};
+
 	L2: l2-cache-controller@c20000 {
 		compatible = "fsl,b4-l2-cache-controller";
 		reg = <0xc20000 0x1000>;
diff --git a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
index 81437fd..01fd153 100644
--- a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
@@ -226,4 +226,18 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+	fman@100000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x100000 0x100000>;
+		compatible = "simple-bus";
+
+		mdio@e1120 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,fman-mdio";
+			reg = <0xe1120 0xee0>;
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 69ce102..6587d47 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -451,4 +451,68 @@
 crypto: crypto@300000 {
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
+		ethernet@e0000 {
+			tbi-handle = <&tbi0>;
+		};
+
+		mdio@e1120 {
+			tbi0: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e2000 {
+			tbi-handle = <&tbi1>;
+		};
+
+		mdio@e3120 {
+			tbi1: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e4000 {
+			tbi-handle = <&tbi2>;
+		};
+
+		mdio@e5120 {
+			tbi2: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e6000 {
+			tbi-handle = <&tbi3>;
+		};
+
+		mdio@e7120 {
+			tbi3: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e8000 {
+			tbi-handle = <&tbi4>;
+		};
+
+		mdio@e9120 {
+			tbi4: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index cd63cb1..43889c4 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -478,4 +478,68 @@
 crypto: crypto@300000 {
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
+		ethernet@e0000 {
+			tbi-handle = <&tbi0>;
+		};
+
+		mdio@e1120 {
+			tbi0: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e2000 {
+			tbi-handle = <&tbi1>;
+		};
+
+		mdio@e3120 {
+			tbi1: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e4000 {
+			tbi-handle = <&tbi2>;
+		};
+
+		mdio@e5120 {
+			tbi2: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e6000 {
+			tbi-handle = <&tbi3>;
+		};
+
+		mdio@e7120 {
+			tbi3: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e8000 {
+			tbi-handle = <&tbi4>;
+		};
+
+		mdio@e9120 {
+			tbi4: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index 12947cc..9a11fc2 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -534,4 +534,108 @@
 crypto: crypto@300000 {
 		fsl,iommu-parent = <&pamu1>;
 	};
+
+/include/ "qoriq-fman-0.dtsi"
+/include/ "qoriq-fman-0-1g-0.dtsi"
+/include/ "qoriq-fman-0-1g-1.dtsi"
+/include/ "qoriq-fman-0-1g-2.dtsi"
+/include/ "qoriq-fman-0-1g-3.dtsi"
+/include/ "qoriq-fman-0-10g-0.dtsi"
+	fman@400000 {
+		ethernet@e0000 {
+			tbi-handle = <&tbi0>;
+		};
+
+		mdio@e1120 {
+			tbi0: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e2000 {
+			tbi-handle = <&tbi1>;
+		};
+
+		mdio@e3120 {
+			tbi1: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e4000 {
+			tbi-handle = <&tbi2>;
+		};
+
+		mdio@e5120 {
+			tbi2: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e6000 {
+			tbi-handle = <&tbi3>;
+		};
+
+		mdio@e7120 {
+			tbi3: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
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
+		ethernet@e0000 {
+			tbi-handle = <&tbi5>;
+		};
+
+		mdio@e1120 {
+			tbi5: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e2000 {
+			tbi-handle = <&tbi6>;
+		};
+
+		mdio@e3120 {
+			tbi6: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e4000 {
+			tbi-handle = <&tbi7>;
+		};
+
+		mdio@e5120 {
+			tbi7: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e6000 {
+			tbi-handle = <&tbi8>;
+		};
+
+		mdio@e7120 {
+			tbi8: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index 4c4a2b0..221af7a 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -469,4 +469,68 @@
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
+		ethernet@e0000 {
+			tbi-handle = <&tbi0>;
+		};
+
+		mdio@e1120 {
+			tbi0: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e2000 {
+			tbi-handle = <&tbi1>;
+		};
+
+		mdio@e3120 {
+			tbi1: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e4000 {
+			tbi-handle = <&tbi2>;
+		};
+
+		mdio@e5120 {
+			tbi2: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e6000 {
+			tbi-handle = <&tbi3>;
+		};
+
+		mdio@e7120 {
+			tbi3: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e8000 {
+			tbi-handle = <&tbi4>;
+		};
+
+		mdio@e9120 {
+			tbi4: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index 67296fd..da4b523 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -443,4 +443,132 @@
 	crypto@300000 {
 		fsl,iommu-parent = <&pamu4>;
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
+		ethernet@e0000 {
+			tbi-handle = <&tbi0>;
+		};
+
+		mdio@e1120 {
+			tbi0: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e2000 {
+			tbi-handle = <&tbi1>;
+		};
+
+		mdio@e3120 {
+			tbi1: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e4000 {
+			tbi-handle = <&tbi2>;
+		};
+
+		mdio@e5120 {
+			tbi2: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e6000 {
+			tbi-handle = <&tbi3>;
+		};
+
+		mdio@e7120 {
+			tbi3: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e8000 {
+			tbi-handle = <&tbi4>;
+		};
+
+		mdio@e9120 {
+			tbi4: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
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
+		ethernet@e0000 {
+			tbi-handle = <&tbi5>;
+		};
+
+		mdio@e1120 {
+			tbi5: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e2000 {
+			tbi-handle = <&tbi6>;
+		};
+
+		mdio@e3120 {
+			tbi6: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e4000 {
+			tbi-handle = <&tbi7>;
+		};
+
+		mdio@e5120 {
+			tbi7: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e6000 {
+			tbi-handle = <&tbi8>;
+		};
+
+		mdio@e7120 {
+			tbi8: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e8000 {
+			tbi-handle = <&tbi9>;
+		};
+
+		mdio@e9120 {
+			tbi9: tbi-phy@8 {
+				reg = <8>;
+				device_type = "tbi-phy";
+			};
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index a3d582e..f885274 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -527,4 +527,158 @@
 		reg = <0xca0000 0x40000>;
 		next-level-cache = <&cpc>;
 	};
+
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
+		ethernet@e0000 {
+			tbi-handle = <&tbi0>;
+		};
+
+		mdio@e1000 {
+			tbi0: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e2000 {
+			tbi-handle = <&tbi1>;
+		};
+
+		mdio@e3000 {
+			tbi1: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e4000 {
+			tbi-handle = <&tbi2>;
+		};
+
+		mdio@e5000 {
+			tbi2: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e6000 {
+			tbi-handle = <&tbi3>;
+		};
+
+		mdio@e7000 {
+			tbi3: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e8000 {
+			tbi-handle = <&tbi4>;
+		};
+
+		mdio@e9000 {
+			tbi4: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@ea000 {
+			tbi-handle = <&tbi5>;
+		};
+
+		mdio@eb000 {
+			tbi5: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
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
+/include/ "qoriq-fman3-0-10g-1.dtsi"
+	fman@500000 {
+		ethernet@e0000 {
+			tbi-handle = <&tbi6>;
+		};
+
+		mdio@e1000 {
+			tbi6: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e2000 {
+			tbi-handle = <&tbi7>;
+		};
+
+		mdio@e3000 {
+			tbi7: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e4000 {
+			tbi-handle = <&tbi8>;
+		};
+
+		mdio@e5000 {
+			tbi8: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e6000 {
+			tbi-handle = <&tbi9>;
+		};
+
+		mdio@e7000 {
+			tbi9: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@e8000 {
+			tbi-handle = <&tbi10>;
+		};
+
+		mdio@e9000 {
+			tbi10: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		ethernet@ea000 {
+			tbi-handle = <&tbi11>;
+		};
+
+		mdio@eb000 {
+			tbi11: tbi-phy@8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+	};
 };
-- 
1.8.3.1
