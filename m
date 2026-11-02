Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36215606A332
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 23:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cZhj3Iae
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJSGF5cNCz3c4V;
	Tue, 03 Nov 2026 10:14:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793661285;
	cv=none; b=LDS9I8/5Y1hiNEwfKz7f8kx9JmyVhua+Rh3yB5MOA/LrKlIp/CmVD5h5i1dv6dSuWlLZvthbVjRiqOZGrTuL1yH8J986W5lcnPamU+57p6Y5MmGmMaH7dMaW7Hp4aJaguoxlWRDzDwOj8k7jIPhg9FTn7Jzqhq3Pr9nnNxcaMG3COLUHpqp04zLuB/8Z95n5RcoZzTSxrfcSxcA/pEUnwLZjgqoEG5TQPZMDPTDXQlg9hEGMBYkh7NTYTNTdILc+CVuyRIPx3SgP6X9grFzKCrsjRh8flny2W3vzj+1rsWi+O2u6P27El9kjaH/zYWeKWdGlGqdUotfMdhM50Fn+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793661285; c=relaxed/relaxed;
	bh=A54gT3IO9WKmImwah9XNTHPRX08hDBc7sZs/pq9+S4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DDb7vwZwZUukerqtMvEevZXPhKE6fVAujW1LHYzbKli5bKXoPbPuU43zeNz5atjzWPnSR67D0DwE/jzvnwLiWcb0fIJANR+4QztT3SFP6eqAcNfyonwfhRnQ1wolOemq+EhEGQB0dGBoFaQx0ey9YqutJgUNjgpvvXMe1QX+Xv1MSDPjtE1nRxBRvzsPnLx0n+fOrsG94p9qWT8U1XCLyx+HEnP4vh6260r/JvF+qQLaognGBFLOxNgifcNnjOz+ygm7RSHDg+9uSBqvr5eVdgOwo/G9DeuiNLyII3fQj5jauuiudCi333qCAxYqMZIESIoV8UI/0HtrSqZ6UVfndA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cZhj3Iae; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cZhj3Iae;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJSGD2Lztz3c8Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 10:14:44 +1100 (AEDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-7f48c750afcso2263794a34.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 15:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793661282; x=1794266082; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A54gT3IO9WKmImwah9XNTHPRX08hDBc7sZs/pq9+S4c=;
        b=cZhj3IaecPqTZc8IoMHBQ8mMlbZdVVpg+pHPzyvZ9nJRAMHWT3cYp7NU1pJQ4XJ48m
         5SNTsNfZzitdKnT8oLJpEY7U4zkyANpEgOVcgZ6qldukGqipDnmWxOLDPmCwL95DkA90
         8qlrCx+Uk6ISWjvw1sxKyOUV6Sk9yu3+hfYg1GnrdZqIs5h9T8xy9hdwX5erflWE7M5V
         wjdYFjcuIel+o2wLxU6WIkGfPfoCSOlxGofPbB619DPoEmhuJpaca5G+1yME/RE6d6K5
         7y8yQu5lr8N523zC57Kc9HoOAILux/7It2rUX3Q/0fq345s3gtcTrOGKmk7QP+0zBxmp
         uQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661282; x=1794266082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A54gT3IO9WKmImwah9XNTHPRX08hDBc7sZs/pq9+S4c=;
        b=xNyH6VCM//ACWtFARifvZRudK0RJPF560xRY0hSsFP98zXBmc/kbWBl4DbQjxHebwV
         qqGWYal17Q3mV9IvYGFEe7Eu194jTJPGfLkGoQI0kJrkrQbJp53iPTncZ4/q/JMeooqH
         IZuSNYSkeSivCu3sMiFFinb5vTfk55wRNKtl3sWy8lesj2oyL3qoVrKsgqt38nuqg7vL
         o6Rka5mpSqbMG26VWnWxH9Yqelo8cZuEHv/8wygOYIIHEdGLlX5BiHDKBEs2uBbX5jHx
         0hjQPH5m9DHTSIdWdv3PgfES+/THHQb1GjvII5npzDp6NqYvHqIINMASF5tSSzF9hjKG
         CJTA==
X-Forwarded-Encrypted: i=1; AKwUvBwfdJJpkq4DCaxcm08bj9n2ruhIbYOz9PmlqV4oyYCBp1oeXBsn7Zh/T7oLjdpVzs7MQpQvBaWtIlOrsZg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ3i5jZMsEwG8PqOt1NiUWX5M3IqPEdgVoov6ZLbsVoF0LQ7CqR
	wf387ITv2iLEGOOyNwL+HiABw+sEyMC10BVMcc7s+Vz0gfwleFWVepkT
X-Gm-Gg: AYBFou32cX3H3FbTHl+E6h+2yGyPkT57ix9a13JwSQh9y+9Sp93YAhAHkvaTTyCMALk
	4SHQCDE7ZWhGzhBTwVL4K0F2v0Q3iX9Dj3lS0BWCLgaGFSgym1TGUplEVJnTXgZ075Soh/HSkIo
	TQOrPDn2Gj/2ObeVMbiDTs+jvbq4KpS+BThit5WY3rggSai6/qntlYBox4eS0OJsO7aJ8/wYL66
	BbRjvi30uVskaKYdKMFz2mluDuK/f5SShPanIeupX1G05iP39N6b3aPchsZCtmoYVkmuutJhV0I
	0aMjrxSmqfdfTJEe+OfqKb2JJxYK/H2BSmG0gxmSQLiAJAHQv5yi5C69KlLSeInobewQnRgoVNZ
	VTiZB9EbGl2ybSVONsZaEjidH91pr3zVYSPOIpXnZDzOf0L+wuBYz629uIo/jQ+jiZB//Oes4SW
	BImX4YyPB96KSHcu2NHrnOJKjSlKrgoI+kcDJ/5ZvPVSH1U/ox+sPOuFagjbEkj0jvSH+nMbno3
	/tHrbF7Mny1E8WZTLuf7v3zy/vu8za1RwmsLWj35rMBzcoMHSUAnZ0vGrz3VsFU/aiZoKmgYGIE
	LXRRP7cq2WfNFM1h7nsLtZ0nWuCdIGXPDpVQtlj5rzi99lQ32L5v9rJg5CFDdjw8Wu3ai1nQzA+
	LdPxanfMBNfiUtvEQca93b08uE9xeoSHslaW1WhCjp2stvVeJloKj/TyPFW4NTko5cP2qV0uMNP
	PwJdcYwMLTm9L8aMMH+TpZk8FXkkOplePUZ7v2qiWXoVxNmnSuVeE=
X-Received: by 2002:a05:6820:5717:20b0:6d8:57bf:57bf with SMTP id 006d021491bc7-714f2381e69mr4446915eaf.21.1793661281665;
        Mon, 02 Nov 2026 15:14:41 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2ce869asm10134463eaf.4.2026.11.02.15.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:14:41 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 16:14:30 -0700
Subject: [PATCH v9 3/8] serial: 8250_omap: serialize RX DMA completion and
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
Message-Id: <20261102-submit-serial-8250-dma-cancel-v1-v9-3-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
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
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index b6f108d34854..322403cec2de 100644
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
+/* Must be called with the port lock and priv->rx_dma_lock held. */
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


