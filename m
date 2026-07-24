Return-Path: <linuxppc-dev+bounces-24749-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5B5C531D0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 00:48:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5q9216dnz2yRC;
	Fri, 24 Jul 2026 10:48:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784854086;
	cv=none; b=CeUhwToZpeubXVsMzoRv0yM1mGDSVPeK5yomG36bPwAR5VhziCZFBXZgBeaV+UaVFGwpoHYJjfSK4LIYkwJp/9cDG+ywMng/JJ9YWbmvsRKzb1GquwrG6X/T6uHOf0Noi36WZgTIEUSsfYhXWt9lPR1I8Dexx2mYd/YEcM/m1RQw/1tjETPaRXF5So5aHNYvDCoFS05QycZLAcZ4QwvhzFT1CSbivfpWJ+mgxTskWle67/IQuTA9gOIrErkaAzuVX4QYYa4xcFp7IMM2fvxNLgJMnBpn6PpC/H6Xnr+MxE2KKe8HcxDgjIBMA6aDz8MtnzEFKRdOgolwRHiOiVPj7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784854086; c=relaxed/relaxed;
	bh=oC8miNtsbOCSUDu5oKXYgZACbFsZ70Mvq4+HrBNxgtc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CJgDqwJ4f4tFhsYVTN9317nGP1f5W0qz6wITmctgIk13UGDvLTX20uX4wJU6NvMjBmN1ZkDvCIu202prd8iPLiHbdz5hTHyOGTyAQ3VNDLQJEz5Rn9YXQQSsw0LiEtB+Va/NUwQj5Efs2XhFBK3W6+SWLISvcMQoF0tYqZek4TqYv1vH/L0G1Pfpgc5ZWU6hULlSV8MkvBGuEpvhLx1z4D4tCd3L12W7itZHV+iQB6MynsepvSLzqDJu4rqTJKr5qin+5UiNyCymfrJsRyMrXBuGcy7HzrGqe+zpj1aaljmcpM++sAXbSrKk2IeXKS1WPuAFmLevSsJhtJ0kfnNhuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=c1nJ+b/P; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3qlziagykdjedzv84x19916z.x97638fiaax-yzg63ded.9k6vwd.9c1@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=c1nJ+b/P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3qlziagykdjedzv84x19916z.x97638fiaax-yzg63ded.9k6vwd.9c1@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com [IPv6:2607:f8b0:4864:20::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5q902CJZz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 10:48:03 +1000 (AEST)
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2cee1ec30f2so16754745ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 17:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784854081; x=1785458881; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oC8miNtsbOCSUDu5oKXYgZACbFsZ70Mvq4+HrBNxgtc=;
        b=c1nJ+b/PMbGCZ39bIQjq2R9ipCBOoLoJADVfA8g2IfFvjIMEg4/UCO2su3vNZNKybZ
         k90x4oy4e7MYV14vkMJ3Ioe8WVfJvuZl9MMc/+D6Q4xbXqOSTy7oxxSVTWo7uG9QMDkL
         p6kGIvwP7Lwnkz0311/4+eY6dgRWAYaLTvQTagy86s8YCFe0aY+Dpml1TBGuGCv9NlNP
         h8m3ezytaLmccKstHJpwYDiP2E29nxL046QSWLVxCLQukGD48Lx79djrBcdZ6P/M5Dag
         5slF35g0/xDp+MDSuyBSuwktRuBVTK3E3Cc1zRbZk4vG/Muc/dLNLPv4/+Jq2nhYgy5Q
         U3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854081; x=1785458881;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oC8miNtsbOCSUDu5oKXYgZACbFsZ70Mvq4+HrBNxgtc=;
        b=I9prd4FPyLP7N4wRznE1aZ72UZ62q62nG/QDmm1p05KktTGEr4WIc2t2KznlqNWYzV
         8m5Ql7a1POUt/Eurts37bPggtWPO1KEKp/ztkQjlaBrFSAiO5UWXnk1HEQr11whiL7VQ
         gaUzbiVHmKk5r+BE6qcNQipC+V2OAsLpAS2w6XJg06X/Y3GbgiW0hNonmau18bl6Qcwf
         IoB9VQriB74+ubkWlWx+bQrdv/do3enG4g762y0BKrKlKLNhAdqxvgdjMWCDsO2pg83r
         fEq4TSg0/zfsMWKP6AFv8V4NHSq4FxzzsyJNqT1isARMxGXZQWIz8wCTNwvD6RGdIoki
         nC5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqemi0AqeptfQVsUAw8WRVrj4sXiPupnxXYN8coIQc9pj9o+FzzEmjaKA0ebKuXY/pjDQhzwzooONLf+xc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwmLvqvYYuqKpD529+cx+XNo+0qkj0QQ20l+xRe3d+LftVppMzz
	fKOttdSwh244otkqnFI0Z3T1cbRvyT0wm+4AcuDLVLlZBLpe2+Ge5T3CEUjHfKYECeL5h5cT7Ft
	KQ+XRaQ==
X-Received: from plte12.prod.google.com ([2002:a17:902:744c:b0:2cc:6815:446c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c7:b0:2c9:97a8:aff1
 with SMTP id d9443c01a7336-2cfa6f871abmr60493245ad.42.1784854080601; Thu, 23
 Jul 2026 17:48:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 17:47:51 -0700
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
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724004757.131420-1-seanjc@google.com>
Subject: [PATCH 0/6] KVM: Harden kvm_vcpu_map() usage against memory leaks
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Harden kvm_vcpu_map() usage against memory leaks by yelling if there's already
a valid mapping, and then unmapping the existing mapping before establishing a
new one.  To get there, add a CLASS() for local, on-stack usage, to guarantee
the map metadata is zero-initialized (well, so long as the CLASS() is used).

Prompted by 2f2312c422fd ("KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails
due to invalid guest state").

Patch 1 is related in that it's needed to avoid tripping the new WARN.

The PPC change is compile-tested only.

Sean Christopherson (6):
  KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is cleared on VM-Exit
  KVM: nSVM: Add CLASS()es for automagically handling local
    kvm_vcpu_map() usage
  KVM: nSVM: Use CLASS(kvm_vcpu_map_local) for SMM VMCB mappings
  KVM: nVMX: Use CLASS(kvm_vcpu_map_local_readonly) for MSR bitmap
    merging
  KVM: PPC: Use CLASS(kvm_vcpu_map_local_readonly) for patching dcbz
  KVM: Harden kvm_vcpu_map() against double-mapping and thus leaking
    references

 arch/powerpc/kvm/book3s_pr.c |  9 +++----
 arch/x86/kvm/svm/nested.c    | 18 ++++++--------
 arch/x86/kvm/svm/svm.c       | 46 +++++++++++++-----------------------
 arch/x86/kvm/vmx/nested.c    | 13 +++++-----
 include/linux/kvm_host.h     | 19 +++++++++++++++
 virt/kvm/kvm_main.c          |  3 +++
 6 files changed, 55 insertions(+), 53 deletions(-)


base-commit: 6bc96b971766fbbbbdd9fb2642cedacaf02da957
-- 
2.55.0.229.g6434b31f56-goog


