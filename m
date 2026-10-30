Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC1606A32F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qDbuwhzd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGSJz0JHMz30Tf;
	Sat, 31 Oct 2026 04:10:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e2a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793380210;
	cv=pass; b=aYjRLn2m+afeY/XGfWsBFymjb+AEetfLSPCKTCAuoxlV69guk/pzfTp+IVBc649ZJgYPKtEnoFV4eLS8hJZnkfL/nc3Op1LG9dTb9HW2sp529bhHhGsMXO16kpvNGDjgc9BuTww66SjDE0fZXtZU+axYjhJRv3JWi9Q1Z6j5WuULpEg7h+7lINHiH6ZxrzXbIfgNl85yii8uXdTShCMHn9j13CkItcCrWp+ZEXsbcPff1o3gEXTkFcfPGZwvJHZElmYZxFrw8kSBPKGIXShHttELE2LE0KEkLZ7NOp7kCz/6hber1cVQvSMpztRRhw5NS1+oxD+gKT6sQVLJmCKAlQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793380210; c=relaxed/relaxed;
	bh=upOYi42AukgDUPkY3CbfHszXdyIJTLIGDSDpKiK4vxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JI35gxNmgUHhvITq5wec6/JFwLPLYPdLF8VU+DjAH1ZL3XUJc7yGfvLe4uHBCUKcfJ+x/NcVKC4a/dS+Q7qMWGVDUh1ebywwigtLRtMOVKLx9d0gM8g3SggxT+ab7ftT3ITCJpJcptFLTc1MNUkpCnCOkIghnGbCKuByn3s4f3nf6yOxRbtYHsEEuukZ8pFCR2nhg+FiJtVt+U417mBY1FkyIlsFl0J0nGUDYv14h9y76m5VfT55y4esiv4YAXNNPRpV+VEGucv5Rvoqyk5zAt1wltmgK3Z4RXmF68zyKSYKQlBBvwtaf7qH/unhiNLTrNECbp/EGAzxUnfbLuiUrQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qDbuwhzd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e2a; helo=mail-vs1-xe2a.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qDbuwhzd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e2a; helo=mail-vs1-xe2a.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGSJx527Yz2yGT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 04:10:09 +1100 (AEDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-7ccae9f1a9eso512400137.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 10:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793380205; cv=none;
        d=google.com; s=arc-20260327;
        b=TL8pQpb9lcN8eCpf6mGzzeW9yXUdBACyPmrvucy8M4tM8ihMtA/Rc2fp4Ytui0mort
         0NrLZuQAdvUlnbcsT2cTS4R7qEHDzVCXnO72wbQmneAxW6QxsP2ZLC3lLnNgyYabATAR
         v46sutPZNB/ZrPHPgU7Rbl/bamGGFgOOp+C0RyJUd75PPXthkVQ0vn1a8XR9WzA96KA4
         1T6OBzJeo5BI8+QUlZPECng2pZB4v4h8lNQ5GEdKY4wfSPkR26Qruu8xR8cjLZGeM7Ll
         CBmr0nYbNzm8TwOH/GIX7oQyLABtm00RQE1ADxl4tJImIwXsdu0DENYCgdLneGb1zhq5
         2PPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=upOYi42AukgDUPkY3CbfHszXdyIJTLIGDSDpKiK4vxs=;
        fh=ZWKceQ6AZUEl39CyyJuBcyj2Wcsz9Qo6wt+6Kr0VCuw=;
        b=F32kPyV/M3yoq7q18PgvXHCMd4qpbvT+ZFvUMWzFHP7XysN/flkI4WrZ0WAPRV0rxY
         9TpXwi2IEEsyrMfpVZREe2lBa79qfkxPduSfILr0MvXq7VTTKChJNV0FzLdpV18ES5Rs
         aZrKfYPiKWhr92v4XxhiW5gkKC9QZaMj72koAUXujnInXqruBgwdspdiVlezE57EGfz/
         g64RN/0q5FBcBU4tXZ1EXh43B//At388qa4I/VtHNDXjRd7j/8asVfGqiaea1wVm+s0r
         EAWUQbi0YmXfXiAfPCbgc+Vmg0RDcphRCuCglSgqqaf5mL7hvcBYBBnCj3jMWU4wy7Rl
         hQ2Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793380205; x=1793985005; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=upOYi42AukgDUPkY3CbfHszXdyIJTLIGDSDpKiK4vxs=;
        b=qDbuwhzdAPTK/8bbNQY3IIRTN/YyRhV0HGuoWnfcfAzpOWgAOuTjX+EzQ+mj27Hp1t
         yoPat648/++XycW4abwIsXO+xWks8kkNBT8Gg9qH6pOowd8Q5qu+3KNWQolpUYcL9vsl
         2l98z2cbBwOBY1h4S5E+oIU2NDJY0CpSgk2O0TddTjkQsQxc4UtRQ6nqAISYk49nfz+f
         iYgcNreXrwPUkE6Qq3aERkZTXLy+hk0t8g9NCxCyzHXx+bgLc3rfAlSbiFMYNrrFWBns
         +n+Hs/2YmZ7exsfFsvMck2Pb2khEZhOd46NOFIh+UhuREHwU880ffIXlHiWD39OpeqZd
         lTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793380205; x=1793985005;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=upOYi42AukgDUPkY3CbfHszXdyIJTLIGDSDpKiK4vxs=;
        b=rNIWd87+ZVqpxfNPipAJ8aV9P+YS8eNGhjf1TY+0oNaVv0JghdF1EmbeheTbM2vvYb
         SxR9kj+xwNN9XMuRbsCMRXDsZmxBmgZtJIOvfqvPmT5wVPiCoRy4X+9Z01B5Diuv4cUo
         zToIu1tiu6uBLywLnyKkFXAfgiTGxapQV7fFrz4C3AkhuamTa/GGubsqx8VNl/SHuMIC
         tCcZW9UOMFdSk4aA9CGxvAv0CawD47R9TRLcwLkWIT89uaa3i4omn2/AAUmimPmV1A8Q
         J+X/yzIkKghcpPYL+t04CSUUH6e/yh2sBTYL89EDvi2PqgEN6xdU2wPw3rKUEWW/onEN
         jE8w==
X-Forwarded-Encrypted: i=1; AKwUvBw000y927eXkQFkmyDveFAjAHh2xKOIzGxaiwi3KjN9EBJJh7fQHWqMUpo0mQBwHsG1zdiEsZNfVziHATI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLzj1t/U196vRD2QUXSU+7wwnfBBAnnZt0Hys45h2n36zJhuMVY
	fOQKyMJadP0GaniTer9OWT+NZZM1IxZRcTdaD2cMxBwHVNMcumexTP1AKCxDhiXx2nHz4jxK3vI
	o+ZJAW0eGaYnSPDyOkRLVAHyD6SGypSc=
X-Gm-Gg: AYBFou05Mfl2QoR2Ztg5BnrAE4rD7mBolNrGp/hJzSd70/zkWeItx9RwxcO+1NAXmj/
	gqWTmmFvCQ5IvLfK9PjvnXu2V24Se/HG9P+wmpO3toNH8GXgJ1Ao2USTGM583tzcMmqDEmU3Lhk
	z8aqucIH47IOMhlY4MIOzGfuCPQjEV7EVI/9MGxrFUTQs19sxvdbh6rlmD5fdyg9NZ/l7HIMCPn
	7YDfBRedPaILV+0Soim4CwVtFfh0oJDBJCKtz99c4Ump9ti6msCNXuY9Oi2KVLjCQNz/jgcFkd+
	1WIiIEjCMEQEKoQxkWvGLmwvIUcGddhOSYb9HjN3hzlg/nwiXOqsimH9i9fp7WtZCjmODzje343
	UzZl4aWd8VI8PGSQgWP5GbtC4w61xnBbJsSbU9VcStvzLeTjeAt98lVDZahcXTjaR60degXq8C3
	/wBKTZAtq6snUdC17FEIGA5Bom45zObP0sWfr4mnZvgAqCRgH/dVgDnG8JDY8eoA0iBvdTY4Ngv
	58E+4y+gWJMtFqXkZq/lV3WNh27Juw=
X-Received: by 2002:a67:e10d:0:b0:7cc:1a41:20fe with SMTP id
 ada2fe7eead31-7d072cae2c9mr1521484137.25.1793380205451; Fri, 30 Oct 2026
 10:10:05 -0700 (PDT)
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
 <auRl9ztbav4nHi7U@ashevche-desk.local>
In-Reply-To: <auRl9ztbav4nHi7U@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 30 Oct 2026 11:09:53 -0600
X-Gm-Features: AclHuK8FtznzJujmH4YHgrWNDCpi98ee8eK0vX_qbau-y3ULhcsZAztidkT31Us
Message-ID: <CADvTj4p8tjwdftg+H11ob0iaBZKxXrTdkSmhfZHjOYunm5tr9w@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] serial: 8250: retain DMA resources when
 termination fails
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

