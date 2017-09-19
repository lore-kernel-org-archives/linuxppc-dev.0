Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxNHH5vRNzDqNh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 22:59:07 +1000 (AEST)
Message-Id: <af19f4aa51d30b352b08acd416d13a917529ddd2.1505825623.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1505825623.git.christophe.leroy@c-s.fr>
References: <cover.1505825623.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/6] crypto: talitos - fix hashing
To: Herbert Xu <herbert@gondor.apana.org.au>,
 David S. Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
Date: Tue, 19 Sep 2017 14:59:03 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

md5sum on some files gives wrong result

Exemple:

With the md5sum from libkcapi:
c15115c05bad51113f81bdaee735dd09  test

With the original md5sum:
bbdf41d80ba7e8b2b7be3a0772be76cb  test

This patch fixes this issue

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/crypto/talitos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 5cc160078286..49f1561fa694 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1769,7 +1769,7 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 
 	sg_count = edesc->src_nents ?: 1;
 	if (is_sec1 && sg_count > 1)
-		sg_copy_to_buffer(areq->src, sg_count, edesc->buf, length);
+		sg_copy_to_buffer(req_ctx->psrc, sg_count, edesc->buf, length);
 	else
 		sg_count = dma_map_sg(dev, req_ctx->psrc, sg_count,
 				      DMA_TO_DEVICE);
-- 
2.13.3
