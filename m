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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D4BC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 17:46:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49926238D6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 17:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49926238D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DHTBx5FSgzDqC8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Jan 2021 04:46:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035;
 helo=mail-pj1-x1035.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=E7zUfA7G; dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DHRzN545CzDsgx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2021 03:51:44 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id v1so5386273pjr.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2021 08:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9WiMTD9C+QXV2s9iIq9yKjJvbj4geefnWEN4+rMDBPY=;
 b=E7zUfA7Gm5Gqz5gPDGXradwUUaGkmyTFRRJieMc+XHaq3Q443/nawuBHo5r6A2bAPE
 HUMxrfGaaeii8o2d2BeiMcA+pC9tIIE1uafcjCUGJKsWIiKZJCuFlbJGfJHYMNQz9a5Q
 NSbTyX5v2GVKNK+Gj7f48CqCuic25lb3N5eqlXllYs5YE+THc4yIcmChz5CB+SDaQN06
 vAwRSkWQWAYAKFxGjyQwrcSIXyO4w2726mIRmMYyVuBwGtXT52YlLF0HT8TZQb5uqQe4
 0siZqzwPR3EptISqtYIw17818wuIqOjPn1hMKEeb2FQ22ejEncAYEG6b7RnRwgod4P3L
 pbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9WiMTD9C+QXV2s9iIq9yKjJvbj4geefnWEN4+rMDBPY=;
 b=U+1iygyVsd16fJXMLbNVLsIxlbU6PguoYddWssUqDT3SnIZFpBut1Md7+bTnytQiaN
 ykOXHP7vDC1Pag1E1YkCn1fyrsrYpbRyhSq2MDqmPFSPglhH7SuWZwk1hRz7H6eLpbv6
 d8M8h6VMQG9QN8nLyk/DRZiHJXPrgS5XxgGy3NgSosOtYSB+GO8MoD3VzokgCsUCRe9e
 tN+Ok/LBJDLE76v6GNEkXh4+8nrr1IhqPmVNJZrhUrTwTKA1U2LIYhXLe2z1B8m1fpqJ
 AJA1WBRg2S1ndU/yJ8IicC9U6uMrZ+BDnzo8xTOgXNwTBqKPnb1mnmov6/11o1Zq+PsH
 O0Uw==
X-Gm-Message-State: AOAM532tWjp8W3c5tP+hR+GCSG54htT3rGfsuVgqJqjX0ptSuqfiA5/q
 kpA8P1WjH43uCQ5Yud1nL0badEc7N4Q=
X-Google-Smtp-Source: ABdhPJyDvEvZVxbAj4C+Y3OdX4rSXNzhNqn5huwNGOqAqPS+6NDzn+qQ4pNr7Ogcv/zBx/3zl6WtTQ==
X-Received: by 2002:a17:90a:7844:: with SMTP id
 y4mr11607444pjl.68.1610729502175; 
 Fri, 15 Jan 2021 08:51:42 -0800 (PST)
Received: from bobo.ibm.com ([124.170.13.62])
 by smtp.gmail.com with ESMTPSA id u1sm8455477pjr.51.2021.01.15.08.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Jan 2021 08:51:41 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 22/39] powerpc: improve handling of unrecoverable system
 reset
Date: Sat, 16 Jan 2021 02:49:55 +1000
Message-Id: <20210115165012.1260253-23-npiggin@gmail.com>
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

If an unrecoverable system reset hits in process context, the system
does not have to panic. Similar to machine check, call nmi_exit()
before die().

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/traps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 3a8699995a77..f70d3f6174c8 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -503,8 +503,11 @@ void system_reset_exception(struct pt_regs *regs)
 		die("Unrecoverable nested System Reset", regs, SIGABRT);
 #endif
 	/* Must die if the interrupt is not recoverable */
-	if (!(regs->msr & MSR_RI))
+	if (!(regs->msr & MSR_RI)) {
+		/* For the reason explained in die_mce, nmi_exit before die */
+		nmi_exit();
 		die("Unrecoverable System Reset", regs, SIGABRT);
+	}
 
 	if (saved_hsrrs) {
 		mtspr(SPRN_HSRR0, hsrr0);
-- 
2.23.0

