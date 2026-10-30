Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD8606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0CwH3GQ2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jG29r3L1Vz308H;
	Fri, 30 Oct 2026 11:32:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::92f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793320352;
	cv=pass; b=n0ByhedBiPLoqJy8sEm4tE08Hl4JXdXFpLLEcJXCsCNFe0J2q/FalBl/yWYV/gLU8BhM+DtlpS4UxX0xbcGNh7R8vXHiTCEP4wfU95Md5axuT6g7nTtdZVMIaSfWRZDOM3HHcxHevj2lgdyTZSuObgoFHh6Wzf54CR59ke430p6Nk4tKZWQX3PmeEAN4iRv9x6tW7CUDntaXyfYx2Ri/hIMz4os/0PM/Nqo0jcCRfnPh75GmuS6AzEYTnBoh96reMaTaZ28vKwwy4hWzZy/kIzX/XDAne7VUWOtZdb/OInMpefpMFykUiCFj+8dk6Ho2m56pxONxdnMtPHr+pChFZQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793320352; c=relaxed/relaxed;
	bh=eL/J2+RjMW7d7peZHUwlj8fhC1xc2jm5N4kIcoYsMvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iebnoLyV8pZIeZipE9kj8zRGzHOQatAbqSiHlYAy6czrkH21i61ia2XDYW5zYLeZkBNJIZcOT6FfNSIxUl3vmPGEgeCnES/zGT3lal1B1At3me0a3WzbJvR+QK2svP7JWsDeIne2AcugFZlvClg6WB2SCR+DWiD7kx5ru/V7/+gPtS3IxJ0dT8+DA55f0XMXtcYhfprBegylgbJOxHpSxE8uz78o6EJvuXJeRsEk+jQ4SKOAxl+osujIAyQYl8rWitPDOfiOdCKApeIC3tuzuQyfQqlokSuF8Nosl8V7j0dTpOQecTY01WSR1f0KxeGMkoUHmm9U8yERHpPou7QG6A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0CwH3GQ2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::92f; helo=mail-ua1-x92f.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0CwH3GQ2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::92f; helo=mail-ua1-x92f.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jG29q3DRPz2yYK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 11:32:31 +1100 (AEDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-9907fa1d2d1so37240241.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 17:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793320347; cv=none;
        d=google.com; s=arc-20260327;
        b=nCsi9PDO1zP3nhKq4TIn/UfoZB4sg+6guJ5hztKiOcFz1L3lQ1d9uBDD8TLayvHTQa
         JZwg0ikLHfHdJPlfAz4kSffPtkT4BALpkxZpy6x7Ba2ffa1QbHOc974icrlFBpNrJjex
         Lx2vqDPedWOVShKzZLXzTs2awv/ZWDCCTQKqMUwfOFkVg+91qlKOEOcQ3cHGHM69sMh1
         6NSg6oIi5o/qpxUgTvmOJGWX8B4WE8UqgAanbKFnkXu+94W10Wptcx/FJLVWdUDLeLRq
         FQSWJEhGvMfkc7oKw5EufuM8IAV/Gjvqh249CvSu5+7I6gLlLVOL8TFc5pGN+vtq8psv
         9sPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eL/J2+RjMW7d7peZHUwlj8fhC1xc2jm5N4kIcoYsMvg=;
        fh=9Xm3ybALkQ7TiMuyquWOKJMixYPqrtDs4devaAj+oR8=;
        b=cpMFtxQk7cPD4hKrTsJ3oEH1J0cgpMiIL+34QpM3Rdj3eBDsEdY9ZWzc7eCb2EQ9+U
         N4hb2tbmyUTwOeXyYB17pBbbABE8aAkewSuSkL0xJ0WDagVXai+nwXZS7/b/wyHkIsPT
         J+HgPTgVUQJc0lEoZCwXphnpCdFetAbbt5rg+Hn1p8GLW8THO602ak6LD1ChLvqYqC4n
         vgwdzhtgQ7XEpE/5/i9tBodS6DHDCIERToMtH22FuGXo6e0+Dr9QE/AcuMQWXMQRIraS
         fnNbs8VepmFo235yZLMZEDeaUAiKGngDAClEm/pIBOBq+e3+e7lejlWHjWHcY8l7u+Eu
         aqog==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793320347; x=1793925147; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eL/J2+RjMW7d7peZHUwlj8fhC1xc2jm5N4kIcoYsMvg=;
        b=0CwH3GQ2IlMdWiNP4Wqt70g1NrkvBT5pwf/wbG2Q+tpAx3+YTlVlD2EGEaWaSvpC3/
         7AZWJuKn20ok76aDE0je+O9/FaMoUFAPRxFeoOp6WP4fqFpYh8t6DaDhGrgwVWMpIM4a
         p4uVqQLaE1XNnI4KyeKbJ6iKdpwYpGhZBkbZiB9FojddVBaCNyF07WoWG7190o2IUGZM
         ywaoOFeOccJ8dIHTsMYmHpLUzcG2O5x+E4keCjOqkFwkGqc3yyiRigqvsazuiOlKb+wv
         ZtOiE4LnsyMBx1SXbTs3ofc3cWloeaGOLudcWJHGAOB5C5FluXJBblCb+RHHSVyI7z6d
         bwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793320347; x=1793925147;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eL/J2+RjMW7d7peZHUwlj8fhC1xc2jm5N4kIcoYsMvg=;
        b=02SINFkO/bsxwWUKFMI8bxs2zDKEoUMsyiuPOdA+tWcDn2Iv69F1gq1KWGEJtQwYH4
         lEmHS0zSRbHx7iaXSaLKaBBtyQ6RGD+ei+D+qzw+r3eyqDhYYHXUbThzn6wcq4qQL6rw
         9bvJgde1sO8iBtCRPHlM75rMlMapHWRzEpunnG+VMduOz6wJjP5Jw/BX2Ur7xK7v0z/3
         EPeT/M5FhzqEE6I0r9adc9IwWc9gxStK3c3hn+lUYXn27sJ1TA9CIFcZd27jSBoDBwNR
         c4G4aUcECt6HELjrIQxQqxz1Y3y71CoUITr449Jq3Mcz5D/h0JNdOP+cDnXAlheE+TE1
         56Lw==
X-Forwarded-Encrypted: i=1; AKwUvByOUjn9m25jomWMU+RiPPWAMjcEZF8cf30uGLpiwx0g16smlCiee8E7+zj31jPaxQlspeOU7vrSsk2rHQ0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLk3Cqmhigu9jhibMghK6CBt2cyfCQa5va7qrEkTe+BNsnnvgDn
	vUvp3J8oB4Ir8WGbBHi3f35qbkXuU8mDLvJodTGKVvvmHExDukw3RC4n8rUBYKQ0woJ5Bqcmh2H
	wDsArGW6+2T8VGTEWXVI0LPlWxnX4BkI=
X-Gm-Gg: AYBFou1N5jJ9jvmer73iCrInDh1lKifAAwJq18WpBZnduFVaXHdcAqgFzAXbR/YGREf
	ySszARm7vpZBKOt4w4A6/IUHXDlW9MOttBAJdQSydmdyf2r34HeNg3Uvkr12G988ss1Ql4SHDkk
	6D1U6T5uKw4U2A9Y5uBj35URPala5PLyFxvNxjdD8RQuSjEJQxR1nqBPe+c//lQXHUUYvzVsMRS
	PmL8p4C+Qt18KORanucpWYIFNHJ4Q3XqI06JmnWuQna4QNl7fLvBZU0fI0idQUI2Feabw4PbQNY
	TtpKR+uhEkXvUcTIgqDh2KTxnQV3XKTsXEKRXvOy4q+OCqsPRcyLueH3HuuHvT6AEGdzDpMpXWW
	2T5qfvWLNVMDL3sejjjW6VCIR2eibrQPqmZ1qX+aPvr8xOYV71ynlvj2FIBxsVd6PWZVOgtevuw
	Yq8IPrTS0nEnuxyHcrVGZncZSZIbaESz3IHNRd0C37C1UhW0fmBk+vPv2HkKzHvfS946TLFihz1
	0eCiUTtpC+ZfvO5bcrLQ3r5Lr9qyxg=
X-Received: by 2002:a05:6102:290c:b0:779:5049:87b2 with SMTP id
 ada2fe7eead31-7d0723d710bmr492388137.0.1793320347401; Thu, 29 Oct 2026
 17:32:27 -0700 (PDT)
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
 <20261029-submit-serial-8250-dma-cancel-v1-v8-5-3fd56ba352ed@gmail.com> <20261029222734.3086943-1-rrangel@chromium.org>
In-Reply-To: <20261029222734.3086943-1-rrangel@chromium.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 18:32:16 -0600
X-Gm-Features: AclHuK-iYJ6lzjlFUVN3seH1Gc5KBaAl343rbNN_d-8c384kErq2Nw5ubYUVG3Q
Message-ID: <CADvTj4qK-1SX_+YZW1jdW-e5JOZ2iz3vAK_8UvkyZWb0rAeyiQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] serial: 8250: retire canceled RX DMA before
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

