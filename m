Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADC76073163
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QmXtQfT0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDl930CLMz30NF;
	Wed, 28 Oct 2026 09:12:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793139142;
	cv=none; b=GIe+dZy6pOWveqRWO2b32AknsE5OU2bYtW6PonvUfb4w5/ZIwV76dvBnT7PLBN4Dm7nwxv52g9/A/VFOtksfH2HmVRHPdwsPR0Ur5wezKwa3hamuN1O0P6ioiVKKUUJuTv4T7gF/ZkEl2Yk642ZcN3idXsFpFcg6QaJN1X68YLnBAqbGoVr8+q+pqeShYDoQN6UyV6dI0EsaHR61wsKkj6LBMTYkZi3gcHtyOc1vbMg5oIy6nfGO8DSpc+/g0ZIZNhz81WzhS6dqb2Tslgvi9xuy0nHBsPvHaspMZYp70VrZQPk9NWq2FDC12gh0yMMbEZAftukumUKjDw3a2JFBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793139142; c=relaxed/relaxed;
	bh=6Of8T2K/5s+DYFHs2DSa93Ge3Q/T1My3lt2s33kdfKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ihBqoxd7vehB54GxqKo6RoRi7MAgXyidqiUUR0iu2KvuDhU7ngqv9VjH1x4qR3DGqwmcHli317cgy7IqSiQYkpKuyEy9FXgrMpsnpyxZKUorlZ5sopEsOFwTIeO9/dZqnmJRjwdNaS/SaISlQmUbsS7eO1oYR8s2zCxib0LTL3Sy9R+PQfFkFJsaf6bHx/wqc6A1PLnEU1TqqwH3Zp6qHoqFXFoWifYZ57wcuNWyHfOYP6PoyDM4MtulgiIRO22sv0yK6CW2YMpHbkSphLqPcNLlcA0zxTAnzmUsxeZL12gyc68GAqZN6r72To1eX91BS0qyxqwccSMgNUyhKvxMrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QmXtQfT0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com; envelope-from=3wyhhagykdogcokxtmqyyqvo.mywvsxehzzm-nofvscdc.yjvklc.ybq@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QmXtQfT0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com; envelope-from=3wyhhagykdogcokxtmqyyqvo.mywvsxehzzm-nofvscdc.yjvklc.ybq@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x648.google.com (mail-pl1-x648.google.com [IPv6:2607:f8b0:4864:20::648])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDl921fsZz30VF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:12:22 +1100 (AEDT)
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2d02df2bf09so2098425ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139140; x=1793743940; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6Of8T2K/5s+DYFHs2DSa93Ge3Q/T1My3lt2s33kdfKI=;
        b=QmXtQfT01EoMqP1+HpYC+UpYKLWTJVaIspMnB6zIhXDV1OR9I28+nvmNZC8WVNXcT/
         XfPMlijxlgiwTOIBPLLbSZAEME2NYNpdkg2lLu0X6Na4qpHCXgnLjcrXqqB3KeYjsMCE
         8w+iCkd/XrGvJrqCI9T2pbR9bNGH9B7e4NhHnfXwAoJXwayebFdWspmxcxiVozR0T2cT
         t5jv0AFsvZ0p8vEYY8LyIIwnDGWW8iuodLEbUCT+gD7/jEYbYLjD4hQ1vMuQWdLTjYyt
         efAqBYl6QYTWWbUamww9KK+gzvRwdlvnecKLpx4vuDgEjzfFPPzc2ZuX2Hs78nKzt0sz
         QjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139140; x=1793743940;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Of8T2K/5s+DYFHs2DSa93Ge3Q/T1My3lt2s33kdfKI=;
        b=wFWCr/8ng33KzEsve5fN+BzSF2QfEHyVBOHiLlLsxGwZvMq2XOhLImF9xy8G7Z9fgt
         vuYLuwbeggiyhf8Y/ywGAwCSveqt2TUqkdojkPZcgj3G/Ja3Ovxhv/pZS8/p3zyq9/xM
         3TDZnfA2YmLOohFJjf71uVHD9b4rfiYuHEwJ1kSLt3mFiRC5xCo93Ad+++fj8izq4fCq
         FxRELLKWVFkZp1ioU596Fx7w35YqkgQZqf1xlzsVhIjL28bRC6y3v9W6LRrWiFviRtAc
         KDXIikyMmsjn7YOzLmImpmMC+21v8/SyARvQ/phc70/+xzW1uYY1P/ZqhCPFvRWOVUzc
         28nA==
X-Forwarded-Encrypted: i=1; AKwUvBzH8bWY0g/YyhwubbFUDE5qPxrysI6ELqpuK3sV1WOyrGQHFcSShcxsZAKq8hFyh1rZhZVxhp0CWxzaAA4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJh7b639vKUznTqBqpIRN6P5OBZ0k2kpfCAwF90znavUdGOMRvL
	biqBw9BKxEI++FlczlF0xkVJgB1zE+8FpNT+sGXmiNe6mdj/sfcR+cAnc+s7mNRoaE+cQR5n8Pd
	l/1wgKw==
X-Received: from plbjw20.prod.google.com ([2002:a17:903:2794:b0:2e9:84f0:65ba])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c408:b0:2dd:ad73:c989
 with SMTP id d9443c01a7336-2eb004b1c6dmr5194065ad.33.1793139139723; Tue, 27
 Oct 2026 15:12:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:00 -0700
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
Message-ID: <20261027221209.1560865-8-seanjc@google.com>
Subject: [PATCH v3 07/15] KVM: WARN if KVM attempts to do guest-related
 uaccess with "wrong" process
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

Now that memslots are torn down before kvm_arch_destroy_vm(), i.e. now that
the massive, unaudited path that is known to have at least one rogue access
to guest memory should be short-circuited before attempting to access user
memory, WARN if KVM attempts to do a user access to guest memory with the
wrong address space.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index be27b4e8f12d..f3f59bdf7e18 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1355,7 +1355,7 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 
 static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *kvm)
 {
-	return current->mm == kvm->mm;
+	return !WARN_ON_ONCE(current->mm != kvm->mm);
 }
 
 #define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)				\
-- 
2.56.0.307.g5fe7bd680c-goog


