Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB403606A9AF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l42G7nQk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYtl6Z9Zz30Wh;
	Sat, 31 Oct 2026 08:21:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395279;
	cv=none; b=UpZjSI40TBa7WIGSlslmosldnYfllUPxI6BtSFWM7e/FGsqfwADAP539DXlCnC2raJFxVyEqqYbG56vu1yplBEUtEBStfAhWQ1wquzI/R55zhYU6n4ygyUWP5WPASlkzinp1y4cIsBfwu5VZIo8nzprlnrCPy7qccCwRuuLRHX1rzZhSp+BP2NgsKBNRQ9WpnsoTkJoJa3/vce74OeGZ+3cFsNtdN4ABfWIUFUjju4BWDDV25RpJF/xzFXlXx3C94o45u/23L4Y0nwY2YUbBKt4sY/3INFQ5qU9zPYoqfW3rDUrasDrZkTTXdQZ6bK+1ldCF/DUoQkj38Yy2/yDfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395279; c=relaxed/relaxed;
	bh=GVfrMv/JwLPpbAn4FrjFqU3DE6u8ipaxUY48dYc7+h0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c3JQFLTdErMKYiCuZkPdoMaY9G4Gb1cn5g2oH3zo8c4eTqb/yGw7tlf8Nbo5SH8ZmLnYAq1J15oosXnZ52LecHUGpuCtRkWP7zTAa5TUnKsP+uJ6+9HPokDQes3jUAqcr36Oj6/Jr94gzrBPu1j8L/OP6vB8ehSVxRjPV60I0nakLY21t82nYjY7OoaZyNf6FrMtnfz6ygLPZ+kljYiqWs7ecLzP1DLoCN0vqIktGwTsigK5NtD01X4R3M2482CJxfoGG+oVieNiUL36YxyLxw4b2QRVpK+bK1ufgoHkvzdiBsYbQ1SOdbvmd+KzhHuy4DTB+MD4nCoyq+yFt8SEIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l42G7nQk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3swrlagykdficyu73w08805y.w86527eh99w-xyf52cdc.8j5uvc.8b0@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l42G7nQk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3swrlagykdficyu73w08805y.w86527eh99w-xyf52cdc.8j5uvc.8b0@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com [IPv6:2607:f8b0:4864:20::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYtk2XX1z2yZf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:18 +1100 (AEDT)
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2e9d52f684fso11707735ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395276; x=1794000076; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GVfrMv/JwLPpbAn4FrjFqU3DE6u8ipaxUY48dYc7+h0=;
        b=l42G7nQkK/GWjo1vAlfVvQnHMvaIESSWnkRuiL6tWzSzk+zWnucvcYW9datOnNnxyN
         +uJwwnPQMPG8e+jCBrnE3u7J6Cksc3+2EX0/nFTsFjqRvZhd+dNHE5qvESkI/GTC+IuV
         G/GqiPbvjxFlGKF6Ys/x3q5EFVNOWEMnTX+kn/2dNJwO332YYl56e4FoFN6AETvxXdrk
         P3DlX2qDT1aBKs8fYKgDCNLv6t3OyKm3V3qtDI06uAqotaIfvto2BtZLVLhBPF8x/8du
         vZbHQoYE33xyRAt1JzQv4L2iwLolnDLi4G/E59+zr+nQo5RkkQ0kRP3LM4NUUUmGnyNm
         Y4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395276; x=1794000076;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GVfrMv/JwLPpbAn4FrjFqU3DE6u8ipaxUY48dYc7+h0=;
        b=MlSgX0PWuwdhufpkYTsAktouOQGlvZTgm/0RlDEchdDr88bb/NfZSGEtZzPJlEG+b4
         5U40o/Mh4lf3hYUpMihCaeUp5JimMkCI/PSzZ7p9HnFmt1Jx9tjuYkCIdsYkdoD/VLbS
         jxA1NjNhUD+ZElfyk8u45vp9MNnnkl/Q9lYPfRUVmPTLuR4Uzqcy+rpaPEvatn/Lm+X4
         GxJdoVQHGSRhr3EhrOC3PDwmTl44IHPhjBY4NPEiLLtbGw2kouDfYOzbgbADKmAiFWGf
         fDlAjlQoMfKwKKUnWyl/CnpCTdb6jH4r20IXotbfth5nLOmPUMq0+twx0OXij2mflkQ1
         YXHA==
X-Forwarded-Encrypted: i=1; AKwUvBzzYvY48bRrM5XJy7Fa68VNRY/AtvvGUV9a131ig3xl4j02qH51p7+u/Jk/DrrQWN4msEP3KO8EtlqN2q8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLXjKBrPz4T2/ns2t8p7YTla5Ko5snDXM+n6nnOAQbPGxUugiH1
	oh15wWo2TDFYMmfjmGsYiAzXlJCLIErv9Tk7FoJWRONQbLGPzKJ+CCBexic0gipJV4R78Taka41
	qK/lvGQ==
X-Received: from plbme3.prod.google.com ([2002:a17:902:fc43:b0:2ea:884b:e7df])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec4:b0:2e9:851a:7188
 with SMTP id d9443c01a7336-2eb3649c631mr36367485ad.23.1793395275725; Fri, 30
 Oct 2026 14:21:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:50 -0700
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
Message-ID: <20261030212112.2598640-3-seanjc@google.com>
Subject: [PATCH v4 02/23] KVM: nVMX: Don't force a full nested VM-Exit when
 destroying a vCPU
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

For all intents and purposes, revert commit b4b65b5642d6 ("KVM: x86: cleanup
freeing of nested state") and go back to manually tearing down nested state
when freeing a vCPU.

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

Furthermore, the shadow VMCS flaw is only the tip of the iceberg, as the
MSR load/store lists mean that emulating a nested VM-Exit can read or write
an arbitrary set of MSRs, e.g. if MSR_KVM_SYSTEM_TIME_NEW is in L1's MSR
load list:

      kvm_arch_vcpu_destroy()
        kvmclock_reset() - takes pv_time off kvm->gpc_list
        vmx_vcpu_free()
          nested_vmx_free_vcpu()
            vmx_leave_nested()
              nested_vmx_vmexit()
                __nested_vmx_vmexit()
                  load_vmcs12_host_state()
                    nested_vmx_load_msr() - writes the MSRs that L1 listed
                  kvm_cpu_has_injectable_intr() - reads Xen's vcpu_info
        kvm_xen_destroy_vcpu() - deactivates the vcpu_info cache

processing the MSR write puts the "pv_time" cache back on kvm->gpc_list,
and the next list_del() writes into the freed vCPU.  And as effectively
pointed out by syzbot[*], attempting to fix each case individually is a
losing game of whack-a-mole.

Deliberately leave "nested_run_pending" as-is, because even though doing so
creates potentitally inconsistent state, KVM should *never* consume said
state while freeing a vCPU.  I.e. if leaving nested_run_pending set trips a
sanity check or bug, then that just means there's more fixing to be done.

Open code only the "free vCPU" path, i.e. keep emulating a nested VM-Exit
when forcing a vCPU out of L2 via vmx_leave_nested(), as there are a number
of updates buried in the nested VM-Exit flow that are needed if the vCPU is
going to run in L1, e.g. clearing pending exceptions and MTF traps, setting
the TSC offset+scale information back to L1, and so on and so forth.  Note,
this means svm_leave_nested() is all but guaranteed to be buggy, but that's
basically an open secret at this point and at least any bugs "only" break
L1, i.e. don't corrupt host state as is the case for abusing nested VM-Exit
when freeing a vCPU.

Link: https://lore.kernel.org/all/6ac0145f.34119e79.2f92f3.0003.GAE@google.com [*]
Fixes: b4b65b5642d6 ("KVM: x86: cleanup freeing of nested state")
Cc: stable@vger.kernel.org
Co-developed-by: Chris Mason <mason@kernel.org>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854c..49c4529901c5 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -385,8 +385,15 @@ static void free_nested(struct kvm_vcpu *vcpu)
  */
 void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
 	vcpu_load(vcpu);
-	vmx_leave_nested(vcpu);
+	if (is_guest_mode(vcpu)) {
+		hrtimer_cancel(&vmx->nested.preemption_timer);
+		leave_guest_mode(vcpu);
+		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
+	}
+	free_nested(vcpu);
 	vcpu_put(vcpu);
 }
 
-- 
2.56.0.385.gac671c819a-goog


