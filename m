Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F79606A31F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JqSL4CJA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFrS81qdGz30T9;
	Fri, 30 Oct 2026 04:14:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::535" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793294056;
	cv=pass; b=DVIfn6iZitiJUvnzcSJDKEI+n7wi4fIxVXGtrmFFqksILTFk96GmG2aGAwjPigmAdYHBiIQgWGASXxs3YLVyMXWxQcZg39YZRHmquZPvuESHFQIi39GMdd7pPoeRL7SUznh/E/RbkaxQbojmQemFh0532q5A3QxF4YUS2PHK/0cTkoW02OLDd3mCIJmvKJ/qiKwlOM/S2nY0bK/KSMx6duBVSrfPGKr2dBRJcOfPnolP4sXmxaPM/y/W21nP3jxcFeJ0x6jc/XF7vf57gYo93Umfd5YsGgIXxu+h4QV8MAOBgwbxj49K3fb4xmkqMv0qckV0H753+97Fw0WvAN4H3g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793294056; c=relaxed/relaxed;
	bh=FTbT3tgSxeUnwmRhmxtw1LLZfXKECJjTK/sp07zcT8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKRAyhggHURBKxtY/LS2MgwTU9Bkg6cz/yIsFPfv2iLBJyNtIHtPYvJs9tvIJGmQ+tU3nVnkSoxg2xSzfZyvUOIP53w3KkYGNULpIDyA30RQ8jQzwND6CV0ltFi63KsZModzbj6HLeWiLgXvV+Z0iSkP6KK+BWMO61BeRK9CuFwCjDEE/Iw3NF5J075SqOeO1cHj1QOK4uOExSMrUIZCTj2SQFbJfMasRJ0uHx9v9sU8HPMBcjXovCsZiF3eG0SVn+C+HiivdfWtpZ22b5FdauLzp0oROc+/jrd1Vd9SOduG37+t+OHhtjTo15UseomPB8IspKN09RKyycmCBNFpRw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JqSL4CJA; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JqSL4CJA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFrS61gjNz30Sv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 04:14:13 +1100 (AEDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so4491574a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 10:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793294049; cv=none;
        d=google.com; s=arc-20260327;
        b=c40qcZIw4ywlfk+ply/aBF9r7S/P5HD9aRsuv8fa+Yl3iHemW+EmmjRJGkVGxB5dEP
         P+mhAfbHfBTPuVA9GDbTxCtwv+MQqIbQuDsXjpcbrrVhB+zq7kCyHRSSdwvV1wMgqcz2
         3cp1465usxdlA/sp+7ia0vKyjbhnmruIH9NIU+igGQoL042qMJ1tYlSHDR5yvMHB/srt
         MGan4NFHn7h90F6qi780srcSHHh+x502X8S+3keaNE+hDm09I3DigtCIwfoScUO7HpBB
         r6ZYi2EFbj4xJaeYBiB0I8FwvvR+GrLg9fcnmuxtAT3BRWO/pedbcLgj8XjoVh2uVpit
         b8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FTbT3tgSxeUnwmRhmxtw1LLZfXKECJjTK/sp07zcT8c=;
        fh=SdbrC89E4EzO6LRq6c79sq6jt187HjQPA8Shq1FxstY=;
        b=lRQhAAPLJI6vsjgQLnIU+do8Uai6Wb/pmrfmgsCLMxGZVDvGIckl/bPwew1NbnDzp/
         +Xb/v/22RRzTDh2DhFSWbWoApqdTv9WJeb50ziBy1/wRie20ecPA/q4Py8Kmw0V4zfWK
         hG3AfTnE75/2tcXV7FHA/dBjaoFJ/63H8gtdCwRorZG0lZ3BVtNwlL1c/riZCsuw1cI0
         Nt5eWLQcR619bKO8vu+t2WxbVHm+E4z7rqB5t0AlvfQY6DbQa4YUEDGCrDGfQkaVhCDc
         0ojD6t86yDtn3IxYrf8y58orc9FTsn8mwIWwJEP6iCkZ1VBSvpN7sF6PHlvIfHjOqOw6
         4qTg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793294049; x=1793898849; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FTbT3tgSxeUnwmRhmxtw1LLZfXKECJjTK/sp07zcT8c=;
        b=JqSL4CJA6qkjPLkiFUTW8dVRsWOaA4rNv60JJg5ebmKnpdyXYGrkWJTtXzyeo8Oc47
         As++MTu7C+o0cVB+j9xn419eOg3riN+7QDTdV6MWDIGU5ztlOy1GWGdahUsFvRe4KMtB
         3zaET4buzKMDH3LB+7MP6jDcDb+N3CPtFi4atEVDN8kzQgUUkhsePuqA0MkeezxrWVHZ
         WMlMnogMKDtqE64chkP1MssPM7RLvPBxgCvKTku8lzgA16roTjtltImH/cSwsoj2Z3Wa
         4JRqNMIn9EbDCG3StgoT3OlNsjx4dxaKWLkQjNhC4eOde7RO8aCJOTbuLd1++305hG0i
         nFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793294049; x=1793898849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FTbT3tgSxeUnwmRhmxtw1LLZfXKECJjTK/sp07zcT8c=;
        b=Glj3fWwROwReyHtboVVi06LhGqwehau7bZ4+sHHJQPaGykzIltKanQ6nCgag3qXs0B
         rtsZaMXsKdZBNJKm6oq4lKJM3/suM1fK+q2thTxsQHJzHFzxJ2PNL+TSsKe+Oy/XHUik
         79vf/+nMygXVamtNkhWoCmPGYEPM/dnoTtQlvZgtaoPTr4kC2uH6Agfmfp5CTjgMKbAf
         RlS8mjNmvmA9W+5URgA7i5MmwR2cHIgQKW13y0NvU4tRpgadlBhUX0jD4mtlzYS+MwGH
         HYc31O0CgsKqRqEB+CR4kGMGJc8mjVS5kjrX5ccV2RIF9lDDOMIMDp53VadLeGrDq+BQ
         NgNA==
X-Forwarded-Encrypted: i=1; AKwUvBxAUfxuVUEPPipnIniZd0/EjZ0FoSYRl4UkKJP4UErhvpDDSAG1XLHKThPDmybk8MnbpVoznPOlLHHzo5k=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJXpTmasRgubvR+8jrKVNVFf8Etav2lmGYUdlCYZYAPB4kuvwRU
	IrudJsKuMmh8MjyfbdfgTJ2TEO9wX+cvxjqRDbu/8q0mevA7rLzwE3baRTzs7Y5vAcaQHK+36g7
	koXpRi+bGPizPKsfrba19AwCpDQrdGaM=
X-Gm-Gg: AYBFou1sMk5ugfiQUOIOdVIOaii2pmhZgISIivRG3zZ3TgiF3oSZ4eaDhgpV9LIuJYJ
	Ugc2QIxHcQiGiBR+pag9AShSBYZA9J7hABYcvTVupMD8WehcY+FsFDQoXQdaOn5GW5dTyMLTvF+
	vAdteNiUFuQorsNGruZlL0R5zSJRu0TbceIypV8YITd46EcLBsXaBDqY/MyTVom5cGUlF0YA7Cm
	tj2DJxSPUT7P0hUYzHbLUDxKe/tz34NRB/RMG+fZDitfVggQE7lmGCP9vAT8plRXKqorOKZKIUb
	csw7ijh7+OBedC+p6z4fbf6KbkteRRg8ixqNhdHs+FSr0YEzA7nGLWcsoTeZA7/CXvgP8Xa0hdN
	bKqDl3lo9bxk7qpKMQ/EWQwLed3l6wbSkBdc2BXh9J3SVes18YhVrKT2j51TMZKW0GHRfM1a8/m
	j0j0Ah+3J/Mn+TNChK0N37/u5MpHZ/m0AqwEx1X+ii9tml/P9hzYEhybgfW8qln7fo5z6TGW9FV
	58b9yfyeXJaS0/P4xeCwOWv3qkbYw==
X-Received: by 2002:a05:6402:1cc4:b0:6aa:9830:aa21 with SMTP id
 4fb4d7f45d1cf-6b49cb8eabemr4436038a12.39.1793294048534; Thu, 29 Oct 2026
 10:14:08 -0700 (PDT)
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
 <20261029-submit-serial-8250-dma-cancel-v1-v8-2-3fd56ba352ed@gmail.com> <auNVk_Y8iiAXyFa3@ashevche-desk.local>
In-Reply-To: <auNVk_Y8iiAXyFa3@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 11:13:56 -0600
X-Gm-Features: AclHuK8vSM1CWTDsGeWZ16QtCofwiUc2xcHxHUC_tVZ5DI3qrKZF21jWZD2zp04
Message-ID: <CADvTj4pwVF7u-6z3RUiHWGyG3MZGFU2WkytMRh0G16pdFwaotQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] serial: serialize asynchronous write wakeups with
 the port lock
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

