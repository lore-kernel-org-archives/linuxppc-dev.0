Return-Path: <linuxppc-dev+bounces-18432-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87C21075260
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 06:21:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbwXD0vq4z3bjc;
	Thu, 19 Mar 2026 17:19:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773901179;
	cv=none; b=LKK5LXk3CbXEKKFOsZJVaUaRWSGKmCRPzC4U5CUt2nYwOusxWCBO/I5PCJgPdDoG+wz90BlsUqlVQJ3/iqOwsi8rP4UgHKIvPP3lao77h9BEOJnSS6W+Gak4VCYfmspg7bwGuNIYe3sUmtYYS1hjG2yZifHK3Jj/OHprQbuf/u/ifl5lj1RSocTaRo56xKeI5t6YhX8fQz2TgNjH0z2EnORMD7QDj7CQTyksmk3IqWD0Cp6/e+VB1I0kUUmPZp0gAR5OZ9vZKHeQrZz/ipnjoOEa7xrb59JWdKXJ4TQC8FULbnOjAMZpUzXQUwXgyuUsLoBaRUV5IP44sfqWFrBIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773901179; c=relaxed/relaxed;
	bh=7uugS5B/tI5rmffJG4qjhUzsxChNc1RoUkWcxWbwAyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXIBhzonDtMpPIC2us1hzHIvEmMBYdCPIwp2p/yNneaUiDRWP5CRR6AeYCoOM+ElsR4hNPW/d1wmvhZj1HgxlNJjm/6yUIY79vfWpuQIJWBbJvYGFlD+MGbgFk0RkvPua3LlcwppSlDkNrUIiZjFpJemEqjNYpW/DCtEsOmcTy1E0Gw50QwkYcMcsvMu8YQ4nr33NJWx2BwMWLSZpfZ9sgNDo3+pqfiLyE5WqT2X4fQkBelGEdt6Xgn/1yMeSkdnwD6kaKBKi4LBJkuc9feg1cR+CL4/KRrp1+++wYKphk93/MQxfXGe+TJB6C0q6k+5Cm6VpNhzzBZ8+LL1HMkA7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LtLToKlg; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LtLToKlg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbwWy1tx8z2yvh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 17:19:25 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DD0CF61860;
	Thu, 19 Mar 2026 06:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CFAC2BCC9;
	Thu, 19 Mar 2026 06:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773901160;
	bh=7F7ndcFH8rpPiACNbtYxCLPxNZA0C89ig93X3UFOhZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LtLToKlgA0+Pk4GjTlYNad6rvHvHbEP/2D3kndnAGFI1vz5KKAGFs1+R+SwEgJXO8
	 HQbMb6bXMWgJVHvmjee84xWTWOzkHZ5i2XUw5vG9WYRbpoThUyDHWaQlFZ9MaABGo2
	 IiiR8rZuYEQBM3NpxG1cPccwPVLZezGnovy4A/EK05lEICEgEH54q6KrgAYlcrcVvW
	 6hTnWXcqDfGFkeJe7m8YD9h/6qVmQqqDpydEODU3dhxIIqxXb2Lbwc3XJu9APpryvN
	 PhH/eiY+dyPlSjSeQemdVtcw6QvNayZP1xVoHu9PrhGn9/YsRBOEtSYwmfpda3vkVu
	 2c4i/tSpO0www==
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
Subject: [PATCH 13/19] lib/crypto: s390/ghash: Migrate optimized code into library
Date: Wed, 18 Mar 2026 23:17:14 -0700
Message-ID: <20260319061723.1140720-14-ebiggers@kernel.org>
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

Remove the "ghash-s390" crypto_shash algorithm, and replace it with an
implementation of ghash_blocks_arch() for the GHASH library.

