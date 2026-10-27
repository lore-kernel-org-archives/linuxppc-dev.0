Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021A606A31D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UCpHlKeq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDl9F1m2Hz3bgK;
	Wed, 28 Oct 2026 09:12:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793139153;
	cv=none; b=Ks2idO6w6tWZ3ovagtRRjNfsXshX/aEk9kSDLnkxJw10yEmNjfB94SFi7+GcGAp0w7loKs0zlTTQrHPoFji6awMjdyLOUKLs4h6pm/S8lq+6VGv7g9FjBUfxKE6If/+5kG6tKziTZnzjRadqTAUr/ViDtHU993tJny0Y7Kk6+4fuV5qFf4EyycGXQLRmuNwEfugSOqK86CieB5XhaAmcv9oIiz65tZ6Uia9o3xNRGIvlcDVzuXBlcce1iaI+GaQxdLx4Hq4Lj1l/6FmOoYy7j6g3yVcnoxR0s9QsMT+wYmjPYzqPAO3gTSeTj56p4cR8ukrGT1+2Y6rWluVRqOS5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793139153; c=relaxed/relaxed;
	bh=CfieY5T+2+zXN7L+WJxdK99n1brgDAnzfFn1YUPYGik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WW7AQvOqoEgT4rCKt6sqTJTSennygs4KYsEbzYqCK9S2yMfnTKZ5scCpgIRiFztfrCgZ3D1XFs6/vyNlVVR/i1yDMTeT3KdnFZ33zoKRj/hS+eq2LuiwsoUbcM19rUyIRQcx1eW+1elFNQv4IK2pjtZAkMaxirIhKfagnct8Uc+zDKyOsziZnpsxDayybAUj83IOBgRG74o+8IQBx/9i/NWgMQPdWZdwRkZ8e1HCDnWM4CeBiSIOTPPTXQhwAzYkL4jqRQz7mp0rq4G6ShnTpVCJHtw9NH9iTupz6QRpAg+EJhpnzfQg8Wqh8Y+sKFRZqE58MeEIY+EExVngJjIisg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UCpHlKeq; dkim-atps=neutral; spf=pass (client-ip=209.85.216.70; helo=mail-pj1-f70.google.com; envelope-from=3zshhagykdpimyuhdwaiiafy.wigfchorjjw-xypfcmnm.itfuvm.ila@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UCpHlKeq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.216.70; helo=mail-pj1-f70.google.com; envelope-from=3zshhagykdpimyuhdwaiiafy.wigfchorjjw-xypfcmnm.itfuvm.ila@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDl9D1rV4z3bf2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:12:32 +1100 (AEDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab1e771632so1141544a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139149; x=1793743949; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CfieY5T+2+zXN7L+WJxdK99n1brgDAnzfFn1YUPYGik=;
        b=UCpHlKeqTRFZkR/Y6/7fujYTNWY2vEUuY2wYRX9ZlFEBbSNVQ2f6Sqb8HdOOUtH7d+
         JfZsLR8QUkeL861WxAtyzUavVe5cVOApQ8rgljKI6V/AiEFdmQkoAQGotX0zHsXQVzxK
         +mKuRBWDb/fpSsKTg1erEWxqxzEsk2WY7IeEx3VXPpo4K+ar2wG6ilGvy2+JbogZ7Pk0
         71l8/2q/jk5zUba87EWYdgjRU6cFKZ710Al/e45kQ8obk2K4q/Lnl+SyyktkDZPxQ46x
         lnLT4JXak4SU+I1Xjb/mZlRvBLRdWebVOtktza3eFH/8FuLQBw2B7bIWDYRmr4qVzP2h
         AQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139149; x=1793743949;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CfieY5T+2+zXN7L+WJxdK99n1brgDAnzfFn1YUPYGik=;
        b=dfVH/wJ+FhnOWzTT6g6pj0TRklXnvnudo37xjBQjwPPjKC47MKEhCQE11jyiMLr5f3
         E3Uas/ijFdFbVha8OmqpL00ytXrkLCrS/Hm+G5hoCqoneQXKWeCJfUFWxjOBu/CycbhL
         hK//ljLM3Md0XlUvlFnHusAMqzY4JhV5HNl0l7z9ex331qyHXn6xhFvfhpTV4keTaU2M
         KMR7i8UXtR0i+w26g5LiAI22pqkbnZQ1AXEYBiDwpYuOH1US+zjTh7sYA8z/LX4drUo2
         sNOsRWLSW+PQxNdfz+0pw3yyxn76YHZf9T2h645Lr9BG14JK/LU4mOl34a3tVlTUl/H6
         xAlA==
X-Forwarded-Encrypted: i=1; AKwUvBxxg/fV04o6mHfWOncEQMgWwdV4vNcPrJi5H1PRkbnbNlcQvRe+KZB7D8b0itDLDJW/C9+jgemBuOlhQyI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK69ZIuiWnvA6XzAoZAb785YVmddwnARkk1weOKcn4oQSlweOkd
	uuRm7OLQE/NuuuUZwPVLAvkunYBkZqGA+7yDwptv1zHbpnM4CI2mdrHnN6912aWNmp578gPRzV3
	xXW6vpw==
X-Received: from pjdw9.prod.google.com ([2002:a17:90a:15c9:b0:3ac:a379:dc7c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3bc3:b0:3a0:d7f2:5a58
 with SMTP id 98e67ed59e1d1-3ae57e14372mr206675a91.3.1793139149377; Tue, 27
 Oct 2026 15:12:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:06 -0700
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
Message-ID: <20261027221209.1560865-14-seanjc@google.com>
Subject: [PATCH v3 13/15] KVM: VMX: Explicitly remove dying vCPUs from the PI
 wakeup list
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

Explicitly remove dying vCPUs that were blocking when the VM was released
from the Posted Interrupts wakeup list instead of very, very subtly relying
on the vcpu_load() in nested_vmx_free_vcpu() to take the vCPU off said list.
In addition to helping avoid future regressions, e.g. if an enterprising
developer were to optimize nested_vmx_free_vcpu() by bailing early if
"nested" is completely disabled, this will allow dropping the load+put pair
from nested_vmx_free_vcpu().

Provide a dedicated API to remove a vCPU from the wakeup list, i.e. don't
_completely_ abuse vt_vcpu_pi_load(), but do reuse the core logic for
updating the PID control word.  Using a CMPXCHG8B _should_ be unnecessary
as IRQ routing has already been torn down, i.e. no IRTEs should be pointing
at updating the PID, and there are obviously no other references to the VM
or vCPU, and so concurrently modifications of the PID should be impossible.
For the same reasons, updating the destination should also be unnecessary,
as nothing should ever send an IRQ.  However, relying on those assumptions
begs for WARNs to ensure they hold, along with fallback code to avoid the
worst case scenario, at which point trying to take advantage of the fact
that the PID is unreachable would be *more* complex than what is now
__vt_vcpu_pi_load(), not to mention KVM would have two paths to maintain.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 68 +++++++++++++++++++++-------------
 arch/x86/kvm/vmx/posted_intr.h |  1 +
 arch/x86/kvm/vmx/vmx.c         |  2 +
 3 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 2644add54b76..7414fb551d2e 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -56,35 +56,13 @@ static int pi_try_set_control(struct pi_desc *pi_desc, u64 *pold, u64 new)
 	return 0;
 }
 
-void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
+static void __vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
-	struct vcpu_vt *vt = to_vt(vcpu);
 	struct pi_desc old, new;
-	unsigned long flags;
 	unsigned int dest;
 
-	/*
-	 * To simplify hot-plug and dynamic toggling of APICv, keep PI.NDST and
-	 * PI.SN up-to-date even if there is no assigned device or if APICv is
-	 * deactivated due to a dynamic inhibit bit, e.g. for Hyper-V's SyncIC.
-	 */
-	if (!enable_apicv || !lapic_in_kernel(vcpu))
-		return;
-
-	/*
-	 * If the vCPU wasn't on the wakeup list and wasn't migrated, then the
-	 * full update can be skipped as neither the vector nor the destination
-	 * needs to be changed.  Clear SN even if there is no assigned device,
-	 * again for simplicity.
-	 */
-	if (pi_desc->nv != POSTED_INTR_WAKEUP_VECTOR && vcpu->cpu == cpu) {
-		if (pi_test_and_clear_sn(pi_desc))
-			goto after_clear_sn;
-		return;
-	}
-
-	local_irq_save(flags);
+	guard(irqsave)();
 
 	/*
 	 * If the vCPU was waiting for wakeup, remove the vCPU from the wakeup
@@ -103,7 +81,7 @@ void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		 */
 		raw_spin_lock(spinlock);
 		spin_acquire(&spinlock->dep_map, PI_LOCK_SCHED_OUT, 0, _RET_IP_);
-		list_del(&vt->pi_wakeup_list);
+		list_del(&to_vt(vcpu)->pi_wakeup_list);
 		spin_release(&spinlock->dep_map, _RET_IP_);
 		raw_spin_unlock(spinlock);
 	}
@@ -129,8 +107,33 @@ void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		 */
 		new.nv = POSTED_INTR_VECTOR;
 	} while (pi_try_set_control(pi_desc, &old.control, new.control));
+}
 
