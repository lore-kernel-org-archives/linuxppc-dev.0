Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDD9606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=L4EAmR/F
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jD62x6LvCz2xPb;
	Tue, 27 Oct 2026 08:19:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793031881;
	cv=none; b=DFL/oq+M89x626kcs4q9Tdndu0P5glYoEbOFuhdQdcywCJOu4CvZ9q+HDi+oj7QUGaxzSKRbl0k/t8HWngVpkP+l/C3KHoKM9kLCxXkBAPwg7ok9zqcenlvD6TF4uoGHcnrmJP8Oh63bdOpNn6xHPbDIz+4CN2rLPthskCH4PbLe5qWn5SNG13IfGFnRrypeZQsxR6SryMQoh7sb2c0ZQP9/lb0ipe3IMOznOu83p8e1q5/WQ//73vLUAxC0GsOckSxgvvtblWDCLa2q6rtIgIgJEfNEUVHB9tNAaY1i5zXGzFWPqpWeB/35g+9yi5eJEcrfpegelmuMlKK6CrhbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793031881; c=relaxed/relaxed;
	bh=B+AzmoN3BW34PliUEHaRIDLUz11XLW+Sf/2Nqdmz0AQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bx132cI6x3Foo+aBAwVr8pNInLufxyEt/bLHZPGfbj5Bqp0nA0FRQYcPsKz6ewZukYk3Xu7rak3c/b612LEibKs3S+2BXGxilTlWhe+pgIXyXg7B0QfKdhI8Q51E2R1z/w8fYrQyECWUFH4VJ52pI4T55MrHE0Tm8XZUuHlmhLptB/A1lK7CTi/P6gNqjFlApT2NxUDgHmSGc33o5ICdggSG3nQuz5n0edD8UFuf+FTwoGhf14W5W+6hRDNBLcrLLhjr+z3ce3l5VZKwMROounzspmMXUueaH4uYzcPeHzZcYOjwixkf5CzbBup+7sYiA9kc6nyyVx9WDXLw+yZIDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=L4EAmR/F; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=L4EAmR/F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCzVH0r7bz2yRn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 03:24:37 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2e5fb79ce82so20528165ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793031870; x=1793636670; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B+AzmoN3BW34PliUEHaRIDLUz11XLW+Sf/2Nqdmz0AQ=;
        b=L4EAmR/FHXM0xMUzOtwDWGp5UYSPGAkfj4s7ZBz+d5gnrMFoVHmIiWlHi16gjI32U8
         6cR1r9bObltky5ue17a/JQluc5rxCnkZqkMjeE6OImkOjrBUeP6PG3r/McYIpZy44Fc0
         GP0ZA6XMbdYwW3O6DVOjQLnUs5saz01iL5Yts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793031870; x=1793636670;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B+AzmoN3BW34PliUEHaRIDLUz11XLW+Sf/2Nqdmz0AQ=;
        b=YMLxANsxSxWTWxekKl7sORWzBFQCTM6kBl46ucgfWSeJCa3C1a/9Vv5x7fNZViqTTT
         YLUiFRNIrHYD5RuZRqXIqayfzG3cNn90zFhT8KaJWDOIXmDooiuiBmEslqV2GsQ3Q416
         frDZUMlf/Pwr1T5RNg8Ui7BEizkINvj+PwMvwrB/1+2qLNJZVw0UpPqY7SkB/G4A5m3o
         aj/FR4T0gNj4lKd1+Hr6QvOgPJW/0F70Ij+BtbZp2uikme5v70rh2RviRdL32JoVNGZJ
         juI2B04TexW8s0LjYbukqRyYN+Lq+vyWlW1bIE8QASwPN7TpshD3cJHgKjo7hdxeCELl
         g3pw==
X-Forwarded-Encrypted: i=1; AKwUvBzDMwEQnuCYhYyQQ1Ye4o0wxgoJY72V1UxBVemZj6qMcR1jnOkzK4xlASNFqz9lHRAi5pjf9qlBAd/ah0c=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKxFagkvYJ+v8dRI8M2ZKqe2TSDY4CZMm4KaGVf1nm34ZRy+P5N
	xDFr97XvzrfEm7WbQNcOAmZeVpqupmTo9k7+pfK23wL2JUPvQQ6cPKW5s7yYdezJOY+0c9twyJE
	YMr4=
X-Gm-Gg: AYBFou1nI2jj7JR/fsPrVwVMRfh1u3kqezi3i/nQo2SYsTJhbLtkZWq1s/8Tu8pe+Y6
	ykBkv+RT29NcY24tS2ywxcREPnKJCCWcTCOyb4L7YkqtrwgSMnr7eAc+xB5NdeJB9uNNk6pKNAt
	Dg2n0mY/MpiNqbwDgTA7kGA/zUDsyDJ0x4mW4U3nEo2IF3Sd1r7ryDOFE+I7CT0xSlWej+tDUe4
	QPbnny9TvM4Z3N62YQkCCAJqV9Pkd5j9RnY9BKziG6ff8LNAFejq9A1XauQfnGs0xJfZ+IDdXCc
	jn/vACadR/x+2VqqYaAR/hCoz7SktU2R9fOW6GVWLZ6XtwtWMt8JnLePNJhZQchSqCgL73aQDxt
	RKMTfX4PM3ldyRPkfQ6yyBhBj43j1spcF7Ou+s97hPwlBJwGsPUHUYGICpO81IMSjdS7yz+femP
	APXDiWiMMpbbQAl+G88RoT3J2dCUSHvEee5trUPmNWUCERKFZ/kyhTaOU1uSJK4zqyS69QNmu19
	Qb6STZXNQnPGym67e0VhwVTlmbryTES5EdKGuANHW+6/N+5DQTmP8UL5I/Lx4m5xmkPz6OER+qZ
	fHslUJzx8zjm0OE/
