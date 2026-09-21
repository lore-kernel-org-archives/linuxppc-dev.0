Return-Path: <linuxppc-dev+bounces-27871-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FD6C982E6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 17:45:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpVx55dMWz30WJ;
	Tue, 22 Sep 2026 03:44:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::645"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790012697;
	cv=none; b=Zq5E9UAlyMXQPL/v6AT/gn2Kj0Mu8x8x52pdxeZyzIpaG+RPwXJwdL3HPO8G+3pwHql61gflIMcFtGOkUkeDS99L9q4oaRdOWAnumef7dvSwDdxEtw0ZgvDVstSeOtp2ioQbgRPnPkIi58KsCPD6ne8KHwiKjLxVah4d2o3tBkA711fPdl/V0F9ORlolb3uoSBnRrUqWJeHisv02zmjqsmNBr1Q6W1nvQGRAbNfF/6ii33SVx0DWUS+eyTDfR9Os1oYWgZZTbxP3/+PE91d8qXeMAum1cT7OO2yrWzEsd5clNnMVJZoYG6oXeXBTv6KLM6aCrzIrwXgsNTyI7/WFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790012697; c=relaxed/relaxed;
	bh=P1dhUTiarEg5c5I3QHkxBctKjtcsAKr4VX6TAcrbU/Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eq0Z8DjDWPx/GjAlPdSUxKEXiqu0WG2quebvkw1KXYwWalgVh/lbsHIL8Sx6sk5xBYrHsNuErWLkExCdKXYpIT9/uNsbMkz9UoI1s3+9lVq4r3+8KMx9OFD8sAV50COr8i/LGT1NnP2nigYLeQCmX8/QwN+qmp2fgAot7yEH2ZLrHsHHNj3MC0v7M5/7gzWDd9gb7YA4Bo9PioTjMHGqv2d9GhMeYgb5mAmsVURGFnt33dQQLdNi586DuG5t1yV5qOjveUKH4W3D+zTDPHiwnmvao9SWe+CIhilATBOZe4bfVnuSajvtlMbCzfAYtxVSSqoBvBHIHNuxfCWYzv0IUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OTO1Beh0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::645; helo=mail-pl1-x645.google.com; envelope-from=3fm2xagykdbmbxt62vz77z4x.v75416dg88v-wxe41bcb.7i4tub.7az@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OTO1Beh0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::645; helo=mail-pl1-x645.google.com; envelope-from=3fm2xagykdbmbxt62vz77z4x.v75416dg88v-wxe41bcb.7i4tub.7az@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x645.google.com (mail-pl1-x645.google.com [IPv6:2607:f8b0:4864:20::645])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpVx507bXz3bY7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 03:44:56 +1000 (AEST)
Received: by mail-pl1-x645.google.com with SMTP id d9443c01a7336-2d94a158dc8so57856705ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790012695; x=1790617495; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P1dhUTiarEg5c5I3QHkxBctKjtcsAKr4VX6TAcrbU/Q=;
        b=OTO1Beh0r++N08/R2HMlq9Pe/e67jY10CigP7rkbbzNkyBbZElbaN1ihBhgTppSqnW
         p1+LklAyIY0M30OBg9Vx6IdzM+XNURhJXs3atudMSWQOuDaPv5LizwxJTo7l0hKAlHJf
         E7S5GKa0J/TqJ325q7+GvdQ8LK9jvNLnjSASSkIsNCgwUxwrsmNnHfbiqQgl2rFGWq1n
         iZOBppy26EDDzrPiXerdK43ntMD43C9Xwute35Oa1hdGaj9PLkncanHO0NRwAhbErzG0
         +0yOiGcag0Bju+hk7CWB1KfjAPUzxCAFTGx23IePNWrCWp8MInyI5dWTcIcBz979utmz
         yM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012695; x=1790617495;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1dhUTiarEg5c5I3QHkxBctKjtcsAKr4VX6TAcrbU/Q=;
        b=gZOIy9xIhB+vtotGDJB5+eprgJWcx96V9FN5phBr3CLC05ZkhupbTpJf3klAD4PiB+
         0eciG/Eoslq1O0ADgNu398egH/zCsIoamEVnj5RhnjToR2GuBIxlPkSA/Ac3UMFmka1o
         pd1havI5K1TjjcTxEDu9QlxEbLXDsGa+GgVEdm1RNVgSn9/a/UmmhmvWNL2o+WAO31h+
         7UcGis/PFQTPAOV+2vQrgLirRVulT8e7Xh3g4mBxfU08upJu6GCqRD33updrmkXFqFyX
         SXgb1rIn+WN/W21qbd4Z9wKmYoRvVqbRESGMPDeOllH6o0TOOJOZx3ktndDfBYtMNUAl
         UkmA==