-	local_irq_restore(flags);
+void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+
+	/*
+	 * To simplify hot-plug and dynamic toggling of APICv, keep PI.NDST and
+	 * PI.SN up-to-date even if there is no assigned device or if APICv is
+	 * deactivated due to a dynamic inhibit bit, e.g. for Hyper-V's SyncIC.
+	 */
+	if (!enable_apicv || !lapic_in_kernel(vcpu))
+		return;
+
+	/*
+	 * If the vCPU wasn't on the wakeup list and wasn't migrated, then the
+	 * full update can be skipped as neither the vector nor the destination
+	 * needs to be changed.  Clear SN even if there is no assigned device,
+	 * again for simplicity.
+	 */
+	if (pi_desc->nv != POSTED_INTR_WAKEUP_VECTOR && vcpu->cpu == cpu) {
+		if (pi_test_and_clear_sn(pi_desc))
+			goto after_clear_sn;
+		return;
+	}
+
+	__vt_vcpu_pi_load(vcpu, cpu);
 
 after_clear_sn:
 
@@ -146,6 +149,19 @@ void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		pi_set_on(pi_desc);
 }
 
+void vt_vcpu_pi_remove_from_wakeup_list(struct kvm_vcpu *vcpu)
+{
+	WARN_ON_ONCE(refcount_read(&vcpu->kvm->users_count));
+
+	if (!enable_apicv || !lapic_in_kernel(vcpu) ||
+	    vcpu_to_pi_desc(vcpu)->nv != POSTED_INTR_WAKEUP_VECTOR)
+		return;
+
+	__vt_vcpu_pi_load(vcpu, get_cpu());
+
+	put_cpu();
+}
+
 static bool vt_can_use_vtd_pi(struct kvm *kvm)
 {
 	/*
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index c5860ea828ae..1d9ccbc2bb6f 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -10,6 +10,7 @@
 
 void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
 void vt_vcpu_pi_put(struct kvm_vcpu *vcpu);
+void vt_vcpu_pi_remove_from_wakeup_list(struct kvm_vcpu *vcpu);
 void pi_wakeup_handler(void);
 void __init pi_init_cpu(int cpu);
 void pi_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 292001bbcbff..1f9e43c5b4c4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7514,6 +7514,8 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
+	vt_vcpu_pi_remove_from_wakeup_list(vcpu);
+
 	if (enable_pml)
 		vmx_destroy_pml_buffer(vcpu);
 	free_vpid(vmx->vpid);
-- 
2.56.0.307.g5fe7bd680c-goog


