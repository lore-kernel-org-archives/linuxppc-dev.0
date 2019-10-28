Return-Path: <SRS0=5fv2=YV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8222ACA9EC0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Oct 2019 21:35:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265BC217D6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Oct 2019 21:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="odEkHLjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265BC217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4727L463DdzDrfX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Oct 2019 08:35:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::441;
 helo=mail-wr1-x441.google.com; envelope-from=richard.henderson@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="odEkHLjS"; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4726hL25p3zDqJW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2019 08:06:09 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id p4so11380403wrm.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2019 14:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OA1lEVPUVah/nj9y4NPe9mpA4YmtUJ45alybXkd0IGY=;
 b=odEkHLjSN3JWnD5C17Txi1cL9gpWHsxbz/541i6HonY1afq+jCmqm6gjraAZ5IF+E5
 3g5eNOzZKQSnRPN35Ido+e/kuRQqORGuoNGHzAuQQLx6oWni+DDSeDvsOW+yofnFtlQC
 0KTVYObE7IiOiNlxdatiKqYf37B1LSAWNDDPYMxFahwK4p9pedn8j6CNfwVcs42oflWp
 TBmfFgdkCjRAYh0LIo2msRLbcL3jnQA1v2rQNPiG8DZnE2NWXfwmz4QQHDhLGC2CkMdP
 kiWYPILROM1iiiG5p0Wz8b4RcFHnytBC85i2qQ/q7Tt0PafGD08vMQ2L1YqvEoDTrMkQ
 gE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OA1lEVPUVah/nj9y4NPe9mpA4YmtUJ45alybXkd0IGY=;
 b=Nu+PLsgIwmQtqDtZuVXt1/OmL+nE5HvsL6JFyfT/bojxc5XFmMj76/ZXIHyhODvmSk
 Wh+Z0BdPMAaoEDg3sqTZ9fLtF15lnWJmpijdBaIQFfbshavRnmBy7+05UlQarmmGd2Pv
 +hp7u1EqhbVfUNTaOacJvAV5xQy0nPFsUPHTF+xvaGfARlma4LAQouoHCuCP28XaeO0y
 DeodeQVbegOMO8Fb6nBaZ5ezc1pBV6K861LOsnSKEnqHNuZ3tLSkSqXVofv8+oZezy40
 MrIzBR2ip0VI5tlvIQjOViKdNT8tjho4KltQ84M6DVDABPXoLwQKeKqbNqsWUhu62rqh
 fizQ==
X-Gm-Message-State: APjAAAXJsvFjZe69bIzoPIZuCkchCu3hNj3nux0ilzgf4pkkGf+IbTZ6
 +6ZkoeXrkussJkRHXTGs1YMUhw==
X-Google-Smtp-Source: APXvYqxc7HPshldpApCL1t58Sst+B72c5dhOqq43UkylGW9qCLLj3H1LeTQb93H8/kIqXI/hDnfPUg==
X-Received: by 2002:adf:82d2:: with SMTP id 76mr15985163wrc.52.1572296766984; 
 Mon, 28 Oct 2019 14:06:06 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net.
 [88.138.106.230])
 by smtp.gmail.com with ESMTPSA id b196sm927822wmd.24.2019.10.28.14.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:06:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To: linux-arch@vger.kernel.org
Subject: [PATCH 4/6] powerpc: Use bool in archrandom.h
Date: Mon, 28 Oct 2019 22:05:57 +0100
Message-Id: <20191028210559.8289-5-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028210559.8289-1-rth@twiddle.net>
References: <20191028210559.8289-1-rth@twiddle.net>
X-Mailman-Approved-At: Tue, 29 Oct 2019 08:33:29 +1100
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
Cc: linux-s390@vger.kernel.org, x86@kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The generic interface uses bool not int; match that.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/archrandom.h | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
index 9c63b596e6ce..f8a887c8b7f8 100644
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@ -6,27 +6,28 @@
 
 #include <asm/machdep.h>
 
-static inline int arch_get_random_long(unsigned long *v)
+static inline bool arch_get_random_long(unsigned long *v)
 {
-	return 0;
+	return false;
 }
 
-static inline int arch_get_random_int(unsigned int *v)
+static inline bool arch_get_random_int(unsigned int *v)
 {
-	return 0;
+	return false;
 }
 
-static inline int arch_get_random_seed_long(unsigned long *v)
+static inline bool arch_get_random_seed_long(unsigned long *v)
 {
 	if (ppc_md.get_random_seed)
 		return ppc_md.get_random_seed(v);
 
-	return 0;
+	return false;
 }
-static inline int arch_get_random_seed_int(unsigned int *v)
+
+static inline bool arch_get_random_seed_int(unsigned int *v)
 {
 	unsigned long val;
-	int rc;
+	bool rc;
 
 	rc = arch_get_random_long(&val);
 	if (rc)
@@ -35,15 +36,16 @@ static inline int arch_get_random_seed_int(unsigned int *v)
 	return rc;
 }
 
-static inline int arch_has_random(void)
+static inline bool arch_has_random(void)
 {
-	return 0;
+	return false;
 }
 
-static inline int arch_has_random_seed(void)
+static inline bool arch_has_random_seed(void)
 {
 	return !!ppc_md.get_random_seed;
 }
+
 #endif /* CONFIG_ARCH_RANDOM */
 
 #ifdef CONFIG_PPC_POWERNV
-- 
2.17.1