X-Forwarded-Encrypted: i=1; AKwUvBwgT2lD5kzBXGk3ik8lmj9HAg61vcjc4zB2OcZ1YkZfhalPU4w0sPW5TEbjRaVtYxfiT8hkDElgogHCCAk=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lJ/liH3yHbmDOcpH+DpN2wKIGc+u4RiCSab9VjR8gHVrfWeExt
	38t7PIBY4n0XFlyVST5hP16HEQ8YCqGb5M4rqyUeyukYXxz/UzDRI8gz4V05byrDRWOr/EA+I7I
	XPh4lCw==
X-Received: from plao21.prod.google.com ([2002:a17:903:3015:b0:2dc:5417:2772])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d984:b0:2df:3b09:664
 with SMTP id d9443c01a7336-2df3b0909cbmr71040325ad.32.1790012694298; Mon, 21
 Sep 2026 10:44:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 10:44:44 -0700
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
Message-ID: <20260921174445.911676-7-seanjc@google.com>
Subject: [PATCH v2 6/7] Revert "KVM: Check for duplicate vcpu_id as early as possible"
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
Content-Transfer-Encoding: quoted-printable

Now that KVM uses kvm_get_vcpu_by_id() to check for an existing vCPU ID
before doing any meaningful work, which was made possible by holding
kvm->lock for the entirety of vCPU creation, revert the now-redundant
"early" vCPU ID tracking.  The claims about the impact of kvm->vcpu_ids on
the memory footprint were a wee bit wrong: the worst case scenario isn't
256 bytes per VM, it's 256 "unsigned longs" per VM, i.e. 2048 bytes per VM.

Increasing the size of "struct kvm" by 2048 nearly doubled the total size
on many architectures, and tripped x86's KVM_SANITY_CHECK_VM_STRUCT_SIZE,
which was added to detect this *exact* scenario, where a single change
significantly increased the size of "struct kvm".  I.e. attempting to build
KVM with CONFIG_DEBUG_KERNEL=3Dn fails on x86 (the build failures got misse=
d
because all build bots apparently test only CONFIG_DEBUG_KERNEL=3Dy kernels=
,
and maintainers' test flows were similarly lacking).

This reverts commit 97d65b544f48b2ee49f6aea32145e3e7969955dc.

Fixes: 97d65b544f48 ("KVM: Check for duplicate vcpu_id as early as possible=
")
Reported-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
Closes: https://lore.kernel.org/all/56a4bc35ee605588b7cc36c8e45c12b5f3b506c=
b.camel@guillain.net
Reported-by: Pawe=C5=82 S <spawel523@gmail.com>
Closes: https://lore.kernel.org/all/CABD%3DWFOS4j4hDv%2BpW-eEM9HAM2q2GY_iYd=
AG%2BqvYcUEinUrcQQ@mail.gmail.com
Tested-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 1 -
 virt/kvm/kvm_main.c      | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6..6aab167bf482 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -791,7 +791,6 @@ struct kvm {
 	/* The current active memslot set for each address space */
 	struct kvm_memslots __rcu *memslots[KVM_MAX_NR_ADDRESS_SPACES];
 	struct xarray vcpu_array;
-	DECLARE_BITMAP(vcpu_ids, KVM_MAX_VCPU_IDS);
 	/*
 	 * Protected by slots_lock, but can be read outside if an
 	 * incorrect answer is acceptable.
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d5524ac8c5cf..985af39b980a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4185,15 +4185,11 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm=
, unsigned long id)
 	if (kvm_get_vcpu_by_id(kvm, id))
 		return -EEXIST;
=20
-	if (WARN_ON_ONCE(test_bit(id, kvm->vcpu_ids)))
-		return -EEXIST;
-
 	r =3D kvm_arch_vcpu_precreate(kvm, id);
 	if (r)
 		return r;
=20
 	kvm->created_vcpus++;
-	__set_bit(id, kvm->vcpu_ids);
=20
 	vcpu =3D kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL_ACCOUNT);
 	if (!vcpu) {
@@ -4276,7 +4272,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, =
unsigned long id)
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 vcpu_decrement:
 	kvm->created_vcpus--;
-	__clear_bit(id, kvm->vcpu_ids);
 	return r;
 }
=20
--=20
2.55.0.1082.g2b9226bbc0-goog


