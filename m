Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8067AC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:12:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC024217F5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYtXsf4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC024217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WJvq5YNXzDqRc
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 20:12:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uYtXsf4K"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WJXS4F0dzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 19:55:36 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id w7so17208068pgp.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 00:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jpcu1UDIzC/kZYsb/gD7gMQHyU/ryGJIi1afoCM5WAo=;
 b=uYtXsf4KIDh9LezuYtZ7zSYxTE+/XshKGvpm0xrDg3LRur0+tzRgdIreLklPxEYVIe
 PecWg6ZXtTLu08gU2tz3BPlYcDb7BHisnyzcvGV44YmgI2UVh0+hcc9JNnr3m3Iycc/0
 PgAwxujtUIe+QPtpRx+M5VdEq8fXlXGeqkaUTr9810fDzMNow8Gtxx64SSQ4l+yTgGV0
 sJctkDYrAF1DYO2wZ8o4l/KtIr0vFeUCP1/s4XPtdIWCF8k7RgBUsUlvvgrhaVBdJA68
 6BOnYnxN2EDB29YpMebA227bqbaCBL66cIlthj/Wqqq1zUZ0dibvkmdSV3Kzcl1Aouyq
 qlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jpcu1UDIzC/kZYsb/gD7gMQHyU/ryGJIi1afoCM5WAo=;
 b=Rq7P7SMXEFreANbVm+eRIIC3B66zFHVh/uta1PsVZwzjOiWk2eIox6F5gD4E+KXQ0S
 pUz3TStxvCnQgjvWsfBBzL/3Bh157UB+Bkn+sVQEyyquRMMzWEE4g8eAkOZEzCBI4Ca4
 8us4uY8v+rX8SY3lUcz31uG8WQ3hjStzis6d5/E0Ht8J9nk/fYxV5EtUenrCJpu7jh4n
 eDue7989zQ6Y6/HmWvWaSewiH4l6g8QHbhTIg6T7dsspsUVyXC8Zut4ViBNUxOj+c5z6
 uzeVutipgczW+g0n22JU5hIjbdqdVZ+a090hinHNGgnIuBnoYcGJbb8bBtO5wUcoR5EG
 4Pxw==
X-Gm-Message-State: AJcUukeDz4qKhwgeGjsh+ZhFP/YLqW96t4bNNmnRHI4+C6Ef9vLzYbft
 GLWX8w7W+uNfZGO5ANmw+VY=
X-Google-Smtp-Source: ALg8bN6ahrlL+oFKWxOoz2sJm1EjP7AL3RCAAXyAPt/DmDTu1SnMvuyb7+QWMxqcv2be9BRNLP48DA==
X-Received: by 2002:a65:5286:: with SMTP id y6mr19921670pgp.439.1546592134904; 
 Fri, 04 Jan 2019 00:55:34 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.55.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:55:34 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 10/11] KVM: Add flush parameter for kvm_age_hva()
Date: Fri,  4 Jan 2019 16:54:04 +0800
Message-Id: <20190104085405.40356-11-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
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
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, catalin.marinas@arm.com,
 will.deacon@arm.com, christoffer.dall@arm.com, hpa@zytor.com,
 kys@microsoft.com, kvmarm@lists.cs.columbia.edu, x86@kernel.org,
 linux@armlinux.org.uk, michael.h.kelley@microsoft.com, mingo@redhat.com,
 jhogan@kernel.org, linux-mips@vger.kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to add flush parameter for kvm_aga_hva() and inside code
can check whether tlb flush is necessary when associated sptes are changed.
The platform may just flush affected address tlbs instead of entire
table's.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/arm/include/asm/kvm_host.h     | 3 ++-
 arch/arm64/include/asm/kvm_host.h   | 3 ++-
 arch/mips/include/asm/kvm_host.h    | 3 ++-
 arch/mips/kvm/mmu.c                 | 3 ++-
 arch/powerpc/include/asm/kvm_host.h | 3 ++-
 arch/powerpc/kvm/book3s.c           | 3 ++-
 arch/powerpc/kvm/e500_mmu_host.c    | 3 ++-
 arch/x86/include/asm/kvm_host.h     | 3 ++-
 arch/x86/kvm/mmu.c                  | 5 +++--
 virt/kvm/arm/mmu.c                  | 3 ++-
 virt/kvm/kvm_main.c                 | 4 ++--
 11 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 4f3400a74a17..7d7f9ff27500 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -229,7 +229,8 @@ int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
 struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 063886be25ad..6f4539e13a26 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -361,7 +361,8 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
 struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 71c3f21d80d5..ae1b079ad740 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -934,7 +934,8 @@ enum kvm_mips_fault_result kvm_trap_emul_gva_fault(struct kvm_vcpu *vcpu,
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
 /* Emulation */
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index f36ccb2d43ec..b69baf01dbac 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -582,7 +582,8 @@ static int kvm_test_age_hva_handler(struct kvm *kvm, gfn_t gfn, gfn_t gfn_end,
 	return pte_young(*gpa_pte);
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush)
 {
 	return handle_hva_to_gpa(kvm, start, end, kvm_age_hva_handler, NULL);
 }
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 0f98f00da2ea..d160e6b8ccfb 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -70,7 +70,8 @@
 
 extern int kvm_unmap_hva_range(struct kvm *kvm,
 			       unsigned long start, unsigned long end);
-extern int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+extern int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		       bool flush);
 extern int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 extern int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index bd1a677dd9e4..430a8b81ef81 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -841,7 +841,8 @@ int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
 	return kvm->arch.kvm_ops->unmap_hva_range(kvm, start, end);
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush)
 {
 	return kvm->arch.kvm_ops->age_hva(kvm, start, end);
 }
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index c3f312b2bcb3..e2f6c23ec39a 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -745,7 +745,8 @@ int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
 	return 0;
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush)
 {
 	/* XXX could be more clever ;) */
 	return 0;
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 22dbaa8fba32..4f3ff9d5b631 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1518,7 +1518,8 @@ asmlinkage void kvm_spurious_fault(void);
 
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end);
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 30ed7a79335b..a5728f51bf7d 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1995,9 +1995,10 @@ static void rmap_recycle(struct kvm_vcpu *vcpu, u64 *spte, gfn_t gfn)
 			KVM_PAGES_PER_HPAGE(sp->role.level));
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush)
 {
-	return kvm_handle_hva_range(kvm, start, end, 0, kvm_age_rmapp);
+	return kvm_handle_hva_range(kvm, start, end, flush, kvm_age_rmapp);
 }
 
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 232007ff3208..bbea7cfd6909 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -2110,7 +2110,8 @@ static int kvm_test_age_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *
 		return pte_young(*pte);
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush)
 {
 	if (!kvm->arch.pgd)
 		return 0;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index bcbe059d98be..afec5787fc1d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -432,7 +432,7 @@ static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
 	idx = srcu_read_lock(&kvm->srcu);
 	spin_lock(&kvm->mmu_lock);
 
-	young = kvm_age_hva(kvm, start, end);
+	young = kvm_age_hva(kvm, start, end, true);
 	if (young)
 		kvm_flush_remote_tlbs(kvm);
 
@@ -465,7 +465,7 @@ static int kvm_mmu_notifier_clear_young(struct mmu_notifier *mn,
 	 * cadence. If we find this inaccurate, we might come up with a
 	 * more sophisticated heuristic later.
 	 */
-	young = kvm_age_hva(kvm, start, end);
+	young = kvm_age_hva(kvm, start, end, false);
 	spin_unlock(&kvm->mmu_lock);
 	srcu_read_unlock(&kvm->srcu, idx);
 
-- 
2.14.4

