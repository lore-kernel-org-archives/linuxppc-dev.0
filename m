Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00CE60A5BCC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nvhPObru
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYtk60ZFz2ygg;
	Sat, 31 Oct 2026 08:21:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1046"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395278;
	cv=none; b=g4vggaF0Zkh1YS8oyf63EoCaRd8G/SEWFW/+NXY/dfliXb7/McnOQq0lZJQbIRH9TsF4dUa+SqIfPyG1yi3KdWAwjIJFibBOQX6iqgufbFLDHFTrpjzj9CW57dMdLZl02r+BFvfS1l0WBjE8MA2Rrjb0SDDCeAOYVEXDbxwD8EylanT2kfErlpinWPL2+RK+iaZrpQyg6kk3UMuFAjpnWhs/2fyHfiw5yFSTMx3/bHhGZfXEFR5hXDvpIOCd+PW2Rzki+G/HLN6lqbIBdd4/xyKlaLqMxyF3vv7YzG8rLxHdwKIlqRYS5HStD3xGsNYfVpA4j+FQGcqJH+T31+/bbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395278; c=relaxed/relaxed;
	bh=9Z3EYYcj7DPzn99/aDJihGAHrZCLthA2ifb7uE3O3Dg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mUhs0HXUqqOHgdRGGCWtnyMQmgZ3+CF0TFHQAQ2zCl4uDFOj2/vLgQZyR/t3DZW+GGv/apYnk+6qbHMbjEc80hiGUIeNeA7lIy9CxPNQb4xiQrsXGeYy164a28m22NPrWIJmiEMw18HBXaN7QcQUeMVDv0VhbKieiKkQ8mGgmHgLmHtrCAsKo/LVyVTpnvUuupEUJdp+IQ4AbKpocLlqshaL239Wd2SqGlmYC4QairiqumDYN3lFHyisXtBu/pi2lCMnL96O5GZoGmrBph2Oi9u0t+O4ITwKDEG6jIo6qDaIZgxLbIQVpEIx/vgKmwTHILuFn0Wxo/TOepw17yJRcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nvhPObru; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1046; helo=mail-pj1-x1046.google.com; envelope-from=3sqrlagykdfaaws51uy66y3w.u64305cf77u-vwd30aba.6h3sta.69y@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nvhPObru;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1046; helo=mail-pj1-x1046.google.com; envelope-from=3sqrlagykdfaaws51uy66y3w.u64305cf77u-vwd30aba.6h3sta.69y@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1046.google.com (mail-pj1-x1046.google.com [IPv6:2607:f8b0:4864:20::1046])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYth5TpNz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:16 +1100 (AEDT)
Received: by mail-pj1-x1046.google.com with SMTP id 98e67ed59e1d1-3ad53f538d2so1011771a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395273; x=1794000073; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Z3EYYcj7DPzn99/aDJihGAHrZCLthA2ifb7uE3O3Dg=;
        b=nvhPObruyyZ/LWBFn/90XtAL/mTJZ0YxhvprN2AGQ8pzveNjB1mgqzGdll/bXG4TIS
         IogmJNx2A350cXQx1UpFuadyQqBT+yY+LFS2lPdHDu8n70mUa8+tkoWvHh7Unn1qcPnT
         84lbsE/bfXbzVfsjHgNpTGVDAa6KrEsRC52jd9n/z9YK3wVMyZKQ2cInLs2H/4sjQpO8
         upfbRiPrVHfIqfiWKD10wIlpbOIcGbqQu4XX1wqHMeJ1sPR+pC8MDBREw9yqPuv65q0v
         aBClncfjYvf9hAVoOz3Ab0V0g6zH96bMauagVw/5o/cecNbKbeLdWhdXoTbhuuzvlgZX
         hNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395273; x=1794000073;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9Z3EYYcj7DPzn99/aDJihGAHrZCLthA2ifb7uE3O3Dg=;
        b=T1BjdHn8zmATDOEOT0i97DSUSrImJGymij+WAt4dIqxpUlX+7qWFpoFKGkjaO053AL
         TsuiBxSkLx4GCYeASXjFcKpuZceoRq4Ngs6VJwS2QZJyoYJ3bKgeIsENQ2Dk/askScJa
         20aSsVYB5lMW0cKWdVdMdKP2Sm3er7D/xDkgyQDmBGt5VM1lOrvGCLD7qmmZQGJLzziU
         ZJEB324jQKuBs4NW/CWm5Qjfgfr4rPvWDZIUA4kgtOqK8OizAWMsqvlMonopOS1AezOX
         ARAeY1yjRritIDXlXTjfQCPuFm1EjZRkLEWX0DzuHo0xtTIY/R1viH4u0lK2CZUpbYqz
         J2yw==
