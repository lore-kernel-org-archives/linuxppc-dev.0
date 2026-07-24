Return-Path: <linuxppc-dev+bounces-24752-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49ACC531D0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 00:48:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5q935z9Wz2yjR;
	Fri, 24 Jul 2026 10:48:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::545"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784854087;
	cv=none; b=LC/snN3ZQjfPk7QVt/neT4XttZd3eRGj+NG1vP2STgrz/TAaeG7sItqERIwYaRrbidB9oA/hsMC7az+rDbEOzqVFSaKV5HtkWNbuyNQzaDbD10CUMdv+7pvkbD9BnmUNn5f5E0V5LIkpqJzvRNh7UuNXe0DxN/5/XqG2DxB2CHvzc/Nx/RMHuq9/xg+zFSE4K+93yNnCewv3aNegi3JYRGQ8Gt4XuSsbU+fctq8DL4JHOlwfFNvo1BEwCxasWI9KB/6MryWGvVoo648zin2+IPAjO1B7zned0tlaDhgtPBEXf1PwAygFRSjGxFdRrA/K9Yki/lmdKr//BGFMNzwSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784854087; c=relaxed/relaxed;
	bh=Alx5+6ajemwcdZLjQENBxyMOBgE6MWN8o6tlzzoEhF8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E3FLTuZB+8j4AhS8aU9FNjvD5ata+CAAiXpUTEhYqckn6bkiUI1P8oXvJpXR8TmPRwPn++W+aJB8TKlq0VaZd05gw8d2YX7AJLg8WxG5OzuZ9/OObTw+9pNqqkmtvsOy2i+roYvqnfSJiJ0iU9bxhqrL9HOcbLhBH1lmUXMGc8JJiDzMQdSrLuSD2MotwqG3OSvVUVkTYVBAjyOucSgApV32P9lc4yUgy6s+cnOm1b33BKqIF5tj6Z03X+3B/h7oJaLl8y03rBQEx5OAXMpL0EPaPfdecMnH+7uza+Q0ajVii+Tb0mReRfX63ufEzkACIX2Y3ntqJ8Af3NgB6e5ldQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=O2oV06r2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::545; helo=mail-pg1-x545.google.com; envelope-from=3rlziagykdjuh3zc815dd5a3.1dba7cjmee1-23ka7hih.doaz0h.dg5@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=O2oV06r2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::545; helo=mail-pg1-x545.google.com; envelope-from=3rlziagykdjuh3zc815dd5a3.1dba7cjmee1-23ka7hih.doaz0h.dg5@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x545.google.com (mail-pg1-x545.google.com [IPv6:2607:f8b0:4864:20::545])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5q925FwBz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 10:48:06 +1000 (AEST)
Received: by mail-pg1-x545.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so2213628a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 17:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784854084; x=1785458884; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Alx5+6ajemwcdZLjQENBxyMOBgE6MWN8o6tlzzoEhF8=;
        b=O2oV06r2PNoeaAoSkHKVi+K3G8qSMoMjbf7iO4GURlem6JpLhQ7QyD1Uoxd1RrcMqI
         RBr6KXHT1VfPtMr8a1ouAL9dq4o1v72WRp+Sc3+aihWJw82FXAOZsyBotNxSth8rqCA2
         rBj+dELDVFOgYNqZ2FdMilKOPWVnmpqQ3liPLZH78JQ90cUGVn0yCwmMt/UB1x9qQTOr
         BIbF1IzZ3eDOFsWK3XpHwiQXOPH81cFt5raJ6Bl4FspqrfKbXuhNTW5GCMblWn8GsgRm
         J3ytyZdsr8njsb8db68Auvud0e57Wy6ItVvmKjO43ZbBgdqrcyzEes0rLt67rZ/HusJ3
         7Z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854084; x=1785458884;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Alx5+6ajemwcdZLjQENBxyMOBgE6MWN8o6tlzzoEhF8=;
        b=nVB4JR5IPePqKe1rS088kxCL58nsPr2wl8Gr9yJlotiqz3f4o6B7KGvx4PDMmQGHCJ
         s/AKe0B/Noy7t5mmZDuX5SRO24loKHbhUOvLziaBNWxGJuWxnfKWEAiKf9fvG+BxVSpi
         EWwzPA2s4Uqm0cTdPrlqSh2HLejyv1dYLvPh3VYA6Frb1JfQO/fYn+/AKCgXcGcomo1/
         905r8mcNXHz3tZgRouGvoZ/PNCqSEXafFCZLpmGzr7E3IMcARZG3xAc6VRz7GdqQaw4J
         ceYpx4/G1ayRU+aB07xz7JTb4E+3WuN3mIAPTYRXBtciEw59M/hseGq5RhFJYCxujd/p
         vmZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHVubjvz5ga3s1CJh3nLPNv40io6SZL5suiG0SCbHJzV/+C0KZJKIensyYJKHKKsx7DsHK8yyl/PXvlWc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx7WgPsAGaGcEWIlL2Vr7IBhLdK8ZWlS0AbXMK5pK8dNwy8Owao
	Gll9rq+bfC9lWved1RwMoUbRCKHAeHwA3b3+UY4ECtkbPL/N2X2RfGQY0Kdv4TstS8Li0SXw4J8
	axLBQZA==
