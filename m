Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ACFC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:38:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B3020875
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PJcLwtVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B3020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RNSW6ky1zF3Rw
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:38:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PJcLwtVX";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="PJcLwtVX"; 
 dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RMwM3CgvzF3Mp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 18:13:55 +1000 (AEST)
Received: by mail-wm1-x343.google.com with SMTP id 189-v6so986339wmw.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 01:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=A+1FdRMKX5kWT68MST48ZYdoIobJ5B3kYMhv71JKOAg=;
 b=PJcLwtVXRuyJPKWbbwJBGaYD/0+A6pH/bRN1v8Ky+MsOeDl1X8nZVqwwcKBgUCWjct
 PMh/eQPIxbpQRmrMSUG0NVWRyNWL60QRHPjdWY8s3j9dnprSTAVQeym8nwAdgE0Kfn39
 qt/i7giQasS5aiIXOxSLGpmt7KZ1soLYUoyuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=A+1FdRMKX5kWT68MST48ZYdoIobJ5B3kYMhv71JKOAg=;
 b=MOmqdWP+9hekt4VdLbmo7oEYCioyBAxzW4D4FpGYKt5QFyw0ToWy6ZUyvbfhrxhgny
 1KiuvKB1ukXhIE/swvHhruRgOwU5f/01xxRaOe2v/6eaK7pxlNedH/lgNK1FTAMUhvkc
 smyaMjdy7Fx+fMosYpRkkuf+51eLykKI4Em5PJ6e8a9tyM/OKshuAHxgt5cR1ZfC4/p2
 OzafgOr63aI6xLFA/Ie99l+efI3cqKLaK212m9NxqO9eAu5er5B6UIhsu8Ik72PBEr4p
 07r1qWPY/Dy+P2ghTxogBvLnPe0Omkk19yu1RBvehhLYnYMyMBCB97cqldi8i3rdg6de
 5pxA==
X-Gm-Message-State: ABuFfogpPv/ag5yJ6EPosjJY6NYSeK59bBNFsQ32Y9ZmUTazUzeNz7vq
 At9zyT2k2mtfqTZmyuFu1iL2Bw==
X-Google-Smtp-Source: ACcGV61whWAPedlj0YXt2r0zQodYfSJJwK7RNqx61OHr39dNjfuLTcFQbE9SyFx0akoRNcAg/V4cJg==
X-Received: by 2002:a1c:9e8f:: with SMTP id
 h137-v6mr380822wme.142.1538727232789; 
 Fri, 05 Oct 2018 01:13:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
 by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 01:13:52 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 9/9] crypto: crc-t10dif/x86 - move PMULL based code into
 core library
Date: Fri,  5 Oct 2018 10:13:33 +0200
Message-Id: <20181005081333.15018-10-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
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
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Samuel Neves <sneves@dei.uc.pt>, Paul Mackerras <paulus@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>,
 Eric Biggers <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-crypto@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Move the PMULL based routines out of the crypto API into the core
CRC-T10DIF library.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/crypto/crct10dif-pclmul_glue.c | 98 +++-----------------
 1 file changed, 13 insertions(+), 85 deletions(-)

diff --git a/arch/x86/crypto/crct10dif-pclmul_glue.c b/arch/x86/crypto/crct10dif-pclmul_glue.c
index cd4df9322501..47f0017ad7f3 100644
--- a/arch/x86/crypto/crct10dif-pclmul_glue.c
+++ b/arch/x86/crypto/crct10dif-pclmul_glue.c
@@ -25,7 +25,7 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/crc-t10dif.h>
-#include <crypto/internal/hash.h>
+#include <linux/ffp.h>
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
@@ -36,90 +36,17 @@
 asmlinkage __u16 crc_t10dif_pcl(__u16 crc, const unsigned char *buf,
 				size_t len);
 