On Thu, Oct 29, 2026 at 4:27=E2=80=AFPM Raul E Rangel <rrangel@chromium.org=
> wrote:
>
> Hi James,
>
> Thanks for the v8 updates and for opening PR #1 on the TLA+ repo! Confirm=
ing
> that the v7 issues in Patch 2/6 (lantiq, dz, zs, jsm_cls), Patch 4/6
> (__dma_tx_complete tx_running check), and 8250_omap.c shutdown locking al=
l
> look resolved in v8.
>
> On Patch 5/6, we updated our TLA+ model for the new rx_pause_pending work=
er
> retry loop:
>
> > +     ret =3D dmaengine_pause(dma->rxchan);
> > +     status =3D dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &stat=
e);
> > +     if (status =3D=3D DMA_ERROR) {
> > +             ret =3D -EIO;
> > +             goto recover;
> > +     }
> > +     if (ret && status !=3D DMA_COMPLETE) {
> > +             dma->rx_pause_pending =3D true;
> > +             serial8250_out_IER(p, p->ier);
> > +             return ret;
> > +     }
> ...
> > +     for (;;) {
> > +             scoped_guard(uart_port_lock_irqsave, &p->port) {
> > +                     if (dma->shutting_down)
> > +                             return;
> > +                     if (dma->rx_pause_pending && !dma->rx_terminating=
)
> > +                             serial8250_rx_dma_try_flush(p);
> > +                     retry =3D dma->rx_pause_pending && !dma->rx_termi=
nating;
> > +                     recover =3D dma->rx_err;
> > +             }
> > +             if (!retry)
> > +                     break;
> > +             usleep_range(1000, 2000);
> > +     }
>
> This cleanly resolves the race where a full 4 KB transfer completed in
> hardware just before dmaengine_pause() ran while its DMA completion hardi=
rq
> was still pending (once serial8250_rx_dma_flush_work() drops port->lock a=
nd
> sleeps, the pending DMA hardirq runs and marks rx_cookie as DMA_COMPLETE)=
.
>
> However, what happens if dmaengine_pause() fails on a *partial* RX transf=
er
> (0 < count < 4096 bytes) during a normal UART_IIR_RX_TIMEOUT where the re=
mote
> peer stopped sending and is waiting for a reply?