X-Received: from pgbee3.prod.google.com ([2002:a05:6a02:4583:b0:c99:d21a:f6b1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e292:b0:3c3:b226:f165
 with SMTP id adf61e73a8af0-3c44b18d6cbmr6214167637.35.1784854084080; Thu, 23
 Jul 2026 17:48:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 17:47:54 -0700
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
Message-ID: <20260724004757.131420-4-seanjc@google.com>
Subject: [PATCH 3/6] KVM: nSVM: Use CLASS(kvm_vcpu_map_local) for SMM VMCB mappings
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Convert the kvm_vcpu_map() usage in the enter/leave SMM flows to the new
CLASS(kvm_vcpu_map_local) implementations, to eliminate the need to
manually do unmap() in error paths, and more importantly to eliminate more
of the open-coded on-stack "struct kvm_host_map" declarations.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index bf10483c0e8a..7a417e717fd9 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4987,7 +4987,6 @@ static int svm_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct kvm_host_map map_save;
 
 	if (!is_guest_mode(vcpu))
 		return 0;
@@ -5021,24 +5020,20 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 	 * that, see svm_prepare_switch_to_guest()) which must be
 	 * preserved.
 	 */
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(svm->nested.hsave_msr), &map_save))
+	CLASS(kvm_vcpu_map_local, m_save)(vcpu, gpa_to_gfn(svm->nested.hsave_msr));
+	if (m_save.ret)
 		return 1;
 
 	BUILD_BUG_ON(offsetof(struct vmcb, save) != 0x400);
 
-	svm_copy_vmrun_state(map_save.hva + 0x400,
-			     &svm->vmcb01.ptr->save);
-
-	kvm_vcpu_unmap(vcpu, &map_save);
+	svm_copy_vmrun_state(m_save.map.hva + 0x400, &svm->vmcb01.ptr->save);
 	return 0;
 }
 
 static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct kvm_host_map map, map_save;
 	struct vmcb *vmcb12;
-	int ret;
 
 	const struct kvm_smram_state_64 *smram64 = &smram->smram64;
 
@@ -5055,22 +5050,23 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	if (!(smram64->efer & EFER_SVME))
 		return 1;
 
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(smram64->svm_guest_vmcb_gpa), &map))
+	CLASS(kvm_vcpu_map_local, m)(vcpu, gpa_to_gfn(smram64->svm_guest_vmcb_gpa));
+	if (m.ret)
 		return 1;
 
-	ret = 1;
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(svm->nested.hsave_msr), &map_save))
-		goto unmap_map;
+	CLASS(kvm_vcpu_map_local, m_save)(vcpu, gpa_to_gfn(svm->nested.hsave_msr));
+	if (m_save.ret)
+		return 1;
 
 	if (svm_allocate_nested(svm))
-		goto unmap_save;
+		return 1;
 
 	/*
 	 * Restore L1 host state from L1 HSAVE area as VMCB01 was
 	 * used during SMM (see svm_enter_smm())
 	 */
 
-	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, map_save.hva + 0x400);
+	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, m_save.map.hva + 0x400);
 
 	/*
 	 * Enter the nested guest now
@@ -5078,24 +5074,18 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 
 	vmcb_mark_all_dirty(svm->vmcb01.ptr);
 
-	vmcb12 = map.hva;
+	vmcb12 = m.map.hva;
 	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
 	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
 
 	if (nested_svm_check_cached_vmcb12(vcpu) < 0)
-		goto unmap_save;
+		return 1;
 
 	if (enter_svm_guest_mode(vcpu, smram64->svm_guest_vmcb_gpa, false) != 0)
-		goto unmap_save;
+		return 1;
 
-	ret = 0;
 	vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
-
-unmap_save:
-	kvm_vcpu_unmap(vcpu, &map_save);
-unmap_map:
-	kvm_vcpu_unmap(vcpu, &map);
-	return ret;
+	return 0;
 }
 
 static void svm_enable_smi_window(struct kvm_vcpu *vcpu)
-- 
2.55.0.229.g6434b31f56-goog


