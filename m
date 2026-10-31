Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83825606A31D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 31 Oct 2026 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RuYMTYLN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jH5PL5FhBz2y2R;
	Sun, 01 Nov 2026 05:01:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e29" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793469670;
	cv=pass; b=IkwT4WFlhhTq6NFnKxlv5FQJ0Yp17zpj2Tl3CVVmrzv7ScuewIL7XlmtE2P4/kFNnKPjXTplIiE2w6JjVUflbyg/CY+3oKzjUH3RxmbKetWKv/MeAKe3URhyjA2c1eOCuKeVuDqYyUwtDLHuBD1z540qE6/VScrqKwqvSdLv0xDjgO4bvgRvMY9nBvF2WhzfUCYsxzTsN9WY88Z2kTe45hfWalqXVFRkjVBnbS7W2gB1ROZbVV3ETybNgz+eERPFcFsFjb8EqwgbShXU/dmbysjff/b+p7EKsGV5ic4OCcC1KPi9iz4sV9oHs9ecG/mSuKiwYJLl0kSgt5wlVrzbSw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793469670; c=relaxed/relaxed;
	bh=ztiV5c0DfuFx8uDKCLiUp5o+ivOB8cWRN0pJNXnNfZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsLuxRhNGuRzMZF2l9kIOmM8iiW+VdYbPErp7agfLmovgSFDMqpYGy2pqNb3FDGiz/2cTQsGQSnd4jjcAgrNQRHEfwBpDT8sfu4K4pK9kA8vd3ayJ7RlFDCkXvRtW4qKnIR7w8nNKy/ofRvGG69B9XlQWwndFEGgGfYJkJvUlZFsWaqGPE05/ZenMFZStJaNE1i8eOLYM+M8IyDVDF7DTyXK00OnxkZLAhSbY142D/9t7Zpu3pordosk0Y+rp9hb1qLpxUjtLKHzbt1+5LjgdpocGlyXmbM1jyvD+iD+5e2tYWUcGnx7r6EalLnIdQRQNIFs+rFrZI5dmScsA8u2dw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RuYMTYLN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e29; helo=mail-vs1-xe29.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RuYMTYLN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e29; helo=mail-vs1-xe29.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jH5PJ4SqTz2xln
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 05:01:07 +1100 (AEDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-7ccae9f1a9eso973804137.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 11:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793469664; cv=none;
        d=google.com; s=arc-20260327;
        b=DQEChZgRCf501Jab9VudNL+2RJ/ePGCw9akaxweCinGFRsVP7nmC2X5scNcvlmZE5m
         o9R+Olqeqzjv4n9MbnqHP16f0XWuigxsIjfm3/zJgjoMNKAUJbJicCr9EF4a0mbMNOF/
         iTeQ9XtYncAFfu5Ts/dZZkic4FCDlMF0J8rxb01y8i++xq7pdIvDEHdKBNTL3uU4Ap3Z
         4YcnN4WJiwFkeySvHq6cABzQ7wnB4BVCM+QdRI4dXSaedw+yUn3MkIWFxXz+plTnU1U+
         Rw+xp8ndH4w3l1fFwlX7Hx9dK5OgIRoxSlXuQ8pO/FlDASPc3b/Qz/9+UXLQDdmggGfv
         mVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ztiV5c0DfuFx8uDKCLiUp5o+ivOB8cWRN0pJNXnNfZU=;
        fh=9vytwhclP6VW0o97ZWXNUyJM4ERYndFuplx9QRDLVm0=;
        b=VAG/VD8Cgvms287Rloe6M5CW8Rbphx2q92FB5T/HXomYZwCNCaKeXGkgQdCjETcyxv
         DxShRu/t5G0L2hjLjnntwBhP23yUqos/QpTKbHPLGNM1M+4jhm1e1DPx4qZJb59y5tG8
         OkATTdc+B3N/H9t8F/FxJBAnJPeKMt2c3IswDWHb/VA+gF1AsCP/4FfV6QcCEN3bxEkn
         0zxvau8BVrqF+kxhG3Ak5Rh0O+p0/+UGcQmb7dVAx+PUEpGd4rDfEpksUBJhK3+IXMwg
         LDrdVAzAHn6R3NgbMkyKE0SOPO7hkWRaHPoOq6bB7DYjGbq4vxilYOaePxhdfRQEo2YG
         ITLg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793469664; x=1794074464; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ztiV5c0DfuFx8uDKCLiUp5o+ivOB8cWRN0pJNXnNfZU=;
        b=RuYMTYLN7ZKP0h7SstsCpG0XddD+gFKosJTFeSuz6TFlOPm2MrC0lIjXEkm5C/lJ5Z
         zMTXqsFdq7WGj3k/7e2c0kXBx3fH91zSXXOYF5vu+5nu1VFsNz8BvxDxGkJmH72ShP/v
         GaPHmlgQthg0EoVNRyXsICubjFHcawWFSm7Xyx7qWhyRdFcdyAQLp855AsjIFcA/U07j
         Y+aWM/Z+0d13FgeB/VqAGKIB0CGFyKz/gUvuvyzrELzLHWWj/cE+X5EZf/EtFde86uBP
         pt5kRCw3xFemhJGTyvY7G0Tjkr6cNn+vn+ovRAEzuDn5xwHfiUIUbxr2OnKXUTMPEJFf
         mmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793469664; x=1794074464;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ztiV5c0DfuFx8uDKCLiUp5o+ivOB8cWRN0pJNXnNfZU=;
        b=utCkCqU1OCztWVQqHeyFO1QKq5ver6XoGqs/HPCXPbbMJ3V7mnrTcYjck7sr6W9Y8d
         n/nSHOIBg3T+cvqKdSmr1uaSsi5+cJ1BAK3Eckf7UZZw8Y/qhXQtR2fSUh8qRAjx8kP8
         Xb4XKSb+5uDnU3ZR9ILug3/h3OeD1KJjGNvfJwjKCsxKNA6fGtVMBflN2kDkxVd7Aom0
         vrRt7uEeZ5+nlfT8TXFfhoQCPDKZW7P2cvwg8yzGC7aMrHirCYKlKHNPgiPbK8Yrtqhl
         3jSrPJhN8kAIrFju0nDUknUhpy4QHV+K47Xft4emVtlA6ANo0KR0bJR6Pp2rVGzOhK0o
         KcYQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmVQMzfS2G04bzwQl8OXfvT4p6RxsMdTS8ZxLpy+iYbvYx984YonN6Z8bRPM3y7y9dEKNU+Lt+2F97bII=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL6nD9lHIVQCd92JhC928i6Y51HU+E8D7tRccOm/Cek5zXxe/A6
	gPkoZC1yhaLK2j9/uD38KH+kXiRm8uff155XxOs1HhdBK40HRNm/8vYOq5yMYkwZPZlKRJAwFdd
	TM0+tdUjwUiObyYMp55a6RMu2UcEnRBg=
X-Gm-Gg: AYBFou0F07pW93FQLSe7YKT9M2mGAUpPaTyKGnnG7XIGOhto92rgI/HFUUkvxtb6UkD
	cub8C3ZNtNK7ev9xwrWPrTHMkurzlhpTL/rE4SiO5hLn2d4jQ3zZuK8mtRAru/cInw48wyIyxim
	5Cq1zkGzv2ls0Rqkm5YepidioueMvAJPdSCZCsNzOfal7aBUJYx+m7QjfqB5AgA72sN7/hu4wCW
	w2s+AXohzhjDee1v8nj72EfU4KSFdzXkwF9uoWXDQBwVvDgKi3LUHhCYC7PjHmeh/tCOINFL+c+
	/NpYisb3WPSIf+Z9tfniIBmb1khMNLO9AGn31akPeAX1bWiteMsa4JigyxS3QVu9FzbLak3fFRl
	RveWQQqXjGS37MWaBpWAfXrIPcQmAnF+7lkwqE5AYHKzo8/1SnXN7v5jfs/e4e9N26wbAjqzsSO
	SzUuw+9qV0c8c6cPWz01uLd2tzlg8A0uBxvcN5jNaqI9hO1FlExyfDUeNbSw4MIcNACsB0NW8Fi
	JQC9Ne+80CQyvbyUPjeKrMXmK+jWQ==
X-Received: by 2002:a05:6102:c4f:b0:7cc:3eb0:6ece with SMTP id
 ada2fe7eead31-7d072d53fa3mr3076240137.33.1793469664332; Sat, 31 Oct 2026
 11:01:04 -0700 (PDT)
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
 <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com>
 <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local> <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
 <auRl9ztbav4nHi7U@ashevche-desk.local> <CADvTj4p8tjwdftg+H11ob0iaBZKxXrTdkSmhfZHjOYunm5tr9w@mail.gmail.com>
 <auTZtteCFnuoMD3p@ashevche-desk.local> <CADvTj4rXXAEnTyu_AzpF41a2YSHHG1ANozCUSePBoH3QZYbBQg@mail.gmail.com>
 <auWqUIBUs0_7bnGU@ashevche-desk.local>
In-Reply-To: <auWqUIBUs0_7bnGU@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 31 Oct 2026 12:00:51 -0600
X-Gm-Features: AclHuK8CrIpMhatn91Js9Zu09dawz3gtrtGWd_ctbAp5jI12V9IMTbfHBekYVDc
Message-ID: <CADvTj4rej-zOtwwN8CtchQ8A9L-fdG0dL_XwBb0zTFv5m=+j4Q@mail.gmail.com>
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 31, 2026 at 2:44=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 30, 2026 at 12:08:52PM -0600, James Hilliard wrote:
> > On Fri, Oct 30, 2026 at 11:54=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Oct 30, 2026 at 11:09:53AM -0600, James Hilliard wrote:
> > > > On Fri, Oct 30, 2026 at 3:40=E2=80=AFAM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, Oct 29, 2026 at 11:19:59AM -0600, James Hilliard wrote:
> > > > > > On Thu, Oct 29, 2026 at 8:24=E2=80=AFAM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Thu, Oct 29, 2026 at 01:37:02AM -0600, James Hilliard wrot=
e:
>
> ...
>
> > > > > > > > +     while (rx_ret || tx_ret) {
> > > > > > > > +             dev_err_ratelimited(p->port.dev,
> > > > > > > > +                                 "DMA termination failed: =
RX %d, TX %d; retrying\n",
> > > > > > > > +                                 rx_ret, tx_ret);
> > > > > > >
> > > > > > > > +             msleep(100);
> > > > > > >
> > > > > > > Huh?!
> > > > > > >
> > > > > > > > +             if (rx_ret)
> > > > > > > > +                     rx_ret =3D dmaengine_terminate_sync(d=
ma->rxchan);
> > > > > > > > +             if (tx_ret)
> > > > > > > > +                     tx_ret =3D dmaengine_terminate_sync(d=
ma->txchan);
> > > > > > > > +     }
> > > > > > >
> > > > > > > This is unacceptable. Sleeping is okay, but value should real=
ly match the
> > > > > > > baudspeed and other parameters of the transfer.
> > > > > >
> > > > > > This sleep is backoff after dmaengine_terminate_sync() has retu=
rned
> > > > > > an error, rather than an estimate of UART transmission time. Ea=
ch
> > > > > > retry asks the provider to stop the channel again; elapsed time=
 is
> > > > > > never treated as evidence that the resources are safe to free.
> > > > > >
> > > > > > The particular 100 ms interval has no hardware-derived justific=
ation.
> > > > > > However, I don't yet see a sound way to derive the retry cadenc=
e from
> > > > > > baud rate either. RX can be waiting for input, TX can be held b=
y flow
> > > > > > control, and callback retirement is a separate requirement from
> > > > > > moving bytes through the UART.
> > > > > >
> > > > > > Do you have a particular provider failure mode in mind where re=
trying
> > > > > > termination should follow the serial transfer timing? I'd like =
to
> > > > > > base the interval on the condition that can make termination su=
cceed,
> > > > > > rather than substitute a wire-time estimate for an arbitrary de=
lay.
> > > > >
> > > > > Termination of DMA sometimes require to clean up internal FIFOs a=
nd other state
> > > > > machines. That's what happens on HW side. In the software waiting=
 for too much
> > > > > may lead to the very big undesired latencies. The value of 100ms =
sounds insane
> > > > > to me for the HSUART cases (megabaud range of speed). Also note, =
not every PCB
> > > > > design uses HW flow control, so this may be even worse for them.
> > > >
> > > > The 100 ms interval can add unnecessary teardown latency if a faile=
d
> > > > termination becomes retryable much sooner. There is no hardware-der=
ived
> > > > justification for that particular value.
> > > >
> > > > The FIFO/state-machine draining is part of the provider's stop sequ=
ence.
> > > > For example, DW performs its FIFO-empty polling inside
> > > > dwc_terminate_all(). If termination succeeds, this patch proceeds w=
ithout
> > > > the retry sleep, regardless of baud rate. The sleep is only reached
> > > > after an error during DMA release, not during normal RX delivery.
> > > >
> > > > Baud rate can influence how quickly a transmit FIFO drains, even wi=
thout
> > > > flow control. However, the termination error does not tell 8250 whe=
ther
> > > > that drain is still progressing, how much remains, or whether the
> > > > controller needs a different recovery operation. That distinction m=
atters
> > > > when choosing a retry interval: a shorter interval reduces the adde=
d
> > > > latency, but does not establish that retrying can recover the chann=
el.
> > > >
> > > > There is also a specific API detail here: dmaengine_terminate_sync(=
)
> > > > returns immediately if device_terminate_all() fails, without reachi=
ng
> > > > dmaengine_synchronize(). Consequently, an error leaves callback dra=
ining
> > > > unconfirmed as well. The retry cadence can change, but resource rel=
ease
> > > > still requires successful termination and synchronization.
> > >
> > > Most likely this is AI slop. I can't see the justification for 100ms.
> > > Can you explain that?
> >
> > 100 ms was an arbitrary backoff to avoid a tight retry loop if
> > termination keeps failing. It was not derived from the baud rate,
> > FIFO depth, or a DMA provider's recovery timing.
> >
> > That motivation explains sleeping between retries, but not choosing
> > 100 ms. I don't have evidence supporting that particular interval.
>
> Yep. And that's what my point is about. Any big sleeps has to be explaine=
d
> and justified.

100 ms was an arbitrary backoff for what I expected to be a rarely
exercised termination-error path. It avoids a tight retry loop, but
neither that nor the expected rarity justifies the particular value.
Successful termination on the first attempt adds no retry delay.

The constraint is that failed termination does not establish that DMA
and its callbacks have stopped. Returning from the current shutdown path
would let the serial core free the TX buffer while DMA might still own
it. Retrying preserves that ownership, but a permanently failing provider
can block shutdown indefinitely.

Would you suggest a different approach to handling termination failure
here, or a better basis for choosing the retry interval?

>
> > > > > > Regardless of the retry interval, shutdown cannot release the b=
uffers
> > > > > > until the provider establishes that DMA and its callbacks have =
stopped.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

