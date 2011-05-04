Return-Path: <B31383@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 30930B6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 May 2011 23:27:14 +1000 (EST)
From: Ramneek Mehresh <ramneek.mehresh@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/qoriq: Add default mode for P1020RDB USB
Date: Wed, 4 May 2011 18:56:56 +0530
Message-ID: <1304515616-3413-1-git-send-email-ramneek.mehresh@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, Ramneek Mehresh <ramneek.mehresh@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add P1020 USB controller default value for "dr_mode" property

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
---
Applies on git://git.am.freescale.net/mirrors/linux-2.6.git
(branch master)
 arch/powerpc/boot/dts/p1020rdb.dts |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1020rdb.dts b/arch/powerpc/boot/dts/p1020rdb.dts
index e0668f8..c630b51 100644
--- a/arch/powerpc/boot/dts/p1020rdb.dts
+++ b/arch/powerpc/boot/dts/p1020rdb.dts
@@ -473,13 +473,11 @@
 			interrupt-parent = <&mpic>;
 			interrupts = <28 0x2>;
 			phy_type = "ulpi";
+			dr_mode = "host";
 		};
 
-		/* USB2 is shared with localbus, so it must be disabled
-		   by default. We can't put 'status = "disabled";' here
-		   since U-Boot doesn't clear the status property when
-		   it enables USB2. OTOH, U-Boot does create a new node
-		   when there isn't any. So, just comment it out.
+		/* USB2 is shared with localbus. It is used
+		   only in case of SPI and SD boot*/
 		usb@23000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -488,8 +486,8 @@
 			interrupt-parent = <&mpic>;
 			interrupts = <46 0x2>;
 			phy_type = "ulpi";
+			dr_mode = "host";
 		};
-		*/
 
 		sdhci@2e000 {
 			compatible = "fsl,p1020-esdhc", "fsl,esdhc";
-- 
1.6.1
