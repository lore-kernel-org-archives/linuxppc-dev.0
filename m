Return-Path: <linuxppc-dev+bounces-28689-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28A2CA5FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 20:23:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwjyd701Bz30Wh;
	Fri, 02 Oct 2026 06:22:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790886169;
	cv=none; b=dHihy1youTvQkz4UypKH1ODxecMty93cU35lgOMyMnlOgxpWTP97XYKnGtVL4HHtQwVJDj40xGkcout4QKZA493E3ZuKuU7VIDENST922gmxDtBWpNbtaootBGFTAPUqvSr+29abbaqtVcnMqdBUXlCKasII4TSwpx9wk1F8KMplAwRytGW8qnHmWj2/LOn1BGvf4QWKGhm5sb6GrwHioTtBLthadkbBwznhz8edNMx9Z9H5UQOlHWRPm/JhVuCqt9PHFQG+9VzQHiW+7++vlgT0LB8M6yvqXdwuVNYaJ8Q0S/Hdmh328YErI8PqJMXMFuhtDvp/d90rG3nVlDa3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790886169; c=relaxed/relaxed;
	bh=qdNDM6n2ZDbcN7ldHmyQd+gWcanpH4YXON8+JKW9Ils=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QDpk/NCAyF3u/g2dtsRr+//7kQbcvdgDWlXtNhBCjAVGpqFYkStUxFM+r7+1yFskLHOaguqyydWekWMAsqffQPXC06M6KwMNXgqAp5mOFh/XrpwhKyGxzMGIKAD7Y8RSvMOoskjsHHqKlNZBf1RUVeCIf4hKu7FNMnEYC9VeaXzy6KSMB4qJitN/jv+x6zeKQayfBdQTYhZPQecEdM5oRYiDERagwwKGQeFHRTeAC09+KQu77gEo2lkL6fsSUcI/Q6E9nc2U2Ke2Akhl/+gXX8BCuyUHMLVoI2zO4fZpNHWVA/JEpHN7lw81uDj3hwLDcu8/2QV/3NBO+NzFY40gyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=X7gNu3x2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3fsg-agykdo8jvreatxffxcv.tfdczeloggt-uvmczjkj.fqcrsj.fix@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=X7gNu3x2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3fsg-agykdo8jvreatxffxcv.tfdczeloggt-uvmczjkj.fqcrsj.fix@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com [IPv6:2607:f8b0:4864:20::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwjyd0PPrz30VT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 06:22:49 +1000 (AEST)
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2e2e0bc619fso21831705ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 13:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886167; x=1791490967; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qdNDM6n2ZDbcN7ldHmyQd+gWcanpH4YXON8+JKW9Ils=;
        b=X7gNu3x2AiK+lp1R4EIj+SCbY/njh8y+ztZM04r6kAXELKaeiVqnav7RfcH9fHGvTN
         /sABcZGh0NJQiNjL4hwz/bsOYJfy0J1Hfby2xJ1RMw6bNItJ5FPo+GttTSeMWafKP49S
         PY5meWO4odqUBwGf87CIIs/IttXD2NXmWGA8d/4VfRhCBAoC3UgRFeGMEwNFteckeZ1+
         U/ChEQJVVBVjXGMvmdEProv2Fvv83btpJxkbbuwSln1Cw1GPkWIqFoPMd+rmQqmjH33Y
         YATnUE39pquTlc8FnY9e92uJbd/NeXbm/qmEQQxbtVohBnN26Lp3sE1105olGyLE0QnM
         RzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886167; x=1791490967;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qdNDM6n2ZDbcN7ldHmyQd+gWcanpH4YXON8+JKW9Ils=;
        b=gJwADvfKwhQi1fAnUQ1LellVKubyoTl/yxsfeqcu3TceGhRIcDH2aJEY92l3VrK81e
         7/zwPyEBRgTwfnN+bdbq6NJhwF2hCOwY6UaksMTgsT/tjXxbN9ax+evDnsnQgiKAJzdW
         VxSgs8QAdLL3M/lZ3MgB7A+sWzBQZOFl79qORJGTaUQ+r9Rj1OYFciZZiUsgv2m4waTy
         h3KLg6Fc/OlRpIYlLgfxl7r/b11iexgSyRi0onMnyPfVtTq9mAAAlnpclUeQiVs3FJc2
         Y6lIg0IXpK2/Zw9/kcV8kHZyoBtNTIwbv1ej27haXrfz8qZEKtkauSSOWOmkbGzQWV1o
         5OXg==
X-Forwarded-Encrypted: i=1; AKwUvByeQ56130pk9fRPD3jSUoz0wzQOfUyCb68rxKix+upKtGy7FsInva55X4Gd+99szlHJ3lCAG30tjisvFQE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJk+V+bZDYp2KuAU0D95SHlUcRw9gcBjVLzt/tt74QOWbQfXtOv
	ZUOzNpPlkaN3P9+BBINtfw0/KLip2zS7ZxfaobGGCzqOWkZXc1kix1L99xISOrO+s3zKQeKQgxO
	bh9JZ0w==
X-Received: from plsc13.prod.google.com ([2002:a17:902:b68d:b0:2df:4aa4:16d0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec84:b0:2dd:c100:4259
 with SMTP id d9443c01a7336-2e49b6d1e0fmr4572245ad.61.1790886166440; Thu, 01
 Oct 2026 13:22:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:28 -0700
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
Message-ID: <20261001202234.3794060-5-seanjc@google.com>
Subject: [PATCH v2 04/10] KVM: Disallow setting memslots when the VM is being destroyed
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

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
index 9a24c3064896..f368240aa1cd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2015,6 +2015,9 @@ static int kvm_set_memory_region(struct kvm *kvm,
 
 	lockdep_assert_held(&kvm->slots_lock);
 
+	if (WARN_ON_ONCE(!refcount_read(&kvm->users_count)))
+		return -EIO;
+
 	r = check_memory_region_flags(kvm, mem);
 	if (r)
 		return r;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


