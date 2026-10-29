Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB39606A31A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ev3AO6T/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFrTn3Ngjz30T9;
	Fri, 30 Oct 2026 04:15:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793294141;
	cv=pass; b=Har2XbbBYXMd12roUS4RAej82gxvtFvsYGTxfjES6TgrNg9vaJcbRB9HzkfAV4TMgKaMhQfqtnnrvN3Qk3d8LetFLsOybfMPueh5esVVfl4CtRYn3GxoG0I254N8Jl7C1B+Na63oNkr+FH1d/7bF/imGcw1dssluVWC4yNSBctKe0KfpV+X7CkyuaYW7DGsvCrpuu1eGbhubkx7wg2Rm42ByVyMHceTsFFhLcK+ZMeyyOldV2GJobVo+jUZPfIUen5LCbCnIV49+IpT+z0VjehuVzye8LDPXUlQNlXbVYAZJRU/16vppO+YqE1i8vZaU1XigEaydjTMcBMItJBUG4A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793294141; c=relaxed/relaxed;
	bh=bfkoGr6eHduUtBaHwkrM0dSWX67wyi9EvMSHv231Bb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hku+a287xnM7VHm69ozYiZ1Pczz18IYobGKsWsLUJfryPH/uimaNt/+qnYIug+PNHRYJZxAHtUpeAlkFuIpX1DbiFsYAenoqhT4qQVrOPMQfprV+ItdRwVXTVtrPbDkmO6nlhwEopiDdBHOyBC4+5Oc4DZX1Tr7hBZ9dTEhzyAQcddtTZ71P3Lfk/9wyISTytyzX/dbfNySJCr13UuBWW4fD4Vg69GO4VleC/eC/q5jsmAQFqykjZ9hsEVj8tuN/6O6AdMa5DGjOTaKYH/FcKtuHD57bQDIZgsjI+o7Uy3FBgCQ2yM0BLxUrPnj1iDYMKxPrGJvX4ehYEum7otWBuA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ev3AO6T/; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ev3AO6T/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFrTm3n47z30Sv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 04:15:40 +1100 (AEDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so2797210a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 10:15:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793294137; cv=none;
        d=google.com; s=arc-20260327;
        b=fBUKH44HELR4+GPHWIWIXvtRrUVlN23xqCCYO+j+BohVJ6WVxfFVGn8ELuHyFI7Y0p
         62EpJfpEMMr1KYEODKdOO5aGjfqJKQeEzN9XNsosYl8lf/wqxeVAjKQfDSFOdUIYrgUn
         Zah9AQNN6DPAgDxCzSkG4hS5ysw2eS7WLA+uGt0WuIwQkcJNiJUQUWMZotMaWihydus+
         o7A6dqri7CUUKNUA/wzrw9oPnJIJbkoStRJKrOHAmZmhMeRO8/8ahg8KZozwbzxqIgZL
         rGq+wsXQ6zHjxgJxYHPf1+2LDrof0N2iURC+MpfuRjcZOEWwpSMNzAZalrE8G5T+gVaj
         xwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bfkoGr6eHduUtBaHwkrM0dSWX67wyi9EvMSHv231Bb8=;
        fh=kNL4j2h4U+zsZWgCfapfdumwA1tp5+epgBzKUvuAHeI=;
        b=A2N7khjaXCdrP/9FFRp/dDx2LZwAT5TGDvs0NoX/cUWk65xAauGSZpfUtiNoxARsyu
         t4hRuckhgL7AnybEWiFuUe3qEVkURNtau0REY8K7dcJao6RyIJTYKv2MbAMQNIObdJ0t
         pWjmJoap80RHJpLz0WraH7zv24bSMCgSKrkywNECNEsJ5R7AcJu6zuyafzPmWQxmX0Z0
         pZOMZxnlMSXLHtiqw2vvCevC5zx0HE+WJiDuRHh3RyuTel8RyxgRnMSBTkrHKlUCNvde
         amo5PNve0AOQ3wU95RUp4pCUGkPfZLIt7AeVtFJU99y3kEDlRfTrlc0jUS55OTexumG4
         x5uQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793294137; x=1793898937; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bfkoGr6eHduUtBaHwkrM0dSWX67wyi9EvMSHv231Bb8=;
        b=ev3AO6T/cLx2dX1lO3usO7Y+XOV/i5eUiAojyTR3bm5wSRDeKDFoF9bAnUyhAABdl5
         +h1uO657uEcxFojeVTxLxtigaSxj06CQMIqMuQDJUZFgzn1phE2pl2GYjZBRA7Y5UcZA
         sL2ff1fmWKizFClPvRZUgJSNdTXajWWBJer35W7QULU6PXRnT/u+kWmETnEN0qJgAcXT
         QXqo4P59fw3u7ngCKZRw/TAWpwOxAvidE3vAC8HA5EZdc+QGxPsvYeAYxY9xixLkabXp
         5sQcdjD+fQPccXRMMBMMAWP9JY6IzNjLdemPRT23Tb2XcsuXa0yBOnGQa035dMf8/e2Q
         +RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793294137; x=1793898937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfkoGr6eHduUtBaHwkrM0dSWX67wyi9EvMSHv231Bb8=;
        b=qtGzHBsTjbqwXJ0h8xogalAgvzCxwcy8MYHwMGGtBMRd4iw3f1f8buTki5jxHpcawf
         49JlLHuHRxBpZqYRwGGT+4Yz7vsbQElIjXvCMj9575MheQkyO5X9kaVK/fUfzo1kyPY/
         a1uIv+qNl1zRX4Y/cq4R0BA53/ZHijrznmY2Q361HZ9IvOCAUK+hqPNMomJYnh6BS5e0
         eQ4ikP1Zkr3QC+EBJQGeDwtFVv7rNUToVdTz3XyTt2lpOfZie2Tns0h40pGF2z2mh5Mn
         Q8ESnjPYqQp+i1x/G+SxIcWiBqDvIfBwYIV/NYnEnAjfV/qAseivV/hKbbpnh5Kwfyl0
         Ob/w==
X-Forwarded-Encrypted: i=1; AKwUvByAGsJ6W1YZbOPwiZ44CopWwM1x/TUKmzhWmoB3zVvPAd2zT0y1HEA3Oqs/D8O2YrBAZjlCzmKHd93K3Dc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIo3bcYz5AB3IRyJNsPzgmtHPauWcr0mucB7X5QhrxwCOGI4Nvz
	4f9mLob4hnbwgGsDJCIDpyoSgfZoo+Y2oT80jsI1zKDb202PlRQBFx/XDPuswzJQbeGiuB9GyYX
	XmBZMV+pG713ujQfR0OPY+hW9+jZXjbw=
X-Gm-Gg: AYBFou1EOu0jK28lgRoTBi8eU6QPz0+oZWa6cepZhHKFuxQ81hFqPp3MN4BdYUseUsF
	R9dq7eFrZguTeH0W8Dq7NO+w++0OG/O5J6m5HYRdoxp4ClUgTWMYjwocBGjnFoGPGxG2hX0c51l
	UM6ythinSY1sh5kbSxglnPG0g3mGCw92qAyLblfQc0DUccAt/MJnkt3JNw8BKMpmtCwiadHNiGh
	yPxLGINb3lPVAmcddmtgyToH2/h83556UCGrar4ExS+z3I5tM3Jge7mJK38WjRUTlzyAZYrlDvx
	ujY11UWXgl2YJWIjUy+U6ZdxO1d0JGs1lExv0Mh8hOh9xQ01LPfRYOYpp2AWF6m3hz7h5iHjEkl
	nuUWluTiCLU533UuW1ERAI92sfFRvBNPUuUVrZS9Vv0uMGlsQ5UMlsRmwf7RX+hKbI0uGtPIX6Q
	RQ8p1572+QKisSu0YmZMjbJ87lyshKb9Wb4Y/rJw2MLmLqp+8DP4Iz1gcCsQGNERGJv0csGQJQY
	oy5DUGwW1hUhE4ZmFfxq11fxKVsfA==
X-Received: by 2002:aa7:c687:0:b0:6b3:f840:59b5 with SMTP id
 4fb4d7f45d1cf-6b49cc019b3mr3067325a12.27.1793294136580; Thu, 29 Oct 2026
 10:15:36 -0700 (PDT)
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
 <20261029-submit-serial-8250-dma-cancel-v1-v8-4-3fd56ba352ed@gmail.com> <auNV7Vco5O3vVwRH@ashevche-desk.local>
In-Reply-To: <auNV7Vco5O3vVwRH@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 11:15:23 -0600
X-Gm-Features: AclHuK8a3pNXQ_IsYXCQfDMZzFxdEUJPDH5qKP3q2TLb8CO-tQBpFEH7zYCUMxU
Message-ID: <CADvTj4oi6dFzWkjFXie1U49A70Y7Mb=4exga-=2SmG7fN2pLrA@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] serial: 8250: drain canceled TX DMA before reusing
 its buffer
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

