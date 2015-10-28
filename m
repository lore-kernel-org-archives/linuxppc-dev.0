Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95F471A0314
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 11:51:32 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/19] crypto: vmx: Only call enable_kernel_vsx()
Date: Wed, 28 Oct 2015 11:50:59 +1100
Message-Id: <1445993467-667-11-git-send-email-anton@samba.org>
In-Reply-To: <1445993467-667-1-git-send-email-anton@samba.org>
References: <1445993467-667-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the recent change to enable_kernel_vsx(), we no longer need
to call enable_kernel_fp() and enable_kernel_altivec().

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 drivers/crypto/vmx/aes.c     | 3 ---
 drivers/crypto/vmx/aes_cbc.c | 3 ---
 drivers/crypto/vmx/aes_ctr.c | 3 ---
 drivers/crypto/vmx/ghash.c   | 8 --------
 4 files changed, 17 deletions(-)

diff --git a/drivers/crypto/vmx/aes.c b/drivers/crypto/vmx/aes.c
index 263af70..20539fb 100644
--- a/drivers/crypto/vmx/aes.c
+++ b/drivers/crypto/vmx/aes.c
@@ -83,7 +83,6 @@ static int p8_aes_setkey(struct crypto_tfm *tfm, const u8 *key,
 
 	preempt_disable();
 	pagefault_disable();
-	enable_kernel_altivec();
 	enable_kernel_vsx();
 	ret = aes_p8_set_encrypt_key(key, keylen * 8, &ctx->enc_key);
 	ret += aes_p8_set_decrypt_key(key, keylen * 8, &ctx->dec_key);
@@ -103,7 +102,6 @@ static void p8_aes_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 	} else {
 		preempt_disable();
 		pagefault_disable();
-		enable_kernel_altivec();
 		enable_kernel_vsx();
 		aes_p8_encrypt(src, dst, &ctx->enc_key);
 		pagefault_enable();
@@ -120,7 +118,6 @@ static void p8_aes_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 	} else {
 		preempt_disable();
 		pagefault_disable();
-		enable_kernel_altivec();
 		enable_kernel_vsx();
 		aes_p8_decrypt(src, dst, &ctx->dec_key);
 		pagefault_enable();
diff --git a/drivers/crypto/vmx/aes_cbc.c b/drivers/crypto/vmx/aes_cbc.c
index 0b8fe2e..8847b92 100644
--- a/drivers/crypto/vmx/aes_cbc.c
+++ b/drivers/crypto/vmx/aes_cbc.c
@@ -84,7 +84,6 @@ static int p8_aes_cbc_setkey(struct crypto_tfm *tfm, const u8 *key,
 
 	preempt_disable();
 	pagefault_disable();
-	enable_kernel_altivec();
 	enable_kernel_vsx();
 	ret = aes_p8_set_encrypt_key(key, keylen * 8, &ctx->enc_key);
 	ret += aes_p8_set_decrypt_key(key, keylen * 8, &ctx->dec_key);
@@ -115,7 +114,6 @@ static int p8_aes_cbc_encrypt(struct blkcipher_desc *desc,
 	} else {
 		preempt_disable();
 		pagefault_disable();
-		enable_kernel_altivec();
 		enable_kernel_vsx();
 
 		blkcipher_walk_init(&walk, dst, src, nbytes);
@@ -156,7 +154,6 @@ static int p8_aes_cbc_decrypt(struct blkcipher_desc *desc,
 	} else {
 		preempt_disable();
 		pagefault_disable();
-		enable_kernel_altivec();
 		enable_kernel_vsx();
 
 		blkcipher_walk_init(&walk, dst, src, nbytes);
diff --git a/drivers/crypto/vmx/aes_ctr.c b/drivers/crypto/vmx/aes_ctr.c
index ee1306c..8095866 100644
--- a/drivers/crypto/vmx/aes_ctr.c
+++ b/drivers/crypto/vmx/aes_ctr.c
@@ -81,7 +81,6 @@ static int p8_aes_ctr_setkey(struct crypto_tfm *tfm, const u8 *key,
 	struct p8_aes_ctr_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	pagefault_disable();
-	enable_kernel_altivec();
 	enable_kernel_vsx();
 	ret = aes_p8_set_encrypt_key(key, keylen * 8, &ctx->enc_key);
 	pagefault_enable();
@@ -100,7 +99,6 @@ static void p8_aes_ctr_final(struct p8_aes_ctr_ctx *ctx,
 	unsigned int nbytes = walk->nbytes;
 
 	pagefault_disable();
-	enable_kernel_altivec();
 	enable_kernel_vsx();
 	aes_p8_encrypt(ctrblk, keystream, &ctx->enc_key);
 	pagefault_enable();
@@ -133,7 +131,6 @@ static int p8_aes_ctr_crypt(struct blkcipher_desc *desc,
 		ret = blkcipher_walk_virt_block(desc, &walk, AES_BLOCK_SIZE);
 		while ((nbytes = walk.nbytes) >= AES_BLOCK_SIZE) {
 			pagefault_disable();
-			enable_kernel_altivec();
 			enable_kernel_vsx();
 			aes_p8_ctr32_encrypt_blocks(walk.src.virt.addr,
 						    walk.dst.virt.addr,
diff --git a/drivers/crypto/vmx/ghash.c b/drivers/crypto/vmx/ghash.c
index 2183a2e..1f4586c 100644
--- a/drivers/crypto/vmx/ghash.c
+++ b/drivers/crypto/vmx/ghash.c
@@ -118,9 +118,7 @@ static int p8_ghash_setkey(struct crypto_shash *tfm, const u8 *key,
 
 	preempt_disable();
 	pagefault_disable();
-	enable_kernel_altivec();
 	enable_kernel_vsx();
-	enable_kernel_fp();
 	gcm_init_p8(ctx->htable, (const u64 *) key);
 	pagefault_enable();
 	preempt_enable();
@@ -149,9 +147,7 @@ static int p8_ghash_update(struct shash_desc *desc,
 			       GHASH_DIGEST_SIZE - dctx->bytes);
 			preempt_disable();
 			pagefault_disable();
-			enable_kernel_altivec();
 			enable_kernel_vsx();
-			enable_kernel_fp();
 			gcm_ghash_p8(dctx->shash, ctx->htable,
 				     dctx->buffer, GHASH_DIGEST_SIZE);
 			pagefault_enable();
@@ -164,9 +160,7 @@ static int p8_ghash_update(struct shash_desc *desc,
 		if (len) {
 			preempt_disable();
 			pagefault_disable();
-			enable_kernel_altivec();
 			enable_kernel_vsx();
-			enable_kernel_fp();
 			gcm_ghash_p8(dctx->shash, ctx->htable, src, len);
 			pagefault_enable();
 			preempt_enable();
@@ -195,9 +189,7 @@ static int p8_ghash_final(struct shash_desc *desc, u8 *out)
 				dctx->buffer[i] = 0;
 			preempt_disable();
 			pagefault_disable();
-			enable_kernel_altivec();
 			enable_kernel_vsx();
-			enable_kernel_fp();
 			gcm_ghash_p8(dctx->shash, ctx->htable,
 				     dctx->buffer, GHASH_DIGEST_SIZE);
 			pagefault_enable();
-- 
2.5.0
