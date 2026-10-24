Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5862606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2026 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WWwEDF/6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBsXX08shz2y8Z;
	Sun, 25 Oct 2026 07:52:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792875163;
	cv=none; b=fJsxcBJZBQnmpWTHd3OX9Na544au/p4aUMeijjc82x073ENCDUXc0QG9EeBXhZSQ5J6CjWgXQbgxy/C4hS9QqlKvuoEnxPb5w2Do3tw/tPmVwoUA21gHHj1IqAsSiIuMNC1LJMqmrx/GEqmskuStAgHifZc8ppbPOCppdFpUf3LuU918eGCRHtDXWkWoWzJ+G54uuuCtY4wLY/abgmF3+FtbcvV80J4cR9YMd19ejZWzkpF+41Z9NJP7QbOkjomjd/aaediZOVS9zy6mg6mKmjF2H8cIVLAmIcMa3w4yvbcjXix89s88x2nOUzooCKTaUGkHiXq0WwjpuT9hMaUV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792875163; c=relaxed/relaxed;
	bh=Pb6uafnLujlPrbZkRPp3SyQb6j6T74+qvt6k1WA10zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ts4SWBlkH1z7h8+SqSVEjKNnzGyib+V1rDU+chvdhXD87/kuyTb0ZuvT29QtAhoVfuqlVkwnYgMO2U+b5Eeyq5jA4zvhQXcI/GkQGon5W0+LS34Ow5/4ViIlOOBBd49ZRT9D1Ewf0fvYm5aIqY3trgSWhstndxjMkNlmMcGj7Zv7AuZ7gykOKYrbziCJzZpk1Ffm660JUwfAhdF5W6mFLfRghwM1oZF5QbGGyRbAz52qw2gODY8vRxFt/cRsFSCEAi9N3gZH5Fr4dHu+84GIV4aGO970/PS6Wn0I3zXsLEN4/EPKK7nmSwUQvVKOlanD4q10wUQkRf/+kfvLVxphhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WWwEDF/6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WWwEDF/6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jBsXV2zybz30P3
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Oct 2026 07:52:42 +1100 (AEDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-81ae6aefdceso1614483a34.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 13:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792875160; x=1793479960; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pb6uafnLujlPrbZkRPp3SyQb6j6T74+qvt6k1WA10zo=;
        b=WWwEDF/6w5RoAJDX1kCiRklynugekmG5SVf3C36OEy0Zfo2fYon9ZNyAkQo8Scl0dE
         bPN0HtAbiUE2iI/k2+CKDWvV1S4PeHG2/lOi2zlFjhIq601H0hiSSt0Ih8b1JlSe7ouI
         RYBH4224mcnhHfq0vC6XblmLV8dU8IBwTJ4bH+U3N35dVvdYOV+nioy4xpfpIqvlbDys
         y8Sv5RkGYFDxfgx3TBav23p2hosi6T7Ss0i4iCX6+HhCR+DMNUYwYJfYOTtFtyG4c6ue
         AYvLiwWPn1Wp4XXKEEHvDmS5gnpEKIHGbt/9huaoFnaCBymJ9K/ZPktptCQbXafhwrAf
         o/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792875160; x=1793479960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pb6uafnLujlPrbZkRPp3SyQb6j6T74+qvt6k1WA10zo=;
        b=ErZRWFJCr7AygT4VUlK4p2hx+40VxWVRCuKCf6tGFwOUqliSKqxwN3lH4/+04EXLqR
         th6ucoiFcALE01Y3GWVtfKwgS+ZXSMGj5cjJwndrPPLzzjXXY1WF6cWe6/ooUmPgjzF2
         E4weFsdnaEJqd6U/QfPObrawX1Yds/0DFwl3cOj6Juln8NGgCRDDjyg9De3PEFaZorsE
         wTxcu5kXTdiVprwhS/3HjmMpHuFOuyn5gr18KtfKEWvqYUZ3+ArzR8p0UNZ8v/nAqTD+
         +qBXye9tnHLNDPwxNWH5X4MQmjLy+7pc0xGI1iANDUlHqj5C5xfCS5lGJDdgK0uc+13d
         0yqg==
X-Forwarded-Encrypted: i=1; AKwUvByadQl4gAXR+ammz1523AdyrA6RoC+p7oJGqkbr5gaC/CZWhQbhvukdZHfRTyUdLUPxJjlkO836Y5x/50Y=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYILVQkr6pGHTlhnmxPSnZSaXOmphv7hPRc2wCIarWZgTWONIov/
	/KLpmNrQHG4ODlgn79MgDrz6bAFn9Brg1yha4hLDoxZCkYzkiZ6j5hfw
X-Gm-Gg: AYBFou0E07HTyvUFN6g7EP0oKOB4RWZfIvbBnQZpd1eam5609VpB9XXu4XPRlnCRNMU
	CZ+Ib/vjJen30kuPIla0IeIXAdH9IolVCqCF/xasSaKfrU4MYSEL1MqWZDaHCZ99Mk40gg2tCm6
	nDZ1gka5o6QYG4Fc7mGcPT2biOBO+uThQFv+XlCwEQZYjV1/kLCO99Afnziex31Dayxvpdcb+Cp
	SImx4ErzLCGM3SRpy/y42gCJO8508Yu4FR9P2Gby/duVdnCF+sa4ns9ynYfvhVxnIRRmIu+J272
	4T7Nn2rr6El+t6CNA1Hxp9kcsOgmIMGy/KMlntnAvztbQArhkgU3z7+1nFhu9EpvZCZROODT63B
	ELzsZ1A5VOMeHDcUEaVG+9UGrO4Y6yGQBkNF3SkVpALOeTn5pllSbCp3oMFWU53dynvLCFIf/gl
	rkCrJjTOd/Amf+4ZDBPTJQFOd5Szo0Vq7XMKk35IMdIw2lMOYqTEvcdGBTwCQkuiRsq+x/jb6d1
	DAh7HYb+ekWFZfVckT7uPK8c79NkwAU8FNMLyNXzniaIgvYGf7zLOBJSwEHKnPtGjAdmR2x3rIP
	cmTmz0MDax57C6tWX7MGwDD8QdrhlCAUaqrnoi3I4J7pFZnKNh1HB1EtNuFL4P8Bsck4wl9g1b1
	N+xDKBq51yTktWj98ZEHxyHxQ4qfxmAxINwItd+poGrEB8lfnp5oeOBMNAnYytipFVQwEL02SOh
	sFlA==
X-Received: by 2002:a05:6808:4f2c:b0:4f4:d7:b15b with SMTP id 5614622812f47-55bfff95140mr1664597b6e.4.1792875159942;
        Sat, 24 Oct 2026 13:52:39 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0429c932sm1986785b6e.7.2026.10.24.13.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:52:39 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 14:52:30 -0600
Subject: [PATCH v6 5/5] serial: 8250: retire canceled RX DMA before reusing
 the receive buffer
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-serial-8250-dma-cancel-v1-v6-5-6f366591f566@gmail.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com>
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Timur Tabi <timur@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RX timeout path pauses a transfer, copies its data and terminates it
asynchronously. Clearing rx_running at that point lets another receive
reuse the buffer and cookie while the old callback is still waiting for
the port lock. Inspecting the new cookie cannot distinguish that callback
from the completion of a new transfer.

Reserve the receive buffer until a worker has drained the canceled
callbacks. Keep FIFO access separate from callback retirement: after a
successful pause and termination, clear rx_running while rx_terminating
prevents another descriptor from reusing the buffer. Deliver the paused
data before allowing the interrupt handler to drain the FIFO through PIO.
Normal retirement only releases ownership and leaves subsequent receive
handling to the UART interrupt.

Preserve the normal completion-path LSR read and gate DMA resubmission on
the receive interrupt enable, so stop_rx() prevents another transfer while
the status read retains its existing side effects.

Reject new flush work and PIO receive handling during shutdown, including
late Intel MID DMA timeouts. Stop and drain retirement work before freeing
the channels and buffer. Once RX has stopped, allow the idle flush used by
DesignWare LCR recovery during shutdown. Clear the shutdown guard before
startup configures the UART and tests its interrupts.

Check pause failures before accessing the buffer. A successful pause is
the quiescence guarantee, even when a provider still reports IN_PROGRESS.
Also accept DMA_COMPLETE after a failed pause: completion can stop the
channel before its callback acquires the port lock, leaving nothing for
the provider to pause. Retire that completed transfer normally.
On pause, status or termination failure, mask receive interrupts and let
the worker stop DMA before handing the FIFO to PIO. Keep the requested
enables in the existing IER shadow and filter hardware writes throughout
recovery, including termios, RS485 and overrun-backoff changes. Apply the
current enables after recovery so stop_rx() and shutdown remain effective.
Hold a runtime PM reference around worker register accesses and keep RX
on PIO until reopen.

Abort the DesignWare idle sequence when RX cannot be stopped. Allow
the empty-FIFO timeout workaround once DMA has released the FIFO, including
while callbacks retire. Exclude FIFO resets during RX DMA recovery. If the
provider still cannot terminate the channel in process context, retain
its buffer and leave receive interrupts masked.

Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h      |  39 ++++++++-
 drivers/tty/serial/8250/8250_core.c |   2 +-
 drivers/tty/serial/8250/8250_dma.c  | 158 +++++++++++++++++++++++++++---------
 drivers/tty/serial/8250/8250_dw.c   |  27 ++++--
 drivers/tty/serial/8250/8250_port.c |  31 +++++--
 5 files changed, 198 insertions(+), 59 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 9f01fa36fa3c..35a71d4780a5 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -23,6 +23,7 @@ struct uart_8250_dma {
 	/* Completion processing with the port lock held. */
 	void (*tx_complete)(struct uart_8250_port *p);
 	struct work_struct tx_flush_work;
+	struct work_struct rx_flush_work;
 	struct uart_8250_port *port;
 
 	/* Filter function */
@@ -55,11 +56,14 @@ struct uart_8250_dma {
 
 	unsigned char		tx_running;
 	unsigned char		tx_err;
+	/* RX DMA may access the FIFO; independent of callback retirement. */
 	unsigned char		rx_running;
 	/* Protected by the UART port lock. */
 	bool			shutting_down:1;
 	bool			tx_terminating:1;
 	bool			tx_flushed:1;
+	bool			rx_terminating:1;
+	bool			rx_err:1;
 };
 
 struct old_serial_port {
@@ -148,6 +152,28 @@ static inline void serial_out(struct uart_8250_port *up, int offset, int value)
 	up->port.serial_out(&up->port, offset, value);
 }
 
+static inline bool serial8250_rx_dma_running(struct uart_8250_port *up)
+{
+	return up->dma && up->dma->rx_running;
+}
+
+static inline bool serial8250_rx_dma_recovering(struct uart_8250_port *up)
+{
+	return up->dma && up->dma->rx_err && up->dma->rx_terminating;
+}
+
+/* Keep the desired enables in up->ier while RX DMA recovery masks hardware. */
+static inline void serial8250_out_IER(struct uart_8250_port *up, u8 ier)
+{
+	lockdep_assert_held_once(&up->port.lock);
+
+	if (up->dma && up->dma->shutting_down)
+		ier = 0;
+	else if (serial8250_rx_dma_recovering(up))
+		ier &= ~(UART_IER_RDI | UART_IER_RLSI | UART_IER_RTOIE);
+	serial_out(up, UART_IER, ier);
+}
+
 /**
  *	serial_lsr_in - Read LSR register and preserve flags across reads
  *	@up:	uart 8250 port
@@ -221,7 +247,7 @@ static inline bool serial8250_set_THRI(struct uart_8250_port *up)
 	if (up->ier & UART_IER_THRI)
 		return false;
 	up->ier |= UART_IER_THRI;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 	return true;
 }
 
@@ -233,7 +259,7 @@ static inline bool serial8250_clear_THRI(struct uart_8250_port *up)
 	if (!(up->ier & UART_IER_THRI))
 		return false;
 	up->ier &= ~UART_IER_THRI;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 	return true;
 }
 
@@ -417,7 +443,7 @@ extern void serial8250_tx_dma_flush(struct uart_8250_port *);
 void serial8250_tx_dma_sync_buffer(struct uart_8250_port *p,
 				   struct scatterlist *sgl, unsigned int nents);
 extern int serial8250_rx_dma(struct uart_8250_port *);
-extern void serial8250_rx_dma_flush(struct uart_8250_port *);
+int serial8250_rx_dma_flush(struct uart_8250_port *p);
 extern int serial8250_request_dma(struct uart_8250_port *);
 extern void serial8250_release_dma(struct uart_8250_port *);
 
@@ -473,7 +499,12 @@ static inline int serial8250_rx_dma(struct uart_8250_port *p)
 {
 	return -1;
 }
-static inline void serial8250_rx_dma_flush(struct uart_8250_port *p) { }
+
+static inline int serial8250_rx_dma_flush(struct uart_8250_port *p)
+{
+	return 0;
+}
+
 static inline int serial8250_request_dma(struct uart_8250_port *p)
 {
 	return -1;
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 42319843cb5b..ca06288038ed 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -738,7 +738,7 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
 
 	guard(uart_port_lock_irqsave)(&up->port);
 	up->ier |= UART_IER_RLSI | UART_IER_RDI;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 static int __serial8250_register_8250_port(struct uart_8250_port *uart,
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 1a070967bf57..37697d1fabd5 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -86,53 +86,96 @@ void serial8250_tx_dma_sync_buffer(struct uart_8250_port *p,
 }
 EXPORT_SYMBOL_GPL(serial8250_tx_dma_sync_buffer);
 
-static void __dma_rx_complete(struct uart_8250_port *p)
+static void serial8250_rx_dma_copy(struct uart_8250_port *p,
+				   const struct dma_tx_state *state)
 {
 	struct uart_8250_dma	*dma = p->dma;
 	struct tty_port		*tty_port = &p->port.state->port;
-	struct dma_tx_state	state;
-	enum dma_status		dma_status;
-	int			count;
-
-	/*
-	 * New DMA Rx can be started during the completion handler before it
-	 * could acquire port's lock and it might still be ongoing. Don't to
-	 * anything in such case.
-	 */
-	dma_status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
-	if (dma_status == DMA_IN_PROGRESS)
-		return;
-
-	count = dma->rx_size - state.residue;
+	size_t			count = dma->rx_size - state->residue;
 
 	if (tty_insert_flip_string(tty_port, dma->rx_buf, count) != count)
 		p->port.icount.buf_overrun++;
 	p->port.icount.rx += count;
-	dma->rx_running = 0;
 
 	tty_flip_buffer_push(tty_port);
 }
 
+static void serial8250_rx_dma_recover(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	/* Keep PIO and new descriptors out until the worker stops the channel. */
+	dma->rx_err = true;
+	dma->rx_terminating = true;
+	serial8250_out_IER(p, p->ier);
+	schedule_work(&dma->rx_flush_work);
+}
+
 static void dma_rx_complete(void *param)
 {
 	struct uart_8250_port *p = param;
 	struct uart_8250_dma *dma = p->dma;
-	unsigned long flags;
+	struct dma_tx_state state;
+	enum dma_status status;
 
-	uart_port_lock_irqsave(&p->port, &flags);
-	if (dma->shutting_down)
-		goto out;
-	if (dma->rx_running)
-		__dma_rx_complete(p);
+	guard(uart_port_lock_irqsave)(&p->port);
 
-	/*
-	 * Cannot be combined with the previous check because __dma_rx_complete()
-	 * changes dma->rx_running.
-	 */
-	if (!dma->rx_running && (serial_lsr_in(p) & UART_LSR_DR))
-		p->dma->rx_dma(p);
-out:
-	uart_port_unlock_irqrestore(&p->port, flags);
+	if (dma->shutting_down || dma->rx_terminating)
+		return;
+	if (dma->rx_running) {
+		status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
+		if (status == DMA_ERROR) {
+			serial8250_rx_dma_recover(p);
+			return;
+		}
+		if (status != DMA_COMPLETE)
+			return;
+		serial8250_rx_dma_copy(p, &state);
+		dma->rx_running = 0;
+	}
+
+	/* Preserve LSR read side effects when stop_rx() has disabled resubmission. */
+	if ((serial_lsr_in(p) & UART_LSR_DR) && (p->ier & UART_IER_RDI))
+		dma->rx_dma(p);
+}
+
+static void serial8250_rx_dma_flush_work(struct work_struct *work)
+{
+	struct uart_8250_dma *dma = container_of(work, struct uart_8250_dma, rx_flush_work);
+	struct uart_8250_port *p = dma->port;
+	bool recover;
+	int ret;
+
+	/* All packed flags share the port lock, including this worker snapshot. */
+	scoped_guard(uart_port_lock_irqsave, &p->port)
+		recover = dma->rx_err;
+
+	if (recover) {
+		ret = dmaengine_terminate_sync(dma->rxchan);
+		if (ret) {
+			/* Retain ownership and keep RX masked if DMA cannot be stopped. */
+			dev_err(p->port.dev, "failed to stop RX DMA: %d\n", ret);
+			return;
+		}
+	} else {
+		dmaengine_synchronize(dma->rxchan);
+	}
+
+	guard(serial8250_rpm)(p);
+
+	scoped_guard(uart_port_lock_irqsave, &p->port) {
+		dma->rx_terminating = false;
+		dma->rx_running = 0;
+		if (dma->shutting_down)
+			return;
+
+		if (!recover)
+			return;
+
+		/* Apply the current enables, including any intervening stop_rx(). */
+		serial8250_out_IER(p, p->ier);
+	}
+	dev_warn(p->port.dev, "RX DMA failed, using PIO\n");
 }
 
 int serial8250_tx_dma(struct uart_8250_port *p)
@@ -242,6 +285,9 @@ int serial8250_rx_dma(struct uart_8250_port *p)
 
 	if (dma->shutting_down || dma->rx_running)
 		return 0;
+	/* A retiring transfer has released the FIFO, but not its buffer. */
+	if (dma->rx_err || dma->rx_terminating)
+		return -EIO;
 
 	serial8250_do_prepare_rx_dma(p);
 
@@ -262,16 +308,47 @@ int serial8250_rx_dma(struct uart_8250_port *p)
 	return 0;
 }
 
