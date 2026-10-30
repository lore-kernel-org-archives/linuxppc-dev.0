Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D07606A31D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 00:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pRx8LRQX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jG2FL6rVNz308H;
	Fri, 30 Oct 2026 11:35:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e32" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793320534;
	cv=pass; b=jPaUngCMpfcgQwr/E076vlq4t6s51sv+vVOl9KaMmGJ32pUdHgpKs+LhnocWf4FO4uyyaOAFaXHujJEjwGM9sX/GVIPoZKPeoHXv05DcIXyiDK4lrODK/WPxCJrhWk6s14n4+1eoHK/v/f3Qcx1LsLR3uF2qKWOjIvF49yW6U3pmZcZ4vZfD0dCOqF5NvN+gir+Q10LsiFAH+fwuqTIuwti2gvgeB1RpDUjsyUkiyYW/KUtd6DRBZQdKDAWEfRgBUVpRVizw7OIu4YHwwIgQEjQUEnKTiZCxDggRQWPH3JGUCGCnsIs/ZYjfOoy+yIG+C3w/rbTG5A+sPnX1YVSqAQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793320534; c=relaxed/relaxed;
	bh=vCXebNkndm9LBXsG81Q2mOpTPDq3UCuJ8oTq7IQkTYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8sAwgFxlijNvj6TkNgmdGMAWDx8OF9XzPHq+cKhwAqdLLKbkDXXOj2M4HEFDlSKEB9S5IZmBDp4xFEQMzfXVNF9XgxkfxmvWXJ90OJAoUeF7wNuHzDvji9efqOQVhvTsEBXVb97u4K0XVdXWfBnT1o68K11oqz9EEHKFDexmtH83cjQn7Y5i86ju6thi3rEX8AeazNOaWrogMHeTMuGwMnH3zf+rLskmQWui9zQe1T3hFiLLx8lm2o+91gfGcDMWy6wqft0o9wdY6IToEVpIcaI5NXtHh4pVSNvxkGToGBG9tGyAQtbTA2cgJB05rIgf7KwJFrKccP4Z0KVjn1cjg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pRx8LRQX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e32; helo=mail-vs1-xe32.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pRx8LRQX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e32; helo=mail-vs1-xe32.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jG2FL0fWtz2yYK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 11:35:33 +1100 (AEDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-7ce78f9d6baso164799137.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 17:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793320531; cv=none;
        d=google.com; s=arc-20260327;
        b=bAd3I+ydAlIyVQrueGTwmPRFfI1+59oLDq+HxYQXjsjGYYtq6UhpCXauOI7VUDXEt4
         R/+/J4n8jSaJ1rqKtJESxsmEvLaUmeIILTSgamcCW0CQfvvFHjL/NDGeQ2H4CMfrF27q
         ESeB/Ka/sdKLGl7Hh1FBP8WEGiN0Mhjss7fQiNygIJqN/VnkoDSZHaozgLLk/Iq4Ys3r
         2tb/6uKvlCmM2VFuokQkjzwMLBhp5E7xQoBlLwQVgaGXNJ5w6Hr97BZn5oHttrE+uSbW
         CRAUnvZinYlAY76kRqEY5m8fOYAcqKbhICxlb7bJPxXq6gwPWr6Ka1ZaaGIz9jJf5q1j
         lD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vCXebNkndm9LBXsG81Q2mOpTPDq3UCuJ8oTq7IQkTYU=;
        fh=VQxA00wC5IF6z/eI0Jkq9IbAP973FjgQZ8Qm28IqB94=;
        b=a7wVfenPHGzwcTFRfGoQEMuEytTNiT/VL7nsc7Jzbyvb02cc5cKxtfiykbBulWV1Pu
         OldZPkt3nQEHfRKDPnOAgq1yPQL9qgUNmynagDuRyZ33slxuror2caqEAOAmS+Caq9UD
         ESpBrO0Gd33QmEiAErhpK/PJYUjfZs1Oi0B0ZiEGnUZ73fwu6kl1p7ovpy2BPewEFIAa
         wrx8qbz1fOSgULLijWiaoZdRGy1Fjtfiz5auHL4ojByuTOVteahBnfnqjNy5p6nW9FK/
         Vj4Wi7nFSG56BD5eYUfR2nekGe/MZVU9o4ViJYTroEjiJLacVPegVHIaAxD7h2AXP+O3
         rBUQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793320531; x=1793925331; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vCXebNkndm9LBXsG81Q2mOpTPDq3UCuJ8oTq7IQkTYU=;
        b=pRx8LRQXjpfNJiBQO0XngwToE3bexAIaAO+1WY76O60o+sp2QHm8pkr9FEqS67TCCu
         LvdOpt+tEBhy2j7RvlfSN7v0R0VfFtSRNggIfVHg20K5ov9Ug3AdVwcTUsWA5HIKsKSf
         RYd7Sf4CtFwJy45yHu7QfeUOwtb4ODVVflX97eQ7OLbKwqBG0Ssy3axVi+P/MM1qotTM
         HsS9yItupeIjq5B1J8yNAQDXtt4DnRhuGDrsLbCKPgle5VB1xlRQdKvSCQz4PW74aWzt
         3ypKAxo9aV7id2jzPTT+hZi8eYKZc7O3DVxdlrs2zji7cIWDy3jls9Uhp4E91rDcUBMy
         skKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793320531; x=1793925331;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vCXebNkndm9LBXsG81Q2mOpTPDq3UCuJ8oTq7IQkTYU=;
        b=kLjgSxCVLWtmYzx+cNbJRScaQtx3WP37CRyISrFuSblh6THWf+uiJjQ2Fhbu3TPuwz
         n9qjPwDiBpYm4mmQ7cuYZznLRZGOo5gF9DGc5yn1J2bPE3kxHHJnCq94DhqI0nDK8HtT
         JbtyCXz5SzM+u4Q74bv8ZkHpDOup0moRpGyBh2K+qhxVALXgVT7cctHLogaY+fFM31HJ
         KUDchMMq+cUZZewBCYdovdmoTS2w/vT08uNqpBq/bbv5wZi50Kx/oCQVWo8SifVmZxCk
         hCTb73JUXh3tp6IK1wPX3SUnLj/5paqvCOoyA+VqJy09Hs5cO2umik6TuovVBoU5Dwjh
         3Bqw==
X-Forwarded-Encrypted: i=1; AKwUvBySL4NXsSORQ0JAszd/d9PhqJRSpB9nu4p0vjRvpZ8Hc/KD9KX2NkhxGE39YcVHhC+YJRm1iQUO7cLQtyg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ21nceJ28LZCFxPoofAze/LOI7huppIwvtUBRdrw6VCjJCwdE6
	xVSfIHtwtvjrFT/OxlXKSOSngC7fBvzq2i4vdS8m5D+oVXflpR1H4cwnds87PlFobJxWsGb6bd7
	ARshzxzs5b9Csx8OC3upF0uqrtSAQ23M=
X-Gm-Gg: AYBFou0/vCMiH44UJT72pZeUAoA2hjUp7UIU136JY7AVnMsO7xCuzvTPDY5wJP1bGrF
	2uR5RfRtg+/5urEzSsNSqQ+oGn5xowTIRvBThu564RRbXeHuDUjWPagwKjETGb0g4hwroov17oF
	/HI47COxhYwFUzrthTBZRLEBVlPFHntNqq3kibpUZAUeldPro/S5WaUocCVV8fbNnvAZbqqcVJv
	iw7JzN4SCF1LVmJAvDC9epZOym9kyLQMyMKmPZlMabbq5WpQqsB4w3uucTg/8CtvgF0LfAK0/wn
	s/WgEEOel0tFVy89cOIvWxxhpmi5Q3+/3I9kANfCfRQg9Rksdxdhp6FlQAsJH4zrW3pkWKcPGlM
	brDb2F3wdmq/rBgokFJP8kyxxdHxhWg57Q7ZCytNzIF5cYz8yPbKYkVOXqMxw8iRJo8pmv7Yady
	SqBJCNnPNtilY8Y7IlpC34vATkc4s0jRCLICoJVV30R2LV58sKHfr9JK0qhBpwcargYm04RjERe
	K+nzhYi0qiyXOWhC7DWb48ntO24Dg==
X-Received: by 2002:a05:6102:50a5:b0:7bb:64cc:1362 with SMTP id
 ada2fe7eead31-7d072c2b96amr253188137.6.1793320531134; Thu, 29 Oct 2026
 17:35:31 -0700 (PDT)
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
 <20261029222734.3086943-2-rrangel@chromium.org>
In-Reply-To: <20261029222734.3086943-2-rrangel@chromium.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 18:35:19 -0600
X-Gm-Features: AclHuK9fwQEf1FE2SE005DWVvtH9Aa6gi9TWL3-I0d1O0Zk2jQvC0qB4u35B3dg
Message-ID: <CADvTj4rRtKyq_7yhpfwGQrbOA=k_jxQymTpZSvdVBB0A-xR-Rw@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] serial: 8250: retain DMA resources when
 termination fails
