Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013F8606A327
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y9M6BIJ+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJLfg0sr8z2xgv;
	Tue, 03 Nov 2026 06:02:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e33" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793646123;
	cv=pass; b=aAokJhEp5jNxx6C+bMYOyCk0S73eqUiBC9Er21LFT/9b18O+8D8bKLYKJ6rhw5W9J+E+p7kZPYJ92BenVSMvR4+rjG2aIcoESBJbuui/cXHD7D0Nnz007rcug+6gMg3OmQ358LmBKdbrXNgeAaQffTrrYNfFYDDVu+IJ7ZcesPiuGi94QVFKRrMP10PPMy2weeL3/A665DcMM+MPwjdbaYSnPJ7ruHYKJTGYfd7LzHtkdS7U1AqAiuelWu/Zew1QARhKkt8qukBURtZYRD2CyLz9mGkHPytstKYQK4CZOJ6IKXgN73o0QdmXt10w/HTFi3YmUchLZcC8vWzcbi3JlA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793646123; c=relaxed/relaxed;
	bh=6x7C36ItNCE7Mv0HbSUEpY6Gibir1HyWLaQqqnLukwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsJd8eLeYltk4S8OVS3oYFPADKlMQ3drHHBdkT6HeShzFLnRGiL58xs7KI4LYJnjtLvEP8A+1oC9xSlrborhoLVAY5kpD8ITqSw+htkYM3K0/JiCQ76hsS9go73obz6c9AxPNZevel0M3cHQjH00tHftnj24COe8FFJci5cz5zh/3GOt/SVfCt/LpR6VzUeeWLyP0FZN2zUSevrgAUimyLnRZCkxFoczCYWLVio/aSd/eu0N9VCU1WTCfDwr6ABgxD/b3yCMd0ZKpI6cfXDx9IPL/rOSigUCjOhVZAPGHQJT2YYaKAfZCu0UzRy7E2wTv+sKtZQRpfyP7Vpaw8AfsA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y9M6BIJ+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e33; helo=mail-vs1-xe33.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y9M6BIJ+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e33; helo=mail-vs1-xe33.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJLfc4l2kz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 06:01:59 +1100 (AEDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-7cc603a168fso1070111137.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 11:01:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793646115; cv=none;
        d=google.com; s=arc-20260327;
        b=dYfRjJgLpJDaXi0qTGC4JSBjGZdsaOtdW4r6azU8nP/ssnoMllclWxe4ERnJMYIvTY
         p3j1bIAqQodpBUtA3FzXXN9GmOi4MCzeAXUJoqHeAYwwXVKe7WlFwMzQKBk8QBjEE/Yi
         bTmcKVLkxyXrCEEaMOIWBXONfwwuZ5aWtS34hYWZ/5rfWJSlDO0SKkNKyah+7uFRAsms
         eJTZPiCB/OVxQcuHVIujhc5XuTFAja8wJxFbB770P6X31cix05ToDpVeuGxyuCkt+lg2
         C10ZpbCs+NoMwQvI1MRwUTGDPhEHVaPqFiuJlQ0ozxOrhLxkg/N+r7NANNyEBL2dNZsk
         j4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6x7C36ItNCE7Mv0HbSUEpY6Gibir1HyWLaQqqnLukwk=;
        fh=rD/gfDsobB3y9xdl1TMHzhKGE8sAEmrFy9XN3SIk35w=;
        b=Lgf3XNdfjXTSpwjep+j4gxE+SKsDoarWg7duu2qM9vi21lC9L0mm8qzRLadyMK0zjt
         DoGjxpmTjaFzYYWUw3z6gDj8NR4ZG4789F4+g1BkCt+E3g2I9UQz3Q6qc7ZpAx6GAun/
         9UEknhagLT+/SkdXVtoNBVuON64mpXv0gtUeg+QjIvxUbbZX5GV9P9GU+SUoIDEGRIPX
         rYbxCcnpd16MIvK2I0svZ47tpMs8+te93NgQueatAKjDG0fKKgqMd8ZEa2DBRd4LsxhS
         FKZxvNW2fi/IXkLvNQGOVXr5s9VGzval9d3iKmpzpEHQXO/47NZFCmKLZ3gnTk+p7E59
         LVZg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646115; x=1794250915; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6x7C36ItNCE7Mv0HbSUEpY6Gibir1HyWLaQqqnLukwk=;
        b=Y9M6BIJ+wNirtBNVrJUjwkfwRZL+TQntVNNHrLoegYS8y4hiy6p8zWSYisbuorQFUg
         GmeAzar+E8qwfP41WsEIkHRZEy2UEbutJKOHMIwiwMVYxcKLPzIby1gIE9y1m3MflRE+
         BvdX+FbtYawFMSuPzRizg43kac/JSLt86UqHbMaHZUVt6BX+eKoY79TFM0HAkW2K1rk/
         HCm9p/ukNsaJFR7Zc8Y5Q28FUNT3b3svYitPsATs/vbgVB+t3XLpPjVrCChzmiQJLxdR
         Cvl61U6Cif3Dwu3AquujtAxJ1JBjM7bFbvS9HjcOjxrouaHVH98inZWwyO6/Q6HEJZM/
         cEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646115; x=1794250915;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6x7C36ItNCE7Mv0HbSUEpY6Gibir1HyWLaQqqnLukwk=;
        b=FuFnBd3Hd5V5QVGIsbvSzIA3AbnqyNh/q5MWT0q108+zDa4a2GyeFia/tRI8fIcYYT
         tBwqWIkx0pdqIXITNrD/Kp8PFXHZUJBFzQX5mfPO4O14GnKi/mK4CkMfWFSKqMaDUI5C
         YG7qQ70IBJsBPZjo0Chmjv0HeiLd12QAa0MJvcyDEudt+/2KKBJYFK1T5IrJ0kQRDVSx
         cpkE8mvCmXyrKX+G6UcyGncbE8Vrh875MNeD9lmTAl7SH7UFFAY8xN/F8UPY7wVHGVRP
         zofszmBIef98ebl6+5C/v7oUZCc2Eqh0f+9S+vDP8ChFBpJsxror6gZU6t6sPXn7QKLv
         GiOg==
X-Forwarded-Encrypted: i=1; AKwUvBwBpCq0//dLqA7gOB6Ps2wTx4gNB4Z0fUKBMmvpZzokYioLak3K+WSagimTQtdyW4xjMIQSheu2Wb84aGM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/nJZggr5Dnb7b4WNhIdIK8OsvZAhPKIsmncRS4cVi8GXqNr6Q1
	cIj6wq7PRIuSA0LGF0uO/5y5Qswt7/v6RNwfPVU7d7RVavQ+7+3svLgaidhFsRpbC5GB8i1wi0P
	mZXkjoenJ1Qzn9/DZTj3bUF4ZQescBHY=
X-Gm-Gg: AYBFou3WB4w7d+/cP3xmpK5cAJ4gANPMMPHwjjHn50e0kjb5p4VHxinas7456E8jsUh
	razYkucceH0jjzNo5MeGURSYNpU1VyaPz2ojlLqPRKzEDsAKvFtb/vNNqsBr3XN5k+YMjTJnA2/
	zknmuUs6WhhiF2KlpjVrdlDDzA6B62gz6rI4TdrQZTT4BRcHfQODZaqnPViDwzw2axAdgk475Hq
	JKU7rA1tBleB9rxL6UG8slXBHPTx3+E0cXWhJvZ2hH7d5tyqtI4LcddR7rYoMZ86MhKbeFJEfrd
	Cr6uHebMun65pNaiefo5okZLcgGQBFZ502i3cfWDro2jUfJYLz/smtg8zzuVC+MdjkjJo502xny
	WpkFzNBnpptyM0YztGvRwBHazIR5PbvF5/GrhNNesGFu7WNizYL2Dco6nQe+0gfec/B0H8zqGH2
	IwSCcA0b7c8bDESqvJx4vHhc1HVkTqZErHoqftkHI9+LSd80O5YipKL2YVcz4G5ablkO+VBA2+t
	UGX2sIN0L7qOnAn7iUojtRYh18ZPw==
X-Received: by 2002:a05:6102:950:b0:7b3:8f0a:f76c with SMTP id
 ada2fe7eead31-7d072bb3726mr4192494137.13.1793646113500; Mon, 02 Nov 2026
 11:01:53 -0800 (PST)
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
 <20261029222734.3086943-2-rrangel@chromium.org> <CADvTj4rRtKyq_7yhpfwGQrbOA=k_jxQymTpZSvdVBB0A-xR-Rw@mail.gmail.com>
 <20261030173635.2186490-2-rrangel@chromium.org>
In-Reply-To: <20261030173635.2186490-2-rrangel@chromium.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 2 Nov 2026 12:01:42 -0700
X-Gm-Features: AclHuK8hePvnISH49dlVrc4mCThAhAMYZDLctOcSiiJ-Xdrwl739zXGlDWt75pI
Message-ID: <CADvTj4op-tFqWmtzOQnt=q9aZttaWngYXLjfXEkdqcLirTMoXA@mail.gmail.com>
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 11:36=E2=80=AFAM Raul E Rangel <rrangel@chromium.or=
g> wrote:
>
> On Thu, Oct 29, 2026 at 6:35 PM James Hilliard <james.hilliard1@gmail.com=
> wrote:
> > That is the current behavior. Returning from shutdown allows serial
> > core to free the TX buffer and removal to release the callback
> > context. The retry loop prevents those releases, but a permanent
> > termination failure blocks teardown indefinitely
> ...
> > Retaining the buffers and channels does not preserve the complete
> > callback context.
> >
> > The callbacks carry a uart_8250_port pointer. For DW, the DMA state is
> > embedded in devm-managed private data, which can be freed after
> > unbind. The registered 8250 port slot can also be reused. Retaining
> > the DMA channel does not prevent either operation.
> ...
> > Clearing up->dma does not stop hardware accesses. After unsuccessful
> > termination, the channel may still access the UART FIFO, so reopening
> > with PIO can introduce concurrent FIFO access.
> >
> > A hardware-specific stop/reset sequence could establish quiescence,
> > but its implementation and effects on other channels depend on the
> > controller. If the channel cannot be stopped, quarantine also needs
> > to preserve callback-context lifetimes and prevent unsafe port reuse.
> ...
> > The current callbacks fetch p->dma before acquiring the port lock.
> > A callback can therefore retain the old non-NULL pointer across the
> > assignment of NULL. Checking that cached pointer does not protect
> > its backing allocation from being freed.
> >
> > When termination returns an error, dmaengine_terminate_sync() also
> > returns without calling dmaengine_synchronize(), so callback draining
> > has not been established.
>
> Those are all good points. We added port reopen and a `NoConcurrentFifoAc=
cess`
> invariant to `Serial8250TxDmaV8.tla`
> (`Serial8250TxDmaV8_QuarantinePioReopenHazard.cfg`), and TLC immediately
> confirmed your point on FIFO contention: clearing `up->dma =3D NULL` and
> falling back to PIO when reopening after a failed `dmaengine_terminate_sy=
nc()`
> violates `NoConcurrentFifoAccess` in 7 states because the un-terminated D=
MA
> descriptor can still access the hardware UART FIFO concurrently with PIO.
>
> We can satisfy all three constraints while still preventing normal `close=
()`,
> `hangup()`, and system `suspend()` from hanging forever in
> `TASK_UNINTERRUPTIBLE` under `port->mutex` across the three lifecycle edg=
es:

Keeping the DMA state intact and refusing PIO reuse addresses the earlier
reopen hazard. However, implementing quarantine safely requires changes
beyond retaining the buffers and rejecting startup.

For example, serial8250_do_shutdown() clears the FIFOs and reads UART_RX
after serial8250_release_dma() returns. Those operations also need to be
excluded while the retained channel may still access the UART. Close and
suspend subsequently enter power-down paths, so retaining the allocations
alone does not establish that either transition is safe.

There is also a serial-core exception to the proposed reopen contract:
startup errors permit an administrative open for CAP_SYS_ADMIN. That
allows reconfiguration paths which can release port resources. Returning
-EIO from the driver startup callback therefore does not by itself
enforce quarantine.

>
> 1. **On `close()` / `hangup()` / `uart_suspend_port()` (`serial8250_relea=
se_dma()` & `uart_free_xmit_buf()`)**:
>    - Bound the retry loop in `serial8250_terminate_dma()` (with a short
>      backoff rather than an unbounded `msleep(100)`, guarding
>      `if (dma->rxchan)` / `if (dma->txchan)`) and release whichever
>      channel(s) terminated cleanly (`rx_ret =3D=3D 0` or `tx_ret =3D=3D 0=
`).
>    - If `rx_ret !=3D 0` or `tx_ret !=3D 0`, **keep `up->dma` intact** (do=
 not set
>      `up->dma =3D NULL`, including in `8250_omap.c:omap_8250_shutdown()`)=
, keep
>      `dma->shutting_down =3D true`, and retain the failed channel and its
>      buffer (`dma->rxchan` / `dma->rx_buf` when `rx_ret !=3D 0`; `dma->tx=
chan`
>      and mapped `dma->tx_addr` when `tx_ret !=3D 0`).
>    - When `tx_ret !=3D 0`, explicitly call `uart_xmit_block(&p->port)` un=
der
>      `p->port.lock` (`state->xmit_blocked =3D true`, since `xmit_blocked`=
 is
>      otherwise only set when `uart_flush_buffer()` ran prior to `close()`=
),
>      and in `serial_core.c:uart_free_xmit_buf()`, return early under
>      `uport->lock` if `state->xmit_blocked` is set (without clearing
>      `port->xmit_buf =3D NULL`, resetting `port->xmit_fifo`, or calling
>      `kfree(xmit_buf)`).
>    - Because `up->dma` is not cleared and `struct uart_8250_dma` /
>      `struct uart_8250_port` remain allocated on the bound device during
>      `close()`, `hangup()`, and `suspend()`, any callback that was not
>      drained by `dmaengine_terminate_sync()` safely loads a valid `p->dma=
`,
>      observes `dma->shutting_down =3D=3D true` under `port->lock`, and re=
turns
>      without UAF=E2=80=94while `close()`, `hangup()`, and system `suspend=
()` return
>      cleanly without hanging in `D` state or triggering `hung_task_panic`=
.
>
> 2. **On subsequent `open()` (`serial8250_do_startup()` & `omap_8250_start=
up()`)**:
>    - At the very start of `serial8250_do_startup()` (`8250_port.c:2356`) =
and
>      `omap_8250_startup()` (`8250_omap.c:724`)=E2=80=94after acquiring ru=
ntime PM,
>      and **before** clearing `up->dma->shutting_down =3D false`, touching
>      `UART_FCR` / `UART_RX` / `UART_TX`, or setting up IRQs/timers=E2=80=
=94if
>      `up->dma && (up->dma->rxchan || up->dma->txchan)` is still non-NULL =
from
>      a prior failed termination, retry `serial8250_release_dma(up)` first=
:
>      - If `up->dma->rxchan || up->dma->txchan` is **still** non-NULL
>        (termination still failed), immediately return `-EIO` and **fail
>        `startup()`** (do *not* clear `up->dma =3D NULL` and do *not* fall=
 back
>        to PIO while the wedged DMA channel may still touch the UART FIFO)=
.
>      - If termination succeeded on retry (`rxchan =3D=3D NULL && txchan =
=3D=3D NULL`,
>        which also unblocked `state->xmit_blocked`), reset `xmit_fifo` and
>        proceed with normal startup and `serial8250_request_dma(up)`.
>
> 3. **On driver unbind (`serial8250_unregister_port()` / `serial_core_remo=
ve_one_port()`)**:
>    - Driver removal is the *only* point where `devm`-allocated
>      `struct uart_8250_dma` and the `serial8250_ports[]` slot are about t=
o be
>      freed/reused (note also that `serial_core_remove_one_port()` at
>      `serial_core.c:3336` only calls `uart_shutdown()` when
>      `tty_port_initialized(port)` is true, so if the port was already clo=
sed
>      with a quarantined channel, unbind must still drain/release it).
>    - Restricting blocking termination wait to driver unbind (when a chann=
el is
>      still active/quarantined) prevents `close()`, `hangup()`, and system
>      `suspend()` from ever hanging the kernel in `msleep(100)`.

This looks like a useful direction, but it introduces a broader lifecycle
contract across serial core, the individual drivers and power management.
In particular, suspend may need to fail until the hardware is quiescent,
rather than succeed with a quarantined channel.

The current retry loop still allows permanent termination failure to
block teardown; changing the backoff does not resolve that limitation.

Would it make sense to address quarantine separately, with that
limitation documented explicitly here? I would prefer not to fold this
larger redesign into the cancellation series before those paths have
been worked through.

>
> We verified this quarantine + `-EIO` reopen contract in
> `Serial8250TxDmaV8_TerminateRetryHang_Fixed.cfg` (`AllowReopen =3D TRUE`,
> `ReopenFallbackToPio =3D FALSE`), which passes all safety and liveness
> properties (`NoUsersAtFree`, `BoundedTerminateRetries`,
> `NoConcurrentFifoAccess`, `QuarantineImpliesXmitBlocked`, `ShutdownProgre=
ss`)
> with 0 errors:
> https://github.com/ismell/linux-8250-dma-tla
>
> Thanks,
> Raul

