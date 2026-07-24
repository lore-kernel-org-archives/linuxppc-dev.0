Return-Path: <linuxppc-dev+bounces-24751-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636FDC531CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 00:48:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5q934qvRz2yhY;
	Fri, 24 Jul 2026 10:48:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::545"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784854087;
	cv=none; b=ieFwAHk/MhzP6wmSLmMK4bocjuj6kCaRUrfFiGJ9bOvvJZymHENhV+Je67gTdO5zcKvn1Aea0S9ANJk+ut7Yxdjk8urzcVPT35mu2F6mSf2SQxl2OB0PUMgxqnMQ5toHbw+4b2raJNbPYIj/Z8vLGnbRWtkbvKAyfP7SGDSDy/iHnozYFTscI2PNB2VkW/rLv4HZ8JXQdAueaDktmGkC4T9pRh84Shu4PB03P52VFWawbbCAX242FWlZHtAn7xTtgVuT4TFCJ04T74IabohAm33XtGgFhCG+uBt7Jg60Mvv/xh6F6adpXsqjqiw3j+Q6AjTFHRa61MBLQX+oRjhVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784854087; c=relaxed/relaxed;
	bh=5hCTXU5J5OKjCYOs510ZpnLddxhpdmEInNm/3mj3vgs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TV0q+8MtfWBan7pucF27STSPTCKjzGNhWFoWPjfl0WqV2C5LECXF8FuhGxkBpCT/8vn5Qcnmq5gBhfllq9eMgLul7TTcTzhOfOGVvFpIAnkkbwT5iXywA534unIjNkg0hoBzWn2pODSdw2XRjeWdfvF1ukxzxYfnLJkxmehO9NKWLaZIUli26MkclAVeUVgIWTfu6Ur74P4LQ7JDVzZFCYujJGJhB9C7/nBP7quLPb3cel2T+xh0IUWPPacNuMqT3b1tjTzH84Nud/qAXvC1FZxyOANwtCsQAUF32XuSNuOe4GmEoVDMoLThqA8TYx+d7DgQKiUhWTdtg4jUli08+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=MgoD8KHn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::545; helo=mail-pg1-x545.google.com; envelope-from=3qrziagykdjmf1xa6z3bb381.zb985ahkccz-01i85fgf.bm8xyf.be3@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=MgoD8KHn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::545; helo=mail-pg1-x545.google.com; envelope-from=3qrziagykdjmf1xa6z3bb381.zb985ahkccz-01i85fgf.bm8xyf.be3@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x545.google.com (mail-pg1-x545.google.com [IPv6:2607:f8b0:4864:20::545])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5q912c02z2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 10:48:05 +1000 (AEST)
Received: by mail-pg1-x545.google.com with SMTP id 41be03b00d2f7-ca860baea9fso2722556a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 17:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784854083; x=1785458883; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5hCTXU5J5OKjCYOs510ZpnLddxhpdmEInNm/3mj3vgs=;
        b=MgoD8KHnPtfr3Erlsk0XYNMYCNpMtl0Y99VTo87qgcWAf3N0ogw4GcQZYb8Ah+l88I
         WpZaNK2AxBUsaKPK75NwRpxPFxVNbmd/csmCWEmAFWRsfrZjGDWS0uCRpjuBJ9CN9KgW
         FYydJmRXQLcE7y2ON5yKIGdJCXr159phCILujBM1FNd03RS3HcvMm91LEG0ZocOuqz8x
         zLtz5aUpHLb339zE61o/qyhvMpCfp+dRsUQ1OtX/ojcz14Ba9gIns3lLTnrREKQV0T0S
         lMt3aO5mk19nBlypaFiLa0RBJh8MQVI9dhbIHkvoiVfgQoFaImgPkwRuBwyH1wb5caJR
         eOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854083; x=1785458883;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5hCTXU5J5OKjCYOs510ZpnLddxhpdmEInNm/3mj3vgs=;
        b=m+v08SnD3wk+u+BXV1qWLwySIruETHVtnx0iA+jvTcAZikfya95yl9lQOWyMkZqtDk
         9i1BFTih5LBMZRCHLZYJWUlJj7gDMOmXmDEDzDKqZ/+odoDeao0dYK4ZkWjTYGbT9WMU
         lhf2k/RsWbKR9HNKa3Sid1Fs2tUWLj/VLlTg22dYBLmyf4wx2hR+YEipxATo90KUUu/Z
         s1+31pFdbCX0iDtjgD+D5zG4cdpr8S54z5Ry4W//eju47CTCaoPwGwf1//VUOXw7xFfK
         /pvRsp89UwxPe3f5cuD4eRLpdgN4R53EOyrKC8L8xyTg69+4xyhkPENfIYz+Ntk/4nLD
         qgVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTnH+Es4Y0ZLaqvYshbhjkedcg52UK8YMAVKY/CHtnQJ1fH3KAf4IesImGtzyrMmkVpWychYCKzfNfpiA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzjdgWUNfAg3q+J5qN+WeMLX1MGdzObaQzTk7Y9ICeHCi7Q/eYM
	DhEzvvdVpGnDAFPG7GbkxiH4Ggp42Pw4RpRf0z8+5uhxSZitEG+FuWN25UYHG+EbC+NwRsGXVZB
	4THhxTQ==
