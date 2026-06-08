Return-Path: <linuxppc-dev+bounces-22210-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCCFCD8C9F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:52:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4B2T34z3bpG;
	Tue, 09 Jun 2026 00:52:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930330;
	cv=none; b=VPY5n6oOMvlqGb5IxcV3MY5/foKYC2sJEKWtSmAL/+/uScBuNqsaZAgohAlr+fa3M3Bcn26rKXZl7VJWq7iobo5ACQjv6IkQDMnCbQ8rgbZYq8teqKj0n3bhzn3NJkV15OOrgAfUFk8PJHsOVCNAqAU6ALRftGphktY3gwQzt78xlj8GnahWpF+yEyUzTfr+aL2+CkKilFP+nNjuIY8crxEG04PjKIApV4q14cFPINTYEA3aej/b5ikGAkU0j0pmf3vI9GTZeJXHqZvDBYC3Ib/UvqJjnEViSVaAmpoYczsYGVHU/KOMSsS+96jUcLd2aWkvPFLzMFQaKtf2wRLhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930330; c=relaxed/relaxed;
	bh=GK3GGE9DhTl+C9mVcDok7LIpbBsR+s/tVCtGWQo3hTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkbUx0oGip2uXoU6MDlZ5le931HM94Igdvm/jQGQ0/iPW26CkvANSwZZr518K6IxhNA3GVQULPDNspJSwVgsca26xhFziiZ/znzC+InjRcmtIHmbxkUmK19VvhlMhKWqq5VS42ijhkWERgU3KiVYdiOQUqg/aAVHJAkHkrRT8lEnnPw0khLCjdXZB8ye/F0e/4G8fw77jY1/Tk5Vyfe7iiHpRHf2tPnRpArWErZ7H8XDq2uooilI+QOz3IZjMV/j2y0Qnlb1fE/3pTjk2X2ZQ+oZu8EtBh/ekwwqDAI1CW4F8T0Zt8Osre+ihnzw7A8YE7kLQaEsDOFtullzcuCi3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw483Xytz2ytV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:07 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id BF5B22028B8;
	Mon,  8 Jun 2026 16:43:09 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	nsaenz@amazon.com,
	anelkz@amazon.de,
	James.Bottomley@HansenPartnership.com,
	Melody Wang <huibo.wang@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	x86@kernel.org,
	coconut-svsm@lists.linux.dev,
	joerg.roedel@amd.com
Subject: [PATCH 22/60] kvm: Move kvm_vcpu pid members to struct kvm_vcpu_common
Date: Mon,  8 Jun 2026 16:42:14 +0200
Message-ID: <20260608144252.351443-23-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608144252.351443-1-joro@8bytes.org>
References: <20260608144252.351443-1-joro@8bytes.org>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

These are the same across all planes for one VCPU, so make then
shared.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/kvm/arm.c              |  2 +-
 include/linux/kvm_host.h          |  5 ++--
 virt/kvm/kvm_main.c               | 44 ++++++++++++++++---------------
 4 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a49042bfa801..32dc484781f0 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1270,7 +1270,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 void kvm_arm_halt_guest(struct kvm *kvm);
 void kvm_arm_resume_guest(struct kvm *kvm);
 
-#define vcpu_has_run_once(vcpu)	(!!READ_ONCE((vcpu)->pid))
+#define vcpu_has_run_once(vcpu)	(!!READ_ONCE((vcpu)->common->pid))
 
 #ifndef __KVM_NVHE_HYPERVISOR__
 #define kvm_call_hyp_nvhe(f, ...)						\
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 001f83f737ea..1e2f42134b74 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -726,7 +726,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (!cpumask_test_cpu(cpu, vcpu->kvm->arch.supported_cpus))
 		vcpu_set_on_unsupported_cpu(vcpu);
 
