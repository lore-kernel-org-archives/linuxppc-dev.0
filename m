Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1223E606A88E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGgysugt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyY91RYDz3bdD;
	Thu, 12 Nov 2026 09:16:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::229"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794435405;
	cv=none; b=EYIheSJ2DLuN6IW3UwdWIytAibxun4xqa4eJeevyMBu3tDn+DfktI3iOSDZF2dVfUPH6tgoDDw5fmDYw/jaJPpRYktraW4sFUlCHrWGO241VNAxE+osiyKZS/KH2w04iqgpZNezmb6r5nIsClNu2uyx6E7WcgqNV9agido15IXT6Mn0n+zGOQCpSwE2FJEKtUlgu953T9oF5tAFJlFWP5PbidWkFndN50CxHUUoTJK7ha/g+Bv9SnxUL0tpnyHAA35NG6Xvh+emCemVqd9t8v1Qf7aLcLraWlegIGuTKGNAGFHYM71+j6VViAR4rWZs/QssFZpTGsazf0ia2lGjznA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794435405; c=relaxed/relaxed;
	bh=ZHEvTQZaDSERMBrfaBr2M8K3I74LqKqS4UfdKeh+wYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rto04mtgl1fUlvEqvivAArYlFonndKMkM/LPryRtQXx3/cNF0UK1+T7gIEsLSBIA508dZ4qJs2Z/yIM5dDXeTrigj6yPmfe/NOGonx/CzZkyxDTQ62AHA9uNrp9M0yR9HE5Hm0IQifLDU1fwNk+IphhYp0ZfObniubvuyfLqt5gkvdwWFoB8P53NwY1CGKLwkfo9GMJpXw1WlSpSKpqM0IjeG/Oqu8QIyCwWf0vKSudh+Tfmfdn+tLEWmOfCQ+qngQabkwO0WeGjNB4hznCWoeISBbX1gbvQ0mNtsK9keOuiWKcENKgyYom/qVDwTkZJPw3/mkzVoikYatf5f88RFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGgysugt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGgysugt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyY70l3wz3bYG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:16:42 +1100 (AEDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-53ec9237600so1787608b6e.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 14:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794435400; x=1795040200; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZHEvTQZaDSERMBrfaBr2M8K3I74LqKqS4UfdKeh+wYI=;
        b=cGgysugt7oL7Pa5jGggztyPzInMC21SFKXGRWi2YxDrkvNmp8XZacByW054JNBRZRq
         rNQnZJIqLAU4h9gifeBg+KsqWKl4hGRR5tVWI/JlZjXrgwIfwO73y1LPTWWDcU6UJnvP
         Xy/5b0nNjxRcjy2PODwFUbLruSrRoxBD+uDC0L++H+fEvrbtIZjNeOZSTIOvAYskGgqf
         JscHyKoQJrRf7j+6As5AHfF5grLhPQBWszR5RbHrqWCM5vpWPr1mY5UbiTpXyz6cxVly
         5eqqJKepRgKpWknI716mvGKi23wgtCW3+Ph7qXcozwui80iGNqNNYreA9i1kr8r1o+qd
         ZEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794435400; x=1795040200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZHEvTQZaDSERMBrfaBr2M8K3I74LqKqS4UfdKeh+wYI=;
        b=TuOLuOEV/9B6SRoAx19iE2ce6kTsoNd5NkjrWf1goYfEtukLhDFd2E9b++Wt4rQBTa
         uperGz1MhMexpDOPzYDjBhInqcl5FALMbHVJFcQvKrlK0XCbf3D4G39kG0V4jYMDUhF+
         9qpkbyNqkmpiJ10EcW7G1Rvqi4QhbdyTmwkwWdQGIg2IFvxO1zpDPWImvEesu8ESiOAL
         KeIXsTBJTNY3qGGkzwzDHfy2wjKQPluUkr+N1voIxlwaAciXFCy4I1Vpm27YkXCz3ukn
         sU5PwFic/S2XBG7nVjlUGRwBZmc4Pbj1ruw3vaF/8wohgpz2TJud2QYzB5924JpUplSj
         5zNw==
X-Forwarded-Encrypted: i=1; AL+hErF189NrVr6+nLLmMSFNm2MSg9WRfgRfdPqPBE1Fljv2LAVOrfxq9mLNQOcJY3t3rOwLlq7RupBMU/r50eE=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/sfmWT4oH1xcbrSsCjMSnyQPL9tfW0L+bmMpL+Oo8AQrEyzurz
	c//lbjd8B8SntbHFjVKk9diYBdPuW0mKS8M5fBy/p9J5H5lsRmDao1LL
X-Gm-Gg: AYBFou17ofzQFiGjD1BigLR6ktMFb1AfsyWnbomz8Gz7MG9nsIS51Gte59KFajyhhCa
	d8o1If3SG2vwMIJdjoN5+2a5qqklocJY4dXMxArNb8DgiIrxb9vm+5pPm0L4+OmGdmfMlPcpNUk
	16tCExmAqiaTgyAg6US8tw1zgAErciXGZgyFurMSEYgp8MBhkDpODXVnItE0dNuDgVlG8d8pjVi
	k09LTDOt42zPG5fMT+8FXCTO5XYk7VlCH0AFb+Rd1674lfHqPMocHXUp6NTZHtL82f5rxcT/ODG
	LjcIzvY8AfI3latuMUaiE0Qsw4s3+lVyklA+8NLX+1Oy6P8EOPL7HUsXJ9jXLbpLbmj8oCG4g5d
	wb6GUQRxt163Tf1nuIFWhUsf2KrOkzw7dX6PV+B29twLLrqaMzsmiJx6odlV4pRnadE5YbWnYiT
	Ozzxgv1Zd2Fqvcdr6LVdFDCIU18CtEV6296TeeJMvmdcQQBhv9rpY/GGF6U5t4qnCZoP4kBR+sr
	mNn5TJZkuqCWtMZe9JA4Co9ldFYRFLo5cMtpofSVrvJxJ1iUPD0t0mdAkU6c4K9mjPXBOzHcRi/
	F2nD2pK3cZJOLTTjOwxZwytTkBfDpadKWyzyiGvgPFmvXh5qLc1qMJKSvMsMlP06cmurtfy4TLa
	Yy1YhG0HyRgMrzLBAO4CAtI03KMSWGETv9wUDdB0RDQrFiIiDsZJafQYu69qHRNlo2AUAVf6Cmc
	3kLd27jC+MgnntTeyTu/BMa3bi7WrFySjmupBKm+tkFiZH4BBC7k7HpYOhLb57QlFj/gxzxw0s
X-Received: by 2002:a05:6808:e8d:b0:53a:88c6:96c8 with SMTP id 5614622812f47-56b97100593mr3406869b6e.55.1794435400488;
        Wed, 11 Nov 2026 14:16:40 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56902ae38ecsm5917498b6e.1.2026.11.11.14.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:16:40 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 15:16:30 -0700
Subject: [PATCH v12 5/8] serial: core: allow drivers to reserve flushed
 transmit storage
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
Message-Id: <20261111-submit-serial-8250-dma-cancel-v1-v12-5-9e3456bc2555@gmail.com>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
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
 Timur Tabi <timur@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

uart_flush_buffer() resets the transmit FIFO before calling the driver's
flush callback. An asynchronous DMA transfer can still access that storage
after the callback returns, while a new write can immediately reuse it.

Add uart_xmit_block() and uart_xmit_unblock() so a driver can reserve the
flushed storage until its transfer and completion callbacks have retired.
Serialize the reservation with FIFO producers using the port lock.

While the storage is reserved, write_room() reports no space and write()
and put_char() accept no data. Defer write-ready notifications until the
reservation is released, preserving one-shot TTY wakeups. Keep the flush's
write-ready notification under the port lock so it cannot race another
reservation.

Wake tty->write_wait after flushing even when writes remain blocked.
tty_wait_until_sent() waits for the logical FIFO to empty, independently
of whether its storage can be reused. Notify these drain waiters without
invoking the line discipline's write_wakeup() callback, so a reservation
does not prevent a completed logical flush from waking a drain waiter or
consume a one-shot write-ready notification prematurely.

Suppress ordinary TX starts while the FIFO storage is blocked. Preserve
high-priority flow-control characters, which use separate storage.
Releasing the reservation wakes writers through the existing TTY wakeup
path. This preserves immediate logical flushing while applying write
backpressure until the storage is reusable.

Track port readiness separately from DMA ownership. Retirement releases the
reservation even during startup or shutdown, while writes and wakeups stay
gated until successful startup or resume. Reopening or restarting a port
wakes deferred writers with either a new or retained FIFO. Restart queued
output when reusing a FIFO after suspension. Keep its write-ready
notification pending until the retained output drains below the normal
wakeup threshold. Share that threshold check with generic 8250 and OMAP
TX DMA completion through uart_write_wakeup_if_needed().

Publish resume readiness under the same port lock as the TX restart,
without clearing any reservation. A concurrent flush can then reserve a
new transfer without resume releasing its storage prematurely.

Assert the port-lock requirement at uart_write_wakeup(), alongside the
reservation helpers, so callers cannot inspect readiness or release a
one-shot notification concurrently with a reservation change.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
---
 drivers/tty/serial/8250/8250_dma.c  |   4 +-
 drivers/tty/serial/8250/8250_omap.c |   3 +-
 drivers/tty/serial/serial_core.c    | 104 ++++++++++++++++++++++++++++++++----
 include/linux/serial_core.h         |  34 +++++++++++-
 4 files changed, 129 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 57fc7915adac..43c55cb991a5 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -15,7 +15,6 @@ static void __dma_tx_complete(void *param)
 {
 	struct uart_8250_port	*p = param;
 	struct uart_8250_dma	*dma = p->dma;
-	struct tty_port		*tport = &p->port.state->port;
 	unsigned long	flags;
 	int		ret;
 
@@ -30,8 +29,7 @@ static void __dma_tx_complete(void *param)
 
 	uart_xmit_advance(&p->port, dma->tx_size);
 
-	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
-		uart_write_wakeup(&p->port);
+	uart_write_wakeup_if_needed(&p->port);
 
 	ret = serial8250_tx_dma(p);
 	if (ret || !dma->tx_running)
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index f1980c15f85a..366fa787292c 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1107,8 +1107,7 @@ static void omap_8250_tx_dma_complete(struct uart_8250_port *p)
 		omap8250_restore_regs(p);
 	}
 
-	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
-		uart_write_wakeup(&p->port);
+	uart_write_wakeup_if_needed(&p->port);
 
 	if (!kfifo_is_empty(&tport->xmit_fifo) && !uart_tx_stopped(&p->port)) {
 		int ret;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c0deec0e6af4..0f6613814ce3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -100,6 +100,11 @@ static inline struct uart_port *uart_port_check(struct uart_state *state)
 	return state->uart_port;
 }
 
+static bool uart_xmit_writable(const struct uart_state *state)
+{
+	return state->xmit_ready && !state->xmit_blocked;
+}
+
 /**
  * uart_write_wakeup - schedule write processing
  * @port: port to be processed
@@ -114,15 +119,77 @@ static inline struct uart_port *uart_port_check(struct uart_state *state)
 void uart_write_wakeup(struct uart_port *port)
 {
 	struct uart_state *state = port->state;
+
+	lockdep_assert_held_once(&port->lock);
+
 	/*
 	 * This means you called this function _after_ the port was
 	 * closed.  No cookie for you.
 	 */
 	BUG_ON(!state);
+	if (!uart_xmit_writable(state))
+		return;
 	tty_port_tty_wakeup(&state->port);
 }
 EXPORT_SYMBOL(uart_write_wakeup);
 
