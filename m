Return-Path: <SRS0=MtJN=LQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F183C2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 11:08:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EFDE61351
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 11:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFDE61351
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8Ntt4ZC7z3fwV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 21:08:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=LbsTxDlX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430;
 helo=mail-pf1-x430.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=LbsTxDlX; dkim-atps=neutral
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8NgT50D0z3c4k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 20:59:01 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id a127so5555923pfa.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 03:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fJodkEL3mlkd09uEBZ0qy1MXGKcAacqn5bf7t2b6BD4=;
 b=LbsTxDlX3EJ/YgLJJ6Oo476zONcdaSAtPw7RTLXiDsSaaTi9AGcN0AU1IQPF+ExvKR
 0Sh++pLlOCTwvZhw0FaY+/TRTuSW8rmUEh/OE05n19IJZofbgPO6k9x8VKNypzDsy3u0
 SZOgOVtNkqJQ5m61Oej2SvlIM1TGnFAnoz8QcAkfCEaAfZBxILcIaccNL5lDl8YTamy5
 ZiOtSLQukq8USI0Ku+dlD0tUUPc8w50zCynW/tJUgxjtHObhEyppnVmZiilvNIFs2Is6
 0C+q+HVqgaYsJDg7BV3sTybVibd5FIC4reueexqHOIAZXATnSaymT5OViadml64bqEsH
 QfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fJodkEL3mlkd09uEBZ0qy1MXGKcAacqn5bf7t2b6BD4=;
 b=dXdabNhA6I1tBSobFUXPNFsHF2qZKTc8VeeqoCyZNbbuLXX0GXiKPQBLky652irbXG
 UJkCBb1SEJ9jhdbO8DfgQiJIMbnb9abPeICf0cQ90Nv8Jsd1ybovikXQIc8BYJHS8Bjg
 qwDtje+YVB8Xw/LuA6YyD3HYyPVMrApFY5XSygWqfc6ftdzTjA0ZEHVxwy6oLa81WaPL
 8fo/38VDmUH5ccWDs3J3IeCGD612On6CIOccXCDMdzeTua8TKkE9oxmHHWb08yyrTp5I
 VySvySbYv7OB6iZayQ6vH0YyBPCelg2dR67rM0UpWdb0qms5XE3a/Qx073rLFd/CMXct
 5J/w==
X-Gm-Message-State: AOAM532f37CCyJBnabPtrjJtoq0/pcbKn6il+RrEDXfwF06oYro27xnB
 MsSecnN9oz9UuATSRZ79UueKMTqU8Wk=
X-Google-Smtp-Source: ABdhPJygGW0fZVLDBJVE3wO94MhuNwPdJ3LH/1XjLnBXyOHKiG3WU0l9aO70MrwzHx/ApHkeUWjaYw==
X-Received: by 2002:a63:be45:: with SMTP id g5mr3168250pgo.311.1624359537779; 
 Tue, 22 Jun 2021 03:58:57 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id l6sm5623621pgh.34.2021.06.22.03.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 03:58:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [RFC PATCH 25/43] KVM: PPC: Book3S HV P9: Juggle SPR switching around
Date: Tue, 22 Jun 2021 20:57:18 +1000
Message-Id: <20210622105736.633352-26-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210622105736.633352-1-npiggin@gmail.com>
References: <20210622105736.633352-1-npiggin@gmail.com>
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

This juggles SPR switching on the entry and exit sides to be more
symmetric, which makes the next refactoring patch possible with no
functional change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 612b70216e75..a780a9b9effd 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4069,7 +4069,7 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
 		kvmppc_restore_tm_hv(vcpu, vcpu->arch.shregs.msr, true);
 
-	switch_pmu_to_guest(vcpu, &host_os_sprs);
+	load_spr_state(vcpu, &host_os_sprs);
 
 	load_fp_state(&vcpu->arch.fp);
 #ifdef CONFIG_ALTIVEC
@@ -4077,7 +4077,7 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 #endif
 	mtspr(SPRN_VRSAVE, vcpu->arch.vrsave);
 
-	load_spr_state(vcpu, &host_os_sprs);
+	switch_pmu_to_guest(vcpu, &host_os_sprs);
 
 	if (kvmhv_on_pseries()) {
 		/*
@@ -4177,6 +4177,8 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 			vcpu->arch.slb_max = 0;
 	}
 
+	switch_pmu_to_host(vcpu, &host_os_sprs);
+
 	store_spr_state(vcpu);
 
 	store_fp_state(&vcpu->arch.fp);
@@ -4191,8 +4193,6 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	vcpu_vpa_increment_dispatch(vcpu);
 
-	switch_pmu_to_host(vcpu, &host_os_sprs);
-
 	timer_rearm_host_dec(*tb);
 
 	restore_p9_host_os_sprs(vcpu, &host_os_sprs);
-- 
2.23.0

