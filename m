Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD67C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:28:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E0D20652
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="de+kc9fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E0D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RNDc16HvzF3RF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:28:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="de+kc9fs";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="de+kc9fs"; 
 dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RMwF2BwzzF3LS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 18:13:49 +1000 (AEST)
Received: by mail-wm1-x343.google.com with SMTP id 185-v6so1028509wmt.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 01:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BPVA95HGlQkQ8R4OJEDdFwk26jpvhoTlnJX6hJlBlqw=;
 b=de+kc9fsZ4BjBKbbhzZrYUMq4lHYmA2vJFroD9TaHnog+QwlRkYWgz+hr1/fdeK2OC
 IyauWZM3k2PDGmd0msOw0d3zhlUGxbRNkeYk0lR3xcdIIZuvqGI85mWFDFE6IkdE4zfj
 NpLaGFTYQMdPLGYkiqxBV67e30UPsXDrw4d4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BPVA95HGlQkQ8R4OJEDdFwk26jpvhoTlnJX6hJlBlqw=;
 b=gVs8PCJmBX9udDFWtsSsdmc99vApmIxTQCymkFJx75TClZyN6IOdNoptn63fcTv3Pe
 /5cqQJFim4PsWVcotC3TwzWJhL9xmXn+SHeeqS2JCuWKRQ89/9pyNak3K7NolKQnFOOz
 C+OJhCBT7rpAGOTPAXz4QZT3VNHJgW1rVP10/w5DSUbdvh5S6oBkUpviTCLb6ojE6jvM
 qimIHBepddEyA99s1s0R4ic11X/0fsAkQVspesRwgTNq+LukyMZUZ+DmEDXMIoywoMpK
 o3w3NBNa1RzDle3N8M4Mc6ccvUJ6pc4PrX9C+i8RQuss9qk9DNyNoDRJse0V7ZMWd216
 JQCQ==
X-Gm-Message-State: ABuFfog+i6HkmXEjkTa0XKB4cZFBTkq2GnaVM3t9GPZTrJ59A5ke7Cam
 jBqygje1OBC3U+kkMRd4SdYIFw==
X-Google-Smtp-Source: ACcGV60xeceEtoHxfm1bbZfKafUhAMdCLJMw2SQJGQ5J07UpIu3go71Nyk67nKveVB8EbZmX6TsamQ==
X-Received: by 2002:a1c:af07:: with SMTP id y7-v6mr7208461wme.12.1538727226568; 
 Fri, 05 Oct 2018 01:13:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
 by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 01:13:45 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/9] crypto: crc-t10dif/arm64 - move PMULL based code into
 core library
Date: Fri,  5 Oct 2018 10:13:29 +0200
Message-Id: <20181005081333.15018-6-ard.biesheuvel@linaro.org>
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
 arch/arm64/crypto/crct10dif-ce-glue.c | 61 +++++---------------
 1 file changed, 14 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/crypto/crct10dif-ce-glue.c b/arch/arm64/crypto/crct10dif-ce-glue.c
index b461d62023f2..c67db86aba2c 100644
--- a/arch/arm64/crypto/crct10dif-ce-glue.c
+++ b/arch/arm64/crypto/crct10dif-ce-glue.c
@@ -10,13 +10,12 @@
 
 #include <linux/cpufeature.h>
 #include <linux/crc-t10dif.h>
+#include <linux/ffp.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
 
-#include <crypto/internal/hash.h>
-
 #include <asm/neon.h>
 #include <asm/simd.h>
 
@@ -25,27 +24,17 @@
 asmlinkage u16 crc_t10dif_pmull_p64(u16 init_crc, const u8 buf[], u64 len);
 asmlinkage u16 crc_t10dif_pmull_p8(u16 init_crc, const u8 buf[], u64 len);
 
-static u16 (*crc_t10dif_pmull)(u16 init_crc, const u8 buf[], u64 len);
-
-static int crct10dif_init(struct shash_desc *desc)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	*crc = 0;
-	return 0;
-}
+DEFINE_FFP(crc_t10dif_pmull, crc_t10dif_pmull_p8);
 
-static int crct10dif_update(struct shash_desc *desc, const u8 *data,
-			    unsigned int length)
+static __u16 crct10dif_update_arm64(u16 crc, const u8 *data, unsigned int length)
 {
-	u16 *crc = shash_desc_ctx(desc);
 	unsigned int l;
 
 	if (unlikely((u64)data % CRC_T10DIF_PMULL_CHUNK_SIZE)) {
 		l = min_t(u32, length, CRC_T10DIF_PMULL_CHUNK_SIZE -
 			  ((u64)data % CRC_T10DIF_PMULL_CHUNK_SIZE));
 
-		*crc = crc_t10dif_generic(*crc, data, l);
+		crc = crc_t10dif_generic(crc, data, l);
 
 		length -= l;
 		data += l;
@@ -54,51 +43,31 @@ static int crct10dif_update(struct shash_desc *desc, const u8 *data,
 	if (length > 0) {
 		if (may_use_simd()) {
 			kernel_neon_begin();
-			*crc = crc_t10dif_pmull(*crc, data, length);
+			crc = crc_t10dif_pmull(crc, data, length);
 			kernel_neon_end();
 		} else {
-			*crc = crc_t10dif_generic(*crc, data, length);
+			crc = crc_t10dif_generic(crc, data, length);
 		}
 	}
 
-	return 0;
-}
-
-static int crct10dif_final(struct shash_desc *desc, u8 *out)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	*(u16 *)out = *crc;
-	return 0;
+	return crc;
 }
 
-static struct shash_alg crc_t10dif_alg = {
-	.digestsize		= CRC_T10DIF_DIGEST_SIZE,
-	.init			= crct10dif_init,
-	.update			= crct10dif_update,
-	.final			= crct10dif_final,
-	.descsize		= CRC_T10DIF_DIGEST_SIZE,
-
-	.base.cra_name		= "crct10dif",
-	.base.cra_driver_name	= "crct10dif-arm64-ce",
-	.base.cra_priority	= 200,
-	.base.cra_blocksize	= CRC_T10DIF_BLOCK_SIZE,
-	.base.cra_module	= THIS_MODULE,
-};
-
 static int __init crc_t10dif_mod_init(void)
 {
 	if (elf_hwcap & HWCAP_PMULL)
-		crc_t10dif_pmull = crc_t10dif_pmull_p64;
-	else
-		crc_t10dif_pmull = crc_t10dif_pmull_p8;
+		SET_FFP(crc_t10dif_pmull, crc_t10dif_pmull_p64);
 
-	return crypto_register_shash(&crc_t10dif_alg);
+	SET_FFP(crc_t10dif_update_arch, crct10dif_update_arm64);
+
+	return 0;
 }
 
 static void __exit crc_t10dif_mod_exit(void)
 {
-	crypto_unregister_shash(&crc_t10dif_alg);
+	RESET_FFP(crc_t10dif_update_arch);
+	/* wait for all users to switch back to the old version */
+	synchronize_rcu();
 }
 
 module_cpu_feature_match(ASIMD, crc_t10dif_mod_init);
@@ -106,5 +75,3 @@ module_exit(crc_t10dif_mod_exit);
 
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS_CRYPTO("crct10dif");
-MODULE_ALIAS_CRYPTO("crct10dif-arm64-ce");
-- 
2.11.0