On Thu, Oct 29, 2026 at 8:19=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 29, 2026 at 01:37:00AM -0600, James Hilliard wrote:
> > uart_flush_buffer() resets the transmit kfifo before calling the driver=
.
> > serial8250_tx_dma_flush() terminates DMA asynchronously and clears
> > tx_running, allowing a new write to replace tx_size while a detached
> > callback has not yet run. That callback can then consume bytes
> > from the new transmission. Reusing the reset kfifo can also overwrite t=
he
> > source of a transfer that has not stopped yet.
> >
> > Reserve the flushed FIFO storage through serial core before returning
> > from the flush callback. Keep tx_running set until a worker synchronize=
s
> > the terminated channel, suppressing old callbacks and new submissions
> > during that interval. Return the mapping to CPU ownership before releas=
ing
> > the reservation and waking writers. Normal transfers continue to use th=
e
> > FIFO directly.
> >
> > Reuse the locked completion processing after retirement, including OMAP
> > delayed register restoration and transmitter-empty handling. Take a run=
time
> > PM reference around worker UART accesses and drain the worker before
> > releasing the channels. Shutdown releases the FIFO reservation after
> > stopping DMA and unmapping its source. Serial core keeps writes and wak=
eups
> > gated until startup or resume makes the port ready again.
> >
> > Track a flushed FIFO separately from the transfer length. If terminatio=
n
> > fails, retain the reservation until normal completion and account the
> > completed bytes without advancing the reset FIFO. After successful
> > cancellation, process a zero-length completion once callbacks have drai=
ned.
> >
> > The race was found by inspecting cancellation and restart while prepari=
ng
> > H616 UART DMA support.
> >
> > Retain the tx_running check in both completion callbacks. Releasing the
> > reservation relies on the DMA provider draining detached callbacks when
> > dmaengine_synchronize() returns; provider callback-lifetime fixes suppl=
y
> > that guarantee for controllers which previously lacked it.
>
> ...
>
> > -     bool                    shutting_down;
> > +     bool                    shutting_down:1;
> > +     bool                    tx_terminating:1;
> > +     bool                    tx_flushed:1;
>
> What is the meaning of bool XXX:1? Have you checked with `pahole` the res=
ult?

These are one-bit boolean fields, intended to pack the state flags
into one byte.

I've now compared layout probes using the kernel type definitions and
saved build flags, changing only those bitfields to ordinary bools.
For the complete v8 structure, including the RX flags, pahole reports:

                            Bitfields   Plain bool
    ARM32 / Clang               212         220
    ARM64 / GCC                 368         376
    ARM64 / GCC / PREEMPT_RT     368         376

The sizes are in bytes. All six flags share one byte in the packed
version. This saves eight bytes in each checked configuration.

The packing is a layout choice, not an atomicity mechanism; updates
still require the UART port lock. Given the measured saving, I'd keep
it unless there is another concern with using bool bitfields here.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

