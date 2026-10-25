Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8895606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Oct 2026 22:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q7oM/TiK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCWDs16YXz2xmV;
	Mon, 26 Oct 2026 09:11:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::936" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792966285;
	cv=pass; b=bq4dUwHuFSe8qPXVcJ1wrWLmmPpm3olh52zpRe5i9pwEX01a4tTnYwfY2tRIdDtH6kFQnABdCZ62sdc8I2swRuCNaFexPUUsmehKP5jevCkPbwt0YkR0UrdDZ/Zw3WsUaymER2ecNuj1krbZgV5wJ7FMyMMBB7/emse9cc7PZN0kaFXfEsSSWFqhbF09Tf+N2lkyOJiqVpIxw0BDFAy8FhtyP7pqLqFKuLTJCxPgDIfbuVWOFDsTZFrCbqGvlnqAzNUlkzVODvOPVW29ZfyKgC4nnURaoqIg0eLOu53L/HZ45KmlfVt4cnkaPKKfXCvMadOeIkNE59UkRNOSRL3HMw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792966285; c=relaxed/relaxed;
	bh=2OfqgWNLYUmZ1gnSmkRsn07TKyfZDdq4vI9UsfMbPGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6BYERg4UfbhMGLIbKy65+ORJI0BVQj7oTvu89b70M9Ww9JT/jV8ghjUaso92F5G0rgPe5qIka/qBevlXsH2cvOGQu4aSXNxtl5dT7Rt4G+xVMp7MeDVcbMNBfBoCIME4Uf9fgvHBv1DlafCa/PXNc8fIo2HycOJyq/7G1u4ELP6yuJY/KVVUeQfwOn4ARBYV06KlPSAKzr5Grt69vuXdlEt3DKj9gyrpxeBKELzDYeyIjg+Jg2EiciHQkwKH98dxoNT+bTkg+B57KmURG8RD7/OedH3dZAWotrimK7NLBiKe9CTibRFpYzrGkNeosDCpn7j1VndybBA9L2ynwAF/A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q7oM/TiK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::936; helo=mail-ua1-x936.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q7oM/TiK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::936; helo=mail-ua1-x936.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCWDq2g2Yz2xKx
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 09:11:23 +1100 (AEDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so2631253241.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Oct 2026 15:11:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792966279; cv=none;
        d=google.com; s=arc-20260327;
        b=rk6bEFClIr37X50GqPLl3V5KL08WQR7kDzakTvn7eGW6GXolSGTwVzTvKU3rH/z5xR
         dUGgNfZ33gIcOa0SZb1On4l+LmyAJAFrnzjkshjNMy1Q0/Ely8OimP4PWXYNnQVKrayY
         H6gDjWJG65G2Y6MdspTMhKTA86bvDD9n/JEQAYjp6mHlO0Y2KNkRqby3n+m1gyTK++qZ
         crLa1952r4Nz9u3SWjXslo9ZTYxuilYmCZw2bgNfVvgOvn9r6TOAQV8PmqwJEnymOwVG
         Rq/euPw3iW1OFeS7m3kiUJFJLfQBirZo+mVtsoqjxcOA1pdWIKGgieAJJbpvXC7GiLGc
         UiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2OfqgWNLYUmZ1gnSmkRsn07TKyfZDdq4vI9UsfMbPGw=;
        fh=RbQZ97IdP0jPeJfQTHs+dloRjZJ0pVqM2ZffxaNvNgY=;
        b=l6H6Fk/XUSlKy1nH0tuFLhm2q/ebSBUeqfjpsp+vrwZ/KK2ORnOBDSTibT1kvpuyOy
         r7DLxMY9tASzk5AhXg7svctkFJroN0vryPDK2bmDl72RxUX9Bg4c6YuCVxRQoId3dXqq
         5iRn22xtlMguPfiwoc3ciuPtTHsYvWia2aBGREE45lFPsjlH+Sr9s9OWiOjq0/ZHBuUw
         Cw61fXkB8WmcmRNNQmAO1jo+M4kaNtK4pad90J/xpaBasqTWKDwisNrHF2cvUkQobnXt
         4ThKJEOk0jtV7lWbwjEnpSUefIoPK4f4n6EIoTfDweweQAV9s678bb4DUKLDglEBP0qM
         3RcQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792966279; x=1793571079; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2OfqgWNLYUmZ1gnSmkRsn07TKyfZDdq4vI9UsfMbPGw=;
        b=Q7oM/TiKy8naga75quonnFkBc0V++m6BY/oyxGYJ6ZoELu1jvJXjxaHUNEpQjPqNHc
         bR0svN+5ZlPTChmA7FYcwDpKs6vt1UoGHTHceSal1p48iP6JwcGuCoBCWLfq5WkpayXF
         +6//A9krxLaJqK5yinJF+1oYHip3Kqh8Bm1Na5khG7Fej3mBsA2LwztafQe52oVhYDQl
         e5CRqu0BPbeRoXLFgFYA3grHgQzckgmQxZMZe6sEucEZJ8EFPXOSGhwfmFmVpEmCuYil
         HXzvAKxlizM0oJV/sKGYMVEb+SEtkU2qYOGyUAyqQ/kHJ6wXeaj9ghHJeYk46T0k7v6s
         +UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792966279; x=1793571079;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2OfqgWNLYUmZ1gnSmkRsn07TKyfZDdq4vI9UsfMbPGw=;
        b=Lz3f38lFkFgEkP3fgqp+BkYZNabNlcxJRd4wTVimFvHH01IVLAvQr4SrrVgXsoo3Ta
         5fYP7uB1TaZz1NrwyX+2xkp8nA43V76P+i1WkOpBkmghI7H+rnkGA5B4Tbo7P8kFbMgw
         RNYzOIOfOBidDSvbPvIia0Cw9VvOA8Mq3v1dhdXQxSisDjotTmyheNHSCoUz1zDa4eXM
         olDBsHiLAyZfPwDq9XNCT4e8GV1Oy2avq5gai8m+63e/CuYKQXRXGqGZaeod+qEmn5hZ
         S3IbzQA31r3sdFQAqhLXiCqRCGounQrJFI/EBI9LmgZzEI+x0mu7YyfoPljyoViviblD
         RGZw==
X-Forwarded-Encrypted: i=1; AKwUvBxVyp4o821PWhejMwaQUkMc04E0bxM+CaQruXHOK2vd/75VJyTYr9QYHkQa6wvIlqghu7eRfoEetkiVhhw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKkV5l85IBhLjpzedZp92Y5M+hq1AnqGBTH9zvdtR69HpuK81tt
	yb5PYTM2mJHmAG2pvWd+cr5g4kyNcrnPhAWEhIIFfahih2ywmn5nrtylgcsTtXxszplslq2r+Gy
	gOEeTE9xctJWrTfMb0BqbvO+XZVpydCw=
X-Gm-Gg: AYBFou1EaLnQCXvm+U28vyZWS4d64KPJ26gXOMOUwdRO3kVUXfCftc1ULScf8Xupk6v
	FoFCvPl7B7GC21sorAWTUf90SvQeSBAa+8W3ZSrBwMhSRIccYvu13busCold5lLXl4uOBF5jqQR
	sRLtqWnHMUTdfGViajBb04t9+G8NmskKkP63PL2S6bgRN3tIJlGEBmNPkZ3LMFOCQyaipzUJ6kj
	SoUx0daCj7byVkQcu6hX+A+6ICqZDB8BdIFvlfVuM3v2oSXduCXqEzq+N1OjwRwcgg24C8nMlgw
	CQssyg92bYoxNnpK15s4PnqMtG1w32tt/PXPXrdYXxsl6KiwEZUhiD2Ii1OhkOD4xLfD19OJiH2
	0LZ7Mft1vdSCEmvzleeFcbGhFsUwTCzOLIJ9hLWUtKzgSbMrpE8L4kQ2JKMuBG4zWypi7Oare8q
	irBr9azxDkXfKGRn5QjykqOvwI2980QFzr73tALqgzf8TWAHpDZ3Nu5DvwCDRn6MfT1O38dQi7M
	+0pULc7TjDp92cwCwTONWaT5QwJag==
X-Received: by 2002:a05:6102:54a4:b0:7bf:8ec:4996 with SMTP id
 ada2fe7eead31-7ce5cd56791mr1192565137.20.1792966279613; Sun, 25 Oct 2026
 15:11:19 -0700 (PDT)
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
 <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com> <at5qKehogAjTa-fA@ashevche-desk.local>
In-Reply-To: <at5qKehogAjTa-fA@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 25 Oct 2026 16:11:08 -0600
X-Gm-Features: AclHuK8uppf4mumWz9vBy2Gysgc_7CSgy4TY8S57y0TXESxCvcndlkgEpAI5NvA
Message-ID: <CADvTj4qSgE6Rc--mWuqAcc8HTqN9EFOS_JM8Hp8e_=ka_ZLa6w@mail.gmail.com>
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

On Sun, Oct 25, 2026 at 2:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard wrote:
> > On Sun, Oct 25, 2026 at 9:10=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sun, Oct 25, 2026 at 05:10:03AM +0000, Maciej W. Rozycki wrote:
> > > > On Sat, 24 Oct 2026, James Hilliard wrote:
> > > >
> > > > > uart_write_wakeup() expects the UART port lock to be held. Severa=
l worker,
> > > > > DMA completion and interrupt paths call it without that lock, inc=
luding
> > > > > indirect calls from uart_handle_cts_change() and the transmit hel=
pers.
> > > >
> > > >  Fair enough, and thank you for the cleanup and spotting the issue =
in the
> > > > first place, however...
> > >
> > > He already issues a v6. I think the tactics against AI contributions =
should be
> > > to not answer for a week or so until there will be a quiescent week.
> >
> > At least with the workflow I've been using, a good signal for quiescenc=
e is
> > simply whether or not the Sashiko reviewer found issues.
> >
> > I am feeding the Sashiko prompts into my local agent but it seems to
> > sometimes miss issues that get flagged by the public Sashiko reviewer
> > still.
> >
> > I've been attempting to peel off independently reviewable fixes where
> > feasible as well to minimize the amount of patches/code during respins
> > as well.
> >
> > > At least that's what I learn from this patch storm.
> >
> > Whenever my local branch accumulates significant refactoring/changes
> > due to Sashiko or manual reviews I generally try and send out the new
> > revision fairly quickly in an attempt to avoid reviewers wasting time
> > reviewing code that is obsoleted by the new fixes/changes in my local
> > branch.
> >
> > Locally I actually have far more UART related patches in an integration
> > tree that I've held off on sending for now since they are dependent upo=
n
> > the prerequisite fixes I have already sent. My unposted patches actuall=
y
> > have an even larger amount of code changes than all the UART related
> > patches that I've posted so far, at least when measured in terms of tot=
al
> > lines of code changed.
> >
> > The large amount of patches I ended up with seems to have mostly come
> > about due to the AI agent identifying most of these bugs while iteratin=
g on
> > and debugging new features(most of which are still largely unsent so fa=
r).
> >
> > The strategy I've been using is to send small isolated fixes separately=
 and
> > then reference them as needed in the larger series that depend on them.
> > I figure this should make the changes easier to review than having them
> > all in a larger series. I contributed the changes[0] to make this compa=
tible
> > with the Sashiko reviewer actually.
> >
> > I also use a custom AI agent controlled hardware in the loop test harne=
ss
> > which makes iterating/testing changes much faster since the AI agent ca=
n
> > autonomously test and iterate on changes far faster than is possible to=
 do
> > manually. This test setup also allows much more thorough testing as a l=
ot
> > of error handling or uncommonly hit code paths can then be tested using
> > AI generated fault injection tests on real hardware tailored to the spe=
cific
> > fix being validated. I manually review the final changes before sending=
 as
> > well of course.
> >
> > I'm constantly refining these patch development/review workflows as wel=
l
> > so feel free to give me any suggestions for anything I should change to
> > make review easier.
>
> I already gave one: slow down. Better think than loop through AI and keep
> Sashiko busy. Your patches are valuable, no questions, but they are way
> too complicated to catch on withing an hours or a couple of days time fra=
me.

Yeah, I was already slowing down quite a bit. I probably should have starte=
d
sending some of these earlier but I wanted to see how my final integration =
tree
would look like first so that I could better peel out what was actually nee=
ded
as preparatory fixes in ways that would fit well with subsequent features.

> Some people might want to test the stuff. And sending too often you actua=
lly
> will get the opposite results, people will be tired to even start reviewi=
ng
> and/or testing your code as it's changed way too quickly.

My thought process was that people wouldn't want to be testing code that
had known bugs flagged in Sashiko reviews.

> Settle down first
> with something, put on the cover letter the answer why not all Sashiko's
> comments are being addressed (for example, due to amount of patches or th=
e
> series being focused on a certain issue).

So, in general I've been always attempting to resolve known Sashiko issues
in every subsequent re-spin, so that would be a bit tricky since I wouldn't=
 be
aware of the Sashiko issues until after the series has already been sent.

Usually the subsequent issues that get flagged are new issues only discover=
ed
after each new re-spin.

I do have a bunch of UART/DMA related patches that don't have flagged Sashi=
ko
issues so it probably makes sense to try and review those first while the l=
arger
series that have Sashiko flagged issues are still stabilizing.

>
> > [0] https://github.com/sashiko-dev/sashiko/pull/389
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

