Return-Path: <linuxppc-dev+bounces-18069-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D42C112584F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:04:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWFt84QL8z3cDg;
	Thu, 12 Mar 2026 03:04:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.184
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773245040;
	cv=none; b=NqJhqId1VIK2Wv1edjSFeulj2B3N4lYmI/t7bsHKMexDYvQLtqSPgxG3jknISxeLSt/Sigs6wrf8QrdWqyr+BNHGIYSUO97GrkgPu+D34rHnuZ71m1bo5kI1q3baJBlKixuGve08vp2tzHJciupvCwYSxcMQgSBF1VY1ntHu7FuhgZhUgPxiIVp0qeCZDT6V1gRoL8Ei6l0B3wwAFmL3bvVRqPw1IGd9wyhSHH2ROwKJ3KdVBshCRSVUemjRmHjmJJ6ZlrdBJEiLocGRa03+4PIwAt/o4bBKnUrXyllaqKGwFoYJt0cLpmhVvZKXlLPkHV7k0T1mEficE/UroykYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773245040; c=relaxed/relaxed;
	bh=1AbKkPRYTP46mVFcNFbB21+SlkZKdM5Pe6Zl0TSZojs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSztSknykwMkolfZ+6mRs4leWgT7wdv8b12/aElYD+evkCmcwTNRZ469ZkQmE6/wOYzrT4yy+jLUHZeUYx7aIekPUJ1rS67u7FlKVACMD0LteDLyzpNCHRrrS8V7C3lQrzXVxInzwbKMw0XluU/qfO9vTPhXoEoFGzdBwYBV7HjQJUwNZed7c6zvBNoYWIL6I/aLIrE7AkcOLX5WImtD/cUh/OoaCLjVvst4jP7ciba4ci42ArHSpLuucyp0oRm3IgF39EbaMoarrbfbv1GOWWrasE+B77Z70waLXkWfsBUFdJEyurYpFbuuuIhgkZ253n9cRuzrAaJGqyclBJc8Xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HekBCL/4; dkim-atps=neutral; spf=pass (client-ip=91.218.175.184; helo=out-184.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HekBCL/4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.184; helo=out-184.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 344 seconds by postgrey-1.37 at boromir; Thu, 12 Mar 2026 03:03:59 AEDT
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWFt7732nz2yFm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 03:03:59 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773244684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AbKkPRYTP46mVFcNFbB21+SlkZKdM5Pe6Zl0TSZojs=;
	b=HekBCL/42ELYcZQnJPWdcGe07PHMv9hmsRPK7iJfAinq8Hej0KIIsdMcS5EcIixWyqGJiD
	c/Wc5glWKby019uFvQyOIrH5s3G+syasz7vPKrIPNsiVqXzT6i1Q4oyF/QiWpN6QFh5IVE
	c2TBzR99Rg9vsLYD2cr8pddjDTx1fl4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Haren Myneni <haren@us.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] crypto: nx - fix context leak in nx842_crypto_free_ctx
Date: Wed, 11 Mar 2026 16:56:49 +0100
Message-ID: <20260311155645.397083-6-thorsten.blum@linux.dev>
In-Reply-To: <20260311155645.397083-4-thorsten.blum@linux.dev>
References: <20260311155645.397083-4-thorsten.blum@linux.dev>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1476; i=thorsten.blum@linux.dev; h=from:subject; bh=z/oznr4rtFbg1KvAqQp9ghSB0UflG5RShs5mZ6Vs+GQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJkbJxx5M1lwitL7on7NzruqOz9N4zhXG7l/vWB1alT0k y7Jm4aSHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRnV8YGU4yfN5VrdtxovKM kCmnzIqIn4yXjNv3efC18v6TddK3WMTI8PyAf0c8R1pc8INv+/8q/VbMnrBL7EtVc0WMf4fujlo fRgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since the scomp conversion, nx842_crypto_alloc_ctx() allocates the
context separately, but nx842_crypto_free_ctx() never releases it. Add
the missing kfree(ctx) to nx842_crypto_free_ctx(), and reuse
nx842_crypto_free_ctx() in the allocation error path.

Fixes: 980b5705f4e7 ("crypto: nx - Migrate to scomp API")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/nx/nx-842.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
index 661568ce47f0..a61208cbcd27 100644
--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -115,10 +115,7 @@ void *nx842_crypto_alloc_ctx(struct nx842_driver *driver)
 	ctx->sbounce = (u8 *)__get_free_pages(GFP_KERNEL, BOUNCE_BUFFER_ORDER);
 	ctx->dbounce = (u8 *)__get_free_pages(GFP_KERNEL, BOUNCE_BUFFER_ORDER);
 	if (!ctx->wmem || !ctx->sbounce || !ctx->dbounce) {
-		kfree(ctx->wmem);
-		free_pages((unsigned long)ctx->sbounce, BOUNCE_BUFFER_ORDER);
-		free_pages((unsigned long)ctx->dbounce, BOUNCE_BUFFER_ORDER);
-		kfree(ctx);
+		nx842_crypto_free_ctx(ctx);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -133,6 +130,7 @@ void nx842_crypto_free_ctx(void *p)
 	kfree(ctx->wmem);
 	free_pages((unsigned long)ctx->sbounce, BOUNCE_BUFFER_ORDER);
 	free_pages((unsigned long)ctx->dbounce, BOUNCE_BUFFER_ORDER);
+	kfree(ctx);
 }
 EXPORT_SYMBOL_GPL(nx842_crypto_free_ctx);
 

