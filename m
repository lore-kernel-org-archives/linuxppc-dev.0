Return-Path: <b.zolnierkie@samsung.com>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 55A3D1A034E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 03:03:52 +1100 (AEDT)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O1Z007GNATOM100@mailout4.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 04 Feb 2016 00:53:48 +0900 (KST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 b.zolnierkie@samsung.com
Subject: [RFT PATCH] powerpc: convert cell_defconfig to use libata PATA drivers
Date: Wed, 03 Feb 2016 16:50:19 +0100
Message-id: <1454514630-29269-13-git-send-email-b.zolnierkie@samsung.com>
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

This patch converts cell_defconfig to use libata PATA drivers.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/powerpc/configs/cell_defconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index db328e6..679edaa 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -108,16 +108,15 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
-CONFIG_IDE=y
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_AEC62XX=y
-CONFIG_BLK_DEV_SIIMAGE=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=m
 CONFIG_CHR_DEV_SG=y
 CONFIG_ATA=y
 CONFIG_SATA_PROMISE=y
+CONFIG_PATA_ARTOP=y
 CONFIG_PATA_PDC2027X=m
+CONFIG_PATA_SIL680=y
+CONFIG_ATA_GENERIC=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=m
 CONFIG_MD_LINEAR=m
-- 
1.9.1
