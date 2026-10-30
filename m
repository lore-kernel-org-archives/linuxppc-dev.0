Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6512860701EA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HGIuvRLS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYtn3lGHz3bZf;
	Sat, 31 Oct 2026 08:21:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::547"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395281;
	cv=none; b=fFNZ7WU2f+n3/cO89orhyUM6z/ILLriuCXfyHiksqYjJV7QM5DnFUfWDC41kBnEhIe0MuSr7onqmpzToDUmUOkZq12OkONcxAt359wFIbO3HYS40REALr+DfoDT8hqA48oBCrYuzBiej0dQMshmWXbIxL/eKHsZJCj5FGZBmTOETiDnyqyBl634iHZbidxjqkOEKCQLPNow2XhSefYN3ZUpc2cRFvO7jET/+Pogc4Ra0T/tYP5GIVRHjNn+lRm+UuWJJa4BJXc+FJVjlIBY/uu0bqCzL1v8mm6qx2gnZDoj4voLlnJlpwi/qL6baPPaXl1+hoZ5blAaMzyGEoxB3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395281; c=relaxed/relaxed;
	bh=MEhWTFe6jtxX2Dal10Wapygbfs7VfCvFh36BKYtVScI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pg5lJg4EByoekG7Q5wE5Mm4ZPFTuQ+8x281p481XnWnRR/iaOAr0amtFTtFgAutZv1KSb6Np7EJCCwu0cGVaPe1P12Ig7I8nQRPK/fNA+Lj3Jgauc/aP4blbFyYd3YeHO5aoVt5puPPe3cq4HFYlyxKmtTUXzkZV43XPOYn3vaK4UEyWEnhdYokOCNQdoCNpFJzrnDsRKExRnesuQCsEDo1X2W/jBlKidgmHmXq8Xh7+WOrfbQxeHDAaz+V9mmbqVLnhUSGP9GPUUpb0iXeqf33YoomfFkaxCiIVsizCXdqxRRuylqhvXk+PwocC1jpfZ+DupJwt4Yj+r+ofEc8rfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HGIuvRLS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3tgrlagykdfuf1xa6z3bb381.zb985ahkccz-01i85fgf.bm8xyf.be3@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HGIuvRLS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3tgrlagykdfuf1xa6z3bb381.zb985ahkccz-01i85fgf.bm8xyf.be3@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x547.google.com (mail-pg1-x547.google.com [IPv6:2607:f8b0:4864:20::547])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYtm4pdrz3bSy
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:20 +1100 (AEDT)
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cca35cf9f77so686968a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395278; x=1794000078; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MEhWTFe6jtxX2Dal10Wapygbfs7VfCvFh36BKYtVScI=;
        b=HGIuvRLSgZUSyPKBPA1plow1K68VUu5GoHsEGU4m6jstYPAAdHAnsRsiW/O5ZHPwpj
         09qLPIlSV0hUytrtR8HrJj8ofzl0FEA5ggaCArc0GYT8/HkOCeT8s+9G7fHHOzRGhO0Z
         Bn7XSxTGyKP6ZUVKwieXhzrjwzuG8kkgECVJHlzR7ltpa4amP5EMgk/gGQVzjaA3Vmeh
         ymF5nN8Tt8OkvhMOw3g0ZMS2VTsh/4hMxNwbSVZuu7sarDIpnrK8r/MuSat+TwS4LDvN
         Ma63OTNTxIXdqv8BASnTLTEEEuuWTA868GZQN7btPUBTCeCIt34PDq/1Fyg+0PcCCy2s
         YUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395278; x=1794000078;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MEhWTFe6jtxX2Dal10Wapygbfs7VfCvFh36BKYtVScI=;
        b=qEQhjp/rblYhOe1g3FL+qDpIy3AT7qBf4lP12CY1UmagceOV4hZrpHx9gHMQTOxM4K
         55hedMpLSf1c5eubd0M2FCPy2+KssVGFh1wVYr6pmWOmEy6hgDNeKukWYk5BvT3wWiCq
         w+H7x4n8fcCxONqdgaU2MGZSIqGAlEq0IGVrx+A4nFn3kebJnXzBc48sbZ9Pby7GV6bi
         ojNLlP3VesL7auYhIa8SdEJRpS2HcfLu9LaoWnp7mCUsmXgOOofQnznRg2GHQlzR616K
         /EGQ3QhRPLWtg/rjcZ5ddjNFLnLSaJPf1w3FQjcach5rickD5XLPapweDT7U+KCgpU8N
         lKpA==
X-Forwarded-Encrypted: i=1; AKwUvBx/jWA8sOf2+AXUXnfzrnPu6wPB8Fb6jFppzMJt5EfijRxk6VMmPm8gJG/fHthdPO3yRr0bQnQgDgZAhDs=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYImhbulYWB9pa8eDSygaIprqMgPQj8bR45ydPWZKmyXkZH5HtIL
	NUGPRb88/ZDi6bZsVjGZ6HI47E+fODF1FLeHjXxrE8xkB2cRC6Bq4tplme2ksjbfCCTvQPphI0K
	IkyKpEQ==
X-Received: from pgbd28-n2.prod.google.com ([2002:a05:6a02:64dc:20b0:cd6:1088:b8f3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e8e:b0:3e1:c08f:c41a
 with SMTP id adf61e73a8af0-3e928daac3fmr3216721637.49.1793395278183; Fri, 30
 Oct 2026 14:21:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:52 -0700
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
Message-ID: <20261030212112.2598640-5-seanjc@google.com>
Subject: [PATCH v4 04/23] KVM: x86: Drop dead check on an existing memslot not
 having any pages
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

Drop the should-be-impossible check on an existing memslot not having any
pages.  Ever since commit 0577d1abe704 ("KVM: Terminate memslot walks via
used_slots"), KVM returns NULL if there is no memslot.  Before that, KVM
pre-allocated all possible memslots and relied on npages==0 to denote "no
valid memslot".  The check on npages was deliberately left behind to aid
debug, but that was over six years ago.

Side topic, there is no need to check for KVM_MEMSLOT_INVALID as it
should be impossible to see an invalid slot while holding slots_lock, and
more importantly, invalid slots preserve their original size, i.e. the
npages check has nothing to do with to-be-deleted/moved memslots.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba9..cb8b60da5b11 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10043,7 +10043,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 
 	slot = id_to_memslot(slots, id);
 	if (size) {
-		if (slot && slot->npages)
+		if (slot)
 			return ERR_PTR_USR(-EEXIST);
 
 		/*
@@ -10055,7 +10055,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 		if (IS_ERR_VALUE(hva))
 			return (void __user *)hva;
 	} else {
-		if (!slot || !slot->npages)
+		if (!slot)
 			return NULL;
 
 		old_npages = slot->npages;
-- 
2.56.0.385.gac671c819a-goog


