Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15EC606A327
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yoGpAyB4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFcTH58g5z3048;
	Thu, 29 Oct 2026 19:14:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e2d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793261667;
	cv=pass; b=HWGXMd7tcLPGIbAkOZzZ9iVknKR9aOQ9H/RtQuXbB8QUEvs3wmBhQxfhcrpYMSDEMbT9wQxkZT0KTqlL2c4mVIKUCECu3Ej3xc/qpmXnoTu5QqzkkAfbqBvu50ZJrw9/7lNAjF8w24mlK1cv3oVehH46znBjdV20K7b5OvV96MW0wQYOfg1kleikZ+Om0N9vxWf73EdiFPleSz5p0t9wRkqMBXtHObwQoc0P4icvMUgaGszxcRMWiUexTRzIYTsZ0eY+Zw2GENb3e/ziDRUmOdBhjP8S7hCSzZ5fc+tWGq30iEDtY/tm1CNOAXpuSCigO83OekMSxV0hAtAxzrekZA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793261667; c=relaxed/relaxed;
	bh=XRqdz8CmBop39zT0MOnXVWaLPZs5c98CxtCs0iCmyZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCiwKVMqes1f4+NllH061oaOohM1H/eFvBvIUKaymx4EOCHi+d49/uK5dy4iZ51Ie23A8QDXMH8238wWE/ic7Sz1Iy9eoR51MlaYfb/cwemtCHYnUQQmTQh/+mIoe2XmGyI3m4bgGJ4ZcqmYinazrymbZ29Qh55IZ1YFFM1nbx0MSx1x2/PlJa7SeN7TRui2B14Ki7kZOuiugZ0HQfAbztNvRKRnApz0/tJRhQSovhIluxlw0aS5cLHnkAgNn55IBcBcNNGTpr9Zt73lMjwBvLH1hpB8PzBQEPzZsI9IVPfg5sODGuiIlt36BiBSb7geYRR+ImW83nNSC9aLivwD1Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yoGpAyB4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e2d; helo=mail-vs1-xe2d.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yoGpAyB4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e2d; helo=mail-vs1-xe2d.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFcTG5xMLz30MZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 19:14:26 +1100 (AEDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-7c03744ef27so583718137.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 01:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793261663; cv=none;
        d=google.com; s=arc-20260327;
        b=gsxWaxF/ty4G8z0y6B9F0VhvKOMswxDu/b9P1Yz3p70uQb6ug4A+CvK+17JmFHm2SM
         SO7vqTi5jDJVhrPHAwJuBQkQsp9zzYayoGMoCm9qFLQChR6y6JIogXqRfU75svhY8rQq
         Xru7uDqh/+BeO3nhwoCnFRUqcQIQDdqwYpoQbpBlbnWlA0oLmfLoaxCkFDEvIGOkXv+D
         1gYwhxJL+qnbWlqPHeuyX1Z3SYusGf2dSFGUEt25IqkcwA+TjY8Pv+OZYebDSkR+Wg3W
         0AAhi+93S9nswQCnGlISXKXaXeOm8aA+PjRGhK2r3clX9AB75bWdbiQ96wa+P49S5wn9
         jUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XRqdz8CmBop39zT0MOnXVWaLPZs5c98CxtCs0iCmyZ0=;
        fh=Bi5rPoiue2S3pisD+nZtHjg/ksEwZn5/aAZum2SQhVo=;
        b=AuWyD9cg5vk31WoL0vT7r+SXnB8EX9+I1TRc9j294YbMjkVL2mGahDGF21h/ZksZOE
         a57KTyfpBXhVQUD0JK3SK6Sw8whSh8jWoXj8p9pNMvjGnfqYtbaV5YudEf80t3qvv9J6
         US9AY1738dsLv8LANuWtGey6lfs+X69EKldrnuXV4AjNhFFh9R8gNAaPYOg3y77NUboW
         b/XO5WfO7ztUP/ZYvskdotyxb4RjeeDw+012emZnWW8gRCG73YqU6OAtmM0QpwFYjixk
         mDeH64jMXp5u09FKoRBZZG/nk0UBwEaFf9HYDSxxvPghDo2tcGBrgEgkT2pS4dN1aNhg
         XmkA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793261663; x=1793866463; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XRqdz8CmBop39zT0MOnXVWaLPZs5c98CxtCs0iCmyZ0=;
        b=yoGpAyB4oXZd09xo/fOKiHZvQUgXCmBVXqCPv39AaIj5s+67YULQPFG09nxt9oBkrX
         6JN6H6tgKHv5V0LfC9hFjrStRFx0v5cYl79W/kQ6zHX9hh97qv9Njb1y2dLN47DfTk5K
         2YQ9QYasPFNKUj6rERYZcf8hOzB4k0INayorzEx3q8nwKU7X6jvd1ktkeR2KgWEMZDui
         tfL29LbQSktN1BRliyAQ16S0rKmcT94moBSRPAkVfflSyuaFIelq0lw3gVlLxhWkSYyc
         ysM+1fW9zrM35SdrnlsZXFbGuw80rfd1r3ghL9mNprFHUxroffe9mplfKIPBiwaFDEQT
         jn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793261663; x=1793866463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XRqdz8CmBop39zT0MOnXVWaLPZs5c98CxtCs0iCmyZ0=;
        b=t9YCsOFjpY2jsUUXHlo045Lhpsk6w5rkTpaO7ZKMhGWdH4sZyL9wpAdOGDJpC3+riY
         JchzjZDEuS5UL4dGKETYxN8ygkm1khiydPzsalPNYBtT/Jd5pgNrhNmirXC7o0GjyBoC
         d4xh4cH4cNc4EcviyooQ0YlitwjEhnCQ6JFIWH6UaX8dNIXDkQ+G9RyBjACIn9YOjfWL
         lezNDijvDLLnc4LXeHpQHb8cYirLVVM8ULUvSmUBVvX6fXF1BLUP3XKhsdAnTLLi9Xf6
         xoDo3B4wzQzO/ihQu5gsfMhbYB9b6gbgav7t7hc4qrjvaM1m/CYDG7gNjbiJhmFHk+45
         axxw==
X-Forwarded-Encrypted: i=1; AKwUvBzgJu6WYNVkrNB/quWQtBBhopw3GtuFrvx0Q3pJR1cMtqQUo2KEpNSohrHsLrv9igNwjJBRwS20lHASqKM=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIV3lC5mGDI+Qu8HL7K10hUVjsyM9hP69zMCKDn9ahVMhvgrD5b
	QB/h/rRekHkE1uThgqLmgLCmxfxUjTmCkC/8DVGEpM42l6EOadv7FZ2ZxfU20/6j9T7vOat5U/O
	OFMIrcBjPhFuqqjaBRLR8a6D4f1i/Y4k=
X-Gm-Gg: AYBFou0Muw7TI9pLhUnT6jwK93m44yOP8N+gYf62l4GPAYaumbSxwvixv2OA3rccr0h
	bD+/7JwFOvWn9e7NuQA4+zWM7n1Wu9BLxOT2iE3dzPuQsvWFuYEEtkkJj4ZD2tEQ5TB/dz8775Q
	Q6FjkT3q+t5fkbMCNAuJqZrBGf1MuWmpQoxB40jvDaSxVnVoVhYw72JB2z4hmFpqeWetsaNgb3o
	P9Eq9wbySlJ/cw6pa95mtHMIaXBLcyiERs8Hsu+9KvH6InrLqB9FvacyUsFp/qQVp2x33jKgObA
	HD8QVTldvUeAvL3ekbvvmlwbXT+cn26rFq/mf4F2ZcD+pvZQk+Q2fZOGLjTgfFsfBWUK86p5/Ax
	X87r9A3Uq0Rul+8m7KXIzrgPCgropQRBaVK2fQeCuSyHjP5bnuFSJKQAng/4aEKxOe5tteEV9vV
	nuOw3aYjiaqgB8btN7GFgWm4IYjsDuGZQGonxepNNtlFbL8QLPWsGbUaWNJ3oSemWkSrL0LKRme
	ziHeqmZvCFlPZSnWyl2BHo8/w81Ig==
X-Received: by 2002:a05:6102:424c:b0:7cc:2712:cafb with SMTP id
 ada2fe7eead31-7d03a5708f1mr2019992137.15.1793261663187; Thu, 29 Oct 2026
 01:14:23 -0700 (PDT)
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
References: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com>
 <20261027-submit-serial-8250-dma-cancel-v1-v7-4-985a023ba4b4@gmail.com> <20261028204847.3471382-2-rrangel@chromium.org>
In-Reply-To: <20261028204847.3471382-2-rrangel@chromium.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 02:14:10 -0600
X-Gm-Features: AclHuK92fmKJThZ29uPEx3r2hwaWsXISrLYNiraGYBJq2R2TpOOpVIz5KsrBhR8
Message-ID: <CADvTj4pEo3uj2bLbP6RwD=P+hW2omQ9x_sn_ag_FHzxUknX-nQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] serial: 8250: drain canceled TX DMA before reusing
 its buffer
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
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 2:48=E2=80=AFPM Raul E Rangel <rrangel@chromium.org=
> wrote:
>
> Hi James,
>
> > @@ -37,26 +40,35 @@ static void __dma_tx_complete(void *param)
> >       struct uart_8250_port *p =3D param;
> >       struct uart_8250_dma *dma =3D p->dma;
> >
> >       guard(uart_port_lock_irqsave)(&p->port);
> >
> > -     if (dma->shutting_down)
> > +     if (serial8250_tx_dma_blocked(dma))
> >               return;
> > -
> > -     if (!dma->tx_running)
> > -             return;
> > -
> >       serial8250_tx_dma_complete(p);
> >  }
>
> Removing `if (!dma->tx_running) return;` and relying solely on
> dmaengine_synchronize(dma->txchan) to drain completion callbacks breaks o=
n
> DMAengine drivers used with 8250 UARTs that do not implement
> .device_synchronize (where dmaengine_synchronize() is a no-op), including=
:
> - drivers/dma/sun6i-dma.c (Allwinner H616, cited in the commit message)
> - drivers/dma/dw/core.c (dw_dmac)
> - drivers/dma/pl330.c
> - drivers/dma/mediatek/mtk-uart-apdma.c