-struct chksum_desc_ctx {
-	__u16 crc;
-};
-
-/*
- * Steps through buffer one byte at at time, calculates reflected
- * crc using table.
- */
-
-static int chksum_init(struct shash_desc *desc)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	ctx->crc = 0;
-
-	return 0;
-}
-
-static int chksum_update(struct shash_desc *desc, const u8 *data,
-			 unsigned int length)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	if (irq_fpu_usable()) {
-		kernel_fpu_begin();
-		ctx->crc = crc_t10dif_pcl(ctx->crc, data, length);
-		kernel_fpu_end();
-	} else
-		ctx->crc = crc_t10dif_generic(ctx->crc, data, length);
-	return 0;
-}
-
-static int chksum_final(struct shash_desc *desc, u8 *out)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	*(__u16 *)out = ctx->crc;
-	return 0;
-}
-
-static int __chksum_finup(__u16 *crcp, const u8 *data, unsigned int len,
-			u8 *out)
+static __u16 crct10dif_update_x86(__u16 crc, const u8 *data, unsigned int length)
 {
 	if (irq_fpu_usable()) {
 		kernel_fpu_begin();
-		*(__u16 *)out = crc_t10dif_pcl(*crcp, data, len);
+		crc = crc_t10dif_pcl(crc, data, length);
 		kernel_fpu_end();
-	} else
-		*(__u16 *)out = crc_t10dif_generic(*crcp, data, len);
-	return 0;
-}
-
-static int chksum_finup(struct shash_desc *desc, const u8 *data,
-			unsigned int len, u8 *out)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	return __chksum_finup(&ctx->crc, data, len, out);
-}
-
-static int chksum_digest(struct shash_desc *desc, const u8 *data,
-			 unsigned int length, u8 *out)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	return __chksum_finup(&ctx->crc, data, length, out);
-}
-
-static struct shash_alg alg = {
-	.digestsize		=	CRC_T10DIF_DIGEST_SIZE,
-	.init		=	chksum_init,
-	.update		=	chksum_update,
-	.final		=	chksum_final,
-	.finup		=	chksum_finup,
-	.digest		=	chksum_digest,
-	.descsize		=	sizeof(struct chksum_desc_ctx),
-	.base			=	{
-		.cra_name		=	"crct10dif",
-		.cra_driver_name	=	"crct10dif-pclmul",
-		.cra_priority		=	200,
-		.cra_blocksize		=	CRC_T10DIF_BLOCK_SIZE,
-		.cra_module		=	THIS_MODULE,
+	} else {
+		crc = crc_t10dif_generic(crc, data, length);
 	}
-};
+	return crc;
+}
 
 static const struct x86_cpu_id crct10dif_cpu_id[] = {
 	X86_FEATURE_MATCH(X86_FEATURE_PCLMULQDQ),
@@ -132,12 +59,16 @@ static int __init crct10dif_intel_mod_init(void)
 	if (!x86_match_cpu(crct10dif_cpu_id))
 		return -ENODEV;
 
-	return crypto_register_shash(&alg);
+	SET_FFP(crc_t10dif_update_arch, crct10dif_update_x86);
+
+	return 0;
 }
 
 static void __exit crct10dif_intel_mod_fini(void)
 {
-	crypto_unregister_shash(&alg);
+	RESET_FFP(crc_t10dif_update_arch);
+	/* wait for all users to switch back to the old version */
+	synchronize_rcu();
 }
 
 module_init(crct10dif_intel_mod_init);
@@ -146,6 +77,3 @@ module_exit(crct10dif_intel_mod_fini);
 MODULE_AUTHOR("Tim Chen <tim.c.chen@linux.intel.com>");
 MODULE_DESCRIPTION("T10 DIF CRC calculation accelerated with PCLMULQDQ.");
 MODULE_LICENSE("GPL");
-
-MODULE_ALIAS_CRYPTO("crct10dif");
-MODULE_ALIAS_CRYPTO("crct10dif-pclmul");
-- 
2.11.0

