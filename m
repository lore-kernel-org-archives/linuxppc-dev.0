Return-Path: <linuxppc-dev+bounces-28688-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B65CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 20:23:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwjyd3TGcz30Vs;
	Fri, 02 Oct 2026 06:22:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::445"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790886169;
	cv=none; b=Q4tGWDsJPUJnwYn015u0j3AhxnQWNmfXo+O9pj3kLqKQtuVrE66UzTP8AQNzIZkdyS+iycDYE+nSe7BFwwpHQVEahFBJ9MCrb/IZnclqG18VrnpaNCi4HtNwp0LsTSDAz/TpdbjmtaDiypjZNY+Dh+6+YamyWaKJuJ7Yut5A85YE1qFddjE3zUnGIAnzHCEj5sAbPix8qLzxfEYS1FMF/inGJC2Z8BaTyQRO/ScAxQmn4Xb1RF1swfXqNaaq7a26012dryOQEyeO6WxGbuGAaGJ3xuQFozngc5HUHDzCrWaT0UTMFKmHUk7taOYe7EkBdZKHrttof54yDqdEqQGj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790886169; c=relaxed/relaxed;
	bh=ymfeYEmvW6bR4RRG+DI7t0UxyoSVGW7KhY3QEGj26Qs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I6XQ6qGuob7vu2voqxIMwn5iKaHDhHKrhk5kCGWko6/jIWu433lBpHLHZ78qZH0hu0T32q7a8kqKND4l4jG/hhKk5c7lV7BlF+Y/rJPUokQJH0qekTjihXn3AfXS0t5Kr1GNtu9boliBNunknZkhrD7Dpx57SUoDqLRnC2EFXgTSAOYZ9krtNAqGlZreSNAYXgmXQiPOYiJ3sWyJCI5yhm3N0mOvUNVGlVD134lGQkH/yWBI+zqVpRJ62BuaWUt/4ppChmJnLE3qcC3EQvdg3T28Mf5+kc3dq/MuuovYh7LEoGaGfhz9t/FtpShE8Bi/ALO5v6XtPQ0HQVytwM2vrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nO3iZWBA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::445; helo=mail-pf1-x445.google.com; envelope-from=3fcg-agykdo4iuqdzsweewbu.secbydknffs-tulbyiji.epbqri.ehw@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nO3iZWBA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::445; helo=mail-pf1-x445.google.com; envelope-from=3fcg-agykdo4iuqdzsweewbu.secbydknffs-tulbyiji.epbqri.ehw@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x445.google.com (mail-pf1-x445.google.com [IPv6:2607:f8b0:4864:20::445])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwjyc302xz30T9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 06:22:47 +1000 (AEST)
Received: by mail-pf1-x445.google.com with SMTP id d2e1a72fcca58-8886b1d3242so902660b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 13:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886166; x=1791490966; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ymfeYEmvW6bR4RRG+DI7t0UxyoSVGW7KhY3QEGj26Qs=;
        b=nO3iZWBADvAB3L+rXdpVEfX7bVyMab1sewtnIK9ad6G8CsvprWSv4eZXrnnrEZs/9F
         OgBaOqc2H1foNQn31ULQTUwbnXtvNVd9sON2IvArRc0HAGwiGMnBMflf92Ke5C4CO3J1
         Wp0r29qsb+wOWYSOXa0rS96CnEA0+n3CjztCNTCNNIep5M9Jx1b54lPrVICqueoP9L6K
         HUlFjU5ym4c9x6X2oxiZSateDKh6s8SNcxTQWJSo3wARXNTZ8R18PWDNnHpgFSUI3SBb
         CIKliBTlwwahq4oNvNHfOzE1lkT9pKGni5vug4+nxctXxahPPEUWk7bl/uqgpaqUr9LR
         SSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886166; x=1791490966;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ymfeYEmvW6bR4RRG+DI7t0UxyoSVGW7KhY3QEGj26Qs=;
        b=o4ci51HSD0yaox3UjW7HIf9xgDczX8A/BzBL3cwMIiQ+zwhMcrkWvTG/SRMoFm59XC
         vIG+3CzHfwu7FqwbIBNyzmCgmAbpl2Gb46htQAxzxIbKbQKnfVNfWkopVkxg/+lnekin
         B+gLVAVl+VwL7R5R5F1yE54oluzLRL5rEo4TKQXsgSQYOCdhZ88FRhWEMB9DPFoq6Plt
         C4mEEboEyyy8J1EFZXaLVJhsqCUljPXmnCQ6ca70I2Q2W7RcAoufXl9iks4aM2wNAyqS
         e1Ws1O5LywCA+cVbcO7i4uATzdPmWrH5onELgVBKbfjf2CQS6Nx40R/Uuum25HGh4RNo
         6AsA==
