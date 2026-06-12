Return-Path: <linuxppc-dev+bounces-22596-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98A3CD98CF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 21:42:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcY0H39l5z2ykX;
	Sat, 13 Jun 2026 07:42:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::62b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781300575;
	cv=pass; b=oWfUpd1bPKVYsj87DWau4QCpDGbV59x+96efwZW9tOA1OJK7uP7ouDt7HPoI79H1mZuDgDoOIHgGxewYY4nYeBCsa1mbHrrHwF/Yoi6XY0T/aFZqRBf+AhyVVYRCpsmpesiPT0a6AOTsWVrCYa83p6g6ExCoVljcCJLZFUyp53f1Nk9YOxxsgTIWrv1//hz+OIB4Hywdf2S1tMzAunuC3b8G7fZBVN3NgbZDPFLfiL5onLEWez8gKNLlTwJUrtPJC6vTv1VGaIpdmdK0cHRQPgDNQkJvEmsS9SFuO+a+XeuP+ykk920DYTxv+2LhcU/J5gGubzZn0cY7qAwH5Dbm+A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781300575; c=relaxed/relaxed;
	bh=1vJ1NEAP1pi8XKUKeidNyFAtITrieBzkmoPXCAEf4CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKxZHA6WrKIHcbLedE+Kky7s3XxYr839LHrh33uNIKSfPrnbs7BGYs0MXMKdzWEGVzLQKmebxkphnNbwKTzkisasmC34NI+DJ2sadijjNlV6UHnrV+H9Lt5gVmzvk3PHC+6lEm7033eUfsWRr+8ooAupyGzn3ueTOwkbyen0eognV4Dcd8qxsQnAgkCK7kkm9R8+xs6Cqnmu8oj1csJ7FCv6zaRmRDgLoAucQBPYdzvwP0/D5NDVo4Z6pjxiFz9tOONakHzNJyPuYRvwAePacecslVoKJCQInOoK3NAQXj21IwV2AmC9zIk23BDgPJAeLDhnzI6dvYiuWKjlyR99Aw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kKR6B4MP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kKR6B4MP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcY0F3qX0z2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 07:42:53 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2bf1cda2b17so11567505ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 14:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781300570; cv=none;
        d=google.com; s=arc-20240605;
        b=UXsHeGEAmnP3d0zWYaQnRdqBKDPAyBhjzSwLwDXcJTgcxGkCxYmTIV9HnUPAR+dYi2
         LAHeLE9BEhVY8B3z+z1mb+w5E6jsyLF1NYhDYv8s8tNXzTIMa+0KVlosAu3A0PFCBVFh
         qdQWDNH3vhaMwKdCWD9lrUJjysqSUROFm0MkSeXSj4Ens1GyWGFsgMQ6Igrjg7nvDw/3
         Q3s+i6aO29L2lACOfMlAecuBzouyLoOT9znh2hiDV96OZ7eIrHMC9hzfoZPgjxS+P9ud
         1lqQWmnMWzbKUrF/WqojlkQJPS1k2CHtIwqm2DHikjeVA9JdyTrNzhRnYKegNxfF1lmW
         BDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1vJ1NEAP1pi8XKUKeidNyFAtITrieBzkmoPXCAEf4CA=;
        fh=20iLxpyyvfyribeaLgvgljq6ojNUrlNrrE6/ocWtrLs=;
        b=YSmdtasd4lXP9/mlwbNNEjXoemsC3uHf6/Ea+E8DOndJADo0V553FbTQw6/iwtB0wZ
         f0gEEXycOxLk6w+bnIZxFQAGklv0C9QRpzBfo8doKKPqJlbgg/RnGC4S6v5b/hFhsyOn
         y5leE3E7DhFVdmSeWA9CM9Zps3wEAXHLuSq3Dal8aX1Ufne7IzbUt/K5dlMyTj+kIkZZ
         eD+4PSJJKApf7uLkA1WrRmH0pigj1VnAqk811+zxHEn8RZBEOix8slMOE3vRnbkbFfi4
         hG0jkjWJFpYXgikdDw81NwQ2di1L+wy/v2WQukdKboQkqYMPDXvs/4RUcxjSpT5WK/NZ
         GhJA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781300570; x=1781905370; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1vJ1NEAP1pi8XKUKeidNyFAtITrieBzkmoPXCAEf4CA=;
        b=kKR6B4MPbgFSB0Y7NL6r6kYdkuvU7MlhudC44wH5JgJWaRp8uPix1DISgDxPNl1ECr
         FiT/+V7WSraFhS53s+XBzCa9u0sJng4lNtmg7a5OUM/u/jCQO8u5gUxW9XT/0O0TlP43
         tbsavKPC6vzvj/psZhjIj7rpwfUUbsPILcB5v6eVoNJTJQvGBDRSGe2Mwo34Ul4Qpxj1
         1Wj2JYRrCJrSjhPbzce97ZEOKqQlo0TS9DCepjugxZB2LUGSBoekwmwSWqQqw9qG0xDV
         XAAjEx/XXZw0hNmkAHxa+39KaictAemOdGK3stV10gDuiD5ELb71vO2NM7b1HbqT+ZIc
         9sDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781300570; x=1781905370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vJ1NEAP1pi8XKUKeidNyFAtITrieBzkmoPXCAEf4CA=;
        b=BVMDaqlbyunySroGU+m/m18YK6Gs2McN1Xkr8xHBpmx9oeXc9PkCVRl3E974xb1r98
         off5WLZP/TR76gFlTQNq/eBHTH/OK79ZL14o28h4VJqzUWe5ct7Btv6vfQy1iELS91Ip
         poPjSK2nbkfx5t3/6WDH7fxdVpMFD5wYI7+WQzs+kGlsZoF9XotcctuLI/izDMoU8VIB
         NN+12HoJZBtUb58FQgNt9IXTMOcZUuD0+MwJLQwnmyH0lJKJ+USDFk5bAmVNAPjetKYx
         roQ7KdKnelszh8b5Guu7fEaeyzJBEJwHX3onhTkARFaGePfvq3ZXCDjy2Qmvh63kYQqC
         tobQ==
