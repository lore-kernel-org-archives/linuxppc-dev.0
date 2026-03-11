Return-Path: <linuxppc-dev+bounces-18068-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9456A112584F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:03:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWFt20QZtz3bf8;
	Thu, 12 Mar 2026 03:03:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b8"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773245034;
	cv=none; b=ZXuvLe4Tygs9tVBzbdzste8eGtJrXWxRtoSPkJ6q+KFQ7L01w2ySizON2nmoSG0+dJtGRpCQJkzXqp7XVe0oiFl64wTR2wXdje5JU//txYlsvpegeE+l4jbcXHieyByoOBOlUtuqRapatrAf9WJkM/2Vdm6QIayiLLYnTFJutls9TD3LLMoDa2ROVtFfMx0mB1zqcbew33fDct2ioGh2WTDOVobzphZugpFMLiYsYE6zKDg+L6g2+0hlOufpf8rSh7YJGLsf7aEc/xjfNEcADiGknpsD+1AILxO7+hbDDMZf8KQzt0iHBuWZpQzX4DwbUqIpCRMRo7d70HQPN7eYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773245034; c=relaxed/relaxed;
	bh=waVdawZ7reu9virZQC5u0WAfRzxcEnY69LNf+GxNlGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDtzJ52nmHRcr5b/pv+1fS9Qo2jworJpMKBJhcUsQL4ja+h6NONgmQO8X3IHvr8jD6HaKlqvSZcjrqxZ+2feqeZ8vM6ImGRmz10OybL5m0QcW806a+Pden0xbT/Usgeo3eG+z5Tk2uk33RafQW382TGU0ligyFfQVifrypU8NVeyhx7xoJMVSTAyqAdvhnZtD9CO22Mw03fXUVbo7Nf6jnoHfBn95zkn8yby+1hIHeWpQ8rVMwIxnw+YPMWEzgSqxn7HrXFguDu+aXs0Hy/XSwY4yoG7xBzZAYwYRa7NprP+0tLXMgrl5WoKHL6Fs2rpxSx5H0T5u1W6JZ7SqIKDPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SJkP0Xj1; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b8; helo=out-184.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SJkP0Xj1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b8; helo=out-184.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 340 seconds by postgrey-1.37 at boromir; Thu, 12 Mar 2026 03:03:50 AEDT
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWFsy4MKzz2yFm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 03:03:50 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773244667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=waVdawZ7reu9virZQC5u0WAfRzxcEnY69LNf+GxNlGc=;
	b=SJkP0Xj17dlhlRy4MzuUoYOTXtrg/cq+QhPBH7F0wWZdcjLVV1MGkoNGKSSL0SepvSOYd4
	0GbF1Xv8uDoSRoV/edJC+uv06RSfkXS1ksLaQ4QqOIn4ReWISopXdwLKCLf2xOjQzFGGBW
	E8M8XZ72vlGwyLFvhCOp95xAyMBUAQ8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Haren Myneni <haren@us.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Dan Streetman <ddstreet@ieee.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] crypto: nx - fix bounce buffer leaks in nx842_crypto_{alloc,free}_ctx
Date: Wed, 11 Mar 2026 16:56:47 +0100
Message-ID: <20260311155645.397083-4-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; i=thorsten.blum@linux.dev; h=from:subject; bh=0iwtMNI63Hs2PgwaAlMQcHtzeFgUFC5l6Bpz+slaTMQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJkbJ+wTbzm1KNJk18NJb5lVDewZ+re6nu1i11x1RaRv2 oSVmxN3dJSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEfs5jZFjO/2xe2OLUd7lR Ukr7nkit/BOyzlS51mTW7XmZS1yjMxsZ/me+b/76o+YiT6mZefTi4+Gzvty9zX1np9oHlq+qz4K FzzICAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The bounce buffers are allocated with __get_free_pages() using
BOUNCE_BUFFER_ORDER (order 2 = 4 pages), but both the allocation error
path and nx842_crypto_free_ctx() release the buffers with free_page().
Use free_pages() with the matching order instead.

Fixes: ed70b479c2c0 ("crypto: nx - add hardware 842 crypto comp alg")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/nx/nx-842.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
index b61f2545e165..661568ce47f0 100644
--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -116,8 +116,8 @@ void *nx842_crypto_alloc_ctx(struct nx842_driver *driver)
 	ctx->dbounce = (u8 *)__get_free_pages(GFP_KERNEL, BOUNCE_BUFFER_ORDER);
 	if (!ctx->wmem || !ctx->sbounce || !ctx->dbounce) {
 		kfree(ctx->wmem);
-		free_page((unsigned long)ctx->sbounce);
-		free_page((unsigned long)ctx->dbounce);
+		free_pages((unsigned long)ctx->sbounce, BOUNCE_BUFFER_ORDER);
+		free_pages((unsigned long)ctx->dbounce, BOUNCE_BUFFER_ORDER);
 		kfree(ctx);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -131,8 +131,8 @@ void nx842_crypto_free_ctx(void *p)
 	struct nx842_crypto_ctx *ctx = p;
 
 	kfree(ctx->wmem);
-	free_page((unsigned long)ctx->sbounce);
-	free_page((unsigned long)ctx->dbounce);
+	free_pages((unsigned long)ctx->sbounce, BOUNCE_BUFFER_ORDER);
+	free_pages((unsigned long)ctx->dbounce, BOUNCE_BUFFER_ORDER);
 }
 EXPORT_SYMBOL_GPL(nx842_crypto_free_ctx);
 

