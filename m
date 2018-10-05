Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1894AC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:36:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A55920875
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8esmuRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A55920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RNPq3Jh2zF3S6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:35:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e8esmuRC";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="e8esmuRC"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RMwK6zhYzF3Jx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 18:13:53 +1000 (AEST)
Received: by mail-wm1-x341.google.com with SMTP id 206-v6so976947wmb.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 01:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=J4kMEdjdjyVuuZO5lYFdItsW+zGD6WfP39sVuKslDsg=;
 b=e8esmuRCIp6ko/JwvDO3kBBIs0dTMMN1wtG2whhv2f4XMHEle3rjYH89bQUST5qiFq
 y01wiSYV80GPMjl+jFCfCvbACNJysosMxzXmakYDLal79M0Jvjtc315CNojt1VlrX3wv
 1kEIFKnSbXS0TIqiC1s6eOzAaXSjfGUTetKb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=J4kMEdjdjyVuuZO5lYFdItsW+zGD6WfP39sVuKslDsg=;
 b=YWKn7Xuw1OOteXS+PwmLJelc4fglLTwIJQmRc3ffprcZYka/AsGOvLUxswn9LvGpT1
 oYQHw2MUFQh/WuJ1qM7gwgj1Re39MPkt8YIEffBhO57tzQelNI4LqsZOtSCMSeZ4QGFH
 EIKNWQKXNezsPVXb3r9U6jAy/I1vnPkrmv+UNLlO7zsYv5gbrUwitc5pc/M4y1fOvQP+
 rqn35OumBcd7dPXvbixkpoa9beSzrLrTMfFZm7zucn9267WUEE3xqVDjTlktRsht/fpJ
 bQENm6KoAarjv64P81QP3y+1d8VoRuVah0uLP93UcZsRXLm1zUSDSioSL37TayoQkNnE
 GGoA==
X-Gm-Message-State: ABuFfog/lMNNr4KJ94iEmNpHPwB3B6MDMSnoSb/3vUbECvtb7IbLZi0+
 lUNnLQSVj3mKZSKIrDO5fssD/g==
X-Google-Smtp-Source: ACcGV61Ibe9AAfd/NquSGQgeZdTsN3JKQyq9DGyJgyEhxqZ5dP7RSW7Wle9DnyJkVviljI3UE2oc5w==
X-Received: by 2002:a1c:14d1:: with SMTP id
 200-v6mr7368323wmu.106.1538727231291; 
 Fri, 05 Oct 2018 01:13:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
 by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 01:13:50 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 8/9] crypto: crc-t10dif/powerpc - move PMULL based code
 into core library
Date: Fri,  5 Oct 2018 10:13:32 +0200
Message-Id: <20181005081333.15018-9-ard.biesheuvel@linaro.org>
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
 arch/powerpc/crypto/crct10dif-vpmsum_glue.c | 55 +++-----------------
 1 file changed, 6 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/crypto/crct10dif-vpmsum_glue.c b/arch/powerpc/crypto/crct10dif-vpmsum_glue.c
index 02ea277863d1..a4db7ecc0ccc 100644
--- a/arch/powerpc/crypto/crct10dif-vpmsum_glue.c
+++ b/arch/powerpc/crypto/crct10dif-vpmsum_glue.c
@@ -11,8 +11,8 @@
  */
 
 #include <linux/crc-t10dif.h>
-#include <crypto/internal/hash.h>
 #include <linux/init.h>
+#include <linux/ffp.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
@@ -63,59 +63,18 @@ static u16 crct10dif_vpmsum(u16 crci, unsigned char const *p, size_t len)
 	return crc & 0xffff;
 }
 
-static int crct10dif_vpmsum_init(struct shash_desc *desc)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	*crc = 0;
-	return 0;
-}
-
-static int crct10dif_vpmsum_update(struct shash_desc *desc, const u8 *data,
-			    unsigned int length)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	*crc = crct10dif_vpmsum(*crc, data, length);
-
-	return 0;
-}
-
-
-static int crct10dif_vpmsum_final(struct shash_desc *desc, u8 *out)
-{
-	u16 *crcp = shash_desc_ctx(desc);
-
-	*(u16 *)out = *crcp;
-	return 0;
-}
-
-static struct shash_alg alg = {
-	.init		= crct10dif_vpmsum_init,
-	.update		= crct10dif_vpmsum_update,
-	.final		= crct10dif_vpmsum_final,
-	.descsize	= CRC_T10DIF_DIGEST_SIZE,
-	.digestsize	= CRC_T10DIF_DIGEST_SIZE,
-	.base		= {
-		.cra_name		= "crct10dif",
-		.cra_driver_name	= "crct10dif-vpmsum",
-		.cra_priority		= 200,
-		.cra_blocksize		= CRC_T10DIF_BLOCK_SIZE,
-		.cra_module		= THIS_MODULE,
-	}
-};
-
 static int __init crct10dif_vpmsum_mod_init(void)
 {
-	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
-		return -ENODEV;
+	SET_FFP(crc_t10dif_update_arch, crct10dif_vpmsum);
 
-	return crypto_register_shash(&alg);
+	return 0;
 }
 
 static void __exit crct10dif_vpmsum_mod_fini(void)
 {
-	crypto_unregister_shash(&alg);
+	RESET_FFP(crc_t10dif_update_arch);
+	/* wait for all users to switch back to the old version */
+	synchronize_rcu();
 }
 
 module_cpu_feature_match(PPC_MODULE_FEATURE_VEC_CRYPTO, crct10dif_vpmsum_mod_init);
@@ -124,5 +83,3 @@ module_exit(crct10dif_vpmsum_mod_fini);
 MODULE_AUTHOR("Daniel Axtens <dja@axtens.net>");
 MODULE_DESCRIPTION("CRCT10DIF using vector polynomial multiply-sum instructions");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_CRYPTO("crct10dif");
-MODULE_ALIAS_CRYPTO("crct10dif-vpmsum");
-- 
2.11.0

