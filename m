Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CA606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 03:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X0lceAPh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNG6h4g3zz30Pn;
	Mon, 09 Nov 2026 14:51:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794196284;
	cv=none; b=hYlYJvKPvd8IzBbzko09xocBWa2HR0wy0TFkXE27UQMl/+fPcoINEsVfyGRlZz2Vzi3mPHc4pYdPQpBsAB3bOOLMwr/D2g/BV8sYmIqzAnrLlQ6f3vcMTpV3eySiQTWCiMfPWXwnaUkd8clLvOoj6YMZnYkOqzalSDRUGyelr5CD8goVeIxNPleJ9X+W8uTSgJ5yWPQjueoS8zF3frx2T7k5t1voFX3SQPpfCYMNoX6f4alqk/O5Kll3ytck4pYL88WtF5zuNYeR/uXlbLx8SrYtCb2SSoAusXhIQPWyha07siH1+9OW2XjwCMs54efMgddfCE/xszx8R5e/R6YasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794196284; c=relaxed/relaxed;
	bh=4vFtdg3s5rVfzlce/+X3Usio5DzYXumKVb8+ZOgcBJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P8sptandevPrhQxw9FfQN+wT31P83O/h1m9jmwulC3q+w/BNM7Jq+/ELlt1hbRVA0ctmBQHaSOHxWEPJobS064o7Djoi45Hew9LdmoR3PI6YsIRr78dMJDtHYUZ56X2XYm7vqdn72BdOXfW5dcbFReUmeJj4vjNefH8Fogq9DDZ6vFsVznVvoANGbbfJtnPzGOqyyrwpJ2NHIo9/1rhWHxHUSNrU//+KTrkRtohLqCgwZxENB8lDVa2aec0mu8uRka8s9DMbfdD5Ay8DSx5VKKIMgD1YUqrkvsyVcCxOTQ+7ddDZkDtG6tLM8cwkU08ObJ51SI9LG+J9SG7Yo9g3Gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X0lceAPh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X0lceAPh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNG6f6zlBz308j
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 14:51:22 +1100 (AEDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-8490a7d6696so210705a34.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 19:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794196281; x=1794801081; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4vFtdg3s5rVfzlce/+X3Usio5DzYXumKVb8+ZOgcBJY=;
        b=X0lceAPhZGldmagGJ7jCncs5NPAwN6jzI8uzRf1QA0+3U7+p0pv7gnrh48yHEA/uab
         5jkBNaDRIRrJfyeyePzodiIHzRzWmXKMyN1YoYeDOFkJP1enS47VeRX+mwHNlt4kepXF
         QqCDBVIHH7ZXqYxaVrS/8pPz6sEzsiA6PkNrnBaXUDlIdcSyQlZwSiRSO/o0ZjdDMj3Z
         EsxMsAvrgxxwzv4MkoqF6+EAg07RQlZJE9PE3Jfnzcgb8g1+e/sRGi11MuhS7AkViKXS
         mWYLIahen6wHiFgel/TncFT34lfRf/FP7q5QGpdupHJOk30fEf8zGS3lnATO9p1q8B6i
         NGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794196281; x=1794801081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vFtdg3s5rVfzlce/+X3Usio5DzYXumKVb8+ZOgcBJY=;
        b=zlaG8AXTv3RhrrX9J3AlqDZA7HOqJ86V4xNnDUZjZVmznM+gP1jfMrB8vQgWHSJQGi
         YVcsTiTzLDd4L/p9KXnUI5Yoo1H8pCDncXYajcJrJeljdsm4rLate1iIzz5VRYKuBsQV
         XRxhALTOcx7NORWsJGkWaoh+tfwVsgUAMBzd3eJPZvA52KR4oDL49xN+zye0g9bHSEca
         NsHC0HT8XD5Rkv/0HujXDcq2ZLvdO7pU8AKJGA5WAZ0hD3NawV9JuxwgBimmMQ64gWJp
         XL7XG34kOMkEucnMMv0BOz/qyN6ZRnSltwKMgSlkxPGGPKwRphMQ39WtC+6Q9Qr2SoBK
         JimA==
X-Forwarded-Encrypted: i=1; AL+hErFqcvtAQEKwx50M+gxf3UjKwzihEZsAj0enyq+Z3tXdwdSqcbhn7zsv/p1x+gIq7MFJO4NYXu7oP6wRjWU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+dU4SRxEYLR4s4MatDx6Vs02GYFkw47E6Qd6pTnqLSZ/yEnBYO
	IBaZT/xtnHPoIYjwk7Twhr7I7lIiXxCMcgHRQ6cajLgs9qBwOQ/nK20J
X-Gm-Gg: AYBFou0czY4t+MMsnWxIKLHVel1bVS8nf8Lmi3S0XLrITEUN0v22SuWOSA4KNmNntCi
	aOWBd8guX7Ox9GFFkqICHMhDV9hf9ljNPYHHQDeS9oLQdpwTOzyl44NMdQJ2vzTimuaGjwJcvWp
	7ON5cYjL/7PPtxz1iK8sRImRe9xxIK1B4lQVbgYemH7SWTUt23b00BKv3OpSPuIW6zyDzhfpoZm
	V3LkpltBpTOxMirP6RmrCqfLF9dwoDvCaGHcMfEwoeQA8pbqUDAwPfXTLeDTWPorXtoGKcojCah
	oQNcPESZCRr/KHPAU30tKY5ecsbnkUr5tNySHt5tvXwYIUjYY30WNedWNZI/ZQ/RDQW6icdsxN9
	jqqKBktLP2Mg/7xgCbe2xSsz8wC2iZeOfhNHWUTPtRALK5TEfZz7D+n6XADRsMecGzgwn3kZoMT
	VfDoz70DynF8wowpXv7i2N1N1K2HVP4/qmv+zCFtFZFEWLebc1xgz10jbDErrb5/rN+0PBBIMsu
	NXpxnpXKIqrtdHBolq+3zPugWv8TWD++dbhy7MsyZITJ+bU0bUfOfVFFn0eGCJl6Sqas7FSv/uG
	gz0GXczd296akITIhDwMrSu1RuQep7VmBupzormbms1PE7gRzyUx9l4T7T5G+tMQsio5ybN/4bn
	gxBxw44gN5yNhPsweXEFEj7IFL/YsQE9OfHkJkhQpz0cQ+Es+/KwteP7KCZ3Z7oXPs60Bo00K6G
	CoTRVd9FmdjT1nXaUIgPQL0z4xJdNT3K+TYLFZ7a7HN6YwZFxuQGBd
X-Received: by 2002:a05:6830:25d1:b0:805:9b38:6f7c with SMTP id 46e09a7af769-85f507d8052mr2520136a34.29.1794196280630;
        Sun, 08 Nov 2026 19:51:20 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fad32cdsm2800428a34.6.2026.11.08.19.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:51:20 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 20:50:15 -0700
Subject: [PATCH v10 6/8] serial: 8250: drain canceled TX DMA before reusing
 its buffer
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
Message-Id: <20261108-submit-serial-8250-dma-cancel-v1-v10-6-e6227ddb95b1@gmail.com>
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

uart_flush_buffer() resets the transmit kfifo before calling the driver.
serial8250_tx_dma_flush() terminates DMA asynchronously and clears
tx_running, allowing a new write to replace tx_size while a detached
callback has not yet run. That callback can then consume bytes
from the new transmission. Reusing the reset kfifo can also overwrite the
source of a transfer that has not stopped yet.

Reserve the flushed FIFO storage through serial core before returning
from the flush callback. Keep tx_running set until a worker synchronizes
the terminated channel, suppressing old callbacks and new submissions
during that interval. Return the mapping to CPU ownership before releasing
the reservation and waking writers. Normal transfers continue to use the
FIFO directly.

Reuse the locked completion processing after retirement, including OMAP
delayed register restoration and transmitter-empty handling. Take a runtime
PM reference around worker UART accesses and drain the worker before
releasing the channels. Shutdown releases the FIFO reservation after
stopping DMA and unmapping its source. Serial core keeps writes and wakeups
gated until startup or resume makes the port ready again.

Track a flushed FIFO separately from the transfer length. If termination
fails, retain the reservation until normal completion and account the
completed bytes without advancing the reset FIFO. After successful
cancellation, process a zero-length completion once callbacks have drained.

The race was found by inspecting cancellation and restart while preparing
H616 UART DMA support.

Retain the tx_running check in both completion callbacks. Releasing the
reservation relies on the DMA provider draining detached callbacks when
dmaengine_synchronize() returns; provider callback-lifetime fixes supply
that guarantee for controllers which previously lacked it.

Fixes: a424a34b8fad ("serial: 8250: Fix TX deadlock when using DMA")
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h      |  20 +++++-
 drivers/tty/serial/8250/8250_dma.c  | 130 ++++++++++++++++++++++++++----------
 drivers/tty/serial/8250/8250_omap.c |  21 ++++--
 3 files changed, 125 insertions(+), 46 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 974a47f24084..1e739aceff39 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -11,6 +11,7 @@
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
 #include <linux/dmaengine.h>
+#include <linux/workqueue.h>
 
 #include "../serial_mctrl_gpio.h"
 
@@ -19,6 +20,10 @@ struct uart_8250_dma {
 	int (*rx_dma)(struct uart_8250_port *p);
 	void (*prepare_tx_dma)(struct uart_8250_port *p);
 	void (*prepare_rx_dma)(struct uart_8250_port *p);
+	/* Completion processing with the port lock held. */
+	void (*tx_complete)(struct uart_8250_port *p);
+	struct work_struct tx_flush_work;
+	struct uart_8250_port *port;
 
 	/* Filter function */
 	dma_filter_fn		fn;
@@ -52,7 +57,9 @@ struct uart_8250_dma {
 	unsigned char		tx_err;
 	unsigned char		rx_running;
 	/* Protected by the UART port lock. */
-	bool			shutting_down;
+	bool			shutting_down:1;
+	bool			tx_terminating:1;
+	bool			tx_flushed:1;
 };
 
 struct old_serial_port {
@@ -400,8 +407,15 @@ static inline int is_omap1510_8250(struct uart_8250_port *pt)
 #endif
 
 #ifdef CONFIG_SERIAL_8250_DMA
+static inline bool serial8250_tx_dma_blocked(struct uart_8250_dma *dma)
+{
+	return dma->shutting_down || dma->tx_terminating;
+}
+
 extern int serial8250_tx_dma(struct uart_8250_port *);
 extern void serial8250_tx_dma_flush(struct uart_8250_port *);
+void serial8250_tx_dma_sync_buffer(struct uart_8250_port *p,
+				   struct scatterlist *sgl, unsigned int nents);
 extern int serial8250_rx_dma(struct uart_8250_port *);
 extern void serial8250_rx_dma_flush(struct uart_8250_port *);
 extern int serial8250_request_dma(struct uart_8250_port *);
@@ -434,7 +448,7 @@ static inline void serial8250_tx_dma_pause(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
 
-	if (!dma->tx_running)
+	if (serial8250_tx_dma_blocked(dma) || !dma->tx_running)
 		return;
 
 	dmaengine_pause(dma->txchan);
@@ -444,7 +458,7 @@ static inline void serial8250_tx_dma_resume(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
 
-	if (!dma->tx_running)
+	if (serial8250_tx_dma_blocked(dma) || !dma->tx_running)
 		return;
 
 	dmaengine_resume(dma->txchan);
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 43c55cb991a5..739a8238e4de 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -11,34 +11,79 @@
 
 #include "8250.h"
 
-static void __dma_tx_complete(void *param)
+static void serial8250_tx_dma_complete(struct uart_8250_port *p)
 {
-	struct uart_8250_port	*p = param;
 	struct uart_8250_dma	*dma = p->dma;
-	unsigned long	flags;
 	int		ret;
 
-	uart_port_lock_irqsave(&p->port, &flags);
-	if (dma->shutting_down)
-		goto out;
-
 	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
 	dma->tx_running = 0;
 
-	uart_xmit_advance(&p->port, dma->tx_size);
+	if (dma->tx_flushed) {
+		p->port.icount.tx += dma->tx_size;
+		uart_xmit_unblock(&p->port);
+	} else {
+		uart_xmit_advance(&p->port, dma->tx_size);
+	}
 
 	uart_write_wakeup_if_needed(&p->port);
 
 	ret = serial8250_tx_dma(p);
 	if (ret || !dma->tx_running)
 		serial8250_set_THRI(p);
+}
 
-out:
-	uart_port_unlock_irqrestore(&p->port, flags);
+static void __dma_tx_complete(void *param)
+{
+	struct uart_8250_port *p = param;
+	struct uart_8250_dma *dma = p->dma;
+
+	guard(uart_port_lock_irqsave)(&p->port);
+
+	if (serial8250_tx_dma_blocked(dma) || !dma->tx_running)
+		return;
+	serial8250_tx_dma_complete(p);
+}
+
+static void serial8250_tx_dma_flush_work(struct work_struct *work)
+{
+	struct uart_8250_dma *dma = container_of(work, struct uart_8250_dma, tx_flush_work);
+	struct uart_8250_port *p = dma->port;
+
+	/* Neither the channel nor its buffer may be reused before this returns. */
+	dmaengine_synchronize(dma->txchan);
+
+	guard(serial8250_rpm)(p);
+
+	guard(uart_port_lock_irqsave)(&p->port);
+
+	dma->tx_terminating = false;
+	dma->tx_size = 0;
+	if (dma->shutting_down)
+		return;
+	dma->tx_complete(p);
 }
 
+void serial8250_tx_dma_sync_buffer(struct uart_8250_port *p,
+				   struct scatterlist *sgl, unsigned int nents)
+{
+	struct uart_8250_dma *dma = p->dma;
+	struct device *dev = dmaengine_get_dma_device(dma->txchan);
+	struct scatterlist *sg;
+	unsigned int i;
+
+	/* DMA reads the FIFO directly; its occupied ranges remain reserved. */
+	for_each_sg(sgl, sg, nents, i) {
+		size_t offset = sg_dma_address(sg) - dma->tx_addr;
+
+		dma_sync_single_range_for_device(dev, dma->tx_addr, offset,
+						 sg_dma_len(sg), DMA_TO_DEVICE);
+	}
+}
+EXPORT_SYMBOL_GPL(serial8250_tx_dma_sync_buffer);
+
 static void __dma_rx_complete(struct uart_8250_port *p)
 {
 	struct uart_8250_dma	*dma = p->dma;
@@ -99,7 +144,7 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	int i;
 	int ret;
 
-	if (dma->shutting_down)
+	if (serial8250_tx_dma_blocked(dma))
 		return 0;
 
 	if (dma->tx_running) {
@@ -129,24 +174,25 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 		dma->tx_size += sg_dma_len(sg);
 
 	serial8250_do_prepare_tx_dma(p);
+	serial8250_tx_dma_sync_buffer(p, sgl, ret);
 
 	desc = dmaengine_prep_slave_sg(dma->txchan, sgl, ret,
 				       DMA_MEM_TO_DEV,
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
+		dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
+					UART_XMIT_SIZE, DMA_TO_DEVICE);
 		ret = -EBUSY;
 		goto err;
 	}
 
 	dma->tx_running = 1;
+	dma->tx_flushed = false;
+	dma->tx_complete = serial8250_tx_dma_complete;
 	desc->callback = __dma_tx_complete;
 	desc->callback_param = p;
 
 	dma->tx_cookie = dmaengine_submit(desc);
-
-	dma_sync_single_for_device(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
-				   UART_XMIT_SIZE, DMA_TO_DEVICE);
-
 	dma_async_issue_pending(dma->txchan);
 	serial8250_clear_THRI(p);
 	dma->tx_err = 0;
@@ -160,32 +206,31 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 void serial8250_tx_dma_flush(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
+	int ret;
 
-	if (!dma->tx_running)
+	if (serial8250_tx_dma_blocked(dma) || !dma->tx_running)
 		return;
 
 	/*
 	 * kfifo_reset() has been called by the serial core, avoid
-	 * advancing and underflowing in __dma_tx_complete().
+	 * advancing the reset FIFO when the old transfer completes.
 	 */
-	dma->tx_size = 0;
+	dma->tx_flushed = true;
+	/* The core reset the FIFO indices, but DMA may still read its storage. */
+	uart_xmit_block(&p->port);
 
 	/*
 	 * We can't use `dmaengine_terminate_sync` because `uart_flush_buffer` is
 	 * holding the uart port spinlock.
 	 */
-	dmaengine_terminate_async(dma->txchan);
-
-	/*
-	 * The callback might or might not run. If it doesn't run, we need to ensure
-	 * that `tx_running` is cleared so that we can schedule new transactions.
-	 * If it does run, then the zombie callback will clear `tx_running` again
-	 * and perform a no-op since `tx_size` was cleared above.
-	 *
-	 * In either case, we ASSUME the DMA transaction will terminate before we
-	 * issue a new `serial8250_tx_dma`.
-	 */
-	dma->tx_running = 0;
+	dma->tx_terminating = true;
+	ret = dmaengine_terminate_async(dma->txchan);
+	if (ret) {
+		/* Keep the buffer owned by the transfer until its callback runs. */
+		dma->tx_terminating = false;
+		return;
+	}
+	schedule_work(&dma->tx_flush_work);
 }
 
 int serial8250_rx_dma(struct uart_8250_port *p)
@@ -310,21 +355,28 @@ int serial8250_request_dma(struct uart_8250_port *p)
 		goto err;
 	}
 
-	/* TX buffer */
+	/* Normal TX uses serial core's FIFO; flush reserves it until retirement. */
 	dma->tx_addr = dma_map_single(tx_dev, p->port.state->port.xmit_buf,
 				      UART_XMIT_SIZE, DMA_TO_DEVICE);
 	if (dma_mapping_error(tx_dev, dma->tx_addr)) {
-		dma_free_coherent(rx_dev, dma->rx_size,
-				  dma->rx_buf, dma->rx_addr);
 		ret = -ENOMEM;
-		goto err;
+		goto free_rx;
 	}
+	dma_sync_single_for_cpu(tx_dev, dma->tx_addr, UART_XMIT_SIZE, DMA_TO_DEVICE);
+
+	dma->port = p;
+	INIT_WORK(&dma->tx_flush_work, serial8250_tx_dma_flush_work);
 
-	scoped_guard(uart_port_lock_irqsave, &p->port)
+	scoped_guard(uart_port_lock_irqsave, &p->port) {
+		dma->tx_terminating = false;
+		dma->tx_flushed = false;
 		dma->shutting_down = false;
+	}
 	dev_dbg_ratelimited(p->port.dev, "got both dma channels\n");
 
 	return 0;
+free_rx:
+	dma_free_coherent(rx_dev, dma->rx_size, dma->rx_buf, dma->rx_addr);
 err:
 	dma_release_channel(dma->txchan);
 release_rx:
@@ -340,6 +392,8 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	if (!dma)
 		return;
 
+	cancel_work_sync(&dma->tx_flush_work);
+
 	/* Release RX resources */
 	dmaengine_terminate_sync(dma->rxchan);
 	dma->rx_running = 0;
@@ -354,7 +408,11 @@ void serial8250_release_dma(struct uart_8250_port *p)
 			 UART_XMIT_SIZE, DMA_TO_DEVICE);
 	dma_release_channel(dma->txchan);
 	dma->txchan = NULL;
-	dma->tx_running = 0;
+	scoped_guard(uart_port_lock_irqsave, &p->port) {
+		dma->tx_running = 0;
+		dma->tx_terminating = false;
+		uart_xmit_unblock(&p->port);
+	}
 
 	dev_dbg_ratelimited(p->port.dev, "dma channels released\n");
 }
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 477d645be9b0..a7cd5b918622 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1099,7 +1099,12 @@ static void omap_8250_tx_dma_complete(struct uart_8250_port *p)
 
 	dma->tx_running = 0;
 
-	uart_xmit_advance(&p->port, dma->tx_size);
+	if (dma->tx_flushed) {
+		p->port.icount.tx += dma->tx_size;
+		uart_xmit_unblock(&p->port);
+	} else {
+		uart_xmit_advance(&p->port, dma->tx_size);
+	}
 
 	if (priv->delayed_restore) {
 		priv->delayed_restore = 0;
@@ -1131,7 +1136,7 @@ static void omap_8250_dma_tx_complete(void *param)
 
 	guard(uart_port_lock_irqsave)(&p->port);
 
-	if (dma->shutting_down)
+	if (serial8250_tx_dma_blocked(dma) || !dma->tx_running)
 		return;
 	omap_8250_tx_dma_complete(p);
 }
@@ -1146,7 +1151,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 	int skip_byte = -1;
 	int ret;
 
-	if (dma->shutting_down || dma->tx_running)
+	if (serial8250_tx_dma_blocked(dma) || dma->tx_running)
 		return 0;
 	if (uart_tx_stopped(&p->port) || kfifo_is_empty(&tport->xmit_fifo)) {
 
@@ -1205,24 +1210,26 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 		goto err;
 	}
 
+	serial8250_tx_dma_sync_buffer(p, &sg, 1);
+
 	desc = dmaengine_prep_slave_sg(dma->txchan, &sg, 1, DMA_MEM_TO_DEV,
 			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
+		dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
+					UART_XMIT_SIZE, DMA_TO_DEVICE);
 		ret = -EBUSY;
 		goto err;
 	}
 
 	dma->tx_size = sg_dma_len(&sg);
 	dma->tx_running = 1;
+	dma->tx_flushed = false;
+	dma->tx_complete = omap_8250_tx_dma_complete;
 
 	desc->callback = omap_8250_dma_tx_complete;
 	desc->callback_param = p;
 
 	dma->tx_cookie = dmaengine_submit(desc);
-
-	dma_sync_single_for_device(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
-				   UART_XMIT_SIZE, DMA_TO_DEVICE);
-
 	dma_async_issue_pending(dma->txchan);
 	if (dma->tx_err)
 		dma->tx_err = 0;

-- 
2.53.0


