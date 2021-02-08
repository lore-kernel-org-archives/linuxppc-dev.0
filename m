Return-Path: <SRS0=fNlO=HK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D07C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Feb 2021 06:35:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FAB164E59
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Feb 2021 06:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAB164E59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DYx980S9hzDvVK
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Feb 2021 17:35:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435;
 helo=mail-pf1-x435.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=gUT9EHMH; dkim-atps=neutral
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DYx783GnxzDqBy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2021 17:33:40 +1100 (AEDT)
Received: by mail-pf1-x435.google.com with SMTP id q20so9057635pfu.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Feb 2021 22:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i7/hEV/Aa4hlIWU2sUnHFM/KMLogNiY7EjbGcwIqZGw=;
 b=gUT9EHMH+SULn1592OovxVEEjYYLkAhyvAltFsVO1M4K/VAcPOWgEKpAZK4XdLJBuZ
 ScMPdjkAEGH2rAhLQ3Zv6eFcLFPu9VAOWmrIYZdtBi+KTepTomJajoDY9jKZCFyNLMKJ
 38GmnnihZ7Wre2WD3EornO5tARmbYS9fjxfFteFFW1vWEsM1WofeGcjqUy4DrFsoh9JZ
 eVlEhOU7MDv0XshSaRanFM8ncQC0edSdPJn3onIwHZ8ubG4yypRXrLVKjZ5fvjhfg8hE
 y5w6YHIZQCk1ikSaYw/8oyKumIJ4p33SdU1cEm+2M1gdtOsgSWWLrt4lx9gQmNA/Zxzf
 IfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i7/hEV/Aa4hlIWU2sUnHFM/KMLogNiY7EjbGcwIqZGw=;
 b=UC4TzMkBY2A/5BQPqeS42EsDgPRZDfxXc7usjrzeHr2Uq4OuJTiFuNStSzkiHUIktq
 5N0a9L4e++eCslXdcatMqY40dwAx3s5JgF5SEjt+itPk8iKfTH8HYSDGnVVAsMB3gXNM
 bZipjoYuwLx2RZhSmen55L8Bv3QplLBKcAWD4d33zn5/7I1rw369brr0JpbxCwjEJEuY
 eLIYKW8NmfpqXbX/i6sO5aR3v+SvU0vasD3pYXBNYhf9MP7L5Y5akkI5tQEGvvSIA9g1
 5As4M35t6K1FCqHnYjppAMt1MEHO4/ronyJY3v16tqxXAc6qZDJEhNs6w13fqS3A+UP8
 G2WQ==
X-Gm-Message-State: AOAM533FmHyR2n2P1SxNkFP4zx4bnJJM/jhnw1YWGJNQ6JcnPSwynCKf
 5o+J8mXuB6VFnFnHVBudqOh9uCpfjO0=
X-Google-Smtp-Source: ABdhPJzou4+VNrCAm6E24QymR4aK41aIgin4G45ys3fUvW5jlaqYm9NM2PoKnmPvmVzJ0AaJJcc63Q==
X-Received: by 2002:a63:5459:: with SMTP id e25mr15911103pgm.403.1612766014951; 
 Sun, 07 Feb 2021 22:33:34 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([1.132.136.97])
 by smtp.gmail.com with ESMTPSA id t17sm18374914pgk.25.2021.02.07.22.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Feb 2021 22:33:34 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64s: syscall real mode entry use mtmsrd rather than
 rfid
Date: Mon,  8 Feb 2021 16:33:26 +1000
Message-Id: <20210208063326.331502-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
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

Have the real mode system call entry handler branch to the kernel
0xc000... address and then use mtmsrd to enable the MMU, rather than use
SRRs and rfid.

Commit 8729c26e675c ("powerpc/64s/exception: Move real to virt switch
into the common handler") implemented this style of real mode entry for
other interrupt handlers, so this brings system calls into line with
them, which is the main motivcation for the change.

This tends to be slightly faster due to avoiding the mtsprs, and it also
does not clobber the SRR registers, which becomes important in a
subsequent change. The real mode entry points don't tend to be too
important for performance these days, but it is possible for a
hypervisor to run guests in AIL=0 mode for certian reasons.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/entry_64.S       | 6 ++++++
 arch/powerpc/kernel/exceptions-64s.S | 9 +++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 33ddfeef4fe9..993ed95ed602 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -225,6 +225,12 @@ _ASM_NOKPROBE_SYMBOL(system_call_vectored_emulate)
 	b	system_call_vectored_common
 #endif
 
+	.balign IFETCH_ALIGN_BYTES
+	.globl system_call_common_real
+system_call_common_real:
+	ld	r10,PACAKMSR(r13)	/* get MSR value for kernel */
+	mtmsrd	r10
+
 	.balign IFETCH_ALIGN_BYTES
 	.globl system_call_common
 system_call_common:
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5478ffa85603..dad35b59bcfb 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1905,12 +1905,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	HMT_MEDIUM
 
 	.if ! \virt
-	__LOAD_HANDLER(r10, system_call_common)
-	mtspr	SPRN_SRR0,r10
-	ld	r10,PACAKMSR(r13)
-	mtspr	SPRN_SRR1,r10
-	RFI_TO_KERNEL
-	b	.	/* prevent speculative execution */
+	__LOAD_HANDLER(r10, system_call_common_real)
+	mtctr	r10
+	bctr
 	.else
 	li	r10,MSR_RI
 	mtmsrd 	r10,1			/* Set RI (EE=0) */
-- 
2.23.0