This makes the GHASH library be optimized with CPACF.  It also greatly
reduces the amount of s390-specific glue code that is needed, and it
fixes the issue where this GHASH optimization was disabled by default.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 arch/s390/configs/debug_defconfig |   1 -
 arch/s390/configs/defconfig       |   1 -
 arch/s390/crypto/Kconfig          |  10 ---
 arch/s390/crypto/Makefile         |   1 -
 arch/s390/crypto/ghash_s390.c     | 144 ------------------------------
 include/crypto/gf128hash.h        |   3 +-
 lib/crypto/Kconfig                |   1 +
 lib/crypto/s390/gf128hash.h       |  54 +++++++++++
 8 files changed, 57 insertions(+), 158 deletions(-)
 delete mode 100644 arch/s390/crypto/ghash_s390.c
 create mode 100644 lib/crypto/s390/gf128hash.h

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 98fd0a2f51c6..aa862d4fcc68 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -807,11 +807,10 @@ CONFIG_CRYPTO_LZ4HC=m
 CONFIG_CRYPTO_ZSTD=m
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_GHASH_S390=m
 CONFIG_CRYPTO_AES_S390=m
 CONFIG_CRYPTO_DES_S390=m
 CONFIG_CRYPTO_HMAC_S390=m
 CONFIG_ZCRYPT=m
 CONFIG_PKEY=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 0f4cedcab3ce..74f943307c46 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -792,11 +792,10 @@ CONFIG_CRYPTO_ZSTD=m
 CONFIG_CRYPTO_JITTERENTROPY_OSR=1
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_GHASH_S390=m
 CONFIG_CRYPTO_AES_S390=m
 CONFIG_CRYPTO_DES_S390=m
 CONFIG_CRYPTO_HMAC_S390=m
 CONFIG_ZCRYPT=m
 CONFIG_PKEY=m
diff --git a/arch/s390/crypto/Kconfig b/arch/s390/crypto/Kconfig
index 79a2d0034258..ee83052dbc15 100644
--- a/arch/s390/crypto/Kconfig
+++ b/arch/s390/crypto/Kconfig
@@ -1,19 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
 menu "Accelerated Cryptographic Algorithms for CPU (s390)"
 
-config CRYPTO_GHASH_S390
-	tristate "Hash functions: GHASH"
-	select CRYPTO_HASH
-	help
-	  GCM GHASH hash function (NIST SP800-38D)
-
-	  Architecture: s390
-
-	  It is available as of z196.
-
 config CRYPTO_AES_S390
 	tristate "Ciphers: AES, modes: ECB, CBC, CTR, XTS, GCM"
 	select CRYPTO_SKCIPHER
 	help
 	  AEAD cipher: AES with GCM
diff --git a/arch/s390/crypto/Makefile b/arch/s390/crypto/Makefile
index 387a229e1038..4449c1b19ef5 100644
--- a/arch/s390/crypto/Makefile
+++ b/arch/s390/crypto/Makefile
@@ -5,9 +5,8 @@
 
 obj-$(CONFIG_CRYPTO_DES_S390) += des_s390.o
 obj-$(CONFIG_CRYPTO_AES_S390) += aes_s390.o
 obj-$(CONFIG_CRYPTO_PAES_S390) += paes_s390.o
 obj-$(CONFIG_S390_PRNG) += prng.o
-obj-$(CONFIG_CRYPTO_GHASH_S390) += ghash_s390.o
 obj-$(CONFIG_CRYPTO_HMAC_S390) += hmac_s390.o
 obj-$(CONFIG_CRYPTO_PHMAC_S390) += phmac_s390.o
 obj-y += arch_random.o
