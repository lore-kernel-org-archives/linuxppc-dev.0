Return-Path: <linuxppc-dev+bounces-27867-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61C3C982FB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 17:45:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpVx131ZLz303F;
	Tue, 22 Sep 2026 03:44:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790012693;
	cv=none; b=ePqFdIhPK7JHS7etvP7rsygBqYWyr5wGOR/ygjNqILPb6miWTqCgyaDFhaxkrGiKEwHvoGS4e6RvITHlliJrwDn7NxmF7xQwX4zQocv7lynCd+eB5bSs5cr2Hufu3u7TeDb7VgZFepr3c3/slD6m56ounyV7lyfAWpD22Zd4+vJ8mlJYs4sT4sjekoG2NH+5fBHn+0XTPSUv1pNtSavOYrX1Y4te+EJr6BF2xtjS+yzp3i5/prpnFQfuMK8cHry0Bmjq5tL/qQYbAX1ROYRU6DTjfpbkskzOREMHUcrfyTKuiWvJ0Xns1FN21Gv/rYGo1EF49fzXyrHjpPGxkA7Vqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790012693; c=relaxed/relaxed;
	bh=Hyb3zhkpLvcha2XPZl3y4VqrXuYFCx4NQzeWMijbr/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nij1kRlVj7YLiqSRRKDE8rgEFVuhzPkvPh0Jt9HXnTplUZH7gRr9aPtiBSDq2uE6+MYDeSF5FBlpC3FcFfTa5fHrzYd1mDb2z+8TVCjGa+O+v+TNF4vMTNskp+q2yhX051FWtzO/FuUSmqTw1qxpN5eUcuMtvQMSqGdU818+IiEhKyXnV88gIYOsnTrQixed1Q1t2u5iW3h1oqd4CagVCbwXpQMrpHzwfZPLKAMVW2DLl5ykyWm4xizwjyeuKSomA3ma1Yo+gEpBsUcmqDhEgAex++gl5RqN0NrlqVrouXtPfAKH/Eaa3j5FO0DnBd1ew8UrvbAdHcY8APBPMW2wFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lRYVTgo0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=3ew2xagykda46so1xqu22uzs.q20zw18b33q-rs9zw676.2dzop6.25u@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lRYVTgo0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=3ew2xagykda46so1xqu22uzs.q20zw18b33q-rs9zw676.2dzop6.25u@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com [IPv6:2607:f8b0:4864:20::647])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpVx02LWNz2yft
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 03:44:52 +1000 (AEST)
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2db3734d06dso57066725ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790012690; x=1790617490; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hyb3zhkpLvcha2XPZl3y4VqrXuYFCx4NQzeWMijbr/g=;
        b=lRYVTgo0o18xOdWUWTyhS729J9Tx2ZjYRPEO/TkqG+vQINFtLYSafaLjzHneq2U6hs
         LISa93TFZQsZB3xIEpKBHZ1FE8mvxnSDCW4DLl+mX5m/T1KCQUh97c9emYvHzmHgZaVP
         ryJa1KwsLvaT1f/pxrzfH4KwpElR3Vu45O2YM4bJfvS2e59+phvuvG0Nc6sRpqB2hlOR
         FDXmCMrFV6DlV6wgrRz5jssXtpZMEK4AMH7UoZpE/ORJZY+1G0Aqisz3sq5EfHE2VXQ+
         u6od/lPFItz/l1fkCYnlcnmEGG1SOOgo12Soter1lT9q9LUjhH2zEwXwSpHYqvJQEj8r
         xm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012690; x=1790617490;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hyb3zhkpLvcha2XPZl3y4VqrXuYFCx4NQzeWMijbr/g=;
        b=emjq7fHL/PuKkcaUxnENNVUfK1NZc+BGJ5tN4n3P7FrOywVYcpJQ7eQbcnYJFx4stg
         rTJbXBFlT2j8W6MbtdunqKoxXQr65InjdXdxMspRcIFuj1j6AgKADvstUUcsfft7wyR8
         e+sUtQ4LQuE70BGT9Kk4vG4p/MFw0F4RlJEDIe5ocHEqUzu8wSZeD+ExEf/3nn/kfsui
         jyC2EnERViC+nWH2UUO2NBUmVn+R0zclFArLhygGwvyVrmC4ksEUSjkvt5TOqHyBiRCK
         Cif45eyQiu3/1IinCA2ePSmcNwA4CFQCTeKAXe6p/L1GLfYbopxG67mWpw6y+aeDJi7R
         EVAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYUOPLEhVpZYZRbNm6M3BDuBVigSN3vPssrGG0naP+KkCBXrLT5CVPkMpjspF79gpX22DzYkDJOvlYHk0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kMHunfSGLsJ0SyqOGWiVlcHAFNQFYDTbcNxpniOB8VqH6BoiU5
	sq17UANPLPn/ZJxOU4ddl7Kv72ze7/RPoIXMhjCWZUfdHscXFfLOPxOV+ne7BVxbcxoVRplsCWf
	Hy7Ow6A==
