Return-Path: <linuxppc-dev+bounces-21445-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FA4CD5BC0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 07:57:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gP7X33GVhz2xnK;
	Mon, 25 May 2026 17:57:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=140.211.166.183
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779695843;
	cv=none; b=T6YXLjlhqor5Pcwpwn24xXLlcaB9NyTYSVhatNIIjgx0B2RwUnDCOtZChvt/nwbxxVy2NJmQl0X0kWU1CQwH/xTLm/NEuYJIjbHtdkeBWZlzKeV7N+pL9GMvtTVAZNu0znkl+roEEFsYs9mgFDJQKgDlJ3hMoe1S6mOzgDLeHGQ4MxtrqM+ypMh6QQw3cV2ATPqgI3knZcLE0yarv8GP4RLWlfdVVPajwynWgG2jWtZACWaX7fEpEuOD8D0w+M2/GaY6PulLYx2/wW0eSI9H8GKV75QTSW67x7ngzubwoPA5jsQuK3iyKZSTaVgOIP22S8WAFtpzDmCAt3SpcxGd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779695843; c=relaxed/relaxed;
	bh=HHhpXlzRmHrzRtNTLHgm3F0nZIdqKdi1jX0PUFMVKPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cytUznnSn2603q2OrE8gj8C/olKyDHkN1kZDDS+rBkcosPJWgcpKGJmcqriBpf7Hor2NLYs0H/2B4mCOVV0qNAC2O40xvfoiWKaMiziJGTW92lyXYGcvaQUlTnLP1Eq3hRCGKxU1xx2zO6ealNbcOg1HRwVq5jxepBL5FVCaQD2ILjc1WkhfgOVOMWki32mAEh5dIkWQZ2TLfNBy2znTCE1eHiOJQDpMzYb5cRcxX65fYRZLfvtE5jmhLWiZzfZ8e/JpdThUsjp2oIKWByI9vWHVKM8hTVM0W3U07WKVELFxwGoRkJjfuEeOyYAlMNPZVeZm9ymIgE1/yq3lnabu0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass (client-ip=140.211.166.183; helo=smtp.gentoo.org; envelope-from=sam@gentoo.org; receiver=lists.ozlabs.org) smtp.mailfrom=gentoo.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gentoo.org (client-ip=140.211.166.183; helo=smtp.gentoo.org; envelope-from=sam@gentoo.org; receiver=lists.ozlabs.org)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gP7X15zcWz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 17:57:21 +1000 (AEST)
Received: from localhost (1.5.5.2.4.d.e.f.f.f.5.f.9.d.6.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a:6d9:f5ff:fed4:2551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 115E9341E5A;
	Mon, 25 May 2026 07:57:09 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: =?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@google.com>
Cc: Sam James <sam@gentoo.org>,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org,
	Calvin Buckley <calvin@cmpct.info>,
	Brad Spengler <brad.spengler@opensrcsec.com>,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] crypto: nx: fix nx_crypto_ctx_exit argument
Date: Mon, 25 May 2026 08:56:19 +0100
Message-ID: <844faa8a75585e4088c95c052dd0ecd189bc3a64.1779695779.git.sam@gentoo.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <b8b1b6fe740187c70349cd04a820d57324e0f70c.1779509289.git.sam@gentoo.org>
References: <b8b1b6fe740187c70349cd04a820d57324e0f70c.1779509289.git.sam@gentoo.org>
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
Content-Transfer-Encoding: 8bit

nx_crypto_ctx_shash_exit calls nx_crypto_ctx_exit with crypto_shash_ctx(...)
but crypto_shash_ctx gives a nx_crypto_ctx *, not a crypto_tfm *.

Fix the type in nx_crypto_ctx_exit and drop the bogus crypto_tfm_ctx
call.

