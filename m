Return-Path: <linuxppc-dev+bounces-28695-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7112FCA5FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 20:24:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwjyp6xWPz3c2G;
	Fri, 02 Oct 2026 06:22:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790886178;
	cv=none; b=J9Ex2jphbwfr8S1U2GNSrvmSNrIKgWE34GGmocmbNe8E8Hg6gt6/kwsMBJJUylkFWcqCujBc86qeDL7Vv1aH2P3aX9i1Jrd0xzvmNjJHrtWMdx3/rSJHzbUL3+2tprZUg3NRWyshFPfuAZ5qgy6uCCXc7m9oDMtPpT/DkhDcmvS6BVw5Q83H3y4ge16Oiet/7MNiO9mPKKk0YdgeyPZ8pUQprea3jePht+1Mmhs9ecq1kMBvcPQEVai3vpNDqvXIsMorEOn1x9WsJfySNdak7ZSOPbEqI34QFtv6zH44wbxpXF3zi82b2b7/sy3tOZZ8eHwlRW5FHETvRcqMiN3+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790886178; c=relaxed/relaxed;
	bh=Jbjl3neiE/IIwhYOUwKWLxnN0Mu5SRuRPO+LEk/x8go=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LeALVBiM7ZBvl6wEmMNaSI8DJiIP3zE0e28sCuqZELhVLlWp3HwLC16661alupBBjTR2SabkdQuVWu0w5HNxxWHcXcSHcE0tPmORv194D5TCcoYxDM7KYga6MLW18ZFatv6nM83k6GV8PlttRIQAYEN2KdCRsnvwYfRGU1XZMDN3cgIjBeNrj6eGmTKY8oiULJCYfdIQWNG1gTnk2jcgKdha9oJQfGpceUrxJwJggJHfOV8/tBlB+lKC6sjAxrfZoChc1qfcoV34jmF5NhTopEgj3iHMCj8vqPdyPlVLSuwCBeDRpbO9Up4SxeRYQ420/tN+X79OGHfx8guPLFxbMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=olKl+uI9; dkim-atps=neutral; spf=pass (client-ip=209.85.214.198; helo=mail-pl1-f198.google.com; envelope-from=3hsg-agykdpcrdzmibfnnfkd.bnlkhmtwoob-cdukhrsr.nykzar.nqf@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=olKl+uI9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.214.198; helo=mail-pl1-f198.google.com; envelope-from=3hsg-agykdpcrdzmibfnnfkd.bnlkhmtwoob-cdukhrsr.nykzar.nqf@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwjyp1hzkz30NF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 06:22:58 +1000 (AEST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e305755a01so16300015ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 13:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886175; x=1791490975; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Jbjl3neiE/IIwhYOUwKWLxnN0Mu5SRuRPO+LEk/x8go=;
        b=olKl+uI9ZvoQwZPR0JCQRTnzeZCNijHN3nc004C5a0DQgCMqZlSNZZfuhc2Uh88Iih
         bRqP3kq8t5WiUfUSE2DKoO6vedQMcX25q3KZMt12DpdLr84Bsx70oFtLxI62SjMnygP8
         j+PSTLoHXFec5JWIJyOOvNYPf69lsVYLYR4QNk224NEYERZgnyZjiwgX5iTfKG2LiGIH
         CC1sCYKoJgKcChoMzTubShI/UwN9xDYIwdZkAbvOAj5QJCuZ2qowvnaYsHsn/76a7jlC
         vE2HdPlQJkKAzWIoqk40gK6+YB17k3DX49DWUF71hwiz0SyKsMqk58jk0xByjppEs0As
         bkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886175; x=1791490975;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jbjl3neiE/IIwhYOUwKWLxnN0Mu5SRuRPO+LEk/x8go=;
        b=pZOE/gYu77rXGpAx4JbecEL0GWiKTsjabx9cSC0dH0xYIQhsoK8kvmG30sPeUatTxq
         29L4XiUf6AjqoZ/hZ8hoaXN2DJdcO0jAuR5otgx2xfB+EeKUUlI6oeRehEN4lkKO4k2F
         i33u9FkXs49jc5feCKgC9jHZdvmgxJIQttZjnW5V1LZJsQBP98Rr2aQPFCh6/yXdagSK
         qoVIwmAN+2M8OiWa0kQiQJ5vtWlcUzHmU6qumam2Tc/ToaIphBFAj7OMJHoqyE2T+J6K
         HiIi6aogVukZuNEOzE2etah2JgWWysV6HUGNnXLoGUSps2ISpJMT3LXJJjUgtX7bCiDG
         AmcQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKnceFWDVyCNX4HBogH82432JmGOQj7drKyI2yGc5oftkZTd4JLNLWZXZh28jlQ6oIvbPNqW29F/RvgTs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++leVjOLkP1aJrr1TVE08N1vG10GCZ3YokwxRhMpm9UYUXp2f+IY
	/hvYa6qtJnvc/c/Urrq7DWkEkce6T6URgSElp24W7ZihYSXcvcrfYG38jHnXGy95xKl/xIIUt7K
	1hKXkNg==
X-Received: from plw11.prod.google.com ([2002:a17:903:45cb:b0:2dd:288d:db3b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d50b:b0:2e4:9081:79e9
 with SMTP id d9443c01a7336-2e49b67302emr5360305ad.37.1790886174487; Thu, 01
 Oct 2026 13:22:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:34 -0700
In-Reply-To: <20261001202234.3794060-1-seanjc@google.com>
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
References: <20261001202234.3794060-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001202234.3794060-11-seanjc@google.com>
Subject: [PATCH v2 10/10] KVM: Pre-check uaccesses in KVM's APIs to read/write
 guest memory
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a check on whether or not doing a user access is ok in KVM's APIs for
accessing guest memory, *before* doing memslot lookup/validation, so that
buggy KVM accesses to guest memory more likely to fail noisily.  Because
KVM installs dummy/empty memslots early in VM destruction, bugs in the VM
teardown path will fail on the memslot checks without getting to the WARNs
buried in kvm_copy_{to,from}_user() and friends.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 770a2c3bd445..80b19d47840b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3211,6 +3211,11 @@ static int next_segment(unsigned long len, int offset)
 		return len;
 }
 
+static bool kvm_is_guest_access_ok(struct kvm *kvm, int offset, int len, int size)
+{
+	return kvm_can_do_uaccess(kvm) && !WARN_ON_ONCE(offset + len > PAGE_SIZE);
+}
+
 /* Copy @len bytes from guest memory at '(@gfn * PAGE_SIZE) + @offset' to @data */
 static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
 				 gfn_t gfn, void *data, int offset, int len)
@@ -3218,7 +3223,7 @@ static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
 	int r;
 	unsigned long addr;
 
-	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
 		return -EFAULT;
 
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
@@ -3294,7 +3299,7 @@ static int __kvm_read_guest_atomic(struct kvm *kvm, struct kvm_memory_slot *slot
 	int r;
 	unsigned long addr;
 
-	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
 		return -EFAULT;
 
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
@@ -3327,7 +3332,7 @@ static int __kvm_write_guest_page(struct kvm *kvm,
 	int r;
 	unsigned long addr;
 
-	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
 		return -EFAULT;
 
 	addr = gfn_to_hva_memslot(memslot, gfn);
@@ -3457,7 +3462,7 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	int r;
 	gpa_t gpa = ghc->gpa + offset;
 
-	if (WARN_ON_ONCE(len + offset > ghc->len))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, ghc->len))
 		return -EINVAL;
 
 	if (slots->generation != ghc->generation) {
@@ -3495,7 +3500,7 @@ int kvm_read_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	int r;
 	gpa_t gpa = ghc->gpa + offset;
 
-	if (WARN_ON_ONCE(len + offset > ghc->len))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, ghc->len))
 		return -EINVAL;
 
 	if (slots->generation != ghc->generation) {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


