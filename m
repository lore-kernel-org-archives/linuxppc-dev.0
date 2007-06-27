Return-Path: <wei.zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA11ADDF24
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 18:28:29 +1000 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: mporter@kernel.crashing.org
Subject: [PATCH 2/5 v2] Add RapidIO sector to the MPC8641HPCN board dts file.
Date: Wed, 27 Jun 2007 16:35:45 +0800
Message-Id: <11829333481375-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11829333481977-git-send-email-wei.zhang@freescale.com>
References: <11829333481420-git-send-email-wei.zhang@freescale.com>
	<11829333481977-git-send-email-wei.zhang@freescale.com>
Sender: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add RapidIO sector to the MPC8641HPCN board dts file.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 04626b1..abc9ff3 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -329,6 +329,19 @@
 				>;
 		};
 
+		srio@c0000 {
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
