Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3B5606A9B4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fBVqW782
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYvC6DFFz3cML;
	Sat, 31 Oct 2026 08:21:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395303;
	cv=none; b=GxVGDL5w7VAVviFdFfonth6Ey84Wx8aD6kOchp6LqXoEpACMcJJuhpMMI/VC52LqA9oMgad1Xm3byhY6fD2WTqMPSgdyKV9DOBtYI+QKYHwzgcd8CwPJlmF0BaLfmD9t7bjkFnVeBNL8eZKKGOz7JMnXCJhctdA4vhi7crcnMg55ivd3xQRhoN2DBjNBmRjHuN79TAzu/5bWcp0mmJgU/eBSZQCO4EBkGG5zbWm5NOjxWXhcelIZ9GnlJUwTAZi/Y+tQ5gYgGLlddyf1G6ktBNTFIPIf/vGw8CJtdI0oX0XHTiOXZfBkImiPEfBaHMLIYsrRfilj9TGTvHZfFDnb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395303; c=relaxed/relaxed;
	bh=5FKhrgmuBOI6zmiBkedaxKopKidBxwZmFCvEG3c53fo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G4+huUXQlt4AfFAXdXaM63XtQw1gxkfj4hv7x/Zi2jkOfVnH2rkkBuvnOjZU8efC/o+Q2fTTfNfkz0vbkEYZkegCb/jCeEKm4Ha05xsEkigzbXS+8WJU7sq4QsOQUIhYgFQshfBlYjBzPgcIqO5c2vVTVxVqAjQWZlAlHXJUeA+8dIM87gy4WrwAx+kwlCJfmWGfecfSYxUPWvMkmkbTZkHfr1hg4P78dXxWnc/AzjkdEmFSooCuMN47mCOtvcZbBmvmA7JhbwdMR3hSZArIDs5P08hHDBEcXg7W0t7h53jV4ROGytDr0+gcHAsXOwBF/Jy0EZoqO8uYYLD/tzpxtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fBVqW782; dkim-atps=neutral; spf=pass (client-ip=209.85.216.70; helo=mail-pj1-f70.google.com; envelope-from=3zarlagykdgsbnjwslpxxpun.lxvurwdgyyl-mneurbcb.xiujkb.xap@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fBVqW782;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.216.70; helo=mail-pj1-f70.google.com; envelope-from=3zarlagykdgsbnjwslpxxpun.lxvurwdgyyl-mneurbcb.xiujkb.xap@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYvC0yDQz3cM2
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:43 +1100 (AEDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so1693070a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395301; x=1794000101; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5FKhrgmuBOI6zmiBkedaxKopKidBxwZmFCvEG3c53fo=;
        b=fBVqW7822uDyt7mvlTGpVRd2D8Yv4rdP+UnqhGZ6hj8oJr0vMzh6e0FZ0DPHtMuFa1
         5Q2kUXaO24imK2svDRrpyqnomQl0m3UZflWZiufuCQE6dnWL1lHSVTzljZkhSkmvYkPC
         MtBqV1Sdn1En1k/FR6dP0Q4pzqawTHzFYokb75AdY25FFJkIGwhQTKIV+2O0EiVJ4SNa
         3zg0J5Uzv9zqYNp3YG193RFUA/uLtdVA15JSZlPsw7PtW/Poj1rvxJDX6O2HsZtQDSgg
         CFPpANY4WLsJ5N2eoV8AU0d57IkyRdQgZ5d4QLmH2z1WmAlDHxE+gaYHUmrVT+5gckK3
         O1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395301; x=1794000101;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5FKhrgmuBOI6zmiBkedaxKopKidBxwZmFCvEG3c53fo=;
        b=G4tgfKlEZjTZUvLcLzpYTVk3vaZegCXtbbLClHwB/1TFsrCNd5UHvbFcgVWEjtWeMo
         tCuaCa2UbkFiYvN5jbrlxwCNcxK0oKSseGLwmDzbiy7gSefLkOO8ISEr0rdF3MVGB0fx
         eZwZy/KvEnaZKqrpVxnmySJ7dHqQw7uqYPb/HdKBHTUpJgwD1Sy/CcLm68o2Q7Kxcs4p
         RcyjrGt17UnYOpvUPICZGdC5hazvGGaS2PvusjvdxFUsiFEE7wlN4D0Iu5D4Hm1F6AV8
         2Vr1xjZNmS7wBFuce1KVjGzD1bB6HOe4bQPmWsinNjwzuFB5cU7ORkB2mor/P8QRnmvk
         NCIg==
X-Forwarded-Encrypted: i=1; AKwUvBz37R1gyzas97hsQ/C+R4Hr0SxH83GXJ3QY+4WD/FkNWO1VAkuwfV1r7uaV/kZ9iHCI25hGU2kA9E1vFLM=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIHMtmW17GKJdHlQ0qjZ+CW5OvZl9P3JRjgeUESP0kHkTJmMxlE
	VunORTf+1lf3yQtLsRvbmuodpJkru+ZzFd+oG32eLiUCCpIFl8F94RAWhwmhbuOkCof+Rhw2kkq
	jjPzczA==
X-Received: from pjbpj10.prod.google.com ([2002:a17:90b:4f4a:b0:3ad:6c5f:feb0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e70c:b0:3ab:2737:3393
 with SMTP id 98e67ed59e1d1-3ae89835d94mr2921939a91.40.1793395300614; Fri, 30
 Oct 2026 14:21:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:10 -0700
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
Message-ID: <20261030212112.2598640-23-seanjc@google.com>
Subject: [PATCH v4 22/23] KVM: nVMX: Don't load+put the vCPU when freeing
 nested state for a dying vCPU
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

Drop the vcpu_{load,put}() pair when freeing nested state for a dying vCPU,
as nothing in what was free_nested() requires the vCPU to be loaded, common
x86 doesn't require the vCPU to be loaded when it's dying (because SVM
never loads the vCPU), KVM now explicitly handles taking the vCPU off the
PI wakeup list (was subtly being handled by vt_vcpu_pi_load()), and the
rest of vmx_vcpu_load() has no effects outside of loading/modifying the
VMCS or vCPU-specific metadata.

As for put(), because the vCPU obviously can't be loaded at the start of
nested_vmx_free_vcpu(), "guest_state_loaded" can't be true and thus
vmx_prepare_switch_to_host() must be a nop.  Similarly, the vCPU can't be
blocking when it's dying, and so vt_vcpu_pi_put() is also a nop (and if
it's not, that would be a fatal bug as it means the vCPU would be left on
the PI wakeup list after being freed).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4a8f57eb3277..51183520f64a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -330,7 +330,7 @@ static void nested_put_vmcs12_pages(struct kvm_vcpu *vcpu)
 	vmx->nested.pi_desc = NULL;
 }
 
-static void free_nested(struct kvm_vcpu *vcpu)
+void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -390,14 +390,7 @@ static void nested_vmx_do_vmxoff(struct kvm_vcpu *vcpu)
 		free_vmcs(shadow_vmcs);
 	}
 
-	free_nested(vcpu);
-}
-
-void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
-{
-	vcpu_load(vcpu);
-	free_nested(vcpu);
-	vcpu_put(vcpu);
+	nested_vmx_free_vcpu(vcpu);
 }
 
 #define EPTP_PA_MASK   GENMASK_ULL(51, 12)
-- 
2.56.0.385.gac671c819a-goog


