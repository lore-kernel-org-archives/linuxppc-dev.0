Return-Path: <bzolnier@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by ozlabs.org (Postfix) with ESMTP id 3BC3DDDEDD
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 11:30:23 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 68so3283355wra.13
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Feb 2008 16:30:22 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Fri, 08 Feb 2008 01:44:34 +0100
Message-Id: <20080208004434.17746.33986.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Subject: [PATCH 02/18] ide: fix ide_find_port()
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Instead of checking for '->io_ports[IDE_DATA_OFFSET] == 0' check for
  '->chipset == ide_unknown' when looking for an empty ide_hwifs[] slot.

* Do ide-pnp initialization after ide-generic when IDE is built-in
  (ide-pnp is the only user of ide_find_port() which needs such fixup).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Makefile |    2 +-
 drivers/ide/ide.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/Makefile
===================================================================
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -36,9 +36,9 @@ ifeq ($(CONFIG_BLK_DEV_CMD640), y)
 endif
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= cris/ ppc/
-obj-$(CONFIG_BLK_DEV_IDEPNP)		+= ide-pnp.o
 obj-$(CONFIG_IDE_H8300)			+= h8300/
 obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o
+obj-$(CONFIG_BLK_DEV_IDEPNP)		+= ide-pnp.o
 
 ide-cd_mod-y += ide-cd.o ide-cd_ioctl.o ide-cd_verbose.o
 
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -259,7 +259,7 @@ ide_hwif_t * ide_find_port(unsigned long
 
 	for (i = 0; i < MAX_HWIFS; i++) {
 		hwif = &ide_hwifs[i];
-		if (hwif->io_ports[IDE_DATA_OFFSET] == 0)
+		if (hwif->chipset == ide_unknown)
 			goto found;
 	}
 