X-Received: from pgbct6.prod.google.com ([2002:a05:6a02:2106:b0:cb5:f989:9b3e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6494:b0:3b7:aefe:4367
 with SMTP id adf61e73a8af0-3c44b051466mr6208250637.33.1784854082942; Thu, 23
 Jul 2026 17:48:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 17:47:53 -0700
In-Reply-To: <20260724004757.131420-1-seanjc@google.com>
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
References: <20260724004757.131420-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724004757.131420-3-seanjc@google.com>
Subject: [PATCH 2/6] KVM: nSVM: Add CLASS()es for automagically handling local
 kvm_vcpu_map() usage
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add CLASS() definitions for locally mapping a PFN using kvm_vcpu_map()
given a vCPU+gfn pair.  In addition to eliminating the need to manually
do unmap(), e.g. in error paths, this will allow hardening KVM against
double-mapping without having to manually ensure every on-stack declaration
is zero-initialized.

Use "map local" as the primary terminology as the basic concept is more or
less the same as kmap_local(): ensure the current context has a kernel
mapping to the underlying memory.

Immediately convert the relatively straightforward nested SVM flows, and
defer converting the more involved SMM flows to a separate change.

No functional change intended.

Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 18 +++++++-----------
 arch/x86/kvm/svm/svm.c    |  8 +++-----
 include/linux/kvm_host.h  | 19 +++++++++++++++++++
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5e3e280cd483..73f37b050d0a 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1086,14 +1086,14 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa, bool from_vmrun)
 static int nested_svm_copy_vmcb12_to_cache(struct kvm_vcpu *vcpu, u64 vmcb12_gpa)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct kvm_host_map map;
 	struct vmcb *vmcb12;
 	int r = 0;
 
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map))
+	CLASS(kvm_vcpu_map_local, m)(vcpu, gpa_to_gfn(vmcb12_gpa));
+	if (m.ret)
 		return -EFAULT;
 
-	vmcb12 = map.hva;
+	vmcb12 = m.map.hva;
 	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
 	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
 
@@ -1107,7 +1107,6 @@ static int nested_svm_copy_vmcb12_to_cache(struct kvm_vcpu *vcpu, u64 vmcb12_gpa
 		r = -EINVAL;
 	}
 
-	kvm_vcpu_unmap(vcpu, &map);
 	return r;
 }
 
@@ -1251,15 +1250,13 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb02 = svm->nested.vmcb02.ptr;
-	struct kvm_host_map map;
 	struct vmcb *vmcb12;
-	int rc;
 
-	rc = kvm_vcpu_map(vcpu, gpa_to_gfn(svm->nested.vmcb12_gpa), &map);
-	if (rc)
-		return rc;
+	CLASS(kvm_vcpu_map_local, m)(vcpu, gpa_to_gfn(svm->nested.vmcb12_gpa));
+	if (m.ret)
+		return m.ret;
 
-	vmcb12 = map.hva;
+	vmcb12 = m.map.hva;
 
 	vmcb12->save.es     = vmcb02->save.es;
 	vmcb12->save.cs     = vmcb02->save.cs;
@@ -1314,7 +1311,6 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 				       vmcb12->control.exit_int_info_err,
 				       KVM_ISA_SVM);
 
-	kvm_vcpu_unmap(vcpu, &map);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 91286d46d13a..bf10483c0e8a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2216,7 +2216,6 @@ static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 	u64 vmcb12_gpa = kvm_rax_read(vcpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb12;
-	struct kvm_host_map map;
 	int ret;
 
 	if (nested_svm_check_permissions(vcpu))
@@ -2227,10 +2226,11 @@ static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 		return 1;
 	}
 
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map))
+	CLASS(kvm_vcpu_map_local, m)(vcpu, gpa_to_gfn(vmcb12_gpa));
+	if (m.ret)
 		return kvm_handle_memory_failure(vcpu, X86EMUL_IO_NEEDED, NULL);
 
-	vmcb12 = map.hva;
+	vmcb12 = m.map.hva;
 
 	ret = kvm_skip_emulated_instruction(vcpu);
 
@@ -2243,8 +2243,6 @@ static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 		svm_copy_vmloadsave_state(vmcb12, svm->vmcb01.ptr);
 	}
 
-	kvm_vcpu_unmap(vcpu, &map);
-
 	return ret;
 }
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9db6eb4023c4..c54dbfdbc346 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1420,6 +1420,25 @@ static inline void kvm_vcpu_map_mark_dirty(struct kvm_vcpu *vcpu,
 		kvm_vcpu_mark_page_dirty(vcpu, map->gfn);
 }
 
+typedef struct {
+	struct kvm_vcpu *vcpu;
+	struct kvm_host_map map;
+	int ret;
+} kvm_vcpu_local_map_t;
+
+#define DEFINE_VCPU_MAP_CLASS(ro)					\
+DEFINE_CLASS(kvm_vcpu_map_local##ro, kvm_vcpu_local_map_t,		\
+	     if (!_T.ret) kvm_vcpu_unmap(_T.vcpu, &_T.map),		\
+	     ({								\
+		kvm_vcpu_local_map_t m = { .vcpu = vcpu };		\
+									\
+		m.ret = kvm_vcpu_map##ro(vcpu, gfn, &m.map);		\
+									\
+		m;							\
+	     }), struct kvm_vcpu *vcpu, gfn_t gfn);
+DEFINE_VCPU_MAP_CLASS();
+DEFINE_VCPU_MAP_CLASS(_readonly);
+
 unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *writable);
 int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data, int offset,
-- 
2.55.0.229.g6434b31f56-goog


