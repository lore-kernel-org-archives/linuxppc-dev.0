Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BCA606F2A3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e8JzmOoh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYtp68Nsz3bSy;
	Sat, 31 Oct 2026 08:21:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395282;
	cv=none; b=fA5PkNmKEkuaec81CYLfzb+At7pDUMtanTCyu0z9Gj34qq4dy6w+des/i2ns5LPDnBO7y20Hh7XXlt6v36aiHK7VNKu1pbc0DmRe7W9XFNPGua7F4W5fTDzmraWhw9p6ExqpFlvGg6Lhy4nsnE076/R7BHZjtXyLQs8LvMpIKBvApy2RpJLCLSR3zH1Hk2Gw0WHFL4rIDahSA5t/UxNV9sFn5Rf3QbTYyKjVcssm1jjLdh6Q/CFbSMEictgHFbyZojZyL9cbfiiYejoPnEJiIR6Dv3CA4ozDEGlNSpluY2PT9srQiNuXEzYCvGVrRvb4PftnbkVgzrfNrwhyJAcS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395282; c=relaxed/relaxed;
	bh=aAKXgeyyRU3oc6qV+7Ii8MEYj0RDQoBh44JQ3GvzeWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G49TEnpc2vF4D39xANNcP6iaJxAC7oo4rKm5WJWwX2jsWm40Cgg+7bOUXe2l6fT4jVcs6dZU2FrIu1zJx5BXkzDUF+OiFBZ5SwaCFaLy3CbkMMjFhfwMh6GoB60u43XeiLc+CrO9R5PwXsg5YnKGeXy/Q6lUEIWIkV94JU79XJKIEgcdEpLoxKdXHBxfm+yiNAoK4qq0yj6woLiU82x8xEZRM3WcgrT81VAYQEg3HB9r0HSkIU7sXluGjGAxjsEdkbIuuCeIcCmxlno0uFZM/k7DveWA5S5Hi/x4MRkxa7WwZdS6C8uF6tADfsfRzQ9erb0kAgwFgtgkCO+2n/nnQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e8JzmOoh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com; envelope-from=3twrlagykdfyg2yb704cc492.0ca96bildd0-12j96ghg.cn9yzg.cf4@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e8JzmOoh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com; envelope-from=3twrlagykdfyg2yb704cc492.0ca96bildd0-12j96ghg.cn9yzg.cf4@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x648.google.com (mail-pl1-x648.google.com [IPv6:2607:f8b0:4864:20::648])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYtp0cWjz3bcj
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:22 +1100 (AEDT)
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2e869e00005so18681625ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395280; x=1794000080; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aAKXgeyyRU3oc6qV+7Ii8MEYj0RDQoBh44JQ3GvzeWs=;
        b=e8JzmOohUrk0g8Ixr0GZ8CSkaE+j3mm/73lm+vM8PeNkgD4wOAbETnj7J/q8QU8clN
         i0ewUwbL5FN1ZBLR1MBot7yjMvlEDq4P+3Pr+pNDwNd61W8krbZ/hbWAqB7S0J2WGcH4
         B+roJ1tiGzNsAqtaYXBkW3kT8m61eMNiky66HLQ18aidaew1M2KqFbIRCUp56sF+VcSq
         DO9xL97dzUdDZr8yYskB5LiAXGk4WR1xaM1G9NgzTTXXjsocnSn7xyHf5hSESnKEk+um
         AYs2E94XNKdnINjXbWYjbp+HAiqNlb2rqGz4DNL9wTJbrDNovyHy+HEaCEAr1JvCPLpg
         pPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395280; x=1794000080;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aAKXgeyyRU3oc6qV+7Ii8MEYj0RDQoBh44JQ3GvzeWs=;
        b=Z1vOAbI74sbkds2+7JzEdp/3MDNrxTYrryIZS3NndFABm+318RQuDGQf188i50sJNJ
         URnlg+RG/IJV9e9tf32fHt2GeLWQHk84WZkN69x/0jT4XThuLnmNqSOf3Br6DAoZp4lX
         HDk/8vSVC4RH/rKC0xZYzP4qIJfQas4pzlypeajRXMaaXTIt5Pes4dYF2EFmuwYDps+4
         sn9qZjySy3z81OuJAkhLrIH7MIeX6Yo7OmwT7usiFV3q3DjxEqgeji5kGkyCnKBqhbxI
         zX1Vwm7F4EPeR26S6JjpoP87KRhP2TpBPrfbXo11TjiJcKQmptUwEoJw7g9Zx/S7jOhm
         dG0A==
X-Forwarded-Encrypted: i=1; AKwUvBzHVk2P8zZQ59pFSKzWbHQQKhQEm8zpuSAQdbEhc2gVzLi4Wavq8SSvEa3RKIf1WzcKOAL6gxELqBWBE3c=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJZSSnzRSlZBn3VxxFMwC/4RZqgn4BtJmc5dJqZKrpxKU95klaB
	xgDFrP0Z1Ip0D7RO+CN0UqBj3bdh/REvTagCfrbEsqANULeNV74d+PW/zi/z8+sjPHDVJay0Zru
	tgAzIcA==
X-Received: from pjbfa4.prod.google.com ([2002:a17:90a:f0c4:b0:3ad:99d8:e894])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac1:b0:3a8:211b:6c6f
 with SMTP id 98e67ed59e1d1-3ae898662b7mr3039027a91.67.1793395279439; Fri, 30
 Oct 2026 14:21:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:53 -0700
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
Message-ID: <20261030212112.2598640-6-seanjc@google.com>
Subject: [PATCH v4 05/23] KVM: WARN and error out if memslot update encounters
 existing slot with no pages
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

WARN and return -EIO if an existing memslot with npages=0 is encountered
when updating memslots, as KVM returns NULL if there is no memslot since
commit 0577d1abe704 ("KVM: Terminate memslot walks via used_slots".  Before
that, KVM pre-allocated all possible memslots and relied on npages==0 to
denote "no valid memslot".  The check on npages was deliberately left
behind to aid debug, but that was over six years ago.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 218456372b11..dcd28b45ef30 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2086,9 +2086,11 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	 * and/or destroyed by kvm_set_memslot().
 	 */
 	old = id_to_memslot(slots, id);
+	if (WARN_ON_ONCE(old && !old->npages))
+		return -EIO;
 
 	if (!mem->memory_size) {
-		if (!old || !old->npages)
+		if (!old)
 			return -EINVAL;
 
 		if (WARN_ON_ONCE(kvm->nr_memslot_pages < old->npages))
@@ -2100,7 +2102,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	base_gfn = (mem->guest_phys_addr >> PAGE_SHIFT);
 	npages = (mem->memory_size >> PAGE_SHIFT);
 
-	if (!old || !old->npages) {
+	if (!old) {
 		change = KVM_MR_CREATE;
 
 		/*
-- 
2.56.0.385.gac671c819a-goog