X-Forwarded-Encrypted: i=1; AKwUvBy3XoWkliwOOhRCxb8KZlo4VdI/z/R24uzNXsnHdFSzgVPndsF4hfES86x2M7N61wSy353+1AW4+MDDTX4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJgdMiOLHEc3hLmoCOXfWBwQFyFReVnQCqK+URZ7/b3xSwG0ivI
	uRQggE2vGLuZABYnItP+6vTdfr/8+tixXVKuFmbNrK0dBeY109XSGx43K5v5Fl/myp+zvMU2NQh
	PVFQtaA==
X-Received: from plgx6.prod.google.com ([2002:a17:902:ec86:b0:2eb:4a7:306e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57cb:b0:3a8:c0cd:57f9
 with SMTP id 98e67ed59e1d1-3ae89744ca2mr2979645a91.25.1793395273224; Fri, 30
 Oct 2026 14:21:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:48 -0700
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
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-1-seanjc@google.com>
Subject: [PATCH v4 00/23] KVM: Fix+harden against bad uaccess using dying VM
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stupid SMM.  Patches 1-3 need to go to 7.4, everything else can and should wait.

Fix a class of bugs (limited to nested VMX, as far as we know) where KVM can
corrupt an unrelated process' memory if KVM (attempts to) write to guest memory
during VM destruction.  Because current->mm usually isn't kvm->mm when a VM is
dying, e.g. because the associated kvm->mm process has already exited, writing
to what KVM thinks is guest memory will corrupt the current address space if
the associated userspace address happens to be writable in the victim.

Patch 1 is a blanket fix for the uaccess paths.  AFAIK, x86's nVMX is the only
path in KVM that screws up, but auditing kvm_arch_destroy_vm() proved to be
infeasible for a human (I didn't throw AI at it, yet...), and I can't think of
any downsides to going straight to a broader fix.

Patch 2 fixes the underlyihng nVMX bug where KVM absuses the architectural
nested VM-Exit flow when tearing down a vCPU, which has a truly absurd number
of problems.

Patch 3 fixes what I assume is a blatant PPC bug.  KVM PPC completely ignores
kvm_arch_flush_shadow_all(), i.e. AFAICT, doesn't tear down its page tables
when the owning process exits.  I don't have much confidence in the "fix", in
part because it seems impossible that such a blatant bug could have gone
unnoticed, but also because I went with a very naive approach of invoking
kvm_arch_flush_shadow_memslot() for each memslot.  The changelog is pretty
sparse, because I didn't know how to describe the issue byeond "this is
completely broken".

Patches 4-(I lost track and stopped caring) implement more agressive hardening
to nuke the memslots before calling kvm_arch_destroy_vm(), e.g. to guard
against writing to guest memory during kvm_arch_destroy_vm() without going
through uaccess.  The big pain in the ass is x86's SMM, or more specifically
x86's internal memslots colliding with SMM, where each internal memslot is
actual *two* internal memslots.  KVM currently uses a single VMA for both,
which means KVM can't automatically unmap the VMA when the memslot is freed
without relying on arbitrary ordering.  And there are several other bugs in
the related code.

Setting dummy memslots feels a little hacky, but kvm_arch_flush_shadow_all()
should have purged everything that effectively caches memslots, so it seems
like the right approach?

Patches after that add more hardening to detect KVM bugs (though the
uaccess+memslot changes earlier in the series should render any bugs benign).

The remaining patches double down on open coding nVMX's vCPU teardown by
tearing down the vCPU "as-is", instead of forcing a switch to L1 and then
doing teardown.  The forced switch is quite heinous, as it requires KVM to
*load* the vCPU when it's dying due to architectural constraints for active
VMCSes.  Not only is that gross, it was also papering over a bug (hopefully
just the one) where KVM was relying on the vCPU load for nested VMX to take
vCPUs off the posted interrupts wakeup list.

v4:
 - Fix the SMM+internal memslots issues. [Sashiko]
 - Massage the vt_vcpu_pi_remove_from_wakeup_list() WARN so that it isn't
   triggered if creating a vCPU fails. [Sashiko]
 - Use "unsigned long" instead of "int" for kvm_is_guest_access_ok() params.
   [James]
 - Collect reviews. [James]

v3:
 - Give up, and open code nVMX teardown. [Sashiko, syzbot, Chris]
 - Drop the nVMX hacks that were trying to fudge around the mass of nVMX
   teardown issues.
 - Free the VMA only for the non-SMM internal memslot. [Sashiko]
 - Use @len, not hardcoded PAGE_SIZE, in kvm_is_guest_access_ok(). [Sashiko]
 - Rip out the awful vCPU load code from nested_vmx_free_vcpu().
 - Collect James' reviews.

v2: https://lore.kernel.org/all/20261001202234.3794060-1-seanjc@google.com

v1: https://lore.kernel.org/all/20260908132838.2116068-1-jmattson@google.com

Sean Christopherson (23):
  KVM: Reject user accesses to guest memory if current->mm != kvm->mm
  KVM: nVMX: Don't force a full nested VM-Exit when destroying a vCPU
  KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
  KVM: x86: Drop dead check on an existing memslot not having any pages
  KVM: WARN and error out if memslot update encounters existing slot
    with no pages
  KVM: x86: Unmap VMAs for KVM-internal memslots when the memslot is
    freed
  KVM: x86: Delete non-SMM internal memslot if creating SMM memslot
    fails
  KVM: x86: Process all address spaces when deleting internal memslot
  KVM: x86: Re-queue APICv update request if inhibiting APIC access page
    fails
  KVM: x86: Map a separate VMA for each address space for internal
    memslots
  KVM: Disallow setting memslots when the VM is being destroyed
  KVM: Destroy memslots immediately after mmu_notifiers are unregistered
  KVM: WARN if KVM attempts to do guest-related uaccess with "wrong"
    process
  KVM: WARN and reject guest-based uaccess if VM is dying
  KVM: Pre-check uaccesses in KVM's APIs to read/write guest memory
  KVM: VMX: Explicility free vmcs01, not the current VMCS, in vCPU free
    paths
  KVM: nVMX: Don't explicitly VMCLEAR+free() vmcs01's shadow VMCS when
    freeing vCPU
  KVM: nVMX: Cancel the nested VMX Preemption Timer's hrtimer in
    free_nested()
  KVM: Add lockdep-only APIs to query and assert that a vCPU is
    unreachable
  KVM: VMX: Explicitly remove dying vCPUs from the PI wakeup list
  KVM: nVMX: Don't switch to vmcs01 when freeing a vCPU
  KVM: nVMX: Don't load+put the vCPU when freeing nested state for a
    dying vCPU
  KVM: x86: Rename __x86_set_memory_region() =>
    x86_set_internal_memslot()

 arch/powerpc/include/asm/kvm_host.h |   1 -
 arch/powerpc/kvm/powerpc.c          |  11 +++
 arch/x86/kvm/lapic.c                |  42 ++++++-----
 arch/x86/kvm/vmx/nested.c           |  69 ++++++++---------
 arch/x86/kvm/vmx/posted_intr.c      |  68 ++++++++++-------
 arch/x86/kvm/vmx/posted_intr.h      |   1 +
 arch/x86/kvm/vmx/sgx.c              |   2 +-
 arch/x86/kvm/vmx/vmx.c              |  31 ++++----
 arch/x86/kvm/x86.c                  | 110 +++++++++++++++-------------
 arch/x86/kvm/x86.h                  |   4 +-
 include/linux/kvm_host.h            |  45 +++++++++++-
 virt/kvm/kvm_main.c                 |  94 +++++++++++++++---------
 12 files changed, 298 insertions(+), 180 deletions(-)


base-commit: 7e60162b16f9da0d2fa83da5c1723b6853a0ac1d
-- 
2.56.0.385.gac671c819a-goog


