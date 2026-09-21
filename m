Return-Path: <linuxppc-dev+bounces-27865-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81C3C982E6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 17:44:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpVx05wX0z2yhD;
	Tue, 22 Sep 2026 03:44:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::446"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790012692;
	cv=none; b=FXy2gIBCr/yOLtW296/iiHyg5bE3CvnHYFIjOtssXSEIrGydZe642e/PiMFJ9F7qfu1Vt7RbEF3UX5KZm7xIuc4yiUwSbxw/Qwhj1dB1OTRJ2JEB5SItLx5JJ6CJ2CEZVp4bPQbvStp+ezvA+crossnPaLIhirH7SDYIWPCSSljLvTZVBR2heTeZ/p5p471aEKtuB5OXBVj7JacynQHwjAA9GtFaUafm+IjU3vyHrpXR1vdbAlztTysPZPy8HgyoQaI9DO+aMvX4pu+QDlc0zbx2uv6/LDduN0OYRUXG24PJiBSWTdCFYiMq+J86SuOkiQku3fNaIZPfhkiBi8cMIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790012692; c=relaxed/relaxed;
	bh=vpZEGIou0oqWtJedTRzj6hNhUCCuK0pge9AESQcyXk4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oszKJBlUgr0MQhjK2k+Y6ooo3yD/LlXnm6rI1tNgHdsR6FHNt0iClCnZRlJA+mrW9J1kb4WHmcDd9T3lS0A329YRUQaTFDHHckiKJFT/N7yU1Fc6321BaXrC3nU2SfqxinrB9Cic6LVg8UtnUQ26n16QNaeFQywHdZtv+RUi8MhVlZOfxyyseeY96V8OpzkA7QbyIWMCVy8I4lvvFaaWpOQfb0Xa2zVYQ9wnAmGFolEeCE44fp8DwlskFyJHVobuYgGKbWNn+bNMvrn54D4HPVy9b6nczXK2eHTlt40P6u9RcAYNmPGH1ai2zqXOw0mmzp7y4rdvFna6LIJ4ub3emw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XQ0CH97E; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::446; helo=mail-pf1-x446.google.com; envelope-from=3dm2xagykdas3plyunrzzrwp.nzxwty5800n-op6wt343.zawlm3.z2r@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XQ0CH97E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::446; helo=mail-pf1-x446.google.com; envelope-from=3dm2xagykdas3plyunrzzrwp.nzxwty5800n-op6wt343.zawlm3.z2r@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x446.google.com (mail-pf1-x446.google.com [IPv6:2607:f8b0:4864:20::446])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpVwz01rwz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 03:44:49 +1000 (AEST)
Received: by mail-pf1-x446.google.com with SMTP id d2e1a72fcca58-8538a72b430so3494956b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 10:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790012687; x=1790617487; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vpZEGIou0oqWtJedTRzj6hNhUCCuK0pge9AESQcyXk4=;
        b=XQ0CH97EYvSlMU5WmkBJz8SjZOJ14o6JNdZQpFTtP3cZ1iS5dp/f57vNdrboISsLR9
         LAKM0gndXIQXAnf9SkC08OVwikABQdsQLlvxL9aLzUPZSH1uxMscZ06yjPaW+6XOfchz
         DSFBtYQQcnrNGZ9EVcA/TSK761G/Xvs2ypU+/mUSBwMnnZ09ymaVf8/6vJx/ZzLMCgDT
         BHCNFtuYphoAPYpueG+84v2VIj2RkMHkux/uqWwK94anG/k0QVFPsnFqSzsEl1i85836
         hBfPrXzQidOarFhcwdjaxv+g7W55dYkUCwDuNu8PD0IRjNlJ8unzbobSC+6y8VYAga7f
         YcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012687; x=1790617487;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vpZEGIou0oqWtJedTRzj6hNhUCCuK0pge9AESQcyXk4=;
        b=dVmmGdGVjOJKpcrd2s7mtEbPW4MpfsiW10NccrTqrE/w65FQKJZdEbL49Toq8IGXjv
         rVfkI8Ox4Tk8OXHHNEKTOI0qtPITJaTMYpu/BzY4Faz8jAG7m2RQinwXdVyZiQOb+fH0
         ZDdd67lJRubxbiZQMbQfQ8q/EHzz8trCgLLrNvgkNc96cqFZ0EMErwW9V6L8L9OgbnCy
         UrnOo+AXJi8LKgC8LlG6O0IZbf4Ie1o+NfnnkdSqSI03Qhan9R7dxX4Gs2VOSTjhGg/u
         gSBxhq74bGazqtomGrQMod/bsBzgMJAlonGVJ57GCwfk23fi0ij7jREsHTtDqhJLdsFR
         4Hzw==
