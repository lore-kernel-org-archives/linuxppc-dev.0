Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF26073154
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RaqT1EQD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDl8z6Bwcz2yqw;
	Wed, 28 Oct 2026 09:12:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1047"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793139139;
	cv=none; b=iqkQ+koKcqmhkaVRPyVGiyAjN9rMjNB4elRsnNbX5fJ1dVOys21sl2A5uWHYScZ43FJ16MVYpUqDGjNoassE9N9RZySzx1T9HBOtdHEsWd2YzD4oPZis3UkpR2qMvVF8I6bu17FlqPbqXaOSGsJBteEqK1i9929JLGhJH6YD7xHCtENMtLpBJaS92QfCdyPu+Dh4ymtMUh28dse/YdGl0IJO1psBvzM/O/EiG44zQo60KAty+KlIS5xJ1x9Tg9OAV+Q9RntTOfnhSZqw6RC4pkYrWAB4fsldDlimoTeODzPOTCWLQhdURWwUipkgc6/UaoDfbfdXA//wfuXapIYReg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793139139; c=relaxed/relaxed;
	bh=iREv2BM/TPI3Cz0K2O/45W+Zzwpa9oFsTUQAe4Z7CDw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gr3RzrK7QxLgxqp9aBhuo92jspKS4xy7KwnUSzKJ+JIKoyNwTt8h311LAKfuratyPfLl3UqPJ7itpuG+NFzOez1jfiJPCNdiIKTFnpGH5SRw1fjGVwf9VtiM+36PhWMLeELPV+J4Kwn3Yi3BL2kSvSZUzV3lO25KwnDuod42Ec7rmI5zSn5in99D2dmhlaZ1y4cz49OXPn4KHWP/yOCb9Yh5OvWV7Yc5Y+MrwwYJ2/qiqJ5wr5jdeKuiJBnJajXWITRgC6ybqX20qRj7I9RDQaf3WHEFkVUXLOG6rEv4hX+xcIzuFrWnElYCBD6cUbcXscTV0Ay8GpMz1xRNA7E1RA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RaqT1EQD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1047; helo=mail-pj1-x1047.google.com; envelope-from=3wchhagykdouzlhuqjnvvnsl.jvtspubewwj-klcspzaz.vgshiz.vyn@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RaqT1EQD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1047; helo=mail-pj1-x1047.google.com; envelope-from=3wchhagykdouzlhuqjnvvnsl.jvtspubewwj-klcspzaz.vgshiz.vyn@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1047.google.com (mail-pj1-x1047.google.com [IPv6:2607:f8b0:4864:20::1047])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDl8y5xM1z2yft
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:12:18 +1100 (AEDT)
Received: by mail-pj1-x1047.google.com with SMTP id 98e67ed59e1d1-3ad840053c7so290838a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139136; x=1793743936; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iREv2BM/TPI3Cz0K2O/45W+Zzwpa9oFsTUQAe4Z7CDw=;
        b=RaqT1EQDJZRHZiWBiAfhMGoHHAnHg8bC+xcyt8YMygFqfhQVC0oQZp3EIMSgIN9NVw
         uDbwmmPEc6yFjWB4b9QsRHO8wYEu27Wnw6+SSvAZdPnS3g6OmnEgz5qvlbA5VK8fRJT3
         4bMhGyKJiSlh3EUOWfdOjAoMTfhD/ET03BHVmrktPA0h3ay8LiLoY0IM92f+YovQb/M9
         3ut1XQf7NOwL49ssljV7k3kXK/XrRDo1Up8ar+ctJ+JBJi4Wve7EXExOA1IXrFfgyT3n
         ibJUAwCmBSG038kPL6273lyPShLoqd0CTmjCgMe4bZ5ZFNv1cyQikmBjk0XfQzUIUdob
         sZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139136; x=1793743936;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iREv2BM/TPI3Cz0K2O/45W+Zzwpa9oFsTUQAe4Z7CDw=;
        b=re8uOt1JB2hJxY1+2Xjqjc/T1KlzHyT8bS3eAZvoxEW9KpSqN9pO898Y3g3rbdRAZd
         sDqIyiQubfLywZc5kAdVAaMSjfrHti9BaWJ3gbDXDuwGGPC0r1zZ8ZR2G2WvQa6GTNA6
         hRVMdnEcg0fbeVQY7XRNBXQI9fwvR9tvvL4eIZz8fJFEiKh86o/AhMcJlUGdO2+pti4P
         gyv0sqISFEGorwNcuYHqS3kObShcl59i7PutiUAWtI33vu573nP2ijWZFrEAf5ENNvNf
         J0hNMtpj2Ta2xFFSbpe5E3E/aIRYdEHg+p8rr5R3CE7yQGb8Q35Uyh8Xs+7EITMYiyZC
         ieBw==
X-Forwarded-Encrypted: i=1; AKwUvBwTdfI/j6TjxRht2Gok9mnyPDs6rYn50dcmo/a9xwANqTi4LQO2Qp/mcrsZqBDu2tOC7Bdq+c8qPb3zD4U=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJgVto+GgfCulojvX9dU+Neqs+XchAcsufM7aC0ZUcV9vWFM3kV
	WwJ0SVILf3zvfP10YtMd6WhtHRbYRirL6JaeRXoCvOaTSEKGW8y/6l2hsgMuve7QhAe7yGVsY5W
	vo0PZmA==
X-Received: from pjnn23.prod.google.com ([2002:a17:90a:917:b0:3ae:45eb:738e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:510f:b0:3ac:adce:60b5
 with SMTP id 98e67ed59e1d1-3ae580ae38emr273883a91.14.1793139136193; Tue, 27
 Oct 2026 15:12:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:11:57 -0700
In-Reply-To: <20261027221209.1560865-1-seanjc@google.com>
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
References: <20261027221209.1560865-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027221209.1560865-5-seanjc@google.com>
Subject: [PATCH v3 04/15] KVM: x86: Unmap VMAs for KVM-internal memslots when
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

Reviewed-by: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba9..0f3fa4571309 100644
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
 		if (!slot || !slot->npages)
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
@@ -10159,6 +10141,18 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 	}
 
 	kvm_page_track_free_memslot(slot);
+
+	/*
+	 * Unmap VMAs allocated on behalf of userspace for internal memslots,
+	 * unless the memory map has changed due to process exit or fd copying.
+	 * Do the unmap only for the non-SMM slot, as the same VMA is used for
+	 * both non-SMM and SMM memslots.  Leak the mapping on failure, e.g.
+	 * if the task is killed.  Worst case scenario, the page(s) will be
+	 * reclaimed when the process exits.
+	 */
+	if (current->mm == kvm->mm && slot->id >= KVM_USER_MEM_SLOTS &&
+	    !slot->as_id && !WARN_ON_ONCE(!slot->npages))
+		vm_munmap(slot->userspace_addr, slot->npages * PAGE_SIZE);
 }
 
 int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages)
-- 
2.56.0.307.g5fe7bd680c-goog


