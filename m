Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2755606A31A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OpySh7/4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFrb62j7cz30TQ;
	Fri, 30 Oct 2026 04:20:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::531" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793294418;
	cv=pass; b=XI6GA3p7/8Y1SfspEj6TP/toxi/XzevOZ9pdWiMeOB0KZt3DtFbiApoNsvTRngpbyT/uReXinA7uPLY9lDkrEz0tuYAsUUE9rQRsWyL/owPnur5mBx6CJgkJfEhIyhbAyIsBALbKNnOZlVlPjTSzAWdiSRchzWeCPYeL8joBl/DwVZexdTwPckfst3eX+XkHyxGgkPGU1vX8AGydEjTmc0SWzRIhZjgudytM8m8nCKXjj+w+FwYi2/tWzTbKTrt36P2DKQ7JPYJtDpamH2qnpLQ/P3l8Zo1EZYgKTqf4/C7/3jykcRNETte7NQgwrMiOiWhrm/oEvZqMEKEETDTh7A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793294418; c=relaxed/relaxed;
	bh=DcHId9d7ZivTlUPflcKuYmygXozfLhAN5Qcceh+SBys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8LxV+V/jEsDgZ8VPE+OOjr1P2ABJ8K8Tv6wzl92ZlK//o7K0mfigTxL5PBGRxn9xuXPIOljhW2FMsziDJuX8GZ+99GX0F0uQd+I4/0MnfWoLqDYEpYAVG5PbMtEZ/x32eA1eqp6R9TQUWrN1l7bGgCE2dxzpFQx8RTdul45QrpVsfFQqvXg55kwyp+xi74KxlXEiqV5MaicOuFBl+ZuyF/De07pzom87QJYXFW/yAX8udQWpmENN8weCsgUYtwPj6YGYGP9WU6af8vrhaE1phAcimjpdZ29tJCmtDwPddjUiSF8IX/h2CjmZYs3fpCJylvzwxHPFQWvKwuZ/p3wWw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OpySh7/4; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OpySh7/4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFrb50FV9z30T9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 04:20:16 +1100 (AEDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-6acb57c2b88so3260568a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 10:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793294413; cv=none;
        d=google.com; s=arc-20260327;
        b=S55NIsNQ9bfsvZPBU/PCavYHVe25DKMp56sIzAUpG9ElRE7V/8o3jNknEMxreADOWA
         7E9gztqIFvayx6yWmvvJlbs3ZZCB3w4WUA3qrwAY8Zx6tPyfVmsFmhNMrP16v8lvkHWy
         V5xnK8A7ZmIr+uTWDuVioQofUECYS2opohMBdNv4h+YT/l1ezEwA1BX0TevtxTRvrNOA
         5av/SaVFESXay9xBoMyUWsQhXUqQzbmdZviHeG2WYNve/HSKX0gboIvgv+wOo3LUcdjo
         bjBVYIU8t3JV9LcbRRC0UHHzsI/+FVfFnyVEDUORGtyEaFvjoQybrsDYrk0ohdHmS7cr
         vo/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DcHId9d7ZivTlUPflcKuYmygXozfLhAN5Qcceh+SBys=;
        fh=llJLZTzSI8t+3sJAy6QVataUloWh1kJSkOUsIQntClA=;
        b=Ktoh5OyblA3Ou86SUocizIzNqYU5pU0RQV4MlBNbYm9NWaj8at9UDT+ifCvpOImM5p
         NFqh2lop/jMyFPC+4UwYWlK0hZ8HK52QZtbJM/rYPeo86GNWI6iKMjbBm0/Sx/p+qxak
         /iUi7oeVbtcRtDTa3dmiD1i1hpRzSrX2QI7AfxDi2ggbaF9nrdk0DKaR0fzUEfAHQ1Z5
         ZpT6xsvFiPoJ5+HYdJqAxtEUPFbNbvD9qzTjPz2y4468rWt9HSWUH+3h7aghIB04BQRF
         THY5T0wMMxO+ydQoWuaSrQf6A5HQBPbb2rjUeV/00R0/woAQZnh+I7VNzB5yDeMrS9wz
         qqww==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793294413; x=1793899213; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DcHId9d7ZivTlUPflcKuYmygXozfLhAN5Qcceh+SBys=;
        b=OpySh7/49q3cIbLQdcQpTdKAAz5KNY+Upco5PBg1R86Af13B6F50uGshX7sZs9XLkq
         yYSzl5Svnx05Bi/MlRnozhMUUNhpdXQYThuLFYotW5V+Dh+ixbqdGvT4iswzTK1NwFB2
         lHmbkZxNDU1CE6v1T2LyXr/eDV3fFcFno4ZRCLwHKRKv2k0iuK8++MTkipGr1icoXBe9
         ztnfmTJSoXwgR9wRxPy9PoYXojlndBgM4KnetsFH77AUK9wf21G92QQQhQlfZ15o/5+f
         joEUhSdVht1sXk/4JCruVinHRT/VC4Qh3+CmFYIQoZ1lwo42yDoht4nKUl3L4LwImuAL
         ygOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793294413; x=1793899213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DcHId9d7ZivTlUPflcKuYmygXozfLhAN5Qcceh+SBys=;
        b=gZB6WO2LTf6atnCuD8jG/IR+393H0XXTlTARxVLrgFnWaINqrd8wzidai69vIHk7B0
         eDAxtYvWuWm1BRM7r1ZQ4DCFsSvWyJG1hhaeJY/qyCBT0dkviEX4l7oGzvHxwVeMLWKO
         dYbEz/UXL5uyiPvMnUo9GWRlWxDUo0wLVaNKxODuzUVJjnl7w760/E8tZZToYsjmAdzz
         sh4PrnWXxlZKoJzCx9JRwpmvL87m+nhrpFZlqViETnyhDsofFSerddkby2IFa7E5hvZ6
         7G3/uvFJB6tMAA4PmOA6H/Mn7SttYaulchAQF48LNuICoZMx+/vRt9Nr7VPyBWGdMkdD
         sDGw==
