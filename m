Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89C4606A33D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aIMepb0I
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDl8x2MStz2yDr;
	Wed, 28 Oct 2026 09:12:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::546"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793139137;
	cv=none; b=CSM0iR2RzGSYa34QZUJsBaZ5PmhKW0MCoD+VblMeGanfSq/1Z/1jP7cwvEy3XFr/sRiTO5RlEdbHoACjfmzl9EtwUDuUwbjvE/m8Hf47R7lTfZdL9obrZPX7/uHsUbo1EHFTOq8Fmhokrfh1f95p8z9yQxG/8XX/9zpX9VwEimrsNQR5PB9i9GGxodlgum8SmCCEnUEjujLjUP2bBw3x9DyV3SLM+yGq8rJqI0EGfpv3qQ8W08HajyBMyXdC3pcjIhk9TRDe3TrzTrKYAh1coX+FT1B30KDgqAq79nM33/iVyq4895X82X0vdDuozHeR23kJ2aQvrQVXSX8pIWKUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793139137; c=relaxed/relaxed;
	bh=5Vq2l0nNlx4Jt5Br3FhBTT5y6+xzpkVfJlHDQEljzdw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O8YN3lQnNmyAW7Bfaqz066C4nOcn8ovt1sUwuBaPopiyeBe4oa7bBqOqSJcV1DFl+aCdLufAAx5CCHSh/nLomykR0GJwMg7QDIcC/4Og4qBxuVdDeYdHkMQt47rhrS9jb2vq7lMqFp1s2R289vJR+WuPzs4/sdBJEQWMyAmddim+zfT0UjQUECo/hckp4FUa4W4XYVL2pbr1hmD4eJHpzyRCn3hgRZOwhIgd/plTZ0Po5wCirw4PmC9iJqyxhUROoD7at39cjqbHExIueQOdXBYhXngQUvG9PPVwoSZoeb6k+iAI66yfMcsvvDzIIpo55MwWFbyXFO9l0xmu5+4BOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aIMepb0I; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::546; helo=mail-pg1-x546.google.com; envelope-from=3uihhagykdn8tfbokdhpphmf.dpnmjovyqqd-efwmjtut.pambct.psh@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aIMepb0I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::546; helo=mail-pg1-x546.google.com; envelope-from=3uihhagykdn8tfbokdhpphmf.dpnmjovyqqd-efwmjtut.pambct.psh@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x546.google.com (mail-pg1-x546.google.com [IPv6:2607:f8b0:4864:20::546])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDl8v35w6z2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:12:14 +1100 (AEDT)
Received: by mail-pg1-x546.google.com with SMTP id 41be03b00d2f7-cd60a365440so248994a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139131; x=1793743931; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Vq2l0nNlx4Jt5Br3FhBTT5y6+xzpkVfJlHDQEljzdw=;
        b=aIMepb0INdCGLcjWIr0JttOT5/0HYIDM2hxKG7GbtLypkjyNyeLJSHY3oE19x5Ro+c
         PDFaMFAtXqDwRFa8VLrDEhPWkYbNNyZoFfzZZeM4u4OzIsl+G3lfp3VqSYTYt0KXW6NP
         o4TGo3DxIJ5kBSX09pt821kXZ/B84hJBuMHVTrDBeeDwYxcaCXPsg7vSTDtvOFjeOYxE
         0UzbUrsE8EI8GhrEww1W1ySSYQlzQ21XRLk2yll0heqb4ifGqWkNNu7ff73nlpn1qncU
         0WvObnnqnS94U5hiLzvx3NhxyGd4eSTpilHEEXafA01GPqzvQ0/aRn+1QLNC256Ghx48
         qE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139131; x=1793743931;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5Vq2l0nNlx4Jt5Br3FhBTT5y6+xzpkVfJlHDQEljzdw=;
        b=USZw81hD5Axy5RNx6CO3XVQPZhJQABXVumPyxCfWDHdZWBNFszqYWxp0RC6ROVN/tF
         gP5smqMGXXlus0gNh2vrzRFzbLaqcyoWxQ9oBjsbeRZKtBaFHBoJOQomBA1nZhhnlKPF
         s0200xAm1mciwdHuaGc7TS6jJtV9uGDFs/UAGgVSVTJNoDahMkQ863kpiOlAPXHMU7ZA
         0cVhv0KyGnQ9gbox7tCZO55Zb+zDooLJfv2eFK5uXeaJ3FLgxT/Txjv7BdBd4uG7dcQv
         xH+Qv/YJJyg+4yrCYt2e6iM7Mkdtj1u/8o74UnTNVwRfzVLZS0HFekQ4emXUrmQqTD/u
         ODfw==
