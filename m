Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4B606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QbrYBrYm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jD4qv5pGGz2yKn;
	Tue, 27 Oct 2026 07:25:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::92b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793046315;
	cv=pass; b=UJQRwPspEYH5H/yBJalplJl54OHff6yG/W/CmuW2fSpXb0Yd/qM1WnKPppEZOeeFSqx/8Q4guDVulvSEUwkY25aM0at8rn4GvtqQ5eubKlD+Ls6Ba1VUsEM68mBcwqBzO1YJgv93OaSrpS7/UELtV/26RLF4/JWB3jG5cRVo8SD9hHSEwDKnOmvYwU3Tucn3hNyn0asvKWhNiobmlCoZNKJFqDvUsTDIa77ZiI74cQN7P2DgoyhsO4lWUHMcDC7CgTPKnYTGbktgpoyqesERRMUt0kdqf53HHe5zEGn8oTCG6Ai+V++ji0yfWqp60K/1Oz0o8I+ESKnEPN+buhcliA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793046315; c=relaxed/relaxed;
	bh=pU0NwAlmN/1H5GxbKnpqpM7HbDpz94JrESY0WvDe6G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7rsiXQ27jBQr1BKZVDb8l7wvxG6iefo6mqI5xwsy2/PrKS9+oSFLPxt0aM8tJvtNemAfr2kV2SRT7OWMHGt26W+HBH6nxkDN++uIaBogUcfbLwrJTNqlYMke1GO1b0ZJh4Vsi1JyOlUCobaYvOspvVcVWw5okeX5M0uGaB8yZ3Qa8BwFbZOXIHSMUbjxCnbFS6MsW87XAQfn4VHEEqK5zbFadoQ3ucIJfe+3Sm2nQdXb79sH2/aa2DGtqt2arGaI9yqBykzS19zVkYLofeGY4HfnAXZzaP0/4chU0OtuyjfXHmzSOX5gbzI4ThuldZwCzJ3mQeREzVd+3tEp93Prw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QbrYBrYm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::92b; helo=mail-ua1-x92b.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QbrYBrYm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::92b; helo=mail-ua1-x92b.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jD4qt4hMMz2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 07:25:13 +1100 (AEDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-9905e692905so331511241.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 13:25:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793046311; cv=none;
        d=google.com; s=arc-20260327;
        b=TOJhfaeWmm/mdmR8jAZUTb7vFCmo05m+jIU1ert2fGuJJ7HBTtXeVULsUbIewbvV35
         iihSoYrg4aKinveAeKN7/uA3zy7Mz+TiWeyvY8fAFBRbQ1ArFnNiAinivtVdBmPUl67w
         LzSNLSPwNx+FQqC/iuulV+43miuKIMG+7k7K4rZU7SyYLu1jAXxQOz6DxOtlCzkkZLcQ
         zwMoySXj9PI4u4clMub6yQR0RZQ9/RLdNgO9JM92l2bxPh5UVvTY/m54+zPRUSgVdkGh
         4umpM3YqAZDfR+xW71ofFF+BzEZCwt91HZ0ervBCU8x0N8hDgOB8UUbmSGBpYGQ8EPq5
         +wvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pU0NwAlmN/1H5GxbKnpqpM7HbDpz94JrESY0WvDe6G0=;
        fh=HlzRrvBEc9zCXjaVgEMNeEH3Lcdj/tvh70UdKBIc8Ls=;
        b=gzQGWFKFxAp4Aqj/U7p2hGhqWNkqrhR2mn6K1v6A6qZiA17RG1rzqqkzXdO0Y7DEhW
         LNj5AzFapaDOqdZUZhw2JQiDoJlZc8LCJq5gRjq2lKq6/l8r8JVMbue3GURMgISB9loe
         Yj93576ugIJ41FOTgFX48c3he+WBXCnB02AeH6ocpU27zxZudZWUTjZqvMiruJGYswqA
         z7Gi6jvOAEAdexCFi80MhcVvBXUxrteZfcz0pD5kJr/zPwNJNyZaZdk95A1LTn92TiXu
         sPeDEmP3389fv33FhFmlmgXdiXbkQx5kMGp46PUJos+ORU/Ged2NdVU7o3UaDM1VAFQf
         31qQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793046311; x=1793651111; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pU0NwAlmN/1H5GxbKnpqpM7HbDpz94JrESY0WvDe6G0=;
        b=QbrYBrYmVOMWSLUEgv/L1fpfQ8y5Oe6YIKam7zYyqgHUEBpdkZAMZCFk7ngmWJgrXf
         pyvl4vGP76RD5HFwcvaY2scsot9YoX8L+Z9GAn2ZjLWejnH1d1qhqh47cifm2zeJmcNy
         66DnH04yYNlpyOUGPUDmXJTQQwBqaY+jzL3eP7QhOuGuQJ8ZuvI/iTzpGXAQwp0wBxK+
         MUwyfEjsYhKvBHEIMsQckBpu2T7/xy3tBQVZ1iJY+lzjG4Yvt26vGVWR7fntrKvno0lj
         K7FdWCJAraqt3vvvvNyvg0IlXUDQaez4U/l0d4VaOc5Y8B32zz+ZvDmgWOb/uDP3ZOcA
         Yi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793046311; x=1793651111;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pU0NwAlmN/1H5GxbKnpqpM7HbDpz94JrESY0WvDe6G0=;
        b=Moh4b+cSdykHVLcoG5PP6X9GyfADTsyc8e0gxNeQBsGl/dq6OPTwZNGL3vkUbh8UV0
         f72VpL++13YxIW6CZOFmpuaEJ5Kr/ewLejCbxHtU6CG3nAj/LE3cfXrP7/cpIT9oTK5B
         Lpvf5eAqifiZO05esg++7VH1a1Vx65V6yYCTQbZ5U7AGAe6H620L9dVW0MnxVKfgfH2F
         a8w9doGo2iZKB6yXPmUD6GUhClbzTNhNT/ysHHO+v8Ur4zXVwcTSr8ZZjlYPeVXvfUSK
         PShLVVEsN+in5Ag2dxuBsiJntZWK3c2kV5eFvAy4AiedahatgRNIlOyVrdkAsDLF9m6R
         /vvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzb7/4txCiP+mylPIGf7C9Mrs1Cn6f3Pokc5DPz6w2bk43P57ZV6gwyz/mCyxvntYRMi2SH7Kdpnxq5yVg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIVwLyncB0IdrpE+BzPWfx+G/lqGayg4cvS6Xfa01mWBktRxOVk
	SruWTLHoJmXWVoBZA78/jLCSl3s4QBH3g9OhbYKTKMU8Uzj4+3GO6yakPV8UA1U7XHlpxruHZqD
	WwSWrRizWtvfUcIHOZ7rJZ9pOH9/dJGY=
X-Gm-Gg: AYBFou1wHhfWMViVeKgEUjAS7Jbgzu6s8j645Q+Fe3EdNcuU0srNYtkzJwv3Iu0zUZ+
	1Z225O4e8gY9asX3aYHC1zr2XKV9hxM4/isZij34xEJwKUpih/6uV13Kfw1SoNm4hfR75gfKTX/
	ZGaMrIJh6VL2b/LbzQ3NOCNeExVY7/wjI8ErKVoNMZtReCEE2kQj4BbInBMDhM2Hd8IQ3be68SP
	lhm1M8cCGaK3ci+GgQQNJRJCic+N+f2RtP58fye9J8RTMJ7l0XN+TiyZgy9PI2Jed99efM8Ct43
	HVHy6t7MxjryVIYvxuimvNii/Hd1JbRO6EPGpZa5XsoFpetHWSmsKt0M3AB69Fug8ia9IEx7C3f
	UU1UBjK0P+s5uPX336e7eiaPv+c58aUx23rXOAeqP2KfqH4oa8cgllZCp3rYd2clAC1y0z0tbaz
	dOskC+r5+wE34X740GjTWCUmxVCqSFBoe/8BNuG4w8w7KtRoKbJuUu8qpVhdFDO1LplL/6UrFbH
	R/tXtgIO5H+Lq/8OCHKyYRmnNKcIQ==
X-Received: by 2002:a05:6102:83cb:b0:7c1:6de4:9f67 with SMTP id
 ada2fe7eead31-7ce5ca62390mr2075068137.2.1793046310592; Mon, 26 Oct 2026
 13:25:10 -0700 (PDT)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
 <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk> <at4bw-G8czG-G7Wl@ashevche-desk.local>
 <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
 <at5qKehogAjTa-fA@ashevche-desk.local> <CADvTj4qSgE6Rc--mWuqAcc8HTqN9EFOS_JM8Hp8e_=ka_ZLa6w@mail.gmail.com>
 <at8eDFj2WNaXDaot@ashevche-desk.local> <CADvTj4oNz-bnSZP+kfau-7wBSWLjLTP5jrr6nLfdCHNPo3pS6w@mail.gmail.com>
 <at-vyZ1sDhYPu0W5@ashevche-desk.local> <CADvTj4o_CENc3i92OQEZudOErSKPUptT4t2CCqDaGbseuK0QcQ@mail.gmail.com>
 <2026102631-stove-preview-b534@gregkh>
In-Reply-To: <2026102631-stove-preview-b534@gregkh>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 14:24:58 -0600
X-Gm-Features: AclHuK-jg_V963WeCj8dDZYyLMETxUQLvBlHikJJBrwQZYN579iKyQfuGLYZuh0
Message-ID: <CADvTj4pCnnzx4B28H_1BuY4gm2fh_8HYL9jLpsAoJcWfiUXOHw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Jiri Slaby <jirislaby@kernel.org>, 
	Raul E Rangel <rrangel@chromium.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Tony Lindgren <tony@atomide.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 2:17=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Oct 26, 2026 at 01:59:06PM -0600, James Hilliard wrote:
> > On Mon, Oct 26, 2026 at 1:53=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Mon, Oct 26, 2026 at 10:45:54AM -0600, James Hilliard wrote:
> > > > On Mon, Oct 26, 2026 at 3:33=E2=80=AFAM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Sun, Oct 25, 2026 at 04:11:08PM -0600, James Hilliard wrote:
> > > > > > On Sun, Oct 25, 2026 at 2:44=E2=80=AFPM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard wrot=
e:
> > >
> > > ...
> > >
> > > > > > > Some people might want to test the stuff. And sending too oft=
en you actually
> > > > > > > will get the opposite results, people will be tired to even s=
tart reviewing
> > > > > > > and/or testing your code as it's changed way too quickly.
> > > > > >
> > > > > > My thought process was that people wouldn't want to be testing =
code that
> > > > > > had known bugs flagged in Sashiko reviews.
> > > > >
> > > > > Sashiko reviews are not visible in my or any other mailbox. To se=
e them I have
> > > > > to go to some URL and so on, meaning to waste time to see why on =
the earth the
> > > > > new version has been sent.
> > > >
> > > > Maybe the Sashiko reviews are getting caught in spam filtering or s=
omething?
> > > > They are showing up for me and on the mailing list[0] so I'm a bit =
confused why
> > > > you aren't seeing them. You shouldn't have to go to the web interfa=
ce[1] to look
> > > > up the reviews.
> > > >
> > > > [0] https://lore.kernel.org/all/sashiko-outbox-183574@kernel.org/
> > > >
> > > > [1] https://sashiko.dev/
> > > >
> > > > > It's better before addressing Sashiko comments,
> > > > > reply to all people involved and to Sashiko's original email, so =
it will be
> > > > > visible in the previous version why you issued (actually about to=
 issue) the
> > > > > next version.
> > > >
> > > > Hmm, maybe it makes sense to enable recipients in the reply_to conf=
ig[2]?
> > >
> > > It's up to the list owners / subsystem maintainers.
> > >
> > > > [2] https://github.com/sashiko-dev/sashiko/blob/v.0.6.3/projects/li=
nux/mailing_lists.toml#L290
> > > >
> > > > > And before even issuing it, wait for a while, people might
> > > > > disagree with Sashiko judgement or your replies on how to address=
 that.
> > > >
> > > > I was assuming everyone was seeing the Sashiko reviews getting post=
ed to
> > > > the mailing list already. The are ending up in lore so unless someo=
ne isn't
> > > > subscribed to the list I'm not sure why they wouldn't be seeing tho=
se reviews
> > > > already.
> > >
> > > I assume you already answered your Q. mailing list in this sense does=
n't mean
> > > recipients. I think it simply goes to the mailing list without forwar=
ding.
> >
> > Do we want those reviews going to recipients as well as the mailing lis=
t?
>
> For serial patches, we decided to only have it go to the submitter and
> the list.

When it goes to the list is it supposed to go to list subscribers as
well or only
to lore?

>
> thanks,
>
> greg k-h