With a persistent pause failure and an incomplete transfer, the
worker keeps retrying. RX remains masked and the runtime PM reference
is held until the condition resolves or shutdown takes over. There
is no receive-progress guarantee if the peer remains idle and pause
continues to fail.

> (In PR #1's Serial8250RxLifetime.tla, Spec puts WF_vars(ProviderProgress)=
 on
> Receive at lines 67-70, which forces the remote peer to always keep
> transmitting until count =3D=3D Capacity and CompleteInHw fires.)

That fairness assumption cannot establish progress for an idle peer.
The broader local RX lifecycle model includes permanent partial-
transfer pause failure, but checks ownership safety and close
progress, not eventual reception. Passing those checks does not
establish recovery from a permanently failing pause operation.

>
> When the peer is idle after sending a partial burst (< 4096 bytes):
> 1. Hardware never reaches 4096 bytes, so status remains DMA_IN_PROGRESS
>    (neither DMA_COMPLETE nor DMA_ERROR).
> 2. If dmaengine_pause(dma->rxchan) persistently returns an error (-ENXIO,
>    -EBUSY, -EAGAIN, -EINVAL, etc.) on that partial transfer,
>    serial8250_rx_dma_flush_work() loops forever in `for (;;)` calling
>    usleep_range(1000, 2000):
>    - It holds a runtime PM reference (`guard(serial8250_rpm)(p)`) and wak=
es a
>      system_percpu_wq worker 500-1000 times per second until the port is =
closed.
>    - RX interrupts remain masked in hardware (`rx_pause_pending =3D=3D tr=
ue`), the
>      partial bytes are never flushed, and the port never falls back to PI=
O.
>    - On 8250_dw, dw8250_idle_enter() gets -EAGAIN from serial8250_rx_dma_=
flush()
>      while rx_pause_pending is true, causing dw8250_set_divisor() and
>      dw8250_check_lcr() to silently abort baud-rate and LCR updates.
>
> Since the only reason to retry pause/status is to let an already-pending =
DMA
> completion hardirq run after port->lock (and local IRQs) are released, co=
uld
> we bound the retry loop in serial8250_rx_dma_flush_work() to a small numb=
er of
> iterations (e.g. 5 retries)?

A failed pause with an incomplete cookie does not distinguish a
persistent hardware fault from completion that has not yet been
published. A fixed retry limit does not resolve that ambiguity.

Terminating after the limit may discard received data, including a
completed buffer whose completion is still unpublished. Successful
termination would make subsequent buffer reuse safe, but would not
recover those bytes. This would therefore be a potentially lossy
error-recovery policy rather than a lossless timeout flush.

> If rx_pause_pending is still unresolved after the
> retry budget expires, calling serial8250_rx_dma_recover(p) under port->lo=
ck
> will set `dma->rx_err =3D true` and `dma->rx_terminating =3D true`, letti=
ng the
> worker exit the retry loop, run dmaengine_terminate_sync(dma->rxchan), an=
d
> switch cleanly to PIO.

That requires termination to succeed and callbacks to be drained.
If termination fails, the channel may still access the FIFO, so PIO
must remain excluded.

The recovery requirements depend on why the provider cannot pause.

>
> We pushed the updated v8 TLA+ models (`Serial8250RxDmaV8.tla`,
> `Serial8250TxDmaV8.tla`, and `./run_v8.sh`) to:
> https://github.com/ismell/linux-8250-dma-tla
>
> Thanks,
> Raul

