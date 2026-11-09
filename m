Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9F9606A322
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 03:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gJ2LDjVk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNG6k6q4kz30VL;
	Mon, 09 Nov 2026 14:51:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794196286;
	cv=none; b=BiXw0P2nm3dmOn7gtwA+Dw5o3TjjI4HS9lim4E7bfTY4DXu6KfcwaXS7FWKk9uY9njN8Zj2m89LKNMg4uOJ18btOMt/Yb9qZu1fZH6lT7HGDxNYoRxrY8x/ILw0NT9iWLCILH6DmYMu1IHGUOtLElESlO4n6X1HDnKpWPCB8WYj5weUB4bTG6Q6sJtrWBg3vVEWpBK1BmFoBFl597urWPTntDTccSJ0ryrigbrQB5b8jE2FE4uvXPA3rWCXZy6TEi8auTKUxB/aDxc/1RhQxUy6x6hpASNH0KE+vBwW2MZPUmIJBv5kaysOrPYV1XnfUue2bsTCGYJ+v5q0R/bDoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794196286; c=relaxed/relaxed;
	bh=PCXVp3TiouFUBp+9ys/g3hrJvGOqhB12mNnRiK6VjhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eG/p41yhjHhCMUF9AKHSCcCPduEDeW5QwLDmL4xHuZvbjcnQJlpwjvGR8aKhaoIw7HGEfmV4rfuG9NS5143LrgHI6B/G0hukyy2HdTlmohHZcxe1x6Gbw8lokJGD306FbBm75k7jSurin/vqCrrbHBfdkGRZtHU4GM0JuIJ6XCxeuy/xLJDglNIOe41dkkwFdqGkbcSbZka+dHawy8c4zBNlpd0qU02ohkFmgjQrGuLkmdPacbQoPX/17OubfilXavMow2RkLRwPjGRyP17voR5+j9/R8h4De4JVo0SWuF2ldBL9hQ/r/xQXflbaKlQf9S7dLwVpymKUHvyfeb7I0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gJ2LDjVk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gJ2LDjVk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNG6k0Nv6z308j
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 14:51:26 +1100 (AEDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-8439fe796ebso253587a34.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 19:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794196284; x=1794801084; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PCXVp3TiouFUBp+9ys/g3hrJvGOqhB12mNnRiK6VjhQ=;
        b=gJ2LDjVko60ZbpDJhBhuKwcmE6z1Su8ICU9ul8oryEBDalvbvqCBWeAUxdUPo6i2mI
         Cyhp9x7N7uqQXQ112/pUQKsT7QgRbSvOPM/2MHu+aCtbGDrVL5FBF0xOCVKMAggPGckM
         2TDo7jaIE5IvhYhBzNzvJpYRHVLyz9zIgW5mSpocWk64v1w7XDnNvCx+kN6j3U2cIcVm
         +aX9jwCjtCLP+o3Kya7syYD+jTFBb3QFTIx8dOcy9m0Mns4Wmml8hEXNuuGm4iUObIqE
         QouVC7FS901r+ei8X693tcQSXjNFDhgY3EFDZEcnIov2t3QZ6FKlkKpQfksheP1/LW4D
         7Irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794196284; x=1794801084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PCXVp3TiouFUBp+9ys/g3hrJvGOqhB12mNnRiK6VjhQ=;
        b=J1z+IuaYYF7iOeGKfCh46IfKzT6L1mDzAP+OX234P7BswNfJu2pn8qH6oPxT9KS5hO
         euRCBbO0y8MM1lkJOHYuOzczB86j8p5SljLdZwXDXtzcPxQsCuuTYNGRGf4tQJExmFNR
         N9Aqa3My4u3FwFckfKZpUVlNq7T/LWIWRLMCXnfK43/3wLvJgItkyySTSg+ezvmwRSCF
         CwgLZS1wohC05XyWPguAmnowVlf1/sbbPkhqA9mVOhXEmE/CaP97cWbdcXvpcBA/hRQY
         0xqHiQXlCDyhdXTh3eQi+o1BGI+PG5OxrXZFRGqZUG0q8RdZfqtHax+F4wlSxCXJCAgj
         sFHg==
X-Forwarded-Encrypted: i=1; AL+hErGHirYIEO0pZAA9kCxQUMEiKTB4YkJCn6LUiU2PPEqH7qdW9GRIscNQmZ2XrLGlrnHm9JruJfCi+z0LXRM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9Xp95jkrIGaq49l6VuzbhOTzk1wA4RX9yMt9DvLt7rPD23Mxta
	FAkBOPywXlOTK0aErumEs5Q3kgeyjo9g3E0ivuPpJKH6/6YUr5ismWdr
X-Gm-Gg: AYBFou3V9gEnKktvQbieHpw5EzxUO25N1H10kev38n1uokEXCx6gwRpWLDEv4nwJlt/
	PGYnlmUn6Ll0+Rr1nuLQGRLYO7ESkiybBLIUcGGSIeVBmMl3C/Sumx4GKVMtkxZq7OKvWVP9RPL
	cdy/MR2E25kVsCflCUxsSB/1Ihql5iO0r+AFvVYJrmRXUWZAOScU2dQmOypaweI4Hsp2ncNZ7pD
	RfxL+Wb2gkbM9osWPfKGk8YSoYUC3B0w5qEFVifvmx+IaZAwzrxmuVer7FqRkAQbs6U9IWsbhZa
	SlR3LavdlqwTqtTJeQtuzu9AjU5Tmq6NuFolWA3AG43mxq2OBJUz8LXZa6KfM14DugSAfYoCvJF
	H81yEkRHV0SblmXSdgbLCtPaKaW1j4IrM5DStSzCEUdM/EHnMU2sDeGuMm58mVWxqCk3ENmuwtq
	O+ZigMjwBxr8drMs77+SqLx6t+EcXkDyY7n212cd+1eRd2ztOEKediF1LXZT5NgLAik4sDQ7h22
	+13gTQXXST4TCMuGfjILQccY9DV6clRWfQ7fRouYH+ZiA9I/KQriOcxRcxFSA/pLYmZRC47l9dJ
	waPCTItCzbCGFjvOpbuDGKp0aG86H5OCbMet+qh2YLgxAaia44turJRAsRAHPsZrc6VoDt9mWI/
	RJ2UEbo0kwbzHbrb5gcwN5G3Yic4ohSWZ6z7wPYCm3nYHa5H/XUqHIhnJZpzuiougo/u1jYvO6q
	QVpK2nUJm/DY9GYXdD+bX+zIb2jA+yIPEv+M3T8aJQSTqCYHQieny5
X-Received: by 2002:a05:6830:928:b0:845:156f:58b1 with SMTP id 46e09a7af769-85f50847937mr2643447a34.24.1794196283700;
        Sun, 08 Nov 2026 19:51:23 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fad32cdsm2800428a34.6.2026.11.08.19.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:51:23 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 20:50:17 -0700
Subject: [PATCH v10 8/8] serial: 8250: retain DMA resources when
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
Message-Id: <20261108-submit-serial-8250-dma-cancel-v1-v10-8-e6227ddb95b1@gmail.com>
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
---
 drivers/tty/serial/8250/8250_dma.c | 50 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 1ea22954150c..a279e3a1a845 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -528,6 +528,53 @@ int serial8250_request_dma(struct uart_8250_port *p)
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
@@ -537,9 +584,9 @@ void serial8250_release_dma(struct uart_8250_port *p)
 
 	cancel_work_sync(&dma->tx_flush_work);
 	cancel_work_sync(&dma->rx_flush_work);
+	serial8250_terminate_dma(p);
 
 	/* Release RX resources */
-	dmaengine_terminate_sync(dma->rxchan);
 	scoped_guard(uart_port_lock_irqsave, &p->port) {
 		dma->rx_running = 0;
 		dma->rx_terminating = false;
@@ -551,7 +598,6 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	dma->rxchan = NULL;
 
 	/* Release TX resources */
-	dmaengine_terminate_sync(dma->txchan);
 	dma_unmap_single(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 			 UART_XMIT_SIZE, DMA_TO_DEVICE);
 	dma_release_channel(dma->txchan);

-- 
2.53.0