The provider-side fixes are posted separately for DesignWare [0],
sun6i [1] and MediaTek [2]. The v8 consumer changes require those
callback-drain guarantees on the affected controllers; they cannot
compensate for a missing provider synchronization implementation.

>
> On those controllers, if Transfer #1's completion tasklet (vchan_complete=
,
> dw_dma_tasklet, or pl330_tasklet) has already dequeued the completed desc=
riptor
> on another CPU, dropped the channel lock, and is waiting on port->lock at=
 the
> start of __dma_tx_complete() when uart_flush_buffer() ->
> serial8250_tx_dma_flush() runs:
> 1. serial8250_tx_dma_flush_work() calls dmaengine_synchronize() (which re=
turns
>    immediately because .device_synchronize is NULL), acquires port->lock,
>    clears dma->tx_terminating =3D false, and calls serial8250_tx_dma_comp=
lete(p)
>    -> uart_xmit_unblock(&p->port).
> 2. If no new transfer has started yet (dma->tx_running =3D=3D 0), Transfe=
r #1's
>    in-flight callback acquires port->lock, sees !serial8250_tx_dma_blocke=
d(dma),
>    and runs serial8250_tx_dma_complete(p) a second time even though
>    dma->tx_running is 0.
> 3. If a writer has already started Transfer #2 (dma->tx_running =3D=3D 1,
>    dma->tx_flushed =3D=3D false), Transfer #1's stale callback runs
>    serial8250_tx_dma_complete(p) while Transfer #2 is still active in har=
dware,
>    syncing tx_addr for CPU, advancing xmit_fifo by Transfer #2's tx_size,=
 and
