Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882CF606A32C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kLcd2IrO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYtq6TQdz3bh6;
	Sat, 31 Oct 2026 08:21:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1046"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395283;
	cv=none; b=eZ5s/smIWfUiSASIlhxSRtLrpjdvFWe9Pv9jj1cXyWhB87h98Ns2qAatTlgq4EGQiLRaNsSJgTocmPoFodrHPYNIWQsv0RIL5asT/c3XU8uzYkwr9x15jFDPekTVVJqr8v7Z6wc5beAXpurA9HBfrPNznmNtmpebVybQ8mjkHBa/BVtxvM5hqd65lfTjvVMWjL6tzb119Rc/wSsBLuMyRX7+ePGr/HbupSM1HIcuosDXSYcR5JMWd27rMgzP/d03qfHAXrsNm2gkBUkeQwjfM3+W5/ehpxCDrgMHBHMZvOXi0T3CHsw61nvK71lt04Bl4dZZYuEgMFjkqTs3ECXgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395283; c=relaxed/relaxed;
	bh=pl4Fq3eHWvdeXHKYf+p4Vk2TxeQCuXbhcaSxF66rRXw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kUV3/9gM52Ss/yPhvzj+nTSysIl+7dgrTxE+f3CYlCKKZewcP2CbFL5MP+ATEWyQPTML7UQw6jc/uJKMClQ3C8pqb1BuxocHCO6+R9ZLyYFpZ+ym0eN6ANbqcOFBNQaK8etuub33d0ucdFysweBoeUgmIH7CZCtxEPkanjXpQLGAE0dhbetPY0cOv6nM/rn2eDkPNJ6tO/BPBHa9XqvdlpEdRJKjC0au5f7s2SOO6iS16IxDu2wTRLedMSN+FxgleCah2A865SXo87r/LVJApt4VdG8BOhqEAMd8PCs3STJ2EaYpZytCbINtr/qaRUPYAdsMAxrOETTxJ6jwifVZSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kLcd2IrO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1046; helo=mail-pj1-x1046.google.com; envelope-from=3uarlagykdfch3zc815dd5a3.1dba7cjmee1-23ka7hih.doaz0h.dg5@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kLcd2IrO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1046; helo=mail-pj1-x1046.google.com; envelope-from=3uarlagykdfch3zc815dd5a3.1dba7cjmee1-23ka7hih.doaz0h.dg5@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1046.google.com (mail-pj1-x1046.google.com [IPv6:2607:f8b0:4864:20::1046])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYtp6Zqpz3bfP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:22 +1100 (AEDT)
Received: by mail-pj1-x1046.google.com with SMTP id 98e67ed59e1d1-3ad840053c7so968962a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395281; x=1794000081; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pl4Fq3eHWvdeXHKYf+p4Vk2TxeQCuXbhcaSxF66rRXw=;
        b=kLcd2IrOcmkthdYlrfVQ+Y2FjDOEarov/8RBwuSlYblVHYsXEmpQALacYSL+Y6yFoJ
         8zVwtleghiOyfqclMWv8JCX3GIZDz/RflQJCYO5Iy5Q4voDggKWx+6P61Fd7O78W/sfs
         8zU3q2ejQQ1bHcJsOu6oRfozU8Xu/c0h6aMSefRMYB7gaz6LFx83OyMtfOdYHFeYcBZn
         mf4QNqCG+FLNXdTdLbN13v3F9eU0dVO7h3u445/oZw3BBZkbTFmkAAGrSbEaaySsAUr1
         awXQTzmtclj1mZd8JbGWv3MFVx0q3M0v5eaiArxZwssy2e9wLBvFZh9TH5/rSgI+7ebU
         OIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395281; x=1794000081;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pl4Fq3eHWvdeXHKYf+p4Vk2TxeQCuXbhcaSxF66rRXw=;
        b=1DnFruSU1+Ir4mxMl8ZI7DWrGkb7UaNjtPPv3xClvjvNWfsDpD3PErUsDEXim0vvh8
         7nggNoDdS+dpDeyzJwqGxv6zx1W96B56mP98wcwtp7Ld3OjF5FHVak08gf7fN8dTgP2G
         qLCJ5DCasdOWIZMvRVI4IWIAoT8mmWqDytpg8e2/5TByM+noNsymN2I3NGega3CvM4cZ
         Dq/oyy9TE1hqMKuoOHD0AvpWWwa1d9E4OHk1TaYiDYkOmMBhR6GdxilEVWId3CBU2whV
         MLVCFVxE88oNDBaP3m0AqY0pX8cLQH8sgOq7rNvmNkfX2JzNFhiJEWCmGFit9sj+pqh+
         HMIA==
