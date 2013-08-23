Return-Path: <mhcerri@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9CE7B2C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 06:01:48 +1000 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mhcerri@linux.vnet.ibm.com>;
 Fri, 23 Aug 2013 17:01:44 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 5CB321DC0068
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 16:01:41 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7NK0D0P32309388
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 17:00:13 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7NK1exg001210
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 17:01:40 -0300
From: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
To: herbert@gondor.apana.org.au
Subject: [PATCH 06/10] crypto: nx - fix limits to sg lists for AES-XCBC
Date: Fri, 23 Aug 2013 17:01:10 -0300
Message-Id: <1377288074-18998-7-git-send-email-mhcerri@linux.vnet.ibm.com>
In-Reply-To: <1377288074-18998-1-git-send-email-mhcerri@linux.vnet.ibm.com>
References: <1377288074-18998-1-git-send-email-mhcerri@linux.vnet.ibm.com>
Cc: Fionnuala Gunter <fin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Fionnuala Gunter <fin@linux.vnet.ibm.com>

This patch updates the NX driver to perform several hyper calls when necessary
so that the length limits of scatter/gather lists are respected.

Reviewed-by: Joy Latten <jmlatten@linux.vnet.ibm.com>
Reviewed-by: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
Signed-off-by: Fionnuala Gunter <fin@linux.vnet.ibm.com>
---
 drivers/crypto/nx/nx-aes-xcbc.c | 107 +++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 44 deletions(-)

