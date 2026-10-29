Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAD2606A31A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PdshPfHa
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFrXR5j34z30TQ;
	Fri, 30 Oct 2026 04:17:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::534" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793294279;
	cv=pass; b=L0Wq/0QhmwNj2ML5NuBVJmqDeEz55IjkRMphgCR5M35ZOSku+dgkRaIha9x1IBw/CXP/wR2IDMgMgxZRvg8mEbotLdlGCp5N5SPHz2DgVgo8u4z/ZGMUFJ52pFeKVMr1QWbd3pVcNnFFImalZqVS7edCz6ksqUvr0gAcmq4P41LKehcN1YrKTZUpxMTHhKajzgf6GdWt4nPiKW2YrdOMTCl11eeUKufq6nqkYHQLQjdVOdzGTQj1N7mfgM3EPj33lIAwzWqB2r7sCQO9Ss8zpiYVqIFa2YQIZIvaYvw/8CW7N3ZVgWEL/a1imWhSXKZnJSMMNK4i5B1+XQgMO7DSjA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793294279; c=relaxed/relaxed;
	bh=aVYR1R4XUuM03rk5Iesd5QgqyShDDveAkvO74xuMO/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRud2du4XOXNVBQALIi8aOMVsFDSY8JRVgUn0IGaq6oaLkYbZwRVqLMS7UepO9yi3OvPRIN8R4pCTnT4PbCuDPuUrL1gKT6RH+bunO5+VgrPlP+keOjxg0ECEpjVYv6OL6js++yPSH1gkVEal7aNge7oJUinAQebDxwTwlCpjZopI576kq7kaOsAAhmM15d0C+IMK/p43zPwHKd+S97v3EhL6Q15cupPh+wIxVyOiiNqenDRO0bKQjtlHUJGdCcyRadujMkzb4uB7jodo5kOgmBYnR65LoR0zpoqFXGCyf0HN3o1FbZ/RpL0sdE+Otj9EJiNXLqH3eR3Av6kOj4Xyg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PdshPfHa; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PdshPfHa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFrXQ4xzGz30T9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 04:17:58 +1100 (AEDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so4371953a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 10:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793294275; cv=none;
        d=google.com; s=arc-20260327;
        b=gEbRgsP2SEaUP+dxUVgYMXtur+EhUdjHil8fDLRGHCu0BLOk17+01pSih0JhkzxljY
         vifIHzBokCBYkp5wvJeRQfbytpziKYCrJ1Kll38vl0/xvmAlyTOJTejop8b2WEeUv+DG
         Lv1D6uFPo8W3cOMQtR1EPAsss/3yTSKdAdzgpvBlp56FKOpHiyurVAsgA17V0YusY2In
         eaLQ9sy4HsVusS+Obs2u3PANWbGwXssvKfVNSivE5kAaZHyNO5z+GAH0yhuUfuof5Ir0
         GS8DNZ4eudr1JI8LaHZvL4YtEKbq6pcvvEutHQ0EvPxjGW9CBq77OvtBuF2hfYMGkTJZ
         lxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aVYR1R4XUuM03rk5Iesd5QgqyShDDveAkvO74xuMO/4=;
        fh=aIl81Oy+ILcqhRrfcRfg/I4PG610cEqN053hF9egRNA=;
        b=o4q94/jpYLAZHuKUgj2+uJb4byIxa70xWpWn8nZlV8OhdKaVzdtra82A2W962B/o8M
         xDDj814S01v6NgQdwHl58gx/NzP5DaY3Pz8b0CbKxxMVHazQZoN1zqMVHZPQr/oZ024s
         WKX9mo00ZDrb3fD5GJA3A3+bbGvrTeCvitjzHdZ9fwM1maN5RoWkWt/wTIjP50AunkMz
         rkE5LdzNYS0aQMjShvWbvonMs54jB8KXn+NpFgKqeHKXl6Lh9n7Osfmk5IxEE0pIeBqe
         XXehW0wT3rvT6VuRQAtfH6SLAM8aACWYA6gWM7+ccUqseazwdmg4+TZBKKt5OLUEuu1d
         vOHQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793294275; x=1793899075; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aVYR1R4XUuM03rk5Iesd5QgqyShDDveAkvO74xuMO/4=;
        b=PdshPfHaB5Ae0mUzHcRvE5gd7sjHFNgGHArtfJHKQZb8h5JRIjiudrGRBh3b899jfw
         YHQtXdJ6F0dcEwdlgdicn3xIddnGJ0f0cOfQSxkoQdXNFRfvLoztb/X4yse5HQC/kJy8
         gp1TST9RUnbaECXMbetIZ4NDsM5/CU+NlH3tTRhXQ/ZWMTxAcpGvLTrGNlNqNWrAS9LD
         9nl51WhXy0hX0QaO96RqJM8zDkSzp3grGLVtO0j8FJW4XlAyOMrFtBV5FSHm9EsUuq9p
         dBc2AeVHGQPOrM/7Dbt3v1gTbsk93gZlx1XkRMQhfstGRxLhRRRcW5SEaHBGi77p0v2n
         1R2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793294275; x=1793899075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aVYR1R4XUuM03rk5Iesd5QgqyShDDveAkvO74xuMO/4=;
        b=Ky+5EN9eIB4q1huAtr+VI4iFkOeHc4B6ne/2QLU2nvnHfuPKHipfrkHeqcT2fsE6mb
         hjH8Zx3Lth95IHbYX6epHVWxHH9oV+1546vO+4Amp4M0SyGTcNSCApP19ZXfR2MhRUzP
         LKg3FtP9wkhHYthEknut5IO+tnbGqIkax+jrkGgvh2W5IpTmTX/neWH8yWSnJJdZwe4R
         +ijdxJkeuJ7xqAX0lPnHzl2qVnWdZLeeKjV4bqJzJjp+YNdKUEfKor0mQHtXJJD1LqcJ
         GBcg0EqdIKu/jXMMPJGNmk5BWp5JE259felxHm9ds7yIewKRKzHGoLziTyHUHISocra/
         SOvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxt558aGhexYtGEUz4pkSWkIYUugRrDnYEqVJ13qjtM/vt6XLF6XxDgA13rw2k4SGz1HgnqTKKsmFzedDw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLm+axVDlBHgFkWS+avj8KrpCk9iLGDTP0ndY7LkhKiqory4AO3
	nxlaIOdTZ3jJetVqXyrNEPAAuLs5/UYqj1i0DM0M5gySJZILyjYMOrKP0WoNhnt06a2IoLhtWOH
	IGOc/EDeyePm2h8QjPg4bgdyyYNhaJQc=
X-Gm-Gg: AYBFou3re0u5LQX88PGI1RYtOxmJchCzU2c7DrpbPcnMKWbEnR4nR4+SX+i51gsZOaj
	pHn5cQD/6c1sWqhaoNvvkepAwuLUkuE6AHMdBTOX5ao8FS3NxUNJ/FhhPHF3knzk1WDWgmZ4GaH
	/QNZsEpE0qgN6/6dJKIaawOne0JVUpEGBwsSjpJQRHVaKn0A3TY1XO4azhwLHryYRRXrzd6SJst
	quNV7djRCVed3+snWI5+VH1mqZhgByrLpPuvTdo9DiuHEt4rZLJGTiFABj8yN2EjIUAiPeu9BeC
	MTYgJXhTnoinXZnAuf2Z6TRussA1zuQPL+G5EZEm1U9GWqTZs3ZRK/4W4KI4gAaM6opJU3oE5pa
	0Ehynb1BiYJs3PmJIULu7rkfK8/mQFfQqBKXfP9/k62g2QaHMQxMfY/Rp+tVUnoCV3S2sNDvKun
	UPTQ2YV6lE8g/ulEpyJMOxLfZEv99uMw9jZLqZx0LzmlxbJq+QyHXYOolhkI0r/GaH8VWem0wep
	ZME3MzeKEpQDFLeaCefyptWVgVJjA==
X-Received: by 2002:a05:6402:158f:b0:6b1:ba86:5f48 with SMTP id
 4fb4d7f45d1cf-6b49cb8e221mr4598429a12.36.1793294275082; Thu, 29 Oct 2026
 10:17:55 -0700 (PDT)
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
 <20261029-submit-serial-8250-dma-cancel-v1-v8-5-3fd56ba352ed@gmail.com> <auNWl_thBnE8JqBE@ashevche-desk.local>
In-Reply-To: <auNWl_thBnE8JqBE@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 11:17:42 -0600
X-Gm-Features: AclHuK9p5HgzHs6EyjP74wtBvDwmav_JmQ_V3uuDUu-UaTGXVkbTzXu0Rboi3LQ
Message-ID: <CADvTj4qR0j7f-79wTUb9LmwWdGKYz32vB3Bgfr9AnEfXMnMBdw@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] serial: 8250: retire canceled RX DMA before
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

