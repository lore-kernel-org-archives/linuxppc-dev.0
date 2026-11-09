Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C5606A322
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 03:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lcgIsd6B
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNG6d4Tyyz2yjp;
	Mon, 09 Nov 2026 14:51:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794196281;
	cv=none; b=duxLKzzAIFanHawRgTEi/utWCyhs09bOtjeVcJDVAsBkvMijA12jzjNPW/mfUnDpIKVixpgSBHDJ48cYxhwbLW+ZJESPvA3FHJPAbFqFIGlSlvT6NC3oluuOvJiNhEzuU2PeLvvax4UnPbcqEJbwFzqVXVy3Hb8FfDqCmWKxaEv+UQKmL2T9eL1pFSSHRXKXBfNWanH8SA49yFRZreNSD54ikg27czzgWVU9cbpe1Sff9vtfpt4szDZRR1D2Cg/Tz7j7lVZxBVq0V4IIN2q10jGu92MVAJ0g5SdaeXB28lsLl977uOZdH2W+MGrb6ByaXukGCqKWimHY/opAD+EJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794196281; c=relaxed/relaxed;
	bh=/VfMcvi+BQaxJ0TjetZSNJB8swjBzVsmRBTwQ3vUJ0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PAhrrWdYVrdsDCGtq4JB/j3Kk7naFTd4uiUABx9n+HTjPXPTXzKQ/JQH25TZEW7BTYTeD1XSA6Cu0+BbeAIzHtzEVLIJmKiUF+c1h7QK99AIjb2wFAxRdkEGEb56IOX2orBQeOk0darf3ujipEyJcDdBcg+2WMAOs5n4AQCJHJ3RaxMIzbUVSXrVKbkH54z5XT1ui0obrBj0h7aKhENcUHDYZrIv0iYcYVUzEcIMF1s0DlIsCMb/8Dk+cPRhJCVhQwFI7BlkbMm36uzAuJI3a/mB/Um03FevZdmn5oC2RRQv7GdKWuCB9ycyMhkiwUaAbxsI967I3O81EbITy9jL7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lcgIsd6B; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lcgIsd6B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNG6Y3DLtz2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 14:51:16 +1100 (AEDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-7f84a55e31aso210175a34.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 19:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794196274; x=1794801074; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/VfMcvi+BQaxJ0TjetZSNJB8swjBzVsmRBTwQ3vUJ0I=;
        b=lcgIsd6BCreaVoCTC/d3vwsKPWTCIcEebg6ooOTFtb0Qo/CyapHNL2SurlTbPKwspT
         pN74iHoWDlW55BVlOdEpboEA8v//edC/6OE14s47eOAWozx37KTxrq10N56wMxbSOkPq
         RmSHwUjtWiKNj84meO3HptxnLloPeYDzY+nbkObW8RxR7dZJ6RpQbfKPx+ztEuz13Try
         ofVxLMSyOpbjHbg8FMe4ZKiFo2dhPYVgFEs23oBb1aEcWo9EWA0aXphgs+R17ksmzloU
         xMc8j72KzSEXRnpTcUNKSQpU3HY64cUusB2NEiZq53k9aKXSOFE6qGlgWWxctHpCfSFZ
         AXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794196274; x=1794801074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/VfMcvi+BQaxJ0TjetZSNJB8swjBzVsmRBTwQ3vUJ0I=;
        b=jDHruvOx1EmG2+v4TfZ302ANbYcGeP9oDAPNNTjUx0E1vM6nKfXlCtp4UHhtit4orC
         HEmIIhV9e667KrCsJatqRpZF8wJS9z64MhO2zngZIFhgAn4bJ+Fi7YNaNBlXj+PkSCez
         F9/4FBC0mqApI8c/7FDHfhHPbl2J7KH4r9jXMKeqBOqmqYqeFn0TnKBSOIFBz5D0Othg
         jOlumcOg1e6uKcS0xT22dD5zHMH2H6RJpvvE3YvT7wmNdvu3lP7U8iMBglu80j9YYkVt
         voNs5JXM//jpKYLxPhQnMEnJlxp/AH/YHAr6abAE6Kc20ywVIxhZKI1tnStjbxhADa67
         8byQ==
X-Forwarded-Encrypted: i=1; AL+hErEFJ016bCCrHLDCDCP2O6jTC6yiZSd0VWIjRPucer32VX/AK3hXDu+gRL9UXW5bb5eNTm2MHX+p0O6EO0g=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+7ZGcZmr3FnQ43wgeOD3LaHhnplDUjiGvHpBRNGbYQPkMkbbd8
	RDr7WP5rvcDPxiHICdeVNxeqd6LU2bJ5MUnkxFXRsagadLIVp0aBgaf2
X-Gm-Gg: AYBFou3Ec+6Ku8BaabY749AT0afmm6NFiPWw0/jbiyGRDvCcPLbcka+INe8xt+Yswjv
	L6Rd+ge11v6FnLDp56gwnveqG4M0aI0KtZ0N7Mow4uAg/heJFj+VlsUmbbr91dvcF1fNaER3Ptm
	Np05mkEHpt0yZF3gCii41tbct8PIaf9J3enez5jF1vs6dpGyjwAGcyIKMeYNfFvDr2FCFfw6hft
	vU7eWn5ScTJgsB9ykit+tabBsAAbMGLJhMBRIPSMUeXNhTw+a6dvHcOSBYoINz8FjvjmEdLO1Vk
	SOMlFR/EJtMQnFZvH1h2ahckLA5mD2Gsm0q39YpQ9stYa6SnnnjUz2vDNPvy837mkVoiuYpQjd+
	z3Ui2bbv4VsGSSTDVsbk6NVEPcrWcoWlGomhoZtjuY/d8dgJFSrMZ/m6iYqeKvstSpY7Iju7T/7
	48IMjuA1Npo7pJQrUj1GARL/kCVlRWv1v0u6+hBDfv3Z6WodE8O15VCdNqThI4NmXZ5FXsy24hf
	lnsC3Jtn+0VR8JYJNM14MvoHXNLBRA6ONxC0WOECplcY0uSGZUiioG7X7Ey7OgjAxNW5iieZm/+
	Qw/6lQNNDAZyuNlgnjd3+XwU8CXA/ICKallxLdMrbvp6/o5qw9L+UGk8+ry9SQSCVfNfnD1t9RW
	EHrsGn9fH8oOIyVeTbP880YZ65ZA9DDRl34dC18Ey05J7tACR7GbGaJKFRkDspq/uD9MA+wjnY3
	dIaoRCfWA8ZUdsnUXPoGBYtc+vT2SLoVU6sGOd8tvg2px11vs9WV/D
X-Received: by 2002:a05:6830:442c:b0:81f:8f5f:f1dc with SMTP id 46e09a7af769-85f5072496fmr1935588a34.8.1794196274119;
        Sun, 08 Nov 2026 19:51:14 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fad32cdsm2800428a34.6.2026.11.08.19.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:51:13 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 20:50:11 -0700
Subject: [PATCH v10 2/8] serial: serialize asynchronous write wakeups with
 the port lock
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261108-submit-serial-8250-dma-cancel-v1-v10-2-e6227ddb95b1@gmail.com>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
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

uart_write_wakeup() expects the UART port lock to be held. Several worker,
DMA completion and interrupt paths call it without that lock, including
indirect calls from uart_handle_cts_change() and the transmit helpers.

Take the port lock around these notifications or their transmit helper.
Keep sleeping SPI and regmap accesses outside the locked region, and keep
the FSL LPUART completion lock held through its wakeup. Acquire the port
lock after releasing private channel locks to preserve the ordering used
by UART callbacks. In the MUX timer, publish available FIFO space under
the port lock and keep the hardware FIFO-drain wait outside it.

Use plain port locking in hard-IRQ handlers and in helpers whose callers
already mask interrupts. Atmel status handling is also called during
resume, where lock_suspended is acquired with interrupts disabled; JSM
interrupt processing holds its IRQ-saving board lock. Keep IRQ-saving
locking in workers, tasklets and other mixed-context paths.

Take the port lock after requesting the ST ASC interrupt and hold it
through startup's transmit servicing and RX interrupt enable. The transmit
helper can notify writers even when the FIFO is empty, and serial core
calls startup without holding the port spinlock.

Use IRQ-safe locking in the Atmel RX and TX tasklets and SB1250 termios
path, since their interrupt handlers now acquire the same port lock.
Preserve the caller's interrupt state when releasing those locks.

On SB1250, lock modem-state updates after reading and filtering the change
status, and wake modem-status waiters after unlocking. Take the TX lock
inside its service routine so RX-only interrupts need no acquisition.
Keep that lock across x_char handling, FIFO consumption and the decision
to mask TX interrupts: a writer must not enqueue data and enable TX between
the empty-FIFO check and the interrupt-mask write. Each TX invocation sends
at most one character.

Serialize CLPS711x TX servicing and its interrupt-enable state with the
port lock. Disable TX interrupts without waiting in stop_tx(), since a
threaded handler may need that same lock. Have an already queued handler
leave stopped output untouched, and drain it outside the lock during
shutdown before the transmit FIFO can be released.

SCCNXP handles interrupts under a controller lock which its UART callbacks
acquire with the port lock already held. Collect the ports needing wakeups
in an unsigned long bitmap while servicing the controller, then release
that lock before visiting the set bits, taking each port lock and
rechecking the wakeup threshold. Removal drains the IRQ or timer before
unregistering the ports.

This serializes write notifications with port-locked serial-core state
changes, allowing readiness and transmit-storage reservations to gate the
notification without a check-versus-shutdown race.

Cover DZ TX servicing and JSM Classic modem notifications as well. On
DECstation ZS, acquire the port lock before the SCC lock and notify writers
after releasing the SCC lock. Defer normal TX restart after console output
to a worker, since console output can already run under the port lock.
Check transmitter readiness before consuming another character and drain
the restart worker during shutdown and removal. Release Lantiq's hardware
lock through the transmit helper's completion hook before notifying the
line discipline.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
---
 drivers/tty/serial/21285.c         |  2 +
 drivers/tty/serial/atmel_serial.c  | 12 ++---
 drivers/tty/serial/clps711x.c      | 23 +++++++---
 drivers/tty/serial/cpm_uart.c      |  2 +
 drivers/tty/serial/dz.c            |  9 ++--
 drivers/tty/serial/fsl_lpuart.c    |  2 +-
 drivers/tty/serial/jsm/jsm_cls.c   |  6 ++-
 drivers/tty/serial/jsm/jsm_neo.c   |  9 ++--
 drivers/tty/serial/lantiq.c        | 12 +++--
 drivers/tty/serial/ma35d1_serial.c |  6 ++-
 drivers/tty/serial/max3100.c       |  6 ++-
 drivers/tty/serial/max310x.c       |  9 ++--
 drivers/tty/serial/mux.c           | 13 ++++--
 drivers/tty/serial/mvebu-uart.c    |  2 +
 drivers/tty/serial/mxs-auart.c     |  2 +
 drivers/tty/serial/sb1250-duart.c  | 25 ++++++----
 drivers/tty/serial/sccnxp.c        | 43 +++++++++++++----
 drivers/tty/serial/st-asc.c        |  2 +
 drivers/tty/serial/ucc_uart.c      |  6 ++-
 drivers/tty/serial/zs.c            | 94 ++++++++++++++++++++++++++++----------
 drivers/tty/serial/zs.h            |  3 ++
 21 files changed, 201 insertions(+), 87 deletions(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 4de0c975ebdc..c12b888c1b7e 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -157,6 +157,8 @@ static irqreturn_t serial21285_tx_chars(int irq, void *dev_id)
 	struct uart_port *port = dev_id;
 	u8 ch;
 
+	guard(uart_port_lock)(port);
+
 	uart_port_tx_limited(port, ch, 256,
 		!(*CSR_UARTFLG & 0x20),
 		*CSR_UARTDR = ch,
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index c3880259e3bc..4c3a6e10d92f 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1371,6 +1371,8 @@ atmel_handle_status(struct uart_port *port, unsigned int pending,
 
 		if (status_change & (ATMEL_US_RI | ATMEL_US_DSR
 					| ATMEL_US_DCD | ATMEL_US_CTS)) {
+			guard(uart_port_lock)(port);
+
 			/* TODO: All reads to CSR will clear these interrupts! */
 			if (status_change & ATMEL_US_RI)
 				port->icount.rng++;
@@ -1702,10 +1704,9 @@ static void atmel_tasklet_rx_func(struct tasklet_struct *t)
 							  tasklet_rx);
 	struct uart_port *port = &atmel_port->uart;
 
-	/* The interrupt handler does not take the lock */
-	uart_port_lock(port);
+	guard(uart_port_lock_irqsave)(port);
+
 	atmel_port->schedule_rx(port);
-	uart_port_unlock(port);
 }
 
 static void atmel_tasklet_tx_func(struct tasklet_struct *t)
@@ -1714,10 +1715,9 @@ static void atmel_tasklet_tx_func(struct tasklet_struct *t)
 							  tasklet_tx);
 	struct uart_port *port = &atmel_port->uart;
 
-	/* The interrupt handler does not take the lock */
-	uart_port_lock(port);
+	guard(uart_port_lock_irqsave)(port);
+
 	atmel_port->schedule_tx(port);
-	uart_port_unlock(port);
 }
 
 static void atmel_init_property(struct atmel_uart_port *atmel_port,
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 83186bf50002..37b2635dda47 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -73,7 +73,8 @@ static void uart_clps711x_stop_tx(struct uart_port *port)
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
 
 	if (s->tx_enabled) {
-		disable_irq(port->irq);
+		/* The handler also takes the port lock. */
+		disable_irq_nosync(port->irq);
 		s->tx_enabled = 0;
 	}
 }
@@ -146,9 +147,16 @@ static irqreturn_t uart_clps711x_int_tx(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
-	struct tty_port *tport = &port->state->port;
+	struct tty_port *tport;
 	unsigned char c;
 
+	guard(uart_port_lock)(port);
+
+	if (!s->tx_enabled)
+		return IRQ_HANDLED;
+
+	tport = &port->state->port;
+
 	if (port->x_char) {
 		writew(port->x_char, port->membase + UARTDR_OFFSET);
 		port->icount.tx++;
@@ -157,10 +165,7 @@ static irqreturn_t uart_clps711x_int_tx(int irq, void *dev_id)
 	}
 
 	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
-		if (s->tx_enabled) {
-			disable_irq_nosync(port->irq);
-			s->tx_enabled = 0;
-		}
+		uart_clps711x_stop_tx(port);
 		return IRQ_HANDLED;
 	}
 
@@ -245,8 +250,14 @@ static void uart_clps711x_shutdown(struct uart_port *port)
 {
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
 
+	scoped_guard(uart_port_lock_irqsave, port)
+		uart_clps711x_stop_tx(port);
+
 	/* Disable the port */
 	regmap_update_bits(s->syscon, SYSCON_OFFSET, SYSCON_UARTEN, 0);
+
+	/* Drain the non-waiting TX disable before releasing the FIFO. */
+	synchronize_irq(port->irq);
 }
 
 static void uart_clps711x_set_termios(struct uart_port *port,
diff --git a/drivers/tty/serial/cpm_uart.c b/drivers/tty/serial/cpm_uart.c
index 39f54bb7b485..3f1e51b04f9f 100644
--- a/drivers/tty/serial/cpm_uart.c
+++ b/drivers/tty/serial/cpm_uart.c
@@ -214,6 +214,8 @@ static void cpm_uart_int_tx(struct uart_port *port)
 {
 	pr_debug("CPM uart[%d]:TX INT\n", port->line);
 
+	guard(uart_port_lock)(port);
+
 	cpm_uart_tx_pump(port);
 }
 
diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 39d93e9c2d15..c86453937a0f 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -254,6 +254,8 @@ static inline void dz_transmit_chars(struct dz_mux *mux)
 
 	status = dz_in(dport, DZ_CSR);
 	dport = &mux->dport[LINE(status)];
+	guard(uart_port_lock)(&dport->port);
+
 	tport = &dport->port.state->port;
 
 	if (dport->port.x_char) {		/* XON/XOFF chars */
@@ -265,9 +267,7 @@ static inline void dz_transmit_chars(struct dz_mux *mux)
 	/* If nothing to do or stopped or hardware stopped. */
 	if (uart_tx_stopped(&dport->port) ||
 			!uart_fifo_get(&dport->port, &tmp)) {
-		uart_port_lock(&dport->port);
 		dz_stop_tx(&dport->port);
-		uart_port_unlock(&dport->port);
 		return;
 	}
 
@@ -281,11 +281,8 @@ static inline void dz_transmit_chars(struct dz_mux *mux)
 		uart_write_wakeup(&dport->port);
 
 	/* Are we are done. */
-	if (kfifo_is_empty(&tport->xmit_fifo)) {
-		uart_port_lock(&dport->port);
+	if (kfifo_is_empty(&tport->xmit_fifo))
 		dz_stop_tx(&dport->port);
-		uart_port_unlock(&dport->port);
-	}
 }
 
 /*
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c8575c965203..cb04571c3d0e 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -540,10 +540,10 @@ static void lpuart_dma_tx_complete(void *arg)
 
 	uart_xmit_advance(&sport->port, sport->dma_tx_bytes);
 	sport->dma_tx_in_progress = false;
-	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(&sport->port);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	if (waitqueue_active(&sport->dma_wait)) {
 		wake_up(&sport->dma_wait);
diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
index 6e40792f92cf..e8e90181504b 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -571,7 +571,8 @@ static inline void cls_parse_isr(struct jsm_board *brd, uint port)
 			spin_lock_irqsave(&ch->ch_lock, flags);
 			ch->ch_flags |= (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
 			spin_unlock_irqrestore(&ch->ch_lock, flags);
-			cls_copy_data_from_queue_to_uart(ch);
+			scoped_guard(uart_port_lock, &ch->uart_port)
+				cls_copy_data_from_queue_to_uart(ch);
 		}
 
 		/*
@@ -581,7 +582,8 @@ static inline void cls_parse_isr(struct jsm_board *brd, uint port)
 		 */
 
 		/* Parse any modem signal changes */
-		cls_parse_modem(ch, readb(&ch->ch_cls_uart->msr));
+		scoped_guard(uart_port_lock, &ch->uart_port)
+			cls_parse_modem(ch, readb(&ch->ch_cls_uart->msr));
 	}
 }
 
diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index e8e13bf056e2..d27aa2166364 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -740,7 +740,8 @@ static void neo_parse_isr(struct jsm_board *brd, u32 port)
 			spin_lock_irqsave(&ch->ch_lock, lock_flags);
 			ch->ch_flags |= (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
 			spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
-			neo_copy_data_from_queue_to_uart(ch);
+			scoped_guard(uart_port_lock, &ch->uart_port)
+				neo_copy_data_from_queue_to_uart(ch);
 		}
 
 		if (isr & UART_17158_IIR_XONXOFF) {
@@ -895,7 +896,8 @@ static inline void neo_parse_lsr(struct jsm_board *brd, u32 port)
 		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
 
 		/* Transfer data (if any) from Write Queue -> UART. */
-		neo_copy_data_from_queue_to_uart(ch);
+		scoped_guard(uart_port_lock, &ch->uart_port)
+			neo_copy_data_from_queue_to_uart(ch);
 	}
 	else if (linestatus & UART_17158_TX_AND_FIFO_CLR) {
 		spin_lock_irqsave(&ch->ch_lock, lock_flags);
@@ -903,7 +905,8 @@ static inline void neo_parse_lsr(struct jsm_board *brd, u32 port)
 		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
 
 		/* Transfer data (if any) from Write Queue -> UART. */
-		neo_copy_data_from_queue_to_uart(ch);
+		scoped_guard(uart_port_lock, &ch->uart_port)
+			neo_copy_data_from_queue_to_uart(ch);
 	}
 }
 
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 62cd9e0bb377..e0b2c7335692 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -153,11 +153,12 @@ lqasc_start_tx(struct uart_port *port)
 	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
 	u8 ch;
 
