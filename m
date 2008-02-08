Return-Path: <bzolnier@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by ozlabs.org (Postfix) with ESMTP id C5735DDEC7
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 11:30:43 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 68so3283355wra.13
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Feb 2008 16:30:43 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Fri, 08 Feb 2008 01:44:55 +0100
Message-Id: <20080208004455.17746.44570.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Subject: [PATCH 05/18] ide: factor out cable detection from ide_init_port()
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

* Factor out cable detection from ide_init_port() to ide_port_cable_detect().

* Move ide_port_cable_detect() call to ide_device_add_all().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1364,7 +1364,10 @@ static void ide_init_port(ide_hwif_t *hw
 	/* call chipset specific routine for each enabled port */
 	if (d->init_hwif)
 		d->init_hwif(hwif);
+}
 
+static void ide_port_cable_detect(ide_hwif_t *hwif)
+{
 	if (hwif->cable_detect && (hwif->ultra_mask & 0x78)) {
 		if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 			hwif->cbl = hwif->cable_detect(hwif);
@@ -1392,6 +1395,7 @@ int ide_device_add_all(u8 *idx, const st
 		mate = (i & 1) ? NULL : hwif;
 
 		ide_init_port(hwif, i & 1, d);
+		ide_port_cable_detect(hwif);
 		ide_port_init_devices(hwif);
 	}
 
