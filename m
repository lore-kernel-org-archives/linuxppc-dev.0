Return-Path: <linuxppc-dev+bounces-21865-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02D6CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 09:26:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV57f2nvwz2yb9;
	Tue, 02 Jun 2026 19:26:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780392414;
	cv=none; b=PiJ5Ba0x3+tHIIRRhPV5HbIUoSd5RNuD6u/t/IOXEMoLjUj05PBvjZmmFMwdTmExbaZrjw2U9fa92m+rh4b4mTXJViG/yW5Z6ds7Rbhf66FsCdJB74NvLUyiO0YrgDxNdWc+hc8XLqt2wVkimqiCkjz8YHFlsB2jXicYiQwmNw/K27V2P/lSIrEZl6xXISeD6dpOdicqHhdSOKHeajXA7S+X5qlaR4ZA9q78LHLQuOZtggNTg5nDHjHo5otEDhF+FlXR11Dgfm828Fzm2+gF7I9Y7FwWxfdL//KufluevLzm0u+cvALqSF4UyQDUXFHwll9CFVepcVF0Bx4b3ZJVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780392414; c=relaxed/relaxed;
	bh=Md4hiUePTg+5wfFpWCPNi1KpT4E53tO51pMj7M2RLpo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=bOWDz+B1EXX1qJVZfqm2rJkZQeiZgi9vJ9tbq8BtwbIwIK/VwkEsbXTfELpUM73tnk8NYW21WezFVc0gNKzTeXy8rZkymwAgLVpEzqrvcUBev4pI7PXiUmvWFTuQtcGV/v6TiD9PDEpsJBWNZlm7tTZWRvRji2dvBoVeewRYsT66rQZpGz1IL0r4axApEkLiiyYW1FszYK9yg3YWS/E60qZuzBTqRxwnoFqRixZQCTV35WTN2CUfkExVA7T4fxRzqQjdTOqs8Sr9KlHBF4fqIshYnfT1ioyknlkpIaHBYMCyTs+geaDyemfLrutVcN8+zqO0cp3pBmWVNuIckCmEsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MuOY2IV9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MuOY2IV9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV57d0MJJz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 19:26:51 +1000 (AEST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-516d15ed2bcso101966261cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 02:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780392408; x=1780997208; darn=lists.ozlabs.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md4hiUePTg+5wfFpWCPNi1KpT4E53tO51pMj7M2RLpo=;
        b=MuOY2IV9HuqP0OtpCFg2R2RZ/rz1z9drs3FXO7ZdJzg9RPY9MYISujSL517nBOJBtC
         we34bDju/HjujFW/FNoeAMBN0BpRpou34MS8oF289vIH3KKkUV5zxpOS9bp9GZbGNyNW
         3gB9t4Wzj6ZWUXZ4sbLZe77ecKyHJPOigChpiLxKJAdJHVofAncUe9CktdASP1VwRc15
         jDmPPiU9gGKd0CPGTcqcRrf1f5lj5O0hzj1x9hINz0T7fwQrvbRA4uXNGHafY86CPh6+
         jvFDCltAhbYhMAp+MBrUBxfGer3ultiembAXKlwU7NpZ0O7D5bCF5R4OsiDEeo+2ELVK
         gTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392408; x=1780997208;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Md4hiUePTg+5wfFpWCPNi1KpT4E53tO51pMj7M2RLpo=;
        b=Mi5Br/9px67IJ9MyBiM9VLkM5I5ob50gGVxmkFcQRxW2e5js2bAaAps86vh+zeCJWk
         v/GF4k22cSkuPzbPUUO4iGn+2BNfFbGMzQaTEMvmYaRCARqdlorGMWkTLcsxz8nXB8o/
         x8V2lbM/2mUhxsOh+xXS7aCGyz0NS4QqAVMZJdq3ITLORefCPME970BS78JH5fC1tj57
         viRImG4b9NP2j1PpjzVf1fvRKx8bFw7kPHhMulcmJivaJ+xPy72y5Ga2rbt+BjggP3rQ
         MzcxiPo/TDHoakyw7l3OlpRllpQaywG/MfFAyAm2+DZvuNkXL9RXPclD867CaYHbIewl
         BQow==
X-Forwarded-Encrypted: i=1; AFNElJ+bteFMIYm2S5UG9f0dNunUeUW/Z9a7bvMxJpOrYvoGaUirjLUCJZfHF2CCIsAKryOoXVsgFIxsVHAuFa4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxRd/aPhlHyTaGrX0ZbIRjKKy3ZUpx6qxeYrSpI5cAeZ657kP3F
	N3nfyDNB9c4FZWSF4JdtMUCTdiFem//lbzg9gk/bx9YQerZdMM5YiW3P
X-Gm-Gg: Acq92OEzSn3VSlFlN7pfT9IZJNeSpMnWZ2dbiw3sCXq+Ah7qwwkrb3pWly8KoY2pkUh
	JF6V7IuFQR1IoCVZv/niqqF0nq0u4cBTn2lGx4G+wvKaUcvBL2OL8KjmzhD0bAQC1q/Hq/Sy81m
	19cvTsBj2rfKZcrKs4tdrV5+9/HVK7F+KMtY6Xx/mXOMapMTk7aA833gIjVwRNEGJ59WRb3rbRj
	D7A1ET8rv3xtBP+1L9HNdI4YNOU1ST6v+K8KWVdhrBHENqL+QHR8SjRtzHoC9wOM4X5Tslupvxz
	rmjgkF1WPnIjPdhwl4prZFG4HR+iPQ9eBPb/aiZScbXS5xl5UZfgD8zchSbbdkOiJkYv93pDs7o
	b4SVBuG9EXJlfAgccfahHJzlJU+urEN4v7OJU/ThObu+whzZrUnRwnn3C53yxOzR+5cqwIuMJT5
	vwgs0YFaICTBoQ4n/L+WyjlV/nnlKOpkblTu6MF30v3/j7t+C4M7RoiQfNfBEA7grMQsIcdJEEI
	F6+IQPJ26WVu6zs6L6esNDgjk5GqEiCsT2A9V0zON4ODtm4Uyo=
X-Received: by 2002:a05:622a:1812:b0:50f:c9a2:1643 with SMTP id d75a77b69052e-517662835efmr36605851cf.11.1780392408389;
        Tue, 02 Jun 2026 02:26:48 -0700 (PDT)
Received: from localhost ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5176e062a2esm6993281cf.7.2026.06.02.02.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 02:26:47 -0700 (PDT)
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jun 2026 02:26:44 -0700
Message-Id: <DIYGFNLIFBW7.21W9J6SUGYF72@gmail.com>
To: "Bartosz Golaszewski" <brgl@kernel.org>, "Rosen Penev"
 <rosenp@gmail.com>
Cc: "Madhavan Srinivasan" <maddy@linux.ibm.com>, <chleroy@kernel.org>,
 "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas Piggin"
 <npiggin@gmail.com>, "Linus Walleij" <linusw@kernel.org>, "open list:LINUX
 FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, "open
 list" <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 5/7] gpio: ppc44x: Convert GPIO to generic MMIO
From: "Rosen Penev" <rosenp@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260602050131.856789-1-rosenp@gmail.com>
 <20260602050131.856789-6-rosenp@gmail.com>
 <CAMRc=Me0rqs8nxrp95X-2Bjw059ahRxwKrg-NtmEt025w2m9bw@mail.gmail.com>
In-Reply-To: <CAMRc=Me0rqs8nxrp95X-2Bjw059ahRxwKrg-NtmEt025w2m9bw@mail.gmail.com>

On Tue Jun 2, 2026 at 12:51 AM PDT, Bartosz Golaszewski wrote:
> On Tue, 2 Jun 2026 07:01:29 +0200, Rosen Penev <rosenp@gmail.com> said:
>> Use gpio_generic_chip_init() to set up the PPC44x GPIO chip
>> instead of open-coding the basic get, set, locking and state handling.
>>
>> Keep the PPC44x-specific direction callbacks because they still need to
>> program ODR and the OSR/TSR registers around the generic data and
>> direction registers.
>>
>> Assisted-by: Codex:GPT-5.5
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> ---
>
> ...
>
>> @@ -124,10 +102,11 @@ static int
>>  ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>>  {
>>  	struct ppc4xx_gpio_chip *chip =3D gpiochip_get_data(gc);
>> +	struct gpio_generic_chip *gen_gc =3D &chip->chip;
>>  	struct ppc4xx_gpio __iomem *regs =3D chip->regs;
>>  	unsigned long flags;
>>
>> -	spin_lock_irqsave(&chip->lock, flags);
>> +	gpio_generic_chip_lock_irqsave(gen_gc, flags);
>
> If you're already doing it, can you use lock guards too?
Sure. btw, I avoided placing

https://lore.kernel.org/all/20260517063754.21819-1-rosenp@gmail.com/

in the beginning of the series. My thinking is that's for older kernels.
I believe either the generic API or devm_gpiochip_add_data fixes this.
>
> Bart