>    submitting Transfer #3 concurrently with Transfer #2.
>
> In addition to implementing .device_synchronize in the affected DMAengine
> drivers, __dma_tx_complete() (and omap_8250_dma_tx_complete() for symmetr=
y)
> should keep `if (!dma->tx_running) return;` and check
> `dmaengine_tx_status(dma->txchan, dma->tx_cookie, NULL) =3D=3D DMA_COMPLE=
TE`
> (matching dma_rx_complete()).

I have not added this check. It could reject some stale callbacks, but
dma->tx_cookie may already identify a replacement transfer, rather
than the transfer whose callback is executing. It therefore cannot
replace draining old callbacks before releasing or reusing storage.

There is also a complication with the existing classic DW provider:
its status path can scan descriptors and invoke completion callbacks.
Calling it from the callback with the UART port lock held therefore
risks re-entry. The DW series [0] removes that behavior, but callback
draining is still required independently of a status check.

The intended guarantee is that termination and callback draining
finish before a replacement transfer can reuse the canceled
transfer's storage.

[0] https://lore.kernel.org/r/20261023-submit-dw-dma-synchronize-v1-v3-0-c6=
2bf048f5ce@gmail.com/
[1] https://lore.kernel.org/r/20261023-submit-sun6i-dma-lifetime-next-v1-v3=
-8-ef1acb0be768@gmail.com/
[2] https://lore.kernel.org/r/20261027-submit-mtk-uart-dma-synchronize-v1-v=
3-0-aad7a6b3c62e@gmail.com/

> We modeled the v7 TX and RX DMA cancellation state machines in TLA+ to ve=
rify
> both the counterexample traces above and the fix:
> https://github.com/ismell/linux-8250-dma-tla

I extended this a bit as well:
https://github.com/ismell/linux-8250-dma-tla/pull/1

One issue in general I'm frequently running into is that there's such a
large amount of correctness issues with this driver that it's tricky to fin=
d
good boundaries to split fixes up into.

>
> Thanks,
> Raul

