Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD82606A990
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X8h/WbDf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYv71qKwz30Tm;
	Sat, 31 Oct 2026 08:21:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395299;
	cv=none; b=YSZ+4EyrzDfsJijdKmjUrrGJkG7kiinzgGXLVpaJ1auUSQ6E9wooXuPL6Pjg+My24Rb5LwKm/CoW7pjWJ2/2IFgQMHJBTIpeZFLtc9r4NPk/nkavERqUQYfciUAWSPf8xfx/xAjuO+zBP9UWd3Musm6LtlQULtFJuf4uA34WfoC880nhk9K3Kl6TnQ8x2V288feR1aFAyums01LPuzsu4zxmitiSImoQF3sr0y//ceI9RH2XWC7TJHxwPAbI8wWPNyIFslXnwNRSAt2GSecZzxbw6g4FVf4a66Xw+0g6rPH2d7+rFzQhpnMkFSxN5tZRIidjc5DxG+oA4Qx9CaskMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395299; c=relaxed/relaxed;
	bh=5bp4E318lJOU9KTeZ4/sgGBHaMDL7s7CdLDZqDaaPsA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a+Blvgn2vL39T1DypAgkWTNS6BBXIz42zrBuX0aDUEe+AesFq/ERh/TVxModvmF6SppuuN/SkgXKYgXlRa8xpZm6lesMfgjeA4IhuIFZomhHWtqoOAbE3GdSAb0C0V+jsmXl+m8VwNxs1QP5DcMRM6hSXrl+D+RrepUHKPZjshEJzee3/snBeftc/31GOJCNgfpOfs/fiN+OtAa9TilxJelrN3hydvpGetOGxAWLbFNsDzp5m8V4pmjGaPoHlpQRoO/hLL+WrelnUFNJk2NFgxlBRIHUfdb/AsKhW/w/p8WzPamhdyOSuSvOFqMbyukEcl7dkpKZeRPM/QY+//fMYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X8h/WbDf; dkim-atps=neutral; spf=pass (client-ip=209.85.210.198; helo=mail-pf1-f198.google.com; envelope-from=3xwrlagykdgywierngksskpi.gsqpmrybttg-hizpmwxw.sdpefw.svk@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X8h/WbDf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.210.198; helo=mail-pf1-f198.google.com; envelope-from=3xwrlagykdgywierngksskpi.gsqpmrybttg-hizpmwxw.sdpefw.svk@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYv63Jsdz3cD1
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:38 +1100 (AEDT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a0688a43d3so833784b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395296; x=1794000096; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5bp4E318lJOU9KTeZ4/sgGBHaMDL7s7CdLDZqDaaPsA=;
        b=X8h/WbDf5KULHJFg1smRxVNpLyO94tjIOKszb1qcXLn2bsS3VkUckUMSIn/2l9oZ/d
         0L01L92SmcRZ4psBqPtWOVwHHaQ0zNsqgMqVt2unBP9tMiwoWOfcVtiLKiokOYwlGAEO
         d/GqB/bJG4VBQRIC1d3+vEAMdrG9aP4LkgEBEXpGVFKOMDWjTdkHIJu5/SAHMV/VNA6D
         Dqq8gGsqBf8kbQv1yORHhlzxSUv5TZlKGOt9oNeGbA6XNCp+bXLfKFIrVdppeH8mufWH
         vewC4Gk1z2Y0lR7gaTFwNUHFsn7oU5vit62eWaxEvqMCZaIUei38y24DzzAGlN3sZoSp
         LhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395296; x=1794000096;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5bp4E318lJOU9KTeZ4/sgGBHaMDL7s7CdLDZqDaaPsA=;
        b=dDhaUw7kIPALwas4n2e2m0gOV4kUHPYHCQok/DBwqXsFrCsZro/RZgsjL1ehcFe/HO
         oKygstmWK68IwfMMLmnsX8T3osEE+tjgR2H4mtfQ+7KVJhNhPYvq52RjcS28MNqS+bxz
         FbjJ+v+i0TpLnr9Xngd17W/m9OFomeaNxRrcu/dSeejQ/+teFN0c9vp5TmQaimTdmGba
         icbOopkxk16Tdle6746JrJTJYD/zelEwou0f7xBZ1sWV26fEp+vSC1znB9eWtuc+FwX2
         7UWOA8cf9mMXV5bsDPmIClrmPxLI4WMDyJmLDF573Sme22Onw+UIcYBHUa2BJ011t4Wi
         vKkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzf+eVzYhQyuv5TwXKEUlAflZVv+REmdRLJQX+0+/sgaXZX37GgOvEGH29pWSvF6dr7PTN5rR2uF2hhuiI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKiSwhOO7U8vSdSHy1wlVefabfwq7jxJHA1dlxc/7gs5eRfYjYL
	wdqdcHJHsHxHKctdz3MpBBJToNLS9dznql6IFRPgMtzemGTaNhRK2v8/X3XF3zgZrnjaq/xxe2m
	iIMBesw==
X-Received: from pgdo11-n1.prod.google.com ([2002:a05:6a02:620b:10b0:cda:ea8c:c389])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:8201:b0:3e2:7643:30b2
 with SMTP id adf61e73a8af0-3e928a7a901mr3766488637.3.1793395295633; Fri, 30
 Oct 2026 14:21:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:06 -0700
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
Message-ID: <20261030212112.2598640-19-seanjc@google.com>
Subject: [PATCH v4 18/23] KVM: nVMX: Cancel the nested VMX Preemption Timer's
 hrtimer in free_nested()
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

Cancel the hrtimer used to emulate a VMX Preemption Timer for L2 when
freeing nested state instead of precisely canceling the timer if and only
if the vCPU is/was in L2.  hrtimer_cancel() bails early if the timer isn't
running, and KVM initializes the timer when allocating nested state, i.e.
canceling the timer even if it's not fully in-use is a glorified nop.

Canceling the timer even if L1 is active will allow KVM to leave the vCPU
in L2 without having to retain an "is_guest_mode()" check just to cancel
timer.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1b30ad7731ee..553915015a75 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -339,6 +339,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
 
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 
+	hrtimer_cancel(&vmx->nested.preemption_timer);
+
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;
 	vmx->nested.vmxon_ptr = INVALID_GPA;
@@ -401,7 +403,6 @@ void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
 
 	vcpu_load(vcpu);
 	if (is_guest_mode(vcpu)) {
-		hrtimer_cancel(&vmx->nested.preemption_timer);
 		leave_guest_mode(vcpu);
 		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 	}
-- 
2.56.0.385.gac671c819a-goog


