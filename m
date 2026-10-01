Return-Path: <linuxppc-dev+bounces-28691-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA3ECA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 20:23:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwjyh35rCz3btl;
	Fri, 02 Oct 2026 06:22:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1048"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790886172;
	cv=none; b=FNCKo2UwYl88UHdUDHLFM750SVc5o42YkSqwHlyED7oq3eyyE3mb4ki8sRZWCgPcuLwChOZQSM+JEzuffiXr2/+MJRjVc+6ejO//hZIltMB/YVAlzwBfQ9NiZW5fZct/Kv03EgtmYvxpYhXkVUlMnnmqZODSYHKDuprh4RR3ez07ErpqeKn5FDGqs/vOzVAyuZ68LY2hl2rCtuX7NgTK8FurxzJ7nyVFi+3U06uti/922cb4S9xdbJTAsu51OwOo5blFwLaplpVou/5HZD8im69xWAxmAlq7bO+bqtojfECv9gUylSQ/Y+R5owiR/t6kncjMPX+qX49tyaT6z7+xPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790886172; c=relaxed/relaxed;
	bh=odUI0VjKINbAApKe2J4PsRbiL/cueYQz4jU79+gDb2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oOJIGWENkaC2vgUdJzykfVtXdM7f2w0glNwkxdrwfz8QL2eYWJcgfBYFJ7MjuIFJTcF6Xm2/4ceGf3PWw0AUhXAsQ5UeDJbb/LDabN5HdSf76aRu82O9bz+sZ4ErqJgay+FelFf3o/g+CXoOZfRMFGQ49N5cVPfDlAmer6veqnwWoOnp60U5Ggw2r1QqmTyp6Ts/RbX7C+ps2iTSh9G/yY5VmJNMbgoIvMjcEezfOSqAuYP9FFdj5HNra7IBdnqvdx1vGr4+ZDhN3sQ5Oam38nVUi4GivO9AozgUyUn0uiA58oa19w5njNwmME0NXQFG1YklmcQVp42KeV9S7jMNpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VGsgFM+c; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3gcg-agykdpimyuhdwaiiafy.wigfchorjjw-xypfcmnm.itfuvm.ila@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VGsgFM+c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3gcg-agykdpimyuhdwaiiafy.wigfchorjjw-xypfcmnm.itfuvm.ila@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com [IPv6:2607:f8b0:4864:20::1048])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwjyg3L35z3bsT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 06:22:51 +1000 (AEST)
Received: by mail-pj1-x1048.google.com with SMTP id 98e67ed59e1d1-3a4b70941efso2555196a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886169; x=1791490969; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=odUI0VjKINbAApKe2J4PsRbiL/cueYQz4jU79+gDb2k=;
        b=VGsgFM+ch66kTbB5C0vO+qmo/RMK5qMz6vAbuTgcRctrn1815I3wYuphztDILEGlzu
         /NUOWU0gDLzNS6lwGLAz8tXB7UvhAtH+QVI0VA1JcrUP+k2vKgz7YKtZwKGaTd6FHIjS
         vGTdy+32hqUGv2+rfSQDYCzCEsnVYICyrucC42UmVN+dg5va8/TPywDKU7THM3lReg9c
         F3DpQxsc+pEO5nczWk4MwKlKefZtITMXskhye/QPEht2o6gVFKta2u/J66bXAbDiZvxj
         g4zZ8VvINw2cEF9SheBs54ho/IVugzjPlmDAfpdI6EUSat6NVvgCaRZm6Xg14c0+y5xY
         G8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886169; x=1791490969;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=odUI0VjKINbAApKe2J4PsRbiL/cueYQz4jU79+gDb2k=;
        b=1ZMWwbulgNXOPXHrzpbU1QSuloEPGCC8v7Ci2L/fMCGUvxKjjrzQAi5Ei/akndgRCh
         GlSXFaVI5vYJ/iqfAt2FlLC2lLjillgk5XLXt8UUsv42RNZPlbdi4W3vTqghqq+ZEicv
         IhiWUwpVemEQyodJx7hOmVympJTCiDWcv7EgblW2rBH2y2qsYN1mpmNDGERBro41PCsV
         1EGvw053VnnhmYtlYpxgoYp3P/CmO4eQAgz31+M4iDIAClfFeoC7I+s3M3ZrW2oA7pcn
         4Xc1zSUmbD1S6owjk8Dfzb6EsKEODq+HXjYbb6FnfsHx2mFUmy04PsfI0KcAKn+gilmd
         RKIg==
X-Forwarded-Encrypted: i=1; AKwUvBxJWp9216L0fCfoFC9rxYXq8ZvKbczezZRWp0rKYkFdoWRhN4YOU6QO+Uh5nvct9LERfLlUB5LM0t277Z0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL9RS+e9uXHGotx451O23UL1Q7agDoKJc+yk1laji9XQ06Gwcjw
	3KrHaILsvuQRjMC/w5L+G+Hf4cSYVsan3L+NvTVPZmUzK23wBedMlhwUe0SbnLJ4J/mcjF63yIZ
	zKUazCg==
X-Received: from pjxd7.prod.google.com ([2002:a17:90a:c247:b0:3a2:a95e:c620])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:268a:b0:39e:2e79:7ce7
 with SMTP id 98e67ed59e1d1-3a6ce3b937amr517701a91.6.1790886169237; Thu, 01
 Oct 2026 13:22:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:30 -0700
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
Message-ID: <20261001202234.3794060-7-seanjc@google.com>
Subject: [PATCH v2 06/10] KVM: WARN if KVM attempts to do guest-related
 uaccess with "wrong" process
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

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
index b37cf275ef79..2a88e4ce145e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1352,7 +1352,7 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 
 static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *kvm)
 {
-	return current->mm == kvm->mm;
+	return !WARN_ON_ONCE(current->mm != kvm->mm);
 }
 
 #define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)				\
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


