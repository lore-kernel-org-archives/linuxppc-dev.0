Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79171606A326
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WxQjzyRc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJtqJ43N9z2xdX;
	Wed, 04 Nov 2026 03:11:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::234"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793722284;
	cv=none; b=OarPmJEOSCY8ue89RAwiIpEO3PdAWP+RXCVtaPP863xuiDwOysXwzdPg1QorEbxY1gbpC6MEiLSvpSXp7ErcslmKULeC2VRCgkv5MOV9ceiA3pCS06bT+4kVSIAK46dXViHs6W/TQI8o7A+fehiXFNCO19wqQ7DRJrrwf+tSd8u8Ttqw6W40y6VRz4xh8+W9mZJM6As1S0adPxEH1rxH43johBPBQkgi0W/b5qckBTwqTxNLy2qR8ho6r4BzTTCPAxkaBAgIVQhoSJdJO2790/T7q//aAN7TONG9cCfAAHDZu+6JfvqRdOw2EMsbYkIQIRwF/qkuOjnySN9AZO6HqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793722284; c=relaxed/relaxed;
	bh=acYk1wdTfJFTPT2zxMP3Y5i0dH0kUe7R3DKFdNTib58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxH1mJyHPtzwvIMi+tQui3gFi3xjxSymuJndnHYtdGAjjyNSUIJpR3xSw8QLcUnczbLhNLcq4eSfftiX9bLWcBgSC9zKmgoaImYemrGOBO7GYFSJxjbXqWeVKV9/yNc4OUGq+p5EOikQo5Kat4IU45iGnOHRcs8HfAXt1JpYKUzVJ/Oyt2kAEiyEZMy0MxACbblTR7i0nhECQ1tkJHZezCBLISpG9vjr9ItxYo6fSuACi7HWb7LPBysdcChOErL5EkNy5A/mikJ/EczpVXg/L00UB/BWrohNuKNxIqq358g9YJnT1wlBR6EKKZTb8JYK+gKp5vZWa9t0UPnyrd2Z9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WxQjzyRc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WxQjzyRc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJtqH5TBBz30P3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 03:11:23 +1100 (AEDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-539a57a0b1fso1514213b6e.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 08:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793722281; x=1794327081; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=acYk1wdTfJFTPT2zxMP3Y5i0dH0kUe7R3DKFdNTib58=;
        b=WxQjzyRcD6Zic0hA1JPCP1FucThYWKnTRbUHf1/4f4pfYSn4K5Fa6qwm9JgkkVdAtY
         8JKFKfpxeSJmEGGMxuMJ4TuoD1Nzo6nXYfFDoHj/bzH+BKgjFENFG1rsqCgYaXR8AzlD
         1NfXyKVnqDv+CvElgBchMaEULVlL8GGcXi258=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722281; x=1794327081;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=acYk1wdTfJFTPT2zxMP3Y5i0dH0kUe7R3DKFdNTib58=;
        b=RR+web8bJUW3m+zbqcxb3kOnmvUKBbe/BdYjSR8H6kOXd5iM6NM6Fb5rYdF6qisPyJ
         b07exEsRtFO/ptU4+Q8Fcejprp8kJ/gx5fjJiiZGWA7UFi6AFU6twMLR8Jf/OIX6m+tH
         N4M0Wi6Wf0oQMn9hm31v6G4BQAOMYKy8HdN388c6dUZQLA92CGZOO3obdAX/cBlxpC0m
         O35fmEvRmCo0lg+DjulQzTNOgtQbYK7aRtmdfM9KnfxfAqU+6czNiV5BiX63RSwSXn0n
         eVhm48U8s49BM54FPudMoAcdKoib6XZD149sc8lCuB+gUvWd+YF/PntLDG/79YrVKPQp
         QpjQ==
X-Forwarded-Encrypted: i=1; AKwUvByuesFl8PGhoc4e/RGvfyEdHbbj4ASTW6EZUPVfPH6oCf4LvUq9JFjuc/QRPyV3UzSQEgKq/P0/lm/+E2o=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8CR3WFV8+dQM7N+ngjBX3CXRCBUoy1WOZv9IqvDjj5vYaMKq5j
	OshzwkcuaIb0X2cBqSxQDpgWwaOHWJFjCSWPDXZQsIIkenOUzpnybtRvuyaNbapsYg==
X-Gm-Gg: AYBFou3OgyNgfy6edN8ZxAPrtANvM1tNDj/WmmaXOAqG2y3Aiz6H2zdSrSLpVyDnJOD
	1GhTJSoIUatXUtJwNobJm2oZdpDcHINKjKuTcPCmslOcsFOTJZAaRNZ55SVUoHo/SVP1yfylTco
	VP7fNQT91vaswV4XhIIIBKmN+HXcpqduVFtL02S33KIOozpm14efwbqUegA73FJLQ1Eo32QZAGk
	VWqZTUADjusIrlw8qTvw0fGYQxNtSmEZcbjWzBO4mfJ5ComQ7Uhv8f/wda74oVgTlrn9KO3WvhR
	YXRPRrYllfAu7Z23fx4DTW74cLne9kqmA2HXZDj5X1EvFVTFbB5ZmLlvJOSJJqzVRHYZec47Jvx
	TT172ixR48w0wX5QTbOwDjbqDnoecoAd1+BG+rKYM4CHlunqPhLYgTHWsuChxynmkpbEfXAyLFL
	fe3z8+uu+krW3s4X+a2DJVqIjxrbzrZjHMWGegn+mOQC+kI2HyL8vM/gdzJiHgN5E99jcbfQlfh
	48Xfxm1unbEZD3vNFDcIEItr/epjrWrfL/okTsTJlraF6HeKaJn+xXjrxKmCXfozdU+S+WTOSBe
	4jpLwsnshim5+4B3OWWRqNiDGcc4XmDALrCudU8LA79GOkUecANxz2PMI1RFFh5/3MRD2tzdL6o
	8+lyeTJBdVfViL+Y=
X-Received: by 2002:a05:6808:11c6:b0:4f4:b5ba:a241 with SMTP id 5614622812f47-5640dde805amr8598864b6e.39.1793722281085;
        Tue, 03 Nov 2026 08:11:21 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95dc0sm11688383b6e.6.2026.11.03.08.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:11:20 -0800 (PST)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Timur Tabi <timur@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 7/8] serial: 8250: retire canceled RX DMA before reusing the receive buffer