This fixes the following oops:

  BUG: Unable to handle kernel data access at 0xc0403effffffffc8
  Faulting instruction address: 0xc000000000396cb4
  Oops: Kernel access of bad area, sig: 11 [#15]
  Call Trace:
   nx_crypto_ctx_shash_exit+0x24/0x60
   crypto_shash_exit_tfm+0x28/0x40
   crypto_destroy_tfm+0x98/0x140
   crypto_exit_ahash_using_shash+0x20/0x40
   crypto_destroy_tfm+0x98/0x140
   hash_release+0x1c/0x30
   alg_sock_destruct+0x38/0x60
   __sk_destruct+0x48/0x2b0
   af_alg_release+0x58/0xb0
   __sock_release+0x68/0x150
   sock_close+0x20/0x40
   __fput+0x110/0x3a0
   sys_close+0x48/0xa0
   system_call_exception+0x140/0x2d0
   system_call_common+0xf4/0x258

.. which came from hardlink(1) opportunistically using AF_ALG.

The same problem exists with nx_crypto_ctx_skcipher_exit getting a context
it wasn't expecting, but apparently nobody hit that for years.

Cc: Eric Biggers <ebiggers@kernel.org>
Cc: stable@vger.kernel.org
Fixes: bfd9efddf990 ("crypto: nx - convert AES-ECB to skcipher API")
Fixes: 9420e628e7d8 ("crypto: nx - Use API partial block handling")
Acked-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Reported-by: Calvin Buckley <calvin@cmpct.info>
Tested-by: Calvin Buckley <calvin@cmpct.info>
Suggested-by: Brad Spengler <brad.spengler@opensrcsec.com>
Signed-off-by: Sam James <sam@gentoo.org>
---
v3: Fix doc tag.
v2: Add stable cc, fix doc for tfm param.

v1: https://lore.kernel.org/all/a3e89c1e8342ffa415b0d29725a0571a4f355d34.1779472902.git.sam@gentoo.org/
v2: https://lore.kernel.org/all/b8b1b6fe740187c70349cd04a820d57324e0f70c.1779509289.git.sam@gentoo.org/

 drivers/crypto/nx/nx.c | 6 ++----
 drivers/crypto/nx/nx.h | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/nx/nx.c b/drivers/crypto/nx/nx.c
index 78135fb13f5c..1b7509e2ce44 100644
--- a/drivers/crypto/nx/nx.c
+++ b/drivers/crypto/nx/nx.c
@@ -714,15 +714,13 @@ int nx_crypto_ctx_aes_xcbc_init(struct crypto_shash *tfm)
 /**
  * nx_crypto_ctx_exit - destroy a crypto api context
  *
- * @tfm: the crypto transform pointer for the context
+ * @nx_ctx: the crypto api context
  *
  * As crypto API contexts are destroyed, this exit hook is called to free the
  * memory associated with it.
  */
-void nx_crypto_ctx_exit(struct crypto_tfm *tfm)
+void nx_crypto_ctx_exit(struct nx_crypto_ctx *nx_ctx)
 {
-	struct nx_crypto_ctx *nx_ctx = crypto_tfm_ctx(tfm);
-
 	kfree_sensitive(nx_ctx->kmem);
 	nx_ctx->csbcpb = NULL;
 	nx_ctx->csbcpb_aead = NULL;
diff --git a/drivers/crypto/nx/nx.h b/drivers/crypto/nx/nx.h
index 36974f08490a..6dfabfbf8192 100644
--- a/drivers/crypto/nx/nx.h
+++ b/drivers/crypto/nx/nx.h
@@ -153,7 +153,7 @@ int nx_crypto_ctx_aes_ctr_init(struct crypto_skcipher *tfm);
 int nx_crypto_ctx_aes_cbc_init(struct crypto_skcipher *tfm);
 int nx_crypto_ctx_aes_ecb_init(struct crypto_skcipher *tfm);
 int nx_crypto_ctx_sha_init(struct crypto_shash *tfm);
-void nx_crypto_ctx_exit(struct crypto_tfm *tfm);
+void nx_crypto_ctx_exit(struct nx_crypto_ctx *nx_ctx);
 void nx_crypto_ctx_skcipher_exit(struct crypto_skcipher *tfm);
 void nx_crypto_ctx_aead_exit(struct crypto_aead *tfm);
 void nx_crypto_ctx_shash_exit(struct crypto_shash *tfm);

base-commit: 79bd2dded182b1d458b18e62684b7f82ffc682e5
-- 
2.54.0


