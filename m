Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8E0B0B7214
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 01:18:30 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAHEIQlK009787
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 08:18:27 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Update SRIO device tree nodes
Date: Thu, 17 Nov 2011 08:18:25 -0600
Message-Id: <1321539505-2175-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update all dts files that support SRIO controllers to match the new
fsl,srio device tree binding.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi |   25 +++++----
 arch/powerpc/boot/dts/fsl/mpc8569si-post.dtsi |   28 +++++++---
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi   |   20 +++++++
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi   |   20 +++++++
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi   |   26 ++++++---
 arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi    |    2 -
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi   |   20 +++++++
 arch/powerpc/boot/dts/fsl/pq3-rmu-0.dtsi      |   68 ++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8568mds.dts          |    4 +-
 arch/powerpc/boot/dts/mpc8569mds.dts          |    7 ++-
 arch/powerpc/boot/dts/mpc8641_hpcn.dts        |   69 +++++++++++++++++++-----
 arch/powerpc/boot/dts/p2041rdb.dts            |   11 ++++
 arch/powerpc/boot/dts/p3041ds.dts             |   11 ++++
 arch/powerpc/boot/dts/p4080ds.dts             |   12 +++-
 arch/powerpc/boot/dts/p5020ds.dts             |   11 ++++
 15 files changed, 285 insertions(+), 49 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-rmu-0.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi
index 6a9cca8..64e7075 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi
@@ -82,18 +82,19 @@
 };
 
 &rio {
+	compatible = "fsl,srio";
+	interrupts = <48 2 0 0>;
 	#address-cells = <2>;
 	#size-cells = <2>;
-	compatible = "fsl,mpc8568-rapidio", "fsl,rapidio-delta";
-	interrupts = <48 2 0 0 /* error     */
-		      49 2 0 0 /* bell_outb */
-		      50 2 0 0 /* bell_inb  */
-		      53 2 0 0 /* msg1_tx   */
-		      54 2 0 0 /* msg1_rx   */
-		      55 2 0 0 /* msg2_tx   */
-		      56 2 0 0 /* msg2_rx   */>;
-	sleep = <&pmc 0x00080000   /* controller */
-		 &pmc 0x00040000>; /* message unit */
+	fsl,srio-rmu-handle = <&rmu>;
+	sleep = <&pmc 0x00080000>;
+	ranges;
+
+	port1 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <1>;
+	};
 };
 
 &soc {
@@ -178,6 +179,10 @@
 	};
 
 /include/ "pq3-mpic.dtsi"
+/include/ "pq3-rmu-0.dtsi"
+	rmu@d3000 {
+		sleep = <&pmc 0x00040000>;
+	};
 
 	global-utilities@e0000 {
 		#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/mpc8569si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8569si-post.dtsi
index eb75a18..3e6346a 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8569si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8569si-post.dtsi
@@ -70,17 +70,25 @@
 };
 
 &rio {
+	compatible = "fsl,srio";
+	interrupts = <48 2 0 0>;
 	#address-cells = <2>;
 	#size-cells = <2>;
-	compatible = "fsl,mpc8569-rapidio", "fsl,rapidio-delta";
-	interrupts = <48 2 0 0 /* error     */
-		      49 2 0 0 /* bell_outb */
-		      50 2 0 0 /* bell_inb  */
-		      53 2 0 0 /* msg1_tx   */
-		      54 2 0 0 /* msg1_rx   */
-		      55 2 0 0 /* msg2_tx   */
-		      56 2 0 0 /* msg2_rx   */>;
+	fsl,srio-rmu-handle = <&rmu>;
 	sleep = <&pmc 0x00080000>;
+	ranges;
+
+	port1 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <1>;
+	};
+
+	port2 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <2>;
+	};
 };
 
 &soc {
@@ -159,6 +167,10 @@
 	};
 
 /include/ "pq3-mpic.dtsi"
+/include/ "pq3-rmu-0.dtsi"
+	rmu@d3000 {
+		sleep = <&pmc 0x00040000>;
+	};
 
 	global-utilities@e0000 {
 		#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 8d037cf..234a399 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -120,6 +120,26 @@
 	};
 };
 
+&rio {
+	compatible = "fsl,srio";
+	interrupts = <16 2 1 11>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+
+	port1 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <1>;
+	};
+
+	port2 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <2>;
+	};
+};
+
 &dcsr {
 	#address-cells = <1>;
 	#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index 9cda481..d41d08d 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -147,6 +147,26 @@
 	};
 };
 
+&rio {
+	compatible = "fsl,srio";
+	interrupts = <16 2 1 11>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+
+	port1 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <1>;
+	};
+
+	port2 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <2>;
+	};
+};
+
 &dcsr {
 	#address-cells = <1>;
 	#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index 1510991..8d35d2c 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -121,17 +121,24 @@
 };
 
 &rio {
+	compatible = "fsl,srio";
+	interrupts = <16 2 1 11>;
 	#address-cells = <2>;
 	#size-cells = <2>;
-	compatible = "fsl,rapidio-delta";
-	interrupts = <
-		16 2 1 11 /* err_irq */
-		56 2 0 0  /* bell_outb_irq */
-		57 2 0 0  /* bell_inb_irq */
-		60 2 0 0  /* msg1_tx_irq */
-		61 2 0 0  /* msg1_rx_irq */
-		62 2 0 0  /* msg2_tx_irq */
-		63 2 0 0>; /* msg2_rx_irq */
+	fsl,srio-rmu-handle = <&rmu>;
+	ranges;
+
+	port1 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <1>;
+	};
+
+	port2 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <2>;
+	};
 };
 
 &dcsr {
@@ -280,6 +287,7 @@
 			16 2 1 30>;
 	};
 
