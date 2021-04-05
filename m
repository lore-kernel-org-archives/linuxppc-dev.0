Return-Path: <SRS0=L/Xq=JC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D4DC433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 01:24:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52756138D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 01:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52756138D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FDCcT3z1Pz3dhg
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 11:24:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=DDRSr5jw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030;
 helo=mail-pj1-x1030.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=DDRSr5jw; dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FDCX50lCNz3bwb
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Apr 2021 11:20:36 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id t23so2030423pjy.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Apr 2021 18:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d/LPXjK92NbOrRa0PeaBki14cO228KIgPnhx2QtNvNo=;
 b=DDRSr5jwRsiT2dvsHefsVNe0wEkujn8kPwsfJQ1nnAy+62x3pXmdNkjnm44KI9+rud
 KsF3F+5HLP0oyZIj3lZ6A9MGMjmgAympt3R+Ao4H3V2h4sC2m8mCrdC1lylRDYA1j0R0
 xmaTR9qItovcvzQ3hdtgbNdIETV67gm7f4X5EOXvIWUZIPgj16dSTrs7RGGoQZlSlJrs
 c6x3AMkXABxiBV0yc4H5C63zN2HTAYEt35PBVo4FPAgG9aO+8KMHSCX1817tut0mDrIe
 /nxa4EDEKJmg8LN3+ChotvsWKOp4JAHjZi2PVzpcSKKro7Zu4WaeNQfkiBg8mWX0iamM
 uA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d/LPXjK92NbOrRa0PeaBki14cO228KIgPnhx2QtNvNo=;
 b=ezV/LxnD5OyAdybO0X/5wMJuMycCe3453t3Ya+0hBffX5cWOdoeYbm1LdETNTmPZ0c
 8EfFEeoNFzlwfn+G2UEe5VONf1ALD8wt9R/Z9ZQ76hVcOBrqawdNHWZ+Vf8tYwUoLUoS
 ymW8vjXVBzKRZdUW2oEnY2U1MVLw6FhoxtLbuayhYJap1lqxJIRvb/U60zdWGC0yZnzW
 zBPYzjCxPMRxMecM569Pptl4OXywFBBWIK4LW1w0u0STmRWRy9DibKqgCoT02oBcDEpk
 cMxdal26/olyrTAdXRJ2asOvcEXbJ1Y55uvcjuVFBMV/PaEAnqGCw4rWotP7x+axXx7A
 6vuQ==
X-Gm-Message-State: AOAM533JOnPOSuxgUmCfWlFqU4LhhkPvqg8+LmemrtRWOX2Ny6l+KTth
 P2/B6F1Jq0IICOGD9cmGLdg=
X-Google-Smtp-Source: ABdhPJys3TkaeqCURnzpiDgIzaQ9FVU//McEKHlQFYV6EF3gG7ZW8hRaiHX3Ai1aQf9Q/dZjLFy3eg==
X-Received: by 2002:a17:90a:fa7:: with SMTP id 36mr8541313pjz.80.1617585634599; 
 Sun, 04 Apr 2021 18:20:34 -0700 (PDT)
Received: from bobo.ibm.com ([1.132.215.134])
 by smtp.gmail.com with ESMTPSA id e3sm14062536pfm.43.2021.04.04.18.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Apr 2021 18:20:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v6 09/48] powerpc/64s: remove KVM SKIP test from instruction
 breakpoint handler
Date: Mon,  5 Apr 2021 11:19:09 +1000
Message-Id: <20210405011948.675354-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210405011948.675354-1-npiggin@gmail.com>
References: <20210405011948.675354-1-npiggin@gmail.com>
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
Cc: Fabiano Rosas <farosas@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The code being executed in KVM_GUEST_MODE_SKIP is hypervisor code with
MSR[IR]=0, so the faults of concern are the d-side ones caused by access
to guest context by the hypervisor.

Instruction breakpoint interrupts are not a concern here. It's unlikely
any good would come of causing breaks in this code, but skipping the
instruction that caused it won't help matters (e.g., skip the mtmsr that
sets MSR[DR]=0 or clears KVM_GUEST_MODE_SKIP).

 [Paul notes: the 0x1300 interrupt was dropped from the architecture a
  long time ago and is not generated by P7, P8, P9 or P10.]

In fact it does not exist in ISA v2.01, which is the earliest supported
now, but did exist in 600 series designs (some of the earliest 64-bit
powerpcs), so it could probably be removed entirely.

Acked-by: Paul Mackerras <paulus@ozlabs.org>
Reviewed-by: Daniel Axtens <dja@axtens.net>
Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a0515cb829c2..c9c446ccff54 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -2553,7 +2553,6 @@ EXC_VIRT_NONE(0x5200, 0x100)
 INT_DEFINE_BEGIN(instruction_breakpoint)
 	IVEC=0x1300
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
-	IKVM_SKIP=1
 	IKVM_REAL=1
 #endif
 INT_DEFINE_END(instruction_breakpoint)
-- 
2.23.0

