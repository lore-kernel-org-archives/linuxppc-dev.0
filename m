Return-Path: <linuxppc-dev+bounces-25697-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942ACC5AD55
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 22:37:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJqPt6RmLz2ynf;
	Tue, 11 Aug 2026 08:37:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::547"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786379698;
	cv=none; b=ZnK80pPx5GtvkOU+9NzQVacwpYJvPo2LgUPjtg0Y9siaeUgOzuekKVvyIXzscK1ioRR4r3K9CojYQub9eftXWMxBv07vZnkb+8S55xe3eZWi3xtrGsLshjzbIzXnTy8dCqYmV5xNy6cmDDngb0MxeQPh4+5BAbYvIkePuQ34WHnF9bietP4Wlc8e5AviMVeYEmTIXoiSEiljjt6/z1ErIEOWR3DVfLVvmQ7h3wgfHSE4qVYoj9OO3wicBDqT0+A3r18IZUtn6xE4jpw59Z+0iPUi3chIVJIndOUswJxNyEBHtF3nK9AedP4A+7FcK3/FYaumHyEAhpJV9hsELvt1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786379698; c=relaxed/relaxed;
	bh=M1E8OcPKQa3EfyTN7DtxgAyhHDdwMTH4+JtgNWA55MM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=osTdGNS4ScZw+3VfL0GDxdznezM9rcWA41A785j5WblJ3vCrHO2OOJ3s2I4lqzVXvz3gbWPQuZZj9UZNTWJv8Qk+91RV5m8jBQQBfNF0ABHxe94+zIqQ+kVUGmiDFPPGianVUB9gMXCRiN5jmVc8jCJdLN058N7pf7Lq03WLY8LpFRcDfMM9DyLAFXugaQqXJnPEHD1H2rFlVG9wPSYPL0nvTVY/3kZ7WDKbDKCmEIq5gCOULLswYQDR4sk58URN1mD3TG42l0Cv6X8n2Fp4S/1AzTu+uuTcTch3jB6xW2gwk2iT1R6aT9PFs0ZrifozERdu4ehmhRHizLyU2iCV/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=daujc7O1; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::547; helo=mail-ed1-x547.google.com; envelope-from=3q_15agkkdogdkbexckreqyyqvo.mywvsxehzzm-nofvscdc.yjvklc.ybq@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=daujc7O1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::547; helo=mail-ed1-x547.google.com; envelope-from=3q_15agkkdogdkbexckreqyyqvo.mywvsxehzzm-nofvscdc.yjvklc.ybq@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x547.google.com (mail-ed1-x547.google.com [IPv6:2a00:1450:4864:20::547])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJgMh6T1Wz2yxN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 02:34:56 +1000 (AEST)
Received: by mail-ed1-x547.google.com with SMTP id 4fb4d7f45d1cf-6a14f110515so1988492a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 09:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786379692; x=1786984492; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M1E8OcPKQa3EfyTN7DtxgAyhHDdwMTH4+JtgNWA55MM=;
        b=daujc7O1nwJ3ogH1ovCQ4J7NlyGLTFuhKawZ6K9THtlguooz3wmR/F3z5w2Sz1nwXp
         rGiQQ6bP5N81Unvmvud45lROBjhnnxGJlNHk6cLSl2AA1B9mPX3yU0aKAnPJN0lNCPeO
         Gjg95adPVxZGPgv1nIxguVh/bzzy4/Ndz9DMh3gSz3JwrdjnGM8NN4nnXZUng04lVCO5
         7RtTziAZ1g6XyzuQeOzPLqRjip38rg/W8nvwBY9zKqbztESCHGN67twYdjvRSDkjEw8S
         C5D8cDnx/EaYXgj8xCU2zOpv7IyIvMmU8FkkSp41gx4l0pM+8Nb6sKez9pTnXjEb2tRb
         IT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786379692; x=1786984492;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M1E8OcPKQa3EfyTN7DtxgAyhHDdwMTH4+JtgNWA55MM=;
        b=DVy7h6gZx3TW6fJlqdo6lH/j4Z5xzXehcosdpYWbyGd5M6jz+c7FiWTK9AtgL6vrPS
         kyMT4CYJmIXdurZcmkuG7Vffe/67/zu2FLhQvuoJfih/euDPJ9AXSS0QN7uwGSQyvjSR
         c9Au4l1kjHF9qcOtb7Y1JN0sEIIJvFuvakAFeEW6TlXNtciay2mGYma/cYrj26rCKy7X
         beejS06xG/MrmVziJQgRQsq0BhdbFLaqPywOT8TjS+iZdALzgjjNFr/Mfel22RhZwi1m
         MN2YAwiyqowaqUxpWeCFUKF4to3MlQfegMX3ON/KqU+Jy4MXDFZt2aO6wkHc9HSEGayz
         iqbg==
X-Gm-Message-State: AOJu0YxN0/L7XDP8uMhkfmIiNBVY6NeHvUYu8Gx2TsLE/ZMDNgfO2Cb5
	WW/+wbMXiFRinQRDKUozMEEj+E98RLEeRBa3chvtKJpEmmg6bNgTd8SnQHmyr/kZbsmpyVIX7Ji
	ABOaFS/RCtuJx8vTMag==
X-Received: from edzh5.prod.google.com ([2002:a05:6402:945:b0:6a1:c0a:e022])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2110:b0:698:6620:d988 with SMTP id 4fb4d7f45d1cf-6a355e1332amr1811578a12.15.1786379691640;
 Mon, 10 Aug 2026 09:34:51 -0700 (PDT)
Date: Mon, 10 Aug 2026 16:28:11 +0000
In-Reply-To: <20260810162814.1398016-1-tarunsahu@google.com>
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
References: <20260810162814.1398016-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810162814.1398016-2-tarunsahu@google.com>
Subject: [PATCH 1/4] ARM: locomo: use put_device() on device_register() failure
From: Tarun Sahu <tarunsahu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geoff Levand <geoff@infradead.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, dmatlack@google.com, Borislav Petkov <bp@alien8.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, djeffery@redhat.com, 
	Tony Luck <tony.luck@intel.com>, skhawaja@google.com, 
	Russell King <linux@armlinux.org.uk>, stuart.w.hayes@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-edac@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

When device_register() fails, calling kfree(dev) directly bypasses the
device_release() callback (locomo_dev_release) and leaks internal driver
core structures allocated during device initialization.

Fix this by replacing direct kfree(dev) with put_device(&dev->dev) when
device_register() returns an error, ensuring proper refcount decrement
and cleanup via locomo_dev_release().

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
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
2.55.0.679.g6767b8d81c-goog