X-Received: by 2002:a17:903:3803:b0:2e9:5829:9b48 with SMTP id d9443c01a7336-2ea9c6c359dmr56848545ad.20.1793031870028;
        Mon, 26 Oct 2026 09:24:30 -0700 (PDT)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com. [74.125.82.45])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9af32085sm19688455ad.2.2026.10.26.09.24.28
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 09:24:28 -0700 (PDT)
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14394530ec6so3877751c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 09:24:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByUSHEFIMohxhK/YjBukk6+NmFNbhAJpTY3ln6ftfAR4ns+m+bDVcz9rCNNq0O1b7z1X2cmFMs6krYpgcA=@lists.ozlabs.org
X-Received: by 2002:a05:7022:7e0a:b0:15b:afce:62c2 with SMTP id
 a92af1059eb24-19936e39a84mr11813231c88.41.1793031866833; Mon, 26 Oct 2026
 09:24:26 -0700 (PDT)
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
References: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com>
 <a011174b-d64c-305b-7dab-62017fc885fa@linux.intel.com>
In-Reply-To: <a011174b-d64c-305b-7dab-62017fc885fa@linux.intel.com>
From: Raul Rangel <rrangel@chromium.org>
Date: Mon, 26 Oct 2026 10:24:15 -0600
X-Gmail-Original-Message-ID: <CAHQZ30AfcwMTXPpCgiWkhz1OFoxHJOqcVmur8Buz72M45Acuag@mail.gmail.com>
X-Gm-Features: AclHuK_hdZ1C8LLY9vMe6zjE8ie5z-dQN8H2kWV5i--OvBI5KAzomZf2JbBvXK8
Message-ID: <CAHQZ30AfcwMTXPpCgiWkhz1OFoxHJOqcVmur8Buz72M45Acuag@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] serial: 8250: serialize DMA cancellation with
 buffer reuse
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Tony Lindgren <tony@atomide.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Timur Tabi <timur@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="00000000000081231b065ec0c333"
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000081231b065ec0c333
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 5:16=E2=80=AFAM Ilpo J=C3=A4rvinen <ilpo.jarvinen@l=
inux.intel.com>
wrote:

> On Sat, 24 Oct 2026, James Hilliard wrote:
>
> > Reserve canceled transmit and receive storage until DMA and its
> completion
> > callbacks have retired. Serial-core write backpressure protects a flush=
ed
> > TX FIFO while normal transfers continue to DMA directly from that FIFO.
> >
> > The series separates OMAP's locked completion processing and serializes
> > asynchronous write wakeups with the port lock before adding the
> serial-core
> > reservation helpers and applying them to 8250 TX. Flushing
> > empties the logical queue immediately. While the old transfer owns its
> > storage, write_room() reports zero and write-ready notifications wait f=
or
> > retirement. Failed termination retains the reservation until normal
> > completion, without advancing the reset FIFO. DMA retirement releases t=
he
> > reservation independently of port readiness. Serial core keeps writes a=
nd
> > wakeups gated during shutdown until successful startup or resume.
> >
> > RX delivers paused data before the PIO fallback and retires callbacks i=
n
> > process context. Track FIFO access separately from buffer retirement so
> > PIO and the DesignWare empty-FIFO timeout handling can run once DMA has
> > released the FIFO. On failure, retain the requested interrupt enables i=
n
> > the existing IER shadow and mask receive interrupts in hardware until D=
MA
> > has stopped. Recovery then leaves RX on PIO until reopen. Shutdown
> excludes
> > new retirement work before releasing the channels.
> >
> > Based on tty-next with the posted shutdown guard [0], channel
> > configuration error handling [1], RX TTY accounting fix [2], RZ/N1
> > transfer-length fix [3], transmit-PM shutdown fix [4], serport
> > write-wakeup deferral [5], DesignWare BUSY-safe fractional-divisor
> > programming [6], and Intel MID RX DMA timeout locking [7]. The serport
> fix
> > is needed before serializing the remaining write-wakeup callers with th=
e
> > port lock.
> >
> > [0]
> https://lore.kernel.org/r/20261021-submit-serial-8250-dma-shutdown-v1-v1-=
1-3d3ce383c614@gmail.com
> > [1]
> https://lore.kernel.org/r/20261021-submit-serial-8250-dma-config-errors-v=
1-v1-1-c067587d1ef2@gmail.com
> > [2]
> https://lore.kernel.org/r/20261021-submit-serial-8250-dma-rx-accounting-v=
1-v1-1-c11795914ab4@gmail.com
> > [3]
> https://lore.kernel.org/r/20261023-submit-serial-8250-dma-tx-length-v1-v2=
-1-c3106ef4d2df@gmail.com
> > [4]
> https://lore.kernel.org/r/20261022-submit-serial-8250-tx-pm-shutdown-v1-v=
1-1-0e894afa3bb8@gmail.com
> > [5]
> https://lore.kernel.org/r/20261023-submit-serport-write-wakeup-v1-v1-1-74=
e7311638a2@gmail.com
> > [6]
> https://lore.kernel.org/r/20261024-submit-serial-8250-dw-divisor-v1-v2-1-=
032ca5338359@gmail.com
> > [7]
> https://lore.kernel.org/r/20261024-submit-serial-8250-mid-rx-lock-v1-v1-1=
-2b9afdf869d7@gmail.com
> >
> > Assisted-by: Codex:gpt-6-astra
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes in v6:
>
> Hi,



