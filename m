Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED172DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 16:15:37 +1100 (EST)
Date: Tue, 20 Nov 2007 23:13:58 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] [POWERPC] Add docs for Freescale RapidIO device tree node
In-Reply-To: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0711202313350.24220@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

---
 Documentation/powerpc/booting-without-of.txt |   47 ++++++++++++++++++++++++--
 1 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index eb14dd5..3d959d6 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2521,9 +2521,9 @@ platforms are moved over to use the flattened-device-tree model.

     Required properties:
     - compatible        : compatible list, contains 2 entries, first is
-			 "fsl,sata-CHIP", where CHIP is the processor
+			 "fsl,CHIP-sata", where CHIP is the processor
 			 (mpc8315, mpc8379, etc.) and the second is
-			 "fsl,sata-pq2pro"
+			 "fsl,pq2pro-sata"
     - interrupts        : <interrupt mapping for SATA IRQ>
     - interrupt-parent  : optional, if needed for interrupt mapping
     - reg               : <registers mapping>
@@ -2531,12 +2531,53 @@ platforms are moved over to use the flattened-device-tree model.
    Example:

 	sata@19000 {
-		compatible = "fsl,mpc8315-sata", "fsl,sata-pq2pro;
+		compatible = "fsl,mpc8315-sata", "fsl,pq2pro-sata;
 		reg = <19000 1000>;
 		interrupts = <2d 8>;
 		interrupt-parent = < &ipic >;
         };

+   * Frescale Serial RapidIO bus controller
+
+   RapidIO is a definition of a system interconnect. This node add
+   the support for RapidIO processor in kernel. The node name is
+   suggested to be 'rapidio'.
+
+   Required properties:
+
+    - compatible        : compatible list, contains 2 entries, first is
+			 "fsl,CHIP-rapidio", where CHIP is the processor
+			 (mpc8572, mpc8641, etc.) and the second is
+			 "fsl,delta-rapidio"
+    - interrupts	: interrupts are expected in the following
+			  order:
+      				* Error/port write
+				* Outbound Doorbell
+				* Inbound Doorbell
+				* Outbound Msg Unit 1
+				* Inbound Msg Unit 1
+				* Outbound Msg Unit 2
+				* Inbound Msg Unit 2
+    - interrupt-parent  : optional, if needed for interrupt mapping
+    - reg               : <registers mapping>
+    - #address-cells	: Should always be 2
+    - #size--cells	: Should always be 2
+    - ranges		: Details processor physical addr to RapidIO address
+
+  Example:
+
+	rapidio@c0000 {
+		compatible = "fsl,mpc8641-rapidio", "fsl,delta-rapidio;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <c0000 20000>;
+		ranges = <0 0 c0000000 20000000>;
+		interrupt-parent = <&mpic>;
+		/* err_irq bell_outb_irq bell_inb_irq msg1_tx_irq msg1_rx_irq
+						      msg2_tx_irq msg2_rx_irq */
+		interrupts = <30 2 31 2 32 2 35 2 36 2 37 2 38 2>;
+	};
+
    More devices will be defined as this spec matures.

 VII - Specifying interrupt information for devices
-- 
1.5.3.4
