Return-Path: <martyn.welch@gefanuc.com>
Received: from welchma.Radstone.Local (unknown [193.130.116.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E5517474D6
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 23:48:21 +1100 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH 2/2] powerpc: Enable watchdog timer on GE Fanuc's SBC610
To: linuxppc-dev@ozlabs.org
Date: Mon, 10 Nov 2008 12:29:33 +0000
Message-ID: <20081110122927.10813.36124.stgit@welchma.Radstone.Local>
In-Reply-To: <20081110122356.10813.29954.stgit@welchma.Radstone.Local>
References: <20081110122356.10813.29954.stgit@welchma.Radstone.Local>
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
