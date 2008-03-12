Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 12 Mar 2008 17:23:56 +1100
Subject: [PATCH] [POWERPC] Fix viodasd driver with scatterlist debug
Message-Id: <20080312062407.492AEDDED5@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The iSeries viodasd drivers does some very strange things with
scatterlists, one of these causing a BUG_ON to trigger when
scatterlist debugging is enabled due to initializing the
scatterlist with memset instead of sg_init_table().

This fixes it by using sg_init_table(). The rest of the stuff
it does to that poor list is still pretty awful but it will work.

I may look into fixing things in a nicer way some other time.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/block/viodasd.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-work.orig/drivers/block/viodasd.c	2008-03-12 10:25:55.000000000 +1100
+++ linux-work/drivers/block/viodasd.c	2008-03-12 10:39:38.000000000 +1100
@@ -528,8 +528,7 @@ static int block_event_to_scatterlist(co
 		numsg = VIOMAXBLOCKDMA;
 
 	*total_len = 0;
-	memset(sg, 0, sizeof(sg[0]) * VIOMAXBLOCKDMA);
-
+	sg_init_table(sg, VIOMAXBLOCKDMA);
 	for (i = 0; (i < numsg) && (rw_data->dma_info[i].len > 0); ++i) {
 		sg_dma_address(&sg[i]) = rw_data->dma_info[i].token;
 		sg_dma_len(&sg[i]) = rw_data->dma_info[i].len;
