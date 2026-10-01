Return-Path: <linuxppc-dev+bounces-28685-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA54CA5FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 20:22:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwjyb3DQ2z30MY;
	Fri, 02 Oct 2026 06:22:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::547"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790886167;
	cv=none; b=JBaVErUgjZZhlR05gldA+CfoWYzZYQptJ+4d9A6qB9CHH7fIFEnsxN823ZszurMehEIzaaKzBuM/Gi1JxKt+uXu5UHSBZBTWm9eHJmp4VlLQxRsQfeNi6fb1r1EDPIOV2RFWl7yIHSP9mkQ9Z4gwyni2yTa62LSardpm/9KRtDqsDr8ueahqsOePFtFGtzcW18FnPVrfUCTKS4YdZyCaFKuhvv3WSrRj8nPDDLz7MJT88dPjsASoMTKoa+FZisQDN4GVPD9/a0s87IS3JKhdy2/NA4zDMG5+06m13m2PJDzwKR6GGFxXKR0/Qy54cgrqhtR78MH9OanOL77kQ6Kc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790886167; c=relaxed/relaxed;
	bh=h55kbjbOzz1CLCuyE736LNDaYbs1qeRtkzsUvXEbxPA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KWEOgZ/B/e/M7sVRJAv/5avzQS3m4gWcAosygcLpVIyYfy210qKIlpk0xDSE7TQX7f1VSYM5hq+gP5LvvYM6nfBoC9biAnXeyQ+1uLesGNm3v3oaOLl2MlrEwa8hhlgjAMpyEUEtmKV2GmM/6A85VfMNnW9Q6qpwD4wYEAmHm5YKjcLy0w7P/+ygBxvsKhUh9it4gSAVUMA4WU2Ki/dxAFb7ai6xGraHyCq6kv+ph/IXiYp6QzpH49B90OwRiF/OC1jowv5YfOmCT08xAyHvyoa2+eepzm5wUWUScWkCXDoV3fxGsM/uXCqxPb3lB6qFusgGdqYAHWklIy/953Rtbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dlYVvc30; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3ecg-agykdooeqmzvosaasxq.oayxuzgjbbo-pqhxuefe.alxmne.ads@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dlYVvc30;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3ecg-agykdooeqmzvosaasxq.oayxuzgjbbo-pqhxuefe.alxmne.ads@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x547.google.com (mail-pg1-x547.google.com [IPv6:2607:f8b0:4864:20::547])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwjyY3lh8z2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 06:22:44 +1000 (AEST)
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so5029474a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 13:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886161; x=1791490961; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h55kbjbOzz1CLCuyE736LNDaYbs1qeRtkzsUvXEbxPA=;
        b=dlYVvc30Flbb9S8+CshDDtJiNACyXSDvuVbt8UAY+5X1YuzUQMWExfFR17Z7A69HEf
         3xAge3BPm8LOuoYeb06mjMDXqnFNs8/J+8a5ahb6M/N0Yg5sxdSfnbFZ9LmUvitwyBNn
         5cbX+8awOXKtHfiK23cSOJXY+5IQwBwZ+RQKGMs03W6reM1SZBTyqS46GEzmEndC4umu
         ytwBBEE9VH4FzpI7Bi4wt2VXhFHeUOLYP1z1xAAjEOUYlotlV2vAWailYNc5dWFhW4ea
         gMwPqfZO51q0Gsrsgv5G/9s9w3FJpxW4u5Y0vixSRx5EZyPyQu+miDsgess+9SZOSaRs
         6pUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886161; x=1791490961;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h55kbjbOzz1CLCuyE736LNDaYbs1qeRtkzsUvXEbxPA=;
        b=ejh0iEaFAk4Ughmflql2UdQdS5sLS4DtkMfLV6tKQFlIZEFxvzxlDJNtSRPBrdPlNS
         iQoSunoRTl03luX9Mayy+tmq/DICXl0U4/9YLloLBVdmbFlNXJVVxdG8iHhGhJuiydXn
         +hQo7DSvEzGtQt/XDfl7g6Zjx1/sWFQkaILsvABKJq/PTvFuKcXDkve9km7iU9yHV9vL
         ibvAPsse9oLRfmyLHKBYmj5yah+YfSGFoD8/fpnKWuAa3waBC5I7y0q6Uws2RVLJc30Z
         eETeY5961qdCLTsJXmN/odJOge4BHyj3ZtzkfKWId0eLY+CCwQS7B/DoXgJ49phu7YSR
         fBiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOR8ZkS1/xuj388gWBX0z4JBXiCKzjc2/Jbar7MqQUm9Xvk0erSYN0dFXv/9ko2hdPOyRAwtUbIYrwHMU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++leNHEjd9p7z/ws5/Vn+hXqnuyPotHqi+4lwPipE794tlpmGUHx
	1bf1fgjYwEzpbce9CRUS+rohWiIVsjx3Ddj8i5QXk5st+5BPsw3LNRL5U8lNrbioCFl4S533u5o
	EUlfwHw==