On Fri, Oct 30, 2026 at 3:40=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 29, 2026 at 11:19:59AM -0600, James Hilliard wrote:
> > On Thu, Oct 29, 2026 at 8:24=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Oct 29, 2026 at 01:37:02AM -0600, James Hilliard wrote:
>
> ...
>
> > > > +     while (rx_ret || tx_ret) {
> > > > +             dev_err_ratelimited(p->port.dev,
> > > > +                                 "DMA termination failed: RX %d, T=
X %d; retrying\n",
> > > > +                                 rx_ret, tx_ret);
> > >
> > > > +             msleep(100);
> > >
> > > Huh?!
> > >
> > > > +             if (rx_ret)
> > > > +                     rx_ret =3D dmaengine_terminate_sync(dma->rxch=
an);
> > > > +             if (tx_ret)
> > > > +                     tx_ret =3D dmaengine_terminate_sync(dma->txch=
an);
> > > > +     }
> > >
> > > This is unacceptable. Sleeping is okay, but value should really match=
 the
> > > baudspeed and other parameters of the transfer.
> >
> > This sleep is backoff after dmaengine_terminate_sync() has returned
> > an error, rather than an estimate of UART transmission time. Each
> > retry asks the provider to stop the channel again; elapsed time is
> > never treated as evidence that the resources are safe to free.
> >
> > The particular 100 ms interval has no hardware-derived justification.
> > However, I don't yet see a sound way to derive the retry cadence from
> > baud rate either. RX can be waiting for input, TX can be held by flow
> > control, and callback retirement is a separate requirement from
> > moving bytes through the UART.
> >
> > Do you have a particular provider failure mode in mind where retrying
> > termination should follow the serial transfer timing? I'd like to
> > base the interval on the condition that can make termination succeed,
> > rather than substitute a wire-time estimate for an arbitrary delay.
>
> Termination of DMA sometimes require to clean up internal FIFOs and other=
 state
