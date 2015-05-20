Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0148.outbound.protection.outlook.com [157.56.110.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 205611A060E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 22:42:58 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 1/4] powerpc/fsl-booke: Add T1023RDB QBMan device tree
Date: Wed, 20 May 2015 15:41:37 +0300
Message-ID: <1432125700-7024-2-git-send-email-madalin.bucur@freescale.com>
In-Reply-To: <1432125700-7024-1-git-send-email-madalin.bucur@freescale.com>
References: <1432125700-7024-1-git-send-email-madalin.bucur@freescale.com>
Reply-To: <madalin.bucur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Igal.Liberman@freescale.com, roy.pledge@freescale.com,
 Madalin Bucur <madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
---
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi | 109 ++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/t1023rdb.dts          |  29 ++++++++
 2 files changed, 138 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
index dbe6578..48c1690 100644
--- a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
@@ -32,6 +32,21 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+&bman_fbpr {
+	compatible = "fsl,bman-fbpr";
+	alloc-ranges = <0 0 0x10000 0>;
+};
+
+&qman_fqd {
+	compatible = "fsl,qman-fqd";
+	alloc-ranges = <0 0 0x10000 0>;
+};
+
+&qman_pfdr {
+	compatible = "fsl,qman-pfdr";
+	alloc-ranges = <0 0 0x10000 0>;
+};
+
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
@@ -178,6 +193,98 @@
 	};
 };
 
+&bportals {
+	#address-cells = <0x1>;
+	#size-cells = <0x1>;
+	compatible = "simple-bus";
+
+	bman-portal@0 {
+		cell-index = <0x0>;
+		compatible = "fsl,bman-portal";
+		reg = <0x0 0x4000>, <0x1000000 0x1000>;
+		interrupts = <105 2 0 0>;
+	};
+	bman-portal@4000 {
+		cell-index = <0x1>;
+		compatible = "fsl,bman-portal";
+		reg = <0x4000 0x4000>, <0x1001000 0x1000>;
+		interrupts = <107 2 0 0>;
+	};
+	bman-portal@8000 {
+		cell-index = <2>;
+		compatible = "fsl,bman-portal";
+		reg = <0x8000 0x4000>, <0x1002000 0x1000>;
+		interrupts = <109 2 0 0>;
+	};
+	bman-portal@c000 {
+		cell-index = <0x3>;
+		compatible = "fsl,bman-portal";
+		reg = <0xc000 0x4000>, <0x1003000 0x1000>;
+		interrupts = <111 2 0 0>;
+	};
+	bman-portal@10000 {
+		cell-index = <0x4>;
+		compatible = "fsl,bman-portal";
+		reg = <0x10000 0x4000>, <0x1004000 0x1000>;
+		interrupts = <113 2 0 0>;
+	};
+	bman-portal@14000 {
+		cell-index = <0x5>;
+		compatible = "fsl,bman-portal";
+		reg = <0x14000 0x4000>, <0x1005000 0x1000>;
+		interrupts = <115 2 0 0>;
+	};
+};
+
+&qportals {
+	#address-cells = <0x1>;
+	#size-cells = <0x1>;
+	compatible = "simple-bus";
+
+	qportal0: qman-portal@0 {
+		cell-index = <0x0>;
+		compatible = "fsl,qman-portal";
+		reg = <0x0 0x4000>, <0x1000000 0x1000>;
+		interrupts = <104 0x2 0 0>;
+		fsl,qman-channel-id = <0x0>;
+	};
+	qportal1: qman-portal@4000 {
+		cell-index = <0x1>;
+		compatible = "fsl,qman-portal";
+		reg = <0x4000 0x4000>, <0x1001000 0x1000>;
+		interrupts = <106 0x2 0 0>;
+		fsl,qman-channel-id = <0x1>;
+	};
+	qportal2: qman-portal@8000 {
+		cell-index = <0x2>;
+		compatible = "fsl,qman-portal";
+		reg = <0x8000 0x4000>, <0x1002000 0x1000>;
+		interrupts = <108 0x2 0 0>;
+		fsl,qman-channel-id = <0x2>;
+	};
+	qportal3: qman-portal@c000 {
+		cell-index = <0x3>;
+		compatible = "fsl,qman-portal";
+		reg = <0xc000 0x4000>, <0x1003000 0x1000>;
+		interrupts = <110 0x2 0 0>;
+		fsl,qman-channel-id = <0x3>;
+	};
+	qportal4: qman-portal@10000 {
+		cell-index = <0x4>;
+		compatible = "fsl,qman-portal";
+		reg = <0x10000 0x4000>, <0x1004000 0x1000>;
+		interrupts = <112 0x2 0 0>;
+		fsl,qman-channel-id = <0x4>;
+	};
+	qportal5: qman-portal@14000 {
+		cell-index = <0x5>;
+		compatible = "fsl,qman-portal";
+		reg = <0x14000 0x4000>, <0x1005000 0x1000>;
+		interrupts = <114 0x2 0 0>;
+		fsl,qman-channel-id = <0x5>;
+	};
+};
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -327,4 +434,6 @@ sata@220000 {
 };
 
 /include/ "qoriq-sec5.0-0.dtsi"
+/include/ "qoriq-qman3.dtsi"
+/include/ "qoriq-bman1.dtsi"
 };
diff --git a/arch/powerpc/boot/dts/t1023rdb.dts b/arch/powerpc/boot/dts/t1023rdb.dts
index 3780e68..571e070 100644
--- a/arch/powerpc/boot/dts/t1023rdb.dts
+++ b/arch/powerpc/boot/dts/t1023rdb.dts
@@ -41,6 +41,25 @@
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+		qman_fqd: qman-fqd {
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+		};
+		qman_pfdr: qman-pfdr {
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+		};
+	};
+
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
 		ranges = <0 0 0xf 0xe8000000 0x08000000
@@ -72,6 +91,14 @@
 		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x2000000>;
+	};
+
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
@@ -100,6 +127,7 @@
 
 		i2c@118100 {
 		};
+
 	};
 
 	pci0: pcie@ffe240000 {
@@ -149,3 +177,4 @@
 };
 
 /include/ "fsl/t1023si-post.dtsi"
+/include/ "fsl/qoriq-dpaa-res3.dtsi"
-- 
1.7.11.7
