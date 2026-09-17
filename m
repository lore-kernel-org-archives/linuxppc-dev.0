Return-Path: <linuxppc-dev+bounces-27633-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2DDC982D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 21:08:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm7dM1RJMz2xfB;
	Fri, 18 Sep 2026 07:08:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::547"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789679287;
	cv=none; b=kzWMnKX+f3wzY/R4bBB/P8jRvvaOa8PjEh6kpnnej9oqDUbrcEbadfp2GgRc+RSOFRSvh86UhK7D84EJGVVOuadp4F2vYhprqemKvBpgEqWBRg9g0LTnQLIvn7suIKDSWLoXD7TRXKk+/2ahKBD9YHXBOLoiOJLQa+Ni9I4tz/68gawUPQ8+uH3Rre344TJQI2agC4Wa0Dy+RUbFW2Gcgc/9oc9ZFwaDEquriyu6TUSgCxaLBlX1LABg8a0u73c30ey0Ec5SLR8lpCQFDHqrU3+goyDb3/9TMmmrk2fvNj0pFoouzfaSkiwrhy/Rnetb9PwqO10pIdFG4u4NJ6gBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789679287; c=relaxed/relaxed;
	bh=GZplDPDarrgfYfltWJB0WdogIU9Jf5wB1DpwTrdaw1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hjt3KsngmlVW50ES6C5Uf2gq21oRri2P2PCbHJqjrAOtmo3DNeVeSiUQmOypYkmHNLFUFUZW2411mfLdhi2xKaI/ymoI3Y3Zjaxfj3RRi5t7Y4Yt07JKTaj3/yncdmOvxwgaNt89kJMWGY61kdfyozWDmV9yc1wUtNwKzLCNfUA/PzYTYFpc8qdDw47sWn7BVqFgdCdgvlZn2tzcvnfrrFtn/dlFi6de4+Vlfl+gpGdvQDH8cijMtnH/+aLuKYrdT1RmqtmHj6yp4EfDypdBj69lFTzqheMFBw40LjDrFVByEhXg17ZGYkU+d77PZ33KTyDz6qu8CGCGpAf8OoeDPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=J9KjgLRW; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::547; helo=mail-ed1-x547.google.com; envelope-from=3sfasagkkdgscjadwbjqdpxxpun.lxvurwdgyyl-mneurbcb.xiujkb.xap@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=J9KjgLRW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::547; helo=mail-ed1-x547.google.com; envelope-from=3sfasagkkdgscjadwbjqdpxxpun.lxvurwdgyyl-mneurbcb.xiujkb.xap@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x547.google.com (mail-ed1-x547.google.com [IPv6:2a00:1450:4864:20::547])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm7dK3617z2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 07:08:05 +1000 (AEST)
Received: by mail-ed1-x547.google.com with SMTP id 4fb4d7f45d1cf-6a178080182so60079a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 14:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789679280; x=1790284080; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GZplDPDarrgfYfltWJB0WdogIU9Jf5wB1DpwTrdaw1c=;
        b=J9KjgLRWfys1U1uzzSwaor5G22IGXjhzolD+ZzvR2MdFb4Q6mhMG7Ehngr4cyyMf+8
         vydpoz82ViVmHvj+rOIAejT8kIpb3Fxt1jSY3OEZX2veJ866QBl4omCtEgpbqA7zY8bn
         SZFvga8KXtOwsjaF8CQwQi5ah4/4E+Y4xVxlF88ZkdJA2uoxL2cjcOJpYk4VzBkdQVsO
         c4wpgF9r75wlGRAOFIy4+ox6sZh2wSMtdV6Byy5avIJzvY4csREHTGxR4GWPiPPyzYG+
         BDDVKJcA/Kvyw0vqILb2b9UBBhm95ndB0pUaJugXyCb9sjazeoITu4k3MclxyiI0pPbh
         5pUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789679280; x=1790284080;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GZplDPDarrgfYfltWJB0WdogIU9Jf5wB1DpwTrdaw1c=;
        b=2VVe77ivqL5hcBTGv9eWiW8XpTlupYvTcA2T7kTqo0bC3cO4btmi2NztUSJlF2l7AA
         vR6hmnvSXOLskeMc7TI7qEiZbXNCTugLMOk2+aDD/EOeep/3ceekB7uhzbbJFMAOhAHm
         uhf9jR2ew7DhYaUTTG8g9+CvYmcnhrOkbpxWx+XhdJyIcSxLyqWd42w3nHga/l9fkHnz
         lXVAakM5gtt1odeyC0kVf63bNP43e0RXyj2dMBVoyxLU8t7B359SfenBgOOjdh07Atc5
         8gCU1BrfC4p21rtkqnCM9qmkndRC+lBoFke1hYWLaymk/m6vrlKopsNdsLytemgY/C1S
         sVcA==
