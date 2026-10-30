Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344D606A9A6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Dtc9rMhz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYv93B1qz3cDT;
	Sat, 31 Oct 2026 08:21:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395301;
	cv=none; b=FmM35Uy88VeOCidoM1i2ARTgw3cZKCDPXvFJw8y5Ttbs/O+HLjdJfEfheYL84Ma48Y3ztTBmQRYDf0AoKRpJX9FaXk6qJLWwFL+BVBhp3oMw8LGv7fl2WHi8i6+KuH66NyWM4CR6CXIhQqMSZCvi+0UaX7Fmxhnphb2M9/y4DlxUsGvc/qTplbsRzNoefb1Sb+j9vlleCxGZzTNmtwEmobzE4gMLfAk8bqYYMJqisQky9vZdyukqZiLbKoH3lfX4qWWlwucN2ZaK8P/wRfkyUKFOiAtw6Qcfa3OfZ2fpBXQQ0MBIBdwEUVhNdHF3a/HnU/4icGvsdNSi1Wg8w93QIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395301; c=relaxed/relaxed;
	bh=8PE43LpzTPSR1zzdd4igy9DBsWKBaooNuQb+N+z+Bpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cm5GHiQg+m1qjvBod7hyQG5TSRm3ucoGPJFTuq+5B3qMMArxMTFfD+94h+2L18Q4kjoL2jXn3qdvSdsfYeJ2TT3RFUfY6a0OgIKF2pyv5db3pyiFmpz4cOFROvkz6AgyVtqNgIRbxKn5C3D1JsgcjDR4vWD4U2/tlaPPJ7cdq2h0GbxXcZtDhDLCAJ+hQJzVX83gAJNdGuXLQJzlGUXdznN2hHr8VDt9SCZO5sdH8bV7S9CBWo8Fb2PomsB67NOYl85rK+LhNVrRDLr+yJdsOpEvRH5PAtSwMUc3SUmBJlpQyVpMpZSvZe9bicbiGcxpmZCuRcRq+1Lo7Q3xXk/+gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Dtc9rMhz; dkim-atps=neutral; spf=pass (client-ip=209.85.210.199; helo=mail-pf1-f199.google.com; envelope-from=3ygrlagykdgkzlhuqjnvvnsl.jvtspubewwj-klcspzaz.vgshiz.vyn@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Dtc9rMhz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.210.199; helo=mail-pf1-f199.google.com; envelope-from=3ygrlagykdgkzlhuqjnvvnsl.jvtspubewwj-klcspzaz.vgshiz.vyn@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYv84j1pz3cH4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:40 +1100 (AEDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a065e2933fso1284712b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395298; x=1794000098; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8PE43LpzTPSR1zzdd4igy9DBsWKBaooNuQb+N+z+Bpc=;
        b=Dtc9rMhzOnC1MPzVx3vyTzWabj8ik8QXPvdZyuorzm6p+wmIuyYppfhc/iVpb26t+E
         jyYW/SP2T1PWnfdt/8zE49DzdrsG0CYgc6lkzT91tyw2+f/0UWcDF0angosRsdbQKFEf
         b1JVhiSjNySOko9TzTxiuafWxtYgDHjMCsbnEq9lDo25jhgq6ZDkqzTXyh/lMLzV8XOu
         XZm2eLyn72oskkbtKo8f4sLZIqaSo/l25xDk9pbXfbA+66UZ8f9Mmj1hzVqbx+x1Nn8v
         MsLzXIwsIkyrvg56byqmi4F/6x1igY75uIo6tPz+Q4lTDlVDj2d8Y9sQoG19dC9w3ffe
         1Imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395298; x=1794000098;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8PE43LpzTPSR1zzdd4igy9DBsWKBaooNuQb+N+z+Bpc=;
        b=nyJ9utH2sWwx+IZKr0V+4b3hef8ttC0BllszeEC9jk9J7lmSxWYP9xK5hlQc/Czx9B
         qVQDwiobN3wiEBjZ26nVt8zXXFWFX7SWUx5fGQGm9+argiL7ZlWCEufVg0o6nhhzTnnz
         m7Xw3dKXEqnN63M3cpVTzTa0m6aaUtWYgNvn8qlyaeG53xpeTlWqVIuBiK2yngc0rGWN
         O8W5CYsxk7K37XuHbwdjrsm5NPh/RPsZar75yvbdGuCNVF4y0AJ1pGLLYVsk++j5PPVO
         zVjjxYjHqeEZwPW3zyBvziLiT03hbggfJIUR90NHn2Rvnc2HBFJM+cLawbMwGvkbD0JZ
         fmpw==
X-Forwarded-Encrypted: i=1; AKwUvBzlg1IcxB66wCeuoYN8ceKQLd/kJcUfT9n4y51A3HNJVaKDtZOtJ4ZRM9cq2Q2tcP84nmqaOjMTw5JBZSA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL/AqOKl+82kvMHLh18gNrScDe0dDzWtOlzQlOYgbNDRauVxJNI
	x3+vKyymJ0eogM1+LtE1nP9TfHof7ZX5RyCYsTRyCe+mo1X8wToYoT5zgK84kkQvJ733KWcNfMw
	w6AERIA==
X-Received: from pfbjw38.prod.google.com ([2002:a05:6a00:92a6:b0:8a0:afff:6594])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:600d:b0:892:e080:4ed8
 with SMTP id d2e1a72fcca58-8a9bd7dc8bfmr2989556b3a.47.1793395298189; Fri, 30
 Oct 2026 14:21:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:08 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
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
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-21-seanjc@google.com>
Subject: [PATCH v4 20/23] KVM: VMX: Explicitly remove dying vCPUs from the PI
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

Reviewed-by: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 68 +++++++++++++++++++++-------------
 arch/x86/kvm/vmx/posted_intr.h |  1 +
 arch/x86/kvm/vmx/vmx.c         |  2 +
 3 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 2644add54b76..4406e344ae6a 100644
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
+	kvm_lockdep_assert_vcpu_is_unreachable(vcpu);
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
2.56.0.385.gac671c819a-goog


