Return-Path: <SRS0=ywKm=U3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFDAC4321A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Jun 2019 05:50:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D012133F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Jun 2019 05:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rcanl3eQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D012133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Zm7q3RvHzDr0C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Jun 2019 15:50:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rcanl3eQ"; 
 dkim-atps=neutral
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Zlmq0FS5zDqnk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2019 15:33:46 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id g15so164490pgi.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2019 22:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TjAK6EKUWy3VTkoFrds3yOeR4KxLlIjRgcM0ogcDHV8=;
 b=Rcanl3eQEdEUXSFYV6EZqfsAlEDTOu4+/+jg0fs/HmTRqJI7H/Y+qVyvwetA+Mv9O+
 mKP4VWF+lT4p/4npmInLha3FjtMKVyg0HNmV/0Lx6fubaurhsuCvuqN1mTv+8aBuibTQ
 GoT080IPNLXcJmnpzm93KRwQT0FczTIO/YSflr22I52wzLqXiroxQHBaCboUUsPpZfdw
 4CwpHO9eIyEYapHk5zh8d6qwB15ALCg2sUz8Y6Z4Kci91r4FmwMBDIeJ6Tb/Xy5FIl27
 CtU4V66Lk23Y/W/b95oRkmTBHYIDNDCpWUSL0ElhjCfpqnFVQCNzvBLz2sI86mRlTafu
 Fo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TjAK6EKUWy3VTkoFrds3yOeR4KxLlIjRgcM0ogcDHV8=;
 b=TTo6lBgw28cZs5o/qMOxZh4TSWT5Zu+fbhGcVcEeybCixI58umkYjBob0NduSwC7ic
 HvuL6LFwdzyHGpi2z0cCATOEZf3nmYz6p3/vMnkc8LjJhVRZxJ9zyrc5nza8eex1Aify
 QZKCDwzpXYAUxQ7ByHq6wZHrvhZHQGI3z5ivbzwoyQwoSdvQ/ax0AkdwYRSnot50Jz8Q
 +0+Qpac4Gip8YxP02HPOYNsX3oOdcUlVmvOdrcve4eogmaHWpp5YIS9wrCTT6JM6H8Eh
 WDoMjJEp4LP3uMtZLotL/SygrvVMjl1cMBefXuWf4677favvvp5dEPYplD+nEq9LW8Bm
 ixjQ==
X-Gm-Message-State: APjAAAVQSa3M488/HCG1EPz4INv5EZctTD0ensyshFCERvqzWepccRch
 Uy/F5sUB10uVfCPY9bT/XlabnNaj
X-Google-Smtp-Source: APXvYqy7lcbpNRO/EVKKGxkOeMITwI9OK3jnPhCPTH4zGcAIGU+eBuOcAAJg3Ix2q6yrJcD+Nn75Gw==
X-Received: by 2002:a17:90a:d14b:: with SMTP id
 t11mr10842239pjw.79.1561700024444; 
 Thu, 27 Jun 2019 22:33:44 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id 125sm1272614pfg.23.2019.06.27.22.33.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 22:33:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 10/13] powerpc/64s/exception: machine check use standard
 macros to save dar/dsisr
Date: Fri, 28 Jun 2019 15:33:29 +1000
Message-Id: <20190628053332.22366-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628053332.22366-1-npiggin@gmail.com>
References: <20190628053332.22366-1-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4427b6820f51..f193a67f02ba 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1064,7 +1064,7 @@ BEGIN_FTR_SECTION
 	b	machine_check_common_early
 END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
 machine_check_pSeries_0:
-	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXMC, 1, 0x200, 0, 0, 0
+	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXMC, 1, 0x200, 1, 1, 0
 	/*
 	 * MSR_RI is not enabled, because PACA_EXMC is being used, so a
 	 * nested machine check corrupts it. machine_check_common enables
@@ -1079,10 +1079,6 @@ EXC_COMMON_BEGIN(machine_check_common)
 	 * Machine check is different because we use a different
 	 * save area: PACA_EXMC instead of PACA_EXGEN.
 	 */
-	mfspr	r10,SPRN_DAR
-	std	r10,PACA_EXMC+EX_DAR(r13)
-	mfspr	r10,SPRN_DSISR
-	stw	r10,PACA_EXMC+EX_DSISR(r13)
 	EXCEPTION_COMMON(PACA_EXMC, 0x200)
 	FINISH_NAP
 	RECONCILE_IRQ_STATE(r10, r11)
-- 
2.20.1