On Thu, Oct 29, 2026 at 8:22=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 29, 2026 at 01:37:01AM -0600, James Hilliard wrote:
> > The generic RX timeout path pauses a transfer, copies its data and
> > terminates it asynchronously. Clearing rx_running at that point lets a
> > new receive reuse the buffer and cookie while the old callback has not
> > yet run. Inspecting the new cookie cannot distinguish that callback fro=
m
> > the completion of a new transfer.
> >
> > Reserve the receive buffer until a worker has drained the canceled
> > callbacks. Keep FIFO access separate from callback retirement: after a
> > successful pause and termination, clear rx_running while rx_terminating
> > prevents another descriptor from reusing the buffer. Deliver the paused
> > data before allowing the interrupt handler to drain the FIFO through PI=
O.
> > Normal retirement only releases ownership and leaves subsequent receive
> > handling to the UART interrupt.
> >
> > Preserve the normal completion-path LSR read and gate DMA resubmission =
on
> > the receive interrupt enable, so stop_rx() prevents another transfer wh=
ile
> > the status read retains its existing side effects.
> >
> > Reject new flush work and PIO receive handling during shutdown, includi=
ng
> > late Intel MID DMA timeouts. Stop and drain retirement work before free=
ing
> > the channels and buffer. Once RX has stopped, allow the idle flush used=
 by
