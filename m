Return-Path: <linuxppc-dev+bounces-28693-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33344CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 20:23:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwjyl1pw4z3c1g;
	Fri, 02 Oct 2026 06:22:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1045"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790886175;
	cv=none; b=K/UzyOkrN5QJCsjC3z29Hclz34UuHac85CqWN0Fa6JIRi4VTla+swC+8rG+wgrROjAEnktnOjzlDHDlOyG9INf91q505spwbXbwIOaNxqbIzDXShJgD/wR4cjVKSjz81gOKGocgh6r2emjWpGn7B0kzswWQqNOvcoK2oLMOoqs9UPZxi2/ZkXOif4Fl3Bbdwn3mDmy9s/8BaXZIkFg9kOchJYQkrboTtRDXN/C1Dn+94/+3VhkkmPi07ng2qkVliHbcbIcDnQgm5akxZnxchJJ4JpoxqRpOZicT/jB+ptXU02K1S5Iw5BAfhjbpIMT5uNve1tsDKg90/8sLI8NoNXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790886175; c=relaxed/relaxed;
	bh=Qvx6sbBHpVfrs0EKvgXvgwYh4GINhQ+EZvF2xOPN8GE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O5579wpfegN2hIooz8NaOv/7BaZ99SA59hxFU1ANPJc8hKAceiGKe+sos8iqMJZWNDw5Mdpa1vyjTLUcx5Fd1xdqcPDrIVlPKNmMB0VmAb9T2lTp1WRumKEZxJft7PPDoQdthOMRKSw9xYZbwD2Zcw3+oVQjg9XFkQVWEk6fpsrsDHaOMOBTTY/+DVhfYqUnxar5sCD4Rh2phT7hmMO7x5MT432NMsEIMn359g+yZ5sUCWN9me5oR6El+B4DiQ05uw7F10LcjJ+zVouFgjAVmfN+hGF2AzD1kbP5I5wMR4TYexwLzF3aUO2JfI1U5qLU25vrpDqa6PUb5sybhzCHWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Hkx2KV8p; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1045; helo=mail-pj1-x1045.google.com; envelope-from=3g8g-agykdpqoawjfyckkcha.ykihejqtlly-zarheopo.kvhwxo.knc@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Hkx2KV8p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1045; helo=mail-pj1-x1045.google.com; envelope-from=3g8g-agykdpqoawjfyckkcha.ykihejqtlly-zarheopo.kvhwxo.knc@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1045.google.com (mail-pj1-x1045.google.com [IPv6:2607:f8b0:4864:20::1045])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwjyk1GPHz3c05
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 06:22:54 +1000 (AEST)
Received: by mail-pj1-x1045.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so15169291a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 13:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886172; x=1791490972; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qvx6sbBHpVfrs0EKvgXvgwYh4GINhQ+EZvF2xOPN8GE=;
        b=Hkx2KV8pxba5cpUA0tZrWf4evkfM0XE8ziAfxzVCmlO0dK8xH2b26evVnJZfc0dXLS
         g/XwOyUkAUkXh4zWViWjY5fX/skwdgWi24fXTToDmEWjBFoZyirFqf1ZrqLwltw3MHkT
         gAOzeR1V4VhKFO+nViBO2hNyxs1SAbJBMCEs7+5DRg9EHgOBSnhbOvV/0/u4xhaqyF39
         NNL96m7OtJ20KVbg665qDGLiVPtN5HmwSr8j+uIhFjxIEmnQ+jJO7KgsLmqMajdUniLz
         p+Pfi675yOBUCL13hOgzZwf+AaTKYr9Rh1yg1QBj8U4PHnQYEI6Ejpe51nHvSP47O+Rf
         tSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886172; x=1791490972;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qvx6sbBHpVfrs0EKvgXvgwYh4GINhQ+EZvF2xOPN8GE=;
        b=YunSs804rm1b8lXcWQ/pKIdNI+s/J+TrSUVJAUsZmvGs/H5c0MZHU2LoFzfL8lP4sr
         R3GNJbUzHQ9fdGriw0Z9++8W4+yYWtUUJqUqS5g/afa7A9J6AUiZ1Y5X1JN2HRvRtnVx
         P05r9XfGr0aB4us+abaON6D5toZ4N6sHy4RG19JXJU4/rrG8+eCvLPmFGCWPuBgjV85w
         bd7BY32PNfjABT+0VGyVDAUqkWoJtLK4ymljMxJnOMydeSrBlXPGItzh73wXZ5O2zauI
         cD/L9h0lk/QoNSorqMKWKlCQkM+443qMgF9ylzDURdvIOJegOBWIhz2paSn0PaHl8NA6
         NzmA==