X-Received: from pgde21.prod.google.com ([2002:a05:6a02:315:b0:cc7:e6e5:e624])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e292:b0:3dd:a196:30a9
 with SMTP id adf61e73a8af0-3e0bd4d2b15mr507037637.89.1790886161199; Thu, 01
 Oct 2026 13:22:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:24 -0700
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
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001202234.3794060-1-seanjc@google.com>
Subject: [PATCH v2 00/10] KVM: Fix+harden against bad uaccess using dying VM
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

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

Patch 2 fixes what I assume is a blatant PPC bug.  KVM PPC completely ignores
kvm_arch_flush_shadow_all(), i.e. AFAICT, doesn't tear down its page tables
when the owning process exits.  I don't have much confidence in the "fix", in
part because it seems impossible that such a blatant bug could have gone
unnoticed, but also because I went with a very naive approach of invoking
kvm_arch_flush_shadow_memslot() for each memslot.  The changelog is pretty
sparse, because I didn't know how to describe the issue byeond "this is
completely broken".

Patches 3-5 implement more agressive hardening to nuke the memslots before
calling kvm_arch_destroy_vm(), e.g. to guard against writing to guest memory
during kvm_arch_destroy_vm() without going through uaccess.  Setting dummy
memslots feels a little hacky, but kvm_arch_flush_shadow_all() should have
purged everything that effectively caches memslots, so it seems like the right
approach?

The remaining patches fudge around the nVMX bugs (KVM abuses its nested VM-Exit
flow to forcefully take a vCPU out of L2, which has been an endless source of
pain, but is also equally difficult to fix properly), and add more hardening to
detect KVM bugs (though the uaccess+memslot changes earlier in the series should
render any bugs benign).

v1: https://lore.kernel.org/all/20260908132838.2116068-1-jmattson@google.com

Jim Mattson (1):
  KVM: nVMX: Don't flush shadow VMCS12 to guest memory during vCPU
    teardown

Sean Christopherson (9):
  KVM: Reject user accesses to guest memory if current->mm != kvm->mm
  KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
  KVM: x86: Unmap VMAs for KVM-internal memslots when the memslot is
    freed
  KVM: Disallow setting memslots when the VM is being destroyed
  KVM: Destroy memslots immediately after mmu_notifiers are unregistered
  KVM: WARN if KVM attempts to do guest-related uaccess with "wrong"
    process
  KVM: WARN and reject guest-based uaccess if VM is dying
  KVM: nVMX: Don't try to load eVMCS12 page when the VM is dying
  KVM: Pre-check uaccesses in KVM's APIs to read/write guest memory

 arch/powerpc/include/asm/kvm_host.h |  1 -
 arch/powerpc/kvm/powerpc.c          | 11 ++++
 arch/x86/kvm/vmx/nested.c           | 14 ++++-
 arch/x86/kvm/vmx/sgx.c              |  2 +-
 arch/x86/kvm/vmx/vmx.c              |  8 +--
 arch/x86/kvm/x86.c                  | 36 +++++-------
 include/linux/kvm_host.h            | 30 +++++++++-
 virt/kvm/kvm_main.c                 | 87 +++++++++++++++++++----------
 8 files changed, 126 insertions(+), 63 deletions(-)


base-commit: d4b7fb647204f0c81dfeae2d1a708e4d858e0c94
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


