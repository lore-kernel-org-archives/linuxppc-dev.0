Return-Path: <linuxppc-dev+bounces-25879-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F92C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 21:01:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hMF524SjKz302T;
	Sat, 15 Aug 2026 07:01:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::646"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786741270;
	cv=none; b=gBjiPPnVmkEPdFDnd4Shz76HHb9NtzvqVXFmMyax9tR0e3LTs5aXx6Vw4ugE8bHpcryNg6bXLavTtPxWO3PIOuX3HojArPxABnCOZo4BWkb9m9xGUzI0tRgQ3mXJ6rxqqvQ6Z3PQJRzOrLJl593ZqSotPQaRrfsBW11LvJ2bn7XXeVcQEzV/VZDdqukDhKiAhNYvffo20Qdi5z71XhfOUghNnEDv2qkDG+w538vPundkQcWDq6/0+sTcoWCwwU2KwPxO9Z0VxDziU+JKKjS6lTKDuRn+dDxZz6+Ej9IaIsR45RXh7rrYJM+o0QPcioUFdTAhfOvidJ8ibpg6b8p1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786741270; c=relaxed/relaxed;
	bh=DYuMpnr3KSC7nQvSYxrDe2V0WmDtuzggqBjS2om2eUA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U4Vwi4olwfjvAXecYx46vixoYy9pRUSj3IXjZZcO220txhhNDr0O87+gcXPhMVfxmFJBIxIUzguBdmA34iIL9qWiKnVkTdtMSDjx8Wj4yI41SemoPwWhEIQXjnoC7eFaGS49RIpZ/rYevAMYY/UluVXQPOeGK6qb22BfYtmCl8kj4ND4B+lj+6KwhPWQfgc5+mCkQmtCH4sjUEyKY7smPyRAfHxQWQ6NccWYR7Dex9AUJ+Zss5Ew7mhcCXYWcbulC7F3k47ZS/WkYO4U2DO/ZUht3dbzS+XAC0KCj8PbniAVnMwfceIiSBEggH11X0JLbd0nFoZsz2DC4B2Rem+5uQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GMZv4BeX; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::646; helo=mail-ej1-x646.google.com; envelope-from=3dij_agkkdgkahybuzhobnvvnsl.jvtspubewwj-klcspzaz.vgshiz.vyn@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GMZv4BeX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::646; helo=mail-ej1-x646.google.com; envelope-from=3dij_agkkdgkahybuzhobnvvnsl.jvtspubewwj-klcspzaz.vgshiz.vyn@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x646.google.com (mail-ej1-x646.google.com [IPv6:2a00:1450:4864:20::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMF513H5Nz2yrf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 07:01:09 +1000 (AEST)
Received: by mail-ej1-x646.google.com with SMTP id a640c23a62f3a-c1c232fa136so138294366b.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 14:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786741261; x=1787346061; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DYuMpnr3KSC7nQvSYxrDe2V0WmDtuzggqBjS2om2eUA=;
        b=GMZv4BeXvKxeOd5ZemcViQEFh0MDIjCzcLox04Dw8p2wMgrsNApaM/AYpbShmr3xMQ
         Uh1LbPXFqhNiznjBVqwD7RVo71BlzucEjf6+i28MmdnCE1MRUYDe+mdLPx1/xx4l5Fta
         Mf9E6NNLPVLp6bfKCbe4Q7l1DsfYS++VklGJ2hjVUX8xAnR5dbhV/euz9wpQ3BXjMB2I
         h7+0XFenUELa++fb4/OKryLuwpuBs8nCzEdAlAk5oxmPW9FOt4+SKDTqxsgfmXSaRdEb
         iGgjBgPfxkBdC5oMmk4Yw15i0o6ElBcNPaluPKn2eS+RPe57z8Pe8TQMtKcNU4HL9DUS
         3BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786741261; x=1787346061;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DYuMpnr3KSC7nQvSYxrDe2V0WmDtuzggqBjS2om2eUA=;
        b=eco3eA4SXQtwZW1I3SKVZOiIc83l1/5X+Xld7mgwu93CLdaUO4Dfl6lxq9QJHlQdtP
         e6nL9mQYijZY6QqHhce9P0mMDT6vhv8nA0+6MqpnQBfU2dj00Ikg4Nu+KXcb+IPQg3lr
         NC5VUqKj3yupRjk1/x0qPeAV7x0CRjB0VKKmnBxTDnOtFrue5Hxmqqu3sSbKtOyTP8n/
         Ny062rq7BzBCcf8D7cnK02I7BC3T+5wy679B62WVf/uF1/IqggFbZwsF7uAyR4PW90B+
         8Nk73kVG+Tzb1anJ6P4adCuvPvu4lNXfN3A1prFZ0ch3flFTipv6X13Ims961SDKJhhC
         egfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3KEtp095DVLjN0Va3vp5Di/3o/aPyU5ci3UY0YqOBWzehwe0fnvlMk26035rvjDFzol0N6mg3zMczlmI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyT/yeZfIIbRN38rUS/B1qUYTgnlaG4nFf0auWOvbRmxflkYc5k
	DT5nrJ+OkImMj4e2+4oVUCp2X8xBTZxWruou7q3gkbpWCPGeXOzg2P0RIkWcSaTu/56lGC0m4YJ
	wMBgg7eiQ3gCrKgq3CQ==
X-Received: from edgd22-n1.prod.google.com ([2002:a05:6402:a516:10b0:6a0:d334:54e7])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:e15b:20b0:c21:3c4e:cb9d with SMTP id a640c23a62f3a-c213c4ecd42mr205334666b.14.1786741260571;
 Fri, 14 Aug 2026 14:01:00 -0700 (PDT)
Date: Fri, 14 Aug 2026 21:00:55 +0000
In-Reply-To: <20260814210057.4102768-1-tarunsahu@google.com>
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
References: <20260814210057.4102768-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814210057.4102768-2-tarunsahu@google.com>
Subject: [PATCH v3 1/3] ARM: locomo: use put_device() on device_register() failure
From: Tarun Sahu <tarunsahu@google.com>
To: helgaas@kernel.org, dmatlack@google.com, 
	Nicholas Piggin <npiggin@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	sourabhjain@linux.ibm.com, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Russell King <linux@armlinux.org.uk>, radheys@amd.com, 
	skhawaja@google.com, djeffery@redhat.com, Geoff Levand <geoff@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-arm-kernel@lists.infradead.org, souravsgl@google.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

As per device_register() function kernel documentation says "even
when device_register return error always use put_device() instead
of kfree()"

Fix such instance in locomo driver by replacing direct kfree(dev)
with put_device(&dev->dev) when device_register() returns an error.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/arm/common/locomo.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 55e360452828..0f6689d343b0 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -223,10 +223,8 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 	int ret;
 
 	dev = kzalloc_obj(struct locomo_dev);
-	if (!dev) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!dev)
+		return -ENOMEM;
 
 	/*
 	 * If the parent device has a DMA mask associated with it,
@@ -255,10 +253,11 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 
 	ret = device_register(&dev->dev);
 	if (ret) {
- out:
-		kfree(dev);
+		put_device(&dev->dev);
+		return ret;
 	}
-	return ret;
+
+	return 0;
 }
 
 #ifdef CONFIG_PM
-- 
2.55.0.691.gc56d675ccc-goog


