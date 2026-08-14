Return-Path: <linuxppc-dev+bounces-25878-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C0BC5CFCF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 21:01:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hMF513yzqz2yrw;
	Sat, 15 Aug 2026 07:01:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::647"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786741269;
	cv=none; b=mvcPyTXZnk6opwkwSUY6P5rI29x+dAcuO82BcEn70Fb312lpIbfkb5LMBIWpodyUpc2rfOdarzgGfKuAOVxCn/U14Eupj3C6hoXM34vOOg1IP6TzjxgLL9aoutjXsWK1lFkDd0E9hGalMdP7OrbybwhFjZelEmnezvxVBuqZm2fzo0gJ8oLU/xU1cv30T0NbGXpUNDphmdct7f/UfJCoEfvKfQg5PPDwk7S3UxqRx5ZiKkrn3uB3BRnPDEL4IlFWQriEa4iOropmjiw1zOJKCziwFlVPlrQQQUKDREf7bQJRN1i0umDW1lnl74veveI5DhlXZAYlQA35R5Ng7PIuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786741269; c=relaxed/relaxed;
	bh=CpRLa2s9CCSXq/nY6RLLua2/DfHcY8vtQRcWiuG8yfo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=la4tLvXR6iJyaDYHAUKDHbNANExqaaJmXAr3bxkSevRYZYU2YrYnnneXwbdvLJ4a2yUv0Det8URlrhPbjm2tzd5uTXzstS01sBhw2gcQzYtOZMuqSHvy03XbRvY7jdEQl9TyCTR2MvkrxudDK0phbxDg0MQSt0IS242FMeg6SKoGh5n1H5AOflatb0uj+5dkITZjOkN3PUkoLAwCqnqyvdu47llRD+tz62rmUlF3Mla+p1WoaUTcAft7JxvrdCV1CoJfClI/P06B14Kbwj6WtEeWC1zN5Fe0TUf8Ap2czxe24WgfHvhsmQ+twksS5XVhCPu/M2w9XB8wTxQrLTR+fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tFVAEIYD; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::647; helo=mail-ej1-x647.google.com; envelope-from=3c4j_agkkdggzgxatygnamuumrk.iusrotadvvi-jkbroyzy.ufrghy.uxm@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tFVAEIYD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::647; helo=mail-ej1-x647.google.com; envelope-from=3c4j_agkkdggzgxatygnamuumrk.iusrotadvvi-jkbroyzy.ufrghy.uxm@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x647.google.com (mail-ej1-x647.google.com [IPv6:2a00:1450:4864:20::647])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMF504XYlz2yjs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 07:01:08 +1000 (AEST)
Received: by mail-ej1-x647.google.com with SMTP id a640c23a62f3a-c15cec1ccb6so98952466b.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 14:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786741260; x=1787346060; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CpRLa2s9CCSXq/nY6RLLua2/DfHcY8vtQRcWiuG8yfo=;
        b=tFVAEIYD0nQZjmmcCWA7oY2oSfzqogqVqlaHH6H62QWQmHyr4tHofOLS4eQm5eZanr
         2ho14AC2LNdAD0Y7rvSwet6AWvks9qfFCYZCeDMadRA/DnKX81wjg9leSnvqFqE043dW
         4ZCmh06tp7ek8C9AnWK6cxUNDJeShgl/6zio9NK1QxUdCUVgDevxrNvLAuhbUJV5xzxz
         Cil5WaTr1foAJxJk6V7BUK+HTCUBStprBlHbEAOtO3oM8RCo818V/CzvnC89HOPZPhrQ
         //kK7+sx4XzgPzaqz1HZgLZEOyGD2sxUg9xH1DiGROP1m1Er8GnSb9xDfDXg2DWlSwtF
         jVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786741260; x=1787346060;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CpRLa2s9CCSXq/nY6RLLua2/DfHcY8vtQRcWiuG8yfo=;
        b=JQl4AFnBr/OQaCTgkeng2X9sQU/4o/NEWiSPI6ZDc6NkfBnu9zv49n9TcWUdxtCYf2
         LiwtrWocAqakaj1zwSE7JnHRXlIVke4jz1l9WXQVc+F+qny5Dk6xAoby5QEfvoxIelga
         IqoGDvvB2Ksclc2AqyeShxyWsoFodMQeGexp+1q7rGZMB7RnBFhtLyFwOo6pDwBy3QGN
         QCRNLPXcCwyO/n91hwpv9neUumGNa74sBTjDp+zTHwepuTWQfmrXqPllG1JPGT1/rn+Z
         0x6ijmoYoCEmJkb0QIJd7/fXafEAmUV9qLKrcCd18B8OEQlUu2CVCHurHJtw9y+n3L1U
         filg==
X-Forwarded-Encrypted: i=1; AHgh+RoLTs2E9AYEPYxZZDvxw3Ix6XarTRs/BbFmA6T2Vmu/ZMV7vbTZVYJMi9LSUjCNVBJtEb5hM9373gNtfDo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyYqABNpPPtgeARqq3jd3WhxaXFxmNwZIvF2VbNb1td2goVnfv8
	AtFmJR+tSm/Kfjqb2ZLibXlxQI2HiaBaIfsU6UjFO0YcXJ/8eJ8zt528TZIcyaiZafUGc5EzivQ
	dWb0BlmUd/PtW3CT6xw==
X-Received: from ejzu7.prod.google.com ([2002:a17:906:c407:b0:c1f:4de4:c4c7])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:960b:b0:c1c:28e5:652e with SMTP id a640c23a62f3a-c212a228bbfmr401758866b.25.1786741259490;
 Fri, 14 Aug 2026 14:00:59 -0700 (PDT)
Date: Fri, 14 Aug 2026 21:00:54 +0000
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
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814210057.4102768-1-tarunsahu@google.com>
Subject: [PATCH v3 0/3] Convert manual kfree(dev) to put_device()
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

Hello,

As per the kernel-doc guidelines, Devices that are tried to register
with device_register or to add using device_add, must use put_device
on their failure path (not kfree). This series contains 3 patches
for updating such instances. Same for kobject_init_and_add or
kobject_add, call kobject_put instead of kfree in case of error.

V3<-V1
1. Updated the commit msg of each patch to mention about the kernel-doc
   guidelines.

V2 <- V1
1. Removed patch [1] as it is part of another series [2] already.

[1]: https://lore.kernel.org/all/20260810162814.1398016-4-tarunsahu@google.com/
[2]: https://lore.kernel.org/all/20260724171945.2812749-5-shubhrajyoti.datta@amd.com/

Tarun Sahu (3):
  ARM: locomo: use put_device() on device_register() failure
  firmware/edd: use kobject_put() on edd_device_register() failure
  powerpc/ps3: use put_device() on device_register() failure in
    ps3_system_bus_device_register

 arch/arm/common/locomo.c                 | 13 ++--
 arch/powerpc/platforms/ps3/device-init.c | 83 ++++++++++++++----------
 arch/powerpc/platforms/ps3/system-bus.c  |  2 +
 drivers/firmware/edd.c                   |  2 +-
 4 files changed, 59 insertions(+), 41 deletions(-)


base-commit: ddca0cd800962b4121e5f2633005167bb6216175
-- 
2.55.0.691.gc56d675ccc-goog