+/include/ "qoriq-rmu-0.dtsi"
 /include/ "qoriq-mpic.dtsi"
 
 	guts: global-utilities@e0000 {
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
index b353ac9..b9556ee 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
@@ -69,8 +69,6 @@
 		rtic_c = &rtic_c;
 		rtic_d = &rtic_d;
 		sec_mon = &sec_mon;
-
-		rio0 = &rapidio0;
 	};
 
 	cpus {
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index 7135c67..914074b 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -147,6 +147,26 @@
 	};
 };
 
+&rio {
+	compatible = "fsl,srio";
+	interrupts = <16 2 1 11>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+
+	port1 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <1>;
+	};
+
+	port2 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <2>;
+	};
+};
+
 &dcsr {
 	#address-cells = <1>;
 	#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/pq3-rmu-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-rmu-0.dtsi
new file mode 100644
index 0000000..587ca9f
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-rmu-0.dtsi
@@ -0,0 +1,68 @@
+/*
+ * PQ3 RIO Message Unit device tree stub [ controller @ offset 0xd3000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+rmu: rmu@d3000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,srio-rmu";
+	reg = <0xd3000 0x500>;
+	ranges = <0x0 0xd3000 0x500>;
+
+	message-unit@0 {
+		compatible = "fsl,srio-msg-unit";
+		reg = <0x0 0x100>;
+		interrupts = <
+			53 2 0 0 /* msg1_tx_irq */
+			54 2 0 0>;/* msg1_rx_irq */
+	};
+	message-unit@100 {
+		compatible = "fsl,srio-msg-unit";
+		reg = <0x100 0x100>;
+		interrupts = <
+			55 2 0 0  /* msg2_tx_irq */
+			56 2 0 0>;/* msg2_rx_irq */
+	};
+	doorbell-unit@400 {
+		compatible = "fsl,srio-dbell-unit";
+		reg = <0x400 0x80>;
+		interrupts = <
+			49 2 0 0  /* bell_outb_irq */
+			50 2 0 0>;/* bell_inb_irq */
+	};
+	port-write-unit@4e0 {
+		compatible = "fsl,srio-port-write-unit";
+		reg = <0x4e0 0x20>;
+		interrupts = <48 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 02eaad3..09598bb 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -297,7 +297,9 @@
 
 	rio: rapidio@e00c00000 {
 		reg = <0x0 0xe00c0000 0x0 0x20000>;
-		ranges = <0x0 0x0 0x0 0xc0000000 0x0 0x20000000>;
+		port1 {
+			ranges = <0x0 0x0 0x0 0xc0000000 0x0 0x20000000>;
+		};
 	};
 
 	leds {
diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
index 976a7f9..7e283c8 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/mpc8569mds.dts
@@ -440,7 +440,12 @@
 
 	rio: rapidio@e00c00000 {
 		reg = <0x0 0xe00c0000 0x0 0x20000>;
-		ranges = <0x0 0x0 0x0 0xc0000000 0x0 0x20000000>;
+		port1 {
+			ranges = <0x0 0x0 0x0 0xc0000000 0x0 0x20000000>;
+		};
+		port2 {
+			status = "disabled";
+		};
 	};
 };
 
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 848320e..fb8640e 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -26,13 +26,6 @@
 		serial1 = &serial1;
 		pci0 = &pci0;
 		pci1 = &pci1;
-/*
- * Only one of Rapid IO or PCI can be present due to HW limitations and
- * due to the fact that the 2 now share address space in the new memory
- * map.  The most likely case is that we have PCI, so comment out the
- * rapidio node.  Leave it here for reference.
- */
-		/* rapidio0 = &rapidio0; */
 	};
 
 	cpus {
@@ -361,6 +354,41 @@
 			device_type = "open-pic";
 		};
 