Date: Tue,  3 Nov 2026 09:11:03 -0700
Message-ID: <20261103161104.2449407-7-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-7-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-7-9159caade148@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi James,

Thanks for v9 — fixing asc_startup() locking in Patch 2/8, waking
tty->write_wait for drain waiters in Patch 5/8, splitting OMAP RX locking
and IRQ quiescing into Patches 3/8 and 4/8, and adding rx_pause_wait with
immediate wakeups from dma_rx_complete() and serial8250_do_shutdown() all
look good. Waking rx_pause_wait under port->lock cleanly avoids delaying
normal completion or cancel_work_sync(&dma->rx_flush_work) during shutdown.

Two remaining comments on Patch 7/8:

1. Escalating to serial8250_rx_dma_recover() after a bounded pause-stall
   window on partial RX transfers:

   The commit message notes:
   > A provider which never pauses or completes retains RX ownership until
   > an error or shutdown; a timeout alone cannot establish that discarding
   > the buffer is safe.

   I completely agree that a timeout alone cannot establish that *reusing*
   or *freeing* dma->rx_buf is safe while the channel is still running.
   However, calling serial8250_rx_dma_recover(p) under p->port.lock once
   the retry budget expires does *not* reuse or free dma->rx_buf without
   stopping the channel:

   - Calling serial8250_rx_dma_recover(p) under p->port.lock inside the
     worker's retry block sets dma->rx_err = true and
     dma->rx_terminating = true (and keeps RX masked in UART_IER), which
     causes serial8250_rx_dma_flush_work() to exit the for (;;) loop
     (retry = false, recover = true) and call
     dmaengine_terminate_sync(dma->rxchan) outside p->port.lock in process
     context (8250_dma.c:233-239).
   - If dmaengine_terminate_sync(dma->rxchan) succeeds (ret == 0), the
     channel is stopped and its callbacks are drained, so clearing
     rx_pause_pending/rx_terminating and restoring p->ier safely falls back
     to PIO ("RX DMA failed, using PIO\n").
   - If dmaengine_terminate_sync(dma->rxchan) also fails (ret != 0),
     lines 235-239 already retain dma->rx_buf and return early with RX
     interrupts masked.

   Why does this matter in practice?
   Look at drivers/dma/tegra186-gpc-dma.c:
   - Line 1521 unconditionally assigns .device_pause = tegra_dma_device_pause,
     so dma_get_slave_caps() (drivers/dma/dmaengine.c:614) sets
     caps.cmd_pause = true and serial8250_request_dma() enables RX DMA.
   - On Tegra186, tegra186_dma_chip_data sets .hw_support_pause = false
     (line 1351), so tegra_dma_device_pause() (lines 420-423) unconditionally
     returns -ENOSYS. (On Tegra194/234/264, tegra_dma_pause() at lines
     389-414 polls TEGRA_GPCDMA_STATUS_BUSY after setting
     TEGRA_GPCDMA_CHAN_CSRE_PAUSE for 20 us and returns -ETIMEDOUT if the
     channel does not pause.)

   When an RX timeout interrupt (UART_IIR_RX_TIMEOUT) fires on a partial
   transfer (e.g. a few bytes typed at an interactive console or a short
   command waiting for a reply, count < 4096), hardware transfer completion
   will never occur while the remote peer is waiting for our response. With
   an unbounded for (;;) loop:
   - Those partial bytes in dma->rx_buf are never delivered anyway (even if
     we wait forever until the user closes the port, serial8250_release_dma()
     terminates the channel without copying dma->rx_buf).
   - UART RX remains permanently dead with RLSI/RDI masked and never falls
     back to PIO.
   - serial8250_rx_dma_flush_work() holds a runtime PM reference
     (guard(serial8250_rpm)(p)) for the lifetime of the open port.
   - On 8250_dw, dw8250_idle_enter() (8250_dw.c:151) sees
     serial8250_rx_dma_flush(up) == -EAGAIN and silently aborts
     dw8250_set_divisor() and dw8250_check_lcr(), breaking baud-rate and
     LCR updates while rx_pause_pending is stuck.

   If serial8250_rx_dma_flush_work() escalates to serial8250_rx_dma_recover(p)
   under p->port.lock once the stall threshold is reached (or immediately when
   dmaengine_pause() returns -ENOSYS / -EOPNOTSUPP), dmaengine_terminate_sync()
   safely stops the channel before any buffer state is released and the UART
   recovers on PIO instead of wedging until close().

2. Minor nit in drivers/tty/serial/8250/8250_omap.c:783-784:
   In omap_8250_shutdown():
     WRITE_ONCE(up->dma->rx_pause_wakeup, true);
     wake_up(&up->dma->rx_pause_wait);
   8250_omap uses its own synchronous omap_8250_rx_dma_flush() and never
   schedules rx_flush_work or sleeps on rx_pause_wait, so those two lines
   in omap_8250_shutdown() can be dropped.

Thanks,
Raul