+/* Publish readiness without releasing any transfer's storage reservation. */
+static void uart_xmit_enable(struct uart_port *port)
+{
+	struct uart_state *state = port->state;
+
+	lockdep_assert_held_once(&port->lock);
+	if (state->xmit_ready)
+		return;
+	state->xmit_ready = true;
+	uart_write_wakeup_if_needed(port);
+}
+
+/**
+ * uart_xmit_block - reserve flushed transmit storage
+ * @port: port whose transmit storage is still in use
+ *
+ * A driver may call this from ->flush_buffer() if DMA still owns the old
+ * transmit data. The logical FIFO has already been emptied, but writers
+ * must not overwrite its storage until uart_xmit_unblock() is called.
+ * write_room() reports zero and write()/put_char() accept no data meanwhile.
+ * Line-discipline write wakeups are deferred until the reservation is released.
+ *
+ * The driver must unblock after retiring the transfer, including on shutdown.
+ * Serial core separately gates writes and wakeups until startup or resume
+ * has made the port ready.
+ * Repeated calls are idempotent, not nested reservations.
+ *
+ * Context: @port->lock held.
+ */
+void uart_xmit_block(struct uart_port *port)
+{
+	lockdep_assert_held_once(&port->lock);
+	port->state->xmit_blocked = true;
+}
+EXPORT_SYMBOL_GPL(uart_xmit_block);
+
+/**
+ * uart_xmit_unblock - release reserved transmit storage and wake writers
+ * @port: port whose storage is available again
+ *
+ * The old transfer must no longer access the FIFO storage, and any required
+ * DMA synchronization must have completed before this call.
+ * Retirement is recorded even while the port is inactive. Writes and wakeups
+ * remain deferred until startup or resume has made the port ready.
+ *
+ * Context: @port->lock held.
+ */
+void uart_xmit_unblock(struct uart_port *port)
+{
+	lockdep_assert_held_once(&port->lock);
+	if (!port->state->xmit_blocked)
+		return;
+	port->state->xmit_blocked = false;
+	uart_write_wakeup(port);
+}
+EXPORT_SYMBOL_GPL(uart_xmit_unblock);
+
 static void uart_stop(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
@@ -141,7 +208,10 @@ static void __uart_start(struct uart_state *state)
 	struct serial_port_device *port_dev;
 	int err;
 
-	if (!port || port->flags & UPF_DEAD || uart_tx_stopped(port))
+	if (!port || port->flags & UPF_DEAD || uart_tx_stopped(port) || !state->xmit_ready)
+		return;
+	/* High-priority flow-control characters have their own storage. */
+	if (state->xmit_blocked && !port->x_char)
 		return;
 
 	port_dev = port->port_dev;
@@ -375,6 +445,11 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state,
 		return -EIO;
 
 	serial_base_port_startup(uport);
+	scoped_guard(uart_port_lock_irq, uport) {
+		uart_xmit_enable(uport);
+		if (!kfifo_is_empty(&port->xmit_fifo) || uport->x_char)
+			__uart_start(state);
+	}
 
 	return 0;
 }
