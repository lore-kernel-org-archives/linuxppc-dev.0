Return-Path: <xuelin.shi@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0242.outbound.protection.outlook.com [207.46.163.242])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CD7D1A0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 19:33:43 +1000 (EST)
From: <xuelin.shi@freescale.com>
To: <dan.j.williams@intel.com>, <vinod.koul@intel.com>
Subject: [PATCH] dmaengine: fix xor sources continuation
Date: Tue, 1 Jul 2014 16:32:38 +0800
Message-ID: <1404203558-18193-1-git-send-email-xuelin.shi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: dmaengine@vger.kernel.org, Xuelin Shi <xuelin.shi@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Xuelin Shi <xuelin.shi@freescale.com>

the partial xor result must be kept until the next
tx is generated.

Signed-off-by: Xuelin Shi <xuelin.shi@freescale.com>
---
 crypto/async_tx/async_xor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/crypto/async_tx/async_xor.c b/crypto/async_tx/async_xor.c
index 3c562f5..e1bce26 100644
--- a/crypto/async_tx/async_xor.c
+++ b/crypto/async_tx/async_xor.c
@@ -78,8 +78,6 @@ do_async_xor(struct dma_chan *chan, struct dmaengine_unmap_data *unmap,
 		tx = dma->device_prep_dma_xor(chan, dma_dest, src_list,
 					      xor_src_cnt, unmap->len,
 					      dma_flags);
-		src_list[0] = tmp;
-
 
 		if (unlikely(!tx))
 			async_tx_quiesce(&submit->depend_tx);
@@ -92,6 +90,7 @@ do_async_xor(struct dma_chan *chan, struct dmaengine_unmap_data *unmap,
 						      xor_src_cnt, unmap->len,
 						      dma_flags);
 		}
+		src_list[0] = tmp;
 
 		dma_set_unmap(tx, unmap);
 		async_tx_submit(chan, tx, submit);
-- 
1.9.1
