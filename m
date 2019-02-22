Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EA8C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:20:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC1B207E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMYxgFb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC1B207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445ZmR3cS9zDqgM
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 02:20:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OMYxgFb/"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445ZTM5DdjzDqVm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 02:07:51 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id u9so1252931pgo.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 07:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7Go7voUR7PP9IbtPtHYJZJ9KLXpiKBFH7bP0tDDsjB4=;
 b=OMYxgFb/TH+McvC6/yX42s2bOKqIFuH7liGSdQk8dA6R6rivWAFzdcTvJKKIW7G4nu
 lXYzdbjHlZnvOqn1M4ZA9z730vCqf2E1ybCCqsj65itbbqBKwDX6hpuZHXoy0miurviB
 kxP6/HeP2wKEXEVp3a+Ug85E1C5++G9MDrdRQLX225uRpiuqsgIHz8qEUnfGUhbFyBst
 nrdGgq8aT26OjCzFjuLr/3y3vhcfqcb4viY/i5FAVoqBRY4uuiJ5fu4uyigEKBWrsW/O
 YyIgfPonVe/xzXniC19S3KWG4/oNp0oM5MXd41ZVqSHpzwaZL+UjWa7IuouoIhAcXe+t
 2ySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7Go7voUR7PP9IbtPtHYJZJ9KLXpiKBFH7bP0tDDsjB4=;
 b=BF2d8qxLUD1VRte8jITWCcdeAVtA2cEDdFjvD18DDPjWVjvmryb6NfLOxYXlzYHmyH
 wIj/QoHApb3W9rQXnIq45Ha9cNCoBe+EbyXikWOq0ItEqd0TXZvYRVs/Sa5dRseJrcUR
 sCc9KtlIGTaUx99AtLPESrinCzxgZ9id9qYGp5+yOltPHckLRz9nDjkX5Z6ViOHgzZRn
 ayYSZaKsKZsHiTEIhHHrFeWiK/T2RuMzAYV0s8gX402cdWDKPGbP/YPHLf34mfFz5cRi
 FO9AAX7DhMM3DTRqslheoMXlR+kORJrXG7MSUGMvx/qfKzo08xu6rAQdeB534JSUQKO5
 ou/w==
X-Gm-Message-State: AHQUAuYhzTarBSk+b8wevbw+uxQRO3q5F0SmaeK8DBuhQjFEPond7nfc
 AhZzLBiu9zjKGaCw4EczOk0=
X-Google-Smtp-Source: AHgI3IZHlSqh4FBsJPrlCgkevIFZismIyLuu2+1WWH0cRzRKJdFO+uEViGuOXjTF2NY5mtMA0QRKFQ==
X-Received: by 2002:a63:1260:: with SMTP id 32mr4435319pgs.278.1550848070153; 
 Fri, 22 Feb 2019 07:07:50 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 07:07:49 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V3 7/10] KVM: Use tlb range flush in the
 kvm_vm_ioctl_get/clear_dirty_log()
Date: Fri, 22 Feb 2019 23:06:34 +0800
Message-Id: <20190222150637.2337-8-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
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

This patch is to use tlb range flush to flush memslot's in the
kvm_vm_ioctl_get/clear_dirty_log() instead of flushing tlbs
of entire ept page table when range flush is available.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c |  8 +-------
 arch/x86/kvm/mmu.h |  7 +++++++
 arch/x86/kvm/x86.c | 16 ++++++++++++----
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 60b1771e400e..e9a727aad603 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -266,12 +266,6 @@ static void mmu_spte_set(u64 *sptep, u64 spte);
 static union kvm_mmu_page_role
 kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
 
-
-static inline bool kvm_available_flush_tlb_with_range(void)
-{
-	return kvm_x86_ops->tlb_remote_flush_with_range;
-}
-
 static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
 		struct kvm_tlb_range *range)
 {
@@ -284,7 +278,7 @@ static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
 		kvm_flush_remote_tlbs(kvm);
 }
 
-static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
+void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 		u64 start_gfn, u64 pages)
 {
 	struct kvm_tlb_range range;
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index bbdc60f2fae8..5e0d9418b912 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -63,6 +63,13 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
 int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 				u64 fault_address, char *insn, int insn_len);
+void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
+				u64 start_gfn, u64 pages);
+
+static inline bool kvm_available_flush_tlb_with_range(void)
+{
+	return kvm_x86_ops->tlb_remote_flush_with_range;
+}
 
 static inline unsigned int kvm_mmu_available_pages(struct kvm *kvm)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 40d8272bee96..35738a7256f4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4448,9 +4448,13 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 	 * kvm_mmu_slot_remove_write_access().
 	 */
 	lockdep_assert_held(&kvm->slots_lock);
-	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+	if (flush) {
+		struct kvm_memory_slot *memslot = kvm_get_memslot(kvm,
+				log->slot);
 
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+				memslot->npages);
+	}
 	mutex_unlock(&kvm->slots_lock);
 	return r;
 }
@@ -4475,9 +4479,13 @@ int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm, struct kvm_clear_dirty_log *lo
 	 * kvm_mmu_slot_remove_write_access().
 	 */
 	lockdep_assert_held(&kvm->slots_lock);
-	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+	if (flush) {
+		struct kvm_memory_slot *memslot = kvm_get_memslot(kvm,
+				log->slot);
 
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+				memslot->npages);
+	}
 	mutex_unlock(&kvm->slots_lock);
 	return r;
 }
-- 
2.14.4

