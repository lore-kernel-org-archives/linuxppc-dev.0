Return-Path: <SRS0=c12Q=ID=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA8DC433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 15:13:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3FD65013
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 15:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3FD65013
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsWTR1gLFz3dkN
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Mar 2021 02:13:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=OblvNJWG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031;
 helo=mail-pj1-x1031.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=OblvNJWG; dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsWLj4wkRz3dRS
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Mar 2021 02:07:41 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id h13so2216231pjt.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Mar 2021 07:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i/yeewQhUiQ0T9DZyWQBsO7hcNFmoeIz9mIQyOpJdyo=;
 b=OblvNJWGB/+QmLCjtBoDShlmF5hvoygSxnXHdt4P2rxUdFthjbgLZn8roIr9xZwkOj
 DlEy1bADz78pXMnX2hpIGywZiIy6BrTJJMr4VI5qIQErtJnzeRLTTekScKkmw64n5WZd
 a6sQs/vWVMKSbivzStmpJ7LK24HNCttVR7zG74EqcGt75VGJpnEpwRIuGGpnb/JTD1O9
 KvqauVnB6GKr71jkV4g39PK9dFqO5V9gvl5J5dDGJKnsPlJn9TiAgRDeuaYbpx62jJU4
 Zt8whC3+8I1UBDiQ1kyatSOG0rTQyypaQOXLk0e9ekNoxNmBXSTo6aZ9FhcNvnH6F4GO
 5sHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i/yeewQhUiQ0T9DZyWQBsO7hcNFmoeIz9mIQyOpJdyo=;
 b=ZCH422MeJ1rUoyOnAuDZ4aq+8ajLA9MANqvbGVGt2IgYFkT83+Ljy6wltIgYrrPtez
 T0BdgWBa1ZUGVk0Xq4uI47kEPk56Pj9vq24OqjF/5dYTJMptNijQi017QyQflGxfhC1c
 1+3KktTDjEug3yKLsUSbyLLEYd43dLz7j6JrOk+qnmmLvAu3GUwsz09sIWC1JQLtTWcJ
 j9J7JyoD9ILA49JZDWG2Pk1fgNeVRUN1CyraQttGfXW2GnzXrRitK81xhCzewRv5TQgC
 2BM3lERvponRKpnvn1TEaGm88ZGU/lHsx5LbgVAcVArzwXviNQ5PyEtMFcq6DlfIuJwc
 qatw==
X-Gm-Message-State: AOAM530W0YPnaI1ViPT7ygs9BKa/ZgfaSJctf/1pVLmcFr/OGkSd9nv0
 GSkdwetkkoJBha21mH99M8s=
X-Google-Smtp-Source: ABdhPJxzSW201g1TvhETvb9hl2LO8/RZbae5DQpoF7xecuB+GicFzQFFcu5r59jyxTOZQM83PAkv1w==
X-Received: by 2002:a17:90a:e7cd:: with SMTP id
 kb13mr10615428pjb.10.1614956859630; 
 Fri, 05 Mar 2021 07:07:39 -0800 (PST)
Received: from bobo.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id m5sm1348982pfd.96.2021.03.05.07.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Mar 2021 07:07:39 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v3 15/41] KVM: PPC: Book3S 64: Minimise hcall handler calling
 convention differences
Date: Sat,  6 Mar 2021 01:06:12 +1000
Message-Id: <20210305150638.2675513-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210305150638.2675513-1-npiggin@gmail.com>
References: <20210305150638.2675513-1-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This sets up the same calling convention from interrupt entry to
KVM interrupt handler for system calls as exists for other interrupt
types.

This is a better API, it uses a save area rather than SPR, and it has
more registers free to use. Using a single common API helps maintain
it, and it becomes easier to use in C in a later patch.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 16 +++++++++++++++-
 arch/powerpc/kvm/book3s_64_entry.S   | 22 +++-------------------
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index b4eab5084964..ce6f5f863d3d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1892,8 +1892,22 @@ EXC_VIRT_END(system_call, 0x4c00, 0x100)
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 TRAMP_REAL_BEGIN(kvm_hcall)
+	std	r9,PACA_EXGEN+EX_R9(r13)
+	std	r11,PACA_EXGEN+EX_R11(r13)
+	std	r12,PACA_EXGEN+EX_R12(r13)
+	mfcr	r9
 	mfctr	r10
-	SET_SCRATCH0(r10) /* Save r13 in SCRATCH0 */
+	std	r10,PACA_EXGEN+EX_R13(r13)
+	li	r10,0
+	std	r10,PACA_EXGEN+EX_CFAR(r13)
+	std	r10,PACA_EXGEN+EX_CTR(r13)
+BEGIN_FTR_SECTION
+	mfspr	r10,SPRN_PPR
+	std	r10,PACA_EXGEN+EX_PPR(r13)
+END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
+
+	HMT_MEDIUM
+
 #ifdef CONFIG_RELOCATABLE
 	/*
 	 * Requires __LOAD_FAR_HANDLER beause kvmppc_hcall lives
diff --git a/arch/powerpc/kvm/book3s_64_entry.S b/arch/powerpc/kvm/book3s_64_entry.S
index 7a6b060ceed8..129d3f81800e 100644
--- a/arch/powerpc/kvm/book3s_64_entry.S
+++ b/arch/powerpc/kvm/book3s_64_entry.S
@@ -14,24 +14,9 @@
 .global	kvmppc_hcall
 .balign IFETCH_ALIGN_BYTES
 kvmppc_hcall:
-	/*
-	 * This is a hcall, so register convention is as
-	 * Documentation/powerpc/papr_hcalls.rst, with these additions:
-	 * R13		= PACA
-	 * guest R13 saved in SPRN_SCRATCH0
-	 * R10		= free
-	 */
-BEGIN_FTR_SECTION
-	mfspr	r10,SPRN_PPR
-	std	r10,HSTATE_PPR(r13)
-END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
-	HMT_MEDIUM
-	mfcr	r10
-	std	r12,HSTATE_SCRATCH0(r13)
-	sldi	r12,r10,32
-	ori	r12,r12,0xc00
-	ld	r10,PACA_EXGEN+EX_R10(r13)
-	b	do_kvm_interrupt
+	ld	r10,PACA_EXGEN+EX_R13(r13)
+	SET_SCRATCH0(r10)
+	li	r10,0xc00
 
 .global	kvmppc_interrupt
 .balign IFETCH_ALIGN_BYTES
@@ -62,7 +47,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ld	r10,EX_R10(r11)
 	ld	r11,EX_R11(r11)
 
-do_kvm_interrupt:
 	/*
 	 * Hcalls and other interrupts come here after normalising register
 	 * contents and save locations:
-- 
2.23.0

