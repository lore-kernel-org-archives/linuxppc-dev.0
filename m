Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E59606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gbz8FFiO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDn6C4tgKz30Qv;
	Wed, 28 Oct 2026 10:40:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793144403;
	cv=none; b=hWbfKXMnj5UD9VmZuxnqrXsX/yXatCdy3GV5gwe+2UglfqCH7OELhgRUMIAKG9ZLFxrkX7LTW0wT6jNZA7oI5pcOrPvz8ROG5y9J7mk5eoDqG2Ygeen2MDigFU8GWsSfyaxBqtI86bJ8zs42iiV4GQMq72wuOaSNpj85o3OuPXFii+BUySl9k1pdU5WJtZYeL4BEGhTg6pcdeAXHI4sNKg5umq3MZBC7Hn1JS99wfGq9v+DLGMQWcSCyxaTZrNjlgFPeKkBRsEcRO1lr7I4qMUo/PMiLL9Rd78mR5K+nVad9YiusWJmHWd/qSu2nZBfFubJHDwwEGFt5bJ0Y61AGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793144403; c=relaxed/relaxed;
	bh=59hJWh9kUI1s3iA0wXRzB3aZhPXoUspoK3eRxXm8TlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARyStX/0Ttq/o4xF/8uEE01/L6QbT9O7iSEoy4YcHLxjXU+Lwt9Z8CVkjBYktgOloMxNp4JXy6GltC6uvNIml7GDjdIioepJNlSijmHiXeKamwt0Z/Y3/Wv82hp04OF7c5aPzzmK/HbvxfaufjL9RmDct5ATPUIdTLbdmpdK5DVCaKVTEjdisU2Ilf6paIVKP0fbyi6THCXzzDkuCEKxQruTiD6n16urtx9B+Xgscpb/TYXsjcfG5UiHYARFzLk0T2MC5l7yPRjaEnvDd6cIOb/Ab5oYAdNFtUIv4Q5Y8QcU5uKpeJfui8Lp/9XiXF48cKb7Oqwvbn7aKml4qyEGGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gbz8FFiO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gbz8FFiO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDn692sH5z30VQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 10:40:01 +1100 (AEDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-843b6f8e2c7so505946a34.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 16:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793144399; x=1793749199; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=59hJWh9kUI1s3iA0wXRzB3aZhPXoUspoK3eRxXm8TlU=;
        b=Gbz8FFiO3yld+Np4GBcpkcjusXPPODx0tzpYwf/TsqhZZ97zihJUtteQlTYhoh7yDW
         pA4iGjvQ3XO7POfvK3BtGk9Lj3ShcxfQSsbiChPj/R3l81/ueTlf2KIeZ/TXq3F1ajEI
         A/jT6+W8Aaij4HAW4uQRNhLemcmeHVMfj4kbwFIU6mXZRsIeKn7oOlo4eEeRWylzFQQF
         sR+u1L8wvQWazSVnoFUIX6mLp5EFyUpto0YxxfElQqWL3UzTsiyJ7TbFO4YfJcCyr6Ti
         2Zr630osL0KzkZglBZNmllMRzguJ3VQB7Zj04MeCrQug3yX41BGTD9KrQ+I8/wI4bYVG
         t2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793144399; x=1793749199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=59hJWh9kUI1s3iA0wXRzB3aZhPXoUspoK3eRxXm8TlU=;
        b=OBZTH7ucV0l4IjWibj1P9fJWlejtTqB55NSfXKS/8pDT/HQzj2Q7YFNGtSLYwJ+T0r
         AxU7yHeDHFCqCQJAuuTl7VFNS63NGQ3xPuHwPC94OfnpbTS/3HgCvA1cW+cjNjkCtkxj
         trSzAy3WGSWLfzsulZntyrrp7nc+n5jflHfuvVgsnTF0/CqVLPw+0Xu9Pd94t9VQZCc/
         1HVc85momBVeZM2eKH0mDhkZ2M8RG4AgHTSzOY68m4fWeJv/nfpqygVKNHhPxK2987nY
         u5Uxc7zRF4zUwQkoO4nJzceSEMLgvDaifuC6R5cpC91BUkgVknYyz4eGa7UieOmvlkX2
         s9Xw==
X-Forwarded-Encrypted: i=1; AKwUvBzqqzju/oLyg9OEFZH8+xUlhUgTAs+7p6NXIdeo+A0E3voEOgRMg4eTDC4pnQR0bd1Sb2dQxhz9ac2Xy6U=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIgjPEdN+AHmr5XbN2Wbc5p6LiUKLSi91U/Y/RmzHNaDNtdTSTR
	HqFJPUigDUdU2CYJKGZQmAhGnpQ0Yp0IatYN+x+LuNqnJQJJ19Dm4dcP
X-Gm-Gg: AYBFou1LytOHucVWikERaLnqbnPsBnt57HpfSgy+SL7naVaMId/cSoQEZpizsn6hMiw
	15O0Zw4tRpkzEri9Y1GBC+vjcYmykzfHP21qKuc7IptHSSasCn2lT0wrd0tZHjr7DXx9tBd6cHE
	QJepES0kI3xcAWByNWrC3gMmP5r8PI73LDmvB9m5re2/kqgWwmAbjFmFidOa7Y+1552PrVrfMAz
	nYzSGq7ebfLtKvqcnsb93z3HFKFGckezGDAbB7lrA7pIASvleUAnCz9hcVHcIywRRGrvl/ZAkNN
	iE8le/C5/1MEYSzz2waXnuyMfZEqASQDr7RCSbA7VhgiHaZKum6n9vk3nre+OtZ+qz1bLwOIIVI
	BBvfFA99s0y34S3fVnJgEvApR1B7OM3h9Cs9zMcEh1XgBWHAFgSoDlk2TAb/pcpHYpnfz7rhW+d
	1AslvwOmATO37coz+RQdXIh9B0rGL2aa/wVxyp5BQ5ejoX7XsodmbZ8vLWj7ebLNLlXgWqa0Hpy
	J0xfhgCO16Z9ZXj7WVJihvH3uuPX0C0fBP/9AGUjPZjPrTvCO07Qi5OD8LETiKcnOWku9rLoJk3
	UeKOGmBY1/bG9UtbwSxJEtcBf20a/UNKnYhJ09chGfWAy8yGSmpnPXJXepip+I9ycCXXKq+iMjF
	B1nrIDwM/iQqqEXwe0lADYhBocqzIVpwH9Foc7ODEpdqP4JvvtfEHVkDJug1q3pPPVRe6TNDi56
	DklP4=
X-Received: by 2002:a05:6830:254c:b0:81a:9522:f007 with SMTP id 46e09a7af769-85ab704077dmr1141810a34.5.1793144399017;
        Tue, 27 Oct 2026 16:39:59 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b1fd31a6fsm62836a34.18.2026.10.27.16.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 16:39:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 27 Oct 2026 17:39:49 -0600
Subject: [PATCH v7 4/5] serial: 8250: drain canceled TX DMA before reusing
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
Message-Id: <20261027-submit-serial-8250-dma-cancel-v1-v7-4-985a023ba4b4@gmail.com>
References: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com>
In-Reply-To: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com>
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

uart_flush_buffer() resets the transmit kfifo before calling the driver.
serial8250_tx_dma_flush() terminates DMA asynchronously and clears
tx_running, allowing a new write to replace tx_size while the old callback
is still waiting for the port lock. That callback can then consume bytes
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

Fixes: a424a34b8fad ("serial: 8250: Fix TX deadlock when using DMA")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h      |  20 +++++-
 drivers/tty/serial/8250/8250_dma.c  | 130 ++++++++++++++++++++++++++----------
 drivers/tty/serial/8250/8250_omap.c |  21 ++++--
 3 files changed, 125 insertions(+), 46 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 974a47f24084..9f01fa36fa3c 100644
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
+	if (!dma->tx_running || serial8250_tx_dma_blocked(dma))
 		return;
 
 	dmaengine_pause(dma->txchan);
@@ -444,7 +458,7 @@ static inline void serial8250_tx_dma_resume(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
 
-	if (!dma->tx_running)
+	if (!dma->tx_running || serial8250_tx_dma_blocked(dma))
 		return;
 
 	dmaengine_resume(dma->txchan);
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 57fc7915adac..1a070967bf57 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -11,24 +11,23 @@
 
 #include "8250.h"
 
-static void __dma_tx_complete(void *param)
+static void serial8250_tx_dma_complete(struct uart_8250_port *p)
 {
-	struct uart_8250_port	*p = param;
 	struct uart_8250_dma	*dma = p->dma;
 	struct tty_port		*tport = &p->port.state->port;
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
 
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(&p->port);
@@ -36,11 +35,57 @@ static void __dma_tx_complete(void *param)
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
+	if (serial8250_tx_dma_blocked(dma))
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
@@ -101,7 +146,7 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	int i;
 	int ret;
 
-	if (dma->shutting_down)
+	if (serial8250_tx_dma_blocked(dma))
 		return 0;
 
 	if (dma->tx_running) {
@@ -131,24 +176,25 @@ int serial8250_tx_dma(struct uart_8250_port *p)
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
@@ -162,32 +208,31 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 void serial8250_tx_dma_flush(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
+	int ret;
 
-	if (!dma->tx_running)
+	if (!dma->tx_running || serial8250_tx_dma_blocked(dma))
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
@@ -312,21 +357,28 @@ int serial8250_request_dma(struct uart_8250_port *p)
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
@@ -342,6 +394,8 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	if (!dma)
 		return;
 
+	cancel_work_sync(&dma->tx_flush_work);
+
 	/* Release RX resources */
 	dmaengine_terminate_sync(dma->rxchan);
 	dma->rx_running = 0;
@@ -356,7 +410,11 @@ void serial8250_release_dma(struct uart_8250_port *p)
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
index b6f108d34854..0dcf63bd3d78 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1092,7 +1092,12 @@ static void omap_8250_tx_dma_complete(struct uart_8250_port *p)
 
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
@@ -1125,7 +1130,7 @@ static void omap_8250_dma_tx_complete(void *param)
 
 	guard(uart_port_lock_irqsave)(&p->port);
 
-	if (dma->shutting_down)
+	if (serial8250_tx_dma_blocked(dma))
 		return;
 	omap_8250_tx_dma_complete(p);
 }
@@ -1140,7 +1145,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 	int skip_byte = -1;
 	int ret;
 
-	if (dma->shutting_down || dma->tx_running)
+	if (serial8250_tx_dma_blocked(dma) || dma->tx_running)
 		return 0;
 	if (uart_tx_stopped(&p->port) || kfifo_is_empty(&tport->xmit_fifo)) {
 
@@ -1199,24 +1204,26 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
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


