Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4CCD1DDE98
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 21:21:52 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 305CC8810
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 16:21:49 +0500 (SAMST)
Date: Wed, 12 Sep 2007 15:24:56 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] ucc_geth: fix compilation
Message-ID: <20070912112456.GA15556@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch is against paulus/powerpc.git or galak/powerpc.git tree.
Both affected.

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>

There is no qe_bd_t typedef any longer, now it's struct qe_bd.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/ucc_geth.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 12e01b2..9a38dfe 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -2148,7 +2148,7 @@ static void ucc_geth_memclean(struct ucc_geth_private *ugeth)
 		for (j = 0; j < ugeth->ug_info->bdRingLenTx[i]; j++) {
 			if (ugeth->tx_skbuff[i][j]) {
 				dma_unmap_single(NULL,
-						 ((qe_bd_t *)bd)->buf,
+						 ((struct qe_bd *)bd)->buf,
 						 (in_be32((u32 *)bd) &
 						  BD_LENGTH_MASK),
 						 DMA_TO_DEVICE);
-- 
1.5.0.6
