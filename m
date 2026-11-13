Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98792606A8AD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zLUnu1GD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQsyr4Pghz3bmq;
	Fri, 13 Nov 2026 20:53:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794563620;
	cv=none; b=koQp0yk1CVSvEBc2wpVZbpEIhZTCi0gK2pkgREcB0Jl2WEVLxWPQ9JAH/f/EDkRzeVn8slZR1nhewPu926zIrvKbnAmOkIVj7LQ2pgwK9pdvwzbk0cwlHfysgV+sLKuJW5vhleWhL1uGSSFsuRy94aGALMMJQu8BlZ84E7y5gJA6W61QzcuXHXG9+jeNPbWjMNm5Nxtw+W01ldadBy26IZIsfnZwfC5rtDSG3h/iVqNP7b6Eo2kzPce896WcosnaCliqRByapFDV/binZKWCSZ2YKaoqs3lUVer7Z4DnuSWS/vrKxt7vPByd8sJ5iFzDRsjxqwXGyZofSbrV+wVw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794563620; c=relaxed/relaxed;
	bh=tKw63yp+LNfG2M5Iosvm2af5QjVi5+/3H0IZittDmk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nbuXPn2CoHhhmYpv4iKn90/a//V4NYIdg81Rgz35p3AAxG9SLPMSR5ERf9WZoPrcGami6nAuD87AHFUe7SIwqQJOH8o9K2Ym3rQgSQgcCdZeiHT6AAQj6ypGkQlLXz7WhLW5y6sckfTle3H54NUOP5fla6qx4LG6czxlwuuP6uCkx3pZqU0MeaPgDo3F3Gpq0hxRB3dNs8wX+KhZDlPj5lTmJ5K0F/3QNz4TpM4USm4psy58/hjAUZwdS0MF6dPCngdC7iE4WU97RdVWVP09rpHW+gbwlmIYGjS0x98Np1dQyLMOnbu+yCJfPK+UrQoKYO0tx3pH4bqB+/2ciIJkXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zLUnu1GD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zLUnu1GD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQsyq6H8Jz3bmH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 20:53:39 +1100 (AEDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-51f2e9e6987so1759921b6e.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 01:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794563617; x=1795168417; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tKw63yp+LNfG2M5Iosvm2af5QjVi5+/3H0IZittDmk8=;
        b=zLUnu1GDEntWTV2Rg5MvdrgTS0uUIz7MeL5XftzXUru2F8+GzOdWqPLie3dsQYmuuQ
         KxgnE8/ulKaR5dcia7PG7MbTdZnnjXVdNZrdvURV4KRQo0jR36hXyOtGX8SM/nHvyDCQ
         Q2sohxWPH34km7g4Bxzf/mowFZ2nXdt4GEJ1ZN0LSprx9tbRzGYmpVUK3OhBTESB5uTW
         /uncf9TeLq8JQ6KfX4nq67gqzZmv176pXzuK3vmanakL1ljeiDUyXGYbRE91iWVpdFTc
         KMmhHSH6Ho+o3OtEV9P5KK9oeTsWrUFircUilxdch88YYqDfGMduDHHnGT7R7lz8glCX
         2IsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563617; x=1795168417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKw63yp+LNfG2M5Iosvm2af5QjVi5+/3H0IZittDmk8=;
        b=nTqaUwdSQoC6mLGwAZU3L6yanLvAoeq9b8UuZ9fDmHbod9aSYJ13DrkDTKexhefhYo
         s5VAduI6EL+GZGMU/gQBaUUva1jtxdXgy/fBQTU5kOPM/PMAmmq4BLH671bsabLqAXpS
         HdsAmwdYR/TZDLbfCR9/04zVeWjyl7j0ziKp+nVqUH6yOHEmj4Lpc9GDiTXrcl/nw/dS
         vuTwb55RaXei4Le+u91Skq40Cv9zuGJb+8Ws6qZaD0jhZMYXmzjRdEgr0Q8lic3pslJs
         Oy0AytXVF3PaxlpNrciDMOEord92tybxVc7DTNRECPooZlxmqfrygLv74BfCospMT2W/
         aDag==
X-Forwarded-Encrypted: i=1; AL+hErG9P8famvsF7FNLKQ8OjI9tjkLXxEqWP2HqLJJLMpvI3kZP6x1wY8vUGKByZTPfFhHrY71NkZhuzKuy6JE=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+/Jv/CZXvhb+WIOTCTJ0bRc7yTd3k9mAsWO3Zmwe78tLSRXk3h
	4TdI1bxYe3zoXP9t3FfC335ogzFQ1KuIEW6blJSJLQzjli/O+IGiotta
