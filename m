Return-Path: <linuxppc-dev+bounces-18064-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B49112583F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 15:10:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWDhW42bpz3bf8;
	Thu, 12 Mar 2026 02:10:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773241835;
	cv=none; b=llzJKZwvkoP4lELGV+J/efHjf8tNpnj/ctAgexHwIp16ULKR415mYt1fkQmb99DhHcRYnfbaKHf4VlMAJrcH9vU0lO/lvnf73r4qOJiofOL30eOvlYgtZV7WB8921iTx2fYzVJdYjlI5g+v5UB6wK55mdEgfhlTwAGs6bT5kvMuxloBkWIjCVE6jzyv8OouWEa3pI4XpMAUKZncDTbknEWwzqw+7m+ezR+amFcfbqbR1TM5wFCa1oScpezzfEPICASWz7dcr94pD0lQhlzPMflPf9N7TIcCArPJy1Tm5OCO9C6DmF92R/QAxEw60tqKbY4/BiHMnZSpsOk/TkpSmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773241835; c=relaxed/relaxed;
	bh=Y050AoUlwUvE4JwnOIvUs9WWS/VlkQtCxi3b0zHeXK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mhx7vpHY6lStJNaMBfHXwB9tKTPonU9ViYyqXgIm69/UdMMwTrNyBd0A1JH+JmKZQAYshHZFEvBQ2OlgyoDKsmMhFIxB+Ubf8IOS1O/K+wczBA3uHRy8xWq1KnzPXPThsdd/D+myc268Oj+bSEyfeWRmqomlxXEWBVZASLgVYFN+Buovhjlq0C+l9y7OtjJ/0Z/xetBA28IFDLPcEafRFZXuJag/XgOEevwP0y6Ph+34gMwfM2hiqg1z2Hasnu9/Wxvdpdv+8Fwkcjw7rIudR93rsfODIVAcjZibssGnrkusqhtw9OTBnLiIIMW2qLrbOKTgzGAeo7RMj0dc4ek9kQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GK3fS4w1; dkim-atps=neutral; spf=pass (client-ip=95.215.58.177; helo=out-177.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GK3fS4w1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.177; helo=out-177.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWDhR48G1z30hP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 02:10:30 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773241810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y050AoUlwUvE4JwnOIvUs9WWS/VlkQtCxi3b0zHeXK0=;
	b=GK3fS4w1p586rGFvb7W0Kx91572o8m6OQ+CSVZnCR9ApTUCQ8yrd77df/GhVoSJ/oFVAyr
	3cGZFlVwYR8QJLgg66nLiMpi63XJ4jex51Kz/y3Z94JTC3moVU2HrAJ1+rMesFP3VkEbjQ
	dZYlcJAUool8HeK4P2fdtfVvtzxkdZU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Haren Myneni <haren@us.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Dan Streetman <ddstreet@ieee.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: nx - fix memory leaks in nx842_crypto_{alloc,free}_ctx
Date: Wed, 11 Mar 2026 16:09:24 +0100
Message-ID: <20260311150922.382941-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901; i=thorsten.blum@linux.dev; h=from:subject; bh=iG015FVCN7oPWGVVn9a39BqVhRv1LNNupCbGtz9cTtI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJkbWxe7bCtbbHHYJ3xFb6NL37Kd5yvdrmtMrL9xvfaGG 1937bHUjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjIhRUM/5PqbKvWzPma3PaS 43L5/oz4hYF8y0z2XXKfujJOQ+fF0SeMDC8iZ21rnO+tpM+t9fBq6Z3bLW1/v/DxP+BKWFN4L0G JiwcA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The bounce buffers are allocated with __get_free_pages() using
BOUNCE_BUFFER_ORDER (order 2 = 4 pages), but both the allocation error
path and nx842_crypto_free_ctx() release the buffers with free_page().
Use free_pages() with the matching order instead.

Also, since the scomp conversion, nx842_crypto_alloc_ctx() allocates the
context separately, but nx842_crypto_free_ctx() never releases it. Add
the missing kfree(ctx) in nx842_crypto_free_ctx(), and reuse
nx842_crypto_free_ctx() in the allocation error path.

Fixes: ed70b479c2c0 ("crypto: nx - add hardware 842 crypto comp alg")
Fixes: 980b5705f4e7 ("crypto: nx - Migrate to scomp API")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/nx/nx-842.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
index b61f2545e165..a61208cbcd27 100644
--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -115,10 +115,7 @@ void *nx842_crypto_alloc_ctx(struct nx842_driver *driver)
 	ctx->sbounce = (u8 *)__get_free_pages(GFP_KERNEL, BOUNCE_BUFFER_ORDER);
 	ctx->dbounce = (u8 *)__get_free_pages(GFP_KERNEL, BOUNCE_BUFFER_ORDER);
 	if (!ctx->wmem || !ctx->sbounce || !ctx->dbounce) {
-		kfree(ctx->wmem);
-		free_page((unsigned long)ctx->sbounce);
-		free_page((unsigned long)ctx->dbounce);
-		kfree(ctx);
+		nx842_crypto_free_ctx(ctx);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -131,8 +128,9 @@ void nx842_crypto_free_ctx(void *p)
 	struct nx842_crypto_ctx *ctx = p;
 
 	kfree(ctx->wmem);
-	free_page((unsigned long)ctx->sbounce);
-	free_page((unsigned long)ctx->dbounce);
+	free_pages((unsigned long)ctx->sbounce, BOUNCE_BUFFER_ORDER);
+	free_pages((unsigned long)ctx->dbounce, BOUNCE_BUFFER_ORDER);
+	kfree(ctx);
 }
 EXPORT_SYMBOL_GPL(nx842_crypto_free_ctx);
 