>
>
This series is moving way too fast with new versions. Please slow down.
>

+1. I think you should have spent more time refining your patch set before
submission, or sending individual patches that weren't interelated.


>
> We're not aiming to who manages to produce highest version counter for a
> series. ;-)
>
> You're making non-trivial changes so please do expect human review to
> take time. Cranking new versions almost back to back (or even every other
> day) will just fill up inboxes.
>
> --
>  i.
>
>
> > - Use v2 of the DesignWare BUSY-safe fractional-divisor prerequisite.
> > - Serialize CLPS711x TX servicing and interrupt-enable state with the
> >   port lock. Use non-waiting IRQ disable in stop_tx(), skip queued TX
> >   interrupts after stopping, and drain the handler outside the lock
> >   during shutdown.
> > - Make the Atmel RX/TX tasklets and SB1250 termios locking IRQ-safe
> >   alongside their interrupt-handler locking, preserving the caller's
> >   interrupt state when releasing the port lock.
> > - Report RX DMA recovery after releasing the port lock, keeping the
> >   state changes and interrupt-enable restoration serialized.
> > - Link to v5:
> https://patch.msgid.link/20261024-submit-serial-8250-dma-cancel-v1-v5-0-9=
e52968928d2@gmail.com
> >
> > Changes in v5:
> > - Add the posted serport write-wakeup deferral as a prerequisite for th=
e
> >   caller-locking preparation.
> > - Add a preparatory patch serializing asynchronous write-wakeup callers
> >   with the port lock, including indirect CTS and transmit-helper calls.
> >   Keep sleeping register accesses outside the lock and defer SCCNXP
> >   notifications until its controller lock is released.
> > - Use the separately posted DesignWare BUSY-safe fractional-divisor fix
> >   and Intel MID RX DMA timeout locking fix as prerequisites, leaving fi=
ve
> >   patches in this series.
> > - Separate serial-core write readiness from DMA storage reservations.
> Record
> >   retirement during startup and shutdown while keeping writes and wakeu=
ps
> >   gated until the port is ready.
> > - Wake deferred writers after successful startup or resume, including
> when
> >   reopening with a retained FIFO, and restart any retained queued outpu=
t.
> > - Keep the write-ready notification pending while retained output is at
> or
> >   above the normal wakeup threshold, until TX completion drains it.
> > - Publish resume readiness under the TX restart lock without releasing =
a
> >   reservation that may belong to a newly flushed transfer.
> > - Release 8250's TX reservation after shutdown has stopped DMA and
> unmapped
> >   the source; serial core retains control of write readiness.
> > - Link to v4:
> https://patch.msgid.link/20261023-submit-serial-8250-dma-cancel-v1-v4-0-e=
759de1839de@gmail.com
> >
> > Changes in v4:
> > - Retain flushed TX reservations through shutdown and failed resume.
> Release
> >   them after successful resume, or when allocating a new FIFO on reopen=
,
> >   so retirement cannot wake writers into a closing port.
> > - Treat RX flush as complete once the channel is inactive, and clear th=
e
> >   shutdown guard before startup configures the UART and tests interrupt=
s.
> > - Check completion after a failed pause so a transfer that finished
> before
> >   its callback acquired the port lock is delivered and retired normally=
.
> > - Keep DesignWare's BUSY-safe divisor setter after fractional-divisor
> >   discovery, writing DLF and DLL/DLH only after confirming DLAB.
> > - Link to v3:
> https://patch.msgid.link/20261023-submit-serial-8250-dma-cancel-v1-v3-0-d=
78f9e4c4932@gmail.com
> >
> > Changes in v3:
> > - Defer write-ready wakeups while flushed TX storage is reserved, and
> >   serialize the flush wakeup with the reservation under the port lock.
> > - Suppress ordinary TX starts during the reservation while preserving
> >   high-priority flow-control characters, which use separate storage.
> > - Separate RX FIFO access from callback retirement, allowing PIO and th=
e
> >   DesignWare empty-FIFO timeout workaround after a successful pause and
> >   termination while keeping the receive buffer reserved.
> > - Use the existing IER shadow for requested enables and a shared regist=
er
> >   writer to keep receive interrupts masked throughout DMA error recover=
y,
> >   including termios, RS485, modem-status and overrun-backoff updates.
> > - Preserve the timeout-enable bit across stop_rx(), exclude late shutdo=
wn
> >   interrupts from PIO, and avoid FIFO resets during RX DMA recovery.
> > - Preserve the completion-path LSR read after stop_rx(), while gating D=
MA
> >   resubmission on the receive interrupt enable.
> > - Pack the cancellation flags after moving all their accesses under the
> >   port lock, including the recovery worker's snapshot and initializatio=
n.
> > - Apply the early-return, shared-helper and line-wrapping cleanups.
> > - Link to v2:
> https://patch.msgid.link/20261022-submit-serial-8250-dma-cancel-v1-v2-0-0=
88ea51e3891@gmail.com
> >
> > Changes in v2:
> > - Add serial-core helpers to reserve flushed transmit storage until DMA
> >   retirement. Apply write backpressure during that interval and keep
> normal
> >   TX using the FIFO directly, replacing the private transmit buffer in
> v1.
> > - Document the flush callback's reservation, writer backpressure and
> >   retirement requirements, including release before shutdown returns.
> > - Split the OMAP completion refactor into a preparatory patch and move
> >   the RZ/N1 preparation-order and shutdown PM fixes to independent
> >   submissions, keeping four patches in this series.
> > - Take runtime PM references around worker UART accesses, and leave
> normal
> >   RX retirement to release ownership without reading LSR or restarting
> DMA.
> > - Synchronize the queued TX ranges before preparing the descriptor and
> >   return the mapping to CPU ownership before releasing the reservation.
> > - Keep the TX transfer length separate from FIFO cancellation, so a
> failed
> >   termination can account completion without advancing the reset FIFO.
> > - Exclude late RX flush work during shutdown, including Intel MID DMA
> >   timeout interrupts which are independent of UART_IER.
> > - Accept DMA_IN_PROGRESS after successful pause, and recover from faile=
d
> >   pause, termination or DMA_ERROR before handing the receiver to PIO.
> > - Preserve stop_rx() and shutdown across recovery, and retain the
> >   DesignWare empty-FIFO timeout workaround when receiving through PIO.
> > - Apply the requested guard spacing and container_of() formatting.
> > - Link to v1:
> https://patch.msgid.link/20261021-submit-serial-8250-dma-cancel-v1-v1-0-e=
fe2b89f2303@gmail.com
> >
> > ---
> > James Hilliard (5):
> >       serial: 8250_omap: separate locked TX DMA completion processing
> >       serial: serialize asynchronous write wakeups with the port lock
> >       serial: core: allow drivers to reserve flushed transmit storage
> >       serial: 8250: drain canceled TX DMA before reusing its buffer
> >       serial: 8250: retire canceled RX DMA before reusing the receive
> buffer
> >
> >  drivers/tty/serial/21285.c          |   2 +
> >  drivers/tty/serial/8250/8250.h      |  59 +++++++-
> >  drivers/tty/serial/8250/8250_core.c |   2 +-
> >  drivers/tty/serial/8250/8250_dma.c  | 286
> +++++++++++++++++++++++++++---------
> >  drivers/tty/serial/8250/8250_dw.c   |  27 +++-
> >  drivers/tty/serial/8250/8250_omap.c |  38 +++--
> >  drivers/tty/serial/8250/8250_port.c |  31 ++--
> >  drivers/tty/serial/atmel_serial.c   |  12 +-
> >  drivers/tty/serial/clps711x.c       |  23 ++-
> >  drivers/tty/serial/cpm_uart.c       |   2 +
> >  drivers/tty/serial/fsl_lpuart.c     |   2 +-
> >  drivers/tty/serial/jsm/jsm_cls.c    |   3 +-
> >  drivers/tty/serial/jsm/jsm_neo.c    |   9 +-
> >  drivers/tty/serial/lantiq.c         |   3 +-
> >  drivers/tty/serial/ma35d1_serial.c  |   6 +-
> >  drivers/tty/serial/max3100.c        |   6 +-
> >  drivers/tty/serial/max310x.c        |   9 +-
> >  drivers/tty/serial/mux.c            |  13 +-
> >  drivers/tty/serial/mvebu-uart.c     |   2 +
> >  drivers/tty/serial/mxs-auart.c      |   2 +
> >  drivers/tty/serial/sb1250-duart.c   |  14 +-
> >  drivers/tty/serial/sccnxp.c         |  45 ++++--
> >  drivers/tty/serial/serial_core.c    | 100 +++++++++++--
> >  drivers/tty/serial/ucc_uart.c       |   6 +-
> >  include/linux/serial_core.h         |  18 ++-
> >  25 files changed, 551 insertions(+), 169 deletions(-)
> > ---
> > base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
> > change-id: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
> > prerequisite-patch-id: 3604bfaa3a1c214997de1f11162b81a4541af5ab
> > prerequisite-patch-id: 79dd093ffb35e254e790dffb8887faf51b64f947
> > prerequisite-patch-id: 80a5061d84c055a64c760268febed179c687b99f
> > prerequisite-patch-id: 7dbb404baf1f861982cf6a4b755d39cfec548223
> > prerequisite-patch-id: 40881d81a27b3a1aa45203d171214faaf2197768
> > prerequisite-patch-id: 4456eb7f800cb5d50a70c898e6d5a452a7f0bca4
> > prerequisite-patch-id: c3d8ac0d54d1bfe43657964c517cfa4c7fde11af
> > prerequisite-patch-id: 48659e5ef3f5fb377d0b751f0830c0de4699262c
> >
> > Best regards,
> > --
> > James Hilliard <james.hilliard1@gmail.com>
> >
>
> --
>  i.
>
>