+	/* Drop the hardware lock before the helper notifies the line discipline. */
 	spin_lock_irqsave(&ltq_port->lock, flags);
-	uart_port_tx(port, ch,
-		lqasc_tx_ready(port),
-		writeb(ch, port->membase + LTQ_ASC_TBUF));
-	spin_unlock_irqrestore(&ltq_port->lock, flags);
+	uart_port_tx_limited(port, ch, port->fifosize,
+			     lqasc_tx_ready(port),
+			     writeb(ch, port->membase + LTQ_ASC_TBUF),
+			     spin_unlock_irqrestore(&ltq_port->lock, flags));
 	return;
 }
 
@@ -239,7 +240,8 @@ lqasc_tx_int(int irq, void *_port)
 	spin_lock_irqsave(&ltq_port->lock, flags);
 	__raw_writel(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
 	spin_unlock_irqrestore(&ltq_port->lock, flags);
-	lqasc_start_tx(port);
+	scoped_guard(uart_port_lock, port)
+		lqasc_start_tx(port);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 3be30fb05513..a59a8496a83b 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -295,8 +295,10 @@ static irqreturn_t ma35d1serial_interrupt(int irq, void *dev_id)
 
 	if (isr & (MA35_ISR_RDA_IF | MA35_ISR_RXTO_IF))
 		receive_chars(up);
-	if (isr & MA35_ISR_THRE_INT)
-		transmit_chars(up);
+	if (isr & MA35_ISR_THRE_INT) {
+		scoped_guard(uart_port_lock, port)
+			transmit_chars(up);
+	}
 	if (fsr & MA35_FSR_TX_OVER_IF)
 		serial_out(up, MA35_FSR_REG, MA35_FSR_TX_OVER_IF);
 
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index f858a6669011..5a8817eb82ad 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -287,8 +287,10 @@ static void max3100_work(struct work_struct *w)
 			tty_flip_buffer_push(&s->port.state->port);
 			rxchars = 0;
 		}
