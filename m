Return-Path: <linuxppc-dev+bounces-25039-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7184C53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 18:32:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9LY82mClz2xwP;
	Thu, 30 Jul 2026 04:32:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::529" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785349964;
	cv=pass; b=WoExWKMYwO6HQXsG+VHklOkJPhxHwj/VCUTSRH3SkOLOcFR0i6XfZmDK2d8cy9qCGyS/srNAZSy0wQt0b+gSNBUDaMbQyF2GQxFTBM9W1fiN4CrXYzBtf15XyQATFTCsRnydK+XFN1RmIpLqE+HuMin9SjOZgFR6c2ehbnZ5WdV7v1KevcZsBkK5rzyUIWrXD/L6jQSLwC1oDUHmbSAtZlwq3lYh73uusM8j4QWP5VWlvYqKMs2/tLDA9WR7qXP/iSWDZSzZWLNu2HtyAC0wQSnrpvppE2f4xv6FPAJqnQ4ucwYVjL4mQHoGM8/sCI6xHjXHhVPcMmM9z8Y9Eid5yg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785349964; c=relaxed/relaxed;
	bh=OWuhUqUKl2tQgwy7xscpevse6bZZgTd2BD+KKHLHGXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2ABUXgbrFQlxwwr2wpVaHcDDFi3Hj9jEYQ/cV8YPXv1igckHNSXAEPkt4O3sUltE6+BrN82VdYOpjjGLGdFLaVGTO9w1F+++RX5AfqTmQDtTxVfEgLAoykU1HTjXNGXFLh6bgbhudxNfNbQJJRW1KEE4qqwhQbo+Ft2iF68EIA2VQBwuU8RQDl9x8Y7iN/gj9u6735VDra7NO2f81R+50rCe55XeJ6txC4AUstVor3opve9WjaHsZvm/HIgaLTy3/GU4pyYD0XdI59jQLr3ZiZ+SP+tpKOPXRfSYGpjW+NFfgssp3AQa6x/PnzSl9xv/LQQ1/rtgrDzn4VcG5nJZg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ktLp+9WP; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ktLp+9WP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9LY73Z8mz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 04:32:43 +1000 (AEST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so1926551a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 11:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785349960; cv=none;
        d=google.com; s=arc-20260327;
        b=fcVd7vQpaws3HWbP25bdKuaH3f+qA+gofMkX1E92M/cDdeD3tSJsUYDVRIpAalZUGk
         X60tO2nxLMGPWZTIfmyvIAyyN3lhYeA0TbvY3HCLTzP6AcPDjelIgN9Zq3M1+Nu0RVxl
         V6MMGlaoz+SLfLJtUA5j89Xm29oZl843z2tp6YhMZval90p7SHr1TD6tClPtCX7NNmUr
         MfNa1EXnkVVHPlXNHapmBfzsmCHi352m/lITm/ph3lFSFNfpYzUf8l00f3dzdM2NxNB0
         Z4Kv4++AoxdHtmnR5vKtoYh/++q9UbpjrZdWQv1dXC0zGYBll7l76SYB7huu51T9UULP
         kYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OWuhUqUKl2tQgwy7xscpevse6bZZgTd2BD+KKHLHGXc=;
        fh=arkJ5+MY+Hjz+zosQtJvmIvJJovIWE1+4YQjHzQu918=;
        b=CkSS9kq+wVueqnMBFlvNYOktIBOc0YNdB8OC6cFjJ0wDuBjKYvz4xutDtMT6M869GN
         3Yqguav5m/inm3utAj6CCHWRcP0q5LSp4lWY9y3Iq8WujGTbnWH19E2TOGqsXd69cxsF
         JujfIcOcXl8hBMOTK57rqtXhGADyDmqHwQFsnCFnbHSXzpZ76iWBs1Rc+xJWIWWZM4KZ
         m82/htSzeq9Nh3W0qevLQehoQW256Sny1QcGB4scXKNCnCcRwGRNoi5t3ihF7h8BTmRF
         7fZedHFfJIZfFM0bUAxtX/rX3mGw9WMuAD9XLqAGTUyjc6VrJadNR0OG8cmGDRfKLieT
         SPkw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785349960; x=1785954760; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OWuhUqUKl2tQgwy7xscpevse6bZZgTd2BD+KKHLHGXc=;
        b=ktLp+9WPvDZO5dRV9CL6e/EyFsGeJNHcMErQvKNRr0Lqd2K23c4Z/uUHTkVbdI4zS6
         wFDBFLBIg93dPHffLmbA0/0YvMY92xZgnbuiMg7/vzPQvYXDFpv0XK45uDAlfqyWUZ2y
         v2aP4ggNbBMLTOmD5wPYU3U6WENYcXE7hQ5Srgi+m7G0QXi3H/9PQa9f68xhLkbschAP
         oHgJLsJA3Np1hUSpX9DpUXMbXX8R3EQuGENyA4sV/qwbNokOJhnD5EN/ZcFJNDYNtmpt
         4tj6cLx6JHR7xEmGmdbkYsbCVquyf5gr1jZ/4bTV0mS1LNkR77dJ2lo/kIuHauxLtcYw
         Z2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785349960; x=1785954760;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWuhUqUKl2tQgwy7xscpevse6bZZgTd2BD+KKHLHGXc=;
        b=YfBfe37Cwje/wbyPIXs2WsREkLGZJez7NJ5Xp2Fp+YZIlKLWI5PJIQJXMfpX5BGjXn
         3Fycm3o4cKz3ZQI3AB8qQ3IZ0YLlk5IPUEjujhPFRBieOWpFhm6uPmu+K0XnJsiQOMmo
         hEVoVp0nMBqc6JwD4NQXD8jgvHtp4crHapCNHdAPmYJR8luX084TkQqZBCq/TDmBZP02
         nlBgXTdEkdkPAKwHoOPQLY2m0Zb5kGMDAYn6VLTvKmZ0LWS85Orf100gCcDCC+snceZ2
         KQPNodXnH5eheUob8BvvhD4ELYGVpJnEObw05eaWStRs/0HrqkuPf0mPaKb1puQc3nCz
         omhg==
X-Forwarded-Encrypted: i=1; AHgh+RrIDCaAVFf+/FQflO8NRlv7jkxPuDx3QLSWP2oYvALyo5pbvSuWor2Dq0IIpltnPySpd7MfGQ4mwmxAVaU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YypsMcCfEmdKM3uT02aH9ghSl9y3iUJLR0XjVBeR7kCpwX9Z+JH
	gazQMJXkFqY0LWpfJur9yQqw5nVSlS9ECrR8Hxp3ZQC2SN2MW3R6idhsyKIPoXY3B9K6Bk2TnDi
	Cw0CDsMZBDGqtMxe03+2WozgRHoG21Ns=
X-Gm-Gg: AR+sD11COc966iq+63KKKqZ/BREhV6hZN6M+wnl/0pLqBcIbPq8ATM7epHHHsZn/eHM
	+F1zcg404ecGONurhCaZyQDaSxLDYOoSBLRwtNYN7u6TsL/68RAfvLPoiv8ZLloKQpnERyvXPq6
	ZSw9anDYFuYBEbDOsJ/qv3mL+1yrcK1lSs6FRVnBiijaDBhzG5lpPXaNee8Wj5fB4hYtaSJqdug
	b+5CJE6f+yfg0C+56n+K4hM9vH/k2zndRK5Ff7dk+4tVIuXxFnuFVWsnMmRrw75mvzCMnjx2fbi
	oLjaDjSg/TcTOtc6BVnoNBDiE2WHwN+W70/WnX+TUjDAN+pcaN7I0TheMcttTYkrFglBhV9ao8i
	+WlvXTsIgcIOOXlrweV187iBfUhTSXrGR/i8ayQ/7hLUKIRq2MzwT93CqgPe/OsOpQ3LFUMlOiq
	a+O1tXWbpjlI76anB9Bbl0+HHpbMPTvvQ/sNFHW0kkvuKpGGaaCOmmxuQ=
X-Received: by 2002:a05:6402:194e:b0:691:7054:8c6b with SMTP id
 4fb4d7f45d1cf-6a034a9e9demr4048551a12.19.1785349959966; Wed, 29 Jul 2026
 11:32:39 -0700 (PDT)
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
References: <20260602050131.856789-1-rosenp@gmail.com> <20260602050131.856789-6-rosenp@gmail.com>
 <CAMRc=Me0rqs8nxrp95X-2Bjw059ahRxwKrg-NtmEt025w2m9bw@mail.gmail.com>
 <DIYGFNLIFBW7.21W9J6SUGYF72@gmail.com> <7ee42722-f7f9-40cc-a576-5f85e3955537@linux.ibm.com>
In-Reply-To: <7ee42722-f7f9-40cc-a576-5f85e3955537@linux.ibm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 29 Jul 2026 11:32:28 -0700
X-Gm-Features: AUfX_mwFm41Bflu7ob8t5htCSDpQ6an6HN0IUWP3VvCWL4feJWz2EPy32kLLAAQ
Message-ID: <CAKxU2N8n4iHrr-+NxL6D9WZ4EgH_XVJ7yfPa4P6ZyFNJTir60w@mail.gmail.com>
Subject: Re: [PATCH 5/7] gpio: ppc44x: Convert GPIO to generic MMIO
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, chleroy@kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Linus Walleij <linusw@kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 3:55=E2=80=AFAM Madhavan Srinivasan <maddy@linux.ib=
m.com> wrote:
>
>
> On 6/2/26 2:56 PM, Rosen Penev wrote:
> > On Tue Jun 2, 2026 at 12:51 AM PDT, Bartosz Golaszewski wrote:
> >> On Tue, 2 Jun 2026 07:01:29 +0200, Rosen Penev <rosenp@gmail.com> said=
:
> >>> Use gpio_generic_chip_init() to set up the PPC44x GPIO chip
> >>> instead of open-coding the basic get, set, locking and state handling=
.
> >>>
> >>> Keep the PPC44x-specific direction callbacks because they still need =
to
> >>> program ODR and the OSR/TSR registers around the generic data and
> >>> direction registers.
> >>>
> >>> Assisted-by: Codex:GPT-5.5
> >>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >>> ---
> >> ...
> >>
> >>> @@ -124,10 +102,11 @@ static int
> >>>   ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int va=
l)
> >>>   {
> >>>     struct ppc4xx_gpio_chip *chip =3D gpiochip_get_data(gc);
> >>> +   struct gpio_generic_chip *gen_gc =3D &chip->chip;
> >>>     struct ppc4xx_gpio __iomem *regs =3D chip->regs;
> >>>     unsigned long flags;
> >>>
> >>> -   spin_lock_irqsave(&chip->lock, flags);
> >>> +   gpio_generic_chip_lock_irqsave(gen_gc, flags);
> >> If you're already doing it, can you use lock guards too?
> > Sure. btw, I avoided placing
>
> Do you have plan to address this comment in v2
Yeah I have it fixed locally.

I'm not sure if this has to do through the PPC or GPIO tree.
>
> Maddy
> >
> > https://lore.kernel.org/all/20260517063754.21819-1-rosenp@gmail.com/
> >
> > in the beginning of the series. My thinking is that's for older kernels=
.
> > I believe either the generic API or devm_gpiochip_add_data fixes this.
> >> Bart
> >