--00000000000081231b065ec0c333
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"background-color:transpare=
nt">On Mon, Oct 26, 2026 at 5:16=E2=80=AFAM Ilpo J=C3=A4rvinen &lt;<a href=
=3D"mailto:ilpo.jarvinen@linux.intel.com">ilpo.jarvinen@linux.intel.com</a>=
&gt; wrote:</span></div><div class=3D"gmail_quote gmail_quote_container"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On Sat, 24 Oct 2026, James =
Hilliard wrote:<br>
<br>
&gt; Reserve canceled transmit and receive storage until DMA and its comple=
tion<br>
&gt; callbacks have retired. Serial-core write backpressure protects a flus=
hed<br>
&gt; TX FIFO while normal transfers continue to DMA directly from that FIFO=
.<br>
&gt; <br>
&gt; The series separates OMAP&#39;s locked completion processing and seria=
lizes<br>
&gt; asynchronous write wakeups with the port lock before adding the serial=
-core<br>
&gt; reservation helpers and applying them to 8250 TX. Flushing<br>
&gt; empties the logical queue immediately. While the old transfer owns its=
<br>
&gt; storage, write_room() reports zero and write-ready notifications wait =
for<br>
&gt; retirement. Failed termination retains the reservation until normal<br=
>
&gt; completion, without advancing the reset FIFO. DMA retirement releases =
the<br>
&gt; reservation independently of port readiness. Serial core keeps writes =
and<br>
&gt; wakeups gated during shutdown until successful startup or resume.<br>
&gt; <br>
&gt; RX delivers paused data before the PIO fallback and retires callbacks =
in<br>
&gt; process context. Track FIFO access separately from buffer retirement s=
o<br>
&gt; PIO and the DesignWare empty-FIFO timeout handling can run once DMA ha=
s<br>
&gt; released the FIFO. On failure, retain the requested interrupt enables =
in<br>
&gt; the existing IER shadow and mask receive interrupts in hardware until =
DMA<br>
&gt; has stopped. Recovery then leaves RX on PIO until reopen. Shutdown exc=
ludes<br>
&gt; new retirement work before releasing the channels.<br>
&gt; <br>
&gt; Based on tty-next with the posted shutdown guard [0], channel<br>
&gt; configuration error handling [1], RX TTY accounting fix [2], RZ/N1<br>
&gt; transfer-length fix [3], transmit-PM shutdown fix [4], serport<br>
&gt; write-wakeup deferral [5], DesignWare BUSY-safe fractional-divisor<br>
&gt; programming [6], and Intel MID RX DMA timeout locking [7]. The serport=
 fix<br>
