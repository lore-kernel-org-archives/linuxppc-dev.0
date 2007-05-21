Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8E3E0DDE26
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 00:12:51 +1000 (EST)
Date: Mon, 21 May 2007 14:53:11 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] remove geometry support from ps3 storage driver
Message-ID: <20070521125311.GA27626@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The old ps3_storage driver did not support DOS geometry, so there is no
point to start adding code for it.

Signed-off-by: Olaf Hering <olaf@aepfle.de>


Index: linux-2.6.22-rc2/drivers/block/ps3disk.c
===================================================================
--- linux-2.6.22-rc2.orig/drivers/block/ps3disk.c
+++ linux-2.6.22-rc2/drivers/block/ps3disk.c
@@ -43,10 +43,6 @@
 
 #define KERNEL_SECTOR_SIZE	512
 
-// FIXME SCSI uses H=64, S=32. Can we still repartition disks partitioned using
-//       the old driver?
-#define PS3DISK_HEADS		255
-#define PS3DISK_SECTORS		63
 
 #define PS3DISK_NAME		"ps3d%c"
 
@@ -70,21 +66,11 @@ static int ps3disk_open(struct inode *in
 	return 0;
 }
 
-static int ps3disk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
-{
-	geo->heads = PS3DISK_HEADS;
-	geo->sectors = PS3DISK_SECTORS;
-	geo->cylinders = min(65535UL,
-			     get_capacity(bdev->bd_disk) /
-			     (PS3DISK_HEADS * PS3DISK_SECTORS));
-	return 0;
-}
 
 
 static struct block_device_operations ps3disk_fops = {
 	.owner		= THIS_MODULE,
 	.open		= ps3disk_open,
-	.getgeo		= ps3disk_getgeo,
 };
 
 static void ps3disk_scatter_gather(struct ps3_storage_device *dev,