X-Forwarded-Encrypted: i=1; AKwUvBwFKJH0gp11j5UdDh7DmijLctPeJyNHw4ZVTq32LL3yyMCiAWYL3MF9qhik5i2c2W/5dKa5nZ+nWnGqO9s=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKrdv0dG//k0icn1jVhMA+TjQDwcUh0rje7pvccRWyNpkPexYqp
	PS+zFA/hVHoJtmdvB8OS+Iti8U/Vw/jldIXiEy1/FyDOx+G+m170gGnLN3IZ+uLUErL/dHICRAT
	7/HW+Lg==
X-Received: from pjzc20.prod.google.com ([2002:a17:90a:e114:b0:3a5:f1d:43a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3142:b0:3ac:403d:6239
 with SMTP id 98e67ed59e1d1-3ae897ee66dmr2448540a91.43.1793395280725; Fri, 30
 Oct 2026 14:21:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:54 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-7-seanjc@google.com>
Subject: [PATCH v4 06/23] KVM: x86: Unmap VMAs for KVM-internal memslots when
 the memslot is freed
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Unmap KVM-created VMAs for KVM-internal memslots when the associated
memslot is freed instead of unmapping via x86's internal API.  This will
allow deleting/freeing all memslots before kvm_arch_destroy_vm() without
leaking VMAs, and in general is a net positive as it makes it far less
likely that KVM will leak VMAs, e.g. in the unlikely scenario some other
flow deletes KVM-internal memslots without going through
__x86_set_memory_region().

Free the VMA only when deleting the memslot from the "last" address space,
where "last" is the highest numbered address space.  KVM currently uses a
single VMA for both non-SMM and SMM memslots, and deletes the memslots in
ascending numerical order, i.e. deletes the SMM memslot last, if SMM is
enabled.  Freeing the VMA on the non-SMM memslot would technically regress
inhibiting the APIC access page, which is the only case where KVM deletes
an internal memslot on a live VM, as accessing the SMM memslot after the
VMA is removed would result in KVM_RUN failing with -EFAULT.

Add a TODO to call out that unmapping only the "last" memslot is a hack,
along with a hint/suggestion for how the hack can be removed.

CC: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cb8b60da5b11..489631686ba6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10018,7 +10018,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
  * @size > 0 to install a new slot, while @size == 0 to uninstall a
  * slot.  The return code can be one of the following:
  *
- *   HVA:           on success (uninstall will return a bogus HVA)
+ *   HVA:           on success (uninstall will return a NULL HVA)
  *   -errno:        on error
  *
  * The caller should always use IS_ERR() to check the return value
@@ -10031,10 +10031,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 				      u32 size)
 {
-	int i, r;
-	unsigned long hva, old_npages;
 	struct kvm_memslots *slots = kvm_memslots(kvm);
 	struct kvm_memory_slot *slot;
+	unsigned long hva;
+	int i, r;
 
 	lockdep_assert_held(&kvm->slots_lock);
 
@@ -10058,8 +10058,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 		if (!slot)
 			return NULL;
 
-		old_npages = slot->npages;
-		hva = slot->userspace_addr;
+		hva = 0;
 	}
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
@@ -10075,9 +10074,6 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 			return ERR_PTR_USR(r);
 	}
 
-	if (!size)
-		vm_munmap(hva, old_npages * PAGE_SIZE);
-
 	return (void __user *)hva;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__x86_set_memory_region);
@@ -10106,20 +10102,6 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
 
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
-	if (current->mm == kvm->mm) {
-		/*
-		 * Free memory regions allocated on behalf of userspace,
-		 * unless the memory map has changed due to process exit
-		 * or fd copying.
-		 */
-		mutex_lock(&kvm->slots_lock);
-		__x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
-					0, 0);
-		__x86_set_memory_region(kvm, IDENTITY_PAGETABLE_PRIVATE_MEMSLOT,
-					0, 0);
-		__x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, 0, 0);
-		mutex_unlock(&kvm->slots_lock);
-	}
 	if (kvm->arch.created_mediated_pmu)
 		perf_release_mediated_pmu();
 	kvm_destroy_vcpus(kvm);
@@ -10159,6 +10141,19 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 	}
 
 	kvm_page_track_free_memslot(slot);
+
+	/*
+	 * Unmap VMAs allocated on behalf of userspace for internal memslots,
+	 * unless the memory map has changed due to process exit or fd copying.
+	 * Leak the mapping on failure, e.g. if the task is killed.  Worst case
+	 * scenario, the page(s) will be reclaimed when the process exits.
+	 *
+	 * TODO: Allocate VMAs for each address space and drop the check on the
+	 *       as_id, which depends on freeing memslots from 0=>N-1.
+	 */
+	if (current->mm == kvm->mm && slot->id >= KVM_USER_MEM_SLOTS &&
+	    slot->as_id == (kvm_arch_nr_memslot_as_ids(kvm) - 1))
+		vm_munmap(slot->userspace_addr, slot->npages * PAGE_SIZE);
 }
 
 int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages)
-- 
2.56.0.385.gac671c819a-goog


