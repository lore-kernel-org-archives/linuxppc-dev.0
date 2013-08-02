Return-Path: <mhcerri@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 267092C0091
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 22:10:04 +1000 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mhcerri@linux.vnet.ibm.com>;
 Fri, 2 Aug 2013 09:09:58 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id B32EE1DC0066
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 08:09:56 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r72C5eIp1134800
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Aug 2013 09:05:40 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r72C9uJw010931
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Aug 2013 09:09:56 -0300
From: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2 2/2] drivers/crypto/nx: fix limits to sg lists for SHA-2
Date: Fri,  2 Aug 2013 09:09:52 -0300
Message-Id: <1375445392-16237-3-git-send-email-mhcerri@linux.vnet.ibm.com>
In-Reply-To: <1375445392-16237-1-git-send-email-mhcerri@linux.vnet.ibm.com>
References: <1375445392-16237-1-git-send-email-mhcerri@linux.vnet.ibm.com>
Cc: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The co-processor has several limits regarding the length of
scatter/gather lists and the total number of bytes in it. These limits
are available in the device tree, as following:

 - "ibm,max-sg-len": maximum number of bytes of each scatter/gather
   list.

 - "ibm,max-sync-cop": used for synchronous operations, it is an array
   of structures that contains information regarding the limits that
   must be considered for each mode and operation. The most important
   limits in it are:
   	- The total number of bytes that a scatter/gather list can hold.
	- The maximum number of elements that a scatter/gather list can
	  have.

This patch updates the NX driver to perform several hyper calls if
needed in order to always respect the length limits for scatter/gather
lists.

Reviewed-by: Fionnuala Gunter <fin@linux.vnet.ibm.com>
Reviewed-by: Joel Schopp <jschopp@linux.vnet.ibm.com>
Reviewed-by: Joy Latten <jmlatten@linux.vnet.ibm.com>
Signed-off-by: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
---
 drivers/crypto/nx/nx-sha256.c | 108 +++++++++++++++++++++++-----------------
 drivers/crypto/nx/nx-sha512.c | 113 ++++++++++++++++++++++++------------------
 2 files changed, 129 insertions(+), 92 deletions(-)

