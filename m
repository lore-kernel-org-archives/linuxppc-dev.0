Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A99606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQzTm/k/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyYF40XPz2ylm;
	Thu, 12 Nov 2026 09:16:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::229"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794435409;
	cv=none; b=XD6BfeCcZybe1YQypiFuiEWk4pUy7WzbCV604Fn3dVoWIanNqULaH3iaAsYFGZHN/1W9kbONbRmljkBrbU9e2sUiiss/8c5LjKtWm9l2tEuO67Sfs3I8wme/LHEHIKb2F/4tnWmwEOkuE8oYTlk9zaKSvf/fy4jI1ZO+vCWR78eOOAtRIq7UjQECqVfXl7nSFpyCGRFlHuegliDxCndAhT2pgqS2vp5xMkyB8oEJAIOCL9RZ0IxHpAVY2NM3F2UGpEeMQFinifyHLSF36v03+4buNcndlt5o39YSnpY6R5zh6rT08CC++PCO/lQz44uOAYKOfmcAfeMxlbgIec4Z+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794435409; c=relaxed/relaxed;
	bh=AMLfsgd2///WRofDujebt5cSA9Zf11vcK5RD88/TdEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lg694ZP5gmn2oBzPL9yDo2vU35jZi1QE+Gc5GFyZDxiO8S1ylr6mjDfGlYTr47uYptpmBHkpDGWr1M2vA0Pn82b/F6czMD61RELILZY/SF2AJW4CPne2qrxlj5o8oe4EP58aPDBxT2b4nXm5vPvW1bMUdYH4Jen5DenacTo27dC1jgQOzpnn16XQc6r3EHfmFpwS9T/q1DgDuRxyuGta0JJJsXFZD3B3DrF4pnK4zr2SUyxYnJBB2SsYESJAje6f/AFhgnHU2G4i10ky6na8rCn7lRpgBcyVS1hXAFL5K3mYSbzvLXsNQuCbX6aNxpWXkjbDuDcFXWQsaAu6TlPRbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQzTm/k/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQzTm/k/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyYD08tnz3bYG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:16:47 +1100 (AEDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-55e02e89f78so1173066b6e.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 14:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794435405; x=1795040205; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AMLfsgd2///WRofDujebt5cSA9Zf11vcK5RD88/TdEI=;
        b=KQzTm/k/sVDuidDuMRLiLDx5ophCmOO/vzpWGwf8mDsWFNFl3v2YCqTOlbzZRiSRKS
         3qufaFkLE2x/LWHHjwUjZKo3cnS5ntYYiBg5Dz+Ko6bAEtskSyW1BYkpX9yNzTmFq0Jz
         HkCXIM8Vy6pq5eXkqKgOWbvsIDY1VBulzfS/lUt/O2RovSBrnrtUQ0ORH7YVj3LpOGcK
         /JZatin+orbz5kEvKldrHRNOfHklHNwLXhPg+nMqFu9m/oX8gXoqJWHqUrqL0SuB2Ili
         DC08gAXT6ceuBFSsFVwK/tecVIj/befiIjsyG5xlwFnGzFMlkEDimirKIwUG4uq7Zmoe
         04Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794435405; x=1795040205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AMLfsgd2///WRofDujebt5cSA9Zf11vcK5RD88/TdEI=;
        b=IltnzevS66y3DFCwUuzu7/xwR9Nb4qmzSrMozE8/+uQPUAcknYm6HHPKZZdEeyznF4
         wY3U5qJnE69LwOSpzDdBqoQJb+JvWOCyAdrlgZrH37o3JuFPfOUJFwIwwr9LxQyJ9H+t
         CX3fUJ2rrNNVQcy65+ZPwj/J9fsRDtIS4j0L9+4kwMHWAXrTX99NMFxqg85qeL4ACm0w
         ZXxXYntUKjD6y6w3UN8MBEIEBwTOLzR4CUyiqJYZN7atre8s7WbeidX7ZEgT34/d5NXy
         n7BaemJRqMxIXexTGhvjWkiEHO3XaOU+oZr/9NyKDeQYrm8QKrO4cUcrXAkSLAysH4bP
         bt2g==
X-Forwarded-Encrypted: i=1; AL+hErFENlffRj2Qo27qPx3M7jt1GeLV48r4tj7Fo03TiwxvwJSnUsD9PxvSj6WMK61VK1VrgpCOJEmLXQN3bM4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z97AZRkRzyVe8RW3qFGhEcA9E5a/8IjjKleSN6AEVIdno0lfknv
	R63eAv1S71iFJTxIPJslVcEETNygvGJSGDhxHElUCyFMaEclWbsAJxOE
X-Gm-Gg: AYBFou2tel7VhBYyoY/X5FMAGFJuu/8oRHfOm29cGl8W642T2ruKTC41MEG2rd0Bte1
	8enidi6N7tWiOiuz7WlhjZC4pXQEmrLgK7EaEuHwkDDBqPpA7G0i2uVKPv7b6OwZgKRD383TW+r
	zcLUcc8wuhwR3luYaSbwCr4cIaR39DARqzljN8ao4fmKnxrFoazfQ1uOKVGNs3XvDzZCYYwQIeb
	2uigaRlTEEqzscj9u27v+BaQchz4oq7aRVxsQwJg1gI62Xc17fPAHRPDEOxJzz6st23DvH+gSQt
	oZ2eltWYLaBhxi3140v88JzWyy3SrJEFGJKlMzt05PMCZx2ZD4deNY3l/ViN/rYRrh//Enmu+F9
	KUGqIkmRlbM42lwWFxiKb2OU+ny4hu52s1xKtEhX+eM6h+CyVjBj555F2qjvbmOy7HkNx4LlX6H
	q+A1jrmRa4ubfDeeS7icAxcb2JsEmViraqEbL3u2OJQZOt6wm1NFQmHc9Yipz0Ib26WNMg5nGlI
	erNNnA17l++XJnLaEVbVyzy7ONwRsru11mJ4kMbEwq+f78FRva/zlguzTAGfPMZytXAVyqSqs4c
	y3ASSBDlPK8O+dgYyC+GAO384t2N6JMERQzDYB8j600TavU0THUgLmRTSU6Jg4ScMExxtvkQlgD
	aGFkGjcru2ctb6cOPZgD0qpG02nybIGiqR6Q+6/zCHXxUHr7fgTYMd2/xhCW2iKWrGLIlsyjIZC
	C6kU4lXv0qFew/tFlIJ60PsxmApdV6stKMR13G/qTaPmnDW36TSsgLPG2ZJTkNPjuxP4FuhZO+
X-Received: by 2002:a05:6808:1902:b0:4f9:6348:cd3b with SMTP id 5614622812f47-56b97101439mr3389720b6e.41.1794435404903;
        Wed, 11 Nov 2026 14:16:44 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56902ae38ecsm5917498b6e.1.2026.11.11.14.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:16:44 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 15:16:33 -0700
Subject: [PATCH v12 8/8] serial: 8250: retain DMA resources when
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
Message-Id: <20261111-submit-serial-8250-dma-cancel-v1-v12-8-9e3456bc2555@gmail.com>
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