X-Forwarded-Encrypted: i=1; AKwUvBwAjAgD9wrjj9MIHytHpjNqft/gckniissdagZUUvE3o0MkAUgAyd5sdkXi20TP/q66BnA1IJyY1AFLH8c=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKbXW2Kx5ERhn5HWe7h1Jvpds+FzMeL5nizo6+/9dHksCbhR61I
	EDu84Nar3e7cMRjPtmuTw+97CNMJyChjJkAgs/W3i3wn8LRq+bzndTRTyT6VaKwzo8e8ZF+1/30
	VidaHsg==
X-Received: from pfbig23.prod.google.com ([2002:a05:6a00:8b97:b0:89e:af6f:f0c7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0c:b0:3e0:d2ba:5b37
 with SMTP id adf61e73a8af0-3e902462639mr382770637.75.1793139130927; Tue, 27
 Oct 2026 15:12:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:11:53 -0700
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
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027221209.1560865-1-seanjc@google.com>
Subject: [PATCH v3 00/15] KVM: Fix+harden against bad uaccess using dying VM
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

Patches 4-6 implement more agressive hardening to nuke the memslots before
calling kvm_arch_destroy_vm(), e.g. to guard against writing to guest memory
during kvm_arch_destroy_vm() without going through uaccess.  Setting dummy
memslots feels a little hacky, but kvm_arch_flush_shadow_all() should have
purged everything that effectively caches memslots, so it seems like the right
approach?

Patches 7-9 add more hardening to detect KVM bugs (though the uaccess+memslot
changes earlier in the series should render any bugs benign).

The remaining patches double down on open coding nVMX's vCPU teardown by
tearing down the vCPU "as-is", instead of forcing a switch to L1 and then
doing teardown.  The forced switch is quite heinous, as it requires KVM to
*load* the vCPU when it's dying due to architectural constraints for active
VMCSes.  Not only is that gross, it was also papering over a bug (hopefully
just the one) where KVM was relying on the vCPU load for nested VMX to take
vCPUs off the posted interrupts wakeup list.

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

Sean Christopherson (15):
  KVM: Reject user accesses to guest memory if current->mm != kvm->mm
  KVM: nVMX: Don't force a full nested VM-Exit when destroying a vCPU
  KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
  KVM: x86: Unmap VMAs for KVM-internal memslots when the memslot is
    freed
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
  KVM: VMX: Explicitly remove dying vCPUs from the PI wakeup list
  KVM: nVMX: Don't switch to vmcs01 when freeing a vCPU
  KVM: nVMX: Don't load+put the vCPU when freeing nested state for a
    dying vCPU

 arch/powerpc/include/asm/kvm_host.h |  1 -
 arch/powerpc/kvm/powerpc.c          | 11 ++++
 arch/x86/kvm/vmx/nested.c           | 69 ++++++++++++-----------
 arch/x86/kvm/vmx/posted_intr.c      | 68 +++++++++++++---------
 arch/x86/kvm/vmx/posted_intr.h      |  1 +
 arch/x86/kvm/vmx/sgx.c              |  2 +-
 arch/x86/kvm/vmx/vmx.c              | 19 ++++---
 arch/x86/kvm/x86.c                  | 38 ++++++-------
 include/linux/kvm_host.h            | 26 ++++++++-
 virt/kvm/kvm_main.c                 | 87 +++++++++++++++++++----------
 10 files changed, 199 insertions(+), 123 deletions(-)


base-commit: 7e60162b16f9da0d2fa83da5c1723b6853a0ac1d
-- 
2.56.0.307.g5fe7bd680c-goog


