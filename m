Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5CCC10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 00:40:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E0C20850
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 00:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlnFWiWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E0C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44j8mp38l9zDqDr
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:40:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="IlnFWiWu"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44j8l63CFyzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 10:39:13 +1000 (AEST)
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net
 [24.5.143.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DFF0420870;
 Mon, 15 Apr 2019 00:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1555288751;
 bh=XKv/WY5HRVs536knZXWZqPLOw+TI8Du1/WeDOvb264g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IlnFWiWuIAtglWzdtdKJjXevwMAwTlBt8vI3rU6duulirNBxPG2N/MBcO37duziCi
 Qt9q8dHLI1HmkAE60c6pzhVYDwrbzO/2zNzk8Bu5plUe9Fj51/yISk2VKhfFQF5xkh
 5cPgzmGwMJ50oHtgAP2CjpA4i5e4r6RemhqVD6Vg=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Subject: [RFC PATCH 2/3] crypto: nx - don't abuse shash MAY_SLEEP flag
Date: Sun, 14 Apr 2019 17:37:08 -0700
Message-Id: <20190415003709.1531-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415003709.1531-1-ebiggers@kernel.org>
References: <20190415003709.1531-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Eric Biggers <ebiggers@google.com>

The nx driver uses the MAY_SLEEP flag in shash_desc::flags as an
indicator to not retry sending the operation to the hardware as many
times before returning -EBUSY.  This is bogus because (1) that's not
what the MAY_SLEEP flag is for, and (2) the shash API doesn't allow
failing if the hardware is busy anyway.

For now, just make it always retry the larger number of times.  This
doesn't actually fix this driver, but it at least makes it not use the
shash_desc::flags field anymore.  Then this field can be removed, as no
other drivers use it.

Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/crypto/nx/nx-aes-xcbc.c | 12 ++++--------
 drivers/crypto/nx/nx-sha256.c   |  6 ++----
 drivers/crypto/nx/nx-sha512.c   |  6 ++----
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/nx/nx-aes-xcbc.c b/drivers/crypto/nx/nx-aes-xcbc.c
index ad3358e74f5c4..8f5820b78a83b 100644
--- a/drivers/crypto/nx/nx-aes-xcbc.c
+++ b/drivers/crypto/nx/nx-aes-xcbc.c
@@ -105,8 +105,7 @@ static int nx_xcbc_empty(struct shash_desc *desc, u8 *out)
 	nx_ctx->op.inlen = (nx_ctx->in_sg - in_sg) * sizeof(struct nx_sg);
 	nx_ctx->op.outlen = (nx_ctx->out_sg - out_sg) * sizeof(struct nx_sg);
 
-	rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
-			   desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP);
+	rc = nx_hcall_sync(nx_ctx, &nx_ctx->op, 0);
 	if (rc)
 		goto out;
 	atomic_inc(&(nx_ctx->stats->aes_ops));
@@ -134,8 +133,7 @@ static int nx_xcbc_empty(struct shash_desc *desc, u8 *out)
 	nx_ctx->op.inlen = (nx_ctx->in_sg - in_sg) * sizeof(struct nx_sg);
 	nx_ctx->op.outlen = (nx_ctx->out_sg - out_sg) * sizeof(struct nx_sg);
 
-	rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
-			   desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP);
+	rc = nx_hcall_sync(nx_ctx, &nx_ctx->op, 0);
 	if (rc)
 		goto out;
 	atomic_inc(&(nx_ctx->stats->aes_ops));
@@ -279,8 +277,7 @@ static int nx_xcbc_update(struct shash_desc *desc,
 			goto out;
 		}
 
-		rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
-			   desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP);
+		rc = nx_hcall_sync(nx_ctx, &nx_ctx->op, 0);
 		if (rc)
 			goto out;
 
@@ -361,8 +358,7 @@ static int nx_xcbc_final(struct shash_desc *desc, u8 *out)
 		goto out;
 	}
 
-	rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
-			   desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP);
+	rc = nx_hcall_sync(nx_ctx, &nx_ctx->op, 0);
 	if (rc)
 		goto out;
 
diff --git a/drivers/crypto/nx/nx-sha256.c b/drivers/crypto/nx/nx-sha256.c
index a6764af83c6dc..e06f0431dee5f 100644
--- a/drivers/crypto/nx/nx-sha256.c
+++ b/drivers/crypto/nx/nx-sha256.c
@@ -162,8 +162,7 @@ static int nx_sha256_update(struct shash_desc *desc, const u8 *data,
 			goto out;
 		}
 
-		rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
-				   desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP);
+		rc = nx_hcall_sync(nx_ctx, &nx_ctx->op, 0);
 		if (rc)
 			goto out;
 
@@ -243,8 +242,7 @@ static int nx_sha256_final(struct shash_desc *desc, u8 *out)
 		goto out;
 	}
 
-	rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
-			   desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP);
+	rc = nx_hcall_sync(nx_ctx, &nx_ctx->op, 0);
 	if (rc)
 		goto out;
 
diff --git a/drivers/crypto/nx/nx-sha512.c b/drivers/crypto/nx/nx-sha512.c
index 92956bc6e45ee..0293b17903d0c 100644
--- a/drivers/crypto/nx/nx-sha512.c
+++ b/drivers/crypto/nx/nx-sha512.c
@@ -166,8 +166,7 @@ static int nx_sha512_update(struct shash_desc *desc, const u8 *data,
 			goto out;
 		}
 
-		rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
-				   desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP);
+		rc = nx_hcall_sync(nx_ctx, &nx_ctx->op, 0);
 		if (rc)
 			goto out;
 
@@ -249,8 +248,7 @@ static int nx_sha512_final(struct shash_desc *desc, u8 *out)
 		goto out;
 	}
 
-	rc = nx_hcall_sync(nx_ctx, &nx_ctx->op,
-			   desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP);
+	rc = nx_hcall_sync(nx_ctx, &nx_ctx->op, 0);
 	if (rc)
 		goto out;
 
-- 
2.21.0

