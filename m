Return-Path: <SRS0=yiwx=H3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6C7C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 13:58:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3944F64F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 13:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3944F64F13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DmZBl4mW4z3dhg
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Feb 2021 00:58:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=oEq6KFmH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c;
 helo=mail-pg1-x52c.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=oEq6KFmH; dkim-atps=neutral
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DmYzB1L3mz3cbj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2021 00:48:38 +1100 (AEDT)
Received: by mail-pg1-x52c.google.com with SMTP id b21so3809124pgk.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2021 05:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4wpRUIXYsph30RZ+o04YHt9M47A98ys3vHV9XOremLs=;
 b=oEq6KFmHXRFXCmls+yOQT9IO5CWXZ8JmfrXrz1qZvOOvuCFPvSWwvnMUfjvlaXcWnM
 k7//repmAwqZY2KIyLPmjx5+ciDhQP23uZ9UQycPgelC3yaUnX/LsJiFI2nsUwpRnwIg
 kwHUVq63k15vh9zvYWG/Oqs2ZxBuBptilpvff3t0ODpz6qChGSNE0hcvZPxekx5e8Tde
 fA9VCIsCi3xotst0DZCD4gSJu0qSzwTVXv4dKCba4BT3iqOio7uABDRUuksSOmpSrqBU
 Ehn7X/0gjEjvJrcUUfMUsttC2cdxxp9ugQ5Be2hGRxqH5oUqDUtkl94/3SIpWugFU3lw
 I0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4wpRUIXYsph30RZ+o04YHt9M47A98ys3vHV9XOremLs=;
 b=IKH+1bfqDC8mp1k2557nre1yX1rk+qqcXGnBXCF05RDW9JWKB1bf2BlMzM48Hp+5Y6
 2TufqgjQqkAWPnCGfVfVcORSUYjCj5prFEsqpp91R9yw4+uxvht8TO8b/kiKEKx4uLFU
 a6WR01jHdKM3VutubDdXVV3VBckOca+GgALjl7ghyIHfCaJE4ofR1B7vtIZOFX9cMMLu
 Ps9yKRB2riij+2nX6iF1mBSXtvLmzzyrRofpk26mNkiYvZS/kly929eSaRF1K7Uqh4VH
 7fEGdW7iUHlQsedCKv/imoyt6q5OLZU591ZBHc4vkvoj3rFLsbImMFkpzlf37QI0G7hZ
 ebjQ==
X-Gm-Message-State: AOAM532uLJtdXT8f3BQqwEdqQ07v8wO1sGNiqSxiFxHv7hFFSKYyCg15
 BnCaN4diUIEFULsnimfLwjg=
X-Google-Smtp-Source: ABdhPJzooV747wcG/f0eQ83XVGXoIqrpt9BT1iLlSxgTTidzwjL+5hbDniMdc1wEKts8PZDfFFnsFA==
X-Received: by 2002:a63:df01:: with SMTP id u1mr3052930pgg.341.1614260916109; 
 Thu, 25 Feb 2021 05:48:36 -0800 (PST)
Received: from bobo.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id a9sm5925868pjq.17.2021.02.25.05.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Feb 2021 05:48:35 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 27/37] KVM: PPC: Book3S HV P9: Move SPR loading after
 expiry time check
Date: Thu, 25 Feb 2021 23:46:42 +1000
Message-Id: <20210225134652.2127648-28-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210225134652.2127648-1-npiggin@gmail.com>
References: <20210225134652.2127648-1-npiggin@gmail.com>
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

This is wasted work if the time limit is exceeded.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_interrupt.c | 38 ++++++++++++++++----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_interrupt.c b/arch/powerpc/kvm/book3s_hv_interrupt.c
index 4a158c8fc0bc..dd0a78a69f49 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupt.c
+++ b/arch/powerpc/kvm/book3s_hv_interrupt.c
@@ -126,22 +126,17 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 	s64 hdec;
 	u64 tb, purr, spurr;
 	u64 *exsave;
-	bool ri_clear;
-	unsigned long msr = mfmsr();
 	int trap;
-	unsigned long host_hfscr = mfspr(SPRN_HFSCR);
-	unsigned long host_ciabr = mfspr(SPRN_CIABR);
-	unsigned long host_dawr0 = mfspr(SPRN_DAWR0);
-	unsigned long host_dawrx0 = mfspr(SPRN_DAWRX0);
-	unsigned long host_psscr = mfspr(SPRN_PSSCR);
-	unsigned long host_pidr = mfspr(SPRN_PID);
-	unsigned long host_dawr1 = 0;
-	unsigned long host_dawrx1 = 0;
-
-	if (cpu_has_feature(CPU_FTR_DAWR1)) {
-		host_dawr1 = mfspr(SPRN_DAWR1);
-		host_dawrx1 = mfspr(SPRN_DAWRX1);
-	}
+	bool ri_clear;
+	unsigned long msr;
+	unsigned long host_hfscr;
+	unsigned long host_ciabr;
+	unsigned long host_dawr0;
+	unsigned long host_dawrx0;
+	unsigned long host_psscr;
+	unsigned long host_pidr;
+	unsigned long host_dawr1;
+	unsigned long host_dawrx1;
 
 	tb = mftb();
 	hdec = time_limit - tb;
@@ -159,6 +154,19 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 		vc->tb_offset_applied = vc->tb_offset;
 	}
 
+	msr = mfmsr();
+
+	host_hfscr = mfspr(SPRN_HFSCR);
+	host_ciabr = mfspr(SPRN_CIABR);
+	host_dawr0 = mfspr(SPRN_DAWR0);
+	host_dawrx0 = mfspr(SPRN_DAWRX0);
+	host_psscr = mfspr(SPRN_PSSCR);
+	host_pidr = mfspr(SPRN_PID);
+	if (cpu_has_feature(CPU_FTR_DAWR1)) {
+		host_dawr1 = mfspr(SPRN_DAWR1);
+		host_dawrx1 = mfspr(SPRN_DAWRX1);
+	}
+
 	if (vc->pcr)
 		mtspr(SPRN_PCR, vc->pcr | PCR_MASK);
 	mtspr(SPRN_DPDES, vc->dpdes);
-- 
2.23.0

