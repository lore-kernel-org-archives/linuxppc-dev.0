Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E371606B786
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SuNk7QvX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYty2dNkz3blr;
	Sat, 31 Oct 2026 08:21:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395290;
	cv=none; b=TNci4RcntORmy7HuXkEUr3NeJBDVbOWlRaXgsDoi/vs7yqIrR++wxdyQ6/KJFRHoEHJGpaQ/PvruYIUxzsQp7TLRClgkX93aOi6s1tUFWZvhTO5/OpwuvuRlDR3jvlD4bLluqpYyXLt1H0EZ/3JpXyb3pcTb3aAPgk0vpm20WynfnwPmu0kYxqDRs9NEvJHez4/Kkf/fqmfjxeFfRS0RIM3QrkLd97+gIropyLBHplExUqZSaKBnBUZMpg8aj4MPnAOZiDOIZzraJNs8e2ItJ8Lkk9VmMFyjco9JIGD4CrCBSHuzr6XGfFuL/CUtvFWIqurXmtGUnzT3ngJRXBGTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395290; c=relaxed/relaxed;
	bh=wBUcCVimSMxUE8k9Ea7hRloNc2vyINknzNzgi9oeUuA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=croE0203hRuMwptkMp9YKw1MF8FPDfMvy7yM8G+6xpc5iw+bItx0yW8BagVITVIVVHYJ3GfP3kuj+EXW/s0LA0Y82IMkwPtvxSZmGOS3aJYJU8QGiR+QOwLkcm9bXwh4vZEuYTsvRvojlBf/xCoanrm3R2kI3xPcqnonmWZ6hfiXrRaKDwXLP94TXG7zlVkZkG6/73HDDkP8b9v4CGsxZ5KtcYKwjXe5/WyYenGiTtdaLSZ/mow5CBBNhvjg2sOW2eWPVkLZuDu2TkgNPTLpLVgR+PbKiCm9fHKGCxDxteiSNLHW2Il8/UtHInk2wuRs49GAxKLfKrH+yoml/qtRSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SuNk7QvX; dkim-atps=neutral; spf=pass (client-ip=209.85.210.197; helo=mail-pf1-f197.google.com; envelope-from=3vgrlagykdf0n95ie7bjjbg9.7jhgdipskk7-89qgdnon.jug56n.jmb@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SuNk7QvX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.210.197; helo=mail-pf1-f197.google.com; envelope-from=3vgrlagykdf0n95ie7bjjbg9.7jhgdipskk7-89qgdnon.jug56n.jmb@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYtx4t58z3bp0
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:29 +1100 (AEDT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-89ff475a0deso1072076b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395287; x=1794000087; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wBUcCVimSMxUE8k9Ea7hRloNc2vyINknzNzgi9oeUuA=;
        b=SuNk7QvXMWxYzPoAoyVpL/bVBuUWowFCcf2RydJ+M/a586i46Yub6gR6tgSI7CfuSY
         fBejWGZ/AYb+MlYtH/GEMurYjNtPQWQ5JhLZydvjpXDkz7gptK9HJ7df0UXjX7PoGXvQ
         QyaPCtqV1e4UrOWvF+6mHIRaaF8p5UVCDEb+MjPpgsudNpf/wfzhLm55FFwZvU1b29Tl
         ep/zSuKxdptlcrhLO+nHyY5ouk27fPoEzRqYIKnh8xU9vgt7Tnn6z/T9VXxm7oKC0kbq
         ZVBwNnCKe1MDjiJEDLPuvnraSXv7t/ptsbUDEZWShUxvSGsJ9v8uJ0vqimEyca/lCDRa
         8YCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395287; x=1794000087;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wBUcCVimSMxUE8k9Ea7hRloNc2vyINknzNzgi9oeUuA=;
        b=vKyJ3BBkdNMhWiWkm0GCWTWxt4X0uRNY4JCH19Cr2BIFgrzJTcSBE6Whj3esERbN6U
         /DusdPvScaaD2amidASnxT0PxwiE2mpvJwV1BJyiHRMyLA2G6i9QWyh5wkGNc/iv5PhP
         lua9wGjGLV8Yk2qY628kKwjZ56+H5gEQF02ExglqNbL+PghfpRaTM1utidpApCHqfXu0
         mYoP178wkcVAshH15jr65sIlkbpDHYQ+YjdtQuBBeq3rFIdktC/ub3QUS5wp0PgtULNo
         6t5ZwoVY4cKWrMHHaSZw6i6ChxDPBFJcjbFHU++9+4XOx4gqxnS4MddyXESBAYnw5RGO
         onYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfd3yGVs6i9dV3PVF5kZ4kJy8Ocly5Gn8YHdy2gO+cb+8wpK3bw+fYAfUv23fao0oIGOapKYzGqj/OVqw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJr0WDsGlUlwyD5jDuBdiiCb9px7gFlBD/YjUd1yTubbctBCQuL
	BX32bJUdkPt1Q5X0VtobTA4CDA/lhM5R+ThNEgVAiWNDwuhgTNC4UyujECFVvN5oAQ7klXJd6It
	D3t09ZA==
X-Received: from pffl17-n1.prod.google.com ([2002:a05:6a00:c351:10b0:89f:3d5c:8c07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1785:b0:880:f278:6b0b
 with SMTP id d2e1a72fcca58-8a9b9a5560dmr2884129b3a.4.1793395286997; Fri, 30
 Oct 2026 14:21:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:59 -0700
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
Message-ID: <20261030212112.2598640-12-seanjc@google.com>
Subject: [PATCH v4 11/23] KVM: Disallow setting memslots when the VM is being destroyed
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

Now that KVM doesn't delete KVM-internal memslots as an unnecessary side
effect during VM destruction, WARN and reject any attempt to set memslots
after the VM's refcount has hit 0.  There's obviously no need to CREATE,
MOVE, or do a FLAGS_ONLY update when a VM is being destroyed, and there
should be no reason for arch code to manually DELETE a memslot: once KVM
KVM unregisters its mmu_notifier and does the final kvm_flush_shadow_all(),
there absolutely must not be any outstanding references to memslots.  I.e.
if arch code "needs" to manually DELETE a memslot, then it's already buggy.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dcd28b45ef30..fa548b12228f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2041,6 +2041,9 @@ static int kvm_set_memory_region(struct kvm *kvm,
 
 	lockdep_assert_held(&kvm->slots_lock);
 
+	if (WARN_ON_ONCE(!refcount_read(&kvm->users_count)))
+		return -EIO;
+
 	r = check_memory_region_flags(kvm, mem);
 	if (r)
 		return r;
-- 
2.56.0.385.gac671c819a-goog


