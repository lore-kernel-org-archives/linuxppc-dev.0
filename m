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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097DBC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 13:53:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633D064EFA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 13:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633D064EFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DmZ4z75Rtz3f47
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Feb 2021 00:53:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=Zd9/+fJB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432;
 helo=mail-pf1-x432.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Zd9/+fJB; dkim-atps=neutral
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DmYyP4c62z3d5H
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2021 00:47:57 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id t29so3625757pfg.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2021 05:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FGYCVyl5qXjwebi/u46IYNl3I3VlFCFB0eRTWRiaPFU=;
 b=Zd9/+fJBaQaHATcB1cKjB+Ry16+u0gjeugQgYRGrma7/1Creqsv7nrs8HiS92vyF0o
 fEbKWEflW7epS08ZrVD7aFrcgVfDNKhexxzLhAvURVWEdWQdNxpOe8cvmyjsMSYzXYZh
 8iMh4efteUhbF0CQjTRndsRJeP/a19rsBiShhVExmFfQ4iw/t+KTs8SKya0YZO12bUUo
 bu5Jiks3vQL1kV8wQejRs1drG7Ktxr4m27SZljiUSqYTrkZNK9VwTtOE3ArAtQUZEEXD
 dmkanXuxSNsFNiBM8rzflOr77vVUnK83Eex99prKmTKpFDUHST5Rvo/P8bAvpyerYQyV
 bmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FGYCVyl5qXjwebi/u46IYNl3I3VlFCFB0eRTWRiaPFU=;
 b=Sf2wicNo5XB0C7MRveX0mVykv+fhzW0DcCYzaAl6EbFMzsBVlwrOqbeWOhFlmPNImC
 OVkeacxhkDkRwR+HToFKyCzzZrZrGl4g5A5CvoBAeZwheamZOuxvIB7oKOBAJRwL86s7
 u9gx4kHbfylG95kowbk1jloHl+c0ycV5fNEQ8qnwx/eV5VyFP90CFyT98SOLsYMHGe1S
 dx+r6bqBlK315PCDvBOnNIP8Bl0WXdK+MVQZtXkowSjS/LksHeXaZekumHHpcaQT3S5J
 xLBmG+3pWta2ouj1bcDqIveywo0xCduLryKQ8CQ23d5HW6dZ74HDIkT//6AHgkiFsRRJ
 c4JA==
X-Gm-Message-State: AOAM532HSOBM0Z2bV+5Si6FlKTeiSSAHttWA0n4kAh3tkm3HikK/Q5jq
 uIHL9KjvQ3nbfc80s4Pm5iY=
X-Google-Smtp-Source: ABdhPJx5BZk10husdXQ7k44Rx1C1FfwF1Vsz1f+vgH6EJfpVQbwBLoV90YqFP98X0H1jrjStXY+ZoQ==
X-Received: by 2002:a05:6a00:2353:b029:1ba:d824:f1dc with SMTP id
 j19-20020a056a002353b02901bad824f1dcmr3363293pfj.9.1614260875507; 
 Thu, 25 Feb 2021 05:47:55 -0800 (PST)
Received: from bobo.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id a9sm5925868pjq.17.2021.02.25.05.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Feb 2021 05:47:54 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 15/37] KVM: PPC: Book3S HV P9: Move xive vcpu context
 management into kvmhv_p9_guest_entry
Date: Thu, 25 Feb 2021 23:46:30 +1000
Message-Id: <20210225134652.2127648-16-npiggin@gmail.com>
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

Move the xive management up so the low level register switching can be
pushed further down in a later patch. XIVE MMIO CI operations can run in
higher level code with machine checks, tracing, etc., available.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index e3344d58537d..7e23838b7f9b 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3549,15 +3549,11 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	switch_mmu_to_guest_radix(kvm, vcpu, lpcr);
 
-	kvmppc_xive_push_vcpu(vcpu);
-
 	mtspr(SPRN_SRR0, vcpu->arch.shregs.srr0);
 	mtspr(SPRN_SRR1, vcpu->arch.shregs.srr1);
 
 	trap = __kvmhv_vcpu_entry_p9(vcpu);
 
-	kvmppc_xive_pull_vcpu(vcpu);
-
 	/* Advance host PURR/SPURR by the amount used by guest */
 	purr = mfspr(SPRN_PURR);
 	spurr = mfspr(SPRN_SPURR);
@@ -3740,7 +3736,10 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 			trap = 0;
 		}
 	} else {
+		kvmppc_xive_push_vcpu(vcpu);
 		trap = kvmhv_load_hv_regs_and_go(vcpu, time_limit, lpcr);
+		kvmppc_xive_pull_vcpu(vcpu);
+
 	}
 
 	vcpu->arch.slb_max = 0;
-- 
2.23.0