X-Forwarded-Encrypted: i=1; AKwUvBxOeXMyga+mMQSoHxWbhOQmoLqBBs02sA5z2Io74yrCkpeNAQa+WHITjDztjy8m3o6ACOSXwffPdxsiK1c=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJu3Z1cbIO0duQ+uf/Py6j8s1E2az8joqsZk3BKSnANYSEEWoqL
	U0vmpNgk+FCo9jEBfN4+/ds5qXkjGA6fM8i9KuZIHpz29TzWg1lK1Bb39yM4cElBs1Hym9QBbs8
	vUWubfrp2xeB+E/enSG1oqqtmUm3Aw7w=
X-Gm-Gg: AYBFou3zos1pplAZL5IDXEPA1FY7kALrLdIb3oAvE/rrc2ggme6bP356+BTadNJkS4S
	TH7zKaGemlctNWq4jz7JdBqTqsvwKhq1r/RdeefqNnb9moROeVuPem8axcKePUKg0qXuAZl7H+j
	H+f5ysJF11KdwrV1RlRJVW1hjbtqvIrwyBkSX6C0oRlPi+tfMSATPRcxPwb1fPQrMzoXApYa8+I
	q9R3bbptvjDXZgjhb8VM48Cl2uXwu4/ecp9ipBHg9MqiK2ybZS+9V7zmySab5a36r9J6U3DRbAC
	a7A5dYCn9Kv6BNWS1exLAf13oiWgvxCplTr6rFxHbzEwA8LjJtPfoRwrkPm6/9Lkid50p5CxyUU
	9MYq8tfBrGvyeBHrcn0UY742klR6Q8gvW8Hkestrux+FjO0DlqrvhtoFIqv6Odi1MH47OXzYzMh
	POzksstJSU5H421NOe7h01uw5Wu4KjH8i1M0bjLVoD/AzxgGp6O21CWDq8FjiBaNqEk3UVlDB8M
	RZ8+OfgB1w84fIoCF8s54A/KW0OuQ==
X-Received: by 2002:aa7:c1d1:0:b0:6b4:201f:17db with SMTP id
 4fb4d7f45d1cf-6b49cbdfd84mr3081067a12.18.1793294412721; Thu, 29 Oct 2026
 10:20:12 -0700 (PDT)
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
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com> <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local>
In-Reply-To: <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 11:19:59 -0600
X-Gm-Features: AclHuK-0pW6JI4DxQzs96I_p0R94o9xpuy7K0elsSNWPWKpDy78P7tTWYrgR_Gg
Message-ID: <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] serial: 8250: retain DMA resources when
 termination fails
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Raul E Rangel <rrangel@chromium.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Tony Lindgren <tony@atomide.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Timur Tabi <timur@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 8:24=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 29, 2026 at 01:37:02AM -0600, James Hilliard wrote:
> > serial8250_release_dma() ignores the return from dmaengine_terminate_sy=
nc()
> > before freeing the coherent RX buffer, unmapping the TX FIFO and releas=
ing
> > the channels. If the provider fails to stop a channel, the DMAengine
> > wrapper returns the error without synchronizing its callbacks. Hardware
> > or a detached callback can then access the released storage and state.
> >
> > Checking the error and returning early would not preserve their lifetim=
e:
> > serial core frees the TX FIFO after the driver's shutdown callback retu=
rns,
> > and port removal can then release the callback context as well.
> >
> > Require successful synchronous termination of both channels before
> > releasing any DMA resources. Retry failed channels after a sleep outsid=
e
> > the port lock, leaving channels that have already stopped and drained
> > alone. Keep the shutdown gate and storage reservation in place througho=
ut
> > the retries.
> >
> > A permanently failed DMA engine blocks close or removal. This deliberat=
ely
> > retains the buffers, mappings, channels and callback context until the
> > provider can establish that they are no longer in use.
>
> ...
>
> > +     while (rx_ret || tx_ret) {
> > +             dev_err_ratelimited(p->port.dev,
> > +                                 "DMA termination failed: RX %d, TX %d=
; retrying\n",
> > +                                 rx_ret, tx_ret);
>
> > +             msleep(100);
>
> Huh?!
>
> > +             if (rx_ret)
> > +                     rx_ret =3D dmaengine_terminate_sync(dma->rxchan);
> > +             if (tx_ret)
> > +                     tx_ret =3D dmaengine_terminate_sync(dma->txchan);
> > +     }
>
> This is unacceptable. Sleeping is okay, but value should really match the
> baudspeed and other parameters of the transfer.

This sleep is backoff after dmaengine_terminate_sync() has returned
an error, rather than an estimate of UART transmission time. Each
retry asks the provider to stop the channel again; elapsed time is
never treated as evidence that the resources are safe to free.

The particular 100 ms interval has no hardware-derived justification.
However, I don't yet see a sound way to derive the retry cadence from
baud rate either. RX can be waiting for input, TX can be held by flow
control, and callback retirement is a separate requirement from
moving bytes through the UART.

Do you have a particular provider failure mode in mind where retrying
termination should follow the serial transfer timing? I'd like to
base the interval on the condition that can make termination succeed,
rather than substitute a wire-time estimate for an arbitrary delay.

Regardless of the retry interval, shutdown cannot release the buffers
until the provider establishes that DMA and its callbacks have stopped.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

