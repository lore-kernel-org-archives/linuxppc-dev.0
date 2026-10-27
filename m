Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C31606A327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WHBVDPzt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDl910D4Hz30PJ;
	Wed, 28 Oct 2026 09:12:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::545"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793139140;
	cv=none; b=Yvte8WSwaSYNBoDDfGHcDgd1OjNQhSHf1ksbrTUlfGl+h/iBZJX/EHsWjoAIAdmWwAVGDoz3Z7DL/8tsoml7Ttxcs7krE5RgigbYStatnlrWevYLiDjIkulF45ok6e2gPowTEkPgLyIkicr1lnBGigMxM4rZw7/v6o9y1Vbv1vaX+BHLNjY/vPh7wDPEtTEEca0zbR2oSIftZO34t9S043ivcoJ1U3sAR+J/1MWq10nzbJr5RVU6KYqg3th2Ruml1+F5kYJI3Pc0w7+QHPpowk3pLJgn9zc4SBgiiqObvz4ngMd83+w7JBUKGK1QvjtIkOeYgAvdmCB3CaRCVggJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793139140; c=relaxed/relaxed;
	bh=46E3EGLnWSLxFlTim02Ohjypmi0q8zDH6vLR5FUSx5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IbF32ruX0lZAuPhqRom1ZqIJ/pt9Cp+9g3RWwOzYpsoEeeynC2WO65XJ0ufNtgOScyln3A3iSb2YJGx3jHL/eZ2MyyJIdzw1Wx6+jFKUF/VH9JkUg6z0HgREdEadvecMBP2CGigc3aO+allCd6Whq+SBp1nszSbf/vdz4JgcIUQ+jsm+DoTPH9eDu/LN5ahhlVzmvyotDZmS4+Ny8XC+wD4R3Y06N4zSjPZIFDl10iDjWQvz6KVLP6wesejm/b/HvAFG1K7lXXLC5C97H+Q6+DRhDJupoQOPjphKMOhN/YNZJavC4hg9KsDkxL2sESxLLYWcN3sGOb+x6+8zRoJRZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WHBVDPzt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::545; helo=mail-pg1-x545.google.com; envelope-from=3wshhagykdoyamivrkowwotm.kwutqvcfxxk-lmdtqaba.whtija.wzo@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WHBVDPzt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::545; helo=mail-pg1-x545.google.com; envelope-from=3wshhagykdoyamivrkowwotm.kwutqvcfxxk-lmdtqaba.whtija.wzo@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x545.google.com (mail-pg1-x545.google.com [IPv6:2607:f8b0:4864:20::545])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDl9000KWz2yvW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:12:19 +1100 (AEDT)
Received: by mail-pg1-x545.google.com with SMTP id 41be03b00d2f7-cd0b795aa8cso924088a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139137; x=1793743937; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=46E3EGLnWSLxFlTim02Ohjypmi0q8zDH6vLR5FUSx5Q=;
        b=WHBVDPzteTyKOGJ/nG8c2WW3Iv3SSyKYiuU06h//9i9NGm/WMQr6l7tmqC6FF/S/mY
         aWqx7PbIy/ORNV3xC2GUUuUPDuaWzwkiP6So9/8SP41eZMYahyuB8I88YZTkEE/2WePZ
         OFjggShZWGGzhALo6HuoNTNswXot662U6Etgv0UlN80GSdzWczf/WOn9sFDNujyvDMSh
         85bJYl/hAQqXwk3smRYq8jF0K/lSof8eHllYhX8iJHJGLp097ju0api4On8Zih8mQ68F
         YGTqZ79yd5rHseRe9m4Z71ruYq2neHdOZwRLbAwUpBlPE7dy5khe401utV/YHXVACXJf
         AojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139137; x=1793743937;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=46E3EGLnWSLxFlTim02Ohjypmi0q8zDH6vLR5FUSx5Q=;
        b=1ykkgolotwIRtW7aHdNGE/0K56B7RDD57LrW+FUzJEADCmsOw3oiyBd6RZ0x9gDy9L
         SxiEWXj84gsQZ02h6Rbr8mBqnVoBIXuu9jwyvlsD+2IF0eaah4scQJOPX/VWIHCUSMPj
         Pcl5JzzlsnpWdzNFcJqRy2xLXpEujc8S7vRlDQHhlPTN9nB064Hu1M19QP5TMT4spmD7
         XGNb4IQC0RJguCrvixJj0gR5JoUFO7ARuX5GlJGVsb+r/OkelVAaSaYwvdOQONW0GTEP
         3ocfVRZSUxnd6rgxUEM3hjJJ4jaJVKNjDuNk1T2v8fSuW1H++K7gQp+065+ntpO3kaQI
         XGlg==
X-Forwarded-Encrypted: i=1; AKwUvBwh9IPbaeVGqOwhPOywti70oiL6mv30D+1X8jZBXCP7ZZ7CeTVUwSoAKdX8FSuMEVYxNX6g6soMrm0Wbgc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIJJe1aQsZbexaq+obwkpQQ3kBJ3JikkqmTEevChufR2JPq7FVV
	m1IGZenHCfVPSQNg8DcQaR/2c8elE8Acsgo78NlaXpwMlKCRPEuHwz0qkpq0qnbPHp3Z9eFzuIF
	Zhb8cpQ==
X-Received: from pjbsv6.prod.google.com ([2002:a17:90b:5386:b0:3ab:334f:21ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c0c:b0:3a2:bb9f:f87d
 with SMTP id 98e67ed59e1d1-3ae580d22admr196697a91.21.1793139137381; Tue, 27
 Oct 2026 15:12:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:11:58 -0700
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
Message-ID: <20261027221209.1560865-6-seanjc@google.com>
Subject: [PATCH v3 05/15] KVM: Disallow setting memslots when the VM is being destroyed
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
index 218456372b11..e7c89861632a 100644
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
2.56.0.307.g5fe7bd680c-goog


