Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA32606A324
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2026 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q8tMUNy/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBsXQ1R7sz2yFk;
	Sun, 25 Oct 2026 07:52:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792875158;
	cv=none; b=BlvO256WRmkh9Nd7HZokcXHX9+CJBtJOqaDHawklswMEHcwbHFpkSf3IMGbmk8A1ckwt6BswZRGCN/fhZyJ55ePtydskghHtw7pCjkwzbOlIGzhv7x4qP42114MRWCgBU0Q+ANuzcHj8qwE9QCJfWfntDzbwZvbyDzEM4c2TyK3tmUR06iLd78YZE2mHGf8pMXycDGcrkl4oHV35dX9Ob5Bb2h5Rx/7JmiofbThEjG1XiLKffPv8rQJQzEfcyy4XQsF4tB6dkgo6aIPW85VV4nCXs+ArvonXgXlZgtxu/9RA+1t8BUAf7lWTYZDlKZZSktU7Eh3MEWLKUFkGDFyMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792875158; c=relaxed/relaxed;
	bh=rBmFQ39D346ZrXUVmjDqiYno67dxEXea+JnyUDrt/bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=knDOVsIWpoly/zSpSKNPcQvstAu9W9XlqEZzgPNHZSp/a60THfZdclrSMrT8wE21HKwQX+6Hw3Af0SHqTHSQAYdNjqqv2l895mA8DjvFIO9KvJjatNYvq4CUUNU05vn1pCRQ2jWYRwl/YUXzw2w5SdxxvQYyz0SSTZNOyomGMRPCrcxh4y+/K4XrT8oTFsGAC2Uf8JLqKT6dQxpYlVB/iQ6SIgKAXqWFxbzCW8Y/YuXmuPAhhaaeHGtVYSnPgOGi0P1iWaOqVBrXKXf7cX7fnVAwoGEMonHZ/2OtnPJlCGq51tIEGb2pBMZHbqWbicxV7T1d80OOpc3pUjpeqzu+lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q8tMUNy/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q8tMUNy/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jBsXP03g5z2yZf
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Oct 2026 07:52:36 +1100 (AEDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-7fccba9c675so3504410a34.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 13:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792875154; x=1793479954; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rBmFQ39D346ZrXUVmjDqiYno67dxEXea+JnyUDrt/bs=;
        b=q8tMUNy/MPWR93bf1a6h+yr7tSJffadMj7YxTOWhJvkoU9NzA9ubKyvMaUxnuUgfx1
         4Cx0mv0++5iA5r/2qBKf7Lr3rAKZHq47kqlML/pmg4QlBGT2SUCleYFY1+u/BAe3MQvs
         8a7Ed5lMU0w70/1M9PbzOuL4k9LgsZ/SzCMmCAIZwnU1AO8A+Azp5wnqm3XhlD3lilxx
         r/tV6Ru1ouEwn83bNW69PMJW3iOk0oICY7B44S7DD/wQYrU6yeSwl9YpBKdclCZINOfN
         oFcImwKvlfNCPf790m2+w+7g0ttugXYgBJaDdBIL3c80MgD6K45DI6qi/0wDIv6NjgiJ
         xMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792875154; x=1793479954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rBmFQ39D346ZrXUVmjDqiYno67dxEXea+JnyUDrt/bs=;
        b=T+vMGrinqborfWI6SPZXbVdJwqJHttYzIgsBiesIpmypFpsVhmWz7Es7S6mb+0+g9p
         mEYRAqjvY6+IgLk0C6MTDDQ/Qm/4Z0SSCTd6mpbzRu7yIPHb109xZU3mnekseaRnVcH6
         nhW9+Kn6CrlgsEA2mRPcxnYXJ6o7UlruJy935++MqcVC5NUHAvafjMJOngSavewRfKnU
         tX9ecCco/YBuFnhsp2Z5hcZ7efhWsjYK+rc8ympMUypwVMNppkhBn9a/C6MDjOPb+Lul
         9+aO/6qdCnZ69p/Hp0BhXhNdCRM0Y+wWTPHUki4fgArZxZLNVTs5gS7Pdbrej/XhXLs2
         /RCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWY10DIX8icp/K7O2RBhN8fpnzKd5aO6iWJ+AGmuZr6ATxfaLxH2kwIjKzkOpZOzlQelLB5CkScAYlLLc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK+2ZBHZL9keWJgnYNONQeRiYcH4o5+lrjD7B3uPQSdEUpNAyDc
	E5vnlm+yK0+VSWzuIlOafCDo0MKQ4aWTbwQRZ0VSUZBrV1rhzuInBBqF
X-Gm-Gg: AYBFou3awPp6sYNINb2qkNNVuWl8wwpSAI5+qVrlG+yy3J/z+2x0PeMr8W5ldB8DxCY
	E7YYAsLusjdSMesSJFBWB9Fd1of3xrzqm0rlaaufXtjyINv4smYsIa7wTi0D1bcl1nY0uNLERKw
	/2bf7sR+GGJEz9Y1+UFyiNl/nqf3kqqI7ZY5dTNKcg3wBjxvbTXFN4hfdutomDA2GVJ5+TJU18j
	xeTHfulMpmaJY3Gp/3+tTOqyYe52PZUW+6AYzeBi+ZhtXq0pHEm3ZjCMatw7NJ84Kd+c9VDdhoW
	xA1HH0InBP90KpLSQSAMd0OZgn1XAYmSmiPbUHYa/4PTR4fjSsvTyPPiX5tjNZZWSzPZIsvAHD9
	ZYOjfTwtDioJAsohuTOx7Qi9dis2w0CRw3wM4gjs17JpLgzdc3WblP8wsFOiGo/VXZwpcUfu7xf
	eInIuf53BuOX1Z+BL4pPp2v6803DVJRAIJRZMn+dRurpHccRMBIF4XzvOlqifEk0erukDiHZuLS
	4/+znVoFNdkaC7rSJv7ncKAgo8idODcsIaMpXlHe0niytFczQ2NH+b/n1giBdi1nJ72zVfYN+RJ
	P9XBADAvwlGn4Kwn471lDZFV98yBqP+OfqhNpe23nvwnw42nSuB9w/weqYttffpWHxGocX56YlD
	G94FHQNg0HCzALZpoo3WZgKZpYEVQvUTGUkklc2dnRkud7wNfJABsg9h/xeUYclXLv27g4jM1hG
	Iytg==
X-Received: by 2002:a05:6808:66d8:b0:4a4:c95a:38d1 with SMTP id 5614622812f47-55c006d23a4mr1050105b6e.4.1792875154472;
        Sat, 24 Oct 2026 13:52:34 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0429c932sm1986785b6e.7.2026.10.24.13.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:52:34 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 14:52:27 -0600
Subject: [PATCH v6 2/5] serial: serialize asynchronous write wakeups with
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-serial-8250-dma-cancel-v1-v6-2-6f366591f566@gmail.com>
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

Use IRQ-safe locking in the Atmel RX and TX tasklets and SB1250 termios
path, since their interrupt handlers now acquire the same port lock.
Preserve the caller's interrupt state when releasing those locks.

Serialize CLPS711x TX servicing and its interrupt-enable state with the
port lock. Disable TX interrupts without waiting in stop_tx(), since a
threaded handler may need that same lock. Have an already queued handler
leave stopped output untouched, and drain it outside the lock during
shutdown before the transmit FIFO can be released.

SCCNXP handles interrupts under a controller lock which its UART callbacks
acquire with the port lock already held. Collect the ports needing wakeups
while servicing the controller, then release that lock before taking each
port lock and rechecking the wakeup threshold. Removal drains the IRQ or
timer before unregistering the ports.

This serializes write notifications with port-locked serial-core state
changes, allowing readiness and transmit-storage reservations to gate the
notification without a check-versus-shutdown race.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/21285.c         |  2 ++
 drivers/tty/serial/atmel_serial.c  | 12 +++++-----
 drivers/tty/serial/clps711x.c      | 23 ++++++++++++++-----
 drivers/tty/serial/cpm_uart.c      |  2 ++
 drivers/tty/serial/fsl_lpuart.c    |  2 +-
 drivers/tty/serial/jsm/jsm_cls.c   |  3 ++-
 drivers/tty/serial/jsm/jsm_neo.c   |  9 +++++---
 drivers/tty/serial/lantiq.c        |  3 ++-
 drivers/tty/serial/ma35d1_serial.c |  6 +++--
 drivers/tty/serial/max3100.c       |  6 +++--
 drivers/tty/serial/max310x.c       |  9 +++++---
 drivers/tty/serial/mux.c           | 13 ++++++-----
 drivers/tty/serial/mvebu-uart.c    |  2 ++
 drivers/tty/serial/mxs-auart.c     |  2 ++
 drivers/tty/serial/sb1250-duart.c  | 14 ++++++------
 drivers/tty/serial/sccnxp.c        | 45 +++++++++++++++++++++++++++++---------
 drivers/tty/serial/ucc_uart.c      |  6 +++--
 17 files changed, 110 insertions(+), 49 deletions(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 4de0c975ebdc..e4149aea4f66 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -157,6 +157,8 @@ static irqreturn_t serial21285_tx_chars(int irq, void *dev_id)
 	struct uart_port *port = dev_id;
 	u8 ch;
 
+	guard(uart_port_lock_irqsave)(port);
+
 	uart_port_tx_limited(port, ch, 256,
 		!(*CSR_UARTFLG & 0x20),
 		*CSR_UARTDR = ch,
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index c3880259e3bc..0433bc70f279 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1371,6 +1371,8 @@ atmel_handle_status(struct uart_port *port, unsigned int pending,
 
 		if (status_change & (ATMEL_US_RI | ATMEL_US_DSR
 					| ATMEL_US_DCD | ATMEL_US_CTS)) {
+			guard(uart_port_lock_irqsave)(port);
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
index 83186bf50002..06ed8ba7c9fb 100644
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
 
+	guard(uart_port_lock_irqsave)(port);
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
index 39f54bb7b485..028a01fa02a9 100644
--- a/drivers/tty/serial/cpm_uart.c
+++ b/drivers/tty/serial/cpm_uart.c
@@ -214,6 +214,8 @@ static void cpm_uart_int_tx(struct uart_port *port)
 {
 	pr_debug("CPM uart[%d]:TX INT\n", port->line);
 
+	guard(uart_port_lock_irqsave)(port);
+
 	cpm_uart_tx_pump(port);
 }
 
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
index 6e40792f92cf..7720796331c9 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -571,7 +571,8 @@ static inline void cls_parse_isr(struct jsm_board *brd, uint port)
 			spin_lock_irqsave(&ch->ch_lock, flags);
 			ch->ch_flags |= (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
 			spin_unlock_irqrestore(&ch->ch_lock, flags);
-			cls_copy_data_from_queue_to_uart(ch);
+			scoped_guard(uart_port_lock_irqsave, &ch->uart_port)
+				cls_copy_data_from_queue_to_uart(ch);
 		}
 
 		/*
diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index e8e13bf056e2..cbd9af43c68b 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -740,7 +740,8 @@ static void neo_parse_isr(struct jsm_board *brd, u32 port)
 			spin_lock_irqsave(&ch->ch_lock, lock_flags);
 			ch->ch_flags |= (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
 			spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
-			neo_copy_data_from_queue_to_uart(ch);
+			scoped_guard(uart_port_lock_irqsave, &ch->uart_port)
+				neo_copy_data_from_queue_to_uart(ch);
 		}
 
 		if (isr & UART_17158_IIR_XONXOFF) {
@@ -895,7 +896,8 @@ static inline void neo_parse_lsr(struct jsm_board *brd, u32 port)
 		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
 
 		/* Transfer data (if any) from Write Queue -> UART. */
-		neo_copy_data_from_queue_to_uart(ch);
+		scoped_guard(uart_port_lock_irqsave, &ch->uart_port)
+			neo_copy_data_from_queue_to_uart(ch);
 	}
 	else if (linestatus & UART_17158_TX_AND_FIFO_CLR) {
 		spin_lock_irqsave(&ch->ch_lock, lock_flags);
@@ -903,7 +905,8 @@ static inline void neo_parse_lsr(struct jsm_board *brd, u32 port)
 		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
 
 		/* Transfer data (if any) from Write Queue -> UART. */
-		neo_copy_data_from_queue_to_uart(ch);
+		scoped_guard(uart_port_lock_irqsave, &ch->uart_port)
+			neo_copy_data_from_queue_to_uart(ch);
 	}
 }
 
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 62cd9e0bb377..0d7e06c7d790 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -239,7 +239,8 @@ lqasc_tx_int(int irq, void *_port)
 	spin_lock_irqsave(&ltq_port->lock, flags);
 	__raw_writel(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
 	spin_unlock_irqrestore(&ltq_port->lock, flags);
-	lqasc_start_tx(port);
+	scoped_guard(uart_port_lock_irqsave, port)
+		lqasc_start_tx(port);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 3be30fb05513..ac44681bcb73 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -295,8 +295,10 @@ static irqreturn_t ma35d1serial_interrupt(int irq, void *dev_id)
 
 	if (isr & (MA35_ISR_RDA_IF | MA35_ISR_RXTO_IF))
 		receive_chars(up);
-	if (isr & MA35_ISR_THRE_INT)
-		transmit_chars(up);
+	if (isr & MA35_ISR_THRE_INT) {
+		scoped_guard(uart_port_lock_irqsave, port)
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
index 33ea496c93b2..7bc0d0d3760e 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -334,6 +334,8 @@ static void mvebu_uart_tx_chars(struct uart_port *port, unsigned int status)
 {
 	u8 ch;
 
+	guard(uart_port_lock_irqsave)(port);
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
index b4e1b90e5960..a62d65b299dd 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -454,10 +454,12 @@ static irqreturn_t sbd_interrupt(int irq, void *dev_id)
 
 		if (intstat & M_DUART_ISR_RX)
 			sbd_receive_chars(sport);
-		if (intstat & M_DUART_ISR_IN)
-			sbd_status_handle(sport);
-		if (intstat & M_DUART_ISR_TX)
-			sbd_transmit_chars(sport);
+		scoped_guard(uart_port_lock_irqsave, uport) {
+			if (intstat & M_DUART_ISR_IN)
+				sbd_status_handle(sport);
+			if (intstat & M_DUART_ISR_TX)
+				sbd_transmit_chars(sport);
+		}
 
 		status = IRQ_HANDLED;
 	}
@@ -611,7 +613,7 @@ static void sbd_set_termios(struct uart_port *uport, struct ktermios *termios,
 	else
 		aux &= ~M_DUART_CTS_CHNG_ENA;
 
-	uart_port_lock(uport);
+	guard(uart_port_lock_irqsave)(uport);
 
 	if (sport->tx_stopped)
 		command |= M_DUART_TX_DIS;
@@ -632,8 +634,6 @@ static void sbd_set_termios(struct uart_port *uport, struct ktermios *termios,
 	write_sbdchn(sport, R_DUART_AUXCTL_X, aux | oldaux);
 
 	write_sbdchn(sport, R_DUART_CMD, command);
-
-	uart_port_unlock(uport);
 }
 
 
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index cb31e3aceb62..f89efc4a2d77 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -435,7 +435,7 @@ static void sccnxp_handle_rx(struct uart_port *port)
 	tty_flip_buffer_push(&port->state->port);
 }
 
-static void sccnxp_handle_tx(struct uart_port *port)
+static bool sccnxp_handle_tx(struct uart_port *port)
 {
 	u8 sr;
 	struct tty_port *tport = &port->state->port;
@@ -445,7 +445,7 @@ static void sccnxp_handle_tx(struct uart_port *port)
 		sccnxp_port_write(port, SCCNXP_THR_REG, port->x_char);
 		port->icount.tx++;
 		port->x_char = 0;
-		return;
+		return false;
 	}
 
 	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
@@ -457,7 +457,7 @@ static void sccnxp_handle_tx(struct uart_port *port)
 			if (s->chip->flags & SCCNXP_HAVE_IO)
 				sccnxp_set_bit(port, DIR_OP, 0);
 		}
-		return;
+		return false;
 	}
 
 	while (1) {
@@ -473,12 +473,12 @@ static void sccnxp_handle_tx(struct uart_port *port)
 		sccnxp_port_write(port, SCCNXP_THR_REG, ch);
 	}
 
-	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	return kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS;
 }
 
-static void sccnxp_handle_events(struct sccnxp_port *s)
+static unsigned int sccnxp_handle_events(struct sccnxp_port *s)
 {
+	unsigned int wakeup = 0;
 	int i;
 	u8 isr;
 
@@ -491,20 +491,43 @@ static void sccnxp_handle_events(struct sccnxp_port *s)
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
+static void sccnxp_write_wakeup(struct sccnxp_port *s, unsigned int wakeup)
+{
+	int i;
+
+	/* UART callbacks take s->lock with the port lock already held. */
+	for (i = 0; i < s->uart.nr; i++) {
+		struct uart_port *port = &s->port[i];
+
+		if (!(wakeup & BIT(i)))
+			continue;
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
+	unsigned int wakeup;
 
 	spin_lock_irqsave(&s->lock, flags);
-	sccnxp_handle_events(s);
+	wakeup = sccnxp_handle_events(s);
 	spin_unlock_irqrestore(&s->lock, flags);
+	sccnxp_write_wakeup(s, wakeup);
 
 	mod_timer(&s->timer, jiffies + usecs_to_jiffies(s->pdata.poll_time_us));
 }
@@ -513,10 +536,12 @@ static irqreturn_t sccnxp_ist(int irq, void *dev_id)
 {
 	struct sccnxp_port *s = (struct sccnxp_port *)dev_id;
 	unsigned long flags;
+	unsigned int wakeup;
 
 	spin_lock_irqsave(&s->lock, flags);
-	sccnxp_handle_events(s);
+	wakeup = sccnxp_handle_events(s);
 	spin_unlock_irqrestore(&s->lock, flags);
+	sccnxp_write_wakeup(s, wakeup);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 6b7dcbbacd13..60f72c19d67c 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -570,8 +570,10 @@ static irqreturn_t qe_uart_int(int irq, void *data)
 	if (events & UCC_UART_UCCE_RX)
 		qe_uart_int_rx(qe_port);
 
-	if (events & UCC_UART_UCCE_TX)
-		qe_uart_tx_pump(qe_port);
+	if (events & UCC_UART_UCCE_TX) {
+		scoped_guard(uart_port_lock_irqsave, &qe_port->port)
+			qe_uart_tx_pump(qe_port);
+	}
 
 	return events ? IRQ_HANDLED : IRQ_NONE;
 }

-- 
2.53.0


