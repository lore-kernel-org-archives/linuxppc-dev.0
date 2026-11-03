Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE87C606A31B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RCUPSDpJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJxcF3h7rz2xdX;
	Wed, 04 Nov 2026 05:17:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::a35" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793729821;
	cv=pass; b=ZYBeIPVxLT1/Of83d9zu1CL5osVntsmvga99hzpPapZKf2zuWFdKcCgrN8UUuVHKiTO6XwszXEiXXJgoXESznblbXOxc3wdy/dvLK3RGHcwZMecuVJ/59s10obs0v7Kr8FihXkglIevGpWjpsEuSrdw0dLQARPzewViinDuTn3KAvULn3EgaD4nswLW6x3CTtgR0tZYbUKHxTeX380eAYoGme7NGCrflULNQHi7Z8Q8iw9zSeovwp9IQGBEoG5aUQ8GJA0dwwJ6wx9gJ9jOC1/B6UxGpKBo4AEXlXOwyLWXS48vgHZpKavb18zX+cKAsoLf9pVXDxedUQA7mFh+poA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793729821; c=relaxed/relaxed;
	bh=bbvyH8U6X8W+XhLMtftlLqtY3X/eIGXG9T4SZ8xrjfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbrzml4bkjqXk4WFitzP5EamMaXqkZ17z7noXzYyMUDdR21rkH7vYK1iC0WAMnZ/jeE5JqYMkuwX46qJNpY1gTvs/PRZ9wvRjBjIRg/2SVvNPl8Kh+XsnCI/XqGqLrdKadZcC2fM9n4wjWhecb728f4fJQRcz1/3ZHoD0vvOGKGkdya7E2Yqf7Pyy0BC1LNBh0RoMeLjH7D+GEokOANCqQeJbPgqmDc0S5j/kl93ZCoHbHJe35BBJeaJG/rm+ZJ+96qwnCZ/gOXdmnNnrouVcA/+XWrwLoVWzFUv1uiOCcijR2XLjrXKxmR9pHS8FjKS61KQSVoGMID8NJeDKQ7T3w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RCUPSDpJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::a35; helo=mail-vk1-xa35.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RCUPSDpJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::a35; helo=mail-vk1-xa35.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJxcD3c3Nz2xSZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 05:17:00 +1100 (AEDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so3547609e0c.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 10:17:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793729817; cv=none;
        d=google.com; s=arc-20260327;
        b=Ax8sbREOnwCgLvBhFjX+dT0msmszSyN8MLHaEZ2DzgXUDysWc01ONJqn4/sFE3C0Kn
         8TDHLGZq7c8Ux9IkPGXoYFqfvki0dyuXzEC36BpMT9jFPNglzQ5vMrujbozWWt4sj1AL
         6/USHABIhdKtmdboNbidevTRK1umqd6i/8u2WD1QMbzRWN7C3mkQ5ePzNdGa5RtWLBnL
         HBhsrM77DQmMOE3SiisOD8GMQoBt8onUVbXpTvgWeHus0Pbt+KFX/VD8mVYpWa8xZumL
         c5WTEEuWElvaNyp/I/ERLYCeEuR0oEBuclb6PxlQHynpzFZ63a2XvXsj1kHhpsVcu/Tc
         XKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bbvyH8U6X8W+XhLMtftlLqtY3X/eIGXG9T4SZ8xrjfM=;
        fh=IxQMKP7wEuNBbZTGLwfg6BUN3WzGT3ff4LAWOH+0R/I=;
        b=d1h/CMTL9nEodVf/hrKB9wdC5gbU3g2CzsGmJ84b7YPueWQj21Nz/Pyi/YUkFgpuuS
         ncI5McpJbxTi8BsvS0gC+ubsFBOq9JWkAeo7ugkWD/P6KwpVeifu8USsTxi//3LPzvY2
         L3iCsFsScXWM2vlf4R+EOajn7nL/1vL1NkqWp9qrxBKir3RXc2LQdMXTIJ7TxmPTz/61
         +HiWcipo7BO9oJUT9P9YRarO+6fpHf+YX3LsIzgwM/190OudfVtiJ/O30Tr4ItxpV8fl
         HtsL9JEU+ntB0Wzkjdo7XRDNshABOXzfdS27BtW2bBL20BdZ1MX+O5n+2/oqmLbo53ew
         pFtQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793729817; x=1794334617; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bbvyH8U6X8W+XhLMtftlLqtY3X/eIGXG9T4SZ8xrjfM=;
        b=RCUPSDpJNsAcKTDmPchpEFRZ1ojqLLtdJ66TrP0qvXXsRpZ7It3mFNrfxL3XF/VDER
         ExKKEkirPmUCTGpuuETlO4Hsz29iSJBIMd2g+DicPtO4fTo2MkLeMRn0G5/WdcrPOzf9
         hDq/CzpRv8IAzuI5GM4V7LsLjYyPBnrcMiuj0sJvzB9rQ8+I/4MKrdpNdxDdGMBy5r3U
         iEwkGeQnJWVOjmZ4UjtR60PrpevQTUPggL3z98Zu6jcNmBmJEB1V9eqVM1utW/NISMHP
         +F29R3e5XurK7hKZCORrcjEHQQcTMr3xG1JQT5wxQm3qcXQrze6PczfaurVn7lDCdMtA
         6kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729817; x=1794334617;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bbvyH8U6X8W+XhLMtftlLqtY3X/eIGXG9T4SZ8xrjfM=;
        b=Hrkqh/1p9652hadHIkwvXfPXlKo8KlZyef09V5OS4btnZ3sGnKG+Wva4yDF6C9W2OB
         xpq8wV3JZ/kSl6pYlYdHDgNiOyZZBJ06SLw/sIAaTgd13UI0gaS5RgZEonFkLkyXZVN0
         spXG7lfft8YzYbaxjwULoAogloc1Y04PHqWiHbSUNF65iGFw5knWRsqPwKm3HSoDlHOe
         9jbJdiLnONV1/wJbcXCmCq+90pT6iYh6fI3fQyVDqI/ZnlhqeyV9e5Q8GZmjTSTL1TJ3
         6ILvffdxn8xpFBGHHUCaBD6IfihHeJbdAsVSret2V8je//dDgr3laBrNWE0qJyOLJF9b
         iMXA==
X-Forwarded-Encrypted: i=1; AKwUvBzleAW25AdkDdhrLJ+tY8hJAD88o1COzzdQ1t7c9s3a1KzzuJ+sZJLc0ozED4Jpa/S5JANZ4cw/NM19cYU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+1Rw42KsMTKwkBj1jdq5zkS5tt2DkaLvCQesecJhF5Xwth1LGK
	Ezg8eETtiWUYyLCR3cBbW9Z/s7RW7rJVuH0rcWk8DzpPjBRYe4iPXao05m3bw4ALzEtSKVVVlo1
	S0KVvKzTU0itnijSkz6/MaO5p11h2+Qg=
X-Gm-Gg: AYBFou1iHPvKwk8WeucE+kmTTxTsP/MtFj9KZUokfraQJu3ynoBEauQfOo+wY/Um2sJ
	TRBIxdv2Vq2Fpq0Dp70aP8pqmgXutnAXu6aYrw/trcsSrBnLgxVmOYRrBx7q0RbtoGY70TggGM4
	r/9MaTFzDmOGdaGkVMbydH+TibtT/o5IbJElAYdJLBidulTsYgzjHJ2nmUObUP/F2D1trZZHAbD
	kjYbo8332elbYEd19Rp9DZtMVyX5nLEhq92/AiqoqBPjtxAmHq0qpynnOYQuxZl2SpIplhrXtnC
	e8AHUqWR2UeZxAowe+Lm2mElpT86817ZUptHBfn8WcO6T7or3Gb8xlmIX4nzjTUSGj++mpvgJhz
	8LqnlN6NUl2riGU8xiv6LYhjRJvyQnvIIxG99VYzD0+r4YbYTUqfPMyhaosWDwFXMwbCIUa46GX
	/13F0pzTwNH9i4s4oODyuDUFgQ09Q1qnMng7VBWiewreU97ql5wuZ4ZDNQ1JD7ZfAvdCEq3DK8q
	8gueWb0H1WbzNBIxIYKo3pPJr1GqJgGfeYbCKykA0IQdmvyWcw=
X-Received: by 2002:a05:6122:180a:b0:5ec:5f1b:f725 with SMTP id
 71dfb90a1353d-5ec689c4d7fmr6770861e0c.23.1793729817534; Tue, 03 Nov 2026
 10:16:57 -0800 (PST)
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
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-7-9159caade148@gmail.com>
 <auoa8OWBxqaQuKRq@ashevche-desk.local> <CADvTj4rL23q6eO8vjVe9vL1g6B8aoZqsbnThi2QJqkj=9e59sw@mail.gmail.com>
 <auoit0AkmVeCvXqk@ashevche-desk.local>
In-Reply-To: <auoit0AkmVeCvXqk@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 3 Nov 2026 11:16:46 -0700
X-Gm-Features: AclHuK8HW-CEs65d3UAbPyCnbzk3fKPiCpsZ9iT1lPWFV_I6MxwKEkb2VsX1bZo
Message-ID: <CADvTj4rwm5BH8veX9i5_4trvzQFRPbDrAby7sXuEth6H6zJH2A@mail.gmail.com>
Subject: Re: [PATCH v9 7/8] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
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
	Peter Ujfalusi <peter.ujfalusi@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 11:06=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 03, 2026 at 10:54:38AM -0700, James Hilliard wrote:
> > On Tue, Nov 3, 2026 at 10:34=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Nov 02, 2026 at 04:14:34PM -0700, James Hilliard wrote:
>
> ...
>
> > > > +static void serial8250_rx_dma_flush_work(struct work_struct *work)
> > > > +{
> > > > +     struct uart_8250_dma *dma =3D container_of(work, struct uart_=
8250_dma, rx_flush_work);
> > > > +     struct uart_8250_port *p =3D dma->port;
> > > > +     unsigned int delay_us =3D USEC_PER_MSEC;
> > > > +     ktime_t start =3D ktime_get();
> > > > +     bool recover, retry, restore_rx;
> > > > +     bool warned =3D false;
> > > > +     int ret;
> > > > +
> > > > +     guard(serial8250_rpm)(p);
> > > > +
> > > > +     for (;;) {
> > > > +             scoped_guard(uart_port_lock_irqsave, &p->port) {
> > > > +                     /* Shutdown cancels this work and drains both=
 DMA channels. */
> > > > +                     if (dma->shutting_down)
> > > > +                             return;
> > > > +                     /* Serialize reset with completion and shutdo=
wn notifications. */
> > > > +                     WRITE_ONCE(dma->rx_pause_wakeup, false);
> > > > +                     retry =3D dma->rx_pause_pending && !dma->rx_t=
erminating;
> > > > +                     if (retry) {
> > > > +                             ret =3D serial8250_rx_dma_try_flush(p=
);
> > > > +                             retry =3D dma->rx_pause_pending && !d=
ma->rx_terminating;
> > > > +                     }
> > > > +                     recover =3D dma->rx_err;
> > > > +             }
> > > > +             if (!retry)
> > > > +                     break;
> > > > +             if (!warned && ktime_ms_delta(ktime_get(), start) >=
=3D MSEC_PER_SEC) {
> > > > +                     dev_warn_ratelimited(p->port.dev,
> > > > +                                          "RX DMA pause stalled: %=
d; retaining transfer and retrying\n",
> > > > +                                          ret);
> > >
> > > _ratelimited() is a slop of AI without understanding the code. It mak=
es nonsense
> > > in combination with warned.
> >
> > The two controls have different scopes. warned is local to one invocati=
on
> > of the flush worker and prevents repeated warning attempts while that
> > flush remains stalled. A later flush starts with warned cleared again.
> >
> > The rate limit applies across worker invocations and UART ports. It lim=
its
> > messages from separate stalls, rather than repeated retries of the same
> > stall.
>
> How? The whole _ratelimited() is nonsense here.

dev_warn_ratelimited() uses a static ratelimit_state at the call site,
shared by all ports. The intent was to limit warning bursts across ports
and separate flushes, while warned only covers one flush.

>
> > > > +                     warned =3D true;
> > >
> > > Altogether NIH _once().
> >
> > dev_warn_once() uses a static flag at the call site, shared by all port=
s.
> > After the first warning, subsequent stalls would remain silent even aft=
er
> > recovery or reopening the port, including stalls on another UART.
> >
> > The intended behavior here is at most one warning attempt per prolonged
> > stall, while keeping later incidents diagnosable and limiting their
> > aggregate logging rate.
>
> Yes, so what the point to use _ratelimited()?

It was intended to limit warning bursts across multiple ports and
separate stalls, while warned prevented repeated messages for one
stalled flush.

I'll use dev_warn() with the per-flush warned flag and one-second
threshold instead. That keeps one warning per prolonged stall and lets
each port report its own failure independently.

>
> > > > +             }
> > > > +             /* Notifications also cover completion or shutdown be=
fore sleeping. */
> > > > +             wait_event_hrtimeout(dma->rx_pause_wait, READ_ONCE(dm=
a->rx_pause_wakeup),
> > > > +                                  ns_to_ktime(delay_us * NSEC_PER_=
USEC));
> > > > +             delay_us =3D min(delay_us * 2, USEC_PER_SEC);
> > > > +     }
> > > > +
> > > > +     if (recover) {
> > > > +             ret =3D dmaengine_terminate_sync(dma->rxchan);
> > > > +             if (ret) {
> > > > +                     /* Retain ownership and keep RX masked if DMA=
 cannot be stopped. */
> > > > +                     dev_err(p->port.dev, "failed to stop RX DMA: =
%d\n", ret);
> > > > +                     return;
> > > > +             }
> > > > +     } else {
> > > > +             dmaengine_synchronize(dma->rxchan);
> > > > +     }
> > > > +
> > > > +     scoped_guard(uart_port_lock_irqsave, &p->port) {
> > > > +             restore_rx =3D recover || dma->rx_pause_pending;
> > > > +             dma->rx_pause_pending =3D false;
> > > > +             dma->rx_terminating =3D false;
> > > > +             dma->rx_running =3D 0;
> > > > +             if (dma->shutting_down)
> > > > +                     return;
> > > > +
> > > > +             if (!restore_rx)
> > > > +                     return;
> > > > +
> > > > +             /* Apply the current enables, including any interveni=
ng stop_rx(). */
> > > > +             serial8250_out_IER(p, p->ier);
> > > > +     }
> > > > +     if (recover)
> > > > +             dev_warn(p->port.dev, "RX DMA failed, using PIO\n");
> > > >  }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