diff --git a/drivers/crypto/nx/nx-sha256.c b/drivers/crypto/nx/nx-sha256.c
index 67024f2..254b01a 100644
--- a/drivers/crypto/nx/nx-sha256.c
+++ b/drivers/crypto/nx/nx-sha256.c
@@ -55,70 +55,86 @@ static int nx_sha256_update(struct shash_desc *desc, const u8 *data,
 	struct nx_crypto_ctx *nx_ctx = crypto_tfm_ctx(&desc->tfm->base);
 	struct nx_csbcpb *csbcpb = (struct nx_csbcpb *)nx_ctx->csbcpb;
 	struct nx_sg *in_sg;
-	u64 to_process, leftover;
+	u64 to_process, leftover, total;
+	u32 max_sg_len;
 	int rc = 0;
 
-	if (NX_CPB_FDM(csbcpb) & NX_FDM_CONTINUATION) {
-		/* we've hit the nx chip previously and we're updating again,
-		 * so copy over the partial digest */
-		memcpy(csbcpb->cpb.sha256.input_partial_digest,
-		       csbcpb->cpb.sha256.message_digest, SHA256_DIGEST_SIZE);
-	}
-
 	/* 2 cases for total data len:
-	 *  1: <= SHA256_BLOCK_SIZE: copy into state, return 0
-	 *  2: > SHA256_BLOCK_SIZE: process X blocks, copy in leftover
+	 *  1: < SHA256_BLOCK_SIZE: copy into state, return 0
+	 *  2: >= SHA256_BLOCK_SIZE: process X blocks, copy in leftover
 	 */
-	if (len + sctx->count < SHA256_BLOCK_SIZE) {
+	total = sctx->count + len;
+	if (total < SHA256_BLOCK_SIZE) {
 		memcpy(sctx->buf + sctx->count, data, len);
 		sctx->count += len;
 		goto out;
 	}
 
-	/* to_process: the SHA256_BLOCK_SIZE data chunk to process in this
-	 * update */
-	to_process = (sctx->count + len) & ~(SHA256_BLOCK_SIZE - 1);
-	leftover = (sctx->count + len) & (SHA256_BLOCK_SIZE - 1);
+	in_sg = nx_ctx->in_sg;
+	max_sg_len = min_t(u32, nx_driver.of.max_sg_len/sizeof(struct nx_sg),
+			   nx_ctx->ap->sglen);
 
-	if (sctx->count) {
-		in_sg = nx_build_sg_list(nx_ctx->in_sg, (u8 *)sctx->buf,
-					 sctx->count, nx_ctx->ap->sglen);
-		in_sg = nx_build_sg_list(in_sg, (u8 *)data,
+	do {
+		/*
+		 * to_process: the SHA256_BLOCK_SIZE data chunk to process in
+		 * this update. This value is also restricted by the sg list
+		 * limits.
+		 */
+		to_process = min_t(u64, total, nx_ctx->ap->databytelen);
+		to_process = min_t(u64, to_process,
+				   NX_PAGE_SIZE * (max_sg_len - 1));
+		to_process = to_process & ~(SHA256_BLOCK_SIZE - 1);
+		leftover = total - to_process;
+
+		if (sctx->count) {
+			in_sg = nx_build_sg_list(nx_ctx->in_sg,
+						 (u8 *) sctx->buf,
+						 sctx->count, max_sg_len);
+		}
+		in_sg = nx_build_sg_list(in_sg, (u8 *) data,
 					 to_process - sctx->count,
-					 nx_ctx->ap->sglen);
+					 max_sg_len);
 		nx_ctx->op.inlen = (nx_ctx->in_sg - in_sg) *
 					sizeof(struct nx_sg);
-	} else {
-		in_sg = nx_build_sg_list(nx_ctx->in_sg, (u8 *)data,
-					 to_process, nx_ctx->ap->sglen);
-		nx_ctx->op.inlen = (nx_ctx->in_sg - in_sg) *
-					sizeof(struct nx_sg);
-	}
 
-	NX_CPB_FDM(csbcpb) |= NX_FDM_INTERMEDIATE;
+		if (NX_CPB_FDM(csbcpb) & NX_FDM_CONTINUATION) {
+			/*
+			 * we've hit the nx chip previously and we're updating
+			 * again, so copy over the partial digest.
+			 */
+			memcpy(csbcpb->cpb.sha256.input_partial_digest,
+			       csbcpb->cpb.sha256.message_digest,
+			       SHA256_DIGEST_SIZE);
+		}
+
+		NX_CPB_FDM(csbcpb) |= NX_FDM_INTERMEDIATE;
+		if (!nx_ctx->op.inlen || !nx_ctx->op.outlen) {
+			rc = -EINVAL;
+			goto out;
+		}
+
+		rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
+				   desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP);
+		if (rc)
+			goto out;
 
-	if (!nx_ctx->op.inlen || !nx_ctx->op.outlen) {
-		rc = -EINVAL;
-		goto out;
-	}
+		atomic_inc(&(nx_ctx->stats->sha256_ops));
+		csbcpb->cpb.sha256.message_bit_length += (u64)
+			(csbcpb->cpb.sha256.spbc * 8);
 
-	rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
-			   desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP);
-	if (rc)
-		goto out;
+		/* everything after the first update is continuation */
+		NX_CPB_FDM(csbcpb) |= NX_FDM_CONTINUATION;
 
-	atomic_inc(&(nx_ctx->stats->sha256_ops));
+		total -= to_process;
+		data += to_process;
+		sctx->count = 0;
+		in_sg = nx_ctx->in_sg;
+	} while (leftover >= SHA256_BLOCK_SIZE);
 
 	/* copy the leftover back into the state struct */
 	if (leftover)
-		memcpy(sctx->buf, data + len - leftover, leftover);
+		memcpy(sctx->buf, data, leftover);
 	sctx->count = leftover;
-
-	csbcpb->cpb.sha256.message_bit_length += (u64)
-		(csbcpb->cpb.sha256.spbc * 8);
-
-	/* everything after the first update is continuation */
-	NX_CPB_FDM(csbcpb) |= NX_FDM_CONTINUATION;
 out:
 	return rc;
 }
@@ -129,8 +145,10 @@ static int nx_sha256_final(struct shash_desc *desc, u8 *out)
 	struct nx_crypto_ctx *nx_ctx = crypto_tfm_ctx(&desc->tfm->base);
 	struct nx_csbcpb *csbcpb = (struct nx_csbcpb *)nx_ctx->csbcpb;
 	struct nx_sg *in_sg, *out_sg;
+	u32 max_sg_len;
 	int rc;
 
