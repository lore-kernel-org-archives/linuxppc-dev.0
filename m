Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CAD2EDE072
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 20:10:24 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m2B9AB3p023112
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 02:10:13 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m2B99x2A028188
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 04:10:11 -0500 (CDT)
From: Zhang Wei <wei.zhang@freescale.com>
To: mporter@kernel.crashing.org, akpm@linux-foundation.org,
	galak@kernel.crashing.org
Subject: [PATCH 07/17] Add RapidIO node into MPC8641HPCN dts file
Date: Tue, 11 Mar 2008 17:07:48 +0800
Message-Id: <1205226478-7641-7-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <1205226478-7641-6-git-send-email-wei.zhang@freescale.com>
References: <1205226478-7641-1-git-send-email-wei.zhang@freescale.com>
	<1205226478-7641-2-git-send-email-wei.zhang@freescale.com>
	<1205226478-7641-3-git-send-email-wei.zhang@freescale.com>
	<1205226478-7641-4-git-send-email-wei.zhang@freescale.com>
	<1205226478-7641-5-git-send-email-wei.zhang@freescale.com>
	<1205226478-7641-6-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 79385bc..4b296af 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -26,6 +26,7 @@
 		serial1 = &serial1;
 		pci0 = &pci0;
 		pci1 = &pci1;
+		rapidio0 = &rapidio0;
 	};
 
 	cpus {
@@ -500,4 +501,15 @@
 				  0x0 0x00100000>;
 		};
 	};
+	rapidio0: rapidio@f80c0000 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "fsl,rapidio-delta";
+		reg = <0xf80c0000 0x20000>;
+		ranges = <0 0 0xc0000000 0 0x20000000>;
+		interrupt-parent = <&mpic>;
+		/* err_irq bell_outb_irq bell_inb_irq
+			msg1_tx_irq msg1_rx_irq	msg2_tx_irq msg2_rx_irq */
+		interrupts = <48 2 49 2 50 2 53 2 54 2 55 2 56 2>;
+	};
 };
-- 
1.5.4
