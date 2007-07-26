Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 04702DDEA0
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 18:34:51 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6Q8YiCd004745
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 01:34:45 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6Q8YdH9022740
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 03:34:44 -0500 (CDT)
From: Zhang Wei <wei.zhang@freescale.com>
To: galak@kernel.crashing.org, mporter@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/5 v3] Add RapidIO OF-node to the MPC8641HPCN board dts file.
Date: Thu, 26 Jul 2007 16:42:49 +0800
Message-Id: <11854393741899-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11854393733580-git-send-email-wei.zhang@freescale.com>
References: <11854393721520-git-send-email-wei.zhang@freescale.com>
	<11854393733580-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add RapidIO OF-node to the MPC8641HPCN board dts file.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 5d82709..080ba8a 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -422,6 +422,19 @@
 				>;
 		};
 
+		rapidio@c0000 {
+			compatible = "fsl,rapidio-delta";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			reg = <c0000 20000>;
+			ranges = <0 0 c0000000 20000000>;
+			interrupt-parent = <&mpic>;
+			/* err_irq bell_outb_irq bell_inb_irq
+						msg1_tx_irq msg1_rx_irq
+						msg2_tx_irq msg2_rx_irq */
+			interrupts = <30 2 31 2 32 2 35 2 36 2 37 2 38 2>;
+		};
+
 		mpic: pic@40000 {
 			clock-frequency = <0>;
 			interrupt-controller;
-- 
1.5.1