diff --git a/drivers/crypto/nx/nx-aes-xcbc.c b/drivers/crypto/nx/nx-aes-xcbc.c
index 658da0f..1a5d9e3 100644
--- a/drivers/crypto/nx/nx-aes-xcbc.c
+++ b/drivers/crypto/nx/nx-aes-xcbc.c
@@ -88,78 +88,97 @@ static int nx_xcbc_update(struct shash_desc *desc,
 	struct nx_crypto_ctx *nx_ctx = crypto_tfm_ctx(&desc->tfm->base);
 	struct nx_csbcpb *csbcpb = nx_ctx->csbcpb;
 	struct nx_sg *in_sg;
-	u32 to_process, leftover;
+	u32 to_process, leftover, total;
+	u32 max_sg_len;
 	unsigned long irq_flags;
 	int rc = 0;
 
 	spin_lock_irqsave(&nx_ctx->lock, irq_flags);
 
-	if (NX_CPB_FDM(csbcpb) & NX_FDM_CONTINUATION) {
-		/* we've hit the nx chip previously and we're updating again,
-		 * so copy over the partial digest */
-		memcpy(csbcpb->cpb.aes_xcbc.cv,
-		       csbcpb->cpb.aes_xcbc.out_cv_mac, AES_BLOCK_SIZE);
-	}
+
+	total = sctx->count + len;
 
 	/* 2 cases for total data len:
 	 *  1: <= AES_BLOCK_SIZE: copy into state, return 0
 	 *  2: > AES_BLOCK_SIZE: process X blocks, copy in leftover
 	 */
-	if (len + sctx->count <= AES_BLOCK_SIZE) {
+	if (total <= AES_BLOCK_SIZE) {
 		memcpy(sctx->buffer + sctx->count, data, len);
 		sctx->count += len;
 		goto out;
 	}
 
-	/* to_process: the AES_BLOCK_SIZE data chunk to process in this
-	 * update */
-	to_process = (sctx->count + len) & ~(AES_BLOCK_SIZE - 1);
-	leftover = (sctx->count + len) & (AES_BLOCK_SIZE - 1);
+	in_sg = nx_ctx->in_sg;
+	max_sg_len = min_t(u32, nx_driver.of.max_sg_len/sizeof(struct nx_sg),
+				nx_ctx->ap->sglen);
 
-	/* the hardware will not accept a 0 byte operation for this algorithm
-	 * and the operation MUST be finalized to be correct. So if we happen
-	 * to get an update that falls on a block sized boundary, we must
-	 * save off the last block to finalize with later. */
-	if (!leftover) {
-		to_process -= AES_BLOCK_SIZE;
-		leftover = AES_BLOCK_SIZE;
-	}
+	do {
 
-	if (sctx->count) {
-		in_sg = nx_build_sg_list(nx_ctx->in_sg, sctx->buffer,
-					 sctx->count, nx_ctx->ap->sglen);
-		in_sg = nx_build_sg_list(in_sg, (u8 *)data,
-					 to_process - sctx->count,
-					 nx_ctx->ap->sglen);
-		nx_ctx->op.inlen = (nx_ctx->in_sg - in_sg) *
-					sizeof(struct nx_sg);
-	} else {
-		in_sg = nx_build_sg_list(nx_ctx->in_sg, (u8 *)data, to_process,
-					 nx_ctx->ap->sglen);
+		/* to_process: the AES_BLOCK_SIZE data chunk to process in this
+		 * update */
+		to_process = min_t(u64, total, nx_ctx->ap->databytelen);
+		to_process = min_t(u64, to_process,
+					NX_PAGE_SIZE * (max_sg_len - 1));
+		to_process = to_process & ~(AES_BLOCK_SIZE - 1);
+		leftover = total - to_process;
+
+		/* the hardware will not accept a 0 byte operation for this
+		 * algorithm and the operation MUST be finalized to be correct.
+		 * So if we happen to get an update that falls on a block sized
+		 * boundary, we must save off the last block to finalize with
+		 * later. */
+		if (!leftover) {
+			to_process -= AES_BLOCK_SIZE;
+			leftover = AES_BLOCK_SIZE;
+		}
+
+		if (sctx->count) {
+			in_sg = nx_build_sg_list(nx_ctx->in_sg,
+						(u8 *) sctx->buffer,
+						sctx->count,
+						max_sg_len);
+		}
+		in_sg = nx_build_sg_list(in_sg,
+					(u8 *) data,
+					to_process - sctx->count,
+					max_sg_len);
 		nx_ctx->op.inlen = (nx_ctx->in_sg - in_sg) *
 					sizeof(struct nx_sg);
-	}
 
-	NX_CPB_FDM(csbcpb) |= NX_FDM_INTERMEDIATE;
+		/* we've hit the nx chip previously and we're updating again,
+		 * so copy over the partial digest */
+		if (NX_CPB_FDM(csbcpb) & NX_FDM_CONTINUATION) {
+			memcpy(csbcpb->cpb.aes_xcbc.cv,
+				csbcpb->cpb.aes_xcbc.out_cv_mac,
+				AES_BLOCK_SIZE);
+		}
 
-	if (!nx_ctx->op.inlen || !nx_ctx->op.outlen) {
-		rc = -EINVAL;
-		goto out;
-	}
+		NX_CPB_FDM(csbcpb) |= NX_FDM_INTERMEDIATE;
+		if (!nx_ctx->op.inlen || !nx_ctx->op.outlen) {
+			rc = -EINVAL;
+			goto out;
+		}
 
-	rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
+		rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
 			   desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP);
-	if (rc)
-		goto out;
+		if (rc)
+			goto out;
 
-	atomic_inc(&(nx_ctx->stats->aes_ops));
+		atomic_inc(&(nx_ctx->stats->aes_ops));
+
+		/* everything after the first update is continuation */
+		NX_CPB_FDM(csbcpb) |= NX_FDM_CONTINUATION;
+
+		total -= to_process;
+		data += to_process - sctx->count;
+		sctx->count = 0;
+		in_sg = nx_ctx->in_sg;
+	} while (leftover > AES_BLOCK_SIZE);
 
 	/* copy the leftover back into the state struct */
-	memcpy(sctx->buffer, data + len - leftover, leftover);
+	memcpy(sctx->buffer, data, leftover);
 	sctx->count = leftover;
 
-	/* everything after the first update is continuation */
-	NX_CPB_FDM(csbcpb) |= NX_FDM_CONTINUATION;
 out:
 	spin_unlock_irqrestore(&nx_ctx->lock, irq_flags);
 	return rc;
-- 
1.7.12
