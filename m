Return-Path: <B32579@freescale.com>
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree-discuss@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx:DTS: Fix PCIe IDSEL for Px020RDB
Date: Wed, 20 Apr 2011 09:42:44 +0530
Message-ID: <1303272764-15333-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: meet2prabhu@gmail.com, Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PCIe device in legacy mode can trigger interrupts using the wires #INTA, #INTB
,#INTC and #INTD. PCI devices are obligated to use #INTx for interrupts under
legacy mode.  Each PCI slot or device is typically wired to different inputs on
the interrupt controller. 

So, Define interrupt-map and interrupt-map-mask properties for device tree to
of map each PCI interrupt signal to the inputs of the interrupt controller.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branch master)

 This patch has depedency on following 2 patches
 	-- powerpc/85xx: P2020 DTS: re-organize dts files
	-- powerpc/85xx: P1020 DTS : re-organize dts files

 arch/powerpc/boot/dts/p1020rdb.dts            |   16 ++++++++++++++++
 arch/powerpc/boot/dts/p2020rdb.dts            |   16 ++++++++++++++++
 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts |    8 ++++++++
 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts |    8 ++++++++
 4 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1020rdb.dts b/arch/powerpc/boot/dts/p1020rdb.dts
index 7ed4793..d6a8ae4 100644
--- a/arch/powerpc/boot/dts/p1020rdb.dts
+++ b/arch/powerpc/boot/dts/p1020rdb.dts
@@ -257,6 +257,14 @@
 	pci0: pcie@ffe09000 {
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x4 0x1
+			0000 0x0 0x0 0x2 &mpic 0x5 0x1
+			0000 0x0 0x0 0x3 &mpic 0x6 0x1
+			0000 0x0 0x0 0x4 &mpic 0x7 0x1
+			>;
 		pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
 			#size-cells = <2>;
@@ -275,6 +283,14 @@
 	pci1: pcie@ffe0a000 {
 		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x0 0x1
+			0000 0x0 0x0 0x2 &mpic 0x1 0x1
+			0000 0x0 0x0 0x3 &mpic 0x2 0x1
+			0000 0x0 0x0 0x4 &mpic 0x3 0x1
+			>;
 		pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
 			#size-cells = <2>;
diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/dts/p2020rdb.dts
index 60a0a8c..3782a58 100644
--- a/arch/powerpc/boot/dts/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/p2020rdb.dts
@@ -249,6 +249,14 @@
 	pci1: pcie@ffe09000 {
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x4 0x1
+			0000 0x0 0x0 0x2 &mpic 0x5 0x1
+			0000 0x0 0x0 0x3 &mpic 0x6 0x1
+			0000 0x0 0x0 0x4 &mpic 0x7 0x1
+			>;
 			pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
 			#size-cells = <2>;
@@ -267,6 +275,14 @@
 	pci2: pcie@ffe0a000 {
 		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x0 0x1
+			0000 0x0 0x0 0x2 &mpic 0x1 0x1
+			0000 0x0 0x0 0x3 &mpic 0x2 0x1
+			0000 0x0 0x0 0x4 &mpic 0x3 0x1
+			>;
 		pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
 			#size-cells = <2>;
diff --git a/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts b/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
index 72c912f..fc8dddd 100644
--- a/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
+++ b/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
@@ -175,6 +175,14 @@
 	pci1: pcie@ffe09000 {
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x4 0x1
+			0000 0x0 0x0 0x2 &mpic 0x5 0x1
+			0000 0x0 0x0 0x3 &mpic 0x6 0x1
+			0000 0x0 0x0 0x4 &mpic 0x7 0x1
+			>;
 		pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
 			#size-cells = <2>;
diff --git a/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts b/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
index eb572cc..261c34b 100644
--- a/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
+++ b/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
@@ -203,6 +203,14 @@
 	pci2: pcie@ffe0a000 {
 		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x0 0x1
+			0000 0x0 0x0 0x2 &mpic 0x1 0x1
+			0000 0x0 0x0 0x3 &mpic 0x2 0x1
+			0000 0x0 0x0 0x4 &mpic 0x3 0x1
+			>;
 		pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
 			#size-cells = <2>;
-- 
1.7.3
