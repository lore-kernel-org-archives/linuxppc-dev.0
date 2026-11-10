Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A1D606A339
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 04:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uwp3Rpex
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNtGx6gtqz2xfK;
	Tue, 10 Nov 2026 15:00:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794283241;
	cv=none; b=iJ+5ILVFoVNnLIW8MEXu6YRC5P2Ja719fUPXDn4T0tRS1S36oyLXwYjmwY9x95EHuOu9d90cAG6s+JwOidw/0CTLpMWNUhrdDZXKPt28W2UlBUGBdd/PhVITHDEyIfHX0vBUuNW5sQryNzljqPAtZGEDPUER0MrJFX99/MW7Jg6d8YIbhMFMW0aJw3IdfDrSt7milFeNd/gLWACTn2fpLRwg8mSo1qZ+IJUjceQVlqnlbi/5/NQEp3JgZHKjoJMcm03QiLZ32jN6a/TkLGz8actfea3nB6rBfn8F7T0fa70dcuPHYYrO7HItCP7La7LZbrI6Pj1XdrRK9j8APpyD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794283241; c=relaxed/relaxed;
	bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FdnjNn0RM0WTW8KxwVGm8duF7+R2WyaNK+7/aJbBWoy83bDW8URMEawNoxhmFMp+yKX5J4O7b8DYL14vefubdH2Uj58NoSbNB5oFGw11kG2OSusRyjCMw8gGs3FfFUwPKBhc1rl8OKZB0it+8XaLAlXXVR9/9bCgmXlWsTjbpz25DCsX2xN/tAT54+tSpVWe9oIjVPUz8o9pWaEqpJOcnMhg1dbXngUKzr13at/uEPfEr9pEDW89ookPvv3PcYTHGRBG5WsmkhR4699SvGLyAgL8A+3kMm47z+FLngoKgBERENqIiKQH1VXtDtLilZA2qDWk08ZV45YhVj3rtQF0nQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uwp3Rpex; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uwp3Rpex;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNtGw316Dz30V6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 15:00:40 +1100 (AEDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-85ac281604dso917915a34.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 20:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794283238; x=1794888038; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
        b=Uwp3RpexkqtyYjGBXa2r7cGQTs+KRb+E8NeawBlf6+j24VwLKRljLIXB4JqcKpJr3T
         xoxlRnshyfzcCilL+htnUYk/OXB4Y09Tx/CC87Mt9hZ+dBep1pVPqnFrOdxjeUL+RyWQ
         hj3ERfSueM6IEwWT/oO1FF+Wato04CI82wPshPrdXkPI0d73/99/PnHHPRAYCTH+xXDa
         kHcw+QQpH/6a0jCxyxp4ee8E5gYY91wy5Nh6eb64KqCIydTG+cs5ufupkNg9X4FIti01
         P1jjSxDlDIt1Tk7QoEcYVRFVWQBcnmkC1Vqin85Lq0xjWGNaILxWNv2xDmm7alsqtAkp
         IfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283238; x=1794888038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
        b=BcWNpuDlz1/GQgvItBaIXVPNNU8pzMV9Jk0M9+9FkhRT9RlC9vRxUeeYiR9N1xARSV
         Z0sLsxw4Or0M3Za51YHLLLbDPiX9179nWItNMGXH0gd+Kn/vvug7mxNYcZbOarnHwUkA
         3HhUZ7xBSjh8dzEY8IInGtjYHXK1VoOi3MjpnFLagPe2FnmqUHy1Mf3xTGGIqQ24ZrvQ
         hz9dxEk9PZgcD0IkkM387jEejIjgMrfq0bO5Gj9UL+di4lS1lMoZPn/7uMvuSF/QlUfp
         4R+qrMKxS27EN2TyynYFhEYlibb53cmJ7sMxc6SpcCZhDVBjvx8ZpgntA1R5bcPxnqol
         +ANg==
X-Forwarded-Encrypted: i=1; AL+hErErxpySTsRYtTTq9YHRJ5fcDQ9AxpEbJAciCCaSzkFSwltuFxvkvnCkTL7nj8CZvFqBo9yMlVZcXoXZUQo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+XAdsyZnCmFiGI0pVf5M4PxZBoAACTMN5HAjC/WIAzgfnyc079
	02jqXcWaIoX0MuJ4w/G0qDIkIHkSbm+LgzQHvDZO8+qNnYC9bXUhpsqD
X-Gm-Gg: AYBFou1CvCa73ErHUP9IDl2WkSfSPfsoxDJxiiqaRIXWKNU1IkaKL3w90kYjUKPAms9
	TxItN7SU50IOyJ5udCjk3jbpC7sX9XDzE9ulwftJjfAU63meYOKui+NkD3AGM49Jvz8BZzU5VSm
	flf5Igj5P7fpJxm+fsAKxUqgzrBx/vBPPeLWwBWMRQ+Mmvc7N/7bSHWEexnNEqpzdJQKgVOfA5Z
	VxFGgohKrxh61pyhqtJfInjv8vv2jaJ6AenwJAz5l2rW3YSCFyUTFcLZw5UEXiYf3yWoA8fiAIs
	6W10WqIMPOE66xIyxrvbFpS1eqfg1h53sJXU2O59vQYD5NgjtghHjzltgOMSi6YnAW3uPyQPz1z
	iP3jYM8ocstMSLuo6OxObN5sGE62z9by0GZ5aq9wAx7jzYVE/TrYnJovXJe1g4AjMqjLfdb1tNM
	/Y2JvXzagcapNrl1B9NYtTrF/PwqCCUOjrSu8QqpAObWjHSY8lscHxH/Ny0Os4/euRiMMlMNjts
	WTlp9mKbHotGYVOefNrDXDH3hoX+ylb1NnkoHW5IM6uk1vo/i5v255PCt16JF8ZHJlLRJ7h7HVr
	ysFchfZh419a0Hu2p0t3Q85RJsPwiqMRZ3rY4I5D9KtTCErol4JFMgEHechCcpDQfu5ltxnGF1d
	tV6XGcRTDIHBJVTuwzbzjyE3dSkqy4syGz3JbpCQ5Ixq2XjsO9Iv3mGbWVCzxSLBzrj+imPKmiN
	sf7ttxgwTRtGo6loXVL62bjgwzkEnBNezwpDyfaGL7yk3AXWsOyJA=
X-Received: by 2002:a05:6830:2693:b0:843:cc20:9d03 with SMTP id 46e09a7af769-860dc70cd38mr1124080a34.6.1794283238334;
        Mon, 09 Nov 2026 20:00:38 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcc1d759sm1028178a34.23.2026.11.09.20.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:00:37 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 21:00:18 -0700
Subject: [PATCH v11 3/8] serial: 8250_omap: serialize RX DMA completion and
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
Message-Id: <20261109-submit-serial-8250-dma-cancel-v1-v11-3-6364edca63d6@gmail.com>
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