> > DesignWare LCR recovery during shutdown. Clear the shutdown guard befor=
e
> > startup configures the UART and tests its interrupts.
> >
> > Check pause failures before accessing the buffer. A successful pause is
> > the quiescence guarantee, even when a provider still reports IN_PROGRES=
S.
> > Also accept DMA_COMPLETE after a failed pause: completion can stop the
> > channel before its callback acquires the port lock, leaving nothing for
> > the provider to pause. Retire that completed transfer normally.
> >
> > A failed pause with an incomplete cookie is ambiguous: hardware may hav=
e
> > finished while its completion interrupt is still pending. Canceling tha=
t
> > descriptor can discard the entire completed receive buffer and switch
> > permanently to PIO. Retain the transfer and retry pause and status in t=
he
> > worker, with receive interrupts masked to prevent a timeout interrupt
> > storm. The worker copies only after a successful pause or reported
> > completion, then terminates and drains the old callback before reuse.
> > The pending-pause guard keeps callbacks from copying or resubmitting th=
e
> > transfer concurrently. Retries sleep outside the port lock and stop whe=
n
> > shutdown takes over. A provider which never pauses or completes retains
> > RX ownership until an error or shutdown; a timeout alone cannot establi=
sh
> > that discarding the buffer is safe.
> >
> > On DMA_ERROR or termination failure, let the worker stop DMA before
> > handing the FIFO to PIO. Keep the requested enables in the existing IER
> > shadow and filter hardware writes during pause retries and recovery,
> > including termios, RS485 and overrun-backoff changes. Apply the current
> > enables after retirement so stop_rx() and shutdown remain effective.
> > Hold a runtime PM reference around worker register accesses and keep RX
> > on PIO until reopen after a confirmed error.
> >
> > Abort the DesignWare idle sequence when RX cannot be stopped. Allow
> > the empty-FIFO timeout workaround once DMA has released the FIFO, inclu=
ding
> > while callbacks retire. Exclude FIFO resets during RX DMA recovery. If =
the
> > provider still cannot terminate the channel in process context, retain
> > its buffer and leave receive interrupts masked.
> >
> > For OMAP, publish the shutdown gate under the port lock before the fina=
l
> > RX flush and interrupt masking. Take the RX DMA lock inside the port lo=
ck
> > in the completion callback, and serialize the runtime-suspend flush wit=
h
> > the same order. Drain the UART IRQ before releasing DMA state so an
> > in-flight handler cannot retain up->dma across its release.
>
> Can this patch be split to smaller logically isolated (to some extent) pi=
eces?

The OMAP shutdown and locking changes look like they can be split
out.

The generic RX changes are more tightly coupled: the retirement
state, worker, IER filtering and FIFO-access guards must agree about
whether DMA still owns the receive path. Splitting those mechanically
could leave intermediate commits allowing PIO or another descriptor
to access a buffer that has not been retired.

>
> ...
>
> > +++ b/drivers/tty/serial/8250/8250_dma.c
>
> >  #include <linux/tty_flip.h>
> >  #include <linux/serial_reg.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/delay.h>
>
> When adding a new header to an unsorted block, try to squeeze it the way =
that
> you get the longest ordered chain (yes, interleaved with some unsorted
> elements, but still).
>
> >  #include "8250.h"
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

