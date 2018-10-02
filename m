Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEC8C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 15:02:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D0D2083F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 15:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJUX03p8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D0D2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Pj7N0wlWzDqfy
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 01:02:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gJUX03p8";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gJUX03p8"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PhMm0yGlzF3HZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 00:28:19 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id s4-v6so1713793plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IRRFhF9ZrENriAG9Gf4LHxqc/b2dQSFALW7xzxXUMpE=;
 b=gJUX03p8zhH7HyxkFGashFS6mVqsfIo2tA7FBDWbEcMgGlSF5Kfh62S5nzmsZDDeqK
 8GzNbladO8g+15cTapbyjIO2hxVpdEgAePSbrq5JkKq7rRfb+060iCDESqdOFXnea5UE
 IU1jbvIob2lrK5gnGa3X7eAkr0Im27lfqG7w3/msdzzDvfuFcmB1QXoI6Hg0PVccsgcg
 SZHxf66NyC21OkmNkwm2ADIboSnsUrdQo53qM7Mhfvr7+rI7Y6gni7oVsZbzb3wQFuJk
 HkZhuhX6JxWG2xHhs/pI/S1O1aFVolwXoIkvI6n5Bg86J7KGcObxGOQjUXQnG3cYDTuj
 myMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IRRFhF9ZrENriAG9Gf4LHxqc/b2dQSFALW7xzxXUMpE=;
 b=ZnVIimIFfN6eH8rAlfsCAvs/PX6pn8y73O4UUz1FYntzpGaa3Wdkleyv/0DEk/fWG8
 8Kt4DcC5v3Pnj7VWLAiWOgJLYCRQDQ+moGp5kRbQiaxZwZC/fRLaXBZOKBvNWhBseaP+
 iGCQ5LeFv5u4huoqLlMUEqHce+3sLKEDOfg7Q7lGM5sMw7MUtQn8irE/nhMEoFwTBj7y
 buLdQGFlJ9bpxL06vwbz05G9Hxgvgs2ViC+7HSX+IkPkaRru5Bov/fMF/MdyknmEECVH
 tultDMmffEG+pVhr1Dwz+WmAx2my1ZdjY8Wv8LDsSMrgvjWICe9kBe872LlQ/aq+UZ1x
 VYzQ==
X-Gm-Message-State: ABuFfoiJK7orLkSDAAsvKFmMnpk8P4TA5Joq4KxCpurT9RH20CN6E44J
 /wWAolYUk47BPTVrbdwBqhiiGkpR
X-Google-Smtp-Source: ACcGV63pFXPwolfvm5vtbdjzMA+SvPLD5YEiSfz9PmjLa2GY8kKjfJyLqfYnCrGdnazezLn8B9KVTA==
X-Received: by 2002:a17:902:4403:: with SMTP id
 k3-v6mr16799680pld.243.1538490497957; 
 Tue, 02 Oct 2018 07:28:17 -0700 (PDT)
Received: from roar.local0.net (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id p3-v6sm21862621pfo.130.2018.10.02.07.28.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Oct 2018 07:28:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 6/9] powerpc/64s/hash: SLB fix preemption issues
Date: Wed,  3 Oct 2018 00:27:56 +1000
Message-Id: <20181002142759.6244-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181002142759.6244-1-npiggin@gmail.com>
References: <20181002142759.6244-1-npiggin@gmail.com>
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

slb_setup_new_exec and preload_new_slb_context run with interrupts
and preemption enabled, which can be corrupted by re-entrant interrupt
or process touching SLB preload cache or SLB allocator.

Hard disable interrupts over these regions.

Fixes: 5e46e29e6a97 ("powerpc/64s/hash: convert SLB miss handlers to C")
Fixes: 89ca4e126a3f ("powerpc/64s/hash: Add a SLB preload cache")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 8c38659f1b6b..b5a33da875b5 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -311,6 +311,8 @@ void slb_setup_new_exec(void)
 	struct mm_struct *mm = current->mm;
 	unsigned long exec = 0x10000000;
 
+	WARN_ON(irqs_disabled());
+
 	/*
 	 * preload cache can only be used to determine whether a SLB
 	 * entry exists if it does not start to overflow.
@@ -318,6 +320,8 @@ void slb_setup_new_exec(void)
 	if (ti->slb_preload_nr + 2 > SLB_PRELOAD_NR)
 		return;
 
+	hard_irq_disable();
+
 	/*
 	 * We have no good place to clear the slb preload cache on exec,
 	 * flush_thread is about the earliest arch hook but that happens
@@ -347,6 +351,8 @@ void slb_setup_new_exec(void)
 
 	/* see switch_slb */
 	asm volatile("isync" : : : "memory");
+
+	local_irq_enable();
 }
 
 void preload_new_slb_context(unsigned long start, unsigned long sp)
@@ -355,10 +361,14 @@ void preload_new_slb_context(unsigned long start, unsigned long sp)
 	struct mm_struct *mm = current->mm;
 	unsigned long heap = mm->start_brk;
 
+	WARN_ON(irqs_disabled());
+
 	/* see above */
 	if (ti->slb_preload_nr + 3 > SLB_PRELOAD_NR)
 		return;
 
+	hard_irq_disable();
+
 	/* Userspace entry address. */
 	if (!is_kernel_addr(start)) {
 		if (preload_add(ti, start))
@@ -379,6 +389,8 @@ void preload_new_slb_context(unsigned long start, unsigned long sp)
 
 	/* see switch_slb */
 	asm volatile("isync" : : : "memory");
+
+	local_irq_enable();
 }
 
 
-- 
2.18.0

