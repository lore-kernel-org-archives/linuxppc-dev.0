Return-Path: <linuxppc-dev+bounces-18433-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577691075261
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 06:21:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbwXD6wFwz3bl7;
	Thu, 19 Mar 2026 17:19:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773901180;
	cv=none; b=G1JsETYF4mrgATdivHee/WQGQY26HJ5+NCZsT/ZFmQQkYRf/m867YYxPk46SEnl2QYgf9xSBVyBCzx5DtVTbwyW2PuedF516RePcmNO69GVcLrrtLFCpyyz8BGKkVVDgmLPyVJw1zxV8K4/cDTEoRtKOZr+yNYtVQC7zyJTFfZTUFnM2tdEzApOkXnxyQ7KDvwlmw04bN3GyuvLuIR+mphqobk3FIVy2MO9QoOeAORkQPWoIt644/7gkpAv362Fb31lNdSLre73fdDdPVhU9B8P8O/R8SlwJ+sEpTnv2IEk7Ytf5q3xcRB7po8//3G2gaWWj0d17pQYqZ0CmleAyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773901180; c=relaxed/relaxed;
	bh=zhsqu63lRwQLsvUDOM5mmkD059b721V1C5RLaqA4si8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ls7uJ1NPUsnYvTnaim1+GtfVGCbp8xurwndnKeykhI2TW1nNVQEFVdSSua6QDNqYxztBWcqlTV4cQXqMqW3yaNoinNZANT3OFkkLLKGzfazSBj8i+gLnKBV1w0rXKLpVA6IN2sdGKXlhkzN0Pr+2aJ9KraBV2Bl1RDFFiK1zyJ4U044A1l9c/RjW/Z15dtJwoQEd/LSYpPM/z/cKnrYU1sHA829dssFrBmkyZO0QUKckO4CS9L58fb8avdDwRynG3jEDM7LpWCXkEYwDVBkFCxcWSTSFOUfZEhe9oYIuTFdbKizJuJwffD6POnTjMp+pMZvrNr6OjnOc2Pptf21KJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m2Y3GEVL; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m2Y3GEVL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbwX6001fz2yrK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 17:19:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0120A61862;
	Thu, 19 Mar 2026 06:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B06FC2BCB2;
	Thu, 19 Mar 2026 06:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773901163;
	bh=3U+NGORzr+uh9rj8G+n62LLimEQQsU/GR7nNllucuSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m2Y3GEVLGtbsHY8WNRU+QFtRIEvKC6sgYmhQjrPtaNQJHos9ekuXQTY0AiXpp5Ygs
	 36CIJ5QSZzuwHHRdIXj6WbXCskrNNkJtG1oBpEzt4z9NgHtoD5om3QeKkjnKsG3DJG
	 olZFYsn7vYCLr4TlueikipE26Ea42XWUA11/b/XDxSNOGqi6H1NzHuQUWQOpKGm0iN
	 4+kAS02ryjXuwJez66eLP6nwrbpJuxJMs8VzC8IO0YNdj3sCyGZ4iS4Uv2hUxZZ2OW
	 MW5pYJD4e1KYvCs/nNWHL7g0aMpyDayR3GGYAzrBIms8gHhr697QWnkIQAZZH0/OBX
	 yhtS5h/NzKhMw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 19/19] lib/crypto: aesgcm: Use GHASH library API
Date: Wed, 18 Mar 2026 23:17:20 -0700
Message-ID: <20260319061723.1140720-20-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319061723.1140720-1-ebiggers@kernel.org>
References: <20260319061723.1140720-1-ebiggers@kernel.org>
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

Make the AES-GCM library use the GHASH library instead of directly
calling gf128mul_lle().  This allows the architecture-optimized GHASH
implementations to be used, or the improved generic implementation if no
architecture-optimized implementation is usable.

Note: this means that <crypto/gcm.h> no longer needs to include
<crypto/gf128mul.h>.  Remove that inclusion, and include
<crypto/gf128mul.h> explicitly from arch/x86/crypto/aesni-intel_glue.c
which previously was relying on the transitive inclusion.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 arch/x86/crypto/aesni-intel_glue.c |  1 +
 include/crypto/gcm.h               |  4 +--
 lib/crypto/Kconfig                 |  2 +-
 lib/crypto/aesgcm.c                | 55 +++++++++++++++---------------
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index e6c38d1d8a92..f522fff9231e 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -23,10 +23,11 @@
 #include <linux/err.h>
 #include <crypto/algapi.h>
 #include <crypto/aes.h>
 #include <crypto/b128ops.h>
 #include <crypto/gcm.h>
+#include <crypto/gf128mul.h>
 #include <crypto/xts.h>
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/internal/aead.h>
diff --git a/include/crypto/gcm.h b/include/crypto/gcm.h
index b524e47bd4d0..1d5f39ff1dc4 100644
--- a/include/crypto/gcm.h
+++ b/include/crypto/gcm.h
@@ -2,11 +2,11 @@
 #define _CRYPTO_GCM_H
 
 #include <linux/errno.h>
 
 #include <crypto/aes.h>
-#include <crypto/gf128mul.h>
+#include <crypto/gf128hash.h>
 
 #define GCM_AES_IV_SIZE 12
 #define GCM_RFC4106_IV_SIZE 8
 #define GCM_RFC4543_IV_SIZE 8
 
