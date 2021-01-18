Return-Path: <SRS0=8WtT=GV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982E3C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Jan 2021 06:39:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4672225C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Jan 2021 06:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4672225C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DK2Fg4zmjzDqlc
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Jan 2021 17:39:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629;
 helo=mail-pl1-x629.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=N0eb0hKe; dkim-atps=neutral
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DK20t092FzDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2021 17:28:29 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id b8so8072627plh.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jan 2021 22:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UiAmv+Y6nRSowY9FUmRqMjFf96IEIuV+ew6LphQamhM=;
 b=N0eb0hKejT3cF5qk+iys/MlopNKWN6fTNAyXS5tzBZ9o6kiIOH7SPkQGqfW9G1jPEL
 XBsRMx/rbAIq2ZNtH6cx3VA2h94/5YnaJWhH6Ca1MHuPFGI+/4cBi+s9qvLAGwyc6pHW
 EGcXEAsku6Y8qx+sa6WxHS6uaxO/eVS747bLJ+33dx0Wkac69eeoVkhlEedBGDx3I/K2
 3E+Par39Phq9+NtG85LbR/IhzERxsjUQVW8CZkK7l3eWkN8kG9BThxj1rIMMqJIRuZiC
 HwbblkJfjCL9Uch6JzlJNmb+4EYlYNr2INLmKQK3A95xURwxPdW6/PL6nHzn3SpMRACa
 cvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UiAmv+Y6nRSowY9FUmRqMjFf96IEIuV+ew6LphQamhM=;
 b=fvJyJSVwQWpM2ADiEFuQ34M3qDt26FIH+2iJU7wgEvaWmK0Vvx1GVqP080BxkhnEvp
 s5REcWj5DthNhwlM8xvtmLCia07bwB2yPTA4KOanfmvhgEfnk1p+qnfiZBLOPJ90Cftb
 owBMK+Q6Nnko4KaqUo4sbUX7J2KADgE+tVjhrCojvM/QLYC2dG4+QLZiLyhPs+Vbbzbm
 WjqzkqW+MPh/HGb9c+n1gCDzbDZALMQBd/FKvgsu8f5eL31WYhPn+oBryAhdNATiKhYI
 YKtVlN3/M2iGoaL/FL/ZEwfy6RPqPEPY0SZZ7iE81p3qLsCRE33tZzlstz4YsI0o2uy0
 axwA==
X-Gm-Message-State: AOAM531u48Kc3sbT5gGCYLOLNo8UZPEyTKHnCf/qGz+Tr/155pOakQpx
 kLWOJhv9FSNrxZEMCCZwpaY=
X-Google-Smtp-Source: ABdhPJy8axW3TJYhPYIy4ERbkxXXE2ScyvW18xHdn1mnhayeW21IiVY99Gm9u6CdAigBEAXn93qPRg==
X-Received: by 2002:a17:90b:1649:: with SMTP id
 il9mr20972704pjb.62.1610951307059; 
 Sun, 17 Jan 2021 22:28:27 -0800 (PST)
Received: from bobo.ibm.com ([124.170.13.62])
 by smtp.gmail.com with ESMTPSA id w25sm8502318pfg.103.2021.01.17.22.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Jan 2021 22:28:26 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 4/4] KVM: PPC: Book3S HV: Use POWER9 SLBIA IH=6 variant to
 clear SLB
Date: Mon, 18 Jan 2021 16:28:09 +1000
Message-Id: <20210118062809.1430920-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210118062809.1430920-1-npiggin@gmail.com>
References: <20210118062809.1430920-1-npiggin@gmail.com>
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

IH=6 may preserve hypervisor real-mode ERAT entries and is the
recommended SLBIA hint for switching partitions.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 9f0fdbae4b44..8cf1f69f442e 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -898,7 +898,7 @@ BEGIN_MMU_FTR_SECTION
 	/* Radix host won't have populated the SLB, so no need to clear */
 	li	r6, 0
 	slbmte	r6, r6
-	slbia
+	PPC_SLBIA(6)
 	ptesync
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 
@@ -1506,7 +1506,7 @@ guest_exit_cont:		/* r9 = vcpu, r12 = trap, r13 = paca */
 	/* Finally clear out the SLB */
 	li	r0,0
 	slbmte	r0,r0
-	slbia
+	PPC_SLBIA(6)
 	ptesync
 	stw	r5,VCPU_SLB_MAX(r9)
 
@@ -3329,7 +3329,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 
 	/* Clear hash and radix guest SLB, see guest_exit_short_path comment. */
 	slbmte	r0, r0
-	slbia
+	PPC_SLBIA(6)
 
 BEGIN_MMU_FTR_SECTION
 	b	4f
-- 
2.23.0

