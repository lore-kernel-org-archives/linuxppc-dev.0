Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBF0606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TncOWk37
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDl9650lxz2yDr;
	Wed, 28 Oct 2026 09:12:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::547"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793139146;
	cv=none; b=Ein66DGc7eqZxdrdQK9szUvn1CHkF89XXjADd3RVVVltET3IfPcR878GhI/khVGBtRMbigMgC5W0BQv4JjvfRgjiGGpeAwjrVqe1JRNjK9gevqGfPh47nfeXsMQsJvI9KG1tc5IexdmhnVXo4rFq5bzjWSKI7gSbx96Y5FJIGBudgUzMABTWM/9tH08pPLhhH77t0+q92D0TaIVQ+Yu7rUOhhDdp00xaebgHrcKqD4p3OLKn6HQEetNXb/5XQjtwWe2B+jEu9T1ijROjoZNA96pam4+kwJ7qHNwB20+VeNvifayRytS/hZVCafq5wAhJEagrPdzOO5PVhY2pUpD3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793139146; c=relaxed/relaxed;
	bh=h43t1HfpFYnqrCz4owPlG1Jkgt4xdvVHI5bkdA4UEfg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D5oIJ4cSoz5MrbAh75lIuCJ6KCtTlU69XfR3qpIu4tMr/yfacdV2CsmZpjZtfl1SvA8k6Z2QqN2FSySVS+uJt6b+KFVp2TAEq2ffkQsLXiDLtMoCasCeUMesJe4T8R7Ffqh3M8WMizn/W6GXFmDvp2kMzuoSMdCXSMOPLY0eGvPz7FSS1s88rbGSn9h5l3p+RL1zi2DSrbYP9fgiKcoHvGGy0+BYo+Af6ZJR0Zdb6rn9kUzEORb/ywL8mvWPKQVjopdLbqlEzY77LyG5KvcN9fZZZvQB2PliZKQoYF38gxxv41R9Bl6dcH2hH0cWuMepy8O/Hy0SARpE/1xUg0Loog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TncOWk37; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3xyhhagykdowgsobxquccuzs.qcazwbilddq-rsjzwghg.cnzopg.cfu@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TncOWk37;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3xyhhagykdowgsobxquccuzs.qcazwbilddq-rsjzwghg.cnzopg.cfu@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x547.google.com (mail-pg1-x547.google.com [IPv6:2607:f8b0:4864:20::547])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDl9555XVz30Vv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:12:25 +1100 (AEDT)
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cd67466211bso218274a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139143; x=1793743943; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h43t1HfpFYnqrCz4owPlG1Jkgt4xdvVHI5bkdA4UEfg=;
        b=TncOWk37SEcMFg9XYexmqDdqVkmqH18aFa1rpc12l6S6kz2N3v0FldfeTEZSVKBUrA
         N6gQP90tR1Mm2e+7lFxIXP6DGYrvPu9/T6HIx7qcVj+ZIvblhIqPPeY23InfT7a+BbDt
         9XbdoW6oibz4BmFS8VpU2rQe73ejPV/6rU0qLrJeurAMoHd382qnEHtzYPyfHwuuXe7R
         zhmie/tunb4LjlqeRwQZ3HHyCwnvbvdDSLWlE1zad0xt6koAicJ9xcpfJmsekQ/gbxBN
         a1/gEJAx3iOB7Ft0BJoEhFaJ9iTN7dvsgdvLDEicpK4WqJswKcRlChCD2aTdzBoD4rVf
         Dx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139143; x=1793743943;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h43t1HfpFYnqrCz4owPlG1Jkgt4xdvVHI5bkdA4UEfg=;
        b=j9CQL2hy3nOTfgsAuQBuMLn8F+0Pvevurr8UZbIl72VFgLCDypJHBC2hiKO8hBv82B
         HS2jGZDyjZGpEpbMng6XHZa8DOuJEtkL4ARsnYN3kQCSo1+RXucLSJenfsPp/5mezfuJ
         yNVYwhr7PfWu4EpqCKeR4tXGtCrOjCuBEGkZI/imvZkSTN2qrh4xFud00avzkTCNW9d+
         r0y5UEGKzIrmj3rQ92WOR8O062MC3wxzacn1cSalx8eJ5T83OxDFPQVQr6tLx516MhWL
         WwJaL68sTvK8QtDbsQZlLVkBh7b1xoh3iWdhAc1t/gzvZxjUg5mrld+528ma7u2MdeLp
         2LFw==
