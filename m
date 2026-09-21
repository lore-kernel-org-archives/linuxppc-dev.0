Return-Path: <linuxppc-dev+bounces-27866-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BA9C982ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 17:44:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpVx05sL1z2ygK;
	Tue, 22 Sep 2026 03:44:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::448"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790012692;
	cv=none; b=K1kka65ITyzqIvj57T5O78lLkw2bIXAdmYAfRMxjPTZQQu2VsPT+5CYQ7UZMJuC6LYQWdfEpkTtqbFbUrrW+QCmbQH24n0RMAXV7/HBKufuddWW9YluvPS6uAWG5g590B2IbHX1VN6G3tHTww8/RAzhrSY2AJ7BFxbbX0nQ/ThHM8zu9jXKufqaCgbYcN0Ox1nnZFHsxyfJ0LSrAtvnplUDksw0NbuVclK343enJNekaloBplLURyi2oful0sTpuqwmxIPYBwJCsbDY1u3UTq+EYNN6DOlraueViNHN6CFaGu6H/osu+ZvPt7lPJ+Jir4GA+zvxkC6ArQysV5fqKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790012692; c=relaxed/relaxed;
	bh=ZLfRYJewP8aR3Y4V2zbyCdDW63inecBdjfc5u4aaKpU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j/ku9BCW/qYH1Ip07aD0dSYJbfVBaxVjX9MppEI6PszEKwpBdoFofR/tbXAm/BFtQ1IvvXYdPOSIDUO3LkfHF5XA5BdNAfW5ibckz1H339uo2Wp3b4MeRWS2rkNMYZHavUbM2rWY+9v7PiSYf6yUhJuo5+1WRU0ocOvX7heBYy5eNW1RRNjiLAAh4uiV8Cv4Ay28+h5MyhNLH18JW0HID5FV5JCWGGTC9cJoPNkjRNrYhlgBNkPZeM5VkhN3/JiY6uUGwp8OUx6OFOjDAyrHz3i/cBd6r3DlpT6tQbfxIJRaby1mIwkciai0HP0TdR8ZcBGdYdUw50rCDoanl5FTlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=sHQH0gKm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::448; helo=mail-pf1-x448.google.com; envelope-from=3eg2xagykda05rn0wpt11tyr.p1zyv07a22p-qr8yv565.1cyno5.14t@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=sHQH0gKm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::448; helo=mail-pf1-x448.google.com; envelope-from=3eg2xagykda05rn0wpt11tyr.p1zyv07a22p-qr8yv565.1cyno5.14t@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x448.google.com (mail-pf1-x448.google.com [IPv6:2607:f8b0:4864:20::448])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpVwz22xnz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 03:44:50 +1000 (AEST)
Received: by mail-pf1-x448.google.com with SMTP id d2e1a72fcca58-86b4048367cso4305714b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790012689; x=1790617489; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZLfRYJewP8aR3Y4V2zbyCdDW63inecBdjfc5u4aaKpU=;
        b=sHQH0gKmF7/W0opYggOpQxtfVV64QSOqUDFutQ/J5cw1x7OQJx+e+vajPABan/NlWd
         P9qCDCrQEcymbhtBkyvF/RCI1an5+O1JX1oTrGRJQqWhd+77zLTa+AiUnxyZyHg05soG
         ETB63q4wydW/KVUY2dRCHNlhPlNzgTUl306NDU2HM6pCcjxxfDY2shfRDeIJlgLnzM89
         8iPZsXweCqfOKgTiTLGZ5i4BGGG0Vv0TcmkI15visbIXN28y6EDrJyp1vl2nJlInzIY4
         uqHXnUlKU5dlTKeYUHMbE4asX3c/MpCl3ht4NEqm35YbWsV22rLYZJ1F5R00Ly4UgNOn
         oenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012689; x=1790617489;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZLfRYJewP8aR3Y4V2zbyCdDW63inecBdjfc5u4aaKpU=;
        b=rqE/McskN3tKZXBKf+ytI4NTKUpRIpmWgVlngjNx+1XS/f73fEfq3+ri+G++ij6VmP
         rM5ky0sK2DURd9G5NzStcCo4v6VPxKst6BM8uR05+pfCi0TJxYZ5/GVBztQjIuHlUM07
         TBbqx5MUySM8CNw/ihxc73HTEjg1N5QfUVjahhoNgu6UyF/cHPEVB1KkUkwt7ANqciXK
         Sxi4LX26Q2W8Fbu9+gL93tfXles/OI+c2TIN9sYTEB12/6JaqW9vXJ2WDracNzFQDVXU
         EhAB8y2GMT3eqt5D9JX7l3W1VPhaoxbeFTHKMie+KmVQmf6iEU+Bpop2CCsTvjddPhR+
         3lUw==
