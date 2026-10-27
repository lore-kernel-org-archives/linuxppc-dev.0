Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759F860A3810
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mo7mZxW2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDl8y5WcZz2yfs;
	Wed, 28 Oct 2026 09:12:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::546"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793139138;
	cv=none; b=jwlaCPzwxmJpCX3g4m2sFBh+rgC5WAN/MJku0NbENvqxX2JBqSh2BAljkGQemRWTleW8To14WcCp+y5X46GTVhcqhiA5AhB2UCldEFqQHs589UE4yNwFocXtGcqFYZiXRkazAzTk3LJkW6dqxazCLrXDN8LXO2uzijhECpQJpsuAlZvCXqIR7p32mwbC1ICX77FRorQ91MIFolQNi15g/AIcu02ZaMWNxOlayG+rbdgUPR44wJbnyfq/1ekK4OteFRQAPJA/Dxs72e+n3+nP/pYlsPDqhTugOCT7Jj54AtMTT2Grdt4lE/SkwRwWmMYLim2wtS7GF0e3ZPDy5nIDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793139138; c=relaxed/relaxed;
	bh=4+wo0Hnq368mIoBgSKtnd7+wHbHIcDQRZtxGt/eUG9s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WAe/6cwv0qw65TQV08DP+eo9GTJg/qStrqimGzrZ2ZnZfGJvLsm8dr9Q9dQsRanOc0Jgn8vlNFgtCTQVwZamCLag6Fd821Dz/kp742qec63iE0Bkiav54uYgCfGznRiPei2H549ec4DgMZENCEfJZ8zRp1QgcNJETdWjn1me8A4FitHLVtdyvrvuF2F/EYmXrfkLBafjEwtfY6AIsHRpnq4dTE0KYjGR9Ma4ug/Pn5qC47OS6ep+2EWkSmEBWOVO/0dV2UmFqVeQaiCXnXCyQ+IUlsI9ymMLp3qovGXTVR629mLZg2WR34+Jb/V8GrGrhff76hIXQvoGatRZPVaBQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mo7mZxW2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::546; helo=mail-pg1-x546.google.com; envelope-from=3vshhagykdoiwierngksskpi.gsqpmrybttg-hizpmwxw.sdpefw.svk@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mo7mZxW2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::546; helo=mail-pg1-x546.google.com; envelope-from=3vshhagykdoiwierngksskpi.gsqpmrybttg-hizpmwxw.sdpefw.svk@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x546.google.com (mail-pg1-x546.google.com [IPv6:2607:f8b0:4864:20::546])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDl8w0f3fz2y8Z
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:12:15 +1100 (AEDT)
Received: by mail-pg1-x546.google.com with SMTP id 41be03b00d2f7-cd68b8579f2so160358a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139134; x=1793743934; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4+wo0Hnq368mIoBgSKtnd7+wHbHIcDQRZtxGt/eUG9s=;
        b=mo7mZxW20IrQZT2vzQ/5Q5k+gmYmgIQ6LS638ESivu8BX+maYDUHJ/BTjupCQCq+rM
         5ygX8wodMgDJVxQVmQL+kM+gMYDTzNV0XwieOfd8DSRxpEmCVD2FQZXB+epLGvPqOeMB
         Cgh4f2gd7kCHfqMeWfmMc74umbbH9eUm1yEYbfW/+ShZExdh7bKAAUn+fn2c1L9hAuvh
         xVZLw8DUY+Z0u5rmlH5YGjbnK5HjEvX1+em4B4LzV8Nl4oCcimcbcOQA827vEDtd/dyp
         hvtHW6jln/oTsx3eC9vRgE2p+yEUDP8/Z5AICEM91K7h7kJgUFVZPZWhghLCarBs2m/9
         t8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139134; x=1793743934;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4+wo0Hnq368mIoBgSKtnd7+wHbHIcDQRZtxGt/eUG9s=;
        b=ZCrH708Eevfke1YEdw1X/bYOoC9aX4XkHh8bTeJ/UcHNUynDBuPn9i2BwcFaZS79Sq
         fAIG1ggE2ydZkc+vnOOTQrnwqYHYNheblpg0D0QxTPYtMsM7zC3cRAq5rQNFhJ1KKbpH
         6KowOTO+3sM1B5LtgvTBQewhygDhP7/p3+voDxF50rVlkxDitfXxYX2A8exUpUeeb2tQ
         Js2W+YlwhGNgUYUygTg5aORDMstXQCdRTNSVO3MR2/uQjpLguiuS4e4AwoVUKflXhmTj
         enhMcr2VZXW5vlS/Ly5TvqVVE0SqaLiiey/4zSucJ6Nqx6zxmZFWECpWDhlnbO9G/qlC
         X3gg==
X-Forwarded-Encrypted: i=1; AKwUvBxSRP6tcqq7WaFCCpmRi51SaxDrDYV4CbVITdyQkzjUxvTDKZNsFvSnyzVYNdzBk3IcD50rGbaTsYCCyEU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJUTRb8uxIoeJSPTWwWGYh8zzIi+2owtNAR3g4HsS+H3lLU1FQ0
	XU/AxQysWRVGgcxr6YV5SI8UuJNZh9t5dSTahVLqXO07mU8aZ4XyXb05WyKzuwY0B8Q9WZ+g1mT
	zg7gVrw==
X-Received: from pjzj16.prod.google.com ([2002:a17:90a:eb10:b0:3aa:dfda:ecdb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:582e:b0:398:e96a:8999
 with SMTP id 98e67ed59e1d1-3ae57f637c3mr292276a91.16.1793139133835; Tue, 27
 Oct 2026 15:12:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:11:55 -0700
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
Message-ID: <20261027221209.1560865-3-seanjc@google.com>
Subject: [PATCH v3 02/15] KVM: nVMX: Don't force a full nested VM-Exit when
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
2.56.0.307.g5fe7bd680c-goog


