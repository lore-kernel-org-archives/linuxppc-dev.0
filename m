Return-Path: <bzolnier@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 5DD4DDDF02
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 11:30:17 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so79767wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Feb 2008 16:30:16 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Fri, 08 Feb 2008 01:44:27 +0100
Message-Id: <20080208004427.17746.14159.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Subject: [PATCH 01/18] ide-generic: set hwif->chipset
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

This hwif->chipset fixup is already present in ide_device_add_all()
but for warm-plug support we also need to reserve not currently present
interfaces.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-generic.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -23,7 +23,9 @@ static int __init ide_generic_init(void)
 	for (i = 0; i < MAX_HWIFS; i++) {
 		ide_hwif_t *hwif = &ide_hwifs[i];
 
-		if (hwif->io_ports[IDE_DATA_OFFSET] && !hwif->present)
+		if (hwif->io_ports[IDE_DATA_OFFSET] &&
+		    (hwif->chipset == ide_unknown ||
+		     hwif->chipset == ide_forced))
 			idx[i] = i;
 		else
 			idx[i] = 0xff;
