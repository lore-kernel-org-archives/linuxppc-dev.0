Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id CFD6ADDEB8
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 09:42:31 +1000 (EST)
Received: from pd3mr2so.prod.shaw.ca
	(pd3mr2so-qfe3.prod.shaw.ca [10.0.141.178]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JQ200A3LXS8KJF0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 17 Oct 2007 17:40:56 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd3mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQ200KCSXS7IQ00@pd3mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 17 Oct 2007 17:40:56 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQ200J1YXS62552@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 17 Oct 2007 17:40:55 -0600 (MDT)
Date: Wed, 17 Oct 2007 17:41:00 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] commit e8f605cd71aa09a8f8b73f410a15d2a46022a60e
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Message-id: <20071017234100.7729.85901.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

mpc8349emitx(gp): add UHCI and USB storage support

    USB support for the 8349itx got added a while back; but the defconfig
    never got updated.  This patch adds the appropriate USB config options
    to defconfig

    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
    CC: Scott Wood <scottwood@freescale.com>
    CC: Kumar Gala <galak@kernel.crashing.org>
    CC: Timur Tabi <timur@freescale.com>
---

 arch/powerpc/configs/mpc834x_itx_defconfig   |    2 -
 arch/powerpc/configs/mpc834x_itxgp_defconfig |   88 ++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/configs/mpc834x_itx_defconfig b/arch/powerpc/configs/mpc834x_itx_defconfig
index eb28dd8..ba512d1 100644
--- a/arch/powerpc/configs/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/mpc834x_itx_defconfig
@@ -867,7 +867,7 @@ CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_EHCI_FSL=y
 # CONFIG_USB_ISP116X_HCD is not set
 # CONFIG_USB_OHCI_HCD is not set
-# CONFIG_USB_UHCI_HCD is not set
+CONFIG_USB_UHCI_HCD=y
 # CONFIG_USB_SL811_HCD is not set
 # CONFIG_USB_R8A66597_HCD is not set
 
diff --git a/arch/powerpc/configs/mpc834x_itxgp_defconfig b/arch/powerpc/configs/mpc834x_itxgp_defconfig
index 22b9546..9faa948 100644
--- a/arch/powerpc/configs/mpc834x_itxgp_defconfig
+++ b/arch/powerpc/configs/mpc834x_itxgp_defconfig
@@ -760,15 +760,101 @@ CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
-# CONFIG_USB is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+# CONFIG_USB_DEVICEFS is not set
+CONFIG_USB_DEVICE_CLASS=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_SPLIT_ISO is not set
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
 CONFIG_USB_EHCI_FSL=y
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_OHCI_HCD is not set
+CONFIG_USB_UHCI_HCD=y
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
 
 #
+# may also be needed; see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=y
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+CONFIG_USB_MON=y
+
+#
+# USB port drivers
+#
+
+#
+# USB Serial Converter support
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGET is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+
+#
+# USB DSL modem support
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