X-Gm-Message-State: AFuF++lnWZJHN53Of01moOhdOTx/mOvm/aIc4Fh9A8aId8vp3b41dEM4
	CZvGqbqFbtUfOWydwSqZK356EgrJJdY1ziVRbEg9x52cJiuiS1q3XmuBz10JsbCG95NLofB6wUD
	o3VJWN4lCbeH55/TKcQ==
X-Received: from edbdc23.prod.google.com ([2002:a05:6402:3117:b0:6a3:65f2:cb6])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:c111:b0:c26:1691:b368 with SMTP id a640c23a62f3a-c2a157fab8amr38402066b.33.1789679280144;
 Thu, 17 Sep 2026 14:08:00 -0700 (PDT)
Date: Thu, 17 Sep 2026 21:07:59 +0000
In-Reply-To: <20260904171610.3342398-1-tarunsahu@google.com>
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
References: <20260904171610.3342398-1-tarunsahu@google.com>
Message-ID: <9huzse37io28.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 0/3] Convert manual kfree(dev) to put_device()
From: tarunsahu@google.com
To: Russell King <linux@armlinux.org.uk>, Geoff Levand <geoff@infradead.org>, 
	Masakazu Mokuno <mokuno@sm.sony.co.jp>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Paul Mackerras <paulus@ozlabs.org>, helgaas@kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	sourabhjain@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"


Hello, This is the gentle remind for picking up this series.

Please, let me know if it needs any improvements.

~Tarun

Tarun Sahu <tarunsahu@google.com> writes:

> Hello,
>
> As per the kernel-doc guidelines, Devices that are tried to register
> with device_register or to add using device_add, must use put_device
> on their failure path (not kfree). This series contains 3 patches
> for updating such instances. Same for kobject_init_and_add or
> kobject_add, call kobject_put instead of kfree in case of error.
>
> V4 <- V3
> 1. Added Fixes tags
> 2. update commit msg as per the suggestion on v3
>
> V3 <- V2
> 1. Updated the commit msg of each patch to mention about the kernel-doc
>    guidelines.
>
> V2 <- V1
> 1. Removed patch [1] as it is part of another series [2] already.
>
> [1]: https://lore.kernel.org/all/20260810162814.1398016-4-tarunsahu@google.com/
> [2]: https://lore.kernel.org/all/20260724171945.2812749-5-shubhrajyoti.datta@amd.com/
>
> Tarun Sahu (3):
>   ARM: locomo: Fix device reference leak on registration failure
>   firmware: edd: Fix kobject reference leak on registration failure
>   powerpc/ps3: use put_device() on device_register() failure in
>     ps3_system_bus_device_register
>
>  arch/arm/common/locomo.c                 | 13 ++--
>  arch/powerpc/platforms/ps3/device-init.c | 83 ++++++++++++++----------
>  arch/powerpc/platforms/ps3/system-bus.c  |  2 +
>  drivers/firmware/edd.c                   |  2 +-
>  4 files changed, 59 insertions(+), 41 deletions(-)
>
>
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> -- 
> 2.55.0.979.g7e5102b832-goog