X-Forwarded-Encrypted: i=1; AFNElJ93vIkpqie0lYDZlIDkpN5FOFgnCdU9dCj4kqtxuNjrDykxptPRHtmunzsp951Gg7Jp+jfi0sjKlkvuAIA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwH7FigWASivSCZGgXVLhvp3ohVlLrpziJ6bAERHFZis6PTh1IH
	W/CoKdwI9IG7P2hPWtRh12h8EdSV7Z/lF36qLqH6wtCq4BR3qtNj+BsnC1Wx0zT+vYlM+9hZiZ+
	u77ANfCZYhXjK82fG0+CgGqP5px6514A=
X-Gm-Gg: Acq92OEmjGy8rVtqbdLPmqJtyEwJ7h+InWlUbueO5WOPFz3Y+a99PA99PW6Dk8+0qM6
	iWOZZLFNlz7V2+2M0I+qpBGL+cG30dqfvghEkjZtRVew2trNrDOuAKnRWmOh2ecF+1fvQDAtQfg
	aJJ+iUemFX23lPxO/riPkyuRSgrA+rBDLAI3470YVX+ZP3s17iCYA8ZULUTVnUGkVHsXyqCa0TB
	z7GCWEpS0fQskjHIsz/7C73C3txNhNs53LLxDktIhmQNLo5dZh4FzYUGuMnvq+Rw3hme5753isS
	IiXNx0lGILfgah0DE5mjyQevfxrtM/FAS1gBEtB6qUd9d/tuTSc4icTxMWVyxgiUszVnHT2T
X-Received: by 2002:a17:903:2290:b0:2c1:88a1:9839 with SMTP id
 d9443c01a7336-2c3fb4ec546mr42132845ad.11.1781300570163; Fri, 12 Jun 2026
 14:42:50 -0700 (PDT)
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
MIME-Version: 1.0
References: <20260612132639.78086-1-phucduc.bui@gmail.com> <20260612132639.78086-12-phucduc.bui@gmail.com>
 <aiwgIjVqa4PeGjRQ@sirena.co.uk>
In-Reply-To: <aiwgIjVqa4PeGjRQ@sirena.co.uk>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Sat, 13 Jun 2026 04:42:38 +0700
X-Gm-Features: AVVi8CcQ5wnxCnP2P6gAEQ2cG8ISmqVV88AetkLUV34w5sJRMS1FX2oxjLgXEA0
Message-ID: <CAABR9nFAaLgjUURzJjuH+vHwkExK2sq7Nu2jKC1Ge5+gLxFfiA@mail.gmail.com>
Subject: Re: [PATCH 11/11] ASoC: fsl: mpc5200_psc_ac97: Use guard() for mutex locks
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Hi Mark,

Thank you for the review.

>
> > -     dev_dbg(psc_dma->dev, "cold reset\n");
> > +     scoped_guard(mutex_lock, &psc_dma->mutex) {
> > +             dev_dbg(psc_dma->dev, "cold reset\n");
>
> mutex_lock not mutex?

Sorry for this oversight.

As mentioned in the cover letter, all files were compile-tested except
mpc5200_dma and mpc5200_psc_ac97.
I'll take a closer look next week and send a v2.

Best regards,
Phuc

