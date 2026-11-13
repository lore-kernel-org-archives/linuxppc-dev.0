Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF4F606A331
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tAX7PyJM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQsyg5dsfz2xwP;
	Fri, 13 Nov 2026 20:53:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794563611;
	cv=none; b=T1flt0E4ySs4vUzO8JkZ52QPBPvKRbw6QK3mWTDd0oR+acGgqtUaE58xRv6ADeQzF1ma90TVeG3YgUYxIc2KsBsCTXOs9CF3ibQ6OaBJ2bH3ep5U2GXZtboWQTDmq2iRrzD/+9y8BnBIYcftVqhRt4ZKUeVIPuBDPlzQmfg6BXr1IFnqNRS2HYKdZW5ZdP5dBZU/NmV6UHP8Y5Ry5e6cKPihqJrZQUZ5weKSlP813zDNdFyYWDESEj1Fy1vlLdDjedHJNuEH1lPyQxcn7i3/HXWiUtvpSNhlTIbGZH+6WIjHTWrsrHlU4czRTzAEK1VrxEVcw/YoSrOwO9hy72C9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794563611; c=relaxed/relaxed;
	bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aN5PK3gs6dTl9KcWKH0eUqXmzxDMXXJ+UEfvn/LD/lbO/O90ic+zM9jYX8kdx1Bo67aoJUnaXumGdI/21nhCMakK4tnYI6KPQzpwhry4pWAUWaZyk8eCkXWw1a0syX8+jPsXEcau/zy68cT52UXFe+U+dtlHFwpu4RtBOsJvC906a8zukVDW/wqakY3ZocYsPKdtBjygQip3ZBUgvQY/4ZNy3lJ07wLjyg/kxwnsgU+hMLBwXiTYToStSHU3tktlAaGAiAX9sC3tYtyRXymCPSONTss/MvSh+fqhrWxwUU48DJbGV0kIXndF0j1wt0dWxO3F1XwjQSB1+inzIsnPLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tAX7PyJM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tAX7PyJM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQsyf2Hhtz3bZR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 20:53:30 +1100 (AEDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-4af173320f9so955689b6e.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 01:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794563608; x=1795168408; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
        b=tAX7PyJMcw/oVysK8GQxlL/1dkTGXRJLqT/7yH2QzICVwdx5mAcCbnxGOyFF6esBDp
         3sg3n4aFKHdoxKGPE4BdCjCpB/Tsc5zGpKU+GC7yGMWZxjJvYBa7m/PwXiHdispCLLhF
         cqjKbMF9PF1UC20hTaUZ0Y81Mntr9RP0eQ2c8AP5MP664KHAqxQ/r78G/akedeZF0oeI
         otLf5U6Oy0IPcgzuUoit5ntn4LMjcNGmOxlCbJ69MJG2N1zU7RLMsu52gI4pNpFaw++b
         /lulEFkFtkSFROJUmM877cKIDSYNSFB/A+kggyvFnj6M6EkD8y9TyBS/UCTpa0mUDRW9
         NfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563608; x=1795168408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
        b=nLIdz7Hj1zUjzSQ1AHUJaAo8mihCTV6AwgL6KHAS/Pn0cQ+LPuq+ggpLNAHOhFToXJ
         u/0WWtQTCRNJ1BzAqk4QTtPcVJiTEND0C2IaRT+pcAXl6m/tN8NEO9VYQTJMMp3ujgPZ
         UWrCL2V8e6A7RJHdGQairPxZj9RioARqRE9CwBXhdLgr2ZHXGubxJVdsRwPQvZ6j5drj
         +Xn9Goh9FZz2FqMbPTdHZCGCHDxiFlfxRVmf/+GuI9rFNMI1YJP1E4AMzkAZkrordioI
         cLy2YAPw59ezhOQ1LkgS3Dmn9y6m2Ho3Qc1eimrP3zYonY14pjGsJsRkRDfhXx8BKPSj
         C7nQ==
X-Forwarded-Encrypted: i=1; AL+hErEzZHnakzpNg1mi557W/0iWmvPdWfbIXZiTIySWNGC+7eXJYZrAzEKHGpQQi2fzp2Nm/h/NEkxYhR4TtPI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8F0lnAdHmVER9mzS8UfRpBf2gRzHrhvw7Yir9KDQ+VcVpCc6sm
	VSUAeWlXw95gw49EHbFA05iMlXV/x+O2D/EhuruleOjupF3xtyrYx9if
X-Gm-Gg: AYBFou2pYLVuQVxCOZAzY0wqZoCo21uSs08e7141JByKiI0YKsS3CqLrMGBMwOTjX1n
	z784SViMWNd82vr3hDjEJd4+MencFTB1OCWioIk/LSjXkw3yKK6Hwavfi9CTNo145mCU+CxYt2z
	Zd1tZsQU7wvtXtM+ielOtRtHwAvRwjb1nHxxwKhZ646RhW06Z1JWP6LZWyHbFHszJz+tafmK804
	fhzVgC4QBa1z/H+i0IWkMa4B5CFMv+aVEZGlnCtiluZ4TD6vZqqx3snwAq0jTTs0Ul/Ug9kF+79
	O7gTZh+3yUq44hr24+FYOUUUq0Khn7VPbEwn51YytLUHbOhNRONwUU0wKknFF/bZ2KpBieRFL/F
	dDFGfZ7X2Tc2iU4wmFsgwZ/THZQ/CZcrJ7+w1MLb0rJhd4whAuSxL7hkOvVTFLvWWFoaB7aQsi7
	0o7+RzXXT135oBITvriCbknMiwZshRYhboCYCsGyhnUngthmj4lGfsCbGT/XAT5y3ypAArc1wsm
	r/TKjVxbES9ZCc9Ex+JNoWYs5CjFMII5gXuiexoOPmLpCTUC1Ysex7doAGLvvoc4O2kbt9UJ84+
	u6MoMYlBsbhLoyKj2KB5S8fPcgf4CCyscI7MSk+57UcMZr6m6y0BH7ESrO1E+qMt+DFMo2zCtDr
	Q9B2bF85vF5dMUUh/XcMP8D54cJ1/at0yiiKmWCGNDrQeMApdbWna5ITAolJK3cw8iORaIdSXzf
	KONrWm2R9nshDxI6d4HyRyDVnF9HrSrKwzGTiOnB0Kdprsl1GsvE4=
X-Received: by 2002:a05:6808:2220:b0:4b3:7549:d3c0 with SMTP id 5614622812f47-56e648e778dmr1355898b6e.18.1794563608017;
        Fri, 13 Nov 2026 01:53:28 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7094aafcsm1609523b6e.12.2026.11.13.01.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:53:27 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 02:53:16 -0700
Subject: [PATCH v13 3/8] serial: 8250_omap: serialize RX DMA completion and
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
Message-Id: <20261113-submit-serial-8250-dma-cancel-v1-v13-3-b857f2617ece@gmail.com>
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


