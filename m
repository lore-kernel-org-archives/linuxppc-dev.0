Return-Path: <linuxppc-dev+bounces-27870-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2934C982EE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 17:45:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpVx41KZTz30gp;
	Tue, 22 Sep 2026 03:44:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::545"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790012696;
	cv=none; b=eJr+eeMfdoKelY46CZ5AlZ0/115Y8eKK/ZINTmiwg4Rvu0zRuOM3oFWqkAhPDv9UMgVLjnvbWsxAwwIsn6NHZT4aLN3xjBgCAmEk7eTo/oOx2FNo3sKRNbO88PeakbWNZh9pAWha8kAW9SQOSTWEzDZjgf7HxH3Q5arWQDHg+LCz4ZYw3gN6v4U4pTRriBIV+WldABq1t++o9DyfKdjq/35CtQK8OgLDjnCyobnymJkgxSSpNenBqVCE1aMSlzBW6N0z09YZz5wIJLutawKKLmw9J2Ip2XYH5G4YTUyp/hLeSJZiY5bOpO5004usStcUl/Uqup4K706ANIO+BUkv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790012696; c=relaxed/relaxed;
	bh=QYiGmxrgAXU1trJ4S0lv2S3WvlXO7vDS7xlQ1HDVynU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HQxCPp5zZWv7yWyISWm087M3hdV4hkbHOYs+jxlvsjlFYTyvWSr7fbo62e84N03zpLIYs4jbIAqrE052gnjWKkFYOk7BFaWY2qOGGv96OGYIOxlfdAtQtz9Y0Uf/VY6+8uR+E9p2luC2WM4Ryi0VDt/KuUmo1vWNSgy6qj6LxzIUwWdduODcLT21dTsHKhZhnpQWPEfG6wj7j2Fd0jt/R/xTCbJsRQ3iKoc7nJ9thJclkAz6+amaea9QqhyVRr6biQGH8rTBmeHkr6vjMIqEhNeicWhJJRcFwim48ImJzzKwvijk4DUcl+bNC1j0WW1VoBIvVTJW35PW/iaDVW5XXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TvJoc1eK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::545; helo=mail-pg1-x545.google.com; envelope-from=3fw2xagykdbiaws51uy66y3w.u64305cf77u-vwd30aba.6h3sta.69y@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TvJoc1eK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::545; helo=mail-pg1-x545.google.com; envelope-from=3fw2xagykdbiaws51uy66y3w.u64305cf77u-vwd30aba.6h3sta.69y@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x545.google.com (mail-pg1-x545.google.com [IPv6:2607:f8b0:4864:20::545])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpVx33CCvz30WJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 03:44:55 +1000 (AEST)
Received: by mail-pg1-x545.google.com with SMTP id 41be03b00d2f7-cc44d708055so517076a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790012693; x=1790617493; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QYiGmxrgAXU1trJ4S0lv2S3WvlXO7vDS7xlQ1HDVynU=;
        b=TvJoc1eKGn9dHyt3qa5DDJrTxA7cpvNM/HlQ1iMpMjLvDwOinWFZrLEWkmDWVm+AyX
         kGJdVxASBO2SnkhD+cU+TNqRd7R+Rq+Gwrtx0d1QgCvfURW8OdtPtsEnHI9OC5ZwQjCv
         nDhHNSkdqxm0jSQdFstzwrqkTCzU76d6JZHmJrSzfX6Pmf4qYfYfBM66BoNFoMKjy9aM
         AKkU5eCt4RL6ugw0f7bzlTEjEWNU8YvToAGRCPrJPxfbruDjb4d36vUD5YKGgJ446kh9
         zJEE1pbZ7F1ls5DP1pmw0HJe3LBh7TIHyIO5/2pwerC287niUXBF6Hdkpp8njCPWIo/G
         u1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012693; x=1790617493;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QYiGmxrgAXU1trJ4S0lv2S3WvlXO7vDS7xlQ1HDVynU=;
        b=S9cMF/kQjiDV2t+ov13tIDIqkqSellp2frF67SPdLi9sc0OjtFkBuvqHtTMclYPnK7
         u4rxAFwrkLjCSgiWKMTR7aqRcpmtZbi3SQvhUAIeew7pPvGP2Zrn+QY2MWP2gInr/ZFS
         Onv80hjn4eZCFHJyWxpEpkHTlmEjckcOQGHAofuxt3fIs67f7MNR/B00dI7jwgREdfeW
         /b+lDlFb7t8dgeXEmmStpLFNIRXrypHVzEZpjYJEQgGwk14rUiKDVEAEhSrEUQyVg6qn
         4vV+/AP0W7/sw9CmCRmeS6hytwzDLpKnbaQWoeB5iya05k6W8UTwPxChOxHwJU5OHaBC
         Ir4g==
X-Forwarded-Encrypted: i=1; AKwUvBxPmDTFdYJWFkNr61dckbBaXAThaK3SYcys7E1DadjX3bARsX60RfzZKpf68YBF69UTnXi9I/a+ovknTR4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lrh+A8sXEudSm+YP4IeGBIlmzOtGN34ZO7FNwNG4Kosc5sZ/Mu
	Fa5j4lFExo0/0LZ91ZPLSWhv7HyJo2EMufrrJT+RuIX9jWwtcy44Q8LllCa1rP7g8C/4IPmtyob
	CvOdc/Q==
X-Received: from pfbhu19.prod.google.com ([2002:a05:6a00:6993:b0:879:55dd:922d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ad89:b0:85f:3d78:79cc
 with SMTP id d2e1a72fcca58-874dc4ed21dmr15528120b3a.9.1790012693049; Mon, 21
 Sep 2026 10:44:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 10:44:43 -0700
In-Reply-To: <20260921174445.911676-1-seanjc@google.com>
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
References: <20260921174445.911676-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921174445.911676-6-seanjc@google.com>
Subject: [PATCH v2 5/7] KVM: Move check for existing vCPU ID to the top of
 vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, 
	"=?UTF-8?q?Pawe=C5=82=20S?=" <spawel523@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Now that kvm->lock is held for the entirety of vCPU creation, check for a
conflicting vCPU ID at the begnning of vCPU creation, before the arch
precreate() hook is invoked.  This will allow reverting commit 97d65b544f48
("KVM: Check for duplicate vcpu_id as early as possible").  For now, keep
the redundant vcpu_ids tracking as a sanity check.

No functional change intended (absent KVM bugs, checking vcpu_ids and
walking kvm_get_vcpu_by_id() should yield the same result).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c17cc8dd371b..d5524ac8c5cf 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4182,7 +4182,10 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	if (kvm->created_vcpus >= kvm->max_vcpus)
 		return -EINVAL;
 
-	if (test_bit(id, kvm->vcpu_ids))
+	if (kvm_get_vcpu_by_id(kvm, id))
+		return -EEXIST;
+
+	if (WARN_ON_ONCE(test_bit(id, kvm->vcpu_ids)))
 		return -EEXIST;
 
 	r = kvm_arch_vcpu_precreate(kvm, id);
@@ -4221,11 +4224,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 			goto arch_vcpu_destroy;
 	}
 
-	if (WARN_ON_ONCE(kvm_get_vcpu_by_id(kvm, id))) {
-		r = -EEXIST;
-		goto unlock_vcpu_destroy;
-	}
-
 	/*
 	 * Set the vCPU's index *before* the vCPU is reachable by other tasks.
 	 * Unwind the index back to -1 on failure so that KVM can use the index
-- 
2.55.0.1082.g2b9226bbc0-goog