X-Forwarded-Encrypted: i=1; AKwUvByH005L+KsQeCMgL3RCx2XrK78fK1T2SsnaUVnb+2qG0ZGtwKBe1qQYLnW1kmF2WHpoevkjJ5i7v7M/J8s=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kNtaqf4K5M2y8+B0Lvi0llb6PJcXBrvILIThbj88WFXxRUyfNR
	mhWoz6Hx2o7X2migK500X1Y32RKFUaHQcK/B2AbOcHIfbzeEeWwYd8J/qO0pNzuo0QSYHpYDieV
	pvqIQtA==
X-Received: from pfbgs18.prod.google.com ([2002:a05:6a00:4d92:b0:87a:49f8:6a76])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9487:b0:878:3507:8d6b
 with SMTP id d2e1a72fcca58-8783508a7bemr7870003b3a.50.1790012686945; Mon, 21
 Sep 2026 10:44:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 10:44:38 -0700
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
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921174445.911676-1-seanjc@google.com>
Subject: [PATCH v2 0/7] KVM: Serialize vCPU creation and revert vcpu_ids tracking
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, 
	"=?UTF-8?q?Pawe=C5=82=20S?=" <spawel523@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Serialize vCPU creation by holding kvm->lock for the entirety of
kvm_vm_ioctl_create_vcpu(), and then revert the now-redundant tracking adding
by commit 97d65b544f48 ("KVM: Check for duplicate vcpu_id as early as
possible").  I botched the math when justifying the vcpu_ids tracking; it's not
an extra 256 bytes, it's an extra 2048 bytes.  Roughly doubling the size of
"struct kvm" tripped x86's KVM_SANITY_CHECK_VM_STRUCT_SIZE, and obviously isn't
something we want to do in general.

The TL;DR of why it's a-ok to serialize vCPU creation is that no VMM actually
does parallel vCPU creation.  As with so many things, KVM's current behavior is
the result of decades-old cruft, not intentional, deliberate design.

Patches 1-3 are a tangentially related cleanups and bug fixes; I included them
here because holding kvm->lock for all of vCPU creation allows WARNing if KVM
attempts to lock all vCPUs if vCPU creation is in-progress (the caller must
hold kvm->lock).

v2:
 - Tweak patch 1's changelog to clarify that that only x86's manual checks are
   dropped. [Sashiko]
 - Add patches to convert additional arm64 and RISC-V usage to 
   kvm_is_vcpu_creation_in_progress(). [Sashiko]
 - Remove acquisition of kvm->lock from s390 and PPC vCPU creation flows.
   [Christian, Sashiko]
 - Add Jean-Christophe's Tested-by to the revert.

v1: https://lore.kernel.org/all/20260914181223.289061-1-seanjc@google.com

Sean Christopherson (7):
  KVM: Reject attempts to lock all vCPUs if vCPU creation is in-progress
  KVM: arm64: vgic: Rely on vCPU creation check in "trylock all vCPUs"
  KVM: RISC-V: Use kvm_is_vcpu_creation_in_progress() instead of
    open-coded equivalent
  KVM: Protect all of kvm_vm_ioctl_create_vcpu() with kvm->lock
  KVM: Move check for existing vCPU ID to the top of vCPU creation
  Revert "KVM: Check for duplicate vcpu_id as early as possible"
  KVM: WARN if vCPU creation is in-progress when locking all vCPUs

 arch/arm64/kvm/vgic/vgic-init.c | 12 ++++-------
 arch/powerpc/kvm/book3s_hv.c    |  2 --
 arch/riscv/kvm/aia_device.c     |  2 +-
 arch/s390/kvm/s390/s390.c       |  5 +----
 arch/x86/kvm/svm/sev.c          | 10 ----------
 arch/x86/kvm/vmx/tdx.c          |  5 -----
 include/linux/kvm_host.h        |  1 -
 virt/kvm/kvm_main.c             | 35 +++++++++++----------------------
 8 files changed, 17 insertions(+), 55 deletions(-)


base-commit: d599822bdb66aeec5ec76297b0fc6efaaeefe07c
-- 
2.55.0.1082.g2b9226bbc0-goog