-		if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
-			uart_write_wakeup(&s->port);
+		scoped_guard(uart_port_lock_irqsave, &s->port) {
+			if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
+				uart_write_wakeup(&s->port);
+		}
 
 	} while (!s->force_end_work &&
 		 !freezing(current) &&
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index a0ed70185555..d9ce6ba53c7f 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -950,8 +950,10 @@ static void max310x_handle_tx(struct uart_port *port)
 		uart_xmit_advance(port, to_send);
 	}
 
-	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	scoped_guard(uart_port_lock_irqsave, port) {
+		if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
+			uart_write_wakeup(port);
+	}
 }
 
 /*
@@ -1043,7 +1045,8 @@ static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
 
 		if (ists & MAX310X_IRQ_CTS_BIT) {
 			lsr = max310x_port_read(port, MAX310X_LSR_IRQSTS_REG);
-			uart_handle_cts_change(port, lsr & MAX310X_LSR_CTS_BIT);
+			scoped_guard(uart_port_lock_irqsave, port)
+				uart_handle_cts_change(port, lsr & MAX310X_LSR_CTS_BIT);
 		}
 		if (rxlen)
 			max310x_handle_rx(port, rxlen);
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 3a77a7e5c7bc..8be5b3031749 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -189,11 +189,14 @@ static void mux_write(struct uart_port *port)
 {
 	u8 ch;
 
-	uart_port_tx_limited(port, ch,
-		port->fifosize - UART_GET_FIFO_CNT(port),
-		true,
-		UART_PUT_CHAR(port, ch),
-		mux_tx_done(port));
+	scoped_guard(uart_port_lock_irqsave, port) {
+		uart_port_tx_limited(port, ch,
+			port->fifosize - UART_GET_FIFO_CNT(port),
+			true,
+			UART_PUT_CHAR(port, ch),
+			({}));
+	}
+	mux_tx_done(port);
 }
 
 /**
diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 33ea496c93b2..35b55138637b 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -334,6 +334,8 @@ static void mvebu_uart_tx_chars(struct uart_port *port, unsigned int status)
 {
 	u8 ch;
 
+	guard(uart_port_lock)(port);
+
 	uart_port_tx_limited(port, ch, port->fifosize,
 		!(readl(port->membase + UART_STAT) & STAT_TX_FIFO_FUL),
 		writel(ch, port->membase + UART_TSH(port)),
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 697318dbb146..6a310309b55d 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -521,6 +521,8 @@ static void dma_tx_callback(void *param)
 
 	dma_unmap_sg(s->dev, &s->tx_sgl, 1, DMA_TO_DEVICE);
 
+	guard(uart_port_lock_irqsave)(&s->port);
+
 	/* clear the bit used to serialize the DMA tx. */
 	clear_bit(MXS_AUART_DMA_TX_SYNC, &s->flags);
 	smp_mb__after_atomic();
diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index b4e1b90e5960..af6a0fe1df70 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -387,6 +387,9 @@ static void sbd_transmit_chars(struct sbd_port *sport)
 	unsigned int mask;
 	int stop_tx;
 
+	/* Serialize FIFO consumption and interrupt masking with start_tx(). */
+	guard(uart_port_lock)(uport);
+
 	/* XON/XOFF chars.  */
 	if (sport->port.x_char) {
 		write_sbdchn(sport, R_DUART_TX_HOLD, sport->port.x_char);
@@ -424,15 +427,19 @@ static void sbd_status_handle(struct sbd_port *sport)
 	delta = read_sbdshr(sport, R_DUART_INCHREG((uport->line) % 2));
 	delta >>= (uport->line) % 2;
 
-	if (delta & (M_DUART_IN_PIN0_VAL << S_DUART_IN_PIN_CHNG))
-		uart_handle_cts_change(uport, !(delta & M_DUART_IN_PIN0_VAL));
+	if (!(delta & ((M_DUART_IN_PIN2_VAL | M_DUART_IN_PIN0_VAL) <<
+		       S_DUART_IN_PIN_CHNG)))
+		return;
 
-	if (delta & (M_DUART_IN_PIN2_VAL << S_DUART_IN_PIN_CHNG))
-		uport->icount.dsr++;
+	scoped_guard(uart_port_lock, uport) {
+		if (delta & (M_DUART_IN_PIN0_VAL << S_DUART_IN_PIN_CHNG))
+			uart_handle_cts_change(uport, !(delta & M_DUART_IN_PIN0_VAL));
 
-	if (delta & ((M_DUART_IN_PIN2_VAL | M_DUART_IN_PIN0_VAL) <<
-		     S_DUART_IN_PIN_CHNG))
-		wake_up_interruptible(&uport->state->port.delta_msr_wait);
+		if (delta & (M_DUART_IN_PIN2_VAL << S_DUART_IN_PIN_CHNG))
+			uport->icount.dsr++;
+	}
+
+	wake_up_interruptible(&uport->state->port.delta_msr_wait);
 }
 
 static irqreturn_t sbd_interrupt(int irq, void *dev_id)
