Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520D606A33D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 04:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qv3asNI0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNtH51JByz3bf8;
	Tue, 10 Nov 2026 15:00:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794283249;
	cv=none; b=fF8qecoTEDBmCIOmsQT6tIqpbOmm7pX7SpeoTeH7FG386iv2nbT/FFv2tBPZD3iCokBFu/oG5gOHhnfPOgYoistXlKvI1tdfPEOZEwUseGJxhV5khmXspC/QpzboompcyfIGo17/Y2T1C3Ycv22km2V8WFCoE5u1nAuDqmWkU8iR6JvaKnYn5qAK6YcB3ong+lubTgfQ2LxDTtnHvT0zeYmKX96JGI05U9qQCiCB9dWlHwxwv6BaJ8+Szs/lkKeEhDNlvphf5P/1L3+zy3Ec7qQPTj0aKeW2SDsLFFqo4gTFYlaVYod3+Azc3GMmxJmGaaIQ/X+hA/F4rupQEH+L+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794283249; c=relaxed/relaxed;
	bh=AMLfsgd2///WRofDujebt5cSA9Zf11vcK5RD88/TdEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EPUp6u+kh0i4tzgMyCCT0s7q4c4An8rD2cbGgHj62RCj7/zRGfbemyIN05GErdKq5e+45FBCGx1VOzMBpQKeKdKeV7GkG0cxDmN+/Tm05oWARjUS736kbAglph9qmppqFakUeCUMha+IZBRW5OMmW7y6MkCuYBD9A9qWtkuFXB4LlirfvGAdFFULaQO/sRtEAxW6F029SK72HKTb3t4M3Pks2z/JgN4jcTaFEPYyUD4BKD4KgoUvvRoQ62KgB/W4m9d8kgRCKvxj7R75qUjjA6ENeqj20aS8wiAqeMzFn0ePqHuz3A2fCsCSVHB9oVmkTcLRJcfZWbaZFDnAlfLwjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qv3asNI0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qv3asNI0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNtH40LZSz2yR1
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 15:00:48 +1100 (AEDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-8470d7d430fso863756a34.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 20:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794283246; x=1794888046; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AMLfsgd2///WRofDujebt5cSA9Zf11vcK5RD88/TdEI=;
        b=qv3asNI0teC3Zbhj+isDqBuUs9JvLnxaz5gb/VwZ+MVGcZxUJNA7LOaDeXUFQ6EOnn
         Hpj+polut7gQesFfIoPKFWl87xJ4KaJRVWEG3f9SHXUaaVyfHW9+5K/1QviYAu7mSXm6
         RqG+3AFqnJVl2oDNJHakVC9tKz/P+wmHLsKKYPYqt7p/bHqG7iBZTc6W23/EMWgz/wBu
         FJuINxu4JJPfJoJidEvOBk/uG2cXEtXIf+YMM0exYLiq+xvAhL0NXdYe/ebj6tZl9r0z
         fu9VJwVIT6yy0FJarn7mLQ4VYyihIcs3SAi4pY3MgwmGn7bXYKsq0ZL+dIxO6QhJ/rOQ
         Jxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283246; x=1794888046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AMLfsgd2///WRofDujebt5cSA9Zf11vcK5RD88/TdEI=;
        b=AWJCGGpwmBH6sjmm1oPvU9l2j8pR4m1xEr2yNvpWd7NNfwNZPYQ31x8q+b1V/jWpj5
         3KNckiADGVohpsCV8y2KSFAoPTdyMHhG+Tr6j81dLHR2tuLeeG1eypoLwKEAjFTAu+s8
         yGNzx1YL/Co8bJ25ByUsRKhtscHeNtMtk+FxXWCMSQ6Ol0cioIJn0VhPGCl9klOllqhN
         cRPmBx2jMsmVdzj2CeDFZ418DirGCUS6v3iW34sSgdliUBtqdWQRmN79j8eXnPB9fXUr
         uaocjty5VWfR+xYH0gxZKQFAJtlaECY0pmR6X1CC9j4WgF7rmzS/e6Edagv8JhnDrd+E
         vnlg==
X-Forwarded-Encrypted: i=1; AL+hErHBrMYHUtXIGYUZ53Q18lZ3cd58VvBkVHZ3dBGm32Mem0p7giUQVkMz1qaM0WyO9Ir8zMV3uIzsrv8J5s4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+XRXblx6PcDDDEH4Npx9ImqbvTbMcWz8b9HBcB/JeHn62t3Tpe
	oZOdixcUwLNroCgAqvAXa2y7R2nXqNEopSKcsLxquAVoBQ4CmiXFUwWZ
X-Gm-Gg: AYBFou3ULmjtbFuLFMpH3S5lAR7forwtXLM5wcL/dDkI7Mc8FvC6AGYFGax0tavMMRN
	R0k/t4OFnS0j4DwcPJXQu9y23OVPd7wOFo5g86aU2HdzbBSnfoMz0NiK5soMR156K0hq7QV/pnk
	5+RrwJ57YurNlKd46doNlrE3t6r6tRdxES6Y1O+LkH26W++6N6b0SEwMLaY2LTYTvy6f+oEQi+p
	W7RQY7sUW6z0+bf1/uvHPGHMgNk0y3Uki52YLygKABZI21Fm9cH7+1ESgtaAI73JiAQXivxqorq
	dJ7DJg41JXoLABPjUyVp5NwzgUHaXxxOfc9zZ7YJDyjkygmfvT7Awk5Ajyf5nBwnqmpWtq9X49e
	kP1GaHSljAF7yB30EI7eE8H037FuJhkWDKXLnidq/Mzox1JHxiBN9BaxS63H9x7lfv1hbBSbZE3
	zQMpYIwOv+IyWMQ+H8l5XRA4RDxkzu+FbQpM7LPb8xMNJs+gy+CHUU3fDEV/APjSPgoAjtOlffK
	SYTm4q6001jx9mhZ6s89P+jdO5+jSV8ownyMC0UMgWqyCBkzdG1ZR0MPP/UNOJ/x1ZVZCg3hdyz
	nivOl1ScJ7LgoCGkcrurst31nmMwfCWWlbwDbyIPJui3jvtRXy0oBlDmQIld07+C9eQD7ZqROuW
	BAx5wprFXijvy7bxafAZwBwnlFqLE+9+f557QrVrUQOIiwJVUrfRYzFNRyh9PultgoOAFc6K9tc
	sbUjVnPqHdOTwWqxbIMuhR06OZA4ErdMj8xB+OJXLW9NvQTkVJcs2RTHeTZprMI6ESsrENn8v+
X-Received: by 2002:a05:6830:4aca:b0:7fa:ab72:9e01 with SMTP id 46e09a7af769-860dc8464a2mr1224823a34.25.1794283245936;
        Mon, 09 Nov 2026 20:00:45 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcc1d759sm1028178a34.23.2026.11.09.20.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:00:45 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 21:00:23 -0700
Subject: [PATCH v11 8/8] serial: 8250: retain DMA resources when
 termination fails
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
Message-Id: <20261109-submit-serial-8250-dma-cancel-v1-v11-8-6364edca63d6@gmail.com>
References: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com>
In-Reply-To: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com>
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

serial8250_release_dma() ignores the return from dmaengine_terminate_sync()
before freeing the coherent RX buffer, unmapping the TX FIFO and releasing
the channels. If the provider fails to stop a channel, the DMAengine
wrapper returns the error without synchronizing its callbacks. Hardware
or a detached callback can then access the released storage and state.

Checking the error and returning early would not preserve their lifetime:
serial core frees the TX FIFO after the driver's shutdown callback returns,
and port removal can then release the callback context as well.

Require successful synchronous termination of both channels before
releasing any DMA resources. Retry failed channels after a sleep outside
the port lock, leaving channels that have already stopped and drained
alone. Keep the shutdown gate and storage reservation in place throughout
the retries.

Start retries with a 1 ms sleep and double it up to one second. This
makes short-lived failures responsive while bounding sustained retry
activity; neither delay is a hardware timeout. Report the initial failure
and ongoing failures with the elapsed time and current RX/TX error codes.
Track the five-second progress-report interval separately for each
teardown, so failures on different ports are reported independently.
Report recovery once both channels have stopped and drained.

A permanently failed DMA engine blocks close or removal. This deliberately
retains the buffers, mappings, channels and callback context until the
provider can establish that they are no longer in use.

Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
---
 drivers/tty/serial/8250/8250_dma.c | 50 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index b1f2998e7735..6efeb16fd994 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -565,6 +565,53 @@ int serial8250_request_dma(struct uart_8250_port *p)
 }
 EXPORT_SYMBOL_GPL(serial8250_request_dma);
 
