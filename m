Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C50606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QhuTZipz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jD4G30GH9z2yPR;
	Tue, 27 Oct 2026 06:59:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e2c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793044762;
	cv=pass; b=nqsbnoe9gputG5fXB2sLY4UWhHxJvcsvw6WeCyT9igHY/HVuBhnNPTTP4sXh21wuEdgB6XTYs2GPf7EbgeGBas6b1od/swE/Q5CLPcLGY6oSHtTIsjQBRfWvqfzDnPlK0dSuo2Nt5yMJiI37fLq5+K+eqd7WhbfmUzL6PrAAvlfgSJqVini0PXym/Y6psavPuU/Qtn8mAknvZOxTQZcYLpFMr9rxRmfsYQ+JbIvb3Dtd5wy3KAeYpLplXrQsU+/njJUJz1Nz7skX07IxQVzaAkSr01WhtipsLG5dzhZn4Zk/byWGbowV2tF8XGpBiph4aP89wFslSFN/SXAZqNQPGg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793044762; c=relaxed/relaxed;
	bh=5v98+mkBPyKcXGGfAa45H0MLFavlwhFEg5B6g7hFf9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwAeJKxQo3AuldVEfaIoPTY14g2nGsIke9R5N9h04Uqcucv3NWsJQl2eFnvJUtsh7MVsDqpCO8efwm1DquVO7rkKzDCPu6/JwkElpbU7MzMiJgPmvpdcUNpEH3aWl53K+nrTC2gElQi2I9efkjn8tUmItqvb3p/GQJ884Cf5E386kaIvNq1Czz0xBRfNJt9vKGOzb6GH9bNxVhGeMevmUEE/Hk67h9Kn84e58OKnnfRCEbbk9nrgA+pcIxkbvIxarNf+f5yQwh8ORru1D2DuLQDhWHlEWl/M+pnQhdvpWfnaQX/XlIz7K8q7Vfm8ZVBlqolz0pTJQpL8QMupXc6Cow==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QhuTZipz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e2c; helo=mail-vs1-xe2c.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QhuTZipz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e2c; helo=mail-vs1-xe2c.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jD4G14fCgz2yKn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 06:59:21 +1100 (AEDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-7c33cc572e6so226682137.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 12:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793044757; cv=none;
        d=google.com; s=arc-20260327;
        b=g6ZYkbHqChB6oeHb43IVXtrgflZruZxKEZPWkRAW5bThNCY1OhD5qBusynpbVW71VH
         SrSPLKSsIeerY9InP9TWNEE7koQCQOx9+idNv5fUaim12y4WAdacgNla5sPFeJJ7TXn1
         2liMy13ZvgRzyjIfpiWQjDkzlD1eOuO3LWPNjnclx4/wmV17qlUlqqWcCnYuMYgaL7Ok
         GqLds3r7qS58H7ZvciA4BzhZ24q13vapg7Z8GvQhlSdFlkECPJoc/VdeVwIOq8E0cMfg
         XNTPgtNqveSx8NqyTM+ytf37KEUnJC/RLQpsig76awwNYkUa1W1H+zp290Ps+iwnZrej
         ke2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5v98+mkBPyKcXGGfAa45H0MLFavlwhFEg5B6g7hFf9M=;
        fh=kIJA/njFb/fokCdEG8d2HjbmI0TUj5EnBGrhTFldpRg=;
        b=h2/hltVywuG/sY3m/gcN+MmBsXeeoCz51AMAeDajWloW4036EUMlRKx8OJEDtLR7/5
         MdJxjvLL1c/mf9n66TE7+jAnU0Cl3fIz5qNlDjAYb+tC6vs3gDvgK6DlUUn/AO8iwXXN
         tAPTA2PsrLFFHXjsmoZJTbTH3WStVhtwg4svINFgOFeLFskp2viyVALliNeJ7p568g5H
         9MezoKYZVPhbeAij4G8i1np2Cl4WbQRl2j1ix86KprbQm9ciYPWLizkDFx6s/30h2mQE
         Qk+vKhQFYuwVUlxr+BM7qjFgB6pzhPByFz2BDSlC8hN/ao54sirnoF4Lvz6sr1RdMLMt
         yFrA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793044757; x=1793649557; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5v98+mkBPyKcXGGfAa45H0MLFavlwhFEg5B6g7hFf9M=;
        b=QhuTZipzP6+0FkjMVXCCnNK8q4FpOuaaDW3Q8uY5jcBv51/AX+/jb15PRPF+i4xlFA
         JKm9zQgvr0Z3MAY3NP1LW7BEqGKmSi5cQE8dwYhQPayJOtzSROGY3TqG8XrHGrDq7yv5
         Kn4h7qNedoZuBAcjWS03v8ZsdFagNGgROaSfwmJ2zm5ZLYOPkBcH3sbqeHPNDk3juiwk
         ZGF9JdORAUcpHip96C/K472MNjUmW6TlrSVs6iMZidqFpXflKNgUWBPTaBT2/uBrTPet
         6iaPBUo591niGTKQrZ1iU08ln9dEXq2zzzwDmdCAdPSO8kSOjs+ZcnFSBciOj1qIlfp+
         cXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793044757; x=1793649557;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5v98+mkBPyKcXGGfAa45H0MLFavlwhFEg5B6g7hFf9M=;
        b=P82be4hMnnjOG8RzXzwoPu455xkrGCjjH9rGtEVUkEmhNs1UcBf7+4KoDpvGT3xglA
         sgATJswTIyNT/d1Fk3zRoG2WsJ9RscjzUwDxhpO/FGUu7Yq1W7S1HveSW7UaFL2j8f4Z
         M+HwI6SwPmrYwohxO8iPHI9PC4x5jomRqkqQTi5Q0nOK/414h8OblSA4lbza5HUEa5i9
         8A1TD46LSXNHypwWO6md9gkuI4kIVZXiLNPfISo+aZORHN/NJlk0UaCIDX+lI2HCi6bv
         i9mSr3KBrNzz5CqBAtr2l0Ot+bVWXb0wh7UWRNvsvV2BFGrEp5bAb5bmMQLCW3WQmj+F
         cy1Q==
X-Forwarded-Encrypted: i=1; AKwUvByIEKGPOtefSLeERBmku4HKTVXckdMCKY+Msr4/VIiI/XfLVDTbrQKAKjhsgKI3kd3kOXmeFyQMZRIUM8A=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKNzvqndjfpx/9gSRZUE7MIHCksSBTiIiErrjtevhYTa//qbS0T
	K0iloler5HHzZCMS5wd1Ot8QHIZsF+D3VxWxHfJ3I6VHKOfMxU2FWYbjD5gGIuSOS4K0w0wUVRZ
	v5Z3GEDyRdVw++Uggqp0NMbBmiPPLkvQ=
X-Gm-Gg: AYBFou0Bx6NUXx1/NiPqtlr5vlwjoHoOM7oYS8YXgEI9cv71WZ6S+1wLW0oa+beELzn
	xrYkAXXfDMW/78tqmBdNzZZqBqGf05gv3IId0tYwH31P1eTlzf2vcDvfZXIdQNKJNhy2mAK1RbV
	UPm9J+evKpSsdQgxYKZHQfburjzptZdVbVkbWw8M8qX6tDtaPlVPch/H1kx+31qbytuREgK9AgQ
	yt3pp/Q/VxnRhgsG6a4j5ecmHYSbRmX+QjTUuQw1z12VsaJ+338tObcNMBs/9OsHWvmiw2BxBKN
	PQBdiq/UlF9BG2Z6Y22mXIdfsIretLuq2hg4STuaDAkW8hf91/M5q0gM90C4/Pll9ftbznUJ95X
	evLnWm7UToiFRBlAUpIqJNRFYIixgGkUmW3TqEg0ccF5c/lqsUBTNzd2BIDrrm0p3MKWwsrAf+o
	ctxzibYkuwPqNE9sNBIVZeu/Lj9nrHpOTTbWDGYp/1ZIhTszD8bZdGbnqBsj6nITDeyoEOMPvEj
	9r9V9rrHhWHhdoxRojUs2Kw+E8t+g==
X-Received: by 2002:a05:6102:3e8f:b0:7cb:bd9b:4873 with SMTP id
 ada2fe7eead31-7cea14fad38mr297588137.21.1793044757153; Mon, 26 Oct 2026
 12:59:17 -0700 (PDT)
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
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
 <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk> <at4bw-G8czG-G7Wl@ashevche-desk.local>
 <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
 <at5qKehogAjTa-fA@ashevche-desk.local> <CADvTj4qSgE6Rc--mWuqAcc8HTqN9EFOS_JM8Hp8e_=ka_ZLa6w@mail.gmail.com>
 <at8eDFj2WNaXDaot@ashevche-desk.local> <CADvTj4oNz-bnSZP+kfau-7wBSWLjLTP5jrr6nLfdCHNPo3pS6w@mail.gmail.com>
 <at-vyZ1sDhYPu0W5@ashevche-desk.local>
In-Reply-To: <at-vyZ1sDhYPu0W5@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 13:59:06 -0600
X-Gm-Features: AclHuK-pkQBp3tukGM9FdJ8ekfrjzUqdLwbnUIKbAlyu-Q9paOfNaII7ApJtovI
Message-ID: <CADvTj4o_CENc3i92OQEZudOErSKPUptT4t2CCqDaGbseuK0QcQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
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

On Mon, Oct 26, 2026 at 1:53=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Oct 26, 2026 at 10:45:54AM -0600, James Hilliard wrote:
> > On Mon, Oct 26, 2026 at 3:33=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sun, Oct 25, 2026 at 04:11:08PM -0600, James Hilliard wrote:
> > > > On Sun, Oct 25, 2026 at 2:44=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard wrote:
>
> ...
>
> > > > > Some people might want to test the stuff. And sending too often y=
ou actually
> > > > > will get the opposite results, people will be tired to even start=
 reviewing
> > > > > and/or testing your code as it's changed way too quickly.
> > > >
> > > > My thought process was that people wouldn't want to be testing code=
 that
> > > > had known bugs flagged in Sashiko reviews.
> > >
> > > Sashiko reviews are not visible in my or any other mailbox. To see th=
em I have
> > > to go to some URL and so on, meaning to waste time to see why on the =
earth the
> > > new version has been sent.
> >
> > Maybe the Sashiko reviews are getting caught in spam filtering or somet=
hing?
> > They are showing up for me and on the mailing list[0] so I'm a bit conf=
used why
> > you aren't seeing them. You shouldn't have to go to the web interface[1=
] to look
> > up the reviews.
> >
> > [0] https://lore.kernel.org/all/sashiko-outbox-183574@kernel.org/
> >
> > [1] https://sashiko.dev/
> >
> > > It's better before addressing Sashiko comments,
> > > reply to all people involved and to Sashiko's original email, so it w=
ill be
> > > visible in the previous version why you issued (actually about to iss=
ue) the
> > > next version.
> >
> > Hmm, maybe it makes sense to enable recipients in the reply_to config[2=
]?
>
> It's up to the list owners / subsystem maintainers.
>
> > [2] https://github.com/sashiko-dev/sashiko/blob/v.0.6.3/projects/linux/=
mailing_lists.toml#L290
> >
> > > And before even issuing it, wait for a while, people might
> > > disagree with Sashiko judgement or your replies on how to address tha=
t.
> >
> > I was assuming everyone was seeing the Sashiko reviews getting posted t=
o
> > the mailing list already. The are ending up in lore so unless someone i=
sn't
> > subscribed to the list I'm not sure why they wouldn't be seeing those r=
eviews
> > already.
>
> I assume you already answered your Q. mailing list in this sense doesn't =
mean
> recipients. I think it simply goes to the mailing list without forwarding=
.

Do we want those reviews going to recipients as well as the mailing list?

>
> You can ask at helpdesk@ how this is configured on the kernel.org side.
>
> > > TL;DR: this mailing list is *not* a playground with you and Sashiko, =
the whole
> > > community is behind it.
>
> > > > > Settle down first
> > > > > with something, put on the cover letter the answer why not all Sa=
shiko's
> > > > > comments are being addressed (for example, due to amount of patch=
es or the
> > > > > series being focused on a certain issue).
> > > >
> > > > So, in general I've been always attempting to resolve known Sashiko=
 issues
> > > > in every subsequent re-spin, so that would be a bit tricky since I =
wouldn't be
> > > > aware of the Sashiko issues until after the series has already been=
 sent.
> > > >
> > > > Usually the subsequent issues that get flagged are new issues only =
discovered
> > > > after each new re-spin.
> > > >
> > > > I do have a bunch of UART/DMA related patches that don't have flagg=
ed Sashiko
> > > > issues so it probably makes sense to try and review those first whi=
le the larger
> > > > series that have Sashiko flagged issues are still stabilizing.
> > >
> > > Yes.
> > >
> > > > > > [0] https://github.com/sashiko-dev/sashiko/pull/389
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

