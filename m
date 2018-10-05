Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4092C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:31:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619DB20875
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnwyIatH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619DB20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RNJ14h74zF3Rq
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:30:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jnwyIatH";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="jnwyIatH"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RMwG5qW6zF3Jg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 18:13:50 +1000 (AEST)
Received: by mail-wr1-x442.google.com with SMTP id 63-v6so12553075wra.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 01:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=W4XNrL/HVz1JFq0EC5F2/AltrGoh1ZboRDNEWdxrwVU=;
 b=jnwyIatHaYA2n3cTx6guJoyPbr+L3fOA9AOBqx0Y2oMaeF96hobAONVdvSUned1y3s
 StByQ8z+FybmB6IbckDsErTVElZPazLc7iw2ihFw0/S6pZiXC3Q6LPbxewFO5smDCYZf
 uOH6PjRG3nJAjWfuYmqeU3mfvrJ5BOnGliwTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=W4XNrL/HVz1JFq0EC5F2/AltrGoh1ZboRDNEWdxrwVU=;
 b=O6Tx+dz8HlFLm7Rn1z7dVzUaZWzVYM+lwR01VHwKDkbwfuiM0n5G21LeyGedJsESC/
 Q0xyjboQPU+OqDs0NThzdP4k7g+0hcOdoWF9PmZMnmywTFNCcCaSoQchu4n/tpc+lx76
 P2bl/AOq6Jv8yDNLFzfrz3r7tgAJL3FVXJcWeKNPw35SJOpLBdvm5pIsDFBxfqHs4dQB
 z4VfvsKMNjXwLX1+dmqtN82IGOvcYToL9Uw3V7Hx1bNFc2+zHDXZKaHGA/ECR9qHdOaV
 6fJxt7UgiqCF54XwI5cMA5/X15vyqQp4FTBcizbeURv19gZ632RWmPH7NzucRsch8iww
 OKGQ==
X-Gm-Message-State: ABuFfojOqtghpbK/m5DTCjZptWx00X8XD22sW0pk0XEL2aF2L5Rh73sp
 5Rg16ehyN5srog8Uy8sHJFgFaA==
X-Google-Smtp-Source: ACcGV61HoftJXzqiL1l8hk7uMWp9ORWuLz+n27+qFSZw8Ez8l1VEdbwmXm9/Fc00segej20s6XNxjA==
X-Received: by 2002:a5d:40cd:: with SMTP id
 b13-v6mr7838866wrq.133.1538727228189; 
 Fri, 05 Oct 2018 01:13:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
 by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 01:13:47 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/9] crypto: crc-t10dif/arm - move PMULL based code into
 core library
Date: Fri,  5 Oct 2018 10:13:30 +0200
Message-Id: <20181005081333.15018-7-ard.biesheuvel@linaro.org>
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
 arch/arm/crypto/crct10dif-ce-glue.c | 78 ++++++--------------
 1 file changed, 22 insertions(+), 56 deletions(-)

diff --git a/arch/arm/crypto/crct10dif-ce-glue.c b/arch/arm/crypto/crct10dif-ce-glue.c
index d428355cf38d..2020d9c29ff1 100644
--- a/arch/arm/crypto/crct10dif-ce-glue.c
+++ b/arch/arm/crypto/crct10dif-ce-glue.c
@@ -10,12 +10,11 @@
 
 #include <linux/crc-t10dif.h>
 #include <linux/init.h>
+#include <linux/ffp.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
 
-#include <crypto/internal/hash.h>
-
 #include <asm/neon.h>
 #include <asm/simd.h>
 
@@ -23,74 +22,42 @@
 
 asmlinkage u16 crc_t10dif_pmull(u16 init_crc, const u8 buf[], u32 len);
 
-static int crct10dif_init(struct shash_desc *desc)
+static __u16 crct10dif_update_arm(__u16 crc, const u8 *data, unsigned int length)
 {
-	u16 *crc = shash_desc_ctx(desc);
-
-	*crc = 0;
-	return 0;
-}
-
-static int crct10dif_update(struct shash_desc *desc, const u8 *data,
-			    unsigned int length)
-{
-	u16 *crc = shash_desc_ctx(desc);
 	unsigned int l;
 
-	if (!may_use_simd()) {
-		*crc = crc_t10dif_generic(*crc, data, length);
-	} else {
-		if (unlikely((u32)data % CRC_T10DIF_PMULL_CHUNK_SIZE)) {
-			l = min_t(u32, length, CRC_T10DIF_PMULL_CHUNK_SIZE -
-				  ((u32)data % CRC_T10DIF_PMULL_CHUNK_SIZE));
+	if (!may_use_simd())
+		return crc_t10dif_generic(crc, data, length);
 
-			*crc = crc_t10dif_generic(*crc, data, l);
+	if (unlikely((u32)data % CRC_T10DIF_PMULL_CHUNK_SIZE)) {
+		l = min_t(u32, length, CRC_T10DIF_PMULL_CHUNK_SIZE -
+			  ((u32)data % CRC_T10DIF_PMULL_CHUNK_SIZE));
 
-			length -= l;
-			data += l;
-		}
-		if (length > 0) {
-			kernel_neon_begin();
-			*crc = crc_t10dif_pmull(*crc, data, length);
-			kernel_neon_end();
-		}
-	}
-	return 0;
-}
+		crc = crc_t10dif_generic(crc, data, l);
 
-static int crct10dif_final(struct shash_desc *desc, u8 *out)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	*(u16 *)out = *crc;
-	return 0;
+		length -= l;
+		data += l;
+	}
+	if (length > 0) {
+		kernel_neon_begin();
+		crc = crc_t10dif_pmull(crc, data, length);
+		kernel_neon_end();
+	}
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
-	.base.cra_driver_name	= "crct10dif-arm-ce",
-	.base.cra_priority	= 200,
-	.base.cra_blocksize	= CRC_T10DIF_BLOCK_SIZE,
-	.base.cra_module	= THIS_MODULE,
-};
-
 static int __init crc_t10dif_mod_init(void)
 {
-	if (!(elf_hwcap2 & HWCAP2_PMULL))
-		return -ENODEV;
+	SET_FFP(crc_t10dif_update_arch, crct10dif_update_arm);
 
-	return crypto_register_shash(&crc_t10dif_alg);
+	return 0;
 }
 
 static void __exit crc_t10dif_mod_exit(void)
 {
-	crypto_unregister_shash(&crc_t10dif_alg);
+	RESET_FFP(crc_t10dif_update_arch);
+	/* wait for all users to switch back to the old version */
+	synchronize_rcu();
 }
 
 module_init(crc_t10dif_mod_init);
@@ -98,4 +65,3 @@ module_exit(crc_t10dif_mod_exit);
 
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS_CRYPTO("crct10dif");
-- 
2.11.0