X-Forwarded-Encrypted: i=1; AKwUvBwdo+vvPGCQ/oQeY0A/8ox5WGy8HuTG8CMB9ofQSyE02iS3OqwajwcKH9jlHFs0D0T5N7HY3u+YQJQe1cw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJSinewEiG5w/pcktY6y0FO2tZDxCRxc8RCxJMUuxjvszm6Ylcw
	WWeoPfmSKSahLFpmuvaV9TbQUoBcbGYaYBZs2e4QTw7ThFkbj2iyuot3rsBQnYawZaFv4UqfLSl
	3vqjSzg==
X-Received: from pjbfh5.prod.google.com ([2002:a17:90b:345:b0:3a8:645b:da8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d0b:b0:3ab:9c73:12e
 with SMTP id 98e67ed59e1d1-3ae57e07896mr285693a91.6.1793139143314; Tue, 27
 Oct 2026 15:12:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:02 -0700
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
Message-ID: <20261027221209.1560865-10-seanjc@google.com>
Subject: [PATCH v3 09/15] KVM: Pre-check uaccesses in KVM's APIs to read/write
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
buggy KVM accesses to guest memory more likely to fail noisily.  Because
KVM installs dummy/empty memslots early in VM destruction, bugs in the VM
teardown path will fail on the memslot checks without getting to the WARNs
buried in kvm_copy_{to,from}_user() and friends.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1058b864d427..d8b914b76f90 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3298,6 +3298,11 @@ static int next_segment(unsigned long len, int offset)
 		return len;
 }
 
+static bool kvm_is_guest_access_ok(struct kvm *kvm, int offset, int len, int size)
+{
+	return kvm_can_do_uaccess(kvm) && !WARN_ON_ONCE(offset + len > size);
+}
+
 /* Copy @len bytes from guest memory at '(@gfn * PAGE_SIZE) + @offset' to @data */
 static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
 				 gfn_t gfn, void *data, int offset, int len)
@@ -3305,7 +3310,7 @@ static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
 	int r;
 	unsigned long addr;
 
-	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
 		return -EFAULT;
 
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
@@ -3381,7 +3386,7 @@ static int __kvm_read_guest_atomic(struct kvm *kvm, struct kvm_memory_slot *slot
 	int r;
 	unsigned long addr;
 
-	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
 		return -EFAULT;
 
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
@@ -3414,7 +3419,7 @@ static int __kvm_write_guest_page(struct kvm *kvm,
 	int r;
 	unsigned long addr;
 
-	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
 		return -EFAULT;
 
 	addr = gfn_to_hva_memslot(memslot, gfn);
@@ -3544,7 +3549,7 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	int r;
 	gpa_t gpa = ghc->gpa + offset;
 
-	if (WARN_ON_ONCE(len + offset > ghc->len))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, ghc->len))
 		return -EINVAL;
 
 	if (slots->generation != ghc->generation) {
@@ -3582,7 +3587,7 @@ int kvm_read_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	int r;
 	gpa_t gpa = ghc->gpa + offset;
 
-	if (WARN_ON_ONCE(len + offset > ghc->len))
+	if (!kvm_is_guest_access_ok(kvm, offset, len, ghc->len))
 		return -EINVAL;
 
 	if (slots->generation != ghc->generation) {
-- 
2.56.0.307.g5fe7bd680c-goog


