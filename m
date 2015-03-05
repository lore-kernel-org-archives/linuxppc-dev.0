Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 65D5A1A02E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 03:46:21 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Kim Phillips <kim.phillips@freescale.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 05/17] crypto: talitos - isolate scatter/gather handling for
 ahash
Message-Id: <20150305164606.A61CC1A2420@localhost.localdomain>
Date: Thu,  5 Mar 2015 17:46:06 +0100 (CET)
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

SEC1 doesn't support scatter/gather, therefore this part of the code will
have to be implemented differently for SEC1, so we isolate it in a small
helper function

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 drivers/crypto/talitos.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 4db35a6..6766bcc 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1709,6 +1709,23 @@ static int ahash_init_sha224_swinit(struct ahash_request *areq)
 	return 0;
 }
 
+static void ahash_process_chain(struct scatterlist *src, int nbytes,
+				bool *chained,
+				struct talitos_ahash_req_ctx *req_ctx,
+				int nbytes_to_hash)
+{
+	if (req_ctx->nbuf) {
+		unsigned int nsg = (req_ctx->nbuf < nbytes_to_hash) ? 2 : 1;
+
+		sg_init_table(req_ctx->bufsl, nsg);
+		sg_set_buf(req_ctx->bufsl, req_ctx->buf, req_ctx->nbuf);
+		if (nsg > 1)
+			scatterwalk_sg_chain(req_ctx->bufsl, 2, src);
+		req_ctx->psrc = req_ctx->bufsl;
+	} else
+		req_ctx->psrc = src;
+}
+
 static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
@@ -1719,7 +1736,6 @@ static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
 			crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
 	unsigned int nbytes_to_hash;
 	unsigned int to_hash_later;
-	unsigned int nsg;
 	bool chained;
 
 	if (!req_ctx->last && (nbytes + req_ctx->nbuf <= blocksize)) {
@@ -1747,15 +1763,8 @@ static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
 	}
 
 	/* Chain in any previously buffered data */
-	if (req_ctx->nbuf) {
-		nsg = (req_ctx->nbuf < nbytes_to_hash) ? 2 : 1;
-		sg_init_table(req_ctx->bufsl, nsg);
-		sg_set_buf(req_ctx->bufsl, req_ctx->buf, req_ctx->nbuf);
-		if (nsg > 1)
-			scatterwalk_sg_chain(req_ctx->bufsl, 2, areq->src);
-		req_ctx->psrc = req_ctx->bufsl;
-	} else
-		req_ctx->psrc = areq->src;
+	ahash_process_chain(areq->src, nbytes, &chained, req_ctx,
+			    nbytes_to_hash);
 
 	if (to_hash_later) {
 		int nents = sg_count(areq->src, nbytes, &chained);
-- 
2.1.0