@@ -63,11 +63,11 @@ static inline int crypto_ipsec_check_assoclen(unsigned int assoclen)
 
 	return 0;
 }
 
 struct aesgcm_ctx {
-	be128			ghash_key;
+	struct ghash_key	ghash_key;
 	struct aes_enckey	aes_key;
 	unsigned int		authsize;
 };
 
 int aesgcm_expandkey(struct aesgcm_ctx *ctx, const u8 *key,
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index a39e7707e9ee..32fafe245f47 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -39,11 +39,11 @@ config CRYPTO_LIB_AES_CBC_MACS
 	  <crypto/aes-cbc-macs.h>.
 
 config CRYPTO_LIB_AESGCM
 	tristate
 	select CRYPTO_LIB_AES
-	select CRYPTO_LIB_GF128MUL
+	select CRYPTO_LIB_GF128HASH
 	select CRYPTO_LIB_UTILS
 
 config CRYPTO_LIB_ARC4
 	tristate
 
diff --git a/lib/crypto/aesgcm.c b/lib/crypto/aesgcm.c
index 02f5b5f32c76..8c7e74d2d147 100644
--- a/lib/crypto/aesgcm.c
+++ b/lib/crypto/aesgcm.c
@@ -3,13 +3,12 @@
  * Minimal library implementation of GCM
  *
  * Copyright 2022 Google LLC
  */
 
-#include <crypto/algapi.h>
 #include <crypto/gcm.h>
-#include <crypto/ghash.h>
+#include <crypto/utils.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <asm/irqflags.h>
 
 static void aesgcm_encrypt_block(const struct aes_enckey *key, void *dst,
@@ -43,37 +42,26 @@ static void aesgcm_encrypt_block(const struct aes_enckey *key, void *dst,
  * that are not permitted by the GCM specification.
  */
 int aesgcm_expandkey(struct aesgcm_ctx *ctx, const u8 *key,
 		     unsigned int keysize, unsigned int authsize)
 {
-	u8 kin[AES_BLOCK_SIZE] = {};
+	u8 h[AES_BLOCK_SIZE] = {};
 	int ret;
 
 	ret = crypto_gcm_check_authsize(authsize) ?:
 	      aes_prepareenckey(&ctx->aes_key, key, keysize);
 	if (ret)
 		return ret;
 
 	ctx->authsize = authsize;
-	aesgcm_encrypt_block(&ctx->aes_key, &ctx->ghash_key, kin);
-
+	aesgcm_encrypt_block(&ctx->aes_key, h, h);
+	ghash_preparekey(&ctx->ghash_key, h);
+	memzero_explicit(h, sizeof(h));
 	return 0;
 }
 EXPORT_SYMBOL(aesgcm_expandkey);
 
-static void aesgcm_ghash(be128 *ghash, const be128 *key, const void *src,
-			 int len)
-{
-	while (len > 0) {
-		crypto_xor((u8 *)ghash, src, min(len, GHASH_BLOCK_SIZE));
-		gf128mul_lle(ghash, key);
-
-		src += GHASH_BLOCK_SIZE;
-		len -= GHASH_BLOCK_SIZE;
-	}
-}
-
 /**
  * aesgcm_mac - Generates the authentication tag using AES-GCM algorithm.
  * @ctx: The data structure that will hold the AES-GCM key schedule
  * @src: The input source data.
  * @src_len: Length of the source data.
@@ -86,24 +74,37 @@ static void aesgcm_ghash(be128 *ghash, const be128 *key, const void *src,
  * and an output buffer for the authentication tag.
  */
 static void aesgcm_mac(const struct aesgcm_ctx *ctx, const u8 *src, int src_len,
 		       const u8 *assoc, int assoc_len, __be32 *ctr, u8 *authtag)
 {
-	be128 tail = { cpu_to_be64(assoc_len * 8), cpu_to_be64(src_len * 8) };
-	u8 buf[AES_BLOCK_SIZE];
-	be128 ghash = {};
+	static const u8 zeroes[GHASH_BLOCK_SIZE];
+	__be64 tail[2] = {
+		cpu_to_be64((u64)assoc_len * 8),
+		cpu_to_be64((u64)src_len * 8),
+	};
+	struct ghash_ctx ghash;
+	u8 ghash_out[AES_BLOCK_SIZE];
+	u8 enc_ctr[AES_BLOCK_SIZE];
+
+	ghash_init(&ghash, &ctx->ghash_key);
+
+	ghash_update(&ghash, assoc, assoc_len);
+	ghash_update(&ghash, zeroes, -assoc_len & (GHASH_BLOCK_SIZE - 1));
 
-	aesgcm_ghash(&ghash, &ctx->ghash_key, assoc, assoc_len);
-	aesgcm_ghash(&ghash, &ctx->ghash_key, src, src_len);
-	aesgcm_ghash(&ghash, &ctx->ghash_key, &tail, sizeof(tail));
+	ghash_update(&ghash, src, src_len);
+	ghash_update(&ghash, zeroes, -src_len & (GHASH_BLOCK_SIZE - 1));
+
+	ghash_update(&ghash, (const u8 *)&tail, sizeof(tail));
+
+	ghash_final(&ghash, ghash_out);
 
 	ctr[3] = cpu_to_be32(1);
-	aesgcm_encrypt_block(&ctx->aes_key, buf, ctr);
-	crypto_xor_cpy(authtag, buf, (u8 *)&ghash, ctx->authsize);
+	aesgcm_encrypt_block(&ctx->aes_key, enc_ctr, ctr);
+	crypto_xor_cpy(authtag, ghash_out, enc_ctr, ctx->authsize);
 
-	memzero_explicit(&ghash, sizeof(ghash));
-	memzero_explicit(buf, sizeof(buf));
+	memzero_explicit(ghash_out, sizeof(ghash_out));
+	memzero_explicit(enc_ctr, sizeof(enc_ctr));
 }
 
 static void aesgcm_crypt(const struct aesgcm_ctx *ctx, u8 *dst, const u8 *src,
 			 int len, __be32 *ctr)
 {
-- 
2.53.0


