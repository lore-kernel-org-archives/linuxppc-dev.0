Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46880ECDE47
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 15:02:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 934D12081D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 15:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roMY4Dx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934D12081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rRMW4Fc4zF3RM
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 02:01:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="roMY4Dx7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="roMY4Dx7"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rR2q6z7BzF3Q1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 01:47:31 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id g59-v6so9637125plb.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 06:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AJsJ7JNmnPIEakaYXYUBPRKd8SXsvIU4O5T3LsLe+k0=;
 b=roMY4Dx71dXPBW6iH0aoehawTSPahflPRdz+q5CZz27ABpLZ0INEdCHKvu8y1e6v0X
 n+JPeM36ZS97lKUY+1OoAKPs1Eez5EC2xh+kfFtgSTKklcsEp154QWdMNMfk85miAruO
 PKVC6NfROhs1MNSkm+rhiXwtBsv9zdGVYFiNHBWIhqfzCQA1nceLU9iVenUZGZFHJzns
 kzClBh3WVFUihCe5ey5syZSqFsXPG/QpvgNi9qTQ/EJm/Vq2F0zR6uutw1mHsYwLWrIt
 k1iSeJ0/sqyE/00ek7FiFpWVglq/QsVtZvdnEZUrxS7qsXBF2SofvcReay3lSwNyKpRk
 KrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AJsJ7JNmnPIEakaYXYUBPRKd8SXsvIU4O5T3LsLe+k0=;
 b=YosNlv1mQ4QdOjsIARs+tR26bTvzvCvMPVQ93uyAhycP3TxF5MR6UX2/MoQImMrBql
 O53YAaIYxA6bj73lg/+2Gimhljs26cX5HfcNYVfnJfroyxq0XMlPNpRcsxteyHCDYbvL
 hMvbziy40LUsH+pxZ3dDfxLskvnjLvdmoGQ2bn2eYXwX5otVD2QXw9IgQy0TY+UxjRSc
 vo6kg5Rv6KBLJy7Okq5lhIiBUjYKLRe50MnvMT9oOUkHxmCC6r2FiqOInhh3ULnzOnCQ
 IsIbJlGzjMeTScxIJc2kGZ4SOV8zBAoNd8YWMOYlc/tZM7bpw0jt97kUfXOR0errFl2z
 sh6g==
X-Gm-Message-State: AGRZ1gJAQPIA2jEXDFwPAr0/aq8+HPFh6mhzK4T2NjuHvOuPt6/kvLiA
 eSMYnwIOI46Sebl2rGI4OkY=
X-Google-Smtp-Source: AJdET5cI/ttuKzIfvHzh9BEgMNyypHvOyw7UODp1vtQPI3swu+s3JK4OBl5dAhf8jp+oBZy5XQKJ/Q==
X-Received: by 2002:a17:902:bc4a:: with SMTP id
 t10-v6mr4618396plz.249.1541688450388; 
 Thu, 08 Nov 2018 06:47:30 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id
 k75-v6sm11526731pfb.119.2018.11.08.06.47.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 08 Nov 2018 06:47:29 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [Resend PATCH V5 6/10] KVM: Replace old tlb flush function with new
 one to flush a specified range.
Date: Thu,  8 Nov 2018 22:46:35 +0800
Message-Id: <20181108144639.11206-6-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
References: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
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

