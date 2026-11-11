Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B705606A883
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=oSYIS3qt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyr34Wjyz3bt9;
	Thu, 12 Nov 2026 09:29:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794436179;
	cv=none; b=ThJCEe1SNx8R5YPiwz4ZzHTrtIDBjCAKEzYGJqAieSCKJ3NVrx/xcyqevgPbpeMscU+upWAkstPWxK6dESMn7QSX4NxymLtajSeGrnLZKLC99U/Bfrq8ZX5Z4iI3nUN2p/h39676FxTdTEpjSQolcouXbdXmcmTvNy7NEj/KdN612uc+s1eq7w0K+HHOM3ZGjqyCrjLdr9/JKcbdBP0flJP2KnevEx7O8wrJ+lCX0nlalTygGYosHRtPIBIEmvDe0zGiN2z78tPs/JG1F8uN6mvtRMN1UTq626qiMuW6BwW2F/zaMzFHHuYMYpfL70Q5twwJvGjvtToVjajPHjevqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794436179; c=relaxed/relaxed;
	bh=/4oURmAxtdLzwOmlIkuFexz35TYtLyT7OPag22iURQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGgarzQLnWL8ko2CZHxtSaZ9iuDoEaBeQED2DRg73+mzT4mbUWojMaE77onmupyshlMz4E5O5adq17yccG9GG5esLpAZCdaFaMEQ5DXKYksHNpcQCgZJJiTl4esWNoxUJ6QgvurhxDl2qlzBSlwTekrYYulN17+YKABFC4+YqHebuXxMwNLq4BOtNTsTaYYwEBW3izIK6ZXgtFqUu65URJfi0HJVqYZNa5wMzh9OkUAZsHC+d5PBMLxnmEYpLY/RhoHusEMEYgXaGMqrUW+8FSvdi6Nz9g5c6Uo/QrUpMmImYGFC4ndwFQ66oKS3ZnBI9i8SchcMSsRslvCPIEjcVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=oSYIS3qt; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+abad5507353db368323c+8480+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=oSYIS3qt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+abad5507353db368323c+8480+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyqj2HJkz2yYY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:29:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/4oURmAxtdLzwOmlIkuFexz35TYtLyT7OPag22iURQs=; b=oSYIS3qt2o+qaxk7+Ax/IMqAJu
	RIdXcgqZmR4rTHiEzQq+OpnllgOOrzxl0Vv7vKpbtFHpKguQghkHJsn1qcTjTT/i63pZaF1QbndNr
	mMSYrKVSdS8Bl69f64aKWkTbFhEdg1EilfOegU5l17Hcv51F2jknDzI+QN+MgXm0yo6GrYH6O4lol
	pmOXVMn369QeFQ+qLe8/cmj4O8RlKQpsPDNtMrHx2WueaNeiol/bXH4RZDHZu3W0cqWQQlx/7ZrOg
	oFZStZjJlpdMwCE2fji6c4nRQW9gfyTdfUZXGap1hJIyhU8afZ5QYh4ebFQDyeC/PnUFfbtw3VuCW
	T9VdSJ/w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRGoa-0000000G3nx-11mM;
	Wed, 11 Nov 2026 22:29:12 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRGoa-0000000008S-098c;
	Wed, 11 Nov 2026 22:29:12 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
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
	joerg.roedel@amd.com,
	Mushahid Hussain <hmushi@amazon.co.uk>,
	Sriram Nambakam <snambakam@linux.microsoft.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 10/16] KVM: planes: Keep current_vcpu in sync in vcpu_load()
Date: Wed, 11 Nov 2026 14:29:05 -0800
Message-ID: <20261111222911.477-11-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111222911.477-1-dwmw2@infradead.org>
References: <20260608144252.351443-1-joro@8bytes.org>
 <20261111222911.477-1-dwmw2@infradead.org>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Woodhouse <dwmw@amazon.co.uk>

The preempt notifiers save and restore common->current_vcpu
(kvm_sched_out()/kvm_sched_in()), but vcpu_load() does not update it.

An ioctl on a plane-N fd loads that plane's vCPU while current_vcpu
may still name the plane that ran last. A reschedule inside the ioctl
then arch-puts the stale twin, whose state is not resident, and
arch-loads it back over the state the ioctl made resident: on VMX the
ioctl's VMCS writes land in the other plane's VMCS, and the trailing
vcpu_put() unloads a non-resident vCPU, corrupting the per-pCPU
loaded_vmcs tracking. The kick paths read current_vcpu->cpu too, and
the next patch, which swaps each twin in around its update after
KVM_SET_CPUID2, relies on the loaded vCPU being the one the preempt
notifiers see.

