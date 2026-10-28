Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6F260A2626
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hbd4EZly
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFGwH0Tqpz30T9;
	Thu, 29 Oct 2026 06:03:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793214191;
	cv=none; b=T0XH6WvyPGY6ykfaAE/9o2wGXAkcCAsCm0IvHFNKNWpFsfrg81oVu15sLaW0B+MKA7luepcd7bkfGYxCc1O/FVwmx/mBlm2WpWeh6zJ/gHlyiHQj4XwIqL5bWcOoc6o32cemQ8Kxq/cRyWNak10Q3+QvnbQItaC8dHMe8G5nj81dN9/hGY74i1FfvVVd05LWQJEq1T7Px/RrX9Icmu/kVpd7v9sRdPvqDRG4XkvDpSGr+xv73XN7YOf3taDMutK+QJ/mO/XUOA+nlR36kpJOmrGF+1/Clc+ZX18N+mFKpyZn/9a0lMQoh7+l/shZRAOIbQpCNehU4X0U34xiuJ4c+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793214191; c=relaxed/relaxed;
	bh=Sl+Mk8tjT6q271G5BWlaeNMAilxi46BFejIwHYIwO+I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NAAphrFCwSv7/oPMYyITVJpNgSBLwqsKM16aY2+VgPBsn/DCNWMuy4gniP1xFs+tSkMuElyRiLhWD7SbiiG4lWOAkchVSUn1WrroR27clnvB1SmRJ93Er1laxFcW3rjjrz79cjS1oc3xXkotnZXsj/5kFZKhXiHdu4Ap91fKZPiTAGeWg10gXyBQMGkLgz3yyOmL5oDogYRp74EpwwplFWV+DCabSYfSOuoKiET8zqjSpbFCyCB3ZZhzDc58woJtaFziH5bhuDq4O2DdoX3l+rSjKqdtG203N//Bk0CnYZ99Jq/MKJfx8SMOzfFBkj+9Iebpwfu/oNAhA+rjcqgY5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hbd4EZly; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=37ebiagykdgerd9mibfnnfkd.bnlkhmtwoob-cdukhrsr.nyk9ar.nqf@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hbd4EZly;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=37ebiagykdgerd9mibfnnfkd.bnlkhmtwoob-cdukhrsr.nyk9ar.nqf@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com [IPv6:2607:f8b0:4864:20::647])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFGwG1X1Pz30VF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 06:03:10 +1100 (AEDT)
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2e93f266d20so17329955ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 12:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793214188; x=1793818988; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Sl+Mk8tjT6q271G5BWlaeNMAilxi46BFejIwHYIwO+I=;
        b=hbd4EZlyqnBZK5POtbWaY/xdGsoTpMS4USZLeqJ4Jq1BnMjb5U9FMHhTVvl2XdApZC
         AuUxsR1i2OXhcqX6RD9joOqBIoZeesVPbLM7IfVoBekst9FNkBSajKg8Ypuy+y9Uakm9
         OHk04pZo1N2lLTlFvZpfQ0XPEhRsehfT8NhlpBHLnPEHlUUBEqIenJbAKg8IPjZqJp/v
         Ps3d2vhVWz6rmYI+7aYd1nRbh86473W6WtsIrW88BNh1/u5N9DDr2PfBByiHsQmtoMJq
         JC4I1+SWAnNihi5gIUHU5JRL1W9L/IxLIvrplYLEwAqJP1ET+4LIAxU93XKtq2DFGO8m
         xZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214188; x=1793818988;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sl+Mk8tjT6q271G5BWlaeNMAilxi46BFejIwHYIwO+I=;
        b=a8AUOM3f8Ybuev3LiIUw1g6neV7I8PRDo/nu++lDsHzeu7OQ33q+c0b3hL6XMX8EoH
         I5l4nmhZJ/DgjHmIr3Qn01zOvQ8Ve/Avgh7gVS5Ceyex20ktfa7iNcQL5U2fE1nN3/3f
         FydpD2YNIqjQbbwCzWI+sf6/Auuk2KDut7PZLsM/PMVMYlhPrtRa0zQnljZKqF0aH1tD
         HuQOrZHGKsDtuPvXalLKD1vtgKkH+wKI0Q0Z8t0vjtbbdCYrVRKl5BsQ3h2ZoKYNIq/y
         13VFArWZ6PBuyPbs9jasWbnaDhNx7GIUA98I14YSlkuHfcZxG0A/rQr5ROF2QcKzF8ZQ
         iYTg==
X-Forwarded-Encrypted: i=1; AKwUvBxcWN6+HqlC32vGIVfLzC/Rkky8PxhmFNOhIdBGAZQDX8Q0RwrEAt58sMkCo8B/7wxOOGsWZQpnth9lbrk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK8XDR/c1MlVUhQfE1ZlSpZgCPmst+Os12IvxqfhC2xuFVB3dIN
	ozYyZxENVdTrxoOStpgFn/ihrfhNM3aNGLbaqHFF6QWtL3gstXJU+NjkjV2zy5ePSI0qWs1AW0q
	toxAwuw==
