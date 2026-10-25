Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C608606A31B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Oct 2026 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OFwuyaSa
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCQjN4FVJz2xfK;
	Mon, 26 Oct 2026 05:47:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e2b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792954040;
	cv=pass; b=SC+5IT2LtOKoDBZQiX2qlkLhwRycvC0M4dcSURjymFpqsVBmktUSbPBoEmQ0rhjLflrdrX8MCkasbHY3EFA01xoOb42zoTO0yH/u4dlfKbfxSHcthGCZQjpHBrVvrRErvPWQz4zjNfey6+5cunGQCyMvbJ/lpfKhBo09eYcoZ1rxx5vSUCl11RoFYA4wGfKfNoZOVy+w3v8sDvqoNFu9/CifSmk0lfLwGfEwe0Z/ubmSpmCUwCeHf8YamY++xWahFM5uHnq4jCMt7dvPLXebgX0QGpms93nKDl0qBViS4IObunc9NVcAaHE0Tl+01KKthOrY9qh99re6Ce5qNo2Pvg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792954040; c=relaxed/relaxed;
	bh=cd/Rf0PmOsf9SbzCT228kopwmzuVCMtn/HtZcsjTHHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJleuKeyqoXAR4cCcL/vyW+RAjieHp9gKWTecIPjCvqJdh+a5/JjeGTNSLMPgsy7xYlTUqNXvLRwi/37odZEYuQp5meJziuP94199QK5u76IORH3mpdfOWvUp/oMGvdfXbpCXnZzx70T4hD/sVdvYqGxSLvIGyf8cSAwjbCuGigNb6XKZ7vpdwwnjo+WdwyfzsUehDpoAeByJOl8HKWhwH5UEelc8kJgl/8sBxvwrIg+Pe3jJV4s3B7GLtPemhH9eG1Vvxxeo+BA7JQHX29Jt8PnlPZ6QtCzLGORZkog1u61wCk9U7CXzKwBA+BHoajNm3WVOVzs95EGkvnpYjUAiA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OFwuyaSa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e2b; helo=mail-vs1-xe2b.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OFwuyaSa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e2b; helo=mail-vs1-xe2b.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCQjM4Ws2z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 05:47:19 +1100 (AEDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-7ce78f9d6baso333204137.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Oct 2026 11:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792954036; cv=none;
        d=google.com; s=arc-20260327;
        b=UVpdIPq8J/0cSrIU5pXKHqJMDuiR4G1BsFNTM00kahmsCnH6rsmZPa7jPC9x+UnibO
         4XMczp4MfmaXfK6fnRqfuhT4qERUOTX1JHQhpVq4DpltFrlWWMZNYz71Za1xB2hfvMUc
         eMMKyg8lymsJfTRcNAH3xYzD+5aOxtGP7TCKd/bySrQ0Ch51u7HH0CYkRRmnifGAXKpF
         30OASXp6FAnIPKCH15LKNlthohVWDj4XZ2nDKJEgNnR0nxQLuk6PRlrMvqPshkXuBMjQ
         p9t2nhZwp3blTzy+8vcHGq9PZVjKkBA4QCeW5cXiJxlE3W6LkGOZ0OPug4IPNx5yLjKy
         YRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cd/Rf0PmOsf9SbzCT228kopwmzuVCMtn/HtZcsjTHHw=;
        fh=IKc2JiLrjNuwYv2S5Sk58Wf3rAUCz1YNgDve3OjbYg0=;
        b=FaSixjtrAbSXytrfiwQJpvVFq37gdAwP0V9v2/frn9vondn3gyh8iCxdw9vuIlqU7c
         Jgu2zVhF+mhmIbIke0+p3cImSJFgBekTdJWYOeRiXb69gL5Jdc7DGoXqhMAmv4f5rVIp
         L2bFJUmXMYYZg/H8QsJYbV4bHe3ZLsMsAglqfOThGlOEB0tmgZNZdnVwgCys2gl0O8U3
         WLUYlr2z2KWAz1i/NSDQb7QQwqsWkybBdK33AP0nUByeRZCV/O14Eoyo/El1kxrlkCci
         /QsrAPZtRYtvH4C3yYpPr/DeEeRbfSvCwzNdAxjBjabtWCiHWB5BU1dEtzwGLlytd1jL
         i8wg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792954036; x=1793558836; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cd/Rf0PmOsf9SbzCT228kopwmzuVCMtn/HtZcsjTHHw=;
        b=OFwuyaSal7aAd4CAlq0K7gAy+yPASiG+OylkfCqhoNFOohjmVJG0eo4BgjAD2W5BNH
         hQRek79MzBlYYFnFFb0CXUm1HLri/ge+QADa+WNW8lFQc1CE/SMclMkdz34/g3N+wa3W
         gqdhqCmNF0yeesnDH568CqgfBd7A9YRyC4YsJ0V9BrRft5GJmmw+RXLatCJQFiuifA42
         G+kqUJvbTKWogs7rDE28lafdHgJ+UbSFsU0CiCtCo22xKN16hCgpTlfW8h/GuxHVO8OW
         tm8gfioxX1j7yYaKzUjtZsh36dSj/tawwHfdDymy+JieuXW2R6DIBWkp/mPHp/T5LcrK
         PkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792954036; x=1793558836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cd/Rf0PmOsf9SbzCT228kopwmzuVCMtn/HtZcsjTHHw=;
        b=Dg/3/zD0rdpY+siDJBF5gDDCiqEv/k3Kph50zS33e8c+BuVdm4MeKQ8sjU/4u5A6Dj
         EHOsfeCFjBO9li7mi0hCEKrmkS78STq8miTjJowRJ0YbSoh7gBf6u//mzoxwLBwPJPD7
         +0xKvAVKy11X+HDXGrl5YtQq5T6OzpuI4ksdyO/BdL+U8IASRCV00RWdZGao+xjOBCLI
         BEAe7yT8ue1Nq18dEQDa8BXdseOsKY+hsIcB3FvuXkXemw1/oFUfD/BrkpZnmY92MOSD
         xRWMdn6zUPDBOhuBPLy0MS8sVHp4O6/CEOmVJPYPHjHn/Ndx5MVRJL8OcBuhFsemvQeA
         hs2w==
X-Forwarded-Encrypted: i=1; AKwUvByWK7lIqtmm1q/X/sY9PAm3PzT1o4zFBW4JroOf66OhJfGf+blULYrbGQGdbhurzQcmqcciYfwjGVVl1A8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLRBeaNCxfHpV+4SNJ1grh8Ha9nUjsttbSN6Xf+rgJKDB991gY1
	iR50o7hUoM0OMFQo4kqyvqJ+9nfCunMeA11ed7RrYJyx9fl28jHaZU7qM6fJ0UI7Uqj04RivKxm
	52366RTYwvT68O1NdWL+E1g2FWf3Hibs=
X-Gm-Gg: AYBFou2VLw41qRmyIdBT0wn2JvwmtAn6ZbYzFCuPgrL8gGQoU4A19uEpFhSQaMqV2ES
	b7Muxa1tXIDHXczB9uCHIIJH3YJd8aQXMm300ndeft01khfkksYeAGSxCxFJx6Q9xglS99A7vN6
	xxMNTa0nKOgczIDYtJPyNmaoCz6NNdpFohYtulYyF3671129MCpn5QPc6dfugs3vYNofb2q/MjN
	3Q4zoC/uCwgklSDkk7fPpvzFyR9fpTOIOmqsGzuTf2NjzgsRRQ/R0tIyJapjbnJMWu7lNIC/CmD
	b6Lm+u6q/N5b3pAYCP12RR2ulPToXOoymFF28YaETKADU5semRkoMPpMI5CXmow89Zlc2fX6rap
	5evP125xidebw33PBqauuo+OzeMJdAFNAV3+o9LkacR+xO1crfnxbFi5QZuQVWlPims+BhNHFDO
	MM4y0TDN/nrnyFNFLGAvlVtkzb/aE0qDyhB31p+GtsHNdb6PNDyK5XDK+ovWVoIIbIQCh4Ps0Oy
	xxA5U35M9qTPakKKNNlVvlfHB9brA==
X-Received: by 2002:a05:6102:b04:b0:7b5:8fd9:27e9 with SMTP id
 ada2fe7eead31-7ce5d005cd0mr1043722137.2.1792954035832; Sun, 25 Oct 2026
 11:47:15 -0700 (PDT)
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
 <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com> <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 25 Oct 2026 12:47:05 -0600
X-Gm-Features: AclHuK8RfnuoMKUL7_ChiQcwJjtxWWikUNjoVOQNx_xye2F4G1UoFeQQYjFC0tc
Message-ID: <CADvTj4ryYd91LYMCktJ6a8=ygm0BG6dd4ZyK6XByaVcWvFTvkw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Raul E Rangel <rrangel@chromium.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 24, 2026 at 11:10=E2=80=AFPM Maciej W. Rozycki <macro@orcam.me.=
uk> wrote:
>
> On Sat, 24 Oct 2026, James Hilliard wrote:
>
> > uart_write_wakeup() expects the UART port lock to be held. Several work=
er,
> > DMA completion and interrupt paths call it without that lock, including
> > indirect calls from uart_handle_cts_change() and the transmit helpers.
>
>  Fair enough, and thank you for the cleanup and spotting the issue in the
> first place, however...
>
> > diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1=
250-duart.c
> > index b4e1b90e5960..b15f76acd06b 100644
> > --- a/drivers/tty/serial/sb1250-duart.c
> > +++ b/drivers/tty/serial/sb1250-duart.c
> > @@ -454,10 +454,12 @@ static irqreturn_t sbd_interrupt(int irq, void *d=
ev_id)
> >
> >               if (intstat & M_DUART_ISR_RX)
> >                       sbd_receive_chars(sport);
> > -             if (intstat & M_DUART_ISR_IN)
> > -                     sbd_status_handle(sport);
> > -             if (intstat & M_DUART_ISR_TX)
> > -                     sbd_transmit_chars(sport);
> > +             scoped_guard(uart_port_lock_irqsave, uport) {
> > +                     if (intstat & M_DUART_ISR_IN)
> > +                             sbd_status_handle(sport);
> > +                     if (intstat & M_DUART_ISR_TX)
> > +                             sbd_transmit_chars(sport);
> > +             }
>
> ... why do you think the whole functions need to be called with the lock
> held while they may or may not call the handlers in question even?

For sbd_transmit_chars(), locking only uart_write_wakeup() would leave the
empty-FIFO decision and TX interrupt masking racing with start_tx(). A
writer could queue data and enable TX after the empty check, then the
interrupt handler disables TX interrupts and leaves that output stalled.

The same lock protects x_char handling and FIFO consumption against
concurrent updates and flushing. These races predate this series, but
wakeup-only locking would leave them unresolved. I'd keep the complete TX
operation locked; each invocation sends at most one character without a
FIFO-drain wait.

> I
> think we should avoid excessive locking where possible to avoid holding
> execution elsewhere unnecessarily, shouldn't we?

For sbd_status_handle(), I'd read and filter the change status first, take
the lock around the CTS/DSR updates, and release it before waking
modem-status waiters.

I'd also move the TX lock into sbd_transmit_chars(), so RX-only interrupts
don't acquire it. That means two acquisitions when both status and TX need
servicing, in exchange for narrower critical sections.

>
>   Maciej
>