@@ -611,7 +618,7 @@ static void sbd_set_termios(struct uart_port *uport, struct ktermios *termios,
 	else
 		aux &= ~M_DUART_CTS_CHNG_ENA;
 
-	uart_port_lock(uport);
+	guard(uart_port_lock_irqsave)(uport);
 
 	if (sport->tx_stopped)
 		command |= M_DUART_TX_DIS;
@@ -632,8 +639,6 @@ static void sbd_set_termios(struct uart_port *uport, struct ktermios *termios,
 	write_sbdchn(sport, R_DUART_AUXCTL_X, aux | oldaux);
 
 	write_sbdchn(sport, R_DUART_CMD, command);
-
-	uart_port_unlock(uport);
 }
 
 
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index cb31e3aceb62..7f79175ef618 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -7,6 +7,7 @@
  *  Based on sc26xx.c, by Thomas Bogendörfer (tsbogend@alpha.franken.de)
  */
 
+#include <linux/bitmap.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -435,7 +436,7 @@ static void sccnxp_handle_rx(struct uart_port *port)
 	tty_flip_buffer_push(&port->state->port);
 }
 
-static void sccnxp_handle_tx(struct uart_port *port)
+static bool sccnxp_handle_tx(struct uart_port *port)
 {
 	u8 sr;
 	struct tty_port *tport = &port->state->port;
@@ -445,7 +446,7 @@ static void sccnxp_handle_tx(struct uart_port *port)
 		sccnxp_port_write(port, SCCNXP_THR_REG, port->x_char);
 		port->icount.tx++;
 		port->x_char = 0;
-		return;
+		return false;
 	}
 
 	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
@@ -457,7 +458,7 @@ static void sccnxp_handle_tx(struct uart_port *port)
 			if (s->chip->flags & SCCNXP_HAVE_IO)
 				sccnxp_set_bit(port, DIR_OP, 0);
 		}
-		return;
+		return false;
 	}
 
 	while (1) {
@@ -473,12 +474,12 @@ static void sccnxp_handle_tx(struct uart_port *port)
 		sccnxp_port_write(port, SCCNXP_THR_REG, ch);
 	}
 
-	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	return kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS;
 }
 
-static void sccnxp_handle_events(struct sccnxp_port *s)
+static unsigned long sccnxp_handle_events(struct sccnxp_port *s)
 {
+	unsigned long wakeup = 0;
 	int i;
 	u8 isr;
 
@@ -491,20 +492,40 @@ static void sccnxp_handle_events(struct sccnxp_port *s)
 		for (i = 0; i < s->uart.nr; i++) {
 			if (s->opened[i] && (isr & ISR_RXRDY(i)))
 				sccnxp_handle_rx(&s->port[i]);
-			if (s->opened[i] && (isr & ISR_TXRDY(i)))
-				sccnxp_handle_tx(&s->port[i]);
+			if (s->opened[i] && (isr & ISR_TXRDY(i)) &&
+			    sccnxp_handle_tx(&s->port[i]))
+				wakeup |= BIT(i);
 		}
 	} while (1);
+
+	return wakeup;
+}
+
+static void sccnxp_write_wakeup(struct sccnxp_port *s, unsigned long wakeup)
+{
+	unsigned int i;
+
+	/* UART callbacks take s->lock with the port lock already held. */
+	for_each_set_bit(i, &wakeup, s->uart.nr) {
+		struct uart_port *port = &s->port[i];
+
+		scoped_guard(uart_port_lock_irqsave, port) {
+			if (kfifo_len(&port->state->port.xmit_fifo) < WAKEUP_CHARS)
+				uart_write_wakeup(port);
+		}
+	}
 }
 
 static void sccnxp_timer(struct timer_list *t)
 {
 	struct sccnxp_port *s = timer_container_of(s, t, timer);
 	unsigned long flags;
+	unsigned long wakeup;
 
 	spin_lock_irqsave(&s->lock, flags);
-	sccnxp_handle_events(s);
+	wakeup = sccnxp_handle_events(s);
 	spin_unlock_irqrestore(&s->lock, flags);
+	sccnxp_write_wakeup(s, wakeup);
 
 	mod_timer(&s->timer, jiffies + usecs_to_jiffies(s->pdata.poll_time_us));
 }