&gt; is needed before serializing the remaining write-wakeup callers with t=
he<br>
&gt; port lock.<br>
&gt; <br>
&gt; [0] <a href=3D"https://lore.kernel.org/r/20261021-submit-serial-8250-d=
ma-shutdown-v1-v1-1-3d3ce383c614@gmail.com" rel=3D"noreferrer" target=3D"_b=
lank">https://lore.kernel.org/r/20261021-submit-serial-8250-dma-shutdown-v1=
-v1-1-3d3ce383c614@gmail.com</a><br>
&gt; [1] <a href=3D"https://lore.kernel.org/r/20261021-submit-serial-8250-d=
ma-config-errors-v1-v1-1-c067587d1ef2@gmail.com" rel=3D"noreferrer" target=
=3D"_blank">https://lore.kernel.org/r/20261021-submit-serial-8250-dma-confi=
g-errors-v1-v1-1-c067587d1ef2@gmail.com</a><br>
&gt; [2] <a href=3D"https://lore.kernel.org/r/20261021-submit-serial-8250-d=
ma-rx-accounting-v1-v1-1-c11795914ab4@gmail.com" rel=3D"noreferrer" target=
=3D"_blank">https://lore.kernel.org/r/20261021-submit-serial-8250-dma-rx-ac=
counting-v1-v1-1-c11795914ab4@gmail.com</a><br>
&gt; [3] <a href=3D"https://lore.kernel.org/r/20261023-submit-serial-8250-d=
ma-tx-length-v1-v2-1-c3106ef4d2df@gmail.com" rel=3D"noreferrer" target=3D"_=
blank">https://lore.kernel.org/r/20261023-submit-serial-8250-dma-tx-length-=
v1-v2-1-c3106ef4d2df@gmail.com</a><br>
&gt; [4] <a href=3D"https://lore.kernel.org/r/20261022-submit-serial-8250-t=
x-pm-shutdown-v1-v1-1-0e894afa3bb8@gmail.com" rel=3D"noreferrer" target=3D"=
_blank">https://lore.kernel.org/r/20261022-submit-serial-8250-tx-pm-shutdow=
n-v1-v1-1-0e894afa3bb8@gmail.com</a><br>
&gt; [5] <a href=3D"https://lore.kernel.org/r/20261023-submit-serport-write=
-wakeup-v1-v1-1-74e7311638a2@gmail.com" rel=3D"noreferrer" target=3D"_blank=
">https://lore.kernel.org/r/20261023-submit-serport-write-wakeup-v1-v1-1-74=
e7311638a2@gmail.com</a><br>
&gt; [6] <a href=3D"https://lore.kernel.org/r/20261024-submit-serial-8250-d=
w-divisor-v1-v2-1-032ca5338359@gmail.com" rel=3D"noreferrer" target=3D"_bla=
nk">https://lore.kernel.org/r/20261024-submit-serial-8250-dw-divisor-v1-v2-=
1-032ca5338359@gmail.com</a><br>
&gt; [7] <a href=3D"https://lore.kernel.org/r/20261024-submit-serial-8250-m=
id-rx-lock-v1-v1-1-2b9afdf869d7@gmail.com" rel=3D"noreferrer" target=3D"_bl=
ank">https://lore.kernel.org/r/20261024-submit-serial-8250-mid-rx-lock-v1-v=
1-1-2b9afdf869d7@gmail.com</a><br>
&gt;<br>
&gt; Assisted-by: Codex:gpt-6-astra<br>
&gt; Signed-off-by: James Hilliard &lt;<a href=3D"mailto:james.hilliard1@gm=
ail.com" target=3D"_blank">james.hilliard1@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; Changes in v6:<br>
<br>
Hi,</blockquote><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><span style=3D"background-color:transparent">=C2=A0</span><br></blo=
ckquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
This series is moving way too fast with new versions. Please slow down.<br>=
</blockquote><div>=C2=A0</div><div>+1. I think you should have spent more t=
ime refining your patch set before submission, or sending individual patche=
s that weren&#39;t interelated.<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
We&#39;re not aiming to who manages to produce highest version counter for =
a <br>
series. ;-)<br>
<br>
You&#39;re making non-trivial changes so please do expect human review to <=
br>
take time. Cranking new versions almost back to back (or even every other <=
br>
day) will just fill up inboxes.<br>
<br>
--<br>
=C2=A0i.<br>
<br>
<br>
&gt; - Use v2 of the DesignWare BUSY-safe fractional-divisor prerequisite.<=
br>
&gt; - Serialize CLPS711x TX servicing and interrupt-enable state with the<=
br>
&gt;=C2=A0 =C2=A0port lock. Use non-waiting IRQ disable in stop_tx(), skip =
queued TX<br>
&gt;=C2=A0 =C2=A0interrupts after stopping, and drain the handler outside t=
he lock<br>
&gt;=C2=A0 =C2=A0during shutdown.<br>
&gt; - Make the Atmel RX/TX tasklets and SB1250 termios locking IRQ-safe<br=
>
&gt;=C2=A0 =C2=A0alongside their interrupt-handler locking, preserving the =
caller&#39;s<br>
&gt;=C2=A0 =C2=A0interrupt state when releasing the port lock.<br>
&gt; - Report RX DMA recovery after releasing the port lock, keeping the<br=
>
&gt;=C2=A0 =C2=A0state changes and interrupt-enable restoration serialized.=
<br>
&gt; - Link to v5: <a href=3D"https://patch.msgid.link/20261024-submit-seri=
al-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com" rel=3D"noreferrer" targe=
t=3D"_blank">https://patch.msgid.link/20261024-submit-serial-8250-dma-cance=
l-v1-v5-0-9e52968928d2@gmail.com</a><br>
&gt; <br>
&gt; Changes in v5:<br>
&gt; - Add the posted serport write-wakeup deferral as a prerequisite for t=
he<br>
&gt;=C2=A0 =C2=A0caller-locking preparation.<br>
&gt; - Add a preparatory patch serializing asynchronous write-wakeup caller=
s<br>
&gt;=C2=A0 =C2=A0with the port lock, including indirect CTS and transmit-he=
lper calls.<br>
&gt;=C2=A0 =C2=A0Keep sleeping register accesses outside the lock and defer=
 SCCNXP<br>
