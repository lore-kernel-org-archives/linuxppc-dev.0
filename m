Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25875C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:33:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DD120875
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WeDWUysr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DD120875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RNLw4GzlzF3Sf
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:33:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WeDWUysr";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="WeDWUysr"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RMwJ52QgzF3Mk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 18:13:52 +1000 (AEST)
Received: by mail-wm1-x342.google.com with SMTP id b19-v6so981270wme.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 01:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7ykn0kdpAuelX0ufR1lLCrLMFlIy/5JjP//jovQ6hBA=;
 b=WeDWUysrCM1wTzn7PG9YlepPl9dIJg8fzOw1684WVaduAN0K8vgjCHF+9AEbojUJgw
 a6lay2dDQi7EbALoyTHW5TVZR0JGZnd8dl/TJiMHR5gduxF+udxOeiLpDmYl4u8nrdr4
 Yex3cYKNCM1K4/unt4EPkx1wx8ANl/+NncRN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7ykn0kdpAuelX0ufR1lLCrLMFlIy/5JjP//jovQ6hBA=;
 b=GYcw9iS8PWmjFf9Q4Ag1mbLoEyDSvdTWqUztMPlb6rrHek9FHUv7Vo7Ei23oiHcttr
 ThQtyYkgsO3LwBVPaKyuhVWlxzdwx8JJVTUjW5rUCJTO3H66ZC26CZilcCQ7S4G1sQMM
 XBWuOHf/MSbELgY4a20EBvdwgsJUVUJE5Y+5IesTF1JFjf5UaeBlCVbuAWruRr3gBBb3
 UEkBZ6bnyhW0AUKTfxaNsPwAJGPilHjoyADkgpa9i91GJltWublzbfLwbCOmaup9ZSi/
 tbG9lXeiSzmGbkRZMOsHHFo+lVReSgozisHs6/8o0+qC2sGXoLbPIDWeTRUJIHEpdZfI
 kwbw==
X-Gm-Message-State: ABuFfoiWup16DqpcxMxhtqNLwvllhR3n37C0d6+vZzUtmngbeBgGiHta
 iCsruA5FVooVptJS/ynLEfcxJA==
X-Google-Smtp-Source: ACcGV63LMyLTdsFROQVq2F8T9xrNbOmEFXJ//dKfIs8ROq4/BvnQT8Qlj0D9nA/4mALqefT70j74+Q==
X-Received: by 2002:a1c:9901:: with SMTP id b1-v6mr4381461wme.15.1538727229699; 
 Fri, 05 Oct 2018 01:13:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
 by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 01:13:49 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/9] crypto: crct10dif/generic - switch crypto API driver
 to core library
Date: Fri,  5 Oct 2018 10:13:31 +0200
Message-Id: <20181005081333.15018-8-ard.biesheuvel@linaro.org>
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

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 crypto/crct10dif_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/crct10dif_generic.c b/crypto/crct10dif_generic.c
index 8e94e29dc6fc..9ea4242c4921 100644
--- a/crypto/crct10dif_generic.c
+++ b/crypto/crct10dif_generic.c
@@ -53,7 +53,7 @@ static int chksum_update(struct shash_desc *desc, const u8 *data,
 {
 	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
 
-	ctx->crc = crc_t10dif_generic(ctx->crc, data, length);
+	ctx->crc = crc_t10dif_update(ctx->crc, data, length);
 	return 0;
 }
 
@@ -68,7 +68,7 @@ static int chksum_final(struct shash_desc *desc, u8 *out)
 static int __chksum_finup(__u16 *crcp, const u8 *data, unsigned int len,
 			u8 *out)
 {
-	*(__u16 *)out = crc_t10dif_generic(*crcp, data, len);
+	*(__u16 *)out = crc_t10dif_update(*crcp, data, len);
 	return 0;
 }
 
-- 
2.11.0

