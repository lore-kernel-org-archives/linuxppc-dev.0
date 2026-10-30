Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC8606A323
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VkeECpzG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYv41Rwbz3bxC;
	Sat, 31 Oct 2026 08:21:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395296;
	cv=none; b=CKQfxAvTZdGLvJPZWSpNHbFGd2HMZrEP7IPKMc/hZEswTqatCYjhnDxxGpUediexHDpNV4R/OLrUR//JMM5MRZVciUMoOOJkCFMZh1G6WBZEIH0Q0/Yi7lcwpeOcow19eWF42nPOWznWRZC/XQtDHcdMDBvcqk3KS37Jq+7S4+uozkzbMgjMIc3xPhA9Z0K6j6mA6Mnz705x4Iq7KaVyokSeYi9S7kmMBqFhX6+rMb/yA18raB6F3FFjBHf55lzk4/ubRgHxCSMIpI6FN/vnGGxesPoI1sN3MlerNnUkMcE67Z6UYeaVOz2A1YjrUolgJCKonX60wwLB0kQ/US1uHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395296; c=relaxed/relaxed;
	bh=dM15LINaQxHbLc792vSLF2sf6HuVzGHLaKE+3j4yUXo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y0saLbuAec3/gcXHUZkAnnEmmtVAZ3QwYcC/apsgaIuUwXT736Uq5kx6btD5ZwkxKZc0TUk4JooebMS33QNTeJa53OK2+RiH6QbTCL9FGIebSaLS6pSKGA2zKOutgVlR9RcNgmh9nmm1yLwhEhZu5Wbi/4mTt2p5NW92SJZY7DscBOuDdOYWKXFSlgpURjmJm4UjsZt0bHA8zK06lYn2DIk9Sft7Zz8ZLcI9CvfnRLyqRRE5GhauAauyxHslukFwXn5LI5+Jy3WkyMCMPtc6YI+4W4Csz9p5YbIWuBOtz+bjJrfQGag1w2UejZ661DoIgN712tZhWBbTrwGXHZe4mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VkeECpzG; dkim-atps=neutral; spf=pass (client-ip=209.85.216.71; helo=mail-pj1-f71.google.com; envelope-from=3wwrlagykdgiseanjcgoogle.comlinuxppc-devlists.ozlabs.org@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VkeECpzG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.216.71; helo=mail-pj1-f71.google.com; envelope-from=3wwrlagykdgiseanjcgoogle.comlinuxppc-devlists.ozlabs.org@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYv34Q52z3btS
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:35 +1100 (AEDT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3aaf955db5fso1427319a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395293; x=1794000093; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dM15LINaQxHbLc792vSLF2sf6HuVzGHLaKE+3j4yUXo=;
        b=VkeECpzGLc5F60BobhZ4+3RqBwetAfBjorSFXRRcaipz7QB1+t3KVaT1zlOvMOb1/Y
         mjJiCqsWKvRfM442vXVAiQZYsNNVaYV9tEKTkKtWLWQvZshsxy70TBD8+5hamFRvHzb/
         cc4bv8Bro5mQ5HPWciP3pijPzd+SqDD+S9yT1tI4voT7M9FlBLdUh8fjblmd1DXwCGod
         Gy9E0axalTq+NzkYga98Y5AvqXTSvBVTFDNjuzijlhtAAZ0YHk2DHIGyY5qeH1fawQGq
         Nz/dpoypx21t1JTl54l5RI5KvxP34R6bR59TP610gzTh9zY4IW0dxzGxYt5WaOw3RZlR
         jKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395293; x=1794000093;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dM15LINaQxHbLc792vSLF2sf6HuVzGHLaKE+3j4yUXo=;
        b=doipmxdB/bsPy4ACgvz49DCmTAp+TMCKkNEF4Ixq1OBJiCOEO/oZSOz/sj+nb7FmkJ
         ka6OoDRE2IZZRwGD38TdLYDCTjz883X/qgxHybe7dl6aUqVUNfnXJlWTQJUIFws+faDQ
         0APImFzzONnFjEQUpb494KXV31rLBOj6kkUlB4B3Jm9b08dUkUNga4ehdKAB1mUtoLmh
         +1RyEmAVqNzTSpM3Fnncp7CnYrFSoXPjTsDZlG99fSMI5UFJ2oKVzPmn6nz+KR+YR1Fs
         fxIVuGKDjZL9DwoMvOnf7CbTv0o6HbY+198DomYA47IBBJBdm7QleAhS72ifegAkWbwb
         TWFg==
X-Forwarded-Encrypted: i=1; AKwUvBzwgskj4r8kzVmid9CYCO7NcHPlFnxY9MdO1aIKlDqHx18sVzm0crRzGNpk925xfBfwGPm2FpAGY22Cu0M=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIUvunt7Syma+ZqGsLqjtNnNXEEek12FWQJEii+bmoYWFeN/Pqu
	Na0KLI7Jv16fzy5q5J2xV1RRzhIwsfoxHJtldFMs/S4P39/n5eHmo15gOX7VOjn0WDLI9DvlhVd
	goEFBOg==
X-Received: from pjbbo5.prod.google.com ([2002:a17:90b:905:b0:3ac:24b3:3484])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d0c:b0:3a8:5cab:1009
 with SMTP id 98e67ed59e1d1-3ae897ba3b2mr3007282a91.46.1793395291990; Fri, 30
 Oct 2026 14:21:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:03 -0700
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
Message-ID: <20261030212112.2598640-16-seanjc@google.com>
Subject: [PATCH v4 15/23] KVM: Pre-check uaccesses in KVM's APIs to read/write
 guest memory
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

Add a check on whether or not doing a user access is ok in KVM's APIs for
accessing guest memory, *before* doing memslot lookup/validation, so that
buggy KVM accesses to guest memory are more likely to fail noisily.
Because KVM installs dummy/empty memslots early in VM destruction, bugs in
the VM teardown path will fail on the memslot checks without getting to the
WARNs buried in kvm_copy_{to,from}_user() and friends.

Reviewed-by: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2eda12a52bf4..c6af11cea296 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3300,6 +3300,12 @@ static int next_segment(unsigned long len, int offset)
 		return len;
 }
 
+static bool kvm_is_guest_access_ok(struct kvm *kvm, unsigned long offset,
+				   unsigned long len, unsigned long size)
+{
+	return kvm_can_do_uaccess(kvm) && !WARN_ON_ONCE(offset + len > size);
+}
+
 /* Copy @len bytes from guest memory at '(@gfn * PAGE_SIZE) + @offset' to @data */
 static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
 				 gfn_t gfn, void *data, int offset, int len)
