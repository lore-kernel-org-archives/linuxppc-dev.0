Return-Path: <B07421@freescale.com>
Date: Thu, 24 Mar 2011 16:43:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc: Add fsl mpic timer binding
Message-ID: <20110324214315.GA9502@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the existing example in the general mpic binding to have a
separate TCRx region.  Currently the example doesn't describe TCRx at
all.  The one upstream device tree with an mpic timer node (p1022ds)
uses one large reg region to describe both, even though there are other
unrelated registers in between.  That device tree also contains a bogus
interrupt specifier, and there's no upstream software that uses this yet,
so changing this shouldn't be a problem.

Add a full binding for the MPIC timer node, not just an example of
4-cell interrupts in the MPIC binding.

Add fsl,available-ranges, similar to msi-available-ranges.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/mpic-timer.txt |   38 ++++++++++++++++++++
 .../devicetree/bindings/powerpc/fsl/mpic.txt       |    2 +-
 2 files changed, 39 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpic-timer.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpic-timer.txt b/Documentation/devicetree/bindings/powerpc/fsl/mpic-timer.txt
new file mode 100644
index 0000000..df41958
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/mpic-timer.txt
@@ -0,0 +1,38 @@
+* Freescale MPIC timers
+
+Required properties:
+- compatible: "fsl,mpic-global-timer"
+
+- reg : Contains two regions.  The first is the main timer register bank
+  (GTCCRxx, GTBCRxx, GTVPRxx, GTDRxx).  The second is the timer control
+  register (TCRx) for the group.
+
+- fsl,available-ranges: use <start count> style section to define which
+  timer interrupts can be used.  This property is optional; without this,
+  all timers within the group can be used.
+
+- interrupts: one interrupt per timer in the group, in order, starting
+  with timer zero.  If timer-available-ranges is present, only the
+  interrupts that correspond to available timers shall be present.
+
+Example:
+	/* Note that this requires #interrupt-cells to be 4 */
+	timer0: timer@41100 {
+		compatible = "fsl,mpic-global-timer";
+		reg = <0x41100 0x100 0x41300 4>;
+
+		/* Another AMP partition is using timers 0 and 1 */
+		fsl,available-ranges = <2 2>;
+
+		interrupts = <2 0 3 0
+		              3 0 3 0>;
+	};
+
+	timer1: timer@42100 {
+		compatible = "fsl,mpic-global-timer";
+		reg = <0x42100 0x100 0x42300 4>;
+		interrupts = <4 0 3 0
+		              5 0 3 0
+		              6 0 3 0
+		              7 0 3 0>;
+	};
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt b/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
index 8aa10f4..6af4b64 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
@@ -190,7 +190,7 @@ EXAMPLE 4
 	 */
 	timer0: timer@41100 {
 		compatible = "fsl,mpic-global-timer";
-		reg = <0x41100 0x100>;
+		reg = <0x41100 0x100 0x41300 4>;
 		interrupts = <0 0 3 0
 		              1 0 3 0
 		              2 0 3 0
-- 
1.7.1
