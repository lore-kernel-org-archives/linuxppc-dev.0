Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56450606A985
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Cn6thVqp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYv555Ftz3c9M;
	Sat, 31 Oct 2026 08:21:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395297;
	cv=none; b=OBocghRbfpCwhWpVkjbTTvCpVGjnbrvkCQHRXtQi+3O6cBSYsePXPHR1oMVd1T/jn+h7ctzNnmbJznaY3+nHVuX2BQDpYLf+MSoPDk6w56eYCm/rHFz4Tjr03FInXRXriBMLS1nW0fcmsAaGMm/mqJDCResiCIRG8zeCYs4CPcSqmv4/TJPHaoCLJMg0dJpCzjozHhJUAdU9jL9UwmMY40ytK7rU5Gh7mtGjG9/J1WAtwaAmF58mOTCcWUQeysE8Sj16yCDpQC7FzO0zLqUTeBknucYI/ObaxCGtfLRtGJljtgPPtMH1aPyFD9omWzWu3N4SBRim3UrmTTdGfsRMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395297; c=relaxed/relaxed;
	bh=zWm75tGn/A4widimTFSWHM28mEbNlDa0wqwtIGGfQ94=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BkUz4jhPuIYDjnL7tz6I/Z+1MQQXf6RbRUH8eUTIiXdGU7kxJE+w7cE8N+ua2/NUdo5EYsoXULErB/Sr/xr90/0G1J+oyPRIdq74W5KS6VkNG4+l1i26ZobgsY9B4D3lKLpgxwdjaWVeVPn7AhWLH+jj6jv3crbwQV85W2uwTScUX0YGvbT3olJ+iaMahbCsQcK/rXk1SU3iZcr3M9uItpHocBOHVS6iPb6AQkkem4l8wGAY6gW8cWBurezH631g2dKiE+2ikVh5bsengpTd+6Ro4DQ4S1CxdjMDp7ti373pLZ0ecyNenJ+/bXc7D1hzxLUyvCfwcJUajLKDcv1D6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Cn6thVqp; dkim-atps=neutral; spf=pass (client-ip=209.85.210.197; helo=mail-pf1-f197.google.com; envelope-from=3xgrlagykdguvhdqmfjrrjoh.frpolqxassf-ghyolvwv.rcodev.ruj@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Cn6thVqp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.210.197; helo=mail-pf1-f197.google.com; envelope-from=3xgrlagykdguvhdqmfjrrjoh.frpolqxassf-ghyolvwv.rcodev.ruj@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYv46frDz3c2k
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:36 +1100 (AEDT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so1266984b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395294; x=1794000094; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zWm75tGn/A4widimTFSWHM28mEbNlDa0wqwtIGGfQ94=;
        b=Cn6thVqp/a+hqn5kZWCEjkDWWUFBOy0qqY74RNfjEQ/D+zcJpdtdrQWiwWv60UUVjv
         ZSLv51t/yz6EYPpVKDRggjdiU8qF8Hl0y1o+JjDAZZD5X9hQb28+R2efHR1lwN8h0lpZ
         sfOvopKslia1Vwu+VXbHOy/NwcfJDS4xs3ftdBeLvdrUcPZy6+hpbkyNteYol15CJO/n
         0LUqGrSSPE/lm4+1Jwff3CUHzadGB5UhlkB+pWFla3xdugJcR9RR/fcZkBwDtl67T7Yr
         dDQ0sJDLM99Oj/gkl0HWPKl2q0cgRqVbsdCtcvIqR1bcsUASQoGzjoYa1karK5cKOj5O
         l5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395294; x=1794000094;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zWm75tGn/A4widimTFSWHM28mEbNlDa0wqwtIGGfQ94=;
        b=Y+cDeLi3HjpIWDgGiFBGROo0tz9ofFiGNfrRNA3ou2HUkM+PJ1WaK0PWbAv7vQWxL3
         9vkVhIklYxHKsra51mDn3uovluaWCn9uPmg3WZLppaULieENQqiXx8Z/WTlqCVQXTATs
         Z0twtmnwj7BSxjtMgM9yMS+SRn5Egd18IxLZK64R6QHn5BIY6PRjSBopKNcyxXurObHN
         rx74aLvtXAwT7GfX3AO/y4etpfUg3iDM9+rJ5tkTBqKJ65vlMOgKzU9ffJ+nkV/0wGjF
         42K70yJif56V3j8cUzvx47OEbLVjSnuOxKZgvczCN76SAHWEup4xY4+BlI8pjcFh5MqE
         mJaw==
X-Forwarded-Encrypted: i=1; AKwUvBxXsy1FMof2xnbjMFepk/p2Do1xRUafBCcJWP7bpTpvXS0w6BDEIg6sLbXWWODCPOuhQS8DpnWobVgaQKY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKvq5LTVRmAZD9GeS+sFslpKKbldTMoJfcsNArUxB5Pw6hysxOc
	fmrcRNLjJ3iTOo9pwggV6zWTNClYNGDz/jdRofaHLeiYCXuG0NeKgBnKDyQ15K+EZcLpaNv/shB
	eEK6sHA==
X-Received: from pgkz28.prod.google.com ([2002:a63:a5c:0:b0:cda:c74c:ca8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3b49:b0:3e1:e757:205e
 with SMTP id adf61e73a8af0-3e9290077e1mr2778969637.42.1793395294419; Fri, 30
 Oct 2026 14:21:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:05 -0700
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
Message-ID: <20261030212112.2598640-18-seanjc@google.com>
Subject: [PATCH v4 17/23] KVM: nVMX: Don't explicitly VMCLEAR+free() vmcs01's
 shadow VMCS when freeing vCPU
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

Explicitly VMCLEAR and free() vmcs01's shadow VMCS only when doing VMXOFF
or forcing the vCPU out of L2, not when freeing the vCPU.  Instead, free
the shadow VMCS as part of free_loaded_vmcs(), i.e. when freeing vmcs01 via
vmx_vcpu_free().  This will allow leaving vmcs02 as the loaded/current VMCS
when freeing a vCPU, i.e. will allow dropping the vmx_switch_vmcs() call as
well as the vcpu_{load,put}() calls, all of which do far too much work when
freeing a vCPU.  E.g. "just" switching to vmcs01 means potentially doing an
extra VCLEAR shootdown, potentially multiple VMPTRLDs (to first load vmcs02
and then vmcs01) and VMWRITEs, and so on and so forth.

Note, shadow VMCSes are rather odd.  They're only ever used when nested
virtualization is live, but a shadow VMCS is provided to L1, not L2, and
more importantly is made "active" (in VMX parlance) when vmcs01 is run (the
shadow VMCS is referenced by a pointer in vmcs01).  Because KVM dynamically
allocates and frees nested state, shadow VMCSes are loosely coupled to the
VMXON/VMXOFF lifecycle, but in practice are more concretely tied to vmcs01,
e.g. a shadow VMCS needs to be VMCLEAR'd if and only if its associated
vmcs01 was launched.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 54 ++++++++++++++++++++++++---------------
 arch/x86/kvm/vmx/vmx.c    |  5 +++-
 2 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 49c4529901c5..1b30ad7731ee 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -330,17 +330,9 @@ static void nested_put_vmcs12_pages(struct kvm_vcpu *vcpu)
 	vmx->nested.pi_desc = NULL;
 }
 
-/*
- * Free whatever needs to be freed from vmx->nested when L1 goes down, or
- * just stops using VMX.
- */
 static void free_nested(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	struct vmcs *shadow_vmcs;
-
-	if (WARN_ON_ONCE(vmx->loaded_vmcs != &vmx->vmcs01))
-		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 
 	if (!vmx->nested.vmxon && !vmx->nested.smm.vmxon)
 		return;
@@ -353,6 +345,36 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	free_vpid(vmx->nested.vpid02);
 	vmx->nested.posted_intr_nv = -1;
 	vmx->nested.current_vmptr = INVALID_GPA;
+
+	kfree(vmx->nested.cached_vmcs12);
+	vmx->nested.cached_vmcs12 = NULL;
+	kfree(vmx->nested.cached_shadow_vmcs12);
+	vmx->nested.cached_shadow_vmcs12 = NULL;
+
+	nested_put_vmcs12_pages(vcpu);
+
+	kvm_mmu_free_roots(vcpu->kvm, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
+
+	nested_release_evmcs(vcpu);
+
+	free_loaded_vmcs(&vmx->nested.vmcs02);
+}
+
+/*
+ * Free whatever needs to be freed from vmx->nested when L1 goes down, or
+ * just stops using VMX.
+ */
+static void nested_vmx_do_vmxoff(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct vmcs *shadow_vmcs;
+
+	if (WARN_ON_ONCE(vmx->loaded_vmcs != &vmx->vmcs01))
+		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
+
+	if (!vmx->nested.vmxon && !vmx->nested.smm.vmxon)
+		return;
+
 	if (enable_shadow_vmcs) {
 		vmx_disable_shadow_vmcs(vmx);
 
@@ -365,18 +387,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
 		vmx->vmcs01.shadow_vmcs = NULL;
 		free_vmcs(shadow_vmcs);
 	}
-	kfree(vmx->nested.cached_vmcs12);
-	vmx->nested.cached_vmcs12 = NULL;
-	kfree(vmx->nested.cached_shadow_vmcs12);
-	vmx->nested.cached_shadow_vmcs12 = NULL;
 
-	nested_put_vmcs12_pages(vcpu);
-
-	kvm_mmu_free_roots(vcpu->kvm, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
-
-	nested_release_evmcs(vcpu);
-
-	free_loaded_vmcs(&vmx->nested.vmcs02);
+	free_nested(vcpu);
 }
 
 /*
@@ -5606,7 +5618,7 @@ static int handle_vmxoff(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	free_nested(vcpu);
+	nested_vmx_do_vmxoff(vcpu);
 
 	if (kvm_apic_has_pending_init_or_sipi(vcpu))
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
@@ -6898,7 +6910,7 @@ void vmx_leave_nested(struct kvm_vcpu *vcpu)
 		vcpu->arch.nested_run_pending = 0;
 		nested_vmx_vmexit(vcpu, -1, 0, 0);
 	}
-	free_nested(vcpu);
+	nested_vmx_do_vmxoff(vcpu);
 }
 
 int nested_vmx_check_restored_vmcs12(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2ef1f634e7ec..292001bbcbff 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3089,7 +3089,10 @@ void free_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
 	loaded_vmcs->vmcs = NULL;
 	if (loaded_vmcs->msr_bitmap)
 		free_page((unsigned long)loaded_vmcs->msr_bitmap);
-	WARN_ON(loaded_vmcs->shadow_vmcs != NULL);
+	if (loaded_vmcs->shadow_vmcs) {
+		free_vmcs(loaded_vmcs->shadow_vmcs);
+		loaded_vmcs->shadow_vmcs = NULL;
+	}
 }
 
 int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
-- 
2.56.0.385.gac671c819a-goog


