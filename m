Return-Path: <linuxppc-dev+bounces-27869-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06187C982F8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 17:45:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpVx338vJz30WF;
	Tue, 22 Sep 2026 03:44:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::447"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790012695;
	cv=none; b=W+yBwX8U8mSKssW/80YYkl6TLVMf9w8/i60pmFBlDOrlY9rHba9TcElSsocDzcGTfQYHlHRnUsKeJ441WnNHalZQU+M8+r1M3nrbOLz46i+XO/PyLDllfCQcx958B/Y+4kB9sp19JY2j/YmshYyQSWvzmjcilFuvhIiVT1uHkNjjdCD/d82kY5DMtIMyIfJG/1bYq1T/nJB5Js279sKPJ4fZbSO+gSxsohF9mMrkuJ2Lq+4LtUqnubdpBdJ3oR8+EOQzYXvLZtnuWT1HnIsOZ4jV4cE/7b8b7gLFYyxQ/u/wmVR1TkJ9IC5NuZBI3CtSzdHx+XiPUViUg1bOTwTYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790012695; c=relaxed/relaxed;
	bh=qeiicXWgTPk3n7JADXXm7zikz8BknOrQz3jHJRoDF6U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=izRF2MptFuGWhdXc0EYmcXF80lPA/I50U6DsU9qI1Ewtx6s/hTAdOI5KN9mf41IL438WIud4ThPijw1/RWhkr0GSA8ty3OfH5YTwIFXNSGGgi7dqCIdAgjnAhGwvpPyKbEr6Jn8cG172SdaWQNhXlMHb9IzrOlV7pnom/RVDxytyK3g2PVZgKNJN6gI7gNpEBfjeHggHLcMceCB2IMWvlWillR5PnbvwVCTZVRl0CIquyHQLHID7Vavxy1GedM3vEUEAKB8RE46WafQG+FFq0J15vfpF4DrYRZ6KfP5/2WMUNUhV5WMn1Y1VA0+h5cs57qeR4iA2IEpwruS9414cjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wK+Stexc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::447; helo=mail-pf1-x447.google.com; envelope-from=3e22xagykdba8uq3zsw44w1u.s421y3ad55s-tub1y898.4f1qr8.47w@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wK+Stexc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::447; helo=mail-pf1-x447.google.com; envelope-from=3e22xagykdba8uq3zsw44w1u.s421y3ad55s-tub1y898.4f1qr8.47w@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x447.google.com (mail-pf1-x447.google.com [IPv6:2607:f8b0:4864:20::447])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpVx22jzfz30VF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 03:44:54 +1000 (AEST)
Received: by mail-pf1-x447.google.com with SMTP id d2e1a72fcca58-8710450f731so3224064b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 10:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790012692; x=1790617492; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qeiicXWgTPk3n7JADXXm7zikz8BknOrQz3jHJRoDF6U=;
        b=wK+StexcZARUZl2bgfbwOgsGA/V5k05B+txpFeTHz4Njhp+U1exuoR4rYceI3VLv8V
         1mYULsvwZ8bC+edpUg93+EWUnkuS5tHDq9shHF2AT7c2xuGxGS6ZMsHzcqV0SYDjfwYu
         +9Bs6Sy26ktMAyoCgXfGU5WcuKNShhx+RakfetKT8oXGShJJTHxzQEuYvbrIwF2+/0+M
         tBU9mvd/T194AnWqbVCfNR0wGdbCawX0xzifabe9baKhiObWgPzTlDnMA5pX8Vq2C2FN
         Brj6VW8SUcf/IRuE5BEePJvEH2yyPCHZ1BI6fx7eudRG43jWqYG5ci3y94YrQv7fVh0X
         DfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012692; x=1790617492;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qeiicXWgTPk3n7JADXXm7zikz8BknOrQz3jHJRoDF6U=;
        b=vt1SZp16McNk1x4PQN8Y52XFQEzokHHV/PgqR99ASTTvx5+MInSaWaS1MR0+tPB692
         aZSk6IfmtRb7k5sroQ5D7ZUR+Rz2UCEodohzi3PXl90X/tPhNCscdpcHjO9buoxve+9o
         9NKFV4TpGj5sZEp5veCK+LUbvwwkPomDdtgFDIJqJJpexmmlMWLD+DbqnTvWwp6a9cWz
         +FEfZoRclFxlHjMr1QJubclSZPCOQL5eVKDPR1er8D8HfB2Onbk/QcQefBIlMenekcht
         HxvWo06aHAW9ZEv1q50VAj/rX9zYtVO8ihBI5SBMwUDhyiCKh3Dus85BgzcoxaqswdjC
         Jy1w==