&gt;=C2=A0 =C2=A0notifications until its controller lock is released.<br>
&gt; - Use the separately posted DesignWare BUSY-safe fractional-divisor fi=
x<br>
&gt;=C2=A0 =C2=A0and Intel MID RX DMA timeout locking fix as prerequisites,=
 leaving five<br>
&gt;=C2=A0 =C2=A0patches in this series.<br>
&gt; - Separate serial-core write readiness from DMA storage reservations. =
Record<br>
&gt;=C2=A0 =C2=A0retirement during startup and shutdown while keeping write=
s and wakeups<br>
&gt;=C2=A0 =C2=A0gated until the port is ready.<br>
&gt; - Wake deferred writers after successful startup or resume, including =
when<br>
&gt;=C2=A0 =C2=A0reopening with a retained FIFO, and restart any retained q=
ueued output.<br>
&gt; - Keep the write-ready notification pending while retained output is a=
t or<br>
&gt;=C2=A0 =C2=A0above the normal wakeup threshold, until TX completion dra=
ins it.<br>
&gt; - Publish resume readiness under the TX restart lock without releasing=
 a<br>
&gt;=C2=A0 =C2=A0reservation that may belong to a newly flushed transfer.<b=
r>
&gt; - Release 8250&#39;s TX reservation after shutdown has stopped DMA and=
 unmapped<br>
