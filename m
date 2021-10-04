Return-Path: <SRS0=/PaX=OY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A623C433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Oct 2021 16:20:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F188A61206
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Oct 2021 16:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F188A61206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HNQst58xFz3flH
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Oct 2021 03:20:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ZCX0inXv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432;
 helo=mail-pf1-x432.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=ZCX0inXv; dkim-atps=neutral
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HNQTG1cwqz3cCR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Oct 2021 03:02:10 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id 145so14896093pfz.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Oct 2021 09:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cHcJEgGt4n//rNMwXrbb2Y/Mu7D+Fv1X8CuV0T7O8Vs=;
 b=ZCX0inXv0MrSy7yOTcot9uSY5rrJGLIWLiBIXdPGSJF6ASQUYWsaU0/w5uKPzWV+Ui
 aWfbjTapfvTvkn+PALykkkqrRyOv/scTGMbD5fEwq+W5rMZbInywp1Dn9azhGAp1YIen
 /FpV4zfB6u8JxhpreDlufSAvb/j4qRtndFI0tdpYHxL7zXKpkWsj+j/EW17Jm+e+A3U4
 QGOirG8ta+hzx3mjWOglhvMyO7nLfkdft/8yORz23dTBVkFcpNtO1FLCMJ+B2xeidln4
 aC0wqJAXZlM/AiwblHZ5c9GUvpTN4oNxT9jTwhI+cQDv1RdxF0okXw9n2KEUXP+rVlxW
 wp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cHcJEgGt4n//rNMwXrbb2Y/Mu7D+Fv1X8CuV0T7O8Vs=;
 b=Hu2z6DRm4GzMu9z4NJwS8h0ES5Eq/UfqLnZP/vhio6sU/dteH+jZvTH1nI5L0f/Ukj
 9crGcnh33YT8HiBZlq260dcPEWbH9vRevLprskGA3k6+H7Ug/4PCc7Q9GUH/4gYE4T1c
 DB8F0OECaqCsGllbRJq1Wbi1NiUg877Bf29gPBgkcZqyzWZ5Ww88TzwjE/w4br13NezZ
 op9hWC1mSnrlBLb7Vt+ITZyF3WxCm5B5UZVh2h8CXv8Ir8pZkejn4YRbbyd6i5gpkp4S
 9LZ5GTwOkXjIJaWjAk4a0JR4TLQiE5UZFFVc3XxfhrkiD4NOK95QsQAsNl9CFyxYAint
 g1hQ==
X-Gm-Message-State: AOAM532cwKYnh0vLXTFabN2Nj8woaBcqDDChrjYvy450DG13ZUAAZ9wl
 eQGaK09dqzx3HQ70E1elYTg=
X-Google-Smtp-Source: ABdhPJyMLdF78dTzsR3aMr2JFmPBHAVM6pfQ4cZXRuCnk2nN9vfsDlg5NOECIMknwDtpoTpN83YdPg==
X-Received: by 2002:a63:4003:: with SMTP id n3mr11399906pga.413.1633363328192; 
 Mon, 04 Oct 2021 09:02:08 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (115-64-153-41.tpgi.com.au. [115.64.153.41])
 by smtp.gmail.com with ESMTPSA id 130sm15557223pfz.77.2021.10.04.09.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 09:02:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 28/52] KVM: PPC: Book3S HV P9: Move vcpu register
 save/restore into functions
Date: Tue,  5 Oct 2021 02:00:25 +1000
Message-Id: <20211004160049.1338837-29-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20211004160049.1338837-1-npiggin@gmail.com>
References: <20211004160049.1338837-1-npiggin@gmail.com>
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

This should be no functional difference but makes the caller easier
to read.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 65 +++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index e817159cd53f..8d721baf8c6b 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4095,6 +4095,44 @@ static void store_spr_state(struct kvm_vcpu *vcpu)
 	vcpu->arch.ctrl = mfspr(SPRN_CTRLF);
 }
 
+/* Returns true if current MSR and/or guest MSR may have changed */
+static bool load_vcpu_state(struct kvm_vcpu *vcpu,
+			   struct p9_host_os_sprs *host_os_sprs)
+{
+	bool ret = false;
+
+	if (cpu_has_feature(CPU_FTR_TM) ||
+	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST)) {
+		kvmppc_restore_tm_hv(vcpu, vcpu->arch.shregs.msr, true);
+		ret = true;
+	}
+
+	load_spr_state(vcpu, host_os_sprs);
+
+	load_fp_state(&vcpu->arch.fp);
+#ifdef CONFIG_ALTIVEC
+	load_vr_state(&vcpu->arch.vr);
+#endif
+	mtspr(SPRN_VRSAVE, vcpu->arch.vrsave);
+
+	return ret;
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
 	host_os_sprs->dscr = mfspr(SPRN_DSCR);
@@ -4203,19 +4241,8 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	vcpu_vpa_increment_dispatch(vcpu);
 
-	if (cpu_has_feature(CPU_FTR_TM) ||
-	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST)) {
-		kvmppc_restore_tm_hv(vcpu, vcpu->arch.shregs.msr, true);
-		msr = mfmsr(); /* TM restore can update msr */
-	}
-
-	load_spr_state(vcpu, &host_os_sprs);
-
-	load_fp_state(&vcpu->arch.fp);
-#ifdef CONFIG_ALTIVEC
-	load_vr_state(&vcpu->arch.vr);
-#endif
-	mtspr(SPRN_VRSAVE, vcpu->arch.vrsave);
+	if (unlikely(load_vcpu_state(vcpu, &host_os_sprs)))
+		msr = mfmsr(); /* MSR may have been updated */
 
 	switch_pmu_to_guest(vcpu, &host_os_sprs);
 
@@ -4319,17 +4346,7 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 
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