@@ -513,10 +534,12 @@ static irqreturn_t sccnxp_ist(int irq, void *dev_id)
 {
 	struct sccnxp_port *s = (struct sccnxp_port *)dev_id;
 	unsigned long flags;
+	unsigned long wakeup;
 
 	spin_lock_irqsave(&s->lock, flags);
-	sccnxp_handle_events(s);
+	wakeup = sccnxp_handle_events(s);
 	spin_unlock_irqrestore(&s->lock, flags);
+	sccnxp_write_wakeup(s, wakeup);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 6ed9a327702b..5fefa3325a1f 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -422,6 +422,8 @@ static int asc_startup(struct uart_port *port)
 		return -ENODEV;
 	}
 
+	guard(uart_port_lock_irqsave)(port);
+
 	asc_transmit_chars(port);
 	asc_enable_rx_interrupts(port);
 
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 6b7dcbbacd13..4c4e8e4621ec 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -570,8 +570,10 @@ static irqreturn_t qe_uart_int(int irq, void *data)
 	if (events & UCC_UART_UCCE_RX)
 		qe_uart_int_rx(qe_port);
 
-	if (events & UCC_UART_UCCE_TX)
-		qe_uart_tx_pump(qe_port);
+	if (events & UCC_UART_UCCE_TX) {
+		scoped_guard(uart_port_lock, &qe_port->port)
+			qe_uart_tx_pump(qe_port);
+	}
 
 	return events ? IRQ_HANDLED : IRQ_NONE;
 }
diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index 8f92b4129a38..6126dee0301d 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -431,20 +431,23 @@ static void zs_stop_tx(struct uart_port *uport)
 	spin_unlock(&scc->zlock);
 }
 
-static void zs_raw_transmit_chars(struct zs_port *);
+static bool zs_raw_transmit_chars(struct zs_port *);
 
 static void zs_start_tx(struct uart_port *uport)
 {
 	struct zs_port *zport = to_zport(uport);
 	struct zs_scc *scc = zport->scc;
+	bool wakeup = false;
 
 	spin_lock(&scc->zlock);
 	if (zport->tx_stopped) {
 		zs_transmit_drain(zport, 0);
 		zport->tx_stopped = 0;
-		zs_raw_transmit_chars(zport);
+		wakeup = zs_raw_transmit_chars(zport);
 	}
 	spin_unlock(&scc->zlock);
+	if (wakeup)
+		uart_write_wakeup(uport);
 }
 
 static void zs_stop_rx(struct uart_port *uport)
@@ -603,51 +606,81 @@ static void zs_receive_chars(struct zs_port *zport)
 	tty_flip_buffer_push(&uport->state->port);
 }
 
