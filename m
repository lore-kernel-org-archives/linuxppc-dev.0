Return-Path: <mhcerri@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8783F2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 06:01:42 +1000 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mhcerri@linux.vnet.ibm.com>;
 Fri, 23 Aug 2013 17:01:36 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 94B9F3520065
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 16:01:33 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7NK06PH43581590
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 17:00:06 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7NK1WbW000825
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 17:01:33 -0300
From: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
To: herbert@gondor.apana.org.au
Subject: [PATCH 02/10] crypto: nx - fix limits to sg lists for AES-ECB
Date: Fri, 23 Aug 2013 17:01:06 -0300
Message-Id: <1377288074-18998-3-git-send-email-mhcerri@linux.vnet.ibm.com>
In-Reply-To: <1377288074-18998-1-git-send-email-mhcerri@linux.vnet.ibm.com>
References: <1377288074-18998-1-git-send-email-mhcerri@linux.vnet.ibm.com>
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

This patch updates the nx-aes-ecb implementation to perform several
hyper calls if needed in order to always respect the length limits for
scatter/gather lists.

Two different limits are considered:

 - "ibm,max-sg-len": maximum number of bytes of each scatter/gather
   list.

 - "ibm,max-sync-cop":
    - The total number of bytes that a scatter/gather list can hold.
    - The maximum number of elements that a scatter/gather list can have.

Reviewed-by: Joy Latten <jmlatten@linux.vnet.ibm.com>
Signed-off-by: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
---
 drivers/crypto/nx/nx-aes-ecb.c | 48 ++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/nx/nx-aes-ecb.c b/drivers/crypto/nx/nx-aes-ecb.c
index fe0d803..85a8d23 100644
--- a/drivers/crypto/nx/nx-aes-ecb.c
+++ b/drivers/crypto/nx/nx-aes-ecb.c
@@ -71,37 +71,49 @@ static int ecb_aes_nx_crypt(struct blkcipher_desc *desc,
 	struct nx_crypto_ctx *nx_ctx = crypto_blkcipher_ctx(desc->tfm);
 	struct nx_csbcpb *csbcpb = nx_ctx->csbcpb;
 	unsigned long irq_flags;
+	unsigned int processed = 0, to_process;
+	u32 max_sg_len;
 	int rc;
 
 	spin_lock_irqsave(&nx_ctx->lock, irq_flags);
 
-	if (nbytes > nx_ctx->ap->databytelen) {
-		rc = -EINVAL;
-		goto out;
-	}
+	max_sg_len = min_t(u32, nx_driver.of.max_sg_len/sizeof(struct nx_sg),
+			   nx_ctx->ap->sglen);
 
 	if (enc)
 		NX_CPB_FDM(csbcpb) |= NX_FDM_ENDE_ENCRYPT;
 	else
 		NX_CPB_FDM(csbcpb) &= ~NX_FDM_ENDE_ENCRYPT;
 
-	rc = nx_build_sg_lists(nx_ctx, desc, dst, src, nbytes, 0, NULL);
-	if (rc)
-		goto out;
+	do {
+		to_process = min_t(u64, nbytes - processed,
+				   nx_ctx->ap->databytelen);
+		to_process = min_t(u64, to_process,
+				   NX_PAGE_SIZE * (max_sg_len - 1));
+		to_process = to_process & ~(AES_BLOCK_SIZE - 1);
 
-	if (!nx_ctx->op.inlen || !nx_ctx->op.outlen) {
-		rc = -EINVAL;
-		goto out;
-	}
+		rc = nx_build_sg_lists(nx_ctx, desc, dst, src, to_process,
+				processed, NULL);
+		if (rc)
+			goto out;
 
-	rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
-			   desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP);
-	if (rc)
-		goto out;
+		if (!nx_ctx->op.inlen || !nx_ctx->op.outlen) {
+			rc = -EINVAL;
+			goto out;
+		}
+
+		rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
+				   desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP);
+		if (rc)
+			goto out;
+
+		atomic_inc(&(nx_ctx->stats->aes_ops));
+		atomic64_add(csbcpb->csb.processed_byte_count,
+			     &(nx_ctx->stats->aes_bytes));
+
+		processed += to_process;
+	} while (processed < nbytes);
 
-	atomic_inc(&(nx_ctx->stats->aes_ops));
-	atomic64_add(csbcpb->csb.processed_byte_count,
-		     &(nx_ctx->stats->aes_bytes));
 out:
 	spin_unlock_irqrestore(&nx_ctx->lock, irq_flags);
 	return rc;
-- 
1.7.12
