Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id A81A71A0030
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2015 00:23:58 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 01/17] crypto: talitos - Use zero entry to init descriptors
 ptrs to zero
To: Kim Phillips <kim.phillips@freescale.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David S Miller <davem@davemloft.net>
Message-Id: <20150417142354.5AE601A242C@localhost.localdomain>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Date: Fri, 17 Apr 2015 14:24:00 -0000

Do use zero_entry value to init the descriptors ptrs to zero instead of
writing 0 in each field

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/crypto/talitos.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 857414a..7bf1b2b 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1373,9 +1373,7 @@ static int common_nonsnoop(struct talitos_edesc *edesc,
 	int sg_count, ret;
 
 	/* first DWORD empty */
-	desc->ptr[0].len = 0;
-	to_talitos_ptr(&desc->ptr[0], 0);
-	desc->ptr[0].j_extent = 0;
+	desc->ptr[0] = zero_entry;
 
 	/* cipher iv */
 	to_talitos_ptr(&desc->ptr[1], edesc->iv_dma);
@@ -1445,9 +1443,7 @@ static int common_nonsnoop(struct talitos_edesc *edesc,
 			       DMA_FROM_DEVICE);
 
 	/* last DWORD empty */
-	desc->ptr[6].len = 0;
-	to_talitos_ptr(&desc->ptr[6], 0);
-	desc->ptr[6].j_extent = 0;
+	desc->ptr[6] = zero_entry;
 
 	ret = talitos_submit(dev, ctx->ch, desc, callback, areq);
 	if (ret != -EINPROGRESS) {
-- 
2.1.0
