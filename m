Return-Path: <SRS0=m4lh=I6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CDCC433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 15:16:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4C861367
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 15:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4C861367
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FB6G43Dcjz3cFY
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Apr 2021 02:16:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=o5x803va;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d;
 helo=mail-pf1-x42d.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=o5x803va; dkim-atps=neutral
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FB61C62RWz30Pl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Apr 2021 02:05:03 +1100 (AEDT)
Received: by mail-pf1-x42d.google.com with SMTP id c204so1684723pfc.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Apr 2021 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q5kLhVg/MvykyPPNmMCuNWVc2bIiaBHBOMGefD2pi70=;
 b=o5x803vaLuhSLiL2m55/F18h/axKjowbv/0eLFEK1BEfhPNw/VYH96aFwytbqBXw7/
 8vzQA0Kl6Y590eyI/6zLOIh4XiS9OOD5GZCsDNHOukGmY+I/3oitK+TNJ2wJc5TRHeKM
 EIq7tBMspWCpDxapOj8396C0/rcunlNAchb/Y0NL5FA1VeBAAREWxL6NC5nRBNZaK3Bo
 eGFm3SP1PS/MSqWjSC3rgwsLQ6E4l7VYcQ6FjFRTd2h5gf3CmLMdwcQmKnupJISdL5ze
 LvrnzfHNm8JzTy7yTtKYK1YM60fZQ3RDj17MJTtbajWQXg4pq8T9Idp6PLGF3sRZr6aA
 acrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q5kLhVg/MvykyPPNmMCuNWVc2bIiaBHBOMGefD2pi70=;
 b=bKoqQwTJijq5gaFdkNZk55c/EhpNPT7CpViiF8+bidY2bep3Zn72clAKb0pI7W+DGR
 9P3nsd/hjUxgpfeeZfq7YD8WhKQHWkg7KpoBI2HjB/W6IjwHx1KZFQxatqXFxpOd0ykV
 1Ya1TPiHS8yGGoJY+FXDbtZ2QWQzVgk/KnQ7C/HlXTdaZdSmhxirIJfoFKs4qoIlQZFa
 5HCTmYDGVSFm/giqXjbCiBAxQZqpim/b9BznoVO5vLuzYYTZzC7DlTtvpW94R1hI+DFh
 opL7K3+5+f6gNqubLBesPVl2Ts4nQSQaHdV5NcQKSzNzDAGO1zpoue1HSCdBytB0QNVg
 UlXg==
X-Gm-Message-State: AOAM5301bODkfgBl2z1CSRQYiYSUuzP+N7AuO7ppWU2puLhI78FPPiB2
 EajZQbbW1X9jv9rdfEocIbk=
X-Google-Smtp-Source: ABdhPJx8LV+GqfZ+ydBxBTgRLBsgiGqZmiv4U0JPdlfOj8dd8zWmoiGU/1i3txf4PH8zazf/csVeGw==
X-Received: by 2002:a63:a54:: with SMTP id z20mr7879950pgk.228.1617289500976; 
 Thu, 01 Apr 2021 08:05:00 -0700 (PDT)
Received: from bobo.ibm.com ([1.128.218.207])
 by smtp.gmail.com with ESMTPSA id l3sm5599632pju.44.2021.04.01.08.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 08:05:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v5 27/48] KVM: PPC: Book3S HV P9: Reduce irq_work vs guest
 decrementer races
Date: Fri,  2 Apr 2021 01:03:04 +1000
Message-Id: <20210401150325.442125-28-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210401150325.442125-1-npiggin@gmail.com>
References: <20210401150325.442125-1-npiggin@gmail.com>
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

irq_work's use of the DEC SPR is racy with guest<->host switch and guest
entry which flips the DEC interrupt to guest, which could lose a host
work interrupt.

This patch closes one race, and attempts to comment another class of
races.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 46f457c3b828..6cfac8f553f6 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3755,6 +3755,18 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 	if (!(vcpu->arch.ctrl & 1))
 		mtspr(SPRN_CTRLT, mfspr(SPRN_CTRLF) & ~1);
 
+	/*
+	 * When setting DEC, we must always deal with irq_work_raise via NMI vs
+	 * setting DEC. The problem occurs right as we switch into guest mode
+	 * if a NMI hits and sets pending work and sets DEC, then that will
+	 * apply to the guest and not bring us back to the host.
+	 *
+	 * irq_work_raise could check a flag (or possibly LPCR[HDICE] for
+	 * example) and set HDEC to 1? That wouldn't solve the nested hv
+	 * case which needs to abort the hcall or zero the time limit.
+	 *
+	 * XXX: Another day's problem.
+	 */
 	mtspr(SPRN_DEC, vcpu->arch.dec_expires - tb);
 
 	if (kvmhv_on_pseries()) {
@@ -3891,6 +3903,9 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	next_timer = timer_get_next_tb();
 	mtspr(SPRN_DEC, next_timer - tb);
+	/* We may have raced with new irq work */
+	if (test_irq_work_pending())
+		set_dec(1);
 	mtspr(SPRN_SPRG_VDSO_WRITE, local_paca->sprg_vdso);
 
 	kvmhv_load_host_pmu();
-- 
2.23.0

