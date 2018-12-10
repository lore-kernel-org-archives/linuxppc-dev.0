Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EB6C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 04:06:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DCE20821
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 04:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcl4EvUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DCE20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CqJX2705zDqh3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 15:06:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dcl4EvUp";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="dcl4EvUp"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Cq7f2qflzDqcV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 14:58:54 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id k8so4572407pls.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Dec 2018 19:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LvmJuwwziss2COckjTxUbK8p0ozKauVVNTpVJ1JHZwE=;
 b=dcl4EvUpjyM41HQWEnO6Io09ugNK29E2EaD4PciPQZ89NpiBLMGkRHpwKrYEgbYfxx
 dBhVadhfJjw+pN2Ioo4Xjz51VxoonTWggePt8f5mSzKvjEP5YsZwCHXnerssu2Un4iaK
 ahNjOkt8v59viSYj+ptI1Gxd8o9sdQXrTAKuO7wm8stFlTH9Hx5Ul87iXlVrXNmpI6+C
 GHNQNShzLBht1Rp86fLqi6fbyMHHKecnOWYOtpSH+ioq3sSXFTdlzIcVsi++Rs+2iIOZ
 M4QubfpDnKiEWIWro1laRazZtkLXp08BODxaIVeQ+KtPWHK1kCp/Y1oMKF/8ATYyNSBE
 dPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LvmJuwwziss2COckjTxUbK8p0ozKauVVNTpVJ1JHZwE=;
 b=QfBOLjmQjTFxPIWzs0ZdCkVTg0TpD5FLJCMK4AMMwf+uxWGPdlE8irQ/RGY0uAY/ZM
 wM6ECzRF2KIH7IQPwcPZiVT1c3QlMQ50w7GiElAca5L3SPe6mHypGI5wobZUwtN2t7Zb
 ZgfUvwC+I/7elp/5dkI3Kl/sEL8Nvd8NOVCvZdvLJYfbE2oD+VCSzYlaDJ06qz2ihb3P
 uYZmtXpeVlVaBeATGKvaskCTD2nVhlmA5/8j9SngSKoTgxHcjdGt4oPmgCq1/IkOW71J
 jkDRi70rBrF1LbHmGP18OuoBYrQ+ommye8553z6AcHOxfDdziMkeBFO16N2udkWPKclJ
 Fhwg==
X-Gm-Message-State: AA+aEWYmJTnpCkoq4mlkiAIZyNF3KKBXpjn2Z+wFtnx2P4a0a0wGz/br
 mOzx6PqytCkGUvFVXtT8oXWQ2rP+
X-Google-Smtp-Source: AFSGD/Xdxp1OMyKe62V1a73tnIdCC7PGn93vKHFgudjjfYTy6a8LV+AmgYT34uDCxC7VVwYejzXbiA==
X-Received: by 2002:a17:902:bc43:: with SMTP id
 t3mr10016054plz.124.1544414332704; 
 Sun, 09 Dec 2018 19:58:52 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id f6sm14291899pfg.188.2018.12.09.19.58.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Dec 2018 19:58:51 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH V2 2/8] KVM: PPC: Book3S HV: Add function kvmhv_vcpu_is_radix()
Date: Mon, 10 Dec 2018 14:58:19 +1100
Message-Id: <20181210035825.29404-3-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181210035825.29404-1-sjitindarsingh@gmail.com>
References: <20181210035825.29404-1-sjitindarsingh@gmail.com>
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 sjitindarsingh@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There exists a function kvm_is_radix() which is used to determine if a
kvm instance is using the radix mmu. However this only applies to the
first level (L1) guest. Add a function kvmhv_vcpu_is_radix() which can
be used to determine if the current execution context of the vcpu is
radix, accounting for if the vcpu is running a nested guest.

Currently all nested guests must be radix but this may change in the
future.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s_64.h | 13 +++++++++++++
 arch/powerpc/kvm/book3s_hv_nested.c      |  1 +
 2 files changed, 14 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 6d298145d564..7a9e472f2872 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -55,6 +55,7 @@ struct kvm_nested_guest {
 	cpumask_t need_tlb_flush;
 	cpumask_t cpu_in_guest;
 	short prev_cpu[NR_CPUS];
+	u8 radix;			/* is this nested guest radix */
 };
 
 /*
@@ -150,6 +151,18 @@ static inline bool kvm_is_radix(struct kvm *kvm)
 	return kvm->arch.radix;
 }
 
+static inline bool kvmhv_vcpu_is_radix(struct kvm_vcpu *vcpu)
+{
+	bool radix;
+
+	if (vcpu->arch.nested)
+		radix = vcpu->arch.nested->radix;
+	else
+		radix = kvm_is_radix(vcpu->kvm);
+
+	return radix;
+}
+
 #define KVM_DEFAULT_HPT_ORDER	24	/* 16MB HPT by default */
 #endif
 
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 401d2ecbebc5..4fca462e54c4 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -480,6 +480,7 @@ struct kvm_nested_guest *kvmhv_alloc_nested(struct kvm *kvm, unsigned int lpid)
 	if (shadow_lpid < 0)
 		goto out_free2;
 	gp->shadow_lpid = shadow_lpid;
+	gp->radix = 1;
 
 	memset(gp->prev_cpu, -1, sizeof(gp->prev_cpu));
 
-- 
2.13.6

