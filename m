Return-Path: <Zhiqiang.Hou@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0137.outbound.protection.outlook.com [207.46.100.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CF811A0C92
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 14:14:46 +1100 (AEDT)
From: Zhiqiang Hou <Zhiqiang.Hou@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>,
 <galak@kernel.crashing.org>, <benh@kernel.crashing.org>, <paulus@samba.org>,
 <mpe@ellerman.id.au>, <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
 <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <ijc+devicetree@hellion.org.uk>, <harninder.rai@freescale.com>
CC: <Minghuan.Lian@freescale.com>, <Mingkai.Hu@freescale.com>, Hou Zhiqiang
 <B48286@freescale.com>
Subject: [PATCH V3 1/2] powerpc/fsl: Add PCI node in device tree of bsc9132qds
Date: Thu, 5 Nov 2015 10:52:54 +0800
Message-ID: <1446691975-8965-1-git-send-email-Zhiqiang.Hou@freescale.com>
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

From: Harninder Rai <harninder.rai@freescale.com>

Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
Reviewed-by: Zang Tiefei-R61911 <tie-fei.zang@freescale.com>
Reviewed-by: Kushwaha Prabhakar-B32579 <prabhakar@freescale.com>
Reviewed-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
Tested-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
---
V3:
 - Remove gerrit stuff.
V2:
 - Remove property clock-frequency.

 arch/powerpc/boot/dts/bsc9132qds.dts          | 15 ++++++++++++++
 arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi | 28 +++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/bsc9132si-pre.dtsi  |  1 +
 3 files changed, 44 insertions(+)

diff --git a/arch/powerpc/boot/dts/bsc9132qds.dts b/arch/powerpc/boot/dts/bsc9132qds.dts
index 6cab106..940d719 100644
--- a/arch/powerpc/boot/dts/bsc9132qds.dts
+++ b/arch/powerpc/boot/dts/bsc9132qds.dts
@@ -29,6 +29,21 @@
 	soc: soc@ff700000 {
 		ranges = <0x0 0x0 0xff700000 0x100000>;
 	};
+
+	pci0: pcie@ff70a000 {
+		reg = <0 0xff70a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0x90000000 0 0x90000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xc0010000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0x90000000
+				  0x2000000 0x0 0x90000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
 };
 
 /include/ "bsc9132qds.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi b/arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi
index c723071..b5f0715 100644
--- a/arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi
@@ -40,6 +40,34 @@
 	interrupts = <16 2 0 0 20 2 0 0>;
 };
 
+/* controller at 0xa000 */
+&pci0 {
+	compatible = "fsl,bsc9132-pcie", "fsl,qoriq-pcie-v2.2";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0 255>;
+	interrupts = <16 2 0 0>;
+
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <16 2 0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x0 0x2 0x0 0x0
+			0000 0x0 0x0 0x2 &mpic 0x1 0x2 0x0 0x0
+			0000 0x0 0x0 0x3 &mpic 0x2 0x2 0x0 0x0
+			0000 0x0 0x0 0x4 &mpic 0x3 0x2 0x0 0x0
+			>;
+	};
+};
+
 &soc {
 	#address-cells = <1>;
 	#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/bsc9132si-pre.dtsi b/arch/powerpc/boot/dts/fsl/bsc9132si-pre.dtsi
index 301a9db..90f7949 100644
--- a/arch/powerpc/boot/dts/fsl/bsc9132si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/bsc9132si-pre.dtsi
@@ -45,6 +45,7 @@
 		serial0 = &serial0;
 		ethernet0 = &enet0;
 		ethernet1 = &enet1;
+		pci0 = &pci0;
 	};
 
 	cpus {
-- 
2.1.0.27.g96db324
