Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D5FC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 13:48:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BED6208E7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 13:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiNGHQQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BED6208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439cP91y17zDqly
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 00:47:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IiNGHQQm";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="IiNGHQQm"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439bqf5rTyzDr95
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 00:22:22 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id u18so167022plq.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 05:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5oDjfSo5BSNgEbwUj6RHvARKoGuVRkTd5H1UXf7m+VQ=;
 b=IiNGHQQmX9rZ+CIvg+3tL1pA98zHSSj5B/2PIh8fCEoku0pxcq/yiU4YV0A7gYAIcD
 NggUO7zVnaojHyOlzoBuzNvdcI23hGHk2NKMbm2sqxZ41NuqETSPYxm0XucL3mOO9qVU
 YaA9Py3f1oh9daPBks0NCPaKn+a+tnk+6fIrJLUkUl0kuvSKP/1/jgqJ8IfLP+Wb30D0
 enFEk6VI1ZymOHq50L1c1fDcyAWSx7jNFd/0gwKz0Y9FXAtOSQPuko43Ju6Z595TgL9y
 llrJu13cEJ/yX4TJOuIDfySVc6bUSA56x1fRwEpody4FumuWh/jn4zKhAzySve5A3hg/
 dFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5oDjfSo5BSNgEbwUj6RHvARKoGuVRkTd5H1UXf7m+VQ=;
 b=iuAot90jic3mvINrDACywqkRGfE3HIcwW9hAAskt/iSP5N7MXf8EwMgNIAAbiV5EZl
 HyNKyQkSOeYET+i6aLW4sQvS/IhJjLQ1hi/fe0CJSY9b+e7aPBLHAVe/fHdxljqevJ5J
 LUXAXyJ/PAeK/DuXarfjdrnwEMpTbqYkGxQfBhHVquKso/M8zlucGYpG1beG/774u5ZO
 7ss2xaA5vPcc6047b7hTBISyzZ3bKmhnxBJDxpvZNrKekj1SLdM64/uGv+9wC7XzcMrx
 fdA2st7hOIm2PigqUMELMHPnd9nIBtqaPElRUqs2ZBQqHufIMEQqi5yUNFtxzcRQuAwg
 Bq0g==
X-Gm-Message-State: AA+aEWYzxM3We4zW1w8kfQtSBjj0O7P1IrIKtDD8vtTUeH5hLHziJrcJ
 S3r3nYp0sb30CY+TyVV8Ssw=
X-Google-Smtp-Source: AFSGD/Wc5xHfM79IbtAdwAoHmOCxX/41mS0T68DSLS9NZG44oZihFKB4YbVpuejvYg8wGdvzEUdisw==
X-Received: by 2002:a17:902:aa82:: with SMTP id
 d2mr19658320plr.153.1544102541169; 
 Thu, 06 Dec 2018 05:22:21 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id y5sm2409246pge.49.2018.12.06.05.22.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 05:22:20 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [Resend PATCH V5 7/10] KVM: Make kvm_set_spte_hva() return int
Date: Thu,  6 Dec 2018 21:21:10 +0800
Message-Id: <20181206132113.2691-8-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
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
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
 catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@arm.com,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu, x86@kernel.org,
 linux@armlinux.org.uk, michael.h.kelley@microsoft.com, mingo@redhat.com,
 jhogan@kernel.org, Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

The patch is to make kvm_set_spte_hva() return int and caller can
check return value to determine flush tlb or not.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/arm/include/asm/kvm_host.h     | 2 +-
 arch/arm64/include/asm/kvm_host.h   | 2 +-
 arch/mips/include/asm/kvm_host.h    | 2 +-
 arch/mips/kvm/mmu.c                 | 3 ++-
 arch/powerpc/include/asm/kvm_host.h | 2 +-
 arch/powerpc/kvm/book3s.c           | 3 ++-
 arch/powerpc/kvm/e500_mmu_host.c    | 3 ++-
 arch/x86/include/asm/kvm_host.h     | 2 +-
 arch/x86/kvm/mmu.c                  | 3 ++-
 virt/kvm/arm/mmu.c                  | 6 ++++--
 10 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 5ca5d9af0c26..fb62b500e590 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -225,7 +225,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 52fbc823ff8c..b3df7b38ba7d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -360,7 +360,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 2c1c53d12179..71c3f21d80d5 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -933,7 +933,7 @@ enum kvm_mips_fault_result kvm_trap_emul_gva_fault(struct kvm_vcpu *vcpu,
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index d8dcdb350405..97e538a8c1be 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -551,7 +551,7 @@ static int kvm_set_spte_handler(struct kvm *kvm, gfn_t gfn, gfn_t gfn_end,
 	       (pte_dirty(old_pte) && !pte_dirty(hva_pte));
 }
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	unsigned long end = hva + PAGE_SIZE;
 	int ret;
@@ -559,6 +559,7 @@ void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 	ret = handle_hva_to_gpa(kvm, hva, end, &kvm_set_spte_handler, &pte);
 	if (ret)
 		kvm_mips_callbacks->flush_shadow_all(kvm);
+	return 0;
 }
 
 static int kvm_age_hva_handler(struct kvm *kvm, gfn_t gfn, gfn_t gfn_end,
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index fac6f631ed29..ab23379c53a9 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -72,7 +72,7 @@ extern int kvm_unmap_hva_range(struct kvm *kvm,
 			       unsigned long start, unsigned long end);
 extern int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 extern int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
-extern void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+extern int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 
 #define HPTEG_CACHE_NUM			(1 << 15)
 #define HPTEG_HASH_BITS_PTE		13
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index fd9893bc7aa1..437613bb609a 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -850,9 +850,10 @@ int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
 	return kvm->arch.kvm_ops->test_age_hva(kvm, hva);
 }
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	kvm->arch.kvm_ops->set_spte_hva(kvm, hva, pte);
+	return 0;
 }
 
 void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 8f2985e46f6f..c3f312b2bcb3 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -757,10 +757,11 @@ int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
 	return 0;
 }
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	/* The page will get remapped properly on its next fault */
 	kvm_unmap_hva(kvm, hva);
+	return 0;
 }
 
 /*****************************************/
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fc7513ecfc13..d3bdeda92e89 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1510,7 +1510,7 @@ asmlinkage void kvm_spurious_fault(void);
 int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
 int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
 int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 1cd3c316a7e6..dfef49f1e7a6 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1913,9 +1913,10 @@ int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
 	return kvm_handle_hva_range(kvm, start, end, 0, kvm_unmap_rmapp);
 }
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	kvm_handle_hva(kvm, hva, (unsigned long)&pte, kvm_set_pte_rmapp);
+	return 0;
 }
 
 static int kvm_age_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 5eca48bdb1a6..b8b20c033fcf 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1849,14 +1849,14 @@ static int kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *data
 }
 
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	unsigned long end = hva + PAGE_SIZE;
 	kvm_pfn_t pfn = pte_pfn(pte);
 	pte_t stage2_pte;
 
 	if (!kvm->arch.pgd)
-		return;
+		return 0;
 
 	trace_kvm_set_spte_hva(hva);
 
@@ -1867,6 +1867,8 @@ void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 	clean_dcache_guest_page(pfn, PAGE_SIZE);
 	stage2_pte = pfn_pte(pfn, PAGE_S2);
 	handle_hva_to_gpa(kvm, hva, end, &kvm_set_spte_handler, &stage2_pte);
+
+	return 0;
 }
 
 static int kvm_age_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *data)
-- 
2.14.4