X-Received: from plic8.prod.google.com ([2002:a17:903:3708:b0:2e8:4252:d40c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:40c9:b0:2cc:6018:f030
 with SMTP id d9443c01a7336-2eb0033e60cmr28999775ad.14.1793214188023; Wed, 28
 Oct 2026 12:03:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 12:02:57 -0700
In-Reply-To: <20261028190259.1819571-1-seanjc@google.com>
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
References: <20261028190259.1819571-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028190259.1819571-6-seanjc@google.com>
Subject: [PATCH 5/7] KVM: Move kvm_arch_vcpu_should_kick() to common code as kvm_vcpu_should_kick()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dedup kvm_arch_vcpu_should_kick() now that all architectures except for PPC
have identical implementations.  PPC's implementation is unreachable as PPC
always invokes __kvm_vcpu_kick() with @force=true.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/arm.c       |  5 -----
 arch/loongarch/kvm/vcpu.c  |  5 -----
 arch/mips/kvm/mips.c       |  5 -----
 arch/powerpc/kvm/powerpc.c |  5 -----
 arch/riscv/kvm/vcpu.c      |  5 -----
 arch/x86/kvm/x86.c         |  5 -----
 include/linux/kvm_host.h   |  1 -
 virt/kvm/kvm_main.c        | 11 ++++++++---
 8 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 775d11f96813..99d540d67b5b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -128,11 +128,6 @@ bool is_kvm_arm_initialised(void)
 	return kvm_arm_initialised;
 }
 
-int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
-{
-	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
-}
-
 int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			    struct kvm_enable_cap *cap)
 {
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 4026b9bf9f2d..76afd386abd2 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -379,11 +379,6 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 		vcpu->arch.mp_state.mp_state == KVM_MP_STATE_RUNNABLE;
 }
 
-int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
-{
-	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
-}
-
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 {
 	unsigned long val;
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index c37e212bc0a3..273dd932d119 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -120,11 +120,6 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 	return false;
 }
 
-int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
-{
-	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
-}
-
 int kvm_arch_enable_virtualization_cpu(void)
 {
 	return kvm_mips_callbacks->enable_virtualization_cpu();
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 09c94b849185..ac259fcd85c2 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -62,11 +62,6 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 	return false;
 }
 
-int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
-{
-	return 1;
-}
-
 /*
  * Common checks before entering the guest world.  Call with interrupts
  * enabled.
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index dd786f758eb7..3981ba39ffc2 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -239,11 +239,6 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 		!kvm_riscv_vcpu_stopped(vcpu) && !vcpu->arch.pause);
 }
 
-int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
-{
-	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
-}
-
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 {
 	return (vcpu->arch.guest_context.sstatus & SR_SPP) ? true : false;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba9..d9fa2690153a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10472,11 +10472,6 @@ unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
 	return kvm_rip_read(vcpu);
 }
 
-int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
-{
-	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
-}
-
 static inline u32 kvm_async_pf_hash_fn(gfn_t gfn)
 {
 	BUILD_BUG_ON(!is_power_of_2(ASYNC_PF_PER_VCPU));
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3b9844c3906d..9db42f58c561 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1694,7 +1694,6 @@ void kvm_arch_disable_virtualization_cpu(void);
 bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu);
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu);
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu);
-int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu);
 bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu);
 bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu);
 bool kvm_arch_vcpu_preempted_in_kernel(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 67addb9e48a7..e1a9da8b43d7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -191,7 +191,7 @@ void vcpu_put(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(vcpu_put);
 
-/* TODO: merge with kvm_arch_vcpu_should_kick */
+/* TODO: merge with kvm_vcpu_should_kick */
 static bool kvm_request_needs_ipi(struct kvm_vcpu *vcpu, unsigned req)
 {
 	int mode = kvm_vcpu_exiting_guest_mode(vcpu);
@@ -209,6 +209,11 @@ static bool kvm_request_needs_ipi(struct kvm_vcpu *vcpu, unsigned req)
 	return mode == IN_GUEST_MODE;
 }
 
+static int kvm_vcpu_should_kick(struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
+}
+
 static void ack_kick(void *_completed)
 {
 }
@@ -3930,7 +3935,7 @@ void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait, bool force)
 
 	/*
 	 * Note, the vCPU could get migrated to a different pCPU at any point
-	 * after kvm_arch_vcpu_should_kick(), which could result in sending an
+	 * after kvm_vcpu_should_kick(), which could result in sending an
 	 * IPI to the previous pCPU.  But, that's ok because the purpose of the
 	 * IPI is to force the vCPU to leave IN_GUEST_MODE, and migrating the
 	 * vCPU also requires it to leave IN_GUEST_MODE
@@ -3939,7 +3944,7 @@ void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait, bool force)
 	 * check also modifies vcpu->mode and KVM PPC needs to avoid that side
 	 * effect for unknown historical reasons.
 	 */
-	if (force || kvm_arch_vcpu_should_kick(vcpu)) {
+	if (force || kvm_vcpu_should_kick(vcpu)) {
 		cpu = READ_ONCE(vcpu->cpu);
 		if (cpu != me && (unsigned int)cpu < nr_cpu_ids && cpu_online(cpu)) {
 			/*
-- 
2.56.0.313.g2479322e68-goog


