Return-Path: <bzolnier@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by ozlabs.org (Postfix) with ESMTP id 4D88BDDF9D
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 11:30:36 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 68so3283355wra.13
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Feb 2008 16:30:36 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Fri, 08 Feb 2008 01:44:48 +0100
Message-Id: <20080208004448.17746.71220.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Subject: [PATCH 04/18] ide-acpi: add missing drive->acpidata zeroing
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

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-acpi.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ide/ide-acpi.c
===================================================================
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -710,6 +710,8 @@ void ide_acpi_port_init_devices(ide_hwif
 	for (i = 0; i < MAX_DRIVES; i++) {
 		drive = &hwif->drives[i];
 
+		memset(drive->acpidata, 0, sizeof(*drive->acpidata));
+
 		if (!drive->present)
 			continue;
 