@@ -397,8 +472,11 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	if (tty)
 		set_bit(TTY_IO_ERROR, &tty->flags);
 
-	if (uport)
+	if (uport) {
+		scoped_guard(uart_port_lock_irq, uport)
+			state->xmit_ready = false;
 		serial_base_port_shutdown(uport);
+	}
 
 	if (tty_port_initialized(port)) {
 		tty_port_set_initialized(port, false);
@@ -593,7 +671,7 @@ static int uart_put_char(struct tty_struct *tty, u8 c)
 		return 0;
 	}
 
-	if (port)
+	if (port && uart_xmit_writable(state))
 		ret = kfifo_put(&state->port.xmit_fifo, c);
 	uart_port_unlock_deref(port, flags);
 	return ret;
@@ -624,7 +702,7 @@ static ssize_t uart_write(struct tty_struct *tty, const u8 *buf, size_t count)
 		return 0;
 	}
 
-	if (port)
+	if (port && uart_xmit_writable(state))
 		ret = kfifo_in(&state->port.xmit_fifo, buf, count);
 
 	__uart_start(state);
@@ -640,7 +718,7 @@ static unsigned int uart_write_room(struct tty_struct *tty)
 	unsigned int ret;
 
 	port = uart_port_ref_lock(state, &flags);