To: Raul E Rangel <rrangel@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
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

On Thu, Oct 29, 2026 at 4:27=E2=80=AFPM Raul E Rangel <rrangel@chromium.org=
> wrote:
>
> On Thu, Oct 29, 2026 at 11:19 AM James Hilliard <james.hilliard1@gmail.co=
m> wrote:
> > On Thu, Oct 29, 2026 at 8:24 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > > + while (rx_ret || tx_ret) {
> > > > +         dev_err_ratelimited(p->port.dev,
> > > > > +                                   "DMA termination failed: RX %=
d, TX %d; retrying\n",
> > > > > +                                   rx_ret, tx_ret);
> > > > > +               msleep(100);
> > > > > +               if (rx_ret)
> > > > > +                       rx_ret =3D dmaengine_terminate_sync(dma->=
rxchan);
> > > > > +               if (tx_ret)
> > > > > +                       tx_ret =3D dmaengine_terminate_sync(dma->=
txchan);
> > > > > +       }
> > > >
> > > > Huh?!
> > > >
> > > > This is unacceptable. Sleeping is okay, but value should really mat=
ch the
> > > > baudspeed and other parameters of the transfer.
> > ...
> > Regardless of the retry interval, shutdown cannot release the buffers
> > until the provider establishes that DMA and its callbacks have stopped.
>
> Agreed that if dmaengine_terminate_sync() fails, shutdown must not free
> dma->rx_buf, unmap dma->tx_addr, or kfree(port->xmit_buf) while hardware
> or a detached callback may still touch them.
>
> However, because serial8250_release_dma() runs under port->mutex in
> uart_shutdown(), uart_tty_port_shutdown(), and uart_suspend_port(), an
> unbounded `while (rx_ret || tx_ret) { msleep(100); ... }` loop means that
> if a DMA provider returns a persistent error from dmaengine_terminate_syn=
c()
> (-ENOSYS, -EINVAL, -ENODEV, -ENXIO, -ETIMEDOUT, or a wedged controller),
> close(), hangup(), and system suspend will hang forever in
> TASK_UNINTERRUPTIBLE while holding port->mutex (triggering hung_task_pani=
c
> after 120 seconds).

