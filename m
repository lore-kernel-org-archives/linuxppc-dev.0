Return-Path: <linuxppc-dev+bounces-25821-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B547C5CFDB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 09:54:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLLLH3xspz2ynH;
	Thu, 13 Aug 2026 19:54:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::548"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786614871;
	cv=none; b=ORLjdUzA8pVStD65f3v7hmdwleBL2W8yO8jJNFdNWJJ+LD94lYexh08uMniMyDT4k8/MuaFlDcav3UeVtdQK644XYgaYj1U0Q+Ybcac0eCOdAbOBA9QCCnKEYWcgWFJOGH4lW5vCMNwrtt7duUynIezA0QfsvUh4sN5Tg+8VNW1frqetK+54oj6IBzDZUGHpkz85B2keO5n/5XEyV5+pOdmA4FQsjkUsefgtc0hu31EDU3PwHnn49jegzWMX0wRtG9WgAVWcKLzkYar1EJEG5iP/qgSaubiYhcmk1HuNcFQpZkQ3/iVby3Q0rcC9JO/0gT7c6ZlzRRZnbYqSgN5z8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786614871; c=relaxed/relaxed;
	bh=c+Ghwm16zCb3XluSdXC+OMNEFWBin0x6u6wWkTNkW+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PJi7726CWTCBQCr5ijKRJ3ha9ttlAhzpjSliTQ5uW0m6L7PWLcnI0sXTLIzZh/1Qhy8wZsTL3utNLtvBCnNcZlSKAoWXG6vd5p1kQI8ywq5N7gtdWTWlxu2MmD7SWehHvF5zKluZY/t/KYydDKHL4rJ4URClY7w3VbAUO0X7oVdAiyzUNqrnRqX0ePz0FgaiFVqysjrOM1I3+ofZjI9um6fgZ5FABiEXi02OAtWKkPYDHEqtqmLK9XUm0RY3UvS8A5gKehHCvqYL7l1VJQFGZfkFPkJAYp8PpjEhy9L7vJighElgDDjSyKKws1wXgiUrd+RmYP9kMLmI4yLL65ItTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OjC2qptm; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::548; helo=mail-ed1-x548.google.com; envelope-from=3upr9agkkdmsar8b49rybx55x2v.t532z4be66t-uvc2z9a9.5g2rs9.58x@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OjC2qptm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::548; helo=mail-ed1-x548.google.com; envelope-from=3upr9agkkdmsar8b49rybx55x2v.t532z4be66t-uvc2z9a9.5g2rs9.58x@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x548.google.com (mail-ed1-x548.google.com [IPv6:2a00:1450:4864:20::548])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLLLG2j1cz2yfN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 19:54:30 +1000 (AEST)
Received: by mail-ed1-x548.google.com with SMTP id 4fb4d7f45d1cf-6983e9c028dso1396179a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 02:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786614867; x=1787219667; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+Ghwm16zCb3XluSdXC+OMNEFWBin0x6u6wWkTNkW+w=;
        b=OjC2qptmqsrsT1AP2OaEqBYJ9pOy3HrGnqxG3QcODsRQvTJsOSvEKvpbZJw25dHCBY
         rjTlRubS2Xkl+BZV9Sjdbs7mONtmGAoPMJDhTV8FygYzuFC+jRZk/yx0EGdg1QMHH0Jl
         6GiRUWp4h+vC/rp2DYiAbEkpNIIQCVVuZr2yKEh1udtkTtOF+S+w/qtfKKi7VoFqQ+CY
         zczSs6hUOKuSY3+MMwF1OegZ6p4Suq3+jmByUeSzjDgQs5GY/fNPfkY9k4X/R7uf/S4e
         XhVJiYyudVSautoNwOrM7/Dc5GRGycGDfwyZYBpe8nqNPwqTh8ytPWrY6RnK2lAAk6B9
         Q1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786614867; x=1787219667;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+Ghwm16zCb3XluSdXC+OMNEFWBin0x6u6wWkTNkW+w=;
        b=DmuiMxQwJGDJ4kiTDUiDBIj4m/qRhhZc3dB+waLbPigfQW2f4+xeFtBAvMTOBBSu57
         kmvuDMsrKvGDPKdxOK5RmgNajXRE8Tbdr/3NoDODGa6qSqv2WP0zcfA9SA0zyiKxpChB
         VvNP1kLRfX2kpaq1N0uwr99YUwec4lZEqPfmA3R6KyuiUPBKVlOptjJ2fKwK61lFX2lq
         2t/pjcy4NhZk1Cy9sF824j7Y4zRwCZBfEG8gbM+mmboGTiz/ZXOmcYQXNvN0MXtbCB/G
         /+9RtMezKUjOeGRgDUm56VuFgbPbumbfYQGgfT9/TVV0yiPa5GVcKFeOl01RGfD4l+1p
         gUzw==
X-Forwarded-Encrypted: i=1; AHgh+Rrea5xgn+AH7MFb9c7pdcrNyMdcicUKhJr2frthPgprdA3h8PYYo9VYso3wNtC/1mv1XcMhTd9VpmNWSto=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzJhusHXG0w7JEd8DMyd2Ki0wQs0fJr/DVFYyy0r/1NVXNV95AI
	GglO5IOTzKrbzZNJ/BqJzHVYA9/JheHXPxJ82HuN68uTWq3VpDGcRefIXy5zTMqeGgjo5HP8dlN
	cPRZ42Sa/DxE2lX3QFQ==
X-Received: from edqz25.prod.google.com ([2002:aa7:d419:0:b0:6a0:51ba:9873])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1948:b0:6a0:a4be:6ed0 with SMTP id 4fb4d7f45d1cf-6a380618f4emr2015007a12.17.1786614866346;
 Thu, 13 Aug 2026 02:54:26 -0700 (PDT)
Date: Thu, 13 Aug 2026 09:54:20 +0000
In-Reply-To: <20260813095421.1700945-1-tarunsahu@google.com>
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
References: <20260813095421.1700945-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260813095421.1700945-3-tarunsahu@google.com>
Subject: [PATCH v2 2/3] firmware/edd: use kobject_put() on edd_device_register()
 failure
From: Tarun Sahu <tarunsahu@google.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Russell King <linux@armlinux.org.uk>, Geoff Levand <geoff@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, djeffery@redhat.com, 
	Nicholas Piggin <npiggin@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, dmatlack@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, souravsgl@google.com, skhawaja@google.com, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

When edd_device_register() fails after initializing the kobject with
kobject_init_and_add(), calling kfree(edev) directly bypasses the
kobject release callback (edd_release) and leaks the allocated kobject
resources.

Fix this by replacing direct kfree(edev) with kobject_put(&edev->kobj) on
registration failure.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 drivers/firmware/edd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index f980c5b56858..763e7b16d517 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -748,7 +748,7 @@ edd_init(void)
 
 		rc = edd_device_register(edev, i);
 		if (rc) {
-			kfree(edev);
+			kobject_put(&edev->kobj);
 			goto out;
 		}
 		edd_devices[i] = edev;
-- 
2.55.0.699.gb54405d56f-goog


