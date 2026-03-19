Return-Path: <linuxppc-dev+bounces-18427-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF081075262
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 06:20:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbwX65HCLz30Wh;
	Thu, 19 Mar 2026 17:19:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773901174;
	cv=none; b=gsVEJ4dwV7O6KffBXlP1x/vuesHcMiWG1pDrUtnWPrcd/KqaW5NcF3ENiOxnEHejxZw0GMxuSAiZhTwgJZYm9WLk/dl5f37lobwL123guOYWYoGyMje/XqLMoHcqPWhwX86fkhmUMttVnxTSjSVSOWGUNwr++FJk9IorF7BSH412GBcaFPcwhyduU+Q7/3rzOna/Ry7+mQKAkvMiYhMy3BLALJ3BHDZyKJWemjMERlwfmfoy94SXXEG23hiw2xK45U0ij3pFnK9HsnVLlh9neV1aw6bbo5Xvcp8AlMnf9kADhswrN+XTsIMvXIwGHXJppOPCoR0wfj88yPGvPlnAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773901174; c=relaxed/relaxed;
	bh=33KTucnLU+VJdkf+Koy62bkJyMfrD+/Fe3LqzQr7h5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvLfKYDhwJAV+gbQLmjk34kqHa+4W5XMxPyc84GSI4CK171KSSdE1hd12UiycFvi9FXcs8UUggWfEpFtFOlp3taRwDWmjnqh4DRKcA5+2YYrfk3jgu7WqmZ5PQYUULVGboB1CVPzuMvDzqpzeMwtAnB8mA0uVmYEvgXjfI6+vwExcKaKCtu2rdpZfJU6xPN0xdlXrXFqYUNFgo55lyMxDcoyo8qzXkIahWP9v6JiXp9UNSwg+lUEzmP4HZalqpkPAzQsApFRHxXxTvoZozjqhKCnvqp3YXGWabYTqtA1W1KQmeVoDM9sHR7641oXZFjiDxTXZexySvTu7m/5M1jmmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qUjaGrt7; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qUjaGrt7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbwWw4Chsz2ynW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 17:19:24 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 064BF44720;
	Thu, 19 Mar 2026 06:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78620C2BCB3;
	Thu, 19 Mar 2026 06:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773901162;
	bh=mTRLUTdGzhcdizBLZYtXG0wi5TCm65S4qlvgr+wYUYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUjaGrt7RFDnbK+cIlqFbgJnk6RjjiIP4nOUXjksgVsooOttsP6ts10f9DTl8O1LL
	 fltmBuZVfF4AgTiJWgwJpoljMMtZvb1kGG1F8wwoAvdwrtEKtC+mdAi2Ie7ox16kJ0
	 aPxVeBkcYFwJLXZB2NkYHm93FvphnZNvhSEZ1qO6kngwuTmb64LuUjgHg3brwwDaVz
	 rvUSK30xdWlSDu5/JM8w8gPwvKmXljbiOQiOhp7P9c5k91Qe88X67tUuicrNsDvd7e
	 X9JHCcVGW72qMY4IPT8WssLvoWtjXoBYf8FZoAx4HmznfMi6YdscUdMDOR1zRH+lfJ
	 cMpc+5cqAOd/A==
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
Subject: [PATCH 17/19] lib/crypto: gf128mul: Remove unused 4k_lle functions
Date: Wed, 18 Mar 2026 23:17:18 -0700
Message-ID: <20260319061723.1140720-18-ebiggers@kernel.org>
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

Remove the 4k_lle multiplication functions and the associated
gf128mul_table_le data table.  Their only user was the generic
implementation of GHASH, which has now been changed to use a different
implementation based on standard integer multiplication.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/crypto/gf128mul.h | 17 ++-------
 lib/crypto/gf128mul.c     | 73 +--------------------------------------
 2 files changed, 4 insertions(+), 86 deletions(-)

diff --git a/include/crypto/gf128mul.h b/include/crypto/gf128mul.h
index b0853f7cada0..6ed2a8351902 100644
--- a/include/crypto/gf128mul.h
+++ b/include/crypto/gf128mul.h
@@ -213,29 +213,18 @@ static inline void gf128mul_x_ble(le128 *r, const le128 *x)
 
 	r->a = cpu_to_le64((a << 1) | (b >> 63));
 	r->b = cpu_to_le64((b << 1) ^ _tt);
 }
 
-/* 4k table optimization */
-
-struct gf128mul_4k {
-	be128 t[256];
-};
-
-struct gf128mul_4k *gf128mul_init_4k_lle(const be128 *g);
-void gf128mul_4k_lle(be128 *a, const struct gf128mul_4k *t);
 void gf128mul_x8_ble(le128 *r, const le128 *x);