&gt;=C2=A0 =C2=A0the source; serial core retains control of write readiness=
.<br>
&gt; - Link to v4: <a href=3D"https://patch.msgid.link/20261023-submit-seri=
al-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com" rel=3D"noreferrer" targe=
t=3D"_blank">https://patch.msgid.link/20261023-submit-serial-8250-dma-cance=
l-v1-v4-0-e759de1839de@gmail.com</a><br>
&gt; <br>
&gt; Changes in v4:<br>
&gt; - Retain flushed TX reservations through shutdown and failed resume. R=
elease<br>
&gt;=C2=A0 =C2=A0them after successful resume, or when allocating a new FIF=
O on reopen,<br>
&gt;=C2=A0 =C2=A0so retirement cannot wake writers into a closing port.<br>
&gt; - Treat RX flush as complete once the channel is inactive, and clear t=
he<br>
&gt;=C2=A0 =C2=A0shutdown guard before startup configures the UART and test=
s interrupts.<br>
&gt; - Check completion after a failed pause so a transfer that finished be=
fore<br>
&gt;=C2=A0 =C2=A0its callback acquired the port lock is delivered and retir=
ed normally.<br>
&gt; - Keep DesignWare&#39;s BUSY-safe divisor setter after fractional-divi=
sor<br>
&gt;=C2=A0 =C2=A0discovery, writing DLF and DLL/DLH only after confirming D=
LAB.<br>
&gt; - Link to v3: <a href=3D"https://patch.msgid.link/20261023-submit-seri=
al-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com" rel=3D"noreferrer" targe=
t=3D"_blank">https://patch.msgid.link/20261023-submit-serial-8250-dma-cance=
l-v1-v3-0-d78f9e4c4932@gmail.com</a><br>
&gt; <br>
&gt; Changes in v3:<br>
&gt; - Defer write-ready wakeups while flushed TX storage is reserved, and<=
br>
&gt;=C2=A0 =C2=A0serialize the flush wakeup with the reservation under the =
port lock.<br>
&gt; - Suppress ordinary TX starts during the reservation while preserving<=
br>
&gt;=C2=A0 =C2=A0high-priority flow-control characters, which use separate =
storage.<br>
&gt; - Separate RX FIFO access from callback retirement, allowing PIO and t=
he<br>
&gt;=C2=A0 =C2=A0DesignWare empty-FIFO timeout workaround after a successfu=
l pause and<br>
&gt;=C2=A0 =C2=A0termination while keeping the receive buffer reserved.<br>
&gt; - Use the existing IER shadow for requested enables and a shared regis=
ter<br>
&gt;=C2=A0 =C2=A0writer to keep receive interrupts masked throughout DMA er=
ror recovery,<br>
&gt;=C2=A0 =C2=A0including termios, RS485, modem-status and overrun-backoff=
 updates.<br>
&gt; - Preserve the timeout-enable bit across stop_rx(), exclude late shutd=
own<br>
&gt;=C2=A0 =C2=A0interrupts from PIO, and avoid FIFO resets during RX DMA r=
ecovery.<br>
&gt; - Preserve the completion-path LSR read after stop_rx(), while gating =
DMA<br>
&gt;=C2=A0 =C2=A0resubmission on the receive interrupt enable.<br>
&gt; - Pack the cancellation flags after moving all their accesses under th=
e<br>
&gt;=C2=A0 =C2=A0port lock, including the recovery worker&#39;s snapshot an=
d initialization.<br>
&gt; - Apply the early-return, shared-helper and line-wrapping cleanups.<br=
>
&gt; - Link to v2: <a href=3D"https://patch.msgid.link/20261022-submit-seri=
al-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com" rel=3D"noreferrer" targe=
t=3D"_blank">https://patch.msgid.link/20261022-submit-serial-8250-dma-cance=
l-v1-v2-0-088ea51e3891@gmail.com</a><br>
&gt; <br>
&gt; Changes in v2:<br>
&gt; - Add serial-core helpers to reserve flushed transmit storage until DM=
A<br>
&gt;=C2=A0 =C2=A0retirement. Apply write backpressure during that interval =
and keep normal<br>
&gt;=C2=A0 =C2=A0TX using the FIFO directly, replacing the private transmit=
 buffer in v1.<br>
&gt; - Document the flush callback&#39;s reservation, writer backpressure a=
nd<br>
&gt;=C2=A0 =C2=A0retirement requirements, including release before shutdown=
 returns.<br>
&gt; - Split the OMAP completion refactor into a preparatory patch and move=
<br>
&gt;=C2=A0 =C2=A0the RZ/N1 preparation-order and shutdown PM fixes to indep=
endent<br>
&gt;=C2=A0 =C2=A0submissions, keeping four patches in this series.<br>
&gt; - Take runtime PM references around worker UART accesses, and leave no=
rmal<br>
&gt;=C2=A0 =C2=A0RX retirement to release ownership without reading LSR or =
restarting DMA.<br>
&gt; - Synchronize the queued TX ranges before preparing the descriptor and=
<br>
&gt;=C2=A0 =C2=A0return the mapping to CPU ownership before releasing the r=
eservation.<br>
&gt; - Keep the TX transfer length separate from FIFO cancellation, so a fa=
iled<br>
&gt;=C2=A0 =C2=A0termination can account completion without advancing the r=
eset FIFO.<br>
&gt; - Exclude late RX flush work during shutdown, including Intel MID DMA<=
br>
&gt;=C2=A0 =C2=A0timeout interrupts which are independent of UART_IER.<br>
&gt; - Accept DMA_IN_PROGRESS after successful pause, and recover from fail=
ed<br>
&gt;=C2=A0 =C2=A0pause, termination or DMA_ERROR before handing the receive=
r to PIO.<br>
&gt; - Preserve stop_rx() and shutdown across recovery, and retain the<br>
&gt;=C2=A0 =C2=A0DesignWare empty-FIFO timeout workaround when receiving th=
rough PIO.<br>
&gt; - Apply the requested guard spacing and container_of() formatting.<br>
&gt; - Link to v1: <a href=3D"https://patch.msgid.link/20261021-submit-seri=
al-8250-dma-cancel-v1-v1-0-efe2b89f2303@gmail.com" rel=3D"noreferrer" targe=
t=3D"_blank">https://patch.msgid.link/20261021-submit-serial-8250-dma-cance=
l-v1-v1-0-efe2b89f2303@gmail.com</a><br>
&gt; <br>
&gt; ---<br>
&gt; James Hilliard (5):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0serial: 8250_omap: separate locked TX DMA co=
mpletion processing<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0serial: serialize asynchronous write wakeups=
 with the port lock<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0serial: core: allow drivers to reserve flush=