-	if (!state->port.xmit_buf)
+	if (!state->port.xmit_buf || !uart_xmit_writable(state))
 		ret = 0;
 	else
 		ret = kfifo_avail(&state->port.xmit_fifo);
@@ -682,8 +760,12 @@ static void uart_flush_buffer(struct tty_struct *tty)
 	kfifo_reset(&state->port.xmit_fifo);
 	if (port->ops->flush_buffer)
 		port->ops->flush_buffer(port);
+	/* Serialize the wakeup with reservation changes, including another flush. */
+	uart_write_wakeup(port);
 	uart_port_unlock_deref(port, flags);
-	tty_port_tty_wakeup(&state->port);
+
+	/* Drain waiters observe FIFO emptiness, not write readiness. */
+	wake_up_interruptible(&tty->write_wait);
 }
 
 /*
@@ -1748,8 +1830,10 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	if (WARN(!uport, "detached port still initialized!\n"))
 		return;
 
-	scoped_guard(uart_port_lock_irq, uport)
+	scoped_guard(uart_port_lock_irq, uport) {
+		state->xmit_ready = false;
 		uport->ops->stop_rx(uport);
+	}
 
 	serial_base_port_shutdown(uport);
 	uart_port_shutdown(port);
@@ -2391,9 +2475,10 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		unsigned int mctrl;
 
 		tty_port_set_suspended(port, true);
-		tty_port_set_initialized(port, false);
 
 		scoped_guard(uart_port_lock_irq, uport) {
+			state->xmit_ready = false;
+			tty_port_set_initialized(port, false);
 			ops->stop_tx(uport);
 			if (!(uport->rs485.flags & SER_RS485_ENABLED))
 				ops->set_mctrl(uport, 0);
@@ -2498,8 +2583,9 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 					if (!(uport->rs485.flags & SER_RS485_ENABLED))
 						ops->set_mctrl(uport, uport->mctrl);
 					ops->start_tx(uport);
+					tty_port_set_initialized(port, true);
+					uart_xmit_enable(uport);
 				}
-				tty_port_set_initialized(port, true);
 			} else {
 				/*
 				 * Failed to resume - maybe hardware went away?
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4eeb8253752a..2297b870cb86 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -208,8 +208,17 @@ struct gpio_desc;
  *	Flush any write buffers, reset any DMA state and stop any ongoing DMA
  *	transfers.
  *
- *	This will be called whenever the @port->state->xmit circular buffer is
- *	cleared.
+ *	This is called after the transmit FIFO has been cleared, with @port->lock
+ *	still held. A driver whose asynchronous transfer can still access the
+ *	flushed storage must call uart_xmit_block() before returning. This keeps
+ *	write_room() at zero and prevents write() and put_char() from reusing the
+ *	storage until the driver calls uart_xmit_unblock().
+ *
+ *	Release the reservation only after the transfer and its callbacks have
+ *	retired and any required DMA synchronization has completed. Shutdown must
+ *	also retire the transfer and release the reservation before returning,
+ *	since serial core then frees the transmit buffer. Serial core separately
+ *	gates writes and wakeups until startup or resume has made the port ready.
  *
  *	Locking: @port->lock taken.
  *	Interrupts: locally disabled.
@@ -834,6 +843,9 @@ enum uart_pm_state {
  */
 struct uart_state {
 	struct tty_port		port;
+	/* TX readiness and storage ownership; protected by the UART port lock. */
+	bool			xmit_ready;
+	bool			xmit_blocked;
 
 	enum uart_pm_state	pm_state;
 
@@ -909,6 +921,24 @@ struct uart_driver {
 };
 
 void uart_write_wakeup(struct uart_port *port);
+void uart_xmit_block(struct uart_port *port);
+void uart_xmit_unblock(struct uart_port *port);
+
+/**
+ * uart_write_wakeup_if_needed - notify writers when queued output is low
+ * @port: port to be processed
+ *
+ * Keep one-shot write-wakeup notifications pending until fewer than
+ * %WAKEUP_CHARS remain in the transmit FIFO. This also applies to output
+ * retained across suspend and resume.
+ *
+ * Context: @port->lock held.
+ */
+static inline void uart_write_wakeup_if_needed(struct uart_port *port)
+{
+	if (kfifo_len(&port->state->port.xmit_fifo) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+}
 
 /**
  * enum UART_TX_FLAGS -- flags for uart_port_tx_flags()

-- 
2.53.0


