Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19664606A31F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UCWdt0Sk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDl9B5DQYz3bYx;
	Wed, 28 Oct 2026 09:12:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793139150;
	cv=none; b=kP9kVoFH5PTvXdwcnhX9SZXcAZpM3KHlFU9njLFwO0x46hO0jq0Ac9K8b0blnsOBLSKgpCJ37uBD0wlzT7C6ZdDYYSG6n5YJWO8tT4Eq80a9809khi42Igc61FY9s6ANVLmhB/SaZRtgMLYROf//tGbjj/m8k2yZcvV0wLoVlMQYZgdR+V9DBdvBvBBmo7nBhIc0x02YwMDV/n6jg6aXMHCUYTgcioZpI+dsymLYpeRWyh0YNWGUSGBZaa8fjXTiobQfF/QAgKCGapo6sIyZ+VI+74FrrNKHP7JxkAsJdOtJP+YlnfcMgHyBkQAp6itZEiJi0cAl9KjNdGHaD5ZwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793139150; c=relaxed/relaxed;
	bh=eF/MVMbJDhLKDA2GRNVDooADE6A9y38RXKzwMieQl+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DmsKOJvwf891J81ePz4/b0ZFp02QcqqzhWUt0xLasjILl3aZGxZlpZbNNioRdJv3Fjo3BRuJbYx28Cqkqh5pwg6PO6uw1M0+hsVzOI27/nf/X3kM89xuDGNjlCLBNjtN5rfqlt6CCYQeH3zzu+z/4QQiPSOSc6pbgTIyTeJ3uRgtEH7s2cblyOqTn6Lr1USmezYrnldkT4Lsbr/hTSXNOYTYlLA1PDh9FUVfD2dzbmApSmnNrUF/DVkZ1j3DSGzatqGlHSIdizALPEjHyXBwoQMOf6xHWJ3LB4DHMxVNJW/oNSoe+NSwSlM/Sf4glJKQHVHd6Atc5vZMtWvPStCeVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UCWdt0Sk; dkim-atps=neutral; spf=pass (client-ip=209.85.214.198; helo=mail-pl1-f198.google.com; envelope-from=3yyhhagykdpakwsfbuyggydw.ugedafmphhu-vwndaklk.grdstk.gjy@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UCWdt0Sk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.214.198; helo=mail-pl1-f198.google.com; envelope-from=3yyhhagykdpakwsfbuyggydw.ugedafmphhu-vwndaklk.grdstk.gjy@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDl9B0C84z3bV6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:12:29 +1100 (AEDT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e9995cea88so2424955ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139147; x=1793743947; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eF/MVMbJDhLKDA2GRNVDooADE6A9y38RXKzwMieQl+Q=;
        b=UCWdt0SkKwBooj30i8edLlT5rt5TQXD/vNZ4/KV2+RjCZVT1FEB6bXop/KQgcByyg1
         vq6BN763R56EoySAYlQm5Ebv5wJ6SAMjvrIdkS6vVasn/kB79uB3euQ+6rEtYm3wnGQa
         1lOxrJqsH53mjo+Eyeenif1DjsIlokEw62haOFzK5HRXpw3Ldlj/Bd3zEHAVLtIeH4Q9
         38O426Uecyxj6YbLQVh+UVXTQ6kj3FlbOe1v83NsRQoo/YFoPWXGglz+Jgr6AWRZypUq
         QwAgqTk693aTfa7tp7ElH+brERHbZwaHQiLETMcDnPX7Wwc46BZbHOOXaSdp/bUUYZzf
         hNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139147; x=1793743947;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eF/MVMbJDhLKDA2GRNVDooADE6A9y38RXKzwMieQl+Q=;
        b=K1d3w3g5TvD7D4zyX/uXyGzWT05pU1issakOzA7DhvQoik+hxllDUM2QDiM1EMo8Pv
         1p7X6RBpo1rwi5CHeHE9p2IpQIiqczp+HBwfJcCjFWtGZsbxxgpkQOeEoFoP4ScDlX4f
         corE8H7KZybl4QfoJA0R76xKVOkVONxZUH9uPW1IV3Nk3KBOaf1Jo39MuaaCHsaVHZ39
         xmaIZXtU938ie/Xg2yEwC3JEc6g3/G6bvlGoUV1FiBHU+9nZ/Ea8IiZgSAd3ANBlWuNg
         x1f6uWrpsb0ew4UYTfE0Lt4OACZzOnG36mJpWzHidUasfRahWkWLsge0y4aVs9QNtAO+
         2Biw==
X-Forwarded-Encrypted: i=1; AKwUvBwGH12XFKYZFoZ3rpstVbydTc5mKRpPs5etRMtBkoo63YpT9fL1cW+diw/MK6iz3Jzj0gZf8O95RqAXe6s=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ+nJ9IhHROJvb4pgeB5iFq7R8+jBX7CmJUYR05fqENLPzIzf9k
	Dr7DnJsRptLTiEEIbfxgiiMVCOAbYzLYQPTl3Tfx64kOeuO337CZSMHAv6ETSiAtaZexs1YwLo2
	i4eUxuA==
X-Received: from plcr1.prod.google.com ([2002:a17:903:141:b0:2e8:1f84:7c18])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e5:b0:2e9:740c:36c
 with SMTP id d9443c01a7336-2eb0057bbbfmr5608715ad.41.1793139147130; Tue, 27
 Oct 2026 15:12:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:04 -0700
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
Message-ID: <20261027221209.1560865-12-seanjc@google.com>
Subject: [PATCH v3 11/15] KVM: nVMX: Don't explicitly VMCLEAR+free() vmcs01's
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
2.56.0.307.g5fe7bd680c-goog


