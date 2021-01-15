Return-Path: <SRS0=Y1I/=GS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB701C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 17:10:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9A7238EE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 17:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9A7238EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DHSP902FTzDsgf
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Jan 2021 04:10:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433;
 helo=mail-pf1-x433.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Y1AprZx8; dkim-atps=neutral
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DHRyK6Y17zDshm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2021 03:50:49 +1100 (AEDT)
Received: by mail-pf1-x433.google.com with SMTP id b3so5855069pft.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2021 08:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IHVnqASdWVCTQIhkIP+wnXNm5lBXV3YL2yR8Z+z3lwA=;
 b=Y1AprZx8OAJAQ37fRId9QG72wXbRxBTRvUakqHHbdMDmI+B7f6ed2ug5cnBXUBWyJJ
 aovgB/RRb5XtoOApHrkz97Z0iaks0ZNtn+TXP03o5FGKJMUqId8mnO6/G29TZFDzYPWd
 JjihF9403C2wEBbLigB0F0sPVdk8MVqsVABuOuuhs/7NPW1CIqarZUaONMtl870Jucek
 wG360EqioyIdJdPEaVCoH7iur6MGiajMFJA/EtNt0PrEkeAdXNbdNNnrwTT//kwpeAXB
 MpY1G0keO718u6K/XrMZleM0XkFon0PZW5ymIJRcE1ZLbR1SHyQPOholvN71MGumdamT
 Gv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IHVnqASdWVCTQIhkIP+wnXNm5lBXV3YL2yR8Z+z3lwA=;
 b=hVojl1Ls8+zyqtn8v5k0kPzdZ6T67/0v8MCerggqW9Ww7ZZUcg/3o9bRN24Q2bKCrO
 l5GNXPfTE313XEjvbXZeFnof2NYqBNLPMQaLDq9QZkQticZAhu+ZaDbDeYdKs/gysKHc
 PlMGbLFJsV8Wn9rLKz3MaguVRu+/wLzmjFzEW+qiolEaYeWpwBVD6GIhTLWplxXE1i+o
 MnvuQ9o8rVPJnbkFUlwVSUl8pWsUZ3ckwf8VphHXJkfqOPZmjhmN1Jmye50Djl+OLcxj
 fs7YibOjrqy3wdyhvo9bxpjT4sKZgkX37QZKqVYoDFbG0tp2APz8qfQrxVuDh/Rxy1HM
 YTww==
X-Gm-Message-State: AOAM5325dAMtqDxzn705GI/E4rLjH2twUo2mGbCC69xJSUcp6wQYpc5O
 +jaW+aZGec3vKVw3AQQouKhWvBdiKjs=
X-Google-Smtp-Source: ABdhPJzmcvpcoMye7ViTjs35d6uyg7XFOMRocDG0NSuS0MsDL5KaW82vox8nmE4u0ZrbE2KHRqCrbg==
X-Received: by 2002:a62:303:0:b029:1a5:a6f7:ac0d with SMTP id
 3-20020a6203030000b02901a5a6f7ac0dmr13641445pfd.63.1610729446494; 
 Fri, 15 Jan 2021 08:50:46 -0800 (PST)
Received: from bobo.ibm.com ([124.170.13.62])
 by smtp.gmail.com with ESMTPSA id u1sm8455477pjr.51.2021.01.15.08.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Jan 2021 08:50:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 08/39] powerpc: rearrange do_page_fault error case to be
 inside exception_enter
Date: Sat, 16 Jan 2021 02:49:41 +1000
Message-Id: <20210115165012.1260253-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210115165012.1260253-1-npiggin@gmail.com>
References: <20210115165012.1260253-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This keeps the context tracking over the entire interrupt handler which
helps later with moving context tracking into interrupt wrappers.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/fault.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index e476d7701413..e4121fd9fcf1 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -544,20 +544,24 @@ NOKPROBE_SYMBOL(__do_page_fault);
 
 long do_page_fault(struct pt_regs *regs)
 {
-	const struct exception_table_entry *entry;
-	enum ctx_state prev_state = exception_enter();
-	int rc = __do_page_fault(regs, regs->dar, regs->dsisr);
-	exception_exit(prev_state);
-	if (likely(!rc))
-		return 0;
-
-	entry = search_exception_tables(regs->nip);
-	if (unlikely(!entry))
-		return rc;
+	enum ctx_state prev_state;
+	long err;
+
+	prev_state = exception_enter();
+	err = __do_page_fault(regs, regs->dar, regs->dsisr);
+	if (unlikely(err)) {
+		const struct exception_table_entry *entry;
+
+		entry = search_exception_tables(regs->nip);
+		if (likely(entry)) {
+			instruction_pointer_set(regs, extable_fixup(entry));
+			err = 0;
+		}
+	}
 
-	instruction_pointer_set(regs, extable_fixup(entry));
+	exception_exit(prev_state);
 
-	return 0;
+	return err;
 }
 NOKPROBE_SYMBOL(do_page_fault);
 
-- 
2.23.0

