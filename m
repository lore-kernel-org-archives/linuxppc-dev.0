Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3E606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S5O0bd21
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYv20VChz3bs2;
	Sat, 31 Oct 2026 08:21:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395294;
	cv=none; b=MKLQB24HkFOaR7IrTdH1JTye2Bq830fqnAJl10RvhLVQ1C+citUxil0EwbsmKBcQFfpEUi9GC5Y2eaSTyacApUGOYnvsJdCfnloQ9SY8+RvIeIqpbsFWwbad2WZqFh/Rmpj+7GQPgLQH3ur6BYtq0lXac3Ng4iLvnlmFkgP07ymJtPfuWcFFUKF5zJwRRX1h5PR9HAFuwHBPkOuZ0IcajSaFmZE+O41gR0aHwSPzeCuNKJLXYwvNmdTq3nOelfd7wTQGT5urHB8vaIvOYHJx5K71JuVS5jNkhsxPCn9yKt7wBYupSlIf7TvEI52xCubxdJrpT1wd97YMhq7Tlh+Imw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395294; c=relaxed/relaxed;
	bh=cco2nkq82iuQQ+19T+wEIhTi8zWX3dqm0jybMBLyVmQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fPI5O1LcSEIuAhDTA2FX7FrWOk0e1I5BT46TNe22TuhA3WxGn8bY99AsJNWTTiuGsKgof8stIaw94V7rr0IiMk8xOZ+h2lSxAr9e6r17qA3vB1PkuI1L4QR6sobH1/UW1LBb/SHuKGCeoLNVvnOZt5+lBfhU6j7OChdemSUXnWgMe5744GwEyo26+EqfZbe9Y67K5AHYOO/2HULf6EN0KxMsYznDBCL41lJpcE2k631Gj7/ZEHHekplmu1hGIzKyrafPvmm8wi3OYCtIsy0IvFs64QrgNZFatENxUZlY+0l0c0fkUv1pKGXkKhL39f6Ue/dT0lJ3BnrDXvJ68/Ov4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S5O0bd21; dkim-atps=neutral; spf=pass (client-ip=209.85.215.200; helo=mail-pg1-f200.google.com; envelope-from=3wgrlagykdgerd9mibfnnfkd.bnlkhmtwoob-cdukhrsr.nyk9ar.nqf@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S5O0bd21;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.215.200; helo=mail-pg1-f200.google.com; envelope-from=3wgrlagykdgerd9mibfnnfkd.bnlkhmtwoob-cdukhrsr.nyk9ar.nqf@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYv13MgXz3btS
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:33 +1100 (AEDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cdac99e77d0so495288a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395291; x=1794000091; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cco2nkq82iuQQ+19T+wEIhTi8zWX3dqm0jybMBLyVmQ=;
        b=S5O0bd21hOY3OcfGzhlHyLf20GxJifWa66WpyPuDHk2JHFkIlFwl93oCUOyWViNWuy
         saPbySk4WC2MvGJbQBErWpm4+GfOB5IZnJq6Eiap9zsiiGQiKGtuOQmrd5urtjJhH4vT
         vX3YI5rHe4cJJWAlw+tJmB3XOUFqoahiU0rE+oLUMfR+ytUOZuGGvPimaD2y1Mr56lP0
         PSXiNQxutslRftBal8DOi2RmsPpbDP5zEIXK9WzVKyFcTSmHg5IkUTHtF8CK9vmkap+i
         Rg53pDoOo8N7GoGP/yr9AdeoE2dLc7aF+JQPLWcYXeaBOm7e6IurzXGS91knvC3IkcJ3
         OI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395291; x=1794000091;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cco2nkq82iuQQ+19T+wEIhTi8zWX3dqm0jybMBLyVmQ=;
        b=noyUdWFFQW3h9sNTVL1XayU+i6196mISemZeiYOoKh0Eqj975G2LZFVf0676CALHbT
         OvLlAEtOuIpqUoJlztES3fVSOKH8G8vWdn6y4QIyUt76LUBmIdC2GMxX+mTUeoKeXU4i
         3Pr4ZBUNC5aPvWD83edf2y9uXiBQdMnHUCcqIXhABlR5yjqNa/FverZa43ZScUg9VcFi
         iFHlk/q5XxcpLE1hYNC1YIx+ighRqpXSOYL2HBXpzBPD6T4QHC2shrX5E7x3V7qiMXoh
         f0qEG/RdQFmDaURHweCGKUstvdgxNnltRuV2fJq0rUzkY/BSJ0IxTm5UV0GVgmXX1YjD
         5YOw==
X-Forwarded-Encrypted: i=1; AKwUvBxLFZ8MCeJzei4Msa+xT9aqUJ0dXoimSBHauO3iX4u0NMC4ATg8tYyp/DrA9I8F8uDbs0vzOr+DNKYUrE8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKbJCZcg6aNZZRnInkRbNaaP3pvw+07IJeiySZtifzG9hgNSNOL
	IpHTLkTQqsr/5zQOMH9iw8BKVkr9Xdmy4dqkTE8M8OPn/7Ad6jqLHwLYmSdQGIG/ynGk9NiJX4A
	ihzxLcQ==
X-Received: from pjbev16.prod.google.com ([2002:a17:90a:ead0:b0:3ad:fc31:f458])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33ce:b0:3ac:450a:fa22
 with SMTP id 98e67ed59e1d1-3ae89536c44mr2992819a91.2.1793395290671; Fri, 30
 Oct 2026 14:21:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:02 -0700
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
Message-ID: <20261030212112.2598640-15-seanjc@google.com>
Subject: [PATCH v4 14/23] KVM: WARN and reject guest-based uaccess if VM is dying
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

WARN and reject user accesses to guest memory if the associated VM is dying
even if the current address space happens to be the correct address space.
Accessing guest memory after the last reference to the VM has been put may
be "fine" from a safety perspective, but it's still a KVM bug.

Reviewed-by: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f3f59bdf7e18..ba8ea62b7304 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1355,7 +1355,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 
 static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *kvm)
 {
-	return !WARN_ON_ONCE(current->mm != kvm->mm);
+	return !WARN_ON_ONCE(current->mm != kvm->mm ||
+			     !refcount_read(&kvm->users_count));
 }
 
 #define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)				\
-- 
2.56.0.385.gac671c819a-goog