-	vcpu->arch.pid = pid_nr(vcpu->pid);
+	vcpu->arch.pid = pid_nr(vcpu->common->pid);
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3c72a462ccfa..73786712495d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -346,6 +346,9 @@ struct kvm_vcpu_common {
 	int mode;
 	u64 requests;
 
+	struct pid *pid;
+	rwlock_t pid_lock;
+
 	/* Scheduling state */
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	struct preempt_notifier preempt_notifier;
@@ -368,8 +371,6 @@ struct kvm_vcpu {
 
 	struct kvm_run *run;
 
-	struct pid *pid;
-	rwlock_t pid_lock;
 	int sigset_active;
 	sigset_t sigset;
 	unsigned int halt_poll_ns;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7ea20d96bc89..af3c4e0081b8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -475,6 +475,9 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned
 	common->kvm = kvm;
 	common->current_vcpu = vcpu;
 
+	common->pid = NULL;
+	rwlock_init(&common->pid_lock);
+
 	common->wants_to_run = false;
 	common->preempted = false;
 	common->ready = false;
@@ -510,8 +513,6 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	vcpu->kvm = kvm;
 	vcpu->plane = kvm->planes[0];
 	vcpu->vcpu_id = id;
-	vcpu->pid = NULL;
-	rwlock_init(&vcpu->pid_lock);
 	kvm_async_pf_vcpu_init(vcpu);
 
 	kvm_vcpu_set_in_spin_loop(vcpu, false);
@@ -539,6 +540,12 @@ static void kvm_vcpu_common_destroy(struct kvm_vcpu *vcpu)
 	kvm->created_vcpus--;
 	mutex_unlock(&common->kvm->lock);
 
+	/*
+	 * No need for rcu_read_lock as VCPU_RUN is the only place that changes
+	 * the common->pid pointer, and at destruction time all file descriptors
+	 * are already gone.
+	 */
+	put_pid(common->pid);
 	kfree(common);
 }
 
@@ -549,13 +556,6 @@ static void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_vcpu_common_destroy(vcpu);
 	kvm_dirty_ring_free(&vcpu->dirty_ring);
 
-	/*
-	 * No need for rcu_read_lock as VCPU_RUN is the only place that changes
-	 * the vcpu->pid pointer, and at destruction time all file descriptors
-	 * are already gone.
-	 */
-	put_pid(vcpu->pid);
-
 	free_page((unsigned long)vcpu->run);
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
@@ -3996,16 +3996,17 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_vcpu_kick);
 
 int kvm_vcpu_yield_to(struct kvm_vcpu *target)
 {
+	struct kvm_vcpu_common *common = target->common;
 	struct task_struct *task = NULL;
 	int ret;
 
-	if (!read_trylock(&target->pid_lock))
+	if (!read_trylock(&common->pid_lock))
 		return 0;
 
-	if (target->pid)
-		task = get_pid_task(target->pid, PIDTYPE_PID);
+	if (common->pid)
+		task = get_pid_task(common->pid, PIDTYPE_PID);
 
-	read_unlock(&target->pid_lock);
+	read_unlock(&common->pid_lock);
 
 	if (!task)
 		return 0;
@@ -4258,9 +4259,9 @@ static int vcpu_get_pid(void *data, u64 *val)
 {
 	struct kvm_vcpu *vcpu = data;
 
-	read_lock(&vcpu->pid_lock);
-	*val = pid_nr(vcpu->pid);
-	read_unlock(&vcpu->pid_lock);
+	read_lock(&vcpu->common->pid_lock);
+	*val = pid_nr(vcpu->common->pid);
+	read_unlock(&vcpu->common->pid_lock);
 	return 0;
 }
 
@@ -4558,6 +4559,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		return -EINTR;
 	switch (ioctl) {
 	case KVM_RUN: {
+		struct kvm_vcpu_common *common = vcpu->common;
 		struct pid *oldpid;
 		r = -EINVAL;
 		if (arg)
@@ -4569,7 +4571,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		 * read vcpu->pid while this vCPU is in KVM_RUN, e.g. to yield
 		 * directly to this vCPU
 		 */
-		oldpid = vcpu->pid;
+		oldpid = common->pid;
 		if (unlikely(oldpid != task_pid(current))) {
 			/* The thread running this VCPU changed. */
 			struct pid *newpid;
@@ -4579,15 +4581,15 @@ static long kvm_vcpu_ioctl(struct file *filp,
 				break;
 
 			newpid = get_task_pid(current, PIDTYPE_PID);
-			write_lock(&vcpu->pid_lock);
-			vcpu->pid = newpid;
-			write_unlock(&vcpu->pid_lock);
+			write_lock(&common->pid_lock);
+			common->pid = newpid;
+			write_unlock(&common->pid_lock);
 
 			put_pid(oldpid);
 		}
 		vcpu->common->wants_to_run = !READ_ONCE(vcpu->run->immediate_exit__unsafe);
 		r = kvm_arch_vcpu_ioctl_run(vcpu);
-		vcpu->common->wants_to_run = false;
+		common->wants_to_run = false;
 
 		/*
 		 * FIXME: Remove this hack once all KVM architectures
-- 
2.53.0