X-Forwarded-Encrypted: i=1; AKwUvBxO9kaWNTRIwR8iWWT5j5sQxgVM+GwOxbrqqJhrjcxOi7iyGXRHHEaXzTlcS37J6s+YxVz4DD8F6ugFb8U=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k6eujoWM1YIrJ+MY9iT7jKS1jhYS3ONCTjMY/Ts1VUg5IT+wAO
	G0Db6Ti7h0n68QLmHEQct+N2rm/xv1cFNVLnkeY4FQ01nWTh1oyqv/TvPBVUz31xFxVA1EUPG3t
	aP7oxPg==
X-Received: from pgbfq17.prod.google.com ([2002:a05:6a02:2991:b0:cc7:9b89:2a72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a518:b0:3d3:ae40:51e5
 with SMTP id adf61e73a8af0-3e0bcf27ea4mr485150637.25.1790886165277; Thu, 01
 Oct 2026 13:22:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:27 -0700
In-Reply-To: <20261001202234.3794060-1-seanjc@google.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001202234.3794060-4-seanjc@google.com>
Subject: [PATCH v2 03/10] KVM: x86: Unmap VMAs for KVM-internal memslots when
 the memslot is freed
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Unmap KVM-created VMAs for KVM-internal memslots when the associated
memslot is freed instead of unmapping via x86's internal API.  This will
allow deleting/freeing all memslots before kvm_arch_destroy_vm() without
leaking VMAs, and in general is a net positive as it makes it far less
likely that KVM will leak VMAs, e.g. in the unlikely scenario some other
flow deletes KVM-internal memslots without going through
__x86_set_memory_region().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe473..e91bd79dd3cc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9925,7 +9925,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
  * @size > 0 to install a new slot, while @size == 0 to uninstall a
  * slot.  The return code can be one of the following:
  *
- *   HVA:           on success (uninstall will return a bogus HVA)
+ *   HVA:           on success (uninstall will return a NULL HVA)
  *   -errno:        on error
  *
  * The caller should always use IS_ERR() to check the return value
@@ -9938,10 +9938,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
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
 
@@ -9965,8 +9965,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 		if (!slot || !slot->npages)
 			return NULL;
 
-		old_npages = slot->npages;
-		hva = slot->userspace_addr;
+		hva = 0;
 	}
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
@@ -9982,9 +9981,6 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 			return ERR_PTR_USR(r);
 	}
 
-	if (!size)
-		vm_munmap(hva, old_npages * PAGE_SIZE);
-
 	return (void __user *)hva;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__x86_set_memory_region);
@@ -10013,20 +10009,6 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
 
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
@@ -10066,6 +10048,16 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 	}
 
 	kvm_page_track_free_memslot(slot);
+
+	/*
+	 * Free memory regions allocated on behalf of userspace, unless the
+	 * memory map has changed due to process exit or fd copying.  Leak the
+	 * mapping on failure, e.g. if the task is killed, worst case scenario,
+	 * the page(s) will be reclaimed when the process exits.
+	 */
+	if (current->mm == kvm->mm && slot->id >= KVM_USER_MEM_SLOTS &&
+	    !WARN_ON_ONCE(!slot->npages))
+		vm_munmap(slot->userspace_addr, slot->npages * PAGE_SIZE);
 }
 
 int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