Set common->current_vcpu in vcpu_load(), so every load path (the run
loop and vCPU ioctls on any plane's fd) agrees with what the preempt
notifiers will operate on. kvm_vcpu_select_plane() keeps its own
assignment; both stores use WRITE_ONCE() to pair with the lock-free
readers in the kick paths.

That makes twin creation a writer as well: kvm_arch_vcpu_create()
calls vcpu_load() on the new twin while its plane-0 twin may be in
KVM_RUN on another pCPU, and the shared preempt notifier would be
registered twice. Hold the shared vCPU mutex across creation of a
non-zero plane's vCPU, from before kvm_arch_vcpu_create() to the end,
including the error-path kvm_arch_vcpu_destroy(), which can
vcpu_load() too (nested_vmx_free_vcpu()). Since vcpu_put() leaves
current_vcpu naming the new twin, put back the twin that owned it once
the arch code returns, on success and on every failure path; otherwise
a failed creation (create_vcpu_fd() can be made to fail with
RLIMIT_NOFILE) frees a vCPU that the lock-free kick paths still
dereference.

Found by a local Sashiko review.

Fixes the current_vcpu tracking in "kvm: Move VCPU scheduling state to
struct kvm_vcpu_common".

Fixes: https://lore.kernel.org/all/20260608144252.351443-16-joro@8bytes.org/
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 virt/kvm/kvm_main.c | 54 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 24d2291b60a2..b6bdbe5c5133 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -174,6 +174,16 @@ void vcpu_load(struct kvm_vcpu *vcpu)
 {
 	int cpu = get_cpu();
 
+	/*
+	 * The preempt notifiers operate on common->current_vcpu, so it
+	 * must name the plane vCPU being loaded here: an ioctl taken on
+	 * another plane's fd than the one that ran last would otherwise
+	 * have a preemption arch-put the stale twin (whose state is not
+	 * resident) and arch-load it back over the state this load makes
+	 * resident.  The kick paths also read it to find the running
+	 * twin's pCPU.
+	 */
+	WRITE_ONCE(vcpu->common->current_vcpu, vcpu);
 	__this_cpu_write(kvm_running_vcpu, vcpu->common);
 	preempt_notifier_register(&vcpu->common->preempt_notifier);
 	kvm_arch_vcpu_load(vcpu, cpu);
@@ -4470,7 +4480,7 @@ static void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 static int kvm_plane_ioctl_create_vcpu(struct kvm_plane *plane, unsigned long id)
 {
 	struct kvm *kvm = plane->kvm;
-	struct kvm_vcpu *vcpu;
+	struct kvm_vcpu *vcpu, *prev = NULL;
 	int r;
 
 	guard(mutex)(&kvm->lock);
@@ -4513,9 +4523,34 @@ static int kvm_plane_ioctl_create_vcpu(struct kvm_plane *plane, unsigned long id
 
 	kvm_vcpu_init(vcpu, kvm, id);
 
+	/*
+	 * A non-zero plane shares 'common' with a plane-0 twin which may
+	 * already be running.  kvm_arch_vcpu_create() calls vcpu_load(),
+	 * which publishes the half-created vCPU through
+	 * common->current_vcpu and registers the shared preempt notifier,
+	 * so it must not run concurrently with a twin's KVM_RUN: hold the
+	 * shared vCPU mutex from here to the end of creation, including
+	 * the error-path kvm_arch_vcpu_destroy(), which can vcpu_load()
+	 * too (nested VMX teardown).  It nests inside the kvm->lock held
+	 * for all of vCPU creation, the usual kvm->lock -> vcpu mutex order.
+	 *
+	 * vcpu_put() leaves current_vcpu naming the new twin; put back
+	 * the twin that owned it, so that the lock-free kick paths never
+	 * see a vCPU that is not reachable yet, or that a failed creation
+	 * frees.
+	 */
+	if (plane->level > 0) {
+		r = mutex_lock_killable(kvm_vcpu_mutex(vcpu));
+		if (r)
+			goto vcpu_free_common;
+		prev = vcpu->common->current_vcpu;
+	}
+
 	r = kvm_arch_vcpu_create(vcpu);
+	if (plane->level > 0)
+		WRITE_ONCE(vcpu->common->current_vcpu, prev);
 	if (r)
-		goto vcpu_free_common;
+		goto unlock_vcpu_free_common;
 
 	/*
 	 * Set the vCPU's index *before* the vCPU is reachable by other tasks.
@@ -4534,9 +4569,10 @@ static int kvm_plane_ioctl_create_vcpu(struct kvm_plane *plane, unsigned long id
 	 * visible (per online_vcpus), e.g. so that KVM doesn't get tricked
 	 * into a NULL-pointer dereference because KVM thinks the _current_
 	 * vCPU doesn't exist.  As a bonus, taking vcpu->mutex ensures lockdep
-	 * knows it's taken *inside* kvm->lock.
+	 * knows it's taken *inside* kvm->lock.  A twin holds it already.
 	 */
-	kvm_vcpu_lock(vcpu);
+	if (!plane->level)
+		kvm_vcpu_lock(vcpu);
 	kvm_get_kvm(kvm);
 	r = create_vcpu_fd(vcpu);
 	if (r < 0)
@@ -4550,12 +4586,18 @@ static int kvm_plane_ioctl_create_vcpu(struct kvm_plane *plane, unsigned long id
 	return r;
 
 kvm_put_xa_erase:
-	kvm_vcpu_unlock(vcpu);
+	if (!plane->level)
+		kvm_vcpu_unlock(vcpu);
 	kvm_put_kvm_no_destroy(kvm);
 	xa_erase(&plane->vcpu_array, vcpu->vcpu_idx);
 unlock_vcpu_destroy:
 	vcpu->vcpu_idx = -1;
 	kvm_arch_vcpu_destroy(vcpu);
+	if (plane->level > 0)
+		WRITE_ONCE(vcpu->common->current_vcpu, prev);
+unlock_vcpu_free_common:
+	if (plane->level > 0)
+		kvm_vcpu_unlock(vcpu);
 vcpu_free_common:
 	kvm_vcpu_common_destroy(vcpu);
 vcpu_free:
@@ -5136,7 +5178,7 @@ struct kvm_vcpu *kvm_vcpu_select_plane(struct kvm_vcpu *vcpu)
 		ret->plane_state = RUNNABLE;
 	}
 
-	common->current_vcpu = ret;
+	WRITE_ONCE(common->current_vcpu, ret);
 
 	common->plane_switch = false;
 
-- 
2.50.1


