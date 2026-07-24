Return-Path: <linuxppc-dev+bounces-24750-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D068FC531CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 00:48:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5q922mt0z2yS4;
	Fri, 24 Jul 2026 10:48:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::548"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784854086;
	cv=none; b=dBGPutRPzt4qYUqX99njolYdMpBt8BgUxQtF2Eg6M+YI6BeMM+Qy7bKzV/p3D0IDBbo8PbPYBG03BYQ920C0loauOCbYIh5BGF0/01HG90F4ir1xOraJei5lYMlX8uQnjZvBIFgtdnNaTmTM9ew+V7J3M+x9D6qDHPPYfrQmUoWS/K698Mjvb98FMjIY4AGYZZ1F39Ch1YXXye+POzr2wwva75W3DG/BGGRuKeXSxsQUSK37eZUBBjMhyM26E9+UjCrhGBxqj+pbhyEDvPbBkvD+MsT4zJlhq58D0mCKjb1bu1U1BpAefjy0inMt0VTcD8wbW2zOGkfQeiszPE1acw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784854086; c=relaxed/relaxed;
	bh=+KAdYpKsVpQWTrdyWSZ+uQBEtcV06POwwOgp0O+/BnM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nQax0YvKjqNK/RlU16VFyHKSXNd98+mNXZurpTR8D6Rol5J0x+Z48enfjUoSS/J+miVlwmtsbQuefc/sDdVYxaJ393cm+qMqRD+g+1cYJSkateVAdXxWBpDTrHaZjCDuTpgO0NJ6MF3cMmN7EFRxtDY1bbPE7CbbNuCjjm8RwPeDvXx+nZIZA+2v8/z9f2sfgVhWZPj2D5SDl+O9WMcKRoQJILmSA76YAhE91NLCJr8PkNBCZVrgxVJDU2LwU+zwfCEvGv9mGuHZDHixoxl45tuxKFynpBmQSdm1E7G8pvQ5HWmUy/r4XS3qOmB8JNNdpJhmxmVD5KxKZM3cdqcMUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LIA70J+X; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=3qbziagykdjie0w95y2aa270.ya8749gjbby-z0h74efe.al7wxe.ad2@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LIA70J+X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=3qbziagykdjie0w95y2aa270.ya8749gjbby-z0h74efe.al7wxe.ad2@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x548.google.com (mail-pg1-x548.google.com [IPv6:2607:f8b0:4864:20::548])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5q903C5jz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 10:48:04 +1000 (AEST)
Received: by mail-pg1-x548.google.com with SMTP id 41be03b00d2f7-cbb92868263so1627920a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 17:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784854082; x=1785458882; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+KAdYpKsVpQWTrdyWSZ+uQBEtcV06POwwOgp0O+/BnM=;
        b=LIA70J+Xj01BFI/pzoo53HcviAbmeFGEOPPZnOpmeEVC682Pco6oxLjJk4HcHMJuYE
         fuZMyP0fBduIh5l3lXMxkic6Maaio7RArUo7lwJ7nmky4WLjHig46feTJWGYRwxqpycp
         wjXQAd+tWrtH79QUj54sbYnLddKF+pYDvnplhHAUPBbsApQzY8pBxtneolIxYfbL4tin
         wCRGRJ/tvTcx2KAkEu40QdUjFN765UCViGHTPa3ofZ4ZPiNDgTNcbf0acLATnNr1FwO7
         KhUF1lWIQVt7Q7oldDvdY+b4mSAZLH8an8Nn/uoBu+m86jznl1CHLZn8lI8Ag0uk3u1+
         iKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854082; x=1785458882;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+KAdYpKsVpQWTrdyWSZ+uQBEtcV06POwwOgp0O+/BnM=;
        b=aCoabxikac4x00+RCSHvvrD1CckWJrbbXJ7ALlxjFriyt5eoT28pKfFYWE5d83oti3
         /+cbX/xDrA/hVfv/lj5l7fxva2rh4x78Y8ZTWdBwA8ihLMSNh/46Axyujsm7YeaOCXn6
         J0wM4UbjgppTeG6Oho07m5ZDlzTVrXkvtJGoM5oJGMgwXXAjEw/AXH/r3mTOVG3ViKBW
         ICuYs2dtIM5YspbZze7o+apvWK+3Z9lmfP6EE9F+zEHFjBStK7plnn6ROT15s+Izfdbj
         Y3RLJd+/bXpw2WuLXTLd45mSibgY2ki5hyfM+hEmBG3j8dnhu/qBtldsldc5lHGvyCmT
         KvOg==
X-Forwarded-Encrypted: i=1; AHgh+RrBYK8G+xIfY+EQmEa/+EsZDxX5VT3Dn7tHbsQ9KhUEPSBexM2T2kkPZYKQ5PPXJymtfV/qLxvvj8NcJ/U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyW8PcRu+7UEFVkGKN7LZRBTqigmAnUWfgMOJEZ1Be7o1vajhW9
	h3VaC+TWlDDAuNbmn0Fn6J/F0V/9cFS+NWMvvmGrTxzawWFtR4EAnYS6u8U8tFbDKNfxNDfbN8e
	3heRA4g==
X-Received: from pfbjw39.prod.google.com ([2002:a05:6a00:92a7:b0:847:aa6c:47fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:300f:b0:848:2cb2:cd97
 with SMTP id d2e1a72fcca58-84e2bba4c21mr6791782b3a.52.1784854081825; Thu, 23
 Jul 2026 17:48:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 17:47:52 -0700
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
Message-ID: <20260724004757.131420-2-seanjc@google.com>
Subject: [PATCH 1/6] KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is
 cleared on VM-Exit
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Always check and clear KVM_REQ_GET_NESTED_STATE_PAGES when emulating a
nested VM-Exit to ensure the request is cleared, even when KVM was built
with CONFIG_KVM_HYPERV=n, as KVM subtly relies on the "check" to clear
the flag and thus avoid double-mapping the vmcs12 pages, e.g. if KVM
manages to bail from VM-Enter without processing the request, and then
emulates VMLAUNCH or VMRESUME.

Fixes: b4f69df0f65e ("KVM: x86: Make Hyper-V emulation optional")
Cc: stable@vger.kernel.org
Reported-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b5460de4b1a7..f2518d67e7de 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5066,8 +5066,9 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	/* trying to cancel vmlaunch/vmresume is a bug */
 	kvm_warn_on_nested_run_pending(vcpu);
 
-#ifdef CONFIG_KVM_HYPERV
+	/* Note, "checking" the request also clears the request. */
 	if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
+#ifdef CONFIG_KVM_HYPERV
 		/*
 		 * KVM_REQ_GET_NESTED_STATE_PAGES is also used to map
 		 * Enlightened VMCS after migration and we still need to
@@ -5075,8 +5076,8 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		 * the first L2 run.
 		 */
 		(void)nested_get_evmcs_page(vcpu);
-	}
 #endif
+	}
 
 	/* Service pending TLB flush requests for L2 before switching to L1. */
 	kvm_service_local_tlb_flush_requests(vcpu);
-- 
2.55.0.229.g6434b31f56-goog