This patch is to replace kvm_flush_remote_tlbs() with kvm_flush_
remote_tlbs_with_address() in some functions without logic change.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c         | 31 +++++++++++++++++++++----------
 arch/x86/kvm/paging_tmpl.h |  3 ++-
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index c1d383532066..af3e9e466014 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1485,8 +1485,12 @@ static bool __drop_large_spte(struct kvm *kvm, u64 *sptep)
 
 static void drop_large_spte(struct kvm_vcpu *vcpu, u64 *sptep)
 {
-	if (__drop_large_spte(vcpu->kvm, sptep))
-		kvm_flush_remote_tlbs(vcpu->kvm);
+	if (__drop_large_spte(vcpu->kvm, sptep)) {
+		struct kvm_mmu_page *sp = page_header(__pa(sptep));
+
+		kvm_flush_remote_tlbs_with_address(vcpu->kvm, sp->gfn,
+			KVM_PAGES_PER_HPAGE(sp->role.level));
+	}
 }
 
 /*
@@ -1954,7 +1958,8 @@ static void rmap_recycle(struct kvm_vcpu *vcpu, u64 *spte, gfn_t gfn)
 	rmap_head = gfn_to_rmap(vcpu->kvm, gfn, sp);
 
 	kvm_unmap_rmapp(vcpu->kvm, rmap_head, NULL, gfn, sp->role.level, 0);
-	kvm_flush_remote_tlbs(vcpu->kvm);
+	kvm_flush_remote_tlbs_with_address(vcpu->kvm, sp->gfn,
+			KVM_PAGES_PER_HPAGE(sp->role.level));
 }
 
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
@@ -2470,7 +2475,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 		account_shadowed(vcpu->kvm, sp);
 		if (level == PT_PAGE_TABLE_LEVEL &&
 		      rmap_write_protect(vcpu, gfn))
-			kvm_flush_remote_tlbs(vcpu->kvm);
+			kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn, 1);
 
 		if (level > PT_PAGE_TABLE_LEVEL && need_sync)
 			flush |= kvm_sync_pages(vcpu, gfn, &invalid_list);
@@ -2590,7 +2595,7 @@ static void validate_direct_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 			return;
 
 		drop_parent_pte(child, sptep);
-		kvm_flush_remote_tlbs(vcpu->kvm);
+		kvm_flush_remote_tlbs_with_address(vcpu->kvm, child->gfn, 1);
 	}
 }
 
@@ -3014,8 +3019,10 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep, unsigned pte_access,
 			ret = RET_PF_EMULATE;
 		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	}
+
 	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH || flush)
-		kvm_flush_remote_tlbs(vcpu->kvm);
+		kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn,
+				KVM_PAGES_PER_HPAGE(level));
 
 	if (unlikely(is_mmio_spte(*sptep)))
 		ret = RET_PF_EMULATE;
@@ -5681,7 +5688,8 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 	 * on PT_WRITABLE_MASK anymore.
 	 */
 	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+			memslot->npages);
 }
 
 static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
@@ -5751,7 +5759,8 @@ void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
 	 * dirty_bitmap.
 	 */
 	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+				memslot->npages);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_slot_leaf_clear_dirty);
 
@@ -5769,7 +5778,8 @@ void kvm_mmu_slot_largepage_remove_write_access(struct kvm *kvm,
 	lockdep_assert_held(&kvm->slots_lock);
 
 	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+				memslot->npages);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_slot_largepage_remove_write_access);
 
@@ -5786,7 +5796,8 @@ void kvm_mmu_slot_set_dirty(struct kvm *kvm,
 
 	/* see kvm_mmu_slot_leaf_clear_dirty */
 	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+				memslot->npages);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_slot_set_dirty);
 
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 7cf2185b7eb5..6bdca39829bc 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -894,7 +894,8 @@ static void FNAME(invlpg)(struct kvm_vcpu *vcpu, gva_t gva, hpa_t root_hpa)
 			pte_gpa += (sptep - sp->spt) * sizeof(pt_element_t);
 
 			if (mmu_page_zap_pte(vcpu->kvm, sp, sptep))
-				kvm_flush_remote_tlbs(vcpu->kvm);
+				kvm_flush_remote_tlbs_with_address(vcpu->kvm,
+					sp->gfn, KVM_PAGES_PER_HPAGE(sp->role.level));
 
 			if (!rmap_can_add(vcpu))
 				break;
-- 
2.14.4