-void serial8250_rx_dma_flush(struct uart_8250_port *p)
+int serial8250_rx_dma_flush(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
+	struct dma_tx_state state;
+	enum dma_status status;
+	int ret;
 
-	if (!dma || !dma->rxchan || !dma->rx_running)
-		return;
+	lockdep_assert_held_once(&p->port.lock);
 
-	dmaengine_pause(dma->rxchan);
-	__dma_rx_complete(p);
-	dmaengine_terminate_async(dma->rxchan);
+	if (!dma || !dma->rx_running)
+		return 0;
+	/* A late interrupt must not hand a still-active receiver to PIO. */
+	if (dma->shutting_down)
+		return -ESHUTDOWN;
+	if (dma->rx_terminating)
+		return -EIO;
+
+	ret = dmaengine_pause(dma->rxchan);
+	status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
+	/* A completed transfer may reject pause before its callback gets the lock. */
+	if (ret && status != DMA_COMPLETE)
+		goto recover;
+	if (status == DMA_ERROR) {
+		ret = -EIO;
+		goto recover;
+	}
+	/* Some providers still report IN_PROGRESS after a successful pause. */
+	serial8250_rx_dma_copy(p, &state);
+	dma->rx_terminating = true;
+	ret = dmaengine_terminate_async(dma->rxchan);
+	if (ret)
+		goto recover;
+
+	/* DMA released the FIFO; retain the buffer until callbacks retire. */
+	dma->rx_running = 0;
+	schedule_work(&dma->rx_flush_work);
+	return 0;
+
+recover:
+	serial8250_rx_dma_recover(p);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(serial8250_rx_dma_flush);
 
@@ -368,10 +445,13 @@ int serial8250_request_dma(struct uart_8250_port *p)
 
 	dma->port = p;
 	INIT_WORK(&dma->tx_flush_work, serial8250_tx_dma_flush_work);
+	INIT_WORK(&dma->rx_flush_work, serial8250_rx_dma_flush_work);
 
 	scoped_guard(uart_port_lock_irqsave, &p->port) {
 		dma->tx_terminating = false;
 		dma->tx_flushed = false;
+		dma->rx_terminating = false;
+		dma->rx_err = false;
 		dma->shutting_down = false;
 	}
 	dev_dbg_ratelimited(p->port.dev, "got both dma channels\n");
@@ -395,10 +475,14 @@ void serial8250_release_dma(struct uart_8250_port *p)
 		return;
 
 	cancel_work_sync(&dma->tx_flush_work);
+	cancel_work_sync(&dma->rx_flush_work);
 
 	/* Release RX resources */
 	dmaengine_terminate_sync(dma->rxchan);
-	dma->rx_running = 0;
+	scoped_guard(uart_port_lock_irqsave, &p->port) {
+		dma->rx_running = 0;
+		dma->rx_terminating = false;
+	}
 	dma_free_coherent(dmaengine_get_dma_device(dma->rxchan), dma->rx_size,
 			  dma->rx_buf, dma->rx_addr);
 	dma_release_channel(dma->rxchan);
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index d036a2fe258a..f05450bba400 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -112,7 +112,7 @@ static void dw8250_idle_exit(struct uart_port *p)
 	if (up->capabilities & UART_CAP_FIFO)
 		serial_port_out(p, UART_FCR, up->fcr);
 	serial_port_out(p, UART_MCR, up->mcr);
-	serial_port_out(p, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 
 	/* DMA Rx is restarted by IRQ handler as needed. */
 	if (up->dma)
@@ -134,6 +134,7 @@ static int dw8250_idle_enter(struct uart_port *p)
 	unsigned int usr_reg = d->pdata ? d->pdata->usr_reg : DW_UART_USR;
 	struct uart_8250_port *up = up_to_u8250p(p);
 	int retries;
+	int ret;
 	u32 lsr;
 
 	lockdep_assert_held_once(&p->lock);
@@ -147,7 +148,12 @@ static int dw8250_idle_enter(struct uart_port *p)
 	serial_port_out(p, UART_IER, 0);
 
 	if (up->dma) {
-		serial8250_rx_dma_flush(up);
+		ret = serial8250_rx_dma_flush(up);
+		if (ret) {
+			serial8250_out_IER(up, up->ier);
+			d->in_idle = 0;
+			return ret;
+		}
 		if (serial8250_tx_dma_running(up))
 			serial8250_tx_dma_pause(up);
 	}
@@ -392,9 +398,9 @@ static void dw8250_quirk_ier_kick(struct uart_port *p)
 	if (!(lsr & UART_LSR_THRE))
 		return;
 
-	serial_port_out(p, UART_IER, up->ier | UART_IER_THRI);
+	serial8250_out_IER(up, up->ier | UART_IER_THRI);
 	serial_port_in(p, UART_LCR);		/* safe, no side-effects */
-	serial_port_out(p, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 static int dw8250_handle_irq(struct uart_port *p)
@@ -431,6 +437,9 @@ static int dw8250_handle_irq(struct uart_port *p)
 
 	d->no_int_count = 0;
 
+	if (up->dma && up->dma->shutting_down)
+		return 1;
+
 	/*
 	 * There are ways to get Designware-based UARTs into a state where
 	 * they are asserting UART_IIR_RX_TIMEOUT but there is no actual
@@ -438,10 +447,11 @@ static int dw8250_handle_irq(struct uart_port *p)
 	 * read.  If we don't do this then the "RX TIMEOUT" interrupt will
 	 * fire forever.
 	 *
-	 * This problem has only been observed so far when not in DMA mode
-	 * so we limit the workaround only to non-DMA mode.
+	 * Only read the FIFO when DMA no longer owns it, including PIO fallback
+	 * after a DMA error.
 	 */
-	if (!(quirks & DW_UART_QUIRK_SKIP_EMPTY_FIFO_READ) && !up->dma && rx_timeout) {
+	if (!(quirks & DW_UART_QUIRK_SKIP_EMPTY_FIFO_READ) &&
+	    !serial8250_rx_dma_running(up) && rx_timeout) {
 		status = serial_lsr_in(up);
 
 		/*
@@ -456,7 +466,8 @@ static int dw8250_handle_irq(struct uart_port *p)
 	}
 
 	/* Manually stop the Rx DMA transfer when acting as flow controller */
-	if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_running && rx_timeout) {
+	if (quirks & DW_UART_QUIRK_IS_DMA_FC && rx_timeout &&
+	    serial8250_rx_dma_running(up) && !up->dma->rx_terminating) {
 		status = serial_lsr_in(up);
 
 		if (status & (UART_LSR_DR | UART_LSR_BI)) {
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f36f7e18ab95..24964acc87f8 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1306,7 +1306,7 @@ static void serial8250_stop_rx(struct uart_port *port)
 	guard(serial8250_rpm)(up);
 
 	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 /**
@@ -1332,7 +1332,8 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
 	 * Enable previously disabled RX interrupts.
 	 */
 	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
-		serial8250_clear_and_reinit_fifos(p);
+		if (!serial8250_rx_dma_recovering(p))
+			serial8250_clear_and_reinit_fifos(p);
 
 		if (toggle_ier) {
 			/*
@@ -1346,7 +1347,7 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
 			lockdep_assert_held_once(&p->port.lock);
 
 			p->ier |= UART_IER_RLSI | UART_IER_RDI;
-			serial_port_out(&p->port, UART_IER, p->ier);
+			serial8250_out_IER(p, p->ier);
 		}
 	}
 }
@@ -1600,7 +1601,7 @@ static void serial8250_disable_ms(struct uart_port *port)
 	mctrl_gpio_disable_ms_no_sync(up->gpios);
 
 	up->ier &= ~UART_IER_MSI;
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 static void serial8250_enable_ms(struct uart_port *port)
@@ -1619,7 +1620,7 @@ static void serial8250_enable_ms(struct uart_port *port)
 	up->ier |= UART_IER_MSI;
 
 	guard(serial8250_rpm)(up);
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 void serial8250_read_char(struct uart_8250_port *up, u16 lsr)
@@ -1816,8 +1817,7 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 		fallthrough;
 	case UART_IIR_RLSI:
 	case UART_IIR_RX_TIMEOUT:
-		serial8250_rx_dma_flush(up);
-		return true;
+		return !serial8250_rx_dma_flush(up);
 	}
 	return up->dma->rx_dma(up);
 }
@@ -1837,15 +1837,22 @@ void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
 
 	lockdep_assert_held_once(&port->lock);
 
+	if (up->dma && up->dma->shutting_down)
+		return;
+
 	status = serial_lsr_in(up);
 
 	/*
 	 * Recover from no-data-ready and FIFO error condition to avoid getting
 	 * stuck in the ISR.
 	 */
-	if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE))
+	if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE) &&
+	    !serial8250_rx_dma_running(up))
 		serial8250_clear_and_reinit_fifos(up);
 
+	if (serial8250_rx_dma_recovering(up))
+		skip_rx = true;
+
 	/*
 	 * If port is stopped and there are no error conditions in the
 	 * FIFO, then don't drain the FIFO, as this may lead to TTY buffer
@@ -2345,6 +2352,12 @@ int serial8250_do_startup(struct uart_port *port)
 
 	guard(serial8250_rpm)(up);
 
+	/* The previous shutdown has drained DMA and its callbacks. */
+	scoped_guard(uart_port_lock_irqsave, port) {
+		if (up->dma)
+			up->dma->shutting_down = false;
+	}
+
 	serial8250_startup_special(port);
 
 	/*
@@ -2786,7 +2799,7 @@ static void serial8250_set_ier(struct uart_port *port, struct ktermios *termios)
 	if (up->capabilities & UART_CAP_RTOIE)
 		up->ier |= UART_IER_RTOIE;
 
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 static void serial8250_set_efr(struct uart_port *port, struct ktermios *termios)

-- 
2.53.0


