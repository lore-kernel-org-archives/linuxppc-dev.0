Return-Path: <b.zolnierkie@samsung.com>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DE301A0316
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 03:05:17 +1100 (AEDT)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O1Z02KIGAW17F20@mailout2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 04 Feb 2016 00:55:13 +0900 (KST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 b.zolnierkie@samsung.com
Subject: [RFT PATCH] powerpc: convert ppc6xx_defconfig to use libata PATA
 drivers
Date: Wed, 03 Feb 2016 16:50:27 +0100
Message-id: <1454514630-29269-21-git-send-email-b.zolnierkie@samsung.com>
In-reply-to: <1454514630-29269-1-git-send-email-b.zolnierkie@samsung.com>
References: <1454514630-29269-1-git-send-email-b.zolnierkie@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IDE subsystem has been deprecated since 2009 and the majority
(if not all) of Linux distributions have switched to use
libata for ATA support exclusively.  However there are still
some users (mostly old or/and embedded non-x86 systems) that
have not converted from using IDE subsystem to libata PATA
drivers.  This doesn't seem to be good thing in the long-term
for Linux as while there is less and less PATA systems left
in use:

* testing efforts are divided between two subsystems

* having duplicate drivers for same hardware confuses users

This patch converts ppc6xx_defconfig to use libata PATA
drivers.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/powerpc/configs/ppc6xx_defconfig | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index e5d2c3d..0d93067 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -378,13 +378,6 @@ CONFIG_EEPROM_AT24=m
 CONFIG_EEPROM_LEGACY=m
 CONFIG_EEPROM_MAX6875=m
 CONFIG_EEPROM_93CX6=m
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=m
-CONFIG_IDE_TASK_IOCTL=y
-# CONFIG_IDEPCI_PCIBUS_ORDER is not set
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_IDE_PMAC=y
-CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST=y
 CONFIG_RAID_ATTRS=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
@@ -411,13 +404,14 @@ CONFIG_ATA=y
 CONFIG_SATA_FSL=m
 CONFIG_PDC_ADMA=m
 CONFIG_ATA_PIIX=m
+CONFIG_PATA_MACIO=y
 CONFIG_PATA_MPC52xx=m
 CONFIG_PATA_OPTIDMA=m
 CONFIG_PATA_SCH=m
 CONFIG_PATA_VIA=m
 CONFIG_PATA_PLATFORM=m
 CONFIG_PATA_OF_PLATFORM=m
-CONFIG_ATA_GENERIC=m
+CONFIG_ATA_GENERIC=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=y
 CONFIG_MD_LINEAR=m
-- 
1.9.1