That is the current behavior. Returning from shutdown allows serial
core to free the TX buffer and removal to release the callback
context. The retry loop prevents those releases, but a permanent
termination failure blocks teardown indefinitely

>
> Would it make sense to satisfy both constraints (no UAF on buffers/callba=
cks,
> and no infinite sleep in close()/suspend()) by quarantining/leaking only =
the
> failed channel's resources instead of looping forever?

Retaining the buffers and channels does not preserve the complete
callback context.

The callbacks carry a uart_8250_port pointer. For DW, the DMA state is
embedded in devm-managed private data, which can be freed after
unbind. The registered 8250 port slot can also be reused. Retaining
the DMA channel does not prevent either operation.

> Specifically:
> 1. Bound the retry loop in serial8250_terminate_dma() (or do not loop on
>    non-transient errors, checking `if (dma->rxchan)` / `if (dma->txchan)`=
).
> 2. If rx_ret or tx_ret is still non-zero, warn once (`dev_err` / `WARN_ON=
_ONCE`)
>    and intentionally quarantine/leak only the failed channel's resources:
>    - If rx_ret !=3D 0, leave dma->rxchan non-NULL, keep dma->shutting_dow=
n =3D true,
>      and skip dma_free_coherent() / dma_release_channel(dma->rxchan).
>    - If tx_ret !=3D 0, leave dma->txchan non-NULL, keep dma->shutting_dow=
n =3D true
>      and state->xmit_blocked =3D true, skip dma_unmap_single() /
>      uart_xmit_unblock() / dma_release_channel(dma->txchan), and in
>      serial_core.c:uart_free_xmit_buf(), skip `kfree(xmit_buf)` if
>      `state->xmit_blocked` is still set.
> 3. For a subsequent port reopen after a quarantined failure:
>    - Remove the redundant `up->dma->shutting_down =3D false;` in
>      serial8250_do_startup() before serial8250_request_dma(up) (which alr=
eady
>      clears shutting_down under port->lock), and have serial8250_request_=
dma()
>      return -EBUSY if `dma->rxchan || dma->txchan` is still non-NULL so
>      reopen falls back cleanly to PIO (`up->dma =3D NULL`).

Clearing up->dma does not stop hardware accesses. After unsuccessful
termination, the channel may still access the UART FIFO, so reopening
with PIO can introduce concurrent FIFO access.

A hardware-specific stop/reset sequence could establish quiescence,
but its implementation and effects on other channels depend on the
controller. If the channel cannot be stopped, quarantine also needs
to preserve callback-context lifetimes and prevent unsafe port reuse.

>    - Guard the DMA completion callbacks (`__dma_tx_complete`, `dma_rx_com=
plete`,
>      `omap_8250_dma_tx_complete`, `__dma_rx_complete`) with `if (!dma || =
...)`
>      so a late callback after `up->dma =3D NULL` is ignored safely.

The current callbacks fetch p->dma before acquiring the port lock.
A callback can therefore retain the old non-NULL pointer across the
assignment of NULL. Checking that cached pointer does not protect
its backing allocation from being freed.

When termination returns an error, dmaengine_terminate_sync() also
returns without calling dmaengine_synchronize(), so callback draining
has not been established.

>
> That way, neither hardware nor a detached callback can ever UAF rx_buf or
> xmit_buf, while close(), system suspend, and subsequent PIO reopen all
> complete cleanly without an unbounded msleep() loop.
>
> Thanks,
> Raul

