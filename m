Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E372D606A31B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f1NqsDDb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJxMX4nwqz2xBK;
	Wed, 04 Nov 2026 05:06:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::932" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793729160;
	cv=pass; b=Tab84QQvCK6YCCJ7PrdoDjBn7Ufrn+Of/OAIiz7CXWF+IRpX26MohBMoyjql4Sg0FRbjvDT2QcGrZsPm64+6gsW1lAGPspE7v8WsfXxhAZbgjN6CQ60RedGsD75RrKlZvFEtOyIuz+KsUH1iLXNnVKehuoj5qp5aYgRkYCnr3kEZ3opV+gBzGO/G1T1G9TxfJpT2WXtmnjHJEDGvkijS+uERtnFEfBuTG27pkeRcIrFsJAgeBDGbH0vQ2/V3FJP1A2FwLCw1S1hvrzuQ80f9of80JvtcHu7ncA/F0lk+EevLEJh7ykfhdM38cIIbxPArQz0Nd5rrNRv3+O4F0muZoA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793729160; c=relaxed/relaxed;
	bh=KNbjwm4E9DcWTobQLF+oFd4MAgDdWhobdyNW4zlZws4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We8k1xxAUG1cTqf9636fNeR+vTpqSVzjhyr2NuRlV88I2Yw7jVlrU/pZg2BQwhxzYg2xR5CKDK/fXYEkwAqcOEx3Lm0XRwQ50ppwNoVi+EWFRBwDkwQJu5pjwtWPPDYfKDHZZ6mTOZiDhg1mnvn8HRb5BvjPoM94Sj4JT1FWUCTSGAiXkvAFAv0JRNcFeakm4VhNWVOzK6FcgArsTb0KPBYiEU/AdbtZCRpNFOe1WxW3UK8KuTzbsLzXq/YuHgTNrcZTcDG2Onf5CVgf0OsOR8W+6h9wrGdDVj0Ya8mY5jfF+PJtTNY1ccE+lYErGJ395QElZtVxSLB7Tbztfn7sQg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f1NqsDDb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::932; helo=mail-ua1-x932.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f1NqsDDb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::932; helo=mail-ua1-x932.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJxMW2z3gz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 05:05:58 +1100 (AEDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-99059bdcdeaso1033102241.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 10:05:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793729156; cv=none;
        d=google.com; s=arc-20260327;
        b=VjDds3r58FfY8RO5Ta0mTIFOXFs+gpMQbj7E50IvIfb8g7db7VktvR/5FKWup+cPB/
         gSE3GN1qL37EkBYlPKEr9pS3/0QF2P0tEf8G8y5albQ3+3vIb61rkGZVYdV9RUHTtyee
         yKAcH7fpdmOAeRaW/AAsZUHhfttys4+HbR+dE8rDaAXRsO0wUh7OFZVjE5dfa8dqm8KX
         mScfxPkrQFe/1ZKbO6214QH9Y22hVZvBFoRL0GRF3qQsmF5orAYjS3u/i2vpl6E5Urek
         qs9h9s514/rgIxBiuYeU3ZwINRYTRVwxqAz2vp7yew2qToPlXhOw76tvhgs8bB9sBfSQ
         TQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNbjwm4E9DcWTobQLF+oFd4MAgDdWhobdyNW4zlZws4=;
        fh=ODkhfHDMctqSkLfkNmOOmV2rRYtjj7VNRRx/zSC8OU0=;
        b=IZ1/32RFTgONcpzjqtaj1R+lRuCh/yZcdDutrFrOR/sRrdPnzHgnaz4VTvl5CFCArq
         ywHirtRJqouQcoK4vK9LynEqUVfWz+n6mJKx3kvtRO4wFLpvtueqk2B9A7VBVpUBA2wm
         a7pZHpwlO9E4h2J9Iaq1qY9YUGjEjdY34Rb2nBgjLV7ipuIO6I9kBBP9jFICQf1XBs7U
         0UWI833WTjfIGXBEtiYEYpXndul6NJehuWaNJVm/mvolsvnp/z9TW9EfgNJwY11MMeum
         ElnYKSlOOj514iC333xVUgAAztYF8OAur9QObY6GkfUVSeQVC8gT3WPnPazex3yw2FEc
         6xGw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793729156; x=1794333956; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KNbjwm4E9DcWTobQLF+oFd4MAgDdWhobdyNW4zlZws4=;
        b=f1NqsDDbKs33maN6e/Vm6HJmLsaWjaT0CxLzympYI6F57bCGtwd5X/nCP8bUj9p1q8
         cdwWH8Ij+mABBMBm+qmnogbyNQm/RBMNkgeYiG6w2RxvoRYeyNm9LZsdvYvkgIavWVs3
         0gyAOG0FlU12PaqXPRewJf8XjAteOF6LgEEnMTYdrsRU+o3SY4bmVuWFZjotAefK0x5w
         Ldx1Bn/lpxRvHJuWsKyb+r/fVFBI0F5DzeS8gytw1dq54X/aNLgpzC4HYcYSXx1nsAea
         SNRPcub7kBtbhTTpWEl0IQKXFaLWGYzmRkexcBPOhUhQr7t+lBRBsVqQLh2tGr/DtgI/
         FhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729156; x=1794333956;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNbjwm4E9DcWTobQLF+oFd4MAgDdWhobdyNW4zlZws4=;
        b=p5xKt4D7v7JYTamEJwKRqWht6WDDwI3Ut1Umg8goUcPa4Vh0djyRIHo3Z0WTW6PQe7
         o6bn8dabI+/HOl5VDwbLVSk5nqpuXaIhxfHc8nHAaRf0ZVzWZqcYzS0xwfPEkHziZ20P
         C6Uvb65nXQqi6uta96I5sBR4vl8XfmHANv1DYgUxogdb0WPNGqxAUMIBSmMegoWe6h6X
         BEhDpa8bxM92SJJnfp+RQiNEe9ELmy8i6F1ctgeV9UTXJm2z+mtJitAr4V+7DAqWVlvj
         10MirUC2DuOO1QMJZWjexK5nDkxPUQJP0RvSQ9xgS6+SGQFQv/LGKJG7SdV6rEe34EK8
         dsqA==
X-Forwarded-Encrypted: i=1; AKwUvByZ/TUhp1VigeJF7JWBqZwiDhnx42hvCVVMMB/pHhr1TbDLTE4XHgOZRqflNpaLVu1OQ6Dp5LBYYY2zPTI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/XnpsQPQ7eQLBpMcpB5fudsmnWHiwMEE1AdLJYWcbc3t4JGZJi
	OuJtAr/ao9iUVwQT+/M7GODZN9v0TUcZInqpJGBrUwqGM2OIcJlrhXV2Q9FyLLuo96wKpLp+wq5
	EhmTxRb2883UH7H0DidxErrzVx/MACJY=
X-Gm-Gg: AYBFou08Mp0qEjlfwQjpVpJjBcKVTM0kjVW54N4QDJRUIDQe5TkhIdxMo4Mpaer9YEV
	TT9vpV5JE5qA4kXlDvYbyIdONIyrhGtudfa4RUT34uV0MwG4y+EqkzZRbmWw/yupZxKHIZmhSzJ
	q+n72GNSnSZZILWniA1U8onqmU4tsGxrk9JA7PwRPL7YfQ1UpTYBuGv0FixF2XrzPzRfaDTGcgw
	GktjWRCyD8g5cfWgZy1wxsR/M4TolGbxgxsbackItY1ZXCyhTnPZs5wke9/hpBz19IBFG7WK7IC
	f6jk1X7fdYDz6XYtiSrE/tc29hgT+3fgx8lzZiOMRbCdqFmq1UxdLC7Qcrx4tJDGMhb4fQZHXIO
	VJrBymfmQ+xAyf9cCWDW5dWpGpSlD6dGDIGdynWl4Bc1TBjHTfauxGt8YYawix4AQysRC4iVj1X
	4fQhtpyv+ZqfkzdBOmWd9TuFXavcKwDtcxwW6CqSTZiX7ZyWdDOBS+PcN9CTU/8iEvLwbV9VVyB
	KvAqRh6tYEEfJLRMsbfWysQUigMcQ==
X-Received: by 2002:a05:6102:5121:b0:7cc:5c9d:7e07 with SMTP id
 ada2fe7eead31-7d072635de3mr4255291137.11.1793729155740; Tue, 03 Nov 2026
 10:05:55 -0800 (PST)
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
 <20261102-submit-serial-8250-dma-cancel-v1-v9-7-9159caade148@gmail.com> <20261103161104.2449407-7-rrangel@chromium.org>
In-Reply-To: <20261103161104.2449407-7-rrangel@chromium.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 3 Nov 2026 11:05:42 -0700
X-Gm-Features: AclHuK8ExVfXbcYLwfHHnCvMLw6HMi1Pim5AHzKRXmfuq3AFPdi8A4knMcfIqjI
Message-ID: <CADvTj4qXcOqS-wDrrN-x3sXUQr5BtFBeGzz_wqpW8WJ1DMPg+g@mail.gmail.com>
Subject: Re: [PATCH v9 7/8] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
To: Raul E Rangel <rrangel@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
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

On Tue, Nov 3, 2026 at 9:11=E2=80=AFAM Raul E Rangel <rrangel@chromium.org>=
 wrote:
>
> Hi James,
>
> Thanks for v9 =E2=80=94 fixing asc_startup() locking in Patch 2/8, waking
> tty->write_wait for drain waiters in Patch 5/8, splitting OMAP RX locking
> and IRQ quiescing into Patches 3/8 and 4/8, and adding rx_pause_wait with
> immediate wakeups from dma_rx_complete() and serial8250_do_shutdown() all
> look good. Waking rx_pause_wait under port->lock cleanly avoids delaying
> normal completion or cancel_work_sync(&dma->rx_flush_work) during shutdow=
n.
>
> Two remaining comments on Patch 7/8:
>
> 1. Escalating to serial8250_rx_dma_recover() after a bounded pause-stall
>    window on partial RX transfers:
>
>    The commit message notes:
>    > A provider which never pauses or completes retains RX ownership unti=
l
>    > an error or shutdown; a timeout alone cannot establish that discardi=
ng
>    > the buffer is safe.
>
>    I completely agree that a timeout alone cannot establish that *reusing=
*
>    or *freeing* dma->rx_buf is safe while the channel is still running.
>    However, calling serial8250_rx_dma_recover(p) under p->port.lock once
>    the retry budget expires does *not* reuse or free dma->rx_buf without
>    stopping the channel:

Successful dmaengine_terminate_sync() establishes the required stop and
callback-draining guarantees. The concern is not that the buffer remains
unsafe after successful termination, but that this recovery path discards
the pending receive data and disables RX DMA until reopen.

A failed pause followed by an incomplete status can be temporary, including
when completion has not yet been published. Retrying preserves the chance
to deliver that transfer without switching to PIO. Memory safety after
termination and the decision to discard the transfer are separate issues.

>    - Calling serial8250_rx_dma_recover(p) under p->port.lock inside the
>      worker's retry block sets dma->rx_err =3D true and
>      dma->rx_terminating =3D true (and keeps RX masked in UART_IER), whic=
h
>      causes serial8250_rx_dma_flush_work() to exit the for (;;) loop
>      (retry =3D false, recover =3D true) and call
>      dmaengine_terminate_sync(dma->rxchan) outside p->port.lock in proces=
s
>      context (8250_dma.c:233-239).
>    - If dmaengine_terminate_sync(dma->rxchan) succeeds (ret =3D=3D 0), th=
e
>      channel is stopped and its callbacks are drained, so clearing
>      rx_pause_pending/rx_terminating and restoring p->ier safely falls ba=
ck
>      to PIO ("RX DMA failed, using PIO\n").
>    - If dmaengine_terminate_sync(dma->rxchan) also fails (ret !=3D 0),
>      lines 235-239 already retain dma->rx_buf and return early with RX
>      interrupts masked.
>
>    Why does this matter in practice?
>    Look at drivers/dma/tegra186-gpc-dma.c:
>    - Line 1521 unconditionally assigns .device_pause =3D tegra_dma_device=
_pause,
>      so dma_get_slave_caps() (drivers/dma/dmaengine.c:614) sets
>      caps.cmd_pause =3D true and serial8250_request_dma() enables RX DMA.
>    - On Tegra186, tegra186_dma_chip_data sets .hw_support_pause =3D false
>      (line 1351), so tegra_dma_device_pause() (lines 420-423) uncondition=
ally
>      returns -ENOSYS. (On Tegra194/234/264, tegra_dma_pause() at lines
>      389-414 polls TEGRA_GPCDMA_STATUS_BUSY after setting
>      TEGRA_GPCDMA_CHAN_CSRE_PAUSE for 20 us and returns -ETIMEDOUT if the
>      channel does not pause.)

The Tegra186 case is a permanent capability mismatch. dma_get_slave_caps()
derives cmd_pause from the presence of device_pause, but this provider
installs that callback even when hw_support_pause is false.

serial8250_request_dma() already rejects RX channels without cmd_pause.
Correcting the provider's capability reporting would prevent this
unsupported configuration from being enabled in the first place, rather
than discovering it after receiving data. That is different from a pause
timeout on hardware which supports the operation.

>    When an RX timeout interrupt (UART_IIR_RX_TIMEOUT) fires on a partial
>    transfer (e.g. a few bytes typed at an interactive console or a short
>    command waiting for a reply, count < 4096), hardware transfer completi=
on
>    will never occur while the remote peer is waiting for our response. Wi=
th
>    an unbounded for (;;) loop:
>    - Those partial bytes in dma->rx_buf are never delivered anyway (even =
if
>      we wait forever until the user closes the port, serial8250_release_d=
ma()
>      terminates the channel without copying dma->rx_buf).

For a provider which never pauses or completes, retries cannot restore
reception. A request/response peer can indeed leave the descriptor
incomplete indefinitely, and closing the port then loses those bytes.
Backoff and diagnostics limit the retry cost and expose the stall; they do
not solve that liveness problem.

For pause-capable hardware, a recovery timeout does not have to prove
that the failure is permanent. The concern is what happens after that
timeout: the current recovery path discards the pending transfer and
leaves RX on PIO until reopen.

Is there a recovery approach that avoids an indefinite RX stall without
turning a potentially temporary pause failure into loss of DMA for the
rest of the open session?

>    - UART RX remains permanently dead with RLSI/RDI masked and never fall=
s
>      back to PIO.
>    - serial8250_rx_dma_flush_work() holds a runtime PM reference
>      (guard(serial8250_rpm)(p)) for the lifetime of the open port.
>    - On 8250_dw, dw8250_idle_enter() (8250_dw.c:151) sees
>      serial8250_rx_dma_flush(up) =3D=3D -EAGAIN and silently aborts
>      dw8250_set_divisor() and dw8250_check_lcr(), breaking baud-rate and
>      LCR updates while rx_pause_pending is stuck.
>
>    If serial8250_rx_dma_flush_work() escalates to serial8250_rx_dma_recov=
er(p)
>    under p->port.lock once the stall threshold is reached (or immediately=
 when
>    dmaengine_pause() returns -ENOSYS / -EOPNOTSUPP), dmaengine_terminate_=
sync()
>    safely stops the channel before any buffer state is released and the U=
ART
>    recovers on PIO instead of wedging until close().
>
> 2. Minor nit in drivers/tty/serial/8250/8250_omap.c:783-784:
>    In omap_8250_shutdown():
>      WRITE_ONCE(up->dma->rx_pause_wakeup, true);
>      wake_up(&up->dma->rx_pause_wait);
>    8250_omap uses its own synchronous omap_8250_rx_dma_flush() and never
>    schedules rx_flush_work or sleeps on rx_pause_wait, so those two lines
>    in omap_8250_shutdown() can be dropped.
>
> Thanks,
> Raul