X-Gm-Gg: AYBFou3hbBYCaI4pQdJ6ZLiq2ldS06r3hTpOD0TvWENSjjASBgv6wSbcJcqsyGAwR6M
	7tTUeVtfCQGXUIFychcAOkuGwGJ1FRSLBkM9qldEudTG6PXf0VGhjqtSpHlNbnonyv9cYUg2li7
	S9SveoRSQ8EP/OnoOJbJROIk+bseyEt8UgvpcT+HqxfWsnUu3yxEsZGhdmisxpuVOo2DSYW9eTj
	Kx4JjWWJtWEhj/ll499kPsxlXjwt4Khb8RtEukEJna9bBCNkUoxfbPpdqPGeox11YAtGYKSw7d9
	PI55rrtJzi0TFFehyO2tuKtreViQSq0c0dcdF3iemjYdRTwDDB7K3fmAhG0CcMHtfkK4Y0JAvQC
	u7p+URVIJM+dnBb0uGhGgBEv7I4rireUpox3sj9Gy91CLx7utugera18fAw031dsIFyPIBsxG1F
	hE6DjZ6QfaUFVg8mmR7pB7AgnSe8fw4UZnT5VzuROeNoqxK0DuK9aebLb2wqdzc/75gWUIb37hp
	WEgsxNM3GASynPTuzhRfJkrCD4v005PP9Ue2ovh5s4bvO1NzNefrjFBmtuM3JKrnD4Pv/yGJ05v
	PBvWg9QkuIVrKPOk6Jh+b8CuXwBs4qx3yRrbetg0l4/w0Wb3YoPRPt9POdwjhI5D8Z45aBOP/Gq
	vtC/z8Ooq2sJaEP6yjTn73Xrxft2ESwKcQuvqOuKyiyWV1z/HpTg36kALAddud+KnRdpGymp6RI
	IWwKuyBFs5QNRgxbFcPWa3hfrgzM/EInbj9vimvVTR4474OoQjPBQ=
X-Received: by 2002:a05:6808:3383:b0:564:3e9e:b498 with SMTP id 5614622812f47-56e65624042mr1138531b6e.22.1794563617554;
        Fri, 13 Nov 2026 01:53:37 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7094aafcsm1609523b6e.12.2026.11.13.01.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:53:36 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 02:53:21 -0700
Subject: [PATCH v13 8/8] serial: 8250: retain DMA resources when
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
Message-Id: <20261113-submit-serial-8250-dma-cancel-v1-v13-8-b857f2617ece@gmail.com>
References: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
In-Reply-To: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
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
 drivers/tty/serial/8250/8250_dma.c | 48 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 1d7c3c5b7564..0719fd4c3129 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -578,6 +578,51 @@ int serial8250_request_dma(struct uart_8250_port *p)
 }
 EXPORT_SYMBOL_GPL(serial8250_request_dma);
 
+static void serial8250_terminate_dma(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+	unsigned int delay_us = 1 * USEC_PER_MSEC;
+	ktime_t start = 0, last_report = 0;
+	bool first = true;
+	int rx_ret = 0, tx_ret = 0;
+
+	/*
+	 * Shutdown cannot return while DMA owns storage or callback state:
+	 * serial core frees the TX FIFO afterwards, and removal frees the port.
+	 * Retain both channels and retry outside the port lock. A permanently
+	 * failed DMA engine therefore prevents teardown from completing.
+	 */
+	do {
+		if (first || rx_ret)
+			rx_ret = dmaengine_terminate_sync(dma->rxchan);
+		if (first || tx_ret)
+			tx_ret = dmaengine_terminate_sync(dma->txchan);
+		if (rx_ret || tx_ret) {
+			ktime_t now = ktime_get();
+
+			if (first) {
+				start = now;
+				last_report = now;
+				first = false;
+				dev_err(p->port.dev,
+					"DMA termination failed: RX %d, TX %d; teardown blocked\n",
+					rx_ret, tx_ret);
+			} else if (ktime_ms_delta(now, last_report) >= 5 * MSEC_PER_SEC) {
+				dev_err(p->port.dev,
+					"DMA termination still failing after %lld ms: RX %d, TX %d\n",
+					ktime_ms_delta(now, start), rx_ret, tx_ret);
+				last_report = now;
+			}
+			fsleep(delay_us);
+			/* Retry promptly at first, then limit sustained retry activity. */
+			delay_us = min(delay_us * 2, 1 * USEC_PER_SEC);
+		}
+	} while (rx_ret || tx_ret);
+	if (!first)
+		dev_info(p->port.dev, "DMA termination recovered after %lld ms\n",
+			 ktime_ms_delta(ktime_get(), start));
+}
+
 void serial8250_release_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
@@ -587,9 +632,9 @@ void serial8250_release_dma(struct uart_8250_port *p)
 
 	cancel_work_sync(&dma->tx_flush_work);
 	cancel_work_sync(&dma->rx_flush_work);
+	serial8250_terminate_dma(p);
 
 	/* Release RX resources */
-	dmaengine_terminate_sync(dma->rxchan);
 	scoped_guard(uart_port_lock_irqsave, &p->port) {
 		dma->rx_running = 0;
 		dma->rx_terminating = false;
@@ -601,7 +646,6 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	dma->rxchan = NULL;
 
 	/* Release TX resources */
-	dmaengine_terminate_sync(dma->txchan);
 	dma_unmap_single(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 			 UART_XMIT_SIZE, DMA_TO_DEVICE);
 	dma_release_channel(dma->txchan);

-- 
2.53.0


