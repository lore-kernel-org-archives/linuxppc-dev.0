Return-Path: <johfel@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 0039ADDE28
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 05:02:41 +1000 (EST)
Subject: [PATCH] powerpc: iSeries: remove unused variable in viodasd.c
From: Johann Felix Soden <johfel@gmx.de>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Sun, 21 Sep 2008 21:02:36 +0200
Message-Id: <1222023756.7114.5.camel@localhost>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
Reply-To: Johann Felix Soden <johfel@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Johann Felix Soden <johfel@users.sourceforge.net>

The variable statindex in send_request is never read, so remove it.

Signed-off-by: Johann Felix Soden <johfel@users.sourceforge.net>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/block/viodasd.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/block/viodasd.c b/drivers/block/viodasd.c
index f1c8feb..1730d29 100644
--- a/drivers/block/viodasd.c
+++ b/drivers/block/viodasd.c
@@ -249,7 +249,6 @@ static int send_request(struct request *req)
 	struct HvLpEvent *hev;
 	struct scatterlist sg[VIOMAXBLOCKDMA];
 	int sgindex;
-	int statindex;
 	struct viodasd_device *d;
 	unsigned long flags;
 
@@ -258,11 +257,9 @@ static int send_request(struct request *req)
 	if (rq_data_dir(req) == READ) {
 		direction = DMA_FROM_DEVICE;
 		viocmd = viomajorsubtype_blockio | vioblockread;
-		statindex = 0;
 	} else {
 		direction = DMA_TO_DEVICE;
 		viocmd = viomajorsubtype_blockio | vioblockwrite;
-		statindex = 1;
 	}
 
         d = req->rq_disk->private_data;
-- 
1.5.6.5
