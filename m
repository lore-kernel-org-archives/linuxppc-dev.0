Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m1.elettra.trieste.it [140.105.206.201])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qmbdN6wgHzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 21:57:27 +1000 (AEST)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [PATCH v2 1/1] powerpc/86xx: Set the right interrupt-cells for pcie
 nodes
Date: Fri, 15 Apr 2016 13:57:22 +0200
Message-Id: <1460721442-6209-1-git-send-email-alessio.bogani@elettra.eu>
In-Reply-To: <1460708643-11204-1-git-send-email-alessio.bogani@elettra.eu>
References: <1460708643-11204-1-git-send-email-alessio.bogani@elettra.eu>
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
v1 -> v2
  Move #interrupt-cells on the pcie child-node
    to avoid 'of_irq_parse_pci() failed with rc=-22'

 arch/powerpc/boot/dts/fsl/gef_sbc310.dts       | 1 +
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts     | 1 +
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts | 1 +
 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi  | 1 +
 arch/powerpc/boot/dts/fsl/sbc8641d.dts         | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/gef_sbc310.dts b/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
index 84b3d38..9131c0a 100644
--- a/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
+++ b/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
@@ -243,6 +243,7 @@
 
 		pcie@0 {
 			reg = <0 0 0 0 0>;
+			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
index 554001f..712a7c6 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
@@ -379,6 +379,7 @@
 			>;
 		pcie@0 {
 			reg = <0 0 0 0 0>;
+			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
index fec5867..a724287 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
@@ -346,6 +346,7 @@
 			>;
 		pcie@0 {
 			reg = <0 0 0 0 0>;
+			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
index 70889d8..2b8752e 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
@@ -113,6 +113,7 @@
 
 	pcie@0 {
 		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		device_type = "pci";
diff --git a/arch/powerpc/boot/dts/fsl/sbc8641d.dts b/arch/powerpc/boot/dts/fsl/sbc8641d.dts
index 0a9733c..1fe73a8 100644
--- a/arch/powerpc/boot/dts/fsl/sbc8641d.dts
+++ b/arch/powerpc/boot/dts/fsl/sbc8641d.dts
@@ -186,6 +186,7 @@
 
 		pcie@0 {
 			reg = <0 0 0 0 0>;
+			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-- 
2.8.0