X-Forwarded-Encrypted: i=1; AKwUvBxZJ7eil98aap84nm4ZMXoReZrOzzQVD6XwVTJJT0d5mQ2opXR+gJhtLpbJxywxlkkHxWx49I34ywCaY+I=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mecAkvhWmOnXu5DPWZ55oKbTcz1q06596ThJ76jF1b8grhxkao
	pD6LDHNLNK++NofmhNnXvbHBYANZr3mJn5PwfQ6kHZWYsf+krDHIvHOO30TGJ3prDtpfuWWFBcZ
	Cy1qhhw==
X-Received: from pfw3.prod.google.com ([2002:a05:6a00:a263:b0:879:1348:bebf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1f06:b0:857:727c:a1f1
 with SMTP id d2e1a72fcca58-874dddfa3acmr14506041b3a.19.1790012691865; Mon, 21
 Sep 2026 10:44:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 10:44:42 -0700
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
Message-ID: <20260921174445.911676-5-seanjc@google.com>
Subject: [PATCH v2 4/7] KVM: Protect all of kvm_vm_ioctl_create_vcpu() with kvm->lock
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

When creating a vCPU, don't drop kvm->lock to when doing the bulk of actual
vCPU creation, as allowing multiple vCPUs to be created in parallel adds
significant complexity in KVM (as evidenced by the many related bugs), and
all known VMMs fully serialize vCPU creation.  Remove all manually locking
of kvm->lock from kvm_arch_vcpu_{post,}create() for obvious reasons.

For many years, "everyone" has assumed that dropping kvm->lock was done for
performance reasons optimization, e.g. to allow userspace to create all
vCPUs concurrently for latency purposes.  But as above, no known VMM does
that.  Looking at the history of this code, before commit 11ec28047118
("KVM: Convert vm lock to a mutex"), kvm->lock was a spinlock.  I.e. KVM
*had* to drop kvm->lock when doing the bulk of vCPU creation, otherwise KVM
couldn't do normal memory allocations.  When kvm->lock got turned into a
mutex for unrelated reasons, no one took advantage updated of the change to
simplify vCPU creation.  And 19 years later, everyone just assumed that KVM
continued to deal with the complexity for performance reasons.

Furthermore, naively parallelizing vCPU creation in userspace is likely a
net negative due to the overheads of task creation.  Unless a VMM carefully
avoids the extra overhead related to parallelization, e.g. spawns each
vCPU's thread before creating the vCPU, creating vCPUs concurrently is a
net *negative* up until about ~64 vCPUs, after which the times are a wash.

The absolute speed of light _is_ faster if KVM doesn't hold kvm-lock, but
at vCPU counts of ~16 or less, it's probably in the noise when considering
total VM creation time, as the added latency is less than 1ms up until 16
or so vCPUs.

On top of all that, KVM has had a *lot* of fatal bugs (most often found by
syzkaller) related to vCPUs being created while trying to do per-VM
operations (basically, see every flow that locks all vCPUs).  I.e. the
parallel vCPU creation "support" is actively harmful as the only "use case"
is for misbehaving userspace to exploit KVM bugs.

Serializing vCPU creation will allow reverting commit 97d65b544f48 ("KVM:
Check for duplicate vcpu_id as early as possible"), which had "minor" math
error: the worst case scenario isn't "256 bytes per VM", it's "256 unsigned
longs per VM", i.e. 2048 bytes per VM, which doubles the size of each VM
and pushes several architectures into order-1 allocations.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/book3s_hv.c |  2 --
 arch/s390/kvm/s390/s390.c    |  5 +----
 virt/kvm/kvm_main.c          | 22 +++++-----------------
 3 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 0409ac9e7b31..30f7095a156e 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3058,7 +3058,6 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 
 	init_waitqueue_head(&vcpu->arch.cpu_run);
 
-	mutex_lock(&kvm->lock);
 	vcore = NULL;
 	err = -EINVAL;
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
@@ -3091,7 +3090,6 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 			mutex_unlock(&kvm->arch.mmu_setup_lock);
 		}
 	}
-	mutex_unlock(&kvm->lock);
 
 	if (!vcore)
 		return err;
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index eca4a4359ab2..cc628afbb850 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -3579,12 +3579,11 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
-	mutex_lock(&vcpu->kvm->lock);
 	preempt_disable();
 	vcpu->arch.sie_block->epoch = vcpu->kvm->arch.epoch;
 	vcpu->arch.sie_block->epdx = vcpu->kvm->arch.epdx;
 	preempt_enable();
-	mutex_unlock(&vcpu->kvm->lock);
+
 	if (!kvm_is_ucontrol(vcpu->kvm)) {
 		vcpu->arch.gmap = vcpu->kvm->arch.gmap;
 		sca_add_vcpu(vcpu);
@@ -3757,13 +3756,11 @@ static int kvm_s390_vcpu_setup(struct kvm_vcpu *vcpu)
 
 	kvm_s390_vcpu_pci_setup(vcpu);
 
-	mutex_lock(&vcpu->kvm->lock);
 	if (kvm_s390_pv_is_protected(vcpu->kvm)) {
 		rc = kvm_s390_pv_create_cpu(vcpu, &uvrc, &uvrrc);
 		if (rc)
 			kvm_s390_vcpu_unsetup_cmma(vcpu);
 	}
-	mutex_unlock(&vcpu->kvm->lock);
 
 	return rc;
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 78cc090435be..c17cc8dd371b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4165,6 +4165,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	struct kvm_vcpu *vcpu;
 	struct page *page;
 
+	guard(mutex)(&kvm->lock);
+
 	/*
 	 * KVM tracks vCPU IDs as 'int', be kind to userspace and reject
 	 * too-large values instead of silently truncating.
@@ -4177,26 +4179,18 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	if (id >= KVM_MAX_VCPU_IDS)
 		return -EINVAL;
 
-	mutex_lock(&kvm->lock);
-	if (kvm->created_vcpus >= kvm->max_vcpus) {
-		mutex_unlock(&kvm->lock);
+	if (kvm->created_vcpus >= kvm->max_vcpus)
 		return -EINVAL;
-	}
 
-	if (test_bit(id, kvm->vcpu_ids)) {
-		mutex_unlock(&kvm->lock);
+	if (test_bit(id, kvm->vcpu_ids))
 		return -EEXIST;
-	}
 
 	r = kvm_arch_vcpu_precreate(kvm, id);
-	if (r) {
-		mutex_unlock(&kvm->lock);
+	if (r)
 		return r;
-	}
 
 	kvm->created_vcpus++;
 	__set_bit(id, kvm->vcpu_ids);
-	mutex_unlock(&kvm->lock);
 
 	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL_ACCOUNT);
 	if (!vcpu) {
@@ -4227,8 +4221,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 			goto arch_vcpu_destroy;
 	}
 
-	mutex_lock(&kvm->lock);
-
 	if (WARN_ON_ONCE(kvm_get_vcpu_by_id(kvm, id))) {
 		r = -EEXIST;
 		goto unlock_vcpu_destroy;
@@ -4267,7 +4259,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	atomic_inc(&kvm->online_vcpus);
 	mutex_unlock(&vcpu->mutex);
 
-	mutex_unlock(&kvm->lock);
 	kvm_arch_vcpu_postcreate(vcpu);
 	kvm_create_vcpu_debugfs(vcpu);
 	return r;
@@ -4278,7 +4269,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	xa_erase(&kvm->vcpu_array, vcpu->vcpu_idx);
 unlock_vcpu_destroy:
 	vcpu->vcpu_idx = -1;
-	mutex_unlock(&kvm->lock);
 	kvm_dirty_ring_free(&vcpu->dirty_ring);
 arch_vcpu_destroy:
 	kvm_arch_vcpu_destroy(vcpu);
@@ -4287,10 +4277,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 vcpu_free:
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 vcpu_decrement:
-	mutex_lock(&kvm->lock);
 	kvm->created_vcpus--;
 	__clear_bit(id, kvm->vcpu_ids);
-	mutex_unlock(&kvm->lock);
 	return r;
 }
 
-- 
2.55.0.1082.g2b9226bbc0-goog


