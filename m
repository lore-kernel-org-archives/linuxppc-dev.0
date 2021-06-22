Return-Path: <SRS0=MtJN=LQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE918C2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 11:09:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56BE861076
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 11:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BE861076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8Nvn6b45z3g5M
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 21:09:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=nx1aCIo+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f;
 helo=mail-pl1-x62f.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=nx1aCIo+; dkim-atps=neutral
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8NgX0kbpz3c53
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 20:59:03 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id f10so8119595plg.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 03:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+VQVm8iqw2WbTFtSnmqUmUPnGnahuafjyJU8AqyBfZk=;
 b=nx1aCIo+0V3MG6kMLg2e8AVqZvDHmd+5nyqfs7J9Y5J7DaGXrhGzYXqHYZLod+Wh2P
 hWM/wAcFuwtWAuMcn0YTG0ilP9xTJ9/sGWJYSdG5YmsqwgCZn5vsl003QCzYrc8xuMWG
 A2B215zqe3bwRqFo9RCXbC7/yRRXfwbi4fT96xdaG/e44UWijJLslOth4NbqLWd+4Bk8
 iVJwnfMtfVbOSP/3/0GOVcrX9NiSXQrd/FO796vecgUn4TNGEQOXcZ8xXQRTkHll7/Iq
 jb/SocYPjb2hEbAKv7n24fUDAGTqHSg9+QEju+aHslgmsDBpKAaraXfZW8Xok5MiMYEZ
 0qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+VQVm8iqw2WbTFtSnmqUmUPnGnahuafjyJU8AqyBfZk=;
 b=gwg7jXeQsrdqnV1AnOPvCUIWewPI1hVLF5bZtBbkHCQjaGN8fThIlKurWrpfV7PCc2
 /ZF3ZN/TqHGwpMr8ZeUM25HAwhUJvvyOmPrz88Lk3j7Ub7LSPlmAU5HQK0ZYsPSzwRBW
 L7RUNXz3FnxBHgGQGpf9Crli50sl8QLn1PUuf0D1UM04A7KHqjSyGqf4+5l7rfelLUtZ
 XkJVxVxoNjOKYSUmhIgMffb2Y+sh2xDjJnXnzcCTxYDXzwRxACbhfie5t34hATcwnvRQ
 CksgC/e2xzpmVcw4475aEIAuw4RP9tZbpCBHYmHP+H8azi8DXIj4uqlfouhb2HglhK6U
 g98Q==
X-Gm-Message-State: AOAM531DCCShHQiO6Pf34pYsXgR5mUZunkYZkE8chxTgPZAN0tH2glpZ
 U2E86QaFodkV4NK1UOg777s=
X-Google-Smtp-Source: ABdhPJwBUlyKqVQy1LFjCcucqHbd9NGFmY8xxbNCKOnWjv4FPipEb0Jj+AEs30ooJzrmSYV0hGLjkA==
X-Received: by 2002:a17:903:3093:b029:121:d072:d3e with SMTP id
 u19-20020a1709033093b0290121d0720d3emr12510560plc.30.1624359539965; 
 Tue, 22 Jun 2021 03:58:59 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id l6sm5623621pgh.34.2021.06.22.03.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 03:58:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [RFC PATCH 26/43] KVM: PPC: Book3S HV P9: Move vcpu register
 save/restore into functions
Date: Tue, 22 Jun 2021 20:57:19 +1000
Message-Id: <20210622105736.633352-27-npiggin@gmail.com>
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

This should be no functional difference but makes the caller easier
to read.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 55 +++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index a780a9b9effd..35749b0b663f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3958,6 +3958,37 @@ static void store_spr_state(struct kvm_vcpu *vcpu)
 	vcpu->arch.ctrl = mfspr(SPRN_CTRLF);
 }
 
+static void load_vcpu_state(struct kvm_vcpu *vcpu,
+			   struct p9_host_os_sprs *host_os_sprs)
+{
+	if (cpu_has_feature(CPU_FTR_TM) ||
+	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
+		kvmppc_restore_tm_hv(vcpu, vcpu->arch.shregs.msr, true);
+
+	load_spr_state(vcpu, host_os_sprs);
+
+	load_fp_state(&vcpu->arch.fp);
+#ifdef CONFIG_ALTIVEC
+	load_vr_state(&vcpu->arch.vr);
+#endif
+	mtspr(SPRN_VRSAVE, vcpu->arch.vrsave);
+}
+
+static void store_vcpu_state(struct kvm_vcpu *vcpu)
+{
+	store_spr_state(vcpu);
+
+	store_fp_state(&vcpu->arch.fp);
+#ifdef CONFIG_ALTIVEC
+	store_vr_state(&vcpu->arch.vr);
+#endif
+	vcpu->arch.vrsave = mfspr(SPRN_VRSAVE);
+
+	if (cpu_has_feature(CPU_FTR_TM) ||
+	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
+		kvmppc_save_tm_hv(vcpu, vcpu->arch.shregs.msr, true);
+}
+
 static void save_p9_host_os_sprs(struct p9_host_os_sprs *host_os_sprs)
 {
 	if (!cpu_has_feature(CPU_FTR_ARCH_31))
@@ -4065,17 +4096,7 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	vcpu_vpa_increment_dispatch(vcpu);
 
-	if (cpu_has_feature(CPU_FTR_TM) ||
-	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
-		kvmppc_restore_tm_hv(vcpu, vcpu->arch.shregs.msr, true);
-
-	load_spr_state(vcpu, &host_os_sprs);
-
-	load_fp_state(&vcpu->arch.fp);
-#ifdef CONFIG_ALTIVEC
-	load_vr_state(&vcpu->arch.vr);
-#endif
-	mtspr(SPRN_VRSAVE, vcpu->arch.vrsave);
+	load_vcpu_state(vcpu, &host_os_sprs);
 
 	switch_pmu_to_guest(vcpu, &host_os_sprs);
 
@@ -4179,17 +4200,7 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	switch_pmu_to_host(vcpu, &host_os_sprs);
 
-	store_spr_state(vcpu);
-
-	store_fp_state(&vcpu->arch.fp);
-#ifdef CONFIG_ALTIVEC
-	store_vr_state(&vcpu->arch.vr);
-#endif
-	vcpu->arch.vrsave = mfspr(SPRN_VRSAVE);
-
-	if (cpu_has_feature(CPU_FTR_TM) ||
-	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
-		kvmppc_save_tm_hv(vcpu, vcpu->arch.shregs.msr, true);
+	store_vcpu_state(vcpu);
 
 	vcpu_vpa_increment_dispatch(vcpu);
 
-- 
2.23.0