On Thu, Oct 29, 2026 at 8:18=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 29, 2026 at 01:36:58AM -0600, James Hilliard wrote:
> > uart_write_wakeup() expects the UART port lock to be held. Several work=
er,
> > DMA completion and interrupt paths call it without that lock, including
> > indirect calls from uart_handle_cts_change() and the transmit helpers.
> >
> > Take the port lock around these notifications or their transmit helper.
> > Keep sleeping SPI and regmap accesses outside the locked region, and ke=
ep
> > the FSL LPUART completion lock held through its wakeup. Acquire the por=
t
> > lock after releasing private channel locks to preserve the ordering use=
d
> > by UART callbacks. In the MUX timer, publish available FIFO space under
> > the port lock and keep the hardware FIFO-drain wait outside it.
> >
> > Use IRQ-safe locking in the Atmel RX and TX tasklets and SB1250 termios
> > path, since their interrupt handlers now acquire the same port lock.
> > Preserve the caller's interrupt state when releasing those locks.
> >
> > On SB1250, lock modem-state updates after reading and filtering the cha=
nge
> > status, and wake modem-status waiters after unlocking. Take the TX lock
> > inside its service routine so RX-only interrupts need no acquisition.
> > Keep that lock across x_char handling, FIFO consumption and the decisio=
n
> > to mask TX interrupts: a writer must not enqueue data and enable TX bet=
ween
> > the empty-FIFO check and the interrupt-mask write. Each TX invocation s=
ends
> > at most one character.
> >
> > Serialize CLPS711x TX servicing and its interrupt-enable state with the
> > port lock. Disable TX interrupts without waiting in stop_tx(), since a
> > threaded handler may need that same lock. Have an already queued handle=
r
> > leave stopped output untouched, and drain it outside the lock during
> > shutdown before the transmit FIFO can be released.
> >
> > SCCNXP handles interrupts under a controller lock which its UART callba=
cks
> > acquire with the port lock already held. Collect the ports needing wake=
ups
> > in an unsigned long bitmap while servicing the controller, then release
> > that lock before visiting the set bits, taking each port lock and
> > rechecking the wakeup threshold. Removal drains the IRQ or timer before
> > unregistering the ports.
> >
> > This serializes write notifications with port-locked serial-core state
> > changes, allowing readiness and transmit-storage reservations to gate t=
he
> > notification without a check-versus-shutdown race.
> >
> > Cover DZ TX servicing and JSM Classic modem notifications as well. On
> > DECstation ZS, acquire the port lock before the SCC lock and notify wri=
ters
> > after releasing the SCC lock. Defer normal TX restart after console out=
put
> > to a worker, since console output can already run under the port lock.
> > Check transmitter readiness before consuming another character and drai=
n
> > the restart worker during shutdown and removal. Release Lantiq's hardwa=
re
> > lock through the transmit helper's completion hook before notifying the
> > line discipline.
>
> ...
>
> > static irqreturn_t serial21285_tx_chars(int irq, void *dev_id)
>
> >       struct uart_port *port =3D dev_id;
> >       u8 ch;
> >
> > +     guard(uart_port_lock_irqsave)(port);
>
> Why _irqsave?

For serial21285_tx_chars(), a plain uart_port_lock guard is sufficient.
It is only registered as an IRQ handler; saving and restoring the IRQ
state adds no protection on the hard-IRQ path. The necessary change
here is acquiring the port lock.

>
> >       uart_port_tx_limited(port, ch, 256,
> >               !(*CSR_UARTFLG & 0x20),
> >               *CSR_UARTDR =3D ch,
>
> ...
>
> Same Q everywhere (it might be legit in some cases,
> it might be too strong in others).

The other sites have different calling contexts. Workers and tasklets
can share the lock with a hard IRQ, and some helpers have callers with
different incoming IRQ states. Those need different treatment from
hard-IRQ-only handlers.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

