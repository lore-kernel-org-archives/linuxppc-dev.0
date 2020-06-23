Return-Path: <SRS0=X5Ay=AE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C275BC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 23:47:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC7820780
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 23:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CavIOZng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC7820780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49s2y33yrYzDqM0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2020 09:47:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::343;
 helo=mail-wm1-x343.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=CavIOZng; dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49s2qy6436zDqbc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2020 09:42:06 +1000 (AEST)
Received: by mail-wm1-x343.google.com with SMTP id o2so520556wmh.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2020 16:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wq1Usiwllo3IzLxZOzXxDD+huSIP8zBTYASyhKVLh8A=;
 b=CavIOZngre4AGsUGm5U0rnpNs/5pHUDdKZG9NZ1Jn1BDhRuMh/e1R5IJQiZ0bbAGqG
 cvl3kr7vM4zBTyyrD9h82rFXxg+m1n5NdZZKNSdaJjJAUF0dtKdtNFuAPSQ8xnV9leKC
 OH9aTnho2/b8S9wZgdT/2gSud22KGDXZwP6Ej8KKJlpYf5LXqjyco/+D0+ufhJtOX5Pi
 wNaHPjkzMbrFmq9wZU4R6/dSMHLo7Bq8fKqdNMIRn5PIdlLtOzol6JW/RetDzg+9anHd
 OqrlvKR+JzTQfxrC4jLLiWSL6RLHgmPOw7v/jdPBoF0vUwnS40cPeTlEdusb+fnoXrwM
 nurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wq1Usiwllo3IzLxZOzXxDD+huSIP8zBTYASyhKVLh8A=;
 b=G3YO5PmMC+P39KbOV3jEVJLeVEOlxJFhGHUYyKmI7Rq6isRfPYiAR6+PMxhTxQimXZ
 LF92qZUzfPcoslMHDoA25U4IYD6steJmTznaRLEslhhSdeLKOH3ERsAQ5N7WAg9+57i5
 2UJlqz+aNVByPeTLXtq+xZ2816xoMAi1QDsdzJxUvsU2q+/4APPytXt7G37qpy1ybVfG
 nhR7nB4xAdNXrhoPJhjpPtaqH4XQSXOY9X1ZPiaO99HYZBRE2m7F+iRlRX+BK669yShC
 zTL2+or7ex7BMVnmZb0+VjK/nwhvX/fzwo9okE9srxgwcDd/D6XGk9kgq8mnFKHAw4+3
 IEog==
X-Gm-Message-State: AOAM531oQsplA8w8+GiOa21IHLfzEJaYTynmsl44kd+q4++l897YkNkH
 nCU/wFGD2/O7wVYEroHJyO0talM0
X-Google-Smtp-Source: ABdhPJx/vMuOwGdPwtr2/WFiANdWvWVC6704JqGlcSnZs/yy7SHhWBEQhHNBxoEtKeWickIhuK1GqQ==
X-Received: by 2002:a1c:790f:: with SMTP id l15mr26310431wme.161.1592955723229; 
 Tue, 23 Jun 2020 16:42:03 -0700 (PDT)
Received: from bobo.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
 by smtp.gmail.com with ESMTPSA id d63sm5878445wmc.22.2020.06.23.16.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 16:42:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc: re-initialise lazy FPU/VEC counters on every
 fault
Date: Wed, 24 Jun 2020 09:41:39 +1000
Message-Id: <20200623234139.2262227-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200623234139.2262227-1-npiggin@gmail.com>
References: <20200623234139.2262227-1-npiggin@gmail.com>
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
Cc: Anton Blanchard <anton@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When a FP/VEC/VSX unavailable fault loads registers and enables the
facility in the MSR, re-set the lazy restore counters to 1 rather
than incrementing them so every fault gets the same number of
restores before the next fault.

This probably shouldn't be a practical change because if a lazy counter
was non-zero then it should have been restored and would not cause a
fault when userspace tries to access it. However the code and comment
implies otherwise so that's misleading and unnecessary.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/fpu.S    | 4 +---
 arch/powerpc/kernel/vector.S | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index cac22cb97a8c..4ae39db70044 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -107,9 +107,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	or	r12,r12,r4
 	std	r12,_MSR(r1)
 #endif
-	/* Don't care if r4 overflows, this is desired behaviour */
-	lbz	r4,THREAD_LOAD_FP(r5)
-	addi	r4,r4,1
+	li	r4,1
 	stb	r4,THREAD_LOAD_FP(r5)
 	addi	r10,r5,THREAD_FPSTATE
 	lfd	fr0,FPSTATE_FPSCR(r10)
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index efc5b52f95d2..801dc28fdcca 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -76,9 +76,7 @@ _GLOBAL(load_up_altivec)
 	oris	r12,r12,MSR_VEC@h
 	std	r12,_MSR(r1)
 #endif
-	/* Don't care if r4 overflows, this is desired behaviour */
-	lbz	r4,THREAD_LOAD_VEC(r5)
-	addi	r4,r4,1
+	li	r4,1
 	stb	r4,THREAD_LOAD_VEC(r5)
 	addi	r6,r5,THREAD_VRSTATE
 	li	r4,1
-- 
2.23.0