+		rmu: rmu@d3000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,srio-rmu";
+			reg = <0xd3000 0x500>;
+			ranges = <0x0 0xd3000 0x500>;
+
+			message-unit@0 {
+				compatible = "fsl,srio-msg-unit";
+				reg = <0x0 0x100>;
+				interrupts = <
+					53 2 /* msg1_tx_irq */
+					54 2>;/* msg1_rx_irq */
+			};
+			message-unit@100 {
+				compatible = "fsl,srio-msg-unit";
+				reg = <0x100 0x100>;
+				interrupts = <
+					55 2  /* msg2_tx_irq */
+					56 2>;/* msg2_rx_irq */
+			};
+			doorbell-unit@400 {
+				compatible = "fsl,srio-dbell-unit";
+				reg = <0x400 0x80>;
+				interrupts = <
+					49 2  /* bell_outb_irq */
+					50 2>;/* bell_inb_irq */
+			};
+			port-write-unit@4e0 {
+				compatible = "fsl,srio-port-write-unit";
+				reg = <0x4e0 0x20>;
+				interrupts = <48 2>;
+			};
+		};
+
 		global-utilities@e0000 {
 			compatible = "fsl,mpc8641-guts";
 			reg = <0xe0000 0x1000>;
@@ -612,16 +640,27 @@
 		};
 	};
 /*
-	rapidio0: rapidio@ffec0000 {
+ * Only one of Rapid IO or PCI can be present due to HW limitations and
+ * due to the fact that the 2 now share address space in the new memory
+ * map.  The most likely case is that we have PCI, so comment out the
+ * rapidio node.  Leave it here for reference.
+
+	rapidio@ffec0000 {
+		reg = <0xffec0000 0x11000>;
+		compatible = "fsl,srio";
+		interrupt-parent = <&mpic>;
+		interrupts = <48 2>;
 		#address-cells = <2>;
 		#size-cells = <2>;
-		compatible = "fsl,rapidio-delta";
-		reg = <0xffec0000 0x20000>;
-		ranges = <0 0 0x80000000 0 0x20000000>;
-		interrupt-parent = <&mpic>;
-		// err_irq bell_outb_irq bell_inb_irq
-		//	msg1_tx_irq msg1_rx_irq	msg2_tx_irq msg2_rx_irq
-		interrupts = <48 2 49 2 50 2 53 2 54 2 55 2 56 2>;
+		fsl,srio-rmu-handle = <&rmu>;
+		ranges;
+
+		port1 {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			cell-index = <1>;
+			ranges = <0 0 0x80000000 0 0x20000000>;
+		};
 	};
 */
 
diff --git a/arch/powerpc/boot/dts/p2041rdb.dts b/arch/powerpc/boot/dts/p2041rdb.dts
index d6ea24d..4f957db 100644
--- a/arch/powerpc/boot/dts/p2041rdb.dts
+++ b/arch/powerpc/boot/dts/p2041rdb.dts
@@ -108,6 +108,17 @@
 		};
 	};
 
+	rio: rapidio@ffe0c0000 {
+		reg = <0xf 0xfe0c0000 0 0x11000>;
+
+		port1 {
+			ranges = <0 0 0xc 0x20000000 0 0x10000000>;
+		};
+		port2 {
+			ranges = <0 0 0xc 0x30000000 0 0x10000000>;
+		};
+	};
+
 	lbc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x1000>;
 		ranges = <0 0 0xf 0xe8000000 0x08000000>;
diff --git a/arch/powerpc/boot/dts/p3041ds.dts b/arch/powerpc/boot/dts/p3041ds.dts
index 1053d69..f469145 100644
--- a/arch/powerpc/boot/dts/p3041ds.dts
+++ b/arch/powerpc/boot/dts/p3041ds.dts
@@ -101,6 +101,17 @@
 		};
 	};
 
+	rio: rapidio@ffe0c0000 {
+		reg = <0xf 0xfe0c0000 0 0x11000>;
+
+		port1 {
+			ranges = <0 0 0xc 0x20000000 0 0x10000000>;
+		};
+		port2 {
+			ranges = <0 0 0xc 0x30000000 0 0x10000000>;
+		};
+	};
+
 	lbc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x1000>;
 		ranges = <0 0 0xf 0xe8000000 0x08000000
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 8ea1ae9..6d60e54 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -108,9 +108,15 @@
 		};
 	};
 
-	rio: rapidio0: rapidio@ffe0c0000 {
-		reg = <0xf 0xfe0c0000 0 0x20000>;
-		ranges = <0 0 0xc 0x20000000 0 0x01000000>;
+	rio: rapidio@ffe0c0000 {
+		reg = <0xf 0xfe0c0000 0 0x11000>;
+
+		port1 {
+			ranges = <0 0 0xc 0x20000000 0 0x10000000>;
+		};
+		port2 {
+			ranges = <0 0 0xc 0x30000000 0 0x10000000>;
+		};
 	};
 
 	lbc: localbus@ffe124000 {
diff --git a/arch/powerpc/boot/dts/p5020ds.dts b/arch/powerpc/boot/dts/p5020ds.dts
index ceee4f5..1c25068 100644
--- a/arch/powerpc/boot/dts/p5020ds.dts
+++ b/arch/powerpc/boot/dts/p5020ds.dts
@@ -101,6 +101,17 @@
 		};
 	};
 
+	rio: rapidio@ffe0c0000 {
+		reg = <0xf 0xfe0c0000 0 0x11000>;
+
+		port1 {
+			ranges = <0 0 0xc 0x20000000 0 0x10000000>;
+		};
+		port2 {
+			ranges = <0 0 0xc 0x30000000 0 0x10000000>;
+		};
+	};
+
 	lbc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x1000>;
 		ranges = <0 0 0xf 0xe8000000 0x08000000
-- 
1.7.3.4
