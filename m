Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95433606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BfIFetxW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYvF1cFMz30Wh;
	Sat, 31 Oct 2026 08:21:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395305;
	cv=none; b=OGvMIPvBzdU2NB7BjvDBjtQvaA+M5Rpt6BnXcfRy3Jqg8Xa/+ug+OV3D4ipYEPEbZDhC36jxxk3AsI0Yvfs5dWv0ZprF5dY3BUWKJ0qv4QbAWDCxu4Rmc1kE0vxlzHESFxTPpGIkpGcWi/tY3bf2BwaX9YitX9xlRx6k89bYIaNMeL2c03YlDVUHRFFWOhtTXjJ08kIGE65DxdJpn4kIY+eXeOiJ+g+JQ7Xq4RHTvmNGAuGD0tYmGyvI6Eqm02ujn0uvobqzCb0buw35WOpbQqUMZQY7SLld+1z3ITQU8L/rKAGxgoJghTvgFCwiEUJ/+ZpaoNNkRxTw+rZNx2tf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395305; c=relaxed/relaxed;
	bh=QOulOknncDj+wvkIw4OOGY1O6DdQV3bVqwj3fNEp63M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JJmkd7Mhc8eTHEk3qn0JrtYHtIDL1SYfbV1HxrMU4AhiG4Vu1TPHEM1O8ofXE/IyJFHdOTbxCefbFdEcV6PKrtM39EYllaTPJL1WFqT8z7pC/Ymm/7wJaWVr+W5rtNM5hGHZ3+dhQ0iyuvV5VVFFZgzjbcdP+chkRLnZlmXcp1CY1dyTWnNCZTGOk6QBjf0pv1ipsCsgVBTyL+QONkBFF0IWnT5uaQQh13xW/jGT5OvYRdemU2eLLH1kgMy/Ag821y0h5qDWqZp3Ja17K3tyaK/003Y6vX4Z2xCaDslwF7RJRvPBe+WwAxmlHBRkL38HmVw1/Jv1WzFvOPul8QZQMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BfIFetxW; dkim-atps=neutral; spf=pass (client-ip=209.85.210.197; helo=mail-pf1-f197.google.com; envelope-from=3zqrlagykdgwcokxtmqyyqvo.mywvsxehzzm-nofvscdc.yjvklc.ybq@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BfIFetxW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.210.197; helo=mail-pf1-f197.google.com; envelope-from=3zqrlagykdgwcokxtmqyyqvo.mywvsxehzzm-nofvscdc.yjvklc.ybq@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYvD3X4rz3cNP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:44 +1100 (AEDT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a0688a43d3so833833b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395302; x=1794000102; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QOulOknncDj+wvkIw4OOGY1O6DdQV3bVqwj3fNEp63M=;
        b=BfIFetxW+Ipx9ozSjpH9cqVn727NdOcqbh8ICZv6FPVHbZ7kHS9J9NmeDNGJC4D6z9
         cU3BVKeLcxlJpxU91K78xD1hV+zoyblRZsQBdaqFhX8/mBeoXJ5RRnUg3VYqC+/oPXVT
         VzoM+7XL2UukfTwtoYaNIvy2nRBnr8tS5Ty/qxb/sAR5M6k9fGSZJAB9qtQzqmkEoeeb
         m/FiiOOwJqktuXf1fz5FwpiC6nlIoLQcGGX8MgRcwnmweunLbOOsj3UHnlV2Tawwf0Im
         RknxocwLr9wVTyEmwycoC82bKQsIRNwgm0Hqm+cQ8i5XbQT1YmVJa8ckYLU1EV7rrEMs
         +6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395302; x=1794000102;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QOulOknncDj+wvkIw4OOGY1O6DdQV3bVqwj3fNEp63M=;
        b=2vg4Go1Q6gMrHYkuE4RMp+OTA6FBeOLqInmxompT/tAJNQCZHWKdpbrISIlX1+6KQ2
         GEH+uSaPi02JFeD7aM1gjoI9cjNYA5Z5UJviqwfUSQbPcCqo5pYJMV8DgfTsT9So3lYE
         jOmXy3iYUxwyh90RN5Ikys0fCeR7AigGVxi39oB6dx/Uu+ov/payFm47V1KDywj6X8zi
         EmX4egH7FTsFTkKJzxXtzKS+OJmsJh02Krf2YR7TtiIunEGxjr9b5MaWrlT83cro5Szt
         DGhdRn72LDENYoHqqF8l44DvZYxydEUAL973IW0ZM9h3kFhetnbAQj5vanqZlE2+3TMu
         fG6A==
X-Forwarded-Encrypted: i=1; AKwUvBziy9dqnGIuQJ2TUjDoy1epS+uz+mMnB1bZMnypCjk7r72vUBXscjPFpUzjGwNioqWlyNmA6/LX9A3xPl0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLm1HC8gg1MgEAeQN+O7ElvQF+u88wQFWayEP1/au4F/zEwbnBM
	HyljVHgvG3Au0+Q+5prM+x/S7MyRSVX+v/CKFlMbLgTDfKFbNjUZ6Fui9GniNOhQ0a9iSxPbwZU
	fZRDzew==
X-Received: from pfbay8.prod.google.com ([2002:a05:6a00:3008:b0:89f:6242:b2d2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3e01:b0:3e2:5d77:4bf3
 with SMTP id adf61e73a8af0-3e92884d686mr2608559637.0.1793395301941; Fri, 30
 Oct 2026 14:21:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:11 -0700
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
Message-ID: <20261030212112.2598640-24-seanjc@google.com>
Subject: [PATCH v4 23/23] KVM: x86: Rename __x86_set_memory_region() => x86_set_internal_memslot()
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

Rename __x86_set_memory_region() to x86_set_internal_memslot() and add
double-underscores to the existing x86_set_internal_memslot(), so that the
x86 APIs better align common KVM's kvm_set_internal_memslot().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c   |  6 +++---
 arch/x86/kvm/vmx/vmx.c | 12 ++++++------
 arch/x86/kvm/x86.c     | 14 +++++++-------
 arch/x86/kvm/x86.h     |  4 ++--
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index c20e2a25834f..b4a7f02f5c48 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2917,8 +2917,8 @@ int kvm_alloc_apic_access_page(struct kvm *kvm)
 	    kvm->arch.apic_access_memslot_inhibited)
 		return 0;
 
-	hva = __x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
-				      APIC_DEFAULT_PHYS_BASE, PAGE_SIZE);
+	hva = x86_set_internal_memslot(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
+				       APIC_DEFAULT_PHYS_BASE, PAGE_SIZE);
 	if (IS_ERR(hva))
 		return PTR_ERR(hva);
 
@@ -2943,7 +2943,7 @@ void kvm_inhibit_apic_access_page(struct kvm_vcpu *vcpu)
 	if (!kvm->arch.apic_access_memslot_enabled)
 		goto out;
 
-	p = __x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT, 0, 0);
+	p = x86_set_internal_memslot(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT, 0, 0);
 	if (IS_ERR(p)) {
 		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
 		goto out;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1f9e43c5b4c4..00fb9459de59 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4055,10 +4055,10 @@ static int init_rmode_identity_map(struct kvm *kvm)
 	if (!kvm_vmx->ept_identity_map_addr)
 		kvm_vmx->ept_identity_map_addr = VMX_EPT_IDENTITY_PAGETABLE_ADDR;
 
-	uaddr = __x86_set_memory_region(kvm,
-					IDENTITY_PAGETABLE_PRIVATE_MEMSLOT,
-					kvm_vmx->ept_identity_map_addr,
-					PAGE_SIZE);
+	uaddr = x86_set_internal_memslot(kvm,
+					 IDENTITY_PAGETABLE_PRIVATE_MEMSLOT,
+					 kvm_vmx->ept_identity_map_addr,
+					 PAGE_SIZE);
 	if (IS_ERR(uaddr)) {
 		r = PTR_ERR(uaddr);
 		goto out;
@@ -5295,8 +5295,8 @@ int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
 		return 0;
 
 	mutex_lock(&kvm->slots_lock);
-	ret = __x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, addr,
-				      PAGE_SIZE * 3);
+	ret = x86_set_internal_memslot(kvm, TSS_PRIVATE_MEMSLOT, addr,
+				       PAGE_SIZE * 3);
 	mutex_unlock(&kvm->slots_lock);
 
 	if (IS_ERR(ret))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8cb58040dd81..85dd52c6beca 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10007,8 +10007,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	return ret;
 }
 
-static int x86_set_internal_memslot(struct kvm *kvm, int id, int as_id,
-				    gpa_t gpa, struct file *f, u32 size)
+static int __x86_set_internal_memslot(struct kvm *kvm, int id, int as_id,
+				      gpa_t gpa, struct file *f, u32 size)
 {
 	struct kvm_userspace_memory_region2 m;
 	unsigned long hva;
@@ -10038,7 +10038,7 @@ static int x86_set_internal_memslot(struct kvm *kvm, int id, int as_id,
 }
 
 /**
- * __x86_set_memory_region: Setup KVM internal memory slot
+ * x86_set_internal_memslot: Setup KVM internal memory slot
  *
  * @kvm: the kvm pointer to the VM.
  * @id: the slot ID to setup.
@@ -10059,7 +10059,7 @@ static int x86_set_internal_memslot(struct kvm *kvm, int id, int as_id,
  * address, i.e. its accessibility is not guaranteed, and must be
  * accessed via __copy_{to,from}_user().
  */
-void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
+void __user *x86_set_internal_memslot(struct kvm *kvm, int id, gpa_t gpa,
 				      u32 size)
 {
 	struct file *f __free(fput) = NULL;
@@ -10081,12 +10081,12 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 	}
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
-		r = x86_set_internal_memslot(kvm, id, i, gpa, f, size);
+		r = __x86_set_internal_memslot(kvm, id, i, gpa, f, size);
 		if (!r)
 			continue;
 
 		for (i--; i >= 0 && size; i--)
-			x86_set_internal_memslot(kvm, id, i, gpa, NULL, 0);
+			__x86_set_internal_memslot(kvm, id, i, gpa, NULL, 0);
 
 		return ERR_PTR_USR(r);
 	}
@@ -10097,7 +10097,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 
 	return (void __user *)(slot ? slot->userspace_addr : 0);
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(__x86_set_memory_region);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(x86_set_internal_memslot);
 
 void kvm_arch_pre_destroy_vm(struct kvm *kvm)
 {
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index cfe96962a4e4..c467d7347145 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -529,8 +529,8 @@ static inline void kvm_inject_gp(struct kvm_vcpu *vcpu, u32 error_code)
 void kvm_inject_nmi(struct kvm_vcpu *vcpu);
 int kvm_get_nr_pending_nmis(struct kvm_vcpu *vcpu);
 
-void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
-				     u32 size);
+void __user *x86_set_internal_memslot(struct kvm *kvm, int id, gpa_t gpa,
+				      u32 size);
 int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
 
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu);
-- 
2.56.0.385.gac671c819a-goog


