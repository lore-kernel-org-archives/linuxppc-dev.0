Return-Path: <Paul.Gortmaker@windriver.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9BC6BB7DEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 01:08:54 +1000 (EST)
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail7.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5C00ADDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 01:08:51 +1000 (EST)
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id n7CDYrMd025219
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 06:34:53 -0700 (PDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] Add localbus node and MTD partitions for SBC834x
Date: Wed, 12 Aug 2009 09:34:29 -0400
Message-Id: <22f17c810cb3e567a842300c553121a574d9b139.1250036189.git.paul.gortmaker@windriver.com>
In-Reply-To: <87b9869d069308d2ed12324ea924e284c85a6765.1250036189.git.paul.gortmaker@windriver.com>
References: <1250084071-26418-1-git-send-email-paul.gortmaker@windriver.com>
	<87b9869d069308d2ed12324ea924e284c85a6765.1250036189.git.paul.gortmaker@windriver.com>
In-Reply-To: <87b9869d069308d2ed12324ea924e284c85a6765.1250036189.git.paul.gortmaker@windriver.com>
References: <87b9869d069308d2ed12324ea924e284c85a6765.1250036189.git.paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Liang Li <liang.li@windriver.com>

There is 8MB flash, 8kB EEPROM and 128MB SDRAM on the sbc834x
local bus, so add a localbus node in DTS with MTD partitions.

The recent U-boot commit fe613cdd4eb moves u-boot to the beginning
of flash, hence the legacy label on the partition at the end of flash.

Signed-off-by: Liang Li <liang.li@windriver.com>
Signed-off-by: Yang Shi <yang.shi@windriver.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8349.dts |   40 +++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sbc8349.dts
index d93e5be..b83036a 100644
--- a/arch/powerpc/boot/dts/sbc8349.dts
+++ b/arch/powerpc/boot/dts/sbc8349.dts
@@ -265,6 +265,46 @@
 		};
 	};
 
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8349-localbus", "simple-bus";
+		reg = <0xe0005000 0x1000>;
+		interrupts = <77 0x8>;
+		interrupt-parent = <&ipic>;
+		ranges = <0x0 0x0 0xff800000 0x00800000		/* 8MB Flash */
+			  0x1 0x0 0xf8000000 0x00002000		/* 8KB EEPROM */
+			  0x2 0x0 0x10000000 0x04000000		/* 64MB SDRAM */
+			  0x3 0x0 0x10000000 0x04000000>;	/* 64MB SDRAM */
+
+		flash@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "intel,28F640J3A", "cfi-flash";
+			reg = <0x0 0x0 0x800000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			partition@0 {
+				label = "u-boot";
+				reg = <0x00000000 0x00040000>;
+				read-only;
+			};
+
+			partition@40000 {
+				label = "user";
+				reg = <0x00040000 0x006c0000>;
+			};
+
+			partition@700000 {
+				label = "legacy u-boot";
+				reg = <0x00700000 0x00100000>;
+				read-only;
+			};
+
+		};
+	};
+
 	pci0: pci@e0008500 {
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
-- 
1.6.3.3
