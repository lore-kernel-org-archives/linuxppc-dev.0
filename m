Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300F1606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Oct 2026 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e34LfF0W
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCSvJ1g7tz2xfK;
	Mon, 26 Oct 2026 07:26:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::a2f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792959964;
	cv=pass; b=VJM2ldkFj2JTMYdxS68mcgyeLaQX6bBhywx9zaKoQOHwG7iOCpgBQux24pAKQpLuEHd9V4ub2ZrHsQpNxPnRe29PqWOj7teK7jVST76CSczo1cHV2oXlltF5C/b+p6sPJNTd+nFzoVF3XAbQ9yf6kvd9lX90x5fPzaF+DptY5ULlazDfJngDcM+tIxj7yBbDTj2Q05vr1mAUqUgCQjQ7zMbgVNA4VtHeI6vDt3gi/VX1TOiF20bd0OE6AbcOKJ6PrOUdyNWjTUqEyGbXHgiWCySyMMOSH+KrmXSEM7lWmS+Vl8kBMX5j3rPd79UhnL3ryTMbLa93AynSMg3o4RO4GA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792959964; c=relaxed/relaxed;
	bh=C/RThAUA8B7cnZs887BkMxa6IkSw9Jpa0pELDADdrhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gt4Lk8pvDyVV6mevtsx5Q9g/cfhciZo3aMsajwpzVBUdaUVV/2JRXUiIIv9Kx+OmpzkAB4Mid88GuWhLUqK6WJ/VTL6fxScdG4liLHndT1mC0jkxXtUCKFuoyUXZ2Poc0ngLb3Cn/7EwuAcTORIPtYs3s2HQPwjHo1JOkub+iubrv9RCkUSBDhFaQQq/FJt5YxWbwLD+0TvKdiD4bCTkG7yCcwAjIZ4jvSB8sFz608EbVzokdD97/6NdY4EUdZ6Puxmytjkh8IybrxWKK/njOpK/Txv75JfLhaXSw1m4T8QfaithTbeV6ZA+beV9YmG6pJdZoVm69VmaNZCAc+RjOA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e34LfF0W; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::a2f; helo=mail-vk1-xa2f.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e34LfF0W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::a2f; helo=mail-vk1-xa2f.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCSvG0trRz2xKx
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 07:26:00 +1100 (AEDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-5eabf243d05so954724e0c.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Oct 2026 13:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792959957; cv=none;
        d=google.com; s=arc-20260327;
        b=J5NS6HCMyBCgpjzoranE+hRy2vqH0PgHxYo38YPy5JotbvY5xrFlsz6RHm0G9vHSAx
         /9xilA27iD6vhc+smzQYrPncCX9bC/XtLp6igHgwvQYkqf0D+nikYaN+gHXdKe28A00j
         bXA1RasCcx5uVJtjFSP8TH6VuhVzjaR0PMU2jE6/Dh7S8xUaptwKlpI0uMpKXRskJcab
         yvJpjSzHwn9219oN4Vwc7x549aSZ6kgMAu5P94Rs/M3PKoqNKRtiMM5ZBp8Juq/FKUca
         wEI4KOoVJtxKE+vzfFwlmCWw/tJW2542CnS+rCHRIRhTEYFzFD9mNjwlAbi35SXmukOZ
         3aPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C/RThAUA8B7cnZs887BkMxa6IkSw9Jpa0pELDADdrhA=;
        fh=7Szs7CLoReWcRWtAHvd3IU0Rz17jUDJ541Rj2l1tO64=;
        b=IbTO8gnoIxR2QT+/Y64+pLBWUIQtqx+hwx6rtZNXKTjaw/naN7AoIulFynJpdDWmC+
         lBDZpwwPm+5+ITNFpBXikDSw9W3jewIhu3zN6YyNK2UdMLAc1y8LJ3l2wk91PtMRDfrW
         7w+wPkmjsTF3vbpHpVuU13nbYEep20bk2NanuN4JTt3LxqgiNXrlqdB38sfBTJ+Jo6VD
         IsJDx5Ok2koSSC9+A2RUwwy4glhuXm+4fshSXFCMwngVEcEglcXT1ZdT9lecn12WrFU0
         VzO7xK4oGoWuA5VHB/oYY5W0XK3P8Crh2bRavIiO1apKDHD3vmwrgTXbowhRpROi6tzv
         mEKg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792959957; x=1793564757; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C/RThAUA8B7cnZs887BkMxa6IkSw9Jpa0pELDADdrhA=;
        b=e34LfF0WSE5QhQF3yJr/AgWqK2hJFOwgIAbxBQIPhQh1pxKrjXOtPobd92BjkKjFv8
         HTrmYo/hBkS7Q6PMNXQKI2YJJk6P7oVUb5KzenWEY1/uvMHdEFnSL/0rjiGL+l8QbfLg
         kM0cxTfeu/XaV+YHFOSMxZHaB87MxjOl2WFa1xuVmiYZIpWcQ48a+kcLtZEUch4jEA71
         /hmGQBBRlqjTgeC1G7L6LkM5kZ23ogNLbYhPbJtONdCeYXRZpbGbmykOHkk75G5Nsc08
         e5qf0FJ7Egj4WShM2R/tx8oa3QvxuGPq6FV39CN4C3X6epCc6mLE7N9mJEeCOTEpe4V4
         GMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959957; x=1793564757;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/RThAUA8B7cnZs887BkMxa6IkSw9Jpa0pELDADdrhA=;
        b=UaioKLmxTDNdIMR9vdPJqRT6j+vwn8vfUNMTZYDfkeyOqhtHHKfWKzgan0udAzPUax
         RyZ/eX/zKs0HOPOt16tJcfwVUgcRqK+JhdfM0SNHrchMCvsohJqCHSxP3OkG0v0ghZCQ
         SAl6xaN6ZlwkGAZA/zd51i1eCyRDJm8KPbokdNzKSbt00miCvdHinI/XOp7iI0wOAddf
         LwQW6WpjNqwjiSYyn2c6zkO1QNNmeCaHgbTn0HK7sOeiMlvRIgQFyLqN2pFf9q2CViGL
         EOguQ1fsKix/LWaWFqgTM19c84xRCH955ruDhPAt1p3wbP0PGWuxoTK0QYRD34/pruf6
         5p1g==
X-Forwarded-Encrypted: i=1; AKwUvBwn4n02P4+5Hub8/qJ30NtScksYdGUwpHJgBavgJM440PItM2PvENdZtEixSRvgbzo2bN5nMBoFGWU1xuE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLRgXnbVohrHchbKaWUI9+WXIDy8gtUh+cVL0XL3cA0hzgqZJHE
	+UY6NhWpxNDhoaYPoX8I+f/spvhzOM1JlhRPvP6uFKpAUZk7s/qCteEm97QM/llL4GR+6/2TPrO
	vJZwtJEfS2F7K83GMVCX59nN1RwSKAzA=
X-Gm-Gg: AYBFou1j4+5+/bF431Y4ggKnWWRmaQ60TLqIShGEx02M9pEG6eRQXvYpie7DFeqr6eM
	tdbMWC+96/F7ZVJJqSOAc72Mzds9jEXF/YOBn+t7k/8MVvVnNlqmOAhyWuVSG1CFK2JeLUTJTlH
	lDPHceTDqocPn/l+BaOYGbaxFW2tIdCbS1ss1hxB95f3Sr+//eApFo+sjRCG0qOsMl6ZZo+oHFf
	h5US/kU+Jw3camtCrEzNcESvAATGlwoTPZ1dUtC+z1eaL1WSwMA3kV+FqdMMXlP+Y42IewouNYz
	RbN1CrFkmTt6huEdTrlUWoe8H25E7nBSKEnfjXeNwYJYOM7SdlMKXC7kh3tYq5RuL2KjnFwnpxI
	RTb7CBiBXeRpdYGgMVwwG5D1O2TUH/+h2Sl0cIyPpHeR3w169hTCLF3v5YdnP2ADqmCFbViCihe
	JTyzeqUk4GWYqpsu2W/dOlfZDj8OH/EH7+siDnF9f4ZYYxyqYxcetwzcJ1OegQq2r5jXoKxRjbZ
	JwqSL5C06ymV8xdK8HxLwINJWu4Tg==
X-Received: by 2002:a05:6102:a213:20b0:7ce:645a:13a4 with SMTP id
 ada2fe7eead31-7ce645a802emr619643137.20.1792959957403; Sun, 25 Oct 2026
 13:25:57 -0700 (PDT)
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
In-Reply-To: <at4bw-G8czG-G7Wl@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 25 Oct 2026 14:25:46 -0600
X-Gm-Features: AclHuK95EKPTnWE_5NOhWBwYmgu-dizSaKFvAkW3Q_P3x_TD5WYGvbT2T9PcLnc
Message-ID: <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
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

On Sun, Oct 25, 2026 at 9:10=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Oct 25, 2026 at 05:10:03AM +0000, Maciej W. Rozycki wrote:
> > On Sat, 24 Oct 2026, James Hilliard wrote:
> >
> > > uart_write_wakeup() expects the UART port lock to be held. Several wo=
rker,
> > > DMA completion and interrupt paths call it without that lock, includi=
ng
> > > indirect calls from uart_handle_cts_change() and the transmit helpers=
.
> >
> >  Fair enough, and thank you for the cleanup and spotting the issue in t=
he
> > first place, however...
>
> He already issues a v6. I think the tactics against AI contributions shou=
ld be
> to not answer for a week or so until there will be a quiescent week.

At least with the workflow I've been using, a good signal for quiescence is
simply whether or not the Sashiko reviewer found issues.

I am feeding the Sashiko prompts into my local agent but it seems to
sometimes miss issues that get flagged by the public Sashiko reviewer
still.

I've been attempting to peel off independently reviewable fixes where
feasible as well to minimize the amount of patches/code during respins
as well.

> At least that's what I learn from this patch storm.

Whenever my local branch accumulates significant refactoring/changes
due to Sashiko or manual reviews I generally try and send out the new
revision fairly quickly in an attempt to avoid reviewers wasting time
reviewing code that is obsoleted by the new fixes/changes in my local
branch.

Locally I actually have far more UART related patches in an integration
tree that I've held off on sending for now since they are dependent upon
the prerequisite fixes I have already sent. My unposted patches actually
have an even larger amount of code changes than all the UART related
patches that I've posted so far, at least when measured in terms of total
lines of code changed.

The large amount of patches I ended up with seems to have mostly come
about due to the AI agent identifying most of these bugs while iterating on
and debugging new features(most of which are still largely unsent so far).

The strategy I've been using is to send small isolated fixes separately and
then reference them as needed in the larger series that depend on them.
I figure this should make the changes easier to review than having them
all in a larger series. I contributed the changes[0] to make this compatibl=
e
with the Sashiko reviewer actually.

I also use a custom AI agent controlled hardware in the loop test harness
which makes iterating/testing changes much faster since the AI agent can
autonomously test and iterate on changes far faster than is possible to do
manually. This test setup also allows much more thorough testing as a lot
of error handling or uncommonly hit code paths can then be tested using
AI generated fault injection tests on real hardware tailored to the specifi=
c
fix being validated. I manually review the final changes before sending as
well of course.

I'm constantly refining these patch development/review workflows as well
so feel free to give me any suggestions for anything I should change to
make review easier.

[0] https://github.com/sashiko-dev/sashiko/pull/389

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