ed transmit storage<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0serial: 8250: drain canceled TX DMA before r=
eusing its buffer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0serial: 8250: retire canceled RX DMA before =
reusing the receive buffer<br>
&gt; <br>
&gt;=C2=A0 drivers/tty/serial/21285.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 drivers/tty/serial/8250/8250.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 59 ++=
+++++-<br>
&gt;=C2=A0 drivers/tty/serial/8250/8250_core.c |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 drivers/tty/serial/8250/8250_dma.c=C2=A0 | 286 +++++++++++++++++=
++++++++++---------<br>
&gt;=C2=A0 drivers/tty/serial/8250/8250_dw.c=C2=A0 =C2=A0|=C2=A0 27 +++-<br=
>
&gt;=C2=A0 drivers/tty/serial/8250/8250_omap.c |=C2=A0 38 +++--<br>
&gt;=C2=A0 drivers/tty/serial/8250/8250_port.c |=C2=A0 31 ++--<br>
&gt;=C2=A0 drivers/tty/serial/atmel_serial.c=C2=A0 =C2=A0|=C2=A0 12 +-<br>
&gt;=C2=A0 drivers/tty/serial/clps711x.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
23 ++-<br>
&gt;=C2=A0 drivers/tty/serial/cpm_uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A02 +<br>
&gt;=C2=A0 drivers/tty/serial/fsl_lpuart.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +-<br>
&gt;=C2=A0 drivers/tty/serial/jsm/jsm_cls.c=C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-=
<br>
&gt;=C2=A0 drivers/tty/serial/jsm/jsm_neo.c=C2=A0 =C2=A0 |=C2=A0 =C2=A09 +-=
<br>
&gt;=C2=A0 drivers/tty/serial/lantiq.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A03 +-<br>
&gt;=C2=A0 drivers/tty/serial/ma35d1_serial.c=C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 drivers/tty/serial/max3100.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A06 +-<br>
&gt;=C2=A0 drivers/tty/serial/max310x.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A09 +-<br>
&gt;=C2=A0 drivers/tty/serial/mux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 13 +-<br>
&gt;=C2=A0 drivers/tty/serial/mvebu-uart.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +<br>
&gt;=C2=A0 drivers/tty/serial/mxs-auart.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A02 +<br>
&gt;=C2=A0 drivers/tty/serial/sb1250-duart.c=C2=A0 =C2=A0|=C2=A0 14 +-<br>
&gt;=C2=A0 drivers/tty/serial/sccnxp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 45 ++++--<br>
&gt;=C2=A0 drivers/tty/serial/serial_core.c=C2=A0 =C2=A0 | 100 +++++++++++-=
-<br>
&gt;=C2=A0 drivers/tty/serial/ucc_uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A06 +-<br>
&gt;=C2=A0 include/linux/serial_core.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 18 ++-<br>
&gt;=C2=A0 25 files changed, 551 insertions(+), 169 deletions(-)<br>
&gt; ---<br>
&gt; base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d<br>
&gt; change-id: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1<br>
&gt; prerequisite-patch-id: 3604bfaa3a1c214997de1f11162b81a4541af5ab<br>
&gt; prerequisite-patch-id: 79dd093ffb35e254e790dffb8887faf51b64f947<br>
&gt; prerequisite-patch-id: 80a5061d84c055a64c760268febed179c687b99f<br>
&gt; prerequisite-patch-id: 7dbb404baf1f861982cf6a4b755d39cfec548223<br>
&gt; prerequisite-patch-id: 40881d81a27b3a1aa45203d171214faaf2197768<br>
&gt; prerequisite-patch-id: 4456eb7f800cb5d50a70c898e6d5a452a7f0bca4<br>
&gt; prerequisite-patch-id: c3d8ac0d54d1bfe43657964c517cfa4c7fde11af<br>
&gt; prerequisite-patch-id: 48659e5ef3f5fb377d0b751f0830c0de4699262c<br>
&gt; <br>
&gt; Best regards,<br>
&gt; --=C2=A0 <br>
&gt; James Hilliard &lt;<a href=3D"mailto:james.hilliard1@gmail.com" target=
=3D"_blank">james.hilliard1@gmail.com</a>&gt;<br>
&gt; <br>
<br>
-- <br>
=C2=A0i.<br>
<br>
</blockquote></div></div>

--00000000000081231b065ec0c333--

