Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19985606A329
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sg2shZ4k
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJx6j4yvMz2xdX;
	Wed, 04 Nov 2026 04:54:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::a34" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793728493;
	cv=pass; b=RUa4UQ01vnRvOThlMLHD98Y0Xgaoz/1A1I0QRKX3h0y01oHt54lRItq7WUbNpK1MMP0p12UphrxIS7/B1ncT4+H496Dj19pGhQsDgf8dnUoe8RhGAfw7w4joA2MDAAELWD8DF2E4A/Wrt14GGqwoZeEq72tFWC9wvIFAAi2ZYHxd24iopCBXlPCHR5XAS9QocsaMAqVZNwFbxiqoAgiwG9vGVBdHfuVk8wpvhmcH1t9YRHuHOa6zc6CjDr0JwJ9Qy439cIRiMSRk6xTH4/iTWeb/Tu8GRW+Kvc9XtvYk73A1wM2pVs4G45qjig9HiJ6Ox7iejYffVgzrP/1EPavRfg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793728493; c=relaxed/relaxed;
	bh=iwVYSA8m7SCKsjhLjy1thrskeRAGo9CHO3+FfrfRAjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6A7u/PcSBgPJgP655YAs3fuoBzW+5Oo2I2e80u9futBq9CGfgFW43+1hpwuRaOY2M2PNmvN+yEEKB8iNshDCYmD1FhTbx73mvxYRVuB6M0DBhr4/tb95NMHqd1Mq2/2u21HPRLBilnzP2esDXDTAwAZDbOEJjH05O09ePsgJvbUvxuHytUyJhy/OiBuKvzBZrJzamB0aLQdiFkJeWVoKSh8Id3iMHOV2/SD4fxNNHQ0fitdYmjhPPtw4YKZ7mRVQBkjz5iybNrUCI2BQM1SGZ41L98lV9VyDRJRdpONn+vj65pYpAtNNGVT4IyFJ9Ih3l0VyuL2va6+XmrBwNoNkw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sg2shZ4k; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::a34; helo=mail-vk1-xa34.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sg2shZ4k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::a34; helo=mail-vk1-xa34.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJx6h42Gpz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 04:54:52 +1100 (AEDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso1601799e0c.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 09:54:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793728489; cv=none;
        d=google.com; s=arc-20260327;
        b=NGiXjLDXwyK+ELc5IUHHcsmlPuNN1LE1Rd96gDzjQehcESshSMjJr6/NNmVAo9FHe1
         2D1J+3c1meY7m50LEtY7Fcc2ZH1U3lVNFui09DjMmgJI9KARnayeTJ7IamGojZ7ofC1b
         klQUhWPsHKuqYg5RKW2hSo+T96KpPYJjrBbMC7TyWEZOjj/w9IIckJZF86SHGD6tICe9
         wGBRVQrowBmuulk1WU1PvRV5wWFykfOK7XwPYhyUwlH1q3hlCLdV1A88FtRdJCMkUhKA
         ZbDmvxrTzZn6wP52CAF2LQ29qYJHawvg6UEltdvXhJY4Vz4ScgethtuyyrhaUbn1rSv7
         UyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iwVYSA8m7SCKsjhLjy1thrskeRAGo9CHO3+FfrfRAjg=;
        fh=mT/0aRvjmjJvXaWhRfvLK2LiHBPV/Ttt3xeF7Of7auU=;
        b=PDFMr+uZA7qXx2l8uqSpejDerK/yk9WhHGyIV4zUwxtQBkq9XENxAQSjgdjAJlXDfB
         h4X425TSkZIr84Ua0/0t5/8UGKEp05hu+HtkReMeTjNmHwb0VRTs2yJGcplhdSwcr8oo
         c7ELCXaro9gipACxfEfgwZ6IQFCBVqipGkXR9RfXBA9sU2NQ3tSVvRWSBHN44262mpEg
         C1Y5TjsB5yoUxwHxtQWLWM7IUzGhKKqiDsTlCQzpleZFePgR5utjojGmcaHS2jWG35i6
         ZBQoVL4jq8BhqJpo7cE0HxYQQUhD2M0utLEljOp5tJutMssCcaw/nqdEh7TthmAqJY+S
         EVxw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793728489; x=1794333289; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iwVYSA8m7SCKsjhLjy1thrskeRAGo9CHO3+FfrfRAjg=;
        b=sg2shZ4kgcGyJ4c4DZSiiwBSgL3xT+oe/lad76qgaazyjfKePipHyldzm79ZxfYi4Z
         95GcZJLVOHsl5OuTDznggaXmV/PHn2H2otoSSPBlO3e7BIdfxrrexFwrixD5v0z18MyX
         gIqg34czMFqIezCPCINNoAK7RR2f/c4oRBjlt4dgzvd07a0D2hUpvzf4ZIkOuZHZL9ak
         1P+/fSZvSFmv/4uhaCB/WcwrHZ6w5EtrT3Al+mbye31KxXU5jDuUIMA1bWTtO4wzfmGj
         /tujgqJ4QYddRnjwqdDYC6pklZnrcp5fF38EDNozCbQfbPWHcloLSgtG96iOl57AY4BQ
         3lRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728489; x=1794333289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iwVYSA8m7SCKsjhLjy1thrskeRAGo9CHO3+FfrfRAjg=;
        b=NVwbzyzwA2q/pcfi3cqENuOxTXeUxHdvhsQhyxtS+KutrTxrGJu7F+H6oS8Glso7cJ
         eRFDpe1TeMEX1f2IxUI7e46gvws3CyDMGiDhlf5JEbuKtomMJKHVefrJX0peyKJZBg/Y
         tAc4EGy3v74rYRLFCiwffBxi2T6po2IycIGr4mX/1KTA5RMM8+bXbY+HpeyHHFJ36DGI
         O3xJmrGYaIjKWPbUEMAk+o5h6A0Bb4n3E4uHpihpuf3ZRX/XIwZnXGNX4sVd925tnRKe
         Iu6uG1Aa255nGGkOVAWX5bK/zxqKwLWC1g33SBE1WD+PoiFs93OA57MkmT+LTFgg3YUQ
         XIAg==
X-Forwarded-Encrypted: i=1; AKwUvBxgbvLE7UgZCZqiFI2RNizGMcjEc7fMDZHbotVeP+jMTzhrbtQrBMCXZMIu1opP+yGUDZXEzBy5WJy3DhI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/8rXdxD6bxKJ8yvLAT2YTLRGzP0ZvJBguEkRnFEHZuI9GY8r/T
	Y41Kb4840BCIVKrnZnmwsWYnxQMB2gtZDFUVSuagdwnWtk4rTkZAN8Ha5T+Fa8Jz7GnYDHEhVrs
	+pKr5WmWEgyob5L7Rz+varUDpfNLEDP4=
X-Gm-Gg: AYBFou0ulKtmdjD+PaHafv0V1XcEs32mMh6CDul/nqIFu8M4iafYdzM/w4WdY+PkgCf
	TI6lBndJrKB9iZxlhw/F6QQIEQUGNquZOmCb83EZx5lat0Yj8sbW7yMUxf34VyusKxtz0RZ5jSm
	z0kkXwDP+bFFW5cD+c7LF3orwgleT44fDQaB8cyAG5magwZ86dJlv2cvRX1T1Yk6AdFTg8tProH
	XrF9b57VTorbCNBjgOnHzsmSYDnyQi/7mQOUBwq0az94h6jvKfzc51yMIOWJab0IrWsHyrFHrao
	4QQOT+83/tnJJGYPr322NgRWHTCJn38RAvb7xgfiT371gT21mLedeFeEQFZrCfW5imW5N1Jslz/
	yFMGpudCZa2vrzVNzBbzNRqWRwIBZ90ImM9fel0NjklWE6M/tI8FsDn0tS7sT6og5C6BzBuW5GK
	ggDyOgGD3q1w1g0QXgp2ruzu4aig/JGSsyXffH6z5DQ6LjundHgnH9QiTAalV9NVcuaV5em2fiQ
	b3duFOBSCXBAocKepAtU/xj6uU8VB4=
X-Received: by 2002:a05:6122:4697:b0:5ea:fae8:e69e with SMTP id
 71dfb90a1353d-5ec688311c2mr6169989e0c.11.1793728489195; Tue, 03 Nov 2026
 09:54:49 -0800 (PST)
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
 <20261102-submit-serial-8250-dma-cancel-v1-v9-7-9159caade148@gmail.com> <auoa8OWBxqaQuKRq@ashevche-desk.local>
In-Reply-To: <auoa8OWBxqaQuKRq@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 3 Nov 2026 10:54:38 -0700
X-Gm-Features: AclHuK9I_c4PO4aR4qFDRCjbioBe9CFVnX4O6YbacRovHX2KesJOnpsJ16Nbm6g
Message-ID: <CADvTj4rL23q6eO8vjVe9vL1g6B8aoZqsbnThi2QJqkj=9e59sw@mail.gmail.com>
Subject: Re: [PATCH v9 7/8] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
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

On Tue, Nov 3, 2026 at 10:34=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 02, 2026 at 04:14:34PM -0700, James Hilliard wrote:
> > The generic RX timeout path pauses a transfer, copies its data and
> > terminates it asynchronously. Clearing rx_running at that point lets a
> > new receive reuse the buffer and cookie while the old callback has not
> > yet run. Inspecting the new cookie cannot distinguish that callback fro=
m
> > the completion of a new transfer.
> >
> > Reserve the receive buffer until a worker has drained the canceled
> > callbacks. Keep FIFO access separate from callback retirement: after a
> > successful pause and termination, clear rx_running while rx_terminating
> > prevents another descriptor from reusing the buffer. Deliver the paused
> > data before allowing the interrupt handler to drain the FIFO through PI=
O.
> > Normal retirement only releases ownership and leaves subsequent receive
> > handling to the UART interrupt.
> >
> > Preserve the normal completion-path LSR read and gate DMA resubmission =
on
> > the receive interrupt enable, so stop_rx() prevents another transfer wh=
ile
> > the status read retains its existing side effects.
> >
> > Reject new flush work and PIO receive handling during shutdown, includi=
ng
> > late Intel MID DMA timeouts. Stop and drain retirement work before free=
ing
> > the channels and buffer. Once RX has stopped, allow the idle flush used=
 by
> > DesignWare LCR recovery during shutdown. Clear the shutdown guard befor=
e
> > startup configures the UART and tests its interrupts.
> >
> > Check pause failures before accessing the buffer. A successful pause is
> > the quiescence guarantee, even when a provider still reports IN_PROGRES=
S.
> > Also accept DMA_COMPLETE after a failed pause: completion can stop the
> > channel before its callback acquires the port lock, leaving nothing for
> > the provider to pause. Retire that completed transfer normally.
> >
> > A failed pause with an incomplete cookie is ambiguous: hardware may hav=
e
> > finished while its completion interrupt is still pending. Canceling tha=
t
> > descriptor can discard the entire completed receive buffer and switch
> > permanently to PIO. Retain the transfer and retry pause and status in t=
he
> > worker, with receive interrupts masked to prevent a timeout interrupt
> > storm. The worker copies only after a successful pause or reported
> > completion, then terminates and drains the old callback before reuse.
> > The pending-pause guard keeps callbacks from copying or resubmitting th=
e
> > transfer concurrently.
> >
> > Start pause retries at 1 ms and double the delay up to one second to li=
mit
> > CPU use during persistent failure. Sleep outside the port lock on a tim=
ed
> > waitqueue, with completion and shutdown publishing a wakeup under the
> > same lock as the worker's retry check. This also catches notifications
> > arriving just before the worker sleeps, avoiding a full backoff delay
> > after completion or during shutdown. Reset the delay for each new flush=
.
> > Report a stall lasting at least one second once per flush, rate-limited
> > across repeated stalls. A provider which never pauses or completes reta=
ins
> > RX ownership until an error or shutdown; a timeout alone cannot establi=
sh
> > that discarding the buffer is safe.
> >
> > On DMA_ERROR or termination failure, let the worker stop DMA before
> > handing the FIFO to PIO. Keep the requested enables in the existing IER
> > shadow and filter hardware writes during pause retries and recovery,
> > including termios, RS485 and overrun-backoff changes. Apply the current
> > enables after retirement so stop_rx() and shutdown remain effective.
> > Hold a runtime PM reference around worker register accesses and keep RX
> > on PIO until reopen after a confirmed error.
> >
> > Abort the DesignWare idle sequence when RX cannot be stopped. Allow
> > the empty-FIFO timeout workaround once DMA has released the FIFO, inclu=
ding
> > while callbacks retire. Exclude FIFO resets during RX DMA recovery. If =
the
> > provider still cannot terminate the channel in process context, retain
> > its buffer and leave receive interrupts masked.
>
> ...
>
> > +static inline bool serial8250_rx_dma_running(struct uart_8250_port *up=
)
> > +{
> > +     return up->dma && up->dma->rx_running;
> > +}
> > +
> > +static inline bool serial8250_rx_dma_recovering(struct uart_8250_port =
*up)
> > +{
> > +     return up->dma && (up->dma->rx_pause_pending ||
> > +                        (up->dma->rx_err && up->dma->rx_terminating));
>
> Slightly better formatting is to put some line breaks.
>
>         return up->dma &&
>                (up->dma->rx_pause_pending || (up->dma->rx_err && up->dma-=
>rx_terminating));
>
> Alternatively
>
>         if (!up->dma)
>                 return false;
>
>         return up->dma->rx_pause_pending || (up->dma->rx_err && up->dma->=
rx_terminating);
>
> > +}
>
> > +/* Keep the desired enables in up->ier while RX DMA recovery masks har=
dware. */
> > +static inline void serial8250_out_IER(struct uart_8250_port *up, u8 ie=
r)
> > +{
> > +     lockdep_assert_held_once(&up->port.lock);
> > +
> > +     if (up->dma && up->dma->shutting_down)
> > +             ier =3D 0;
> > +     else if (serial8250_rx_dma_recovering(up))
> > +             ier &=3D ~(UART_IER_RDI | UART_IER_RLSI | UART_IER_RTOIE)=
;
> > +     serial_out(up, UART_IER, ier);
> > +}
>
> ...
>
> >       struct tty_port         *tty_port =3D &p->port.state->port;
> > -     struct dma_tx_state     state;
> > -     enum dma_status         dma_status;
> > -     int                     count;
> > -
> > -     /*
> > -      * New DMA Rx can be started during the completion handler before=
 it
> > -      * could acquire port's lock and it might still be ongoing. Don't=
 to
> > -      * anything in such case.
> > -      */
> > -     dma_status =3D dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &=
state);
> > -     if (dma_status =3D=3D DMA_IN_PROGRESS)
> > -             return;
> > -
> > -     count =3D dma->rx_size - state.residue;
> > +     size_t                  count =3D dma->rx_size - state->residue;
>
> No need to put too many spaces between type and variable name.
> (Yes, the first one will be left untouched.)
>
> ...
>
> > +static void serial8250_rx_dma_flush_work(struct work_struct *work)
> > +{
> > +     struct uart_8250_dma *dma =3D container_of(work, struct uart_8250=
_dma, rx_flush_work);
> > +     struct uart_8250_port *p =3D dma->port;
> > +     unsigned int delay_us =3D USEC_PER_MSEC;
> > +     ktime_t start =3D ktime_get();
> > +     bool recover, retry, restore_rx;
> > +     bool warned =3D false;
> > +     int ret;
> > +
> > +     guard(serial8250_rpm)(p);
> > +
> > +     for (;;) {
> > +             scoped_guard(uart_port_lock_irqsave, &p->port) {
> > +                     /* Shutdown cancels this work and drains both DMA=
 channels. */
> > +                     if (dma->shutting_down)
> > +                             return;
> > +                     /* Serialize reset with completion and shutdown n=
otifications. */
> > +                     WRITE_ONCE(dma->rx_pause_wakeup, false);
> > +                     retry =3D dma->rx_pause_pending && !dma->rx_termi=
nating;
> > +                     if (retry) {
> > +                             ret =3D serial8250_rx_dma_try_flush(p);
> > +                             retry =3D dma->rx_pause_pending && !dma->=
rx_terminating;
> > +                     }
> > +                     recover =3D dma->rx_err;
> > +             }
> > +             if (!retry)
> > +                     break;
> > +             if (!warned && ktime_ms_delta(ktime_get(), start) >=3D MS=
EC_PER_SEC) {
> > +                     dev_warn_ratelimited(p->port.dev,
> > +                                          "RX DMA pause stalled: %d; r=
etaining transfer and retrying\n",
> > +                                          ret);
>
> _ratelimited() is a slop of AI without understanding the code. It makes n=
onsense
> in combination with warned.

The two controls have different scopes. warned is local to one invocation
of the flush worker and prevents repeated warning attempts while that
flush remains stalled. A later flush starts with warned cleared again.

The rate limit applies across worker invocations and UART ports. It limits
messages from separate stalls, rather than repeated retries of the same
stall.

>
> > +                     warned =3D true;
>
> Altogether NIH _once().

dev_warn_once() uses a static flag at the call site, shared by all ports.
After the first warning, subsequent stalls would remain silent even after
recovery or reopening the port, including stalls on another UART.

The intended behavior here is at most one warning attempt per prolonged
stall, while keeping later incidents diagnosable and limiting their
aggregate logging rate.

>
> > +             }
> > +             /* Notifications also cover completion or shutdown before=
 sleeping. */
> > +             wait_event_hrtimeout(dma->rx_pause_wait, READ_ONCE(dma->r=
x_pause_wakeup),
> > +                                  ns_to_ktime(delay_us * NSEC_PER_USEC=
));
> > +             delay_us =3D min(delay_us * 2, USEC_PER_SEC);
> > +     }
> > +
> > +     if (recover) {
> > +             ret =3D dmaengine_terminate_sync(dma->rxchan);
> > +             if (ret) {
> > +                     /* Retain ownership and keep RX masked if DMA can=
not be stopped. */
> > +                     dev_err(p->port.dev, "failed to stop RX DMA: %d\n=
", ret);
> > +                     return;
> > +             }
> > +     } else {
> > +             dmaengine_synchronize(dma->rxchan);
> > +     }
> > +
> > +     scoped_guard(uart_port_lock_irqsave, &p->port) {
> > +             restore_rx =3D recover || dma->rx_pause_pending;
> > +             dma->rx_pause_pending =3D false;
> > +             dma->rx_terminating =3D false;
> > +             dma->rx_running =3D 0;
> > +             if (dma->shutting_down)
> > +                     return;
> > +
> > +             if (!restore_rx)
> > +                     return;
> > +
> > +             /* Apply the current enables, including any intervening s=
top_rx(). */
> > +             serial8250_out_IER(p, p->ier);
> > +     }
> > +     if (recover)
> > +             dev_warn(p->port.dev, "RX DMA failed, using PIO\n");
> >  }
>
> ...
>
> > -void serial8250_rx_dma_flush(struct uart_8250_port *p)
> > +int serial8250_rx_dma_flush(struct uart_8250_port *p)
> >  {
> >       struct uart_8250_dma *dma =3D p->dma;
> > +     int ret;
> >
> > -     if (!dma || !dma->rxchan || !dma->rx_running)
> > -             return;
> > +     lockdep_assert_held_once(&p->port.lock);
> >
> > -     dmaengine_pause(dma->rxchan);
> > -     __dma_rx_complete(p);
> > -     dmaengine_terminate_async(dma->rxchan);
> > +     if (!dma || !dma->rx_running)
>
> You introduced a helper serial8250_rx_dma_running(). Use it.
>
> > +             return 0;
> > +     /* A late interrupt must not hand a still-active receiver to PIO.=
 */
> > +     if (dma->shutting_down)
> > +             return -ESHUTDOWN;
> > +     if (dma->rx_terminating)
> > +             return -EIO;
> > +     if (dma->rx_pause_pending)
> > +             return -EAGAIN;
> > +
> > +     ret =3D serial8250_rx_dma_try_flush(p);
> > +     schedule_work(&dma->rx_flush_work);
> > +     return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(serial8250_rx_dma_flush);
>
> ...
>
> >       /* Manually stop the Rx DMA transfer when acting as flow controll=
er */
> > -     if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_ru=
nning && rx_timeout) {
> > +     if (quirks & DW_UART_QUIRK_IS_DMA_FC && rx_timeout &&
> > +         serial8250_rx_dma_running(up) && !up->dma->rx_terminating &&
> > +         !up->dma->rx_pause_pending) {
>
> Re-wrap it logically (also be consistent with parentheses
> when & versus && is used).
>
>         if ((quirks & DW_UART_QUIRK_IS_DMA_FC) && rx_timeout &&
>             serial8250_rx_dma_running(up) &&
>             !up->dma->rx_terminating && !up->dma->rx_pause_pending) {
>
> >       }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

