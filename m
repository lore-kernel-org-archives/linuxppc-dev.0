Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 75F32DDEAB
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 18:34:48 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6Q8Yhqw006829
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 01:34:43 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6Q8YdH7022740
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 03:34:42 -0500 (CDT)
From: Zhang Wei <wei.zhang@freescale.com>
To: galak@kernel.crashing.org, mporter@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/5 v3] Add the explanation and a sample of RapidIO OF node to
	the document of booting-without-of.txt file.
Date: Thu, 26 Jul 2007 16:42:48 +0800
Message-Id: <11854393733580-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11854393721520-git-send-email-wei.zhang@freescale.com>
References: <11854393721520-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the explanation and a sample of RapidIO OF node to the document of booting-without-of.txt file.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |   37 ++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 76733a3..d89b805 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1824,6 +1824,43 @@ platforms are moved over to use the flattened-device-tree model.
 		fsl,has-rstcr;
 	};
 
+   l) RapidIO
+
+   RapidIO is a definition of a system interconnect. This node add
+   the support for RapidIO processor in kernel. The node name is
+   suggested to be 'rapidio'.
+
+   Required properties:
+
+    - compatible : Using "fsl,rapidio-delta" for Freescale PowerPC
+      RapidIO controller.
+    - #address-cells : Address representation for "rapidio" devices.
+      This field represents the number of cells needed to represent
+      the RapidIO address of the registers.
+      See 1) above for more details on defining #address-cells.
+    - reg : Offset and length of the register set for the device
+    - ranges : Should be defined as specified in 1) to describe the
+      translation of addresses for memory mapped RapidIO memory
+      space.
+    - interrupts : binding interrupts for this device node,
+      please follow below orders:
+      <err_irq bell_outb_irq bell_inb_irq msg1_tx_irq msg1_rx_irq
+      msg2_tx_irq msg2_rx_irq ... msgN_tx_irq msgN_rx_irq>.
+
+  Example:
+
+	rapidio@c0000 {
+		compatible = "fsl,rapidio-delta";
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
1.5.1
