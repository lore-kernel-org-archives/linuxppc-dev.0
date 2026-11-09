Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DF5606A322
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 03:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BVIYXfmh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNG6b5MVzz2yYK;
	Mon, 09 Nov 2026 14:51:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794196279;
	cv=none; b=KZWJ0+IvotLS6JrDjaUw97ydHpF8U3u0ZKmXS4Nxb/T28ML/dQquX/+M/zPm41rsk5FIHYZa8LY+aKnnOml0PnNi34ljPmqLl2afxh1pjS972rbZfDBtUck+3+2dwrtaGh3NFvLph+TpSfKGPDUFt6FDrYw3IwH5fDZFTP2BG+4HN8Arx1RpkbTAHWl5yrznxcKxOnnRGbkJ35x/mw6wsU6SPcYKLLOBPS9hiOIvl6CNrd8coVEIgdwqyxgeDJ1fTDfZxvuldX5rOP5VrVG3jhmq7jrCM6IwLFBjN8guMxFh0jGINiQgAFvAIlKQe1vaNqwfIt69rkvlXhJUN+eiFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794196279; c=relaxed/relaxed;
	bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=guunJlNaYdDjL4wRvzl53SogSeYu5KI6WllMHtDiTRiSSs00V7G8dz3oa7qIshVApGKNNALsFAJIrgE9Wi8PV+AU68b5SNi321JHxUv2drtYVPUX9ubkp6YqN8pvSr2/j4nKwutpJ16v/ztYQ2w8Jbd2s5omkOV8V4PLtlisKVuJ8pkjYHCEvk9jljBcwJ+DTnbHGjZOAruDn9iAzNX8auohHMZHRajmbbU9XCyWDdrb1zQHEnwWAbAcZ7aLP82iZ8DLa0NlAwR7Yqq9/r8tYYz5piqPjhERQ86QzKbeSZ8cVSWVMJbqXsNRi1WWNSc6pBdSMF+MA+ek8f8z97JXRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BVIYXfmh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BVIYXfmh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNG6Z2NB8z2yTK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 14:51:17 +1100 (AEDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-844a8bf7e25so310506a34.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 19:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794196276; x=1794801076; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
        b=BVIYXfmhSnONw5l4qhAtXgGZdiguqwTUSOw2LunPKScSd7eRV5xX+ejxEeCeo+O2BI
         GHdgmUuW4QsW1T629j5FzXEm2WAsaXA7kSSCDW9X1zonCco4mwx1e0gBu++7DRZF4/Go
         0h6PK6InN8/0N9SspAVAgsogdAs+84Q78w0ADhJx1ywdayBm/QoN3ugGO39KfeM7Uidk
         Hl8K620pWzMuCQTrUpWsNKuYBKPhzBphuRFOY8fGCuQ5ASOAhTt4Iz699/tlyvkqGui4
         /S7aLxSRIHpisjukOBFmpsQoFGOkTfKZzkwnVNW40vjouLIBMeyDPuKXabDaiM+Fsj8G
         Mkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794196276; x=1794801076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
        b=gOtIZ6Pbvx4XlWnLmMId8ihjukUZ8NbwludYuYEJcKkIyfPBhEGB87ABOPsF2k+jRR
         uwH6J+Pzp4DpRMwZ1IE54y/NDq8tWRpqE673VGh3IOvEk0pjW/NbhyNivP3TPd7ix4iR
         5E0pBUzVFpiA739djmIQYFEEZO5bPzyz5AUd7HwguupVg4HQpQAtNl0ftBrjYNpBUynq
         s41jIsVSdx32lxtNUkdeDkSlnnxpqFjYjngOiiYZpDkOevVc2SFNZtq6e81t0GNZ6Gmh
         jJburtqGQ/Yt3GbSWyEXkNfAj8MkEjuIJxqKkLmy63cD/KPbgttXTM635n1aQzU6iAVQ
         x+NQ==
X-Forwarded-Encrypted: i=1; AL+hErE4NaZoTIsyxPhghjw8UbUaZZfW1jg74RV4pBI0Tiu+UMQ92/gDWJNoWkUbiAZDaVA7RfCf8bpn7ZGN/eM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8lNfMle7OyaBuzE9oneITgiUWpN2nLVUg/1GorJoEWakjLM9uS
	U8P0XslodHrKRNKXB0b1vrkRnFOAbHCiwSlu0H5gGFYyIbopGi7KYfFz
X-Gm-Gg: AYBFou2pfDRuE8z7nf0sQKT53zVyL8mF8NCvEqkP0hbrhBYvt+4tPLFUDjnmJjyzjTg
	W74hjQVR0mL7PcWiEv9JN1U1E+vRIdHequG6ouVpn1CgU3NhmpWjxU+gTRZ2QN3LC8zxmQlGZWD
	zKlyZDjRZT1uKCOEopv7AlmE/6gNtjJe9edQRpCOAu8dLZ4qhfBuKf636fnuyw5VxeYIZcruaBn
	8+qaHI1efn7v/v/IyORWBF58w3VAcdDM1FNVFRwHgDAFifVk71M8C6Dy63I8s8Qgkvig3q6viGG
	mV/2L/Bx9tOKAc9WXTx5UN1B254apynM4266/l1QgwE/yb9GG8lXP63vF0U/7IkhrWc2iqcqapm
	K6ywyv2FXL6dlzQVjB49k9//SKAxrCv1vwxJDbJigodE2CyFg9Icwp6hbGzvN4IlX9bff3Iua6D
	zXoCMNl7gZF8PFA0Akw+qgLQNqLMXVvpcLmzAA9h8CMrifFt8wl76jzDoO/nfEoUSw2n55ahaKT
	FYjH4YDks8/SpUZk3o0SGD4YZfrY8anam3p+/qxbz1KG4AI6TRctdGx4FToN6AOwfXYQXovRFaI
	0M1/hADlYD/t73GCrIhrJh7NkDr5gSgoirH77iSJZSVPZP6pjG7Z8ZUBfZL4vSL3dwyA2+1XZ64
	ddSSrbyUeEB1o66wP5pNHn/9qmKuDiyX5GSBpSAGo3aZ972Ka0TjW5cAXqoZ84NLkKBwG7nE51M
	GiGAFY6F7H+ddyQugiHuKby5X4G5i7YZLv6LikmFMgnuGmqI1i15Il
X-Received: by 2002:a05:6830:2b2c:b0:821:c75e:5309 with SMTP id 46e09a7af769-85f506ac2damr2072062a34.7.1794196275699;
        Sun, 08 Nov 2026 19:51:15 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fad32cdsm2800428a34.6.2026.11.08.19.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:51:15 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 20:50:12 -0700
Subject: [PATCH v10 3/8] serial: 8250_omap: serialize RX DMA completion and
 flushing
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
Message-Id: <20261108-submit-serial-8250-dma-cancel-v1-v10-3-e6227ddb95b1@gmail.com>
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

Moving RX DMA locking out of __dma_rx_do_complete() left the DMA
completion callback calling it without rx_dma_lock. Shutdown and runtime
suspend flush RX under rx_dma_lock but without the port lock, allowing
these paths to overlap the callback's buffer accounting and flip-buffer
insertion. RX submission and UART interrupt handling also require the
port lock.

Take rx_dma_lock inside the port lock in the completion callback. Hold
the port lock around the shutdown and runtime-suspend flushes, matching
the existing interrupt-path lock order. Assert both locks in the common
completion helper and the port lock at the flush entry point.

Fixes: 789898416749 ("serial: 8250: 8250_omap: Move locking out from __dma_rx_do_complete()")
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index b6f108d34854..5e114dd8f9bf 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -771,8 +771,10 @@ static void omap_8250_shutdown(struct uart_port *port)
 	guard(serial8250_rpm)(up);
 
 	flush_work(&priv->qos_work);
-	if (up->dma)
+	if (up->dma) {
+		guard(uart_port_lock_irq)(port);
 		omap_8250_rx_dma_flush(up);
+	}
 
 	serial_out(up, UART_OMAP_WER, 0);
 	if (priv->habit & UART_HAS_EFR2)
@@ -898,7 +900,7 @@ static int omap8250_rs485_config(struct uart_port *port,
 #ifdef CONFIG_SERIAL_8250_DMA
 static int omap_8250_rx_dma(struct uart_8250_port *p);
 
-/* Must be called while priv->rx_dma_lock is held */
+/* Context: port lock and priv->rx_dma_lock held. */
 static void __dma_rx_do_complete(struct uart_8250_port *p)
 {
 	struct uart_8250_dma    *dma = p->dma;
@@ -911,6 +913,9 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 	int			ret;
 	u32			reg;
 
+	lockdep_assert_held_once(&p->port.lock);
+	lockdep_assert_held_once(&priv->rx_dma_lock);
+
 	if (!dma->rx_running)
 		goto out;
 
@@ -977,7 +982,8 @@ static void __dma_rx_complete(void *param)
 	if (dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state) != DMA_COMPLETE)
 		return;
 
-	__dma_rx_do_complete(p);
+	scoped_guard(spinlock, &priv->rx_dma_lock)
+		__dma_rx_do_complete(p);
 	if (priv->throttled)
 		return;
 
@@ -995,6 +1001,8 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
 	unsigned long		flags;
 	int ret;
 
+	lockdep_assert_held_once(&p->port.lock);
+
 	spin_lock_irqsave(&priv->rx_dma_lock, flags);
 
 	if (!dma->rx_running) {
@@ -1811,8 +1819,10 @@ static int omap8250_runtime_suspend(struct device *dev)
 		}
 	}
 
-	if (up && up->dma && up->dma->rxchan)
+	if (up && up->dma && up->dma->rxchan) {
+		guard(uart_port_lock_irqsave)(&up->port);
 		omap_8250_rx_dma_flush(up);
+	}
 
 	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	schedule_work(&priv->qos_work);

-- 
2.53.0


