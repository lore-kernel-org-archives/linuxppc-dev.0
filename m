Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A3AECDDD07
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 20:20:38 +1100 (EST)
Date: Fri, 16 Feb 2007 10:20:46 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Jeff Garzik <jeff@garzik.org>, Paul Mackeras <paulus@samba.org>
Subject: [PATCH] use winbond libata instead of ide driver for pseries CD drives
Message-ID: <20070216092046.GA2572@aepfle.de>
References: <20070210203512.GA25586@aepfle.de>
	<20070210203614.GA25602@aepfle.de> <45D4E82B.7020403@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <45D4E82B.7020403@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Change the default for the built-in IDE on p610/p615/p630 from
ide to libata. libata has better error handling and the drive can
recover when hald does its CD media polling.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/configs/ppc64_defconfig   |    4 ++--
 arch/powerpc/configs/pseries_defconfig |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.20/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-2.6.20.orig/arch/powerpc/configs/ppc64_defconfig
+++ linux-2.6.20/arch/powerpc/configs/ppc64_defconfig
@@ -500,7 +500,7 @@ CONFIG_BLK_DEV_AMD74XX=y
 # CONFIG_BLK_DEV_PDC202XX_NEW is not set
 # CONFIG_BLK_DEV_SVWKS is not set
 # CONFIG_BLK_DEV_SIIMAGE is not set
-CONFIG_BLK_DEV_SL82C105=y
+# CONFIG_BLK_DEV_SL82C105 is not set
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
@@ -646,7 +646,7 @@ CONFIG_SATA_SVW=y
 # CONFIG_PATA_SIL680 is not set
 # CONFIG_PATA_SIS is not set
 # CONFIG_PATA_VIA is not set
-# CONFIG_PATA_WINBOND is not set
+CONFIG_PATA_WINBOND=y
 
 #
 # Multi-device support (RAID and LVM)
Index: linux-2.6.20/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux-2.6.20.orig/arch/powerpc/configs/pseries_defconfig
+++ linux-2.6.20/arch/powerpc/configs/pseries_defconfig
@@ -483,7 +483,7 @@ CONFIG_BLK_DEV_AMD74XX=y
 # CONFIG_BLK_DEV_PDC202XX_NEW is not set
 # CONFIG_BLK_DEV_SVWKS is not set
 # CONFIG_BLK_DEV_SIIMAGE is not set
-CONFIG_BLK_DEV_SL82C105=y
+# CONFIG_BLK_DEV_SL82C105 is not set
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
@@ -628,7 +628,7 @@ CONFIG_ATA=y
 # CONFIG_PATA_SIL680 is not set
 # CONFIG_PATA_SIS is not set
 # CONFIG_PATA_VIA is not set
-# CONFIG_PATA_WINBOND is not set
+CONFIG_PATA_WINBOND=y
 
 #
 # Multi-device support (RAID and LVM)
