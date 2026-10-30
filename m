Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1DD606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UvZi7QbR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYv067d6z3bqh;
	Sat, 31 Oct 2026 08:21:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395292;
	cv=none; b=HflveHwamnzIzfv69QixD1OotEwI2t8Q9BladLaX4t9XuXR2lvO6ZAWyCF7HS3tOWsjoMcVz40z6Oul57dWkKcVjxr7P1KhBF1qKIKn97KUug1j3tjMp7SKx4nGU9XAkxX/mjrV8UDZpxP0/aYWSz73C3Ki/azOImnRbcoXcrgu1J0K5RJ1wTB3EYnGPneBWqgDTUuA4lguttt5qczhhDE7PS01BvkjdpVZph2ak0i9NqQm3B9lcQMNEGymA4Tq5wTfS7mYpfmf7Yl+7BbqHzekkp1jzKY+JOb5kkVC9zpnh4WUACIF1v2vma61hwVeDxjLfLeEue9MGLNzolaBfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395292; c=relaxed/relaxed;
	bh=iFN1OdobNZOI9Kqr8g7DQiTe1TY1BZi1PiVwsL0/XKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FJlvWkgjKTql8fXIPned+Rj9K/wMmJf4CfvCCI5XaPICQwqmtG4LfbUHIeCXLpT74luCPVmFrla/4jim7helS4Dua3+CSN3N1L/ycUhtfhxlp3pFyadsHk4gm+nH1HUxJkVR6B6vET+N92uECFAZkLrLLwEZvGVejztak2eWeaQ0wWX+q4YcKa6D/0sOWzAgOXBB65oNeLIH0FMhu0wtxybzd6rJe+XMgOKjCdiw4cnOArj7ZXOvs09EuD+OcO79V+EnwndalITYnVRmohPFLUxnUHxeNkiGnxlw6NdWVejQEmLuqXD/OwlsFLkje8bQ3oAZZIO+V7tsXqLl0mU08w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UvZi7QbR; dkim-atps=neutral; spf=pass (client-ip=209.85.215.197; helo=mail-pg1-f197.google.com; envelope-from=3wqrlagykdgaqc8lhaemmejc.amkjglsvnna-bctjgqrq.mxj89q.mpe@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UvZi7QbR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.215.197; helo=mail-pg1-f197.google.com; envelope-from=3wqrlagykdgaqc8lhaemmejc.amkjglsvnna-bctjgqrq.mxj89q.mpe@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYv0184Gz3bs2
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:32 +1100 (AEDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd61bdc8683so609638a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395289; x=1794000089; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iFN1OdobNZOI9Kqr8g7DQiTe1TY1BZi1PiVwsL0/XKQ=;
        b=UvZi7QbRa30yOWPaT5m6+mnP9KR9+TdpaTqHGDQA1p/V/n7H7+uy0Km7ZXCHL7c1bi
         2Aa1785nzu0bio2cn7sxwt6zxQVUapXFL3qPErzaoDfRvx7/ETPZCNfayW27xiwVs6f3
         hsFyWPBGiR51o9TnXVx8faySLYtbCKwVAtkLFrEV1sp9vKmI0lte5Ovk1weq3vDCGdXz
         f4A+Ud/bDK/X1zjbyzSusR3OA4kDiXxhaDJcmwRCeIIXxNMnKucuOae1eBPYqgiOgT/r
         c8qUJO6fxdEQVIVrIDvJmgAHVWlTdIPt6c2ed1Tu1r119wkTLPH1ggBoafx+k58ejzoQ
         x6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395289; x=1794000089;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iFN1OdobNZOI9Kqr8g7DQiTe1TY1BZi1PiVwsL0/XKQ=;
        b=fbc+8DMAfB/uYc4zx5vCQ03rXEJlIL5+LZvtdygHZ9/upQJofvK5J0aOYH0srfQm+F
         XQkFtgyX62rQxdhZPB19nJ/qumnbattlPIz12XsNnft9KLGFX6Cv/9nbhnS3ebVo63B5
         C3ur5fqMnMwnGzIbju6y1r13XsaU7tQsdzJVdP4OI1OWMjx8du3ZqOt4PEJ+Y3jLFN1T
         dx36EEqajqmevkqo1pKxM2PhX7gmBASosvLUN32QwLUyVnorPsXYNeuOeFA3KA69NzvM
         MLvCJf1CVxTwdp/++jiPh0epGtyGB4PBMD19rHe0ux26ZNVKznk3Jm8HPmk2pCvcD0qA
         vyog==
X-Forwarded-Encrypted: i=1; AKwUvBz6DFbJUP+IAYSawwl3M+QnOxnOoVR2cJweq+1Ydku//D5ENAXBegkhhI6fJenUQhNckhJIMBpSSsO0078=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIeGPxAWMnHHptRMnyhlERNpzkIOepf72CIfs9VwYKW/tMYGRDd
	lirdkYf/ynCCqAfH4kwilJevBY30y/IzwXZ34FTIdh9hlbYd37CAB3Bm7Zzq/k+WmaKeLR2ROvm
	sge5zig==
X-Received: from plsr11.prod.google.com ([2002:a17:902:be0b:b0:2ea:d63d:f2c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3804:b0:2ea:fb8b:258d
 with SMTP id d9443c01a7336-2eb36401e95mr37934335ad.6.1793395289485; Fri, 30
 Oct 2026 14:21:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:01 -0700
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
Message-ID: <20261030212112.2598640-14-seanjc@google.com>
Subject: [PATCH v4 13/23] KVM: WARN if KVM attempts to do guest-related
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
2.56.0.385.gac671c819a-goog


