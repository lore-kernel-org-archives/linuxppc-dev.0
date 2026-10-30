Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C7D606A31E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HZfuEdmz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGTd10wKfz30VX;
	Sat, 31 Oct 2026 05:09:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::92a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793383749;
	cv=pass; b=lfc58rAo9rV/N5jaQKggTxRQT2IrX08A7v/jIgRs8bQuyOgsUPncp/YWDLxB1cdIvp08wp6HdfSLMJW0HTwR26GXClYJuNFguc8JGlceqlchs9MSHgxC6EBQ2+/K5iRH6wQqG11W5TLXxsqzWb7wx0vnFkMe8agUSV58KgQfmtV7OKo6Dh946sHhVE4NIzKiktzuFSJ8OOsrmEb/eurOrsK0dzqKnj/wnj5CfRIGXKXoUWIAzeRBMoncWt8MewtoIbNH2YjcjmYbdfutYByoht0CZxnFoxjn895w/YxkvwK5dv5r0rmhoVQ1a/d1tCt8WIR+oyxRhiKy2MmX04E64Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793383749; c=relaxed/relaxed;
	bh=zCM05k2C0awIth60s9Z4jRxjplzssn0gUpe0d+ZqU04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leLMv69tCbnEYYkMzeV3m3UePsyfcthcHIGebaNpMQOE9WilZ4cMy2dq/TlQEumalDMNpYPpx5Lh10gZHNdW/JjXxbDi8UzjIqMrj2q1+2PvTOc9YQ4SygWH6EXl3cvMe72NnvG0tLSGcn1rseyYwwf9OsbooLIkDtwaHjNWEmtn/7n0YeUq0KCdtK0b2smTDZRtL7ZDT0TXqKe5AwNi/vDyLxKWAq8SXkC86epyIWupdbco924uxMCKhiZ3+KFL+/xvXjbscIGRyFOd1YVNRv4470lbnuB3wEyk376UTn9JhsCwYUZeYDpAXOkGa0RUv411mTTx4C1g4iqaeywYOA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HZfuEdmz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::92a; helo=mail-ua1-x92a.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HZfuEdmz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::92a; helo=mail-ua1-x92a.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGTcz48N4z2xwN
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 05:09:06 +1100 (AEDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-9908346255fso1183071241.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 11:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793383743; cv=none;
        d=google.com; s=arc-20260327;
        b=WQfka+W9ZA44sOPGcfabYFTPN6mxVMLO37qeBLUMRG3MVNgEhHMbJNyY3aXNF7VSuj
         +MnfMpAHQ/FlhgF4s46jJvoS2NSGEciXbeKzvZcLjPkY/UyFFUk1ZkiZfqZsucTAPqoM
         kx7w3miQciWleq2ZOpHc5wxy64sKB1VEdAhfFmgdtcFZY7Ou7LP+9VNjmNzDEMflDhF6
         r42VCZqW3Ll6aJ6h/tpB0iyRkXrVdl2hePfdU88yNgfsc2cJaDatu0gt23SSKazBoP5r
         tUQ/6HuXRWDb625w2FJwMIBjhV3wAfE7NGcZhGLiDi3bqzHr2XOK8mMsjc/FzyRh7YZp
         k4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zCM05k2C0awIth60s9Z4jRxjplzssn0gUpe0d+ZqU04=;
        fh=ulq+f0fv86kvTTkiLxGQlbE1ALN7PGaIfaVYajronqU=;
        b=s0/W8/jNhQ8+/RNU8cpHbUaDTq4bXJ0E+NZgaSKd9Cb4UTP1KumQ7bYSSiW295XRln
         XlphirqLbXqulSBbkifc15Tb8Pa5775kjnkLZsWSgIl3Jidf2GdqUWRYm6v2RtKvqESJ
         2kSpf+s3d58PuWp+0OLegkpQhkCaRe/N52n0B2ZGyln4bdQgrB5eKGhPNM1H8oc5/5my
         xdf6OJQD8OnqNCnvxxayqDpEEAGmoOY4D5GkH0CkbZWot10uEWujkGMlhaNDaKkmvK/k
         JHPENo4REq8mtGm8WyeR9LiBP1vf0qND0Gq2o6YFWw9hxXoKQQXOkvxg6iOdYv+q33X9
         5LiA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793383743; x=1793988543; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zCM05k2C0awIth60s9Z4jRxjplzssn0gUpe0d+ZqU04=;
        b=HZfuEdmzet7xDqaPknRRSJSYyAs8d7zCtExXAFzCt0JpuGI56NJjaZi4QnODdRjLHK
         ejqXHMe+SYItNk+wSzJZxjzA8xZQ2ThYbEmoNo8YqXr476w2VKn+k+sAPFYZ5Z9mGqhu
         IhcuoDnF2EM/ACsbufGtFuknunWh9nkR94xcXuIW4kllrJtReoTEjLKzJ/89OYrqbU4z
         VBVh+1HyRq+Okmij0rLQSDKfddTSsfSM5gKaTns5GKItlWyhicvlkF17Ta2VUrbVSN6N
         xS/PPerlaDVrGfBUBBuqgDyzRRHOFpL/oybloH9J+An8svJadGImS/JwHTprBeFsP2kK
         4AHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793383743; x=1793988543;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zCM05k2C0awIth60s9Z4jRxjplzssn0gUpe0d+ZqU04=;
        b=h9nAPsKDMRyckASmm2mthL11+ol9LILv5jIi9Wdd+c7q40lwxVe9xCHrl1isw9L3Cz
         WhnLUqL+nUHkTzd01wmpH77HpD3N+n5mG7M1Oi8dTyn5SFGXSzkDy2GuFQvDTDpyLKwu
         0JuUrb+fW8q9v9rCRZ9LrAlJeUhTLT0/6JgkFYBdofaTtg1UyL4wyCmf5zcRE+R1GgLp
         trtP+24sBLgTo4E+lwAO6D1qzJ3AB95RppcZqySxCTY3pgMUriosoQUutVxMbUuVOzLz
         c7aE90oG1DqCKxUDC9gfZMXbeI2/Nm4GCwgzn2vNpn09XYj5xlnDtMwZbF79RK2ZPrNo
         J9dA==
X-Forwarded-Encrypted: i=1; AKwUvBz/Dar/7jbhdVwq/Ja7GFws7Q0oqQ4w9f741veNmdo/83+IwMQnmaxMH+Txk734yVchLlVpag8JrUXw3LI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIsPzadsh/gnjePQ3RsjMaEJ5xZtiwQO2OO+wrlT/iRVMJiNOTq
	jAOWdto821/anLKO0MWor7uqUh8bEey3b/l17eWBD6cKQZX+EME/rnC31OC/s39mHl2Gj+MBvg+
	fG3igtBu6l5DOsQkimMXwcfyZrFuFMlA=
X-Gm-Gg: AYBFou2HYrvZqd+VNbND0SgIzgoMFLAFR+s70TmXN0a1Dx8X1ebrX94iTByt88WdwtP
	bBgliOwmVK06Cv6ulfujq2KD2RwL9Oocb/nO/P+h6g8/+RW92nLR8S7QL9ksgVJXykPd+t7/sIa
	YlEW1lmoHG3cousOQ9C4jeVtqg0BAqMCayXQirrYDLa5KG3pXCeUM9LMtE8HBNAW57TJvg6xYSv
	z9KfSi4RoXeqmwIKQB/5ayBU3c1Nj5X90FOjnJswU6OMY6+XiwcFHsVpFnkrcDo+1DBu/J5eMhv
	eILz1GCzWcWuCx2aaKY5eFbaXNf8BTKBuTQz0rZaUhuQjblS4nDMGoBHExfjBqlj5v8jnvsEEnD
	2rJJdQxichagKvoKfbmU8Aw0r2OpZxbjqsntbQwthwZyVuOcqI5FyYd/5IblIwdIa17QDODZJl1
	/QMeUsQnRz+cMXg6awIYlbVWxkCSlwS637vjpsF0/XWrep9YtbRwQiZ5CtYl7zad/Oq7Xf6DjHF
	4OBPSKLalZOhImICa/pwbScsTjHQg==
X-Received: by 2002:a05:6102:e07:b0:7b3:9d2e:c1a2 with SMTP id
 ada2fe7eead31-7d0543af600mr2250112137.42.1793383743550; Fri, 30 Oct 2026
 11:09:03 -0700 (PDT)
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
 <auRl9ztbav4nHi7U@ashevche-desk.local> <CADvTj4p8tjwdftg+H11ob0iaBZKxXrTdkSmhfZHjOYunm5tr9w@mail.gmail.com>
 <auTZtteCFnuoMD3p@ashevche-desk.local>
In-Reply-To: <auTZtteCFnuoMD3p@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 30 Oct 2026 12:08:52 -0600
X-Gm-Features: AclHuK8c5dKv2-dU28EFYCOPnAfJ1MA-zFVMtXg5QQ7p9buAg8gKSWCKNovPJxw
Message-ID: <CADvTj4rXXAEnTyu_AzpF41a2YSHHG1ANozCUSePBoH3QZYbBQg@mail.gmail.com>
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

On Fri, Oct 30, 2026 at 11:54=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 30, 2026 at 11:09:53AM -0600, James Hilliard wrote:
> > On Fri, Oct 30, 2026 at 3:40=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Oct 29, 2026 at 11:19:59AM -0600, James Hilliard wrote:
> > > > On Thu, Oct 29, 2026 at 8:24=E2=80=AFAM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, Oct 29, 2026 at 01:37:02AM -0600, James Hilliard wrote:
>
> ...
>
> > > > > > +     while (rx_ret || tx_ret) {
> > > > > > +             dev_err_ratelimited(p->port.dev,
> > > > > > +                                 "DMA termination failed: RX %=
d, TX %d; retrying\n",
> > > > > > +                                 rx_ret, tx_ret);
> > > > >
> > > > > > +             msleep(100);
> > > > >
> > > > > Huh?!
> > > > >
> > > > > > +             if (rx_ret)
> > > > > > +                     rx_ret =3D dmaengine_terminate_sync(dma->=
rxchan);
> > > > > > +             if (tx_ret)
> > > > > > +                     tx_ret =3D dmaengine_terminate_sync(dma->=
txchan);
> > > > > > +     }
> > > > >
> > > > > This is unacceptable. Sleeping is okay, but value should really m=
atch the
> > > > > baudspeed and other parameters of the transfer.
> > > >
> > > > This sleep is backoff after dmaengine_terminate_sync() has returned
> > > > an error, rather than an estimate of UART transmission time. Each
> > > > retry asks the provider to stop the channel again; elapsed time is
> > > > never treated as evidence that the resources are safe to free.
> > > >
> > > > The particular 100 ms interval has no hardware-derived justificatio=
n.
> > > > However, I don't yet see a sound way to derive the retry cadence fr=
om
> > > > baud rate either. RX can be waiting for input, TX can be held by fl=
ow
> > > > control, and callback retirement is a separate requirement from
> > > > moving bytes through the UART.
> > > >
> > > > Do you have a particular provider failure mode in mind where retryi=
ng
> > > > termination should follow the serial transfer timing? I'd like to
> > > > base the interval on the condition that can make termination succee=
d,
> > > > rather than substitute a wire-time estimate for an arbitrary delay.
> > >
> > > Termination of DMA sometimes require to clean up internal FIFOs and o=
ther state
> > > machines. That's what happens on HW side. In the software waiting for=
 too much
> > > may lead to the very big undesired latencies. The value of 100ms soun=
ds insane
> > > to me for the HSUART cases (megabaud range of speed). Also note, not =
every PCB
> > > design uses HW flow control, so this may be even worse for them.
> >
> > The 100 ms interval can add unnecessary teardown latency if a failed
> > termination becomes retryable much sooner. There is no hardware-derived
> > justification for that particular value.
> >
> > The FIFO/state-machine draining is part of the provider's stop sequence=
.
> > For example, DW performs its FIFO-empty polling inside
> > dwc_terminate_all(). If termination succeeds, this patch proceeds witho=
ut
> > the retry sleep, regardless of baud rate. The sleep is only reached
> > after an error during DMA release, not during normal RX delivery.
> >
> > Baud rate can influence how quickly a transmit FIFO drains, even withou=
t
> > flow control. However, the termination error does not tell 8250 whether
> > that drain is still progressing, how much remains, or whether the
> > controller needs a different recovery operation. That distinction matte=
rs
> > when choosing a retry interval: a shorter interval reduces the added
> > latency, but does not establish that retrying can recover the channel.
> >
> > There is also a specific API detail here: dmaengine_terminate_sync()
> > returns immediately if device_terminate_all() fails, without reaching
> > dmaengine_synchronize(). Consequently, an error leaves callback drainin=
g
> > unconfirmed as well. The retry cadence can change, but resource release
> > still requires successful termination and synchronization.
>
> Most likely this is AI slop. I can't see the justification for 100ms.
> Can you explain that?

100 ms was an arbitrary backoff to avoid a tight retry loop if
termination keeps failing. It was not derived from the baud rate,
FIFO depth, or a DMA provider's recovery timing.

That motivation explains sleeping between retries, but not choosing
100 ms. I don't have evidence supporting that particular interval.

>
> > > > Regardless of the retry interval, shutdown cannot release the buffe=
rs
> > > > until the provider establishes that DMA and its callbacks have stop=
ped.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