diff --git a/arch/s390/crypto/ghash_s390.c b/arch/s390/crypto/ghash_s390.c
deleted file mode 100644
index dcbcee37cb63..000000000000
--- a/arch/s390/crypto/ghash_s390.c
+++ /dev/null
@@ -1,144 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Cryptographic API.
- *
- * s390 implementation of the GHASH algorithm for GCM (Galois/Counter Mode).
- *
- * Copyright IBM Corp. 2011
- * Author(s): Gerald Schaefer <gerald.schaefer@de.ibm.com>
- */
-
-#include <asm/cpacf.h>
-#include <crypto/ghash.h>
-#include <crypto/internal/hash.h>
-#include <linux/cpufeature.h>
-#include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/string.h>
-
-struct s390_ghash_ctx {
-	u8 key[GHASH_BLOCK_SIZE];
-};
-
-struct s390_ghash_desc_ctx {
-	u8 icv[GHASH_BLOCK_SIZE];
-	u8 key[GHASH_BLOCK_SIZE];
-};
-
-static int ghash_init(struct shash_desc *desc)
-{
-	struct s390_ghash_ctx *ctx = crypto_shash_ctx(desc->tfm);
-	struct s390_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
-
-	memset(dctx, 0, sizeof(*dctx));
-	memcpy(dctx->key, ctx->key, GHASH_BLOCK_SIZE);
-
-	return 0;
-}
-
-static int ghash_setkey(struct crypto_shash *tfm,
-			const u8 *key, unsigned int keylen)
-{
-	struct s390_ghash_ctx *ctx = crypto_shash_ctx(tfm);
-
-	if (keylen != GHASH_BLOCK_SIZE)
-		return -EINVAL;
-
-	memcpy(ctx->key, key, GHASH_BLOCK_SIZE);
-
-	return 0;
-}
-
-static int ghash_update(struct shash_desc *desc,
-			 const u8 *src, unsigned int srclen)
-{
-	struct s390_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
-	unsigned int n;
-
-	n = srclen & ~(GHASH_BLOCK_SIZE - 1);
-	cpacf_kimd(CPACF_KIMD_GHASH, dctx, src, n);
-	return srclen - n;
-}
-
-static void ghash_flush(struct s390_ghash_desc_ctx *dctx, const u8 *src,
-			unsigned int len)
-{
-	if (len) {
-		u8 buf[GHASH_BLOCK_SIZE] = {};
-
-		memcpy(buf, src, len);
-		cpacf_kimd(CPACF_KIMD_GHASH, dctx, buf, GHASH_BLOCK_SIZE);
-		memzero_explicit(buf, sizeof(buf));
-	}
-}
-
-static int ghash_finup(struct shash_desc *desc, const u8 *src,
-		       unsigned int len, u8 *dst)
-{
-	struct s390_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
-
-	ghash_flush(dctx, src, len);
-	memcpy(dst, dctx->icv, GHASH_BLOCK_SIZE);
-	return 0;
-}
-
-static int ghash_export(struct shash_desc *desc, void *out)
-{
-	struct s390_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
-
-	memcpy(out, dctx->icv, GHASH_DIGEST_SIZE);
-	return 0;
-}
-
-static int ghash_import(struct shash_desc *desc, const void *in)
-{
-	struct s390_ghash_ctx *ctx = crypto_shash_ctx(desc->tfm);
-	struct s390_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
-
-	memcpy(dctx->icv, in, GHASH_DIGEST_SIZE);
-	memcpy(dctx->key, ctx->key, GHASH_BLOCK_SIZE);
-	return 0;
-}
-
-static struct shash_alg ghash_alg = {
-	.digestsize	= GHASH_DIGEST_SIZE,
-	.init		= ghash_init,
-	.update		= ghash_update,
-	.finup		= ghash_finup,
-	.setkey		= ghash_setkey,
-	.export		= ghash_export,
-	.import		= ghash_import,
-	.statesize	= sizeof(struct ghash_desc_ctx),
-	.descsize	= sizeof(struct s390_ghash_desc_ctx),
-	.base		= {
-		.cra_name		= "ghash",
-		.cra_driver_name	= "ghash-s390",
-		.cra_priority		= 300,
-		.cra_flags		= CRYPTO_AHASH_ALG_BLOCK_ONLY,
-		.cra_blocksize		= GHASH_BLOCK_SIZE,
-		.cra_ctxsize		= sizeof(struct s390_ghash_ctx),
-		.cra_module		= THIS_MODULE,
-	},
-};
-
-static int __init ghash_mod_init(void)
-{
-	if (!cpacf_query_func(CPACF_KIMD, CPACF_KIMD_GHASH))
-		return -ENODEV;
-
-	return crypto_register_shash(&ghash_alg);
-}
-
-static void __exit ghash_mod_exit(void)
-{
-	crypto_unregister_shash(&ghash_alg);
-}
-
-module_cpu_feature_match(S390_CPU_FEATURE_MSA, ghash_mod_init);
-module_exit(ghash_mod_exit);
-
-MODULE_ALIAS_CRYPTO("ghash");
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("GHASH hash function, s390 implementation");
diff --git a/include/crypto/gf128hash.h b/include/crypto/gf128hash.h
index b798438cce23..0bc649d01e12 100644
--- a/include/crypto/gf128hash.h
+++ b/include/crypto/gf128hash.h
@@ -42,11 +42,12 @@ struct polyval_elem {
  */
 struct ghash_key {
 #if defined(CONFIG_CRYPTO_LIB_GF128HASH_ARCH) && defined(CONFIG_PPC64)
 	/** @htable: GHASH key format used by the POWER8 assembly code */
 	u64 htable[4][2];
-#elif defined(CONFIG_CRYPTO_LIB_GF128HASH_ARCH) && defined(CONFIG_RISCV)
+#elif defined(CONFIG_CRYPTO_LIB_GF128HASH_ARCH) && \
+	(defined(CONFIG_RISCV) || defined(CONFIG_S390))
 	/** @h_raw: The hash key H, in GHASH format */
 	u8 h_raw[GHASH_BLOCK_SIZE];
 #endif
 	/** @h: The hash key H, in POLYVAL format */
 	struct polyval_elem h;
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 027802e0de33..a39e7707e9ee 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -122,10 +122,11 @@ config CRYPTO_LIB_GF128HASH_ARCH
 	default y if ARM && KERNEL_MODE_NEON
 	default y if ARM64
 	default y if PPC64 && VSX
 	default y if RISCV && 64BIT && TOOLCHAIN_HAS_VECTOR_CRYPTO && \
 		     RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS
+	default y if S390
 	default y if X86_64
 
 config CRYPTO_LIB_MD5
 	tristate
 	help
diff --git a/lib/crypto/s390/gf128hash.h b/lib/crypto/s390/gf128hash.h
new file mode 100644
index 000000000000..1e46ce4bca40
--- /dev/null
+++ b/lib/crypto/s390/gf128hash.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * GHASH optimized using the CP Assist for Cryptographic Functions (CPACF)
+ *
+ * Copyright 2026 Google LLC
+ */
+#include <asm/cpacf.h>
+#include <linux/cpufeature.h>
+
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_cpacf_ghash);
+
+#define ghash_preparekey_arch ghash_preparekey_arch
+static void ghash_preparekey_arch(struct ghash_key *key,
+				  const u8 raw_key[GHASH_BLOCK_SIZE])
+{
+	/* Save key in POLYVAL format for fallback */
+	ghash_key_to_polyval(raw_key, &key->h);
+
+	/* Save key in GHASH format for CPACF_KIMD_GHASH */
+	memcpy(key->h_raw, raw_key, GHASH_BLOCK_SIZE);
+}
+
+#define ghash_blocks_arch ghash_blocks_arch
+static void ghash_blocks_arch(struct polyval_elem *acc,
+			      const struct ghash_key *key,
+			      const u8 *data, size_t nblocks)
+{
+	if (static_branch_likely(&have_cpacf_ghash)) {
+		/*
+		 * CPACF_KIMD_GHASH requires the accumulator and key in a single
+		 * buffer, each using the GHASH convention.
+		 */
+		u8 ctx[2][GHASH_BLOCK_SIZE] __aligned(8);
+
+		polyval_acc_to_ghash(acc, ctx[0]);
+		memcpy(ctx[1], key->h_raw, GHASH_BLOCK_SIZE);
+
+		cpacf_kimd(CPACF_KIMD_GHASH, ctx, data,
+			   nblocks * GHASH_BLOCK_SIZE);
+
+		ghash_acc_to_polyval(ctx[0], acc);
+		memzero_explicit(ctx, sizeof(ctx));
+	} else {
+		ghash_blocks_generic(acc, &key->h, data, nblocks);
+	}
+}
+
+#define gf128hash_mod_init_arch gf128hash_mod_init_arch
+static void gf128hash_mod_init_arch(void)
+{
+	if (cpu_have_feature(S390_CPU_FEATURE_MSA) &&
+	    cpacf_query_func(CPACF_KIMD, CPACF_KIMD_GHASH))
+		static_branch_enable(&have_cpacf_ghash);
+}
-- 
2.53.0