X-Forwarded-Encrypted: i=1; AKwUvBw56CEnTOaaQetk/5FjKZsT/7aE2Vl/fAsjL64mo9wyC1x1PB4qgHC6thInNk18PkVXqVd/REvIcComEg0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mifA1SuaZNz+/iEocu0eheFkdqQ2BEKlQc8g3C0o2RFthm5o95
	bzbDcfsk5IBY2ilqz7mL1sbXY4NbHlBK7p4MTfN9ek09wCJ1eYU32oeI6E7e2QphxHrvuu3jV33
	GIhvsKw==
X-Received: from pfbgk3.prod.google.com ([2002:a05:6a00:8483:b0:873:d536:aebe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12dd:b0:86b:73b4:30fa
 with SMTP id d2e1a72fcca58-874dc0ff42cmr17041050b3a.11.1790012688332; Mon, 21
 Sep 2026 10:44:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 10:44:39 -0700
In-Reply-To: <20260921174445.911676-1-seanjc@google.com>
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
References: <20260921174445.911676-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921174445.911676-2-seanjc@google.com>
Subject: [PATCH v2 1/7] KVM: Reject attempts to lock all vCPUs if vCPU
 creation is in-progress
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

Reject locking of all vCPUs if vCPU creation is in-progress, i.e. if the
number of "created" vCPUs doesn't match the number of "onlined" vCPUs.
It's simply not possible to guarantee that KVM has truly locked all vCPUs
if one or more vCPUs are actively being created.  Holding kvm->lock does
prevent in-flight vCPUs from being fully onlined, but it's infeasible for
common KVM to know whether or not that provides sufficient protection.

In practice, this is likely a minor bug fix for the ARM and RISC-V usage of
kvm_trylock_all_vcpus(), and a glorified nop for everything else.  E.g.
ARM's kvm_timer_vcpu_init() can race kvm_vm_ioctl_set_counter_offset() with
respect to observing KVM_ARCH_FLAG_VM_COUNTER_OFFSET.

Opportunistically drop x86's existing manual checks on vCPU creation being
in-progress as all of x86's checks immediately precede or follow locking of
all vCPUs.  Leave arm64 and RISC-V alone for the moment, as their checks
aren't as obviously redundant/equivalent.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 10 ----------
 arch/x86/kvm/vmx/tdx.c |  5 -----
 virt/kvm/kvm_main.c    |  6 ++++++
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5705723f1f41..068f8a236a35 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1125,9 +1125,6 @@ static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!sev_es_guest(kvm))
 		return -ENOTTY;
 
-	if (kvm_is_vcpu_creation_in_progress(kvm))
-		return -EBUSY;
-
 	ret = kvm_lock_all_vcpus(kvm);
 	if (ret)
 		return ret;
@@ -2115,10 +2112,6 @@ static int sev_check_source_vcpus(struct kvm *dst, struct kvm *src)
 	struct kvm_vcpu *src_vcpu;
 	unsigned long i;
 
-	if (kvm_is_vcpu_creation_in_progress(src) ||
-	    kvm_is_vcpu_creation_in_progress(dst))
-		return -EBUSY;
-
 	if (!sev_es_guest(src))
 		return 0;
 
@@ -2510,9 +2503,6 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	unsigned long i;
 	int ret;
 
-	if (kvm_is_vcpu_creation_in_progress(kvm))
-		return -EBUSY;
-
 	ret = kvm_lock_all_vcpus(kvm);
 	if (ret)
 		return ret;
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a7..58c255256e4c 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2728,11 +2728,6 @@ static tdx_vm_state_guard_t tdx_acquire_vm_state_locks(struct kvm *kvm)
 
 	mutex_lock(&kvm->lock);
 
-	if (kvm->created_vcpus != atomic_read(&kvm->online_vcpus)) {
-		r = -EBUSY;
-		goto out_err;
-	}
-
 	r = kvm_lock_all_vcpus(kvm);
 	if (r)
 		goto out_err;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..78cc090435be 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1363,6 +1363,9 @@ int kvm_trylock_all_vcpus(struct kvm *kvm)
 
 	lockdep_assert_held(&kvm->lock);
 
+	if (kvm_is_vcpu_creation_in_progress(kvm))
+		return -EBUSY;
+
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		if (!mutex_trylock_nest_lock(&vcpu->mutex, &kvm->lock))
 			goto out_unlock;
@@ -1386,6 +1389,9 @@ int kvm_lock_all_vcpus(struct kvm *kvm)
 
 	lockdep_assert_held(&kvm->lock);
 
+	if (kvm_is_vcpu_creation_in_progress(kvm))
+		return -EBUSY;
+
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		r = mutex_lock_killable_nest_lock(&vcpu->mutex, &kvm->lock);
 		if (r)
-- 
2.55.0.1082.g2b9226bbc0-goog