> machines. That's what happens on HW side. In the software waiting for too=
 much
> may lead to the very big undesired latencies. The value of 100ms sounds i=
nsane
> to me for the HSUART cases (megabaud range of speed). Also note, not ever=
y PCB
> design uses HW flow control, so this may be even worse for them.

The 100 ms interval can add unnecessary teardown latency if a failed
termination becomes retryable much sooner. There is no hardware-derived
justification for that particular value.

The FIFO/state-machine draining is part of the provider's stop sequence.
For example, DW performs its FIFO-empty polling inside
dwc_terminate_all(). If termination succeeds, this patch proceeds without
the retry sleep, regardless of baud rate. The sleep is only reached
after an error during DMA release, not during normal RX delivery.

Baud rate can influence how quickly a transmit FIFO drains, even without
flow control. However, the termination error does not tell 8250 whether
that drain is still progressing, how much remains, or whether the
controller needs a different recovery operation. That distinction matters
when choosing a retry interval: a shorter interval reduces the added
latency, but does not establish that retrying can recover the channel.

There is also a specific API detail here: dmaengine_terminate_sync()
returns immediately if device_terminate_all() fails, without reaching
dmaengine_synchronize(). Consequently, an error leaves callback draining
unconfirmed as well. The retry cadence can change, but resource release
still requires successful termination and synchronization.

>
> > Regardless of the retry interval, shutdown cannot release the buffers
> > until the provider establishes that DMA and its callbacks have stopped.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

