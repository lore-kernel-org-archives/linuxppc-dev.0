Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-6.online-age.net (ext-cn0ut-6.online-age.net
	[63.210.253.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1A3BCDDED3
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 23:31:44 +1100 (EST)
Received: from int-cn0ut-3.online-age.net (int-cn0ut-3.online-age.net
	[3.159.252.72])
	by ext-cn0ut-6.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id mAACVgXI003713
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 07:31:40 -0500
Received: from cinmlip01.e2k.ad.ge.com (int-cn0ut-3.online-age.net
	[3.159.252.72])
	by int-cn0ut-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id mAACVeNn031355
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 07:31:40 -0500
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH 2/2] powerpc: Enable watchdog timer on GE Fanuc's SBC610
To: linuxppc-dev@ozlabs.org
Date: Mon, 10 Nov 2008 12:31:33 +0000
Message-ID: <20081110123131.8608.43231.stgit@ubuntu8041.localdomain>
In-Reply-To: <20081110123101.8608.352.stgit@ubuntu8041.localdomain>
References: <20081110123101.8608.352.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: wim@iguana.be, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Support for the FPGA based watchdog timer on GE Fanuc's SBC610.

This patch enables one of the watchdog timers found on the SBC610. There are
two identical watchdog timers at different offsets in the above mentioned
boards, however the current driver is only capable of supporting one of them.

The watchdog timers are also capable of generating interrupts at a
user-configurable threshold, though support for this operation is currently
not supported by the driver.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_sbc610.dts           |   15 +++++++++++++++
 arch/powerpc/configs/86xx/gef_sbc610_defconfig |    1 +
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index 1f7833c..2458690 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -88,6 +88,21 @@
 			compatible = "gef,fpga-regs";
 			reg = <0x4 0x0 0x40>;
 		};
+
+		wdt@4,2000 {
+			compatible = "gef,fpga-wdt";
+			reg = <0x4 0x2000 0x8>;
+			interrupts = <0x1a 0x4>;
+			interrupt-parent = <&gef_pic>;
+		};
+		/* Second watchdog available, driver currently supports one.
+		wdt@4,2010 {
+			compatible = "gef,fpga-wdt";
+			reg = <0x4 0x2010 0x8>;
+			interrupts = <0x1b 0x4>;
+			interrupt-parent = <&gef_pic>;
+		};
+		*/
 		gef_pic: pic@4,4000 {
 			#interrupt-cells = <1>;
 			interrupt-controller;
diff --git a/arch/powerpc/configs/86xx/gef_sbc610_defconfig b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
index 312d7af..99fe882 100644
--- a/arch/powerpc/configs/86xx/gef_sbc610_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
@@ -1109,6 +1109,7 @@ CONFIG_WATCHDOG=y
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
+CONFIG_GEF_WDT=y
 
 #
 # PCI-based Watchdog Cards