+static void serial8250_terminate_dma(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+	unsigned int delay_us = 1 * USEC_PER_MSEC;
+	ktime_t start, last_report;
+	int rx_ret, tx_ret;
+
+	rx_ret = dmaengine_terminate_sync(dma->rxchan);
+	tx_ret = dmaengine_terminate_sync(dma->txchan);
+	if (!rx_ret && !tx_ret)
+		return;
+
+	start = ktime_get();
+	last_report = start;
+	dev_err(p->port.dev,
+		"DMA termination failed: RX %d, TX %d; teardown blocked\n",
+		rx_ret, tx_ret);
+
+	/*
+	 * Shutdown cannot return while DMA owns storage or callback state:
+	 * serial core frees the TX FIFO afterwards, and removal frees the port.
+	 * Retain both channels and retry outside the port lock. A permanently
+	 * failed DMA engine therefore prevents teardown from completing.
+	 */
+	while (rx_ret || tx_ret) {
+		fsleep(delay_us);
+		/* Retry promptly at first, then limit sustained retry activity. */
+		delay_us = min(delay_us * 2, 1 * USEC_PER_SEC);
+		if (rx_ret)
+			rx_ret = dmaengine_terminate_sync(dma->rxchan);
+		if (tx_ret)
+			tx_ret = dmaengine_terminate_sync(dma->txchan);
+		if (rx_ret || tx_ret) {
+			ktime_t now = ktime_get();
+
+			if (ktime_ms_delta(now, last_report) < 5 * MSEC_PER_SEC)
+				continue;
+			dev_err(p->port.dev,
+				"DMA termination still failing after %lld ms: RX %d, TX %d\n",
+				ktime_ms_delta(now, start), rx_ret, tx_ret);
+			last_report = now;
+		}
+	}
+	dev_info(p->port.dev, "DMA termination recovered after %lld ms\n",
+		 ktime_ms_delta(ktime_get(), start));
+}
+
 void serial8250_release_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
@@ -574,9 +621,9 @@ void serial8250_release_dma(struct uart_8250_port *p)
 
 	cancel_work_sync(&dma->tx_flush_work);
 	cancel_work_sync(&dma->rx_flush_work);
+	serial8250_terminate_dma(p);
 
 	/* Release RX resources */
-	dmaengine_terminate_sync(dma->rxchan);
 	scoped_guard(uart_port_lock_irqsave, &p->port) {
 		dma->rx_running = 0;
 		dma->rx_terminating = false;
@@ -588,7 +635,6 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	dma->rxchan = NULL;
 
 	/* Release TX resources */
-	dmaengine_terminate_sync(dma->txchan);
 	dma_unmap_single(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 			 UART_XMIT_SIZE, DMA_TO_DEVICE);
 	dma_release_channel(dma->txchan);

-- 
2.53.0


