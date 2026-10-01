Return-Path: <linuxppc-dev+bounces-28692-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F5DCA5FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 20:23:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwjyj3Kj5z3bxM;
	Fri, 02 Oct 2026 06:22:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1048"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790886173;
	cv=none; b=H/jcX41wNml5wcKFpx9Hb7jfKFgd2WkMDwHGARq6Bd7n9VIp2Asgm7gnIhrmDDoxpix6dewjZzciT93sA7lCVecgaa1x7Ny/FRaXyFZf0G28WslrgKHUuVYvpbmavmo6oxqfjTPb0oLUpDVHM/d4N+GAMW8n8ZigedmfQIi8KX2XEdrlG/hv8mFhSsA/IAZzUNPqvLWqKGuema9gwwsnNJvnFD/NXViV5iwwGTOu6id3Bcd8A2NDBzk0HMpMxF8YLmziEtSik3Axp4eerytGL0nzsF/erN/LxNNqfJNqzRrSpyMvM6glgr55kGNFirsaaCA7+ab1GMM8Iws4PlPK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790886173; c=relaxed/relaxed;
	bh=y0J6VXN5lFwBxZJKWuWa6CerLz6QV8Oo4iFC23tHaiM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WEp3thsGQEr+NZLKUGqHIBkJkCeCmiY8qpl7VmLSA7HI5SKIeEUMNSJZcWHaadZqCq9zyNfzUBTnoQCqJHd+gn/AFD2C1M8DoJEPSBNhkR1uy9Y8Q8SuC3VKRGKMcdGyYegr7CqmTeJT93FgFg0rLrs4Rncqn5GRtU1/jFNxA0d4l0SQPZ7EZ+XTCmRDv5FEWOBgxUshzrkN+3aGHQUWF9XGJUv5HSC/ay4/HztYIlroky+sd/98unofPo/516+Zws+zdx8jx7xk4xHZ+7x401fbKh87xJJBcu7XnrIOkfjCRZ/s88kIQ6bGz3+QN7P5V0m9mpDxX5jbnwYApLImcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lk64agQH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3gsg-agykdpmnzviexbjjbgz.xjhgdipskkx-yzqgdnon.jugvwn.jmb@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lk64agQH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3gsg-agykdpmnzviexbjjbgz.xjhgdipskkx-yzqgdnon.jugvwn.jmb@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com [IPv6:2607:f8b0:4864:20::1048])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwjyh4bQTz3bw9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 06:22:52 +1000 (AEST)
Received: by mail-pj1-x1048.google.com with SMTP id 98e67ed59e1d1-39512608fb1so10904643a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 13:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886171; x=1791490971; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y0J6VXN5lFwBxZJKWuWa6CerLz6QV8Oo4iFC23tHaiM=;
        b=lk64agQHW09emH7gBgTcerCE1vNRQGD490HiiDXzKLB2veoiXHHYrXis2E1a8i1TkR
         WllZT3UMYPACproPXxqcbTkmXr62YOxVWmrxuKVbUmR0y0K2Su7VGrx01YFqo29CSpOU
         rzAhTxi0lw/cgXgpIrUJp2tvfG9KPmruxrTO5cXBRGGUpnkYSkDxvH/IEBB1RWEosiNc
         VMmBtATXUYjbe8KXlrlRUubhylZozSt9xoWTxp3Q5FlxekN7IDzar0xG/fF0mJtsclCm
         XeaK32BuqTnfVWmgMa1XVz3MkqKIxcrpyqMyOkzu9LSANegj2vLE/YyDQrUtFAtdV8aX
         QZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886171; x=1791490971;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y0J6VXN5lFwBxZJKWuWa6CerLz6QV8Oo4iFC23tHaiM=;
        b=Qx2RrB4mQdJal69mxXftquchjExvw3t/mhF3EF8LTUapIbUKNtjwl4djbqRgiWhzBu
         qwduJTroa/6NRfbpEQmUGW1Merdzx8eRNEEwXz23fLedJhXMHHlgrtqvKFWNZWyn+ggO
         dPeIs+Na/boyVcXelEDkyyGLWXoXVtXrdDtJz9oogLemHi98kWO2oo7rT7vyX6DmPda0
         v9/ezDa1L3fZxtT9G4Yvmo/ZuMiPUyuVMD+JhbN9P5zgxz3Fc2PDN2+VH2iL06smls8o
         LMcCuZTeSMF2AsLYT612dssoGn1Z4ZxxfZEv2sYuJzqmpN1u5Z09UIMZh6MX5b8Yqir9
         qkag==
X-Forwarded-Encrypted: i=1; AKwUvBzOmKP1QIFjRdMnjT62Hn2OQvJ0r8TEg63NN0mIDxtfBKP8n9nsIWXB6Q26NsRcl3Q+s41TxZR+HGL6ZmI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLRf4DIpI75sEQVMHVMeMq0vzOfpH0o+RNcP24KIe08pxTxaA9M
	pS/JSBPEOJ30uFttUxd2hyo8Al7NqAfF5notK1y38+e5V40P4+VvYBcBjqxUzoA4xCS2C4D0vCY
	mpiiS3g==
X-Received: from pjye1.prod.google.com ([2002:a17:90a:ee01:b0:3a4:fd38:2765])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e4f:b0:3a0:e163:fbba
 with SMTP id 98e67ed59e1d1-3a6ce9ae034mr628788a91.16.1790886170475; Thu, 01
 Oct 2026 13:22:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:31 -0700
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
Message-ID: <20261001202234.3794060-8-seanjc@google.com>
Subject: [PATCH v2 07/10] KVM: WARN and reject guest-based uaccess if VM is dying
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN and reject user accesses to guest memory if the associated VM is dying
even if the current address space happens to be the correct address space.
Accessing guest memory after the last reference to the VM has been put may
be "fine" from a safety perspective, but it's still a KVM bug.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2a88e4ce145e..0ee81754d730 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1352,7 +1352,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 
 static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *kvm)
 {
-	return !WARN_ON_ONCE(current->mm != kvm->mm);
+	return !WARN_ON_ONCE(current->mm != kvm->mm ||
+			     !refcount_read(&kvm->users_count));
 }
 
 #define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)				\
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