X-Forwarded-Encrypted: i=1; AKwUvBzwXlGxiJN2RQ1LldajrHekAmPNiGzVkoNyT8SwGx82Jeqo0VjZbpdGhEGgGsbm0QP+ByFFPjfWl7oKRXE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL/A/AbX74/E/ckJAJ/r5Xea0iozvLWO/5KDCdcYjxZLCidCwrA
	9ndBWjzAHDCnQHqr+by7+jEFzNh7J6JaWO9c0JPpqtcyLlhbG0hncPVVTpFV2EbcPOARhzC/Qxc
	auf0f3w==
X-Received: from plct19.prod.google.com ([2002:a17:902:d293:b0:2dd:2d81:c97])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2787:b0:3a4:f4e8:e09c
 with SMTP id 98e67ed59e1d1-3a6ceb0557fmr560862a91.33.1790886171697; Thu, 01
 Oct 2026 13:22:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:32 -0700
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
Message-ID: <20261001202234.3794060-9-seanjc@google.com>
Subject: [PATCH v2 08/10] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

When a vCPU is destroyed while L2 is active, KVM synthesizes a nested
VM-Exit, which flushes the cached shadow VMCS12 back to guest memory:

  vmx_vcpu_free()
  |-> nested_vmx_free_vcpu()
      |-> vmx_leave_nested()
          |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
              |-> nested_flush_cached_shadow_vmcs12()
                  |-> kvm_write_guest_cached()
                      |-> __copy_to_user(ghc->hva, ...)

Accessing user memory via a memslot during VM destruction is broken, as
there are no guarantees that current->mm == kvm->mm when the VM is dying,
because the last reference to the VM can be put from a different process
than the original creating processes.

And even if the original process does put the final reference, during
process exit, do_exit() calls exit_mm() before closing file descriptors, so
vCPU destruction runs with current->mm == NULL on a borrowed lazy TLB
active_mm.  If the borrowed address space has a writable mapping at the
to-be-written userspace address, KVM will corrupt an unrelated task's
memory since uaccess APIs, including __copy_to_user(), don't sanity check
current->mm (and *can't* sanity perform KVM's current->mm == kvm->mm check
since that is firmly a KVM-only concept).

Hack-a-fix the nVMX flow even though KVM now protects against bad uaccess
reads/writes in the core APIs, as doing so will allow adding even more
sanity checks in KVM's APIs to help detect other buggy code.  Add a TODO to
call out that checking if KVM can do a uaccess for the VM is a hack; nVMX
really needs to stop abusing __nested_vmx_vmexit() when destroying a vCPU.

Fixes: 61ada7488ffd ("KVM: nVMX: Cache shadow vmcs12 on VMEntry and flush to memory on VMExit")
Signed-off-by: Jim Mattson <jmattson@google.com>
[sean: key off __kvm_can_do_uaccess(), add TODO]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 7 ++++++-
 include/linux/kvm_host.h  | 8 ++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 151873407abd..8e31eba4d9fa 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5134,8 +5134,13 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		 * Otherwise, this flush will dirty guest memory at a
 		 * point it is already assumed by user-space to be
 		 * immutable.
+		 *
+		 * TODO: Drop the explicit check on being able to access guest
+		 *       memory once KVM no longer abuses the nested VM-Exit
+		 *       flow when destroying a vCPU.
 		 */
-		nested_flush_cached_shadow_vmcs12(vcpu, vmcs12);
+		if (__kvm_can_do_uaccess(vcpu->kvm))
+			nested_flush_cached_shadow_vmcs12(vcpu, vmcs12);
 	} else {
 		/*
 		 * The only expected VM-instruction error is "VM entry with
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0ee81754d730..0c58a4945595 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1350,10 +1350,14 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			      gpa_t gpa, unsigned long len);
 
+static __always_inline __must_check bool __kvm_can_do_uaccess(struct kvm *kvm)
+{
+	return current->mm == kvm->mm && refcount_read(&kvm->users_count);
+}
+
 static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *kvm)
 {
-	return !WARN_ON_ONCE(current->mm != kvm->mm ||
-			     !refcount_read(&kvm->users_count));
+	return !WARN_ON_ONCE(!__kvm_can_do_uaccess(kvm));
 }
 
 #define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)				\
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


