Return-Path: <B09055@freescale.com>
From: Dipen Dudhat <Dipen.Dudhat@freescale.com>
To: <devicetree-discuss@lists.ozlabs.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH][upstream] powerpc:Integrated Flash controller device tree
	bindings
Date: Thu, 19 May 2011 12:08:23 +0530
Message-ID: <1305787103-25105-1-git-send-email-Dipen.Dudhat@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@linux.freescale.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Dipen Dudhat <Dipen.Dudhat@freescale.com>
Acked-By: Scott Wood <scottwood@freescale.com>
---
Based upon git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git (branch -> master)
 .../devicetree/bindings/powerpc/fsl/ifc.txt        |   76 ++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/ifc.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/ifc.txt b/Documentation/devicetree/bindings/powerpc/fsl/ifc.txt
new file mode 100644
index 0000000..939a26d
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/ifc.txt
@@ -0,0 +1,76 @@
+Integrated Flash Controller
+
+Properties:
+- name : Should be ifc
+- compatible : should contain "fsl,ifc". The version of the integrated
+               flash controller can be found in the IFC_REV register at
+               offset zero.
+
+- #address-cells : Should be either two or three.  The first cell is the
+                   chipselect number, and the remaining cells are the
+                   offset into the chipselect.
+- #size-cells : Either one or two, depending on how large each chipselect
+                can be.
+- reg : Offset and length of the register set for the device
+- interrupts : IFC has two interrupts. The first one is the "common"
+               interrupt(CM_EVTER_STAT), and second is the NAND interrupt
+               (NAND_EVTER_STAT).
+
+- ranges : Each range corresponds to a single chipselect, and covers
+           the entire access window as configured.
+
+Child device nodes describe the devices connected to IFC such as NOR (e.g.
+cfi-flash) and NAND (fsl,ifc-nand). There might be board specific devices
+like FPGAs, CPLDs, etc.
+
+Example:
+
+	ifc@ffe1e000 {
+		compatible = "fsl,ifc", "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0x0 0xffe1e000 0 0x2000>;
+		interrupts = <16 2 19 2>;
+
+		/* NOR, NAND Flashes and CPLD on board */
+		ranges = <0x0 0x0 0x0 0xee000000 0x02000000
+			  0x1 0x0 0x0 0xffa00000 0x00010000
+			  0x3 0x0 0x0 0xffb00000 0x00020000>;
+
+		flash@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x2000000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			partition@0 {
+				/* 32MB for user data */
+				reg = <0x0 0x02000000>;
+				label = "NOR Data";
+			};
+		};
+
+		flash@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,ifc-nand";
+			reg = <0x1 0x0 0x10000>;
+
+			partition@0 {
+				/* This location must not be altered  */
+				/* 1MB for u-boot Bootloader Image */
+				reg = <0x0 0x00100000>;
+				label = "NAND U-Boot Image";
+				read-only;
+			};
+		};
+
+		cpld@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,p1010rdb-cpld";
+			reg = <0x3 0x0 0x000001f>;
+		};
+	};
-- 
1.5.6.5
