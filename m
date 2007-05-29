Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 52097DDF05
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 16:06:57 +1000 (EST)
Date: Tue, 29 May 2007 16:06:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Fix viodasd geometry calculations.
Message-Id: <20070529160654.8e12e507.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit a885c8c4316e1c1d2d2c8755da3f3d14f852528d that introduced the
getgeo block device method changed the fallback number of sectors and
introduced a bug into the fallback cylinder number calculation.

Thanks to Rusty Russell for noticing this.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/block/viodasd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Paul, this is not too urgent as in most (all) cases the fallbacks will
not be taken.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/block/viodasd.c b/drivers/block/viodasd.c
index 68592c3..dae3991 100644
--- a/drivers/block/viodasd.c
+++ b/drivers/block/viodasd.c
@@ -252,10 +252,10 @@ static int viodasd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	struct gendisk *disk = bdev->bd_disk;
 	struct viodasd_device *d = disk->private_data;
 
-	geo->sectors = d->sectors ? d->sectors : 0;
+	geo->sectors = d->sectors ? d->sectors : 32;
 	geo->heads = d->tracks ? d->tracks  : 64;
 	geo->cylinders = d->cylinders ? d->cylinders :
-		get_capacity(disk) / (geo->cylinders * geo->heads);
+		get_capacity(disk) / (geo->sectors * geo->heads);
 
 	return 0;
 }
-- 
1.5.1.4