@@ -3307,7 +3313,7 @@ static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
 	int r;
 	unsigned long addr;
 
-	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
 		return -EFAULT;
 
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
@@ -3383,7 +3389,7 @@ static int __kvm_read_guest_atomic(struct kvm *kvm, struct kvm_memory_slot *slot
 	int r;
 	unsigned long addr;
 
-	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
 		return -EFAULT;
 
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
@@ -3416,7 +3422,7 @@ static int __kvm_write_guest_page(struct kvm *kvm,
 	int r;
 	unsigned long addr;
 
-	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
 		return -EFAULT;
 
 	addr = gfn_to_hva_memslot(memslot, gfn);
@@ -3546,7 +3552,7 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	int r;
 	gpa_t gpa = ghc->gpa + offset;
 
-	if (WARN_ON_ONCE(len + offset > ghc->len))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, ghc->len))
 		return -EINVAL;
 
 	if (slots->generation != ghc->generation) {
@@ -3584,7 +3590,7 @@ int kvm_read_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	int r;
 	gpa_t gpa = ghc->gpa + offset;
 
-	if (WARN_ON_ONCE(len + offset > ghc->len))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, ghc->len))
 		return -EINVAL;
 
 	if (slots->generation != ghc->generation) {
-- 
2.56.0.385.gac671c819a-goog