X-Received: from plaq21.prod.google.com ([2002:a17:903:2055:b0:2dd:1daa:a60c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54f:b0:2dd:c053:c207
 with SMTP id d9443c01a7336-2df560d81a4mr14415165ad.35.1790012689572; Mon, 21
 Sep 2026 10:44:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 10:44:40 -0700
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
Message-ID: <20260921174445.911676-3-seanjc@google.com>
Subject: [PATCH v2 2/7] KVM: arm64: vgic: Rely on vCPU creation check in
 "trylock all vCPUs"
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

Now that KVM's APIs for locking all vCPUs return -EBUSY if vCPU creation is
in-progress, drop the manual check for the same from vGIC creation, and
update the comments accordingly.

Note, while KVM arm64 guards many vGIC operations with its arch-specific
config_lock, holding kvm->lock is sufficient to guarantee a stable result
for "is vCPU creation in-progress".  So, no functional change intended.

Note #2, the open coded check in vgic_init() is racy when called without
kvm->lock held, e.g. via vgic_lazy_init().  I.e. that check needs to stay
open coded to avoid triggering a lockdep assert.  Whether or not the race
is "fine" is a problem for a different day.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/vgic/vgic-init.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 4012df6002ea..a58575df36e9 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -97,6 +97,9 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 	/*
 	 *  - Acquiring the vCPU mutex for every *online* vCPU to prevent
 	 *    concurrent vCPU ioctls for vCPUs already visible to userspace.
+	 *    This also ensures KVM isn't in the middle of creating a vCPU,
+	 *    i.e. that there are no vCPUs that have been created but aren't
+	 *    yet fully online.
 	 */
 	ret = -EBUSY;
 	if (kvm_trylock_all_vcpus(kvm))
@@ -105,18 +108,11 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 	/*
 	 *  - Taking the config_lock which protects VGIC data structures such
 	 *    as the per-vCPU arrays of private IRQs (SGIs, PPIs).
-	 */
-	mutex_lock(&kvm->arch.config_lock);
-
-	/*
-	 * - Bailing on the entire thing if a vCPU is in the middle of creation,
-	 *   dropped the kvm->lock, but hasn't reached kvm_arch_vcpu_create().
 	 *
 	 * The whole combination of this guarantees that no vCPU can get into
 	 * KVM with a VGIC configuration inconsistent with the VM's VGIC.
 	 */
-	if (kvm->created_vcpus != atomic_read(&kvm->online_vcpus))
-		goto out_unlock;
+	mutex_lock(&kvm->arch.config_lock);
 
 	if (irqchip_in_kernel(kvm)) {
 		ret = -EEXIST;
-- 
2.55.0.1082.g2b9226bbc0-goog


