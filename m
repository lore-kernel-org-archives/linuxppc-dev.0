Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-5.online-age.net (ext-cn0ut-5.online-age.net
	[63.210.253.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D1EE2DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 19:52:20 +1100 (EST)
Received: from int-cn0ut-7.online-age.net (int-cn0ut-7.online-age.net
	[3.159.252.76])
	by ext-cn0ut-5.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id mAK8qGSw013979
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 03:52:16 -0500
Received: from cinmlip01.e2k.ad.ge.com (int-cn0ut-7.online-age.net
	[3.159.252.76])
	by int-cn0ut-7.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id mAK8qEh1027186
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 03:52:16 -0500
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH] powerpc: Add use of Epson RTX-8581 RTC to GE Fanuc SBC610 dts
To: linuxppc-dev@ozlabs.org
Date: Thu, 20 Nov 2008 08:52:09 +0000
Message-ID: <20081120085207.6545.48588.stgit@ubuntu8041>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adding use of newly added Epson RTX-8581 real-time clock driver to GE
Fanuc SBC610's dts file and adding driver to default config.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_sbc610.dts           |    5 +++++
 arch/powerpc/configs/86xx/gef_sbc610_defconfig |    8 ++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index c046190..ed230bf 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -146,6 +146,11 @@
 			interrupt-parent = <&mpic>;
 			dfsrr;
 
+			rtc@51 {
+				compatible = "epson,rx8581";
+				reg = <0x00000051>;
+			};
+
 			eti@6b {
 				compatible = "dallas,ds1682";
 				reg = <0x6b>;
diff --git a/arch/powerpc/configs/86xx/gef_sbc610_defconfig b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
index 771b671..2e78ff4 100644
--- a/arch/powerpc/configs/86xx/gef_sbc610_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
@@ -1398,8 +1398,11 @@ CONFIG_USB_STORAGE=y
 # CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
 # CONFIG_EDAC is not set
-CONFIG_RTC_LIB=m
-CONFIG_RTC_CLASS=m
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
 
 #
 # RTC interfaces
@@ -1425,6 +1428,7 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_M41T80 is not set
 # CONFIG_RTC_DRV_S35390A is not set
 # CONFIG_RTC_DRV_FM3130 is not set
+CONFIG_RTC_DRV_RX8581=y
 
 #
 # SPI RTC drivers