+	max_sg_len = min_t(u32, nx_driver.of.max_sg_len, nx_ctx->ap->sglen);
 
 	if (NX_CPB_FDM(csbcpb) & NX_FDM_CONTINUATION) {
 		/* we've hit the nx chip previously, now we're finalizing,
@@ -146,9 +164,9 @@ static int nx_sha256_final(struct shash_desc *desc, u8 *out)
 	csbcpb->cpb.sha256.message_bit_length += (u64)(sctx->count * 8);
 
 	in_sg = nx_build_sg_list(nx_ctx->in_sg, (u8 *)sctx->buf,
-				 sctx->count, nx_ctx->ap->sglen);
+				 sctx->count, max_sg_len);
 	out_sg = nx_build_sg_list(nx_ctx->out_sg, out, SHA256_DIGEST_SIZE,
-				  nx_ctx->ap->sglen);
+				  max_sg_len);
 	nx_ctx->op.inlen = (nx_ctx->in_sg - in_sg) * sizeof(struct nx_sg);
 	nx_ctx->op.outlen = (nx_ctx->out_sg - out_sg) * sizeof(struct nx_sg);
 
diff --git a/drivers/crypto/nx/nx-sha512.c b/drivers/crypto/nx/nx-sha512.c
index 08eee11..2d6d913 100644
--- a/drivers/crypto/nx/nx-sha512.c
+++ b/drivers/crypto/nx/nx-sha512.c
@@ -55,72 +55,88 @@ static int nx_sha512_update(struct shash_desc *desc, const u8 *data,
 	struct nx_crypto_ctx *nx_ctx = crypto_tfm_ctx(&desc->tfm->base);
 	struct nx_csbcpb *csbcpb = (struct nx_csbcpb *)nx_ctx->csbcpb;
 	struct nx_sg *in_sg;
-	u64 to_process, leftover, spbc_bits;
+	u64 to_process, leftover, total, spbc_bits;
+	u32 max_sg_len;
 	int rc = 0;
 
-	if (NX_CPB_FDM(csbcpb) & NX_FDM_CONTINUATION) {
-		/* we've hit the nx chip previously and we're updating again,
-		 * so copy over the partial digest */
-		memcpy(csbcpb->cpb.sha512.input_partial_digest,
-		       csbcpb->cpb.sha512.message_digest, SHA512_DIGEST_SIZE);
-	}
-
 	/* 2 cases for total data len:
-	 *  1: <= SHA512_BLOCK_SIZE: copy into state, return 0
-	 *  2: > SHA512_BLOCK_SIZE: process X blocks, copy in leftover
+	 *  1: < SHA512_BLOCK_SIZE: copy into state, return 0
+	 *  2: >= SHA512_BLOCK_SIZE: process X blocks, copy in leftover
 	 */
-	if ((u64)len + sctx->count[0] < SHA512_BLOCK_SIZE) {
+	total = sctx->count[0] + len;
+	if (total < SHA512_BLOCK_SIZE) {
 		memcpy(sctx->buf + sctx->count[0], data, len);
 		sctx->count[0] += len;
 		goto out;
 	}
 
-	/* to_process: the SHA512_BLOCK_SIZE data chunk to process in this
-	 * update */
-	to_process = (sctx->count[0] + len) & ~(SHA512_BLOCK_SIZE - 1);
-	leftover = (sctx->count[0] + len) & (SHA512_BLOCK_SIZE - 1);
+	in_sg = nx_ctx->in_sg;
+	max_sg_len = min_t(u32, nx_driver.of.max_sg_len/sizeof(struct nx_sg),
+			   nx_ctx->ap->sglen);
 
-	if (sctx->count[0]) {
-		in_sg = nx_build_sg_list(nx_ctx->in_sg, (u8 *)sctx->buf,
-					 sctx->count[0], nx_ctx->ap->sglen);
-		in_sg = nx_build_sg_list(in_sg, (u8 *)data,
+	do {
+		/*
+		 * to_process: the SHA512_BLOCK_SIZE data chunk to process in
+		 * this update. This value is also restricted by the sg list
+		 * limits.
+		 */
+		to_process = min_t(u64, total, nx_ctx->ap->databytelen);
+		to_process = min_t(u64, to_process,
+				   NX_PAGE_SIZE * (max_sg_len - 1));
+		to_process = to_process & ~(SHA512_BLOCK_SIZE - 1);
+		leftover = total - to_process;
+
+		if (sctx->count[0]) {
+			in_sg = nx_build_sg_list(nx_ctx->in_sg,
+						 (u8 *) sctx->buf,
+						 sctx->count[0], max_sg_len);
+		}
+		in_sg = nx_build_sg_list(in_sg, (u8 *) data,
 					 to_process - sctx->count[0],
-					 nx_ctx->ap->sglen);
+					 max_sg_len);
 		nx_ctx->op.inlen = (nx_ctx->in_sg - in_sg) *
 					sizeof(struct nx_sg);
-	} else {
-		in_sg = nx_build_sg_list(nx_ctx->in_sg, (u8 *)data,
-					 to_process, nx_ctx->ap->sglen);
-		nx_ctx->op.inlen = (nx_ctx->in_sg - in_sg) *
-					sizeof(struct nx_sg);
-	}
 
-	NX_CPB_FDM(csbcpb) |= NX_FDM_INTERMEDIATE;
+		if (NX_CPB_FDM(csbcpb) & NX_FDM_CONTINUATION) {
+			/*
+			 * we've hit the nx chip previously and we're updating
+			 * again, so copy over the partial digest.
+			 */
+			memcpy(csbcpb->cpb.sha512.input_partial_digest,
+			       csbcpb->cpb.sha512.message_digest,
+			       SHA512_DIGEST_SIZE);
+		}
+
+		NX_CPB_FDM(csbcpb) |= NX_FDM_INTERMEDIATE;
+		if (!nx_ctx->op.inlen || !nx_ctx->op.outlen) {
+			rc = -EINVAL;
+			goto out;
+		}
+
+		rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
+				   desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP);
+		if (rc)
+			goto out;
 
-	if (!nx_ctx->op.inlen || !nx_ctx->op.outlen) {
-		rc = -EINVAL;
-		goto out;
-	}
+		atomic_inc(&(nx_ctx->stats->sha512_ops));
+		spbc_bits = csbcpb->cpb.sha512.spbc * 8;
+		csbcpb->cpb.sha512.message_bit_length_lo += spbc_bits;
+		if (csbcpb->cpb.sha512.message_bit_length_lo < spbc_bits)
+			csbcpb->cpb.sha512.message_bit_length_hi++;
 
-	rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
-			   desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP);
-	if (rc)
-		goto out;
+		/* everything after the first update is continuation */
+		NX_CPB_FDM(csbcpb) |= NX_FDM_CONTINUATION;
 
