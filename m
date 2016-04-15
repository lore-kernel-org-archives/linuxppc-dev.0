Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m1.elettra.trieste.it [140.105.206.201])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qmVv16S5GzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 18:24:08 +1000 (AEST)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [PATCH 1/1] powerpc/86xx: Set the right interrupt-cells for pcie nodes
Date: Fri, 15 Apr 2016 10:24:03 +0200
Message-Id: <1460708643-11204-1-git-send-email-alessio.bogani@elettra.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 595207b93fe4 ("powerpc/86xx: Update device tree") removes
wrongly #interrupt-cells from pcie nodes. Fix it letting these
come back to the right place.

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
 arch/powerpc/boot/dts/fsl/gef_sbc310.dts       | 1 +
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts     | 1 +
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts | 1 +
 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi  | 1 +
 arch/powerpc/boot/dts/fsl/sbc8641d.dts         | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/gef_sbc310.dts b/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
index 84b3d38..6856167 100644
--- a/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
+++ b/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
@@ -225,6 +225,7 @@
 	pci1: pcie@fef09000 {
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
+		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0xfef09000 0x1000>;
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
index 554001f..09e47a3 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
@@ -361,6 +361,7 @@
 	pci1: pcie@ffe09000 {
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
+		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0xffe09000 0x1000>;
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
index fec5867..9e5f4a6 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
@@ -328,6 +328,7 @@
 	pci1: pcie@fffe09000 {
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
+		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0x0f 0xffe09000 0x0 0x1000>;
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
index 70889d8..48d1bfc 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
@@ -97,6 +97,7 @@
 &pci0 {
 	compatible = "fsl,mpc8641-pcie";
 	device_type = "pci";
+	#interrupt-cells = <1>;
 	#size-cells = <2>;
 	#address-cells = <3>;
 	bus-range = <0x0 0xff>;
diff --git a/arch/powerpc/boot/dts/fsl/sbc8641d.dts b/arch/powerpc/boot/dts/fsl/sbc8641d.dts
index 0a9733c..efcad7c 100644
--- a/arch/powerpc/boot/dts/fsl/sbc8641d.dts
+++ b/arch/powerpc/boot/dts/fsl/sbc8641d.dts
@@ -167,6 +167,7 @@
 	pci1: pcie@f8009000 {
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
+		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0xf8009000 0x1000>;
-- 
2.8.0