-static inline void gf128mul_free_4k(struct gf128mul_4k *t)
-{
-	kfree_sensitive(t);
-}
-
 
 /* 64k table optimization, implemented for bbe */
 
 struct gf128mul_64k {
-	struct gf128mul_4k *t[16];
+	struct {
+		be128 t[256];
+	} *t[16];
 };
 
 /* First initialize with the constant factor with which you
  * want to multiply and then call gf128mul_64k_bbe with the other
  * factor in the first argument, and the table in the second.
diff --git a/lib/crypto/gf128mul.c b/lib/crypto/gf128mul.c
index e5a727b15f07..7ebf07ce1168 100644
--- a/lib/crypto/gf128mul.c
+++ b/lib/crypto/gf128mul.c
@@ -125,31 +125,13 @@
 	(i & 0x20 ? 0x3840 : 0) ^ (i & 0x10 ? 0x1c20 : 0) ^ \
 	(i & 0x08 ? 0x0e10 : 0) ^ (i & 0x04 ? 0x0708 : 0) ^ \
 	(i & 0x02 ? 0x0384 : 0) ^ (i & 0x01 ? 0x01c2 : 0) \
 )
 
-static const u16 gf128mul_table_le[256] = gf128mul_dat(xda_le);
 static const u16 gf128mul_table_be[256] = gf128mul_dat(xda_be);
 
-/*
- * The following functions multiply a field element by x^8 in
- * the polynomial field representation.  They use 64-bit word operations
- * to gain speed but compensate for machine endianness and hence work
- * correctly on both styles of machine.
- */
-
-static void gf128mul_x8_lle(be128 *x)
-{
-	u64 a = be64_to_cpu(x->a);
-	u64 b = be64_to_cpu(x->b);
-	u64 _tt = gf128mul_table_le[b & 0xff];
-
-	x->b = cpu_to_be64((b >> 8) | (a << 56));
-	x->a = cpu_to_be64((a >> 8) ^ (_tt << 48));
-}
-
-/* time invariant version of gf128mul_x8_lle */
+/* A table-less implementation of multiplying by x^8 */
 static void gf128mul_x8_lle_ti(be128 *x)
 {
 	u64 a = be64_to_cpu(x->a);
 	u64 b = be64_to_cpu(x->b);
 	u64 _tt = xda_le(b & 0xff); /* avoid table lookup */
@@ -303,60 +285,7 @@ void gf128mul_64k_bbe(be128 *a, const struct gf128mul_64k *t)
 		be128_xor(r, r, &t->t[i]->t[ap[15 - i]]);
 	*a = *r;
 }
 EXPORT_SYMBOL(gf128mul_64k_bbe);
 
-/*      This version uses 4k bytes of table space.
-    A 16 byte buffer has to be multiplied by a 16 byte key
-    value in GF(2^128).  If we consider a GF(2^128) value in a
-    single byte, we can construct a table of the 256 16 byte
-    values that result from the 256 values of this byte.
-    This requires 4096 bytes. If we take the highest byte in
-    the buffer and use this table to get the result, we then
-    have to multiply by x^120 to get the final value. For the
-    next highest byte the result has to be multiplied by x^112
-    and so on. But we can do this by accumulating the result
-    in an accumulator starting with the result for the top
-    byte.  We repeatedly multiply the accumulator value by
-    x^8 and then add in (i.e. xor) the 16 bytes of the next
-    lower byte in the buffer, stopping when we reach the
-    lowest byte. This requires a 4096 byte table.
-*/
-struct gf128mul_4k *gf128mul_init_4k_lle(const be128 *g)
-{
-	struct gf128mul_4k *t;
-	int j, k;
-
-	t = kzalloc_obj(*t);
-	if (!t)
-		goto out;
-
-	t->t[128] = *g;
-	for (j = 64; j > 0; j >>= 1)
-		gf128mul_x_lle(&t->t[j], &t->t[j+j]);
-
-	for (j = 2; j < 256; j += j)
-		for (k = 1; k < j; ++k)
-			be128_xor(&t->t[j + k], &t->t[j], &t->t[k]);
-
-out:
-	return t;
-}
-EXPORT_SYMBOL(gf128mul_init_4k_lle);
-
-void gf128mul_4k_lle(be128 *a, const struct gf128mul_4k *t)
-{
-	u8 *ap = (u8 *)a;
-	be128 r[1];
-	int i = 15;
-
-	*r = t->t[ap[15]];
-	while (i--) {
-		gf128mul_x8_lle(r);
-		be128_xor(r, r, &t->t[ap[i]]);
-	}
-	*a = *r;
-}
-EXPORT_SYMBOL(gf128mul_4k_lle);
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Functions for multiplying elements of GF(2^128)");
-- 
2.53.0


