Return-Path: <Paul.Gortmaker@windriver.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 49D3CB708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 01:08:23 +1000 (EST)
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail7.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0DCF3DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 01:08:20 +1000 (EST)
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id n7CDYqfR025216
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 06:34:52 -0700 (PDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] Remove second USB node from SBC834x DTS
Date: Wed, 12 Aug 2009 09:34:28 -0400
Message-Id: <87b9869d069308d2ed12324ea924e284c85a6765.1250036189.git.paul.gortmaker@windriver.com>
In-Reply-To: <1250084071-26418-1-git-send-email-paul.gortmaker@windriver.com>
References: <1250084071-26418-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Liang Li <liang.li@windriver.com>

Since only one of the SoC USB devices is brought out to a physical
connector on the board, remove the 2nd (USB-DR) node from the DTS.
Having it present and USB enabled will cause a hang at boot.

Signed-off-by: Liang Li <liang.li@windriver.com>
Signed-off-by: Yang Shi <yang.shi@windriver.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8349.dts |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sbc8349.dts
index 2d9fa68..d93e5be 100644
--- a/arch/powerpc/boot/dts/sbc8349.dts
+++ b/arch/powerpc/boot/dts/sbc8349.dts
@@ -146,18 +146,6 @@
 			phy_type = "ulpi";
 			port0;
 		};
-		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
-		usb@23000 {
-			device_type = "usb";
-			compatible = "fsl-usb2-dr";
-			reg = <0x23000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupt-parent = <&ipic>;
-			interrupts = <38 0x8>;
-			dr_mode = "otg";
-			phy_type = "ulpi";
-		};
 
 		enet0: ethernet@24000 {
 			#address-cells = <1>;
-- 
1.6.3.3