-static void zs_raw_transmit_chars(struct zs_port *zport)
+static bool zs_raw_transmit_chars(struct zs_port *zport)
 {
 	struct tty_port *tport = &zport->port.state->port;
 	unsigned char ch;
+	bool wakeup;
+
+	/* A deferred console restart can race a pending TX interrupt. */
+	if (!(read_zsreg(zport, R0) & Tx_BUF_EMP))
+		return false;
 
 	/* XON/XOFF chars.  */
 	if (zport->port.x_char) {
 		write_zsdata(zport, zport->port.x_char);
 		zport->port.icount.tx++;
 		zport->port.x_char = 0;
-		return;
+		return false;
 	}
 
 	/* If nothing to do or stopped or hardware stopped.  */
 	if (uart_tx_stopped(&zport->port) ||
 			!uart_fifo_get(&zport->port, &ch)) {
 		zs_raw_stop_tx(zport);
-		return;
+		return false;
 	}
 
 	/* Send char.  */
 	write_zsdata(zport, ch);
 
-	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
-		uart_write_wakeup(&zport->port);
+	wakeup = kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS;
 
 	/* Are we are done?  */
 	if (kfifo_is_empty(&tport->xmit_fifo))
 		zs_raw_stop_tx(zport);
+
+	return wakeup;
 }
 
 static void zs_transmit_chars(struct zs_port *zport)
 {
 	struct zs_scc *scc = zport->scc;
+	bool wakeup;
+
+	guard(uart_port_lock)(&zport->port);
 
 	spin_lock(&scc->zlock);
-	zs_raw_transmit_chars(zport);
+	wakeup = zs_raw_transmit_chars(zport);
 	spin_unlock(&scc->zlock);
+	if (wakeup)
+		uart_write_wakeup(&zport->port);
+}
+
+static void zs_tx_work(struct work_struct *work)
+{
+	struct zs_port *zport = container_of(work, struct zs_port, tx_work);
+	struct uart_port *uport = &zport->port;
+	bool wakeup = false;
+
+	guard(uart_port_lock_irqsave)(uport);
+
+	if (!uport->state || !uport->state->port.xmit_buf)
+		return;
+
+	scoped_guard(spinlock, &zport->scc->zlock) {
+		if (!zport->tx_stopped)
+			wakeup = zs_raw_transmit_chars(zport);
+	}
+	if (wakeup)
+		uart_write_wakeup(uport);
 }
 
 static void zs_status_handle(struct zs_port *zport, struct zs_port *zport_a)
 {
 	struct uart_port *uport = &zport->port;
 	struct zs_scc *scc = zport->scc;
-	unsigned int delta;
+	unsigned int delta, mctrl;
 	u8 status, brk;
 
 	spin_lock(&scc->zlock);
@@ -670,18 +703,19 @@ static void zs_status_handle(struct zs_port *zport, struct zs_port *zport_a)
 
 	if (zport != zport_a) {
 		delta = zs_raw_xor_mctrl(zport);
+		mctrl = zport->mctrl;
 		spin_unlock(&scc->zlock);
 
-		if (delta & TIOCM_CTS)
-			uart_handle_cts_change(uport,
-					       zport->mctrl & TIOCM_CTS);
-		if (delta & TIOCM_CAR)
-			uart_handle_dcd_change(uport,
-					       zport->mctrl & TIOCM_CAR);
-		if (delta & TIOCM_RNG)
-			uport->icount.rng++;
-		if (delta & TIOCM_DSR)
-			uport->icount.dsr++;
+		scoped_guard(uart_port_lock, uport) {
+			if (delta & TIOCM_CTS)
+				uart_handle_cts_change(uport, mctrl & TIOCM_CTS);
+			if (delta & TIOCM_CAR)
+				uart_handle_dcd_change(uport, mctrl & TIOCM_CAR);
+			if (delta & TIOCM_RNG)
+				uport->icount.rng++;
+			if (delta & TIOCM_DSR)
+				uport->icount.dsr++;
+		}
 
 		if (delta)
 			wake_up_interruptible(&uport->state->port.delta_msr_wait);
@@ -809,13 +843,19 @@ static void zs_shutdown(struct uart_port *uport)
 	unsigned long flags;
 	int irq_guard;
 
-	spin_lock_irqsave(&scc->zlock, flags);
+	uart_port_lock_irqsave(uport, &flags);
+	spin_lock(&scc->zlock);
+	zs_raw_stop_tx(zport);
+	zport->regs[1] &= ~TxINT_ENAB;
+	write_zsreg(zport, R1, zport->regs[1]);
 
 	zport->regs[3] &= ~RxENABLE;
 	write_zsreg(zport, R5, zport->regs[5]);
 	write_zsreg(zport, R3, zport->regs[3]);
 
-	spin_unlock_irqrestore(&scc->zlock, flags);
+	spin_unlock(&scc->zlock);
+	uart_port_unlock_irqrestore(uport, flags);
+	cancel_work_sync(&zport->tx_work);
 
 	irq_guard = atomic_add_return(-1, &scc->irq_guard);
 	if (!irq_guard)
@@ -1066,6 +1106,7 @@ static int __init zs_probe(struct platform_device *pdev)
 
 		zport->scc	= &zs_sccs[chip];
 		zport->clk_mode	= 16;
+		INIT_WORK(&zport->tx_work, zs_tx_work);
 
 		uport->dev	= &pdev->dev;
 		uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_ZS_CONSOLE);
@@ -1098,8 +1139,10 @@ static void __exit zs_remove(struct platform_device *pdev)
 		struct zs_port *zport = &zs_sccs[chip].zport[side];
 		struct uart_port *uport = &zport->port;
 
-		if (uport->dev)
+		if (uport->dev) {
 			uart_remove_one_port(&zs_reg, uport);
+			cancel_work_sync(&zport->tx_work);
+		}
 	}
 }
 
@@ -1161,9 +1204,12 @@ static void zs_console_write(struct console *co, const char *s,
 		zport->regs[1] |= TxINT_ENAB;
 		write_zsreg(zport, R1, zport->regs[1]);
 
-		/* Resume any transmission as the TxIP bit won't be set.  */
+		/*
+		 * TxIP won't be set. Defer the restart: console output may be
+		 * called with the port lock held, and TX must acquire it first.
+		 */
 		if (!zport->tx_stopped)
-			zs_raw_transmit_chars(zport);
+			schedule_work(&zport->tx_work);
 	}
 	spin_unlock_irqrestore(&scc->zlock, flags);
 }
diff --git a/drivers/tty/serial/zs.h b/drivers/tty/serial/zs.h
index e0d3c189b33f..0404294e4533 100644
--- a/drivers/tty/serial/zs.h
+++ b/drivers/tty/serial/zs.h
@@ -14,6 +14,8 @@
 
 #ifdef __KERNEL__
 
+#include <linux/workqueue.h>
+
 #define ZS_NUM_REGS 16
 
 /*
@@ -22,6 +24,7 @@
 struct zs_port {
 	struct zs_scc	*scc;			/* Containing SCC.  */
 	struct uart_port port;			/* Underlying UART.  */
+	struct work_struct tx_work;		/* Restart after console output. */
 
 	int		clk_mode;		/* May be 1, 16, 32, or 64.  */
 

-- 
2.53.0


