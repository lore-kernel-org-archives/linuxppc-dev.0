Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C720DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 06:24:15 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: linux-raid@vger.kernel.org
Subject: [PATCH] ASYNC_TX: async_xor mapping fix
Date: Mon, 8 Dec 2008 22:14:26 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200812082214.26811.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, Dan Williams <dan.j.williams@intel.com>,
	wd@denx.de, dzu@denx.de, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 The destination address may be present in the source list, so we should
map the addresses from the source list first.
 Otherwise, if page corresponding to destination is not marked as write-
through (with regards to CPU cache), then mapping it with DMA_FROM_DEVICE
may lead to data loss, and finally to an incorrect result of calculations.

Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
---
 crypto/async_tx/async_xor.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/crypto/async_tx/async_xor.c b/crypto/async_tx/async_xor.c
index 91dbf07..291f517 100644
--- a/crypto/async_tx/async_xor.c
+++ b/crypto/async_tx/async_xor.c
@@ -53,10 +53,10 @@ do_async_xor(struct dma_chan *chan, struct page *dest, struct page **src_list,
 	int xor_src_cnt;
 	dma_addr_t dma_dest;
 
-	dma_dest = dma_map_page(dma->dev, dest, offset, len, DMA_FROM_DEVICE);
 	for (i = 0; i < src_cnt; i++)
 		dma_src[i] = dma_map_page(dma->dev, src_list[i], offset,
 					  len, DMA_TO_DEVICE);
+	dma_dest = dma_map_page(dma->dev, dest, offset, len, DMA_FROM_DEVICE);
 
 	while (src_cnt) {
 		async_flags = flags;
-- 
1.5.6.1

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