-	atomic_inc(&(nx_ctx->stats->sha512_ops));
+		total -= to_process;
+		data += to_process;
+		sctx->count[0] = 0;
+		in_sg = nx_ctx->in_sg;
+	} while (leftover >= SHA512_BLOCK_SIZE);
 
 	/* copy the leftover back into the state struct */
 	if (leftover)
-		memcpy(sctx->buf, data + len - leftover, leftover);
+		memcpy(sctx->buf, data, leftover);
 	sctx->count[0] = leftover;
-
-	spbc_bits = csbcpb->cpb.sha512.spbc * 8;
-	csbcpb->cpb.sha512.message_bit_length_lo += spbc_bits;
-	if (csbcpb->cpb.sha512.message_bit_length_lo < spbc_bits)
-		csbcpb->cpb.sha512.message_bit_length_hi++;
-
-	/* everything after the first update is continuation */
-	NX_CPB_FDM(csbcpb) |= NX_FDM_CONTINUATION;
 out:
 	return rc;
 }
@@ -131,9 +147,12 @@ static int nx_sha512_final(struct shash_desc *desc, u8 *out)
 	struct nx_crypto_ctx *nx_ctx = crypto_tfm_ctx(&desc->tfm->base);
 	struct nx_csbcpb *csbcpb = (struct nx_csbcpb *)nx_ctx->csbcpb;
 	struct nx_sg *in_sg, *out_sg;
+	u32 max_sg_len;
 	u64 count0;
 	int rc;
 
+	max_sg_len = min_t(u32, nx_driver.of.max_sg_len, nx_ctx->ap->sglen);
+
 	if (NX_CPB_FDM(csbcpb) & NX_FDM_CONTINUATION) {
 		/* we've hit the nx chip previously, now we're finalizing,
 		 * so copy over the partial digest */
@@ -152,9 +171,9 @@ static int nx_sha512_final(struct shash_desc *desc, u8 *out)
 		csbcpb->cpb.sha512.message_bit_length_hi++;
 
 	in_sg = nx_build_sg_list(nx_ctx->in_sg, sctx->buf, sctx->count[0],
-				 nx_ctx->ap->sglen);
+				 max_sg_len);
 	out_sg = nx_build_sg_list(nx_ctx->out_sg, out, SHA512_DIGEST_SIZE,
-				  nx_ctx->ap->sglen);
+				  max_sg_len);
 	nx_ctx->op.inlen = (nx_ctx->in_sg - in_sg) * sizeof(struct nx_sg);
 	nx_ctx->op.outlen = (nx_ctx->out_sg - out_sg) * sizeof(struct nx_sg);
 
-- 
1.7.12
