Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7438B606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NG6LXXJ6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDl9B0BX3z3bV5;
	Wed, 28 Oct 2026 09:12:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793139149;
	cv=none; b=GdZHepYi7EpKbqzqJuHT6qGMzZ/L6YibYiiDUSJZ1m120ax9cYILhDtbEoCZ1pXK++xZc9j/pvCfgSXVp8rHnI/p91XT9ZY12T4GxeUISaHTaN2q/ZOVQNrOWDkCXibR8RkNumZcrFofSvg6jWmTe0IkLVzv2h2yLZtylERGq16V8tv/N5fQnR3KaPvsuablf1xpa1kaVNVoK+mZETrChxfOsWY4PafGuBvjmF2AE1r8NowQvqcS02qcvIX4gzLx7PVcSR0SLQbXnMO+qZ6rxFZ7cVFdK6hh0Y08PzuROZyjoNfGpyDZtpErl3oD5gqR92Xjf7ZUNeajeONTMNhdAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793139149; c=relaxed/relaxed;
	bh=7KZPmVSe/mbc0d3PV2oDcK5UvV7diSgsE22iAyaAi38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c20JLU5vXouw2F0SnZCwp2/xqFWARf3y45ECgkJs+aCM7jLVT+vLqnSDE24iJga2QgG5tpOIi5ebC9TkPYhv8CEZXxOsrst2kb8ktaqpfAf0x64sNhdfFetX59uEpryMpa9kbSWWaeaoZYHPyMyV0/Bugor3CHoM/s67zdpFwOSINggHrhql5DikBg02NVk3g8H+ay+WClcW3hl77utWQYj7fx5s0lvDkMBc/NhKuS7/07NQHxGlLlJXExqlca8V76QJSiG/5T4EiMBuDrlzSm7ZfU4OhBbgxKTZNx4MSt+t1HT4PM1Ap+thyq5Cc3vdnTXJ5BoIDOpkKyT+V3KlFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NG6LXXJ6; dkim-atps=neutral; spf=pass (client-ip=209.85.216.72; helo=mail-pj1-f72.google.com; envelope-from=3ychhagykdo0htpcyrvddvat.rdbaxcjmeer-stkaxhih.doapqh.dgv@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NG6LXXJ6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.216.72; helo=mail-pj1-f72.google.com; envelope-from=3ychhagykdo0htpcyrvddvat.rdbaxcjmeer-stkaxhih.doapqh.dgv@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDl990yxKz30Vv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:12:29 +1100 (AEDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3addd73e66bso301797a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139145; x=1793743945; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7KZPmVSe/mbc0d3PV2oDcK5UvV7diSgsE22iAyaAi38=;
        b=NG6LXXJ6O2t5Qq0yr5Aum4CAlKMKZsC/XinYcdPY1KL5kHitBu/FP697GydjKdjYvU
         b388d7LfMR0s7m4qOe1EqVes7lwkx2zlYC25OKen11qpFkmmS0hxj/bY2XVvYDc6i+Xr
         OQA/mmzJONs7rgMg+sdoBA/7p86xm/hWLbEsSb0P9v0LGPVwA9b47Rqokh4HhAOYTRcJ
         G8LOebjUjJjHIeEGb2SslE1rP1dTyTnEoYLo8Fkl282utu1Ll5EFZe9iJ4B0uK2p7XDf
         kwaO0Pyj8YzB6rNMCNi4GfXitWH93LjI7hL9r+NYa/2fmthI3KmaKyOzqdZIYe7KOdeZ
         2LAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139145; x=1793743945;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7KZPmVSe/mbc0d3PV2oDcK5UvV7diSgsE22iAyaAi38=;
        b=oVGV6322MEpqpkjtQHXssOJfqMZdhmrxyh4iAbjDxebiY7HlsWGizHG6++3NwVuN26
         OvYcqZakTYFtTTi+CYv/GCSTOxZ0843xPmLCgVJtXJDYQMTWszXdKE95D2LohIbMZ11C
         JTgwssR+RNkt0iHRRx6vlYXE1G5k6nhV8Zi0R8vTh5AqgZkqgk0tKY3BDI2ZsidLQOr2
         YLXosJatsfmdBnxEnRYHis2KLv64waHf3jg+8shOrYrm3GhJvr8ibXxhOR28HWrpkbUp
         5hMo10tiJvgZGhaS3G11jJixqEmIwbSEIj6vyu5DBbpcnk9CuYkRGWieLCquUYLAyK4b
         UW6g==
X-Forwarded-Encrypted: i=1; AKwUvBxK0nXrB1X3336+V6md/joqmWiYaE/y4kK3lfETxxLRXyg+elyWRnNmTq1+MQIkcdpE3DxdK29BeUyQfwY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKPzAy6MMM57gGxsp+HPDL0NJI6xHDoyjS9BTcEU7wB1IoPVG83
	JJn4SDRs0h07MpYPTvF41Cum+oHarg1uY42HsroSX19n4NxpGhSoAs76r2bY0E/hhqmkNuzbvjY
	3WGmH3Q==
X-Received: from pjbdy8.prod.google.com ([2002:a17:90b:6c8:b0:3ac:2cdc:a8ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fd92:b0:3a0:d265:3647
 with SMTP id 98e67ed59e1d1-3ae57e357e5mr211906a91.8.1793139144546; Tue, 27
 Oct 2026 15:12:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:03 -0700
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
Message-ID: <20261027221209.1560865-11-seanjc@google.com>
Subject: [PATCH v3 10/15] KVM: VMX: Explicility free vmcs01, not the current
 VMCS, in vCPU free paths
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

Explicitly free vmcs01 instead of the currently loaded VMCS when freeing a
vCPU, as relying on loaded_vmcs to point at vmcb01 is unnecessarily risky
and confusing.  E.g. during vCPU creation, the error path relies on setting
loaded_vmcs and obfuscates that it should be impossible for vmcb02 to be
allocated, let alone active.  Similarly, if KVM were buggy and left vmcb02
as the current vCPU when freeing a vCPU, operating on loaded_vmcs would hit
a use-after-free *and* leak vmcs01.

Because KVM isn't buggy, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d433cd846ac4..2ef1f634e7ec 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7515,7 +7515,7 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 		vmx_destroy_pml_buffer(vcpu);
 	free_vpid(vmx->vpid);
 	nested_vmx_free_vcpu(vcpu);
-	free_loaded_vmcs(vmx->loaded_vmcs);
+	free_loaded_vmcs(&vmx->vmcs01);
 	free_page((unsigned long)vmx->ve_info);
 
 	if (vmx_can_use_ipiv(vcpu))
@@ -7614,7 +7614,7 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 	return 0;
 
 free_vmcs:
-	free_loaded_vmcs(vmx->loaded_vmcs);
+	free_loaded_vmcs(&vmx->vmcs01);
 free_pml:
 	vmx_destroy_pml_buffer(vcpu);
 free_vpid:
-- 
2.56.0.307.g5fe7bd680c-goog


