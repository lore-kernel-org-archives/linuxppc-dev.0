Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8305C606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=J+8iALVC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFzPt4RwNz2yql;
	Fri, 30 Oct 2026 09:27:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793312866;
	cv=none; b=F8M7G/JtyyCsohcn2zDcSgSb+vuNRdrVF4fCzpJOOlydcHDPKLbCttIYPx0s2+rEPBsuH2wcOjMz/sxTPyyx/lIHTTog83DKUtub3+zBe2Vogq8gYEzng2KGT4bomzNdnZ+GRt0jGny43XPuxBDbz0S1m08C4mMyXimudy9VmIBqTG1kpE3BNtQ8RHFYMKoEQ7BozbvA1b/j2Bx3feXeDUF6cAdpJJ/ZE3WYPpNyunner0oKAVFPbmGKzMD0KgSfsfV5gboR5NgiAZEK9UzJVkULZUqOq+bWQZOjsOI3ZDkPBXPRt9mYKBl8vDwOyan+TfcPzb9ZpYxvrBPLGLu5Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793312866; c=relaxed/relaxed;
	bh=XxsrJQyS+nOjzlF7/QV42KG9lGt3qkw3rRZfnV8/yI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTeILRp5mZGWhmw4vLJL8k8zXZNrwRHv9rljCkdHfCTngIO22Ks7ahnB9EHipmmmdH4FlqBK2izfFPPT5ve6yteR5l2s93BarS7VfoedfOdOz9S5GmdeIwtKqouoyd02KRbxr+CPs7OCliReAjJFtLBprateeQ9qCSqzzSZuVml9tT7/hFzX5YY646X3VUta52Wp2eq2sw2C7VmZaZhAd1dyuTc3nGJk2CgxuVyhLh0NkAZQEO2eKgdhw20O33xAlJirW3vfd2Us/tmpr1xZz1m+wVPN9TWbJBYHoMxRPRPustzjPJoxf+gkD7tfka3TSibfXq5CAJxSpc8cLMvx+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=J+8iALVC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=J+8iALVC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFzPs0JZLz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 09:27:43 +1100 (AEDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-7f48c750afcso113899a34.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 15:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793312860; x=1793917660; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XxsrJQyS+nOjzlF7/QV42KG9lGt3qkw3rRZfnV8/yI0=;
        b=J+8iALVCkDPBF5/LhdjJdH0gFLfLuAL7k65A3ieKpmJZrtRrfGqpdFBTpeySbRXSMx
         7fmqbjPeiBgsr5+sPQLGogkKH6JKQs5HVV2q1X1qJ+ePIgUvvxZuAaAdqD9pHViXu/jw
         I5UW8Pj/Zvuzxe7jtHrSHXO/DUBk43pECOo7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312860; x=1793917660;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XxsrJQyS+nOjzlF7/QV42KG9lGt3qkw3rRZfnV8/yI0=;
        b=AqvRj92d7l+jwqWDf8wprqCGkAzZkj2GHBfNJjJ+2o2g2iuB3fkFl5IHDH4EmtxoE2
         kNGGVH01K1RHFWIXS99hkf6clSiIDhbqXyGufo2sldA5E6I6Coy+rqOWtnIMBGpK1wvk
         ti4tgpUtCr8R0O1DqOZk2Nssi3ilcbEs9uXqH1mjmKyq+mYU5iIOIAWVgB+vlPlyxwVB
         tuYUmxax+rKBVKR7ROIawky2npX31m4zghvFI63MC7EJ6YIrdVZ56BQS6AvGFqVqmD6y
         bRaLJddoDJtG2vttyNYX5ok7Se619oE4DmiCCscivozyW3WF7h+pMRslyP+G+k9I6qsi
         doEA==
X-Forwarded-Encrypted: i=1; AKwUvBwjTEpZTSbxd2anJF2hOcVNCNFCPrgSjqoByCjm/AOdXb9D0S5Hdhc2PVxE8S29holITXLucQEO8U7W1Qo=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYICje8I1h4FMN0i7lKoYuj9DY9ACUzMVVkSWgCqfgCrn5GWo0KS
	UqazEWBgbUtkMKRfR0NFVTWEoNZ2dLUH3IzdWVDAqexoMEy/AjOKWrPqhLhUIoc9Ew==
X-Gm-Gg: AYBFou1yd5rLkQO/SxqYQQ1eU91eKjt+8gO/AimMnuG7Yp207VuLlkwwbgzTLxECndq
	KDTmOODz9vxLvNWJO+zHYW5iC5DBU4Jd8HKIOnIZz1d02lSeBJGYhi0pOwonCcAE2eB3oDs/8PP
	pFgV4hzO9Vc22jh3lWfL0BKLpjrHmFaRUuMwDLMs5lDmkt4no2YzeltN+JYjm0ycS/iz4fnYN56
	XAC3pFS7/ohZ3BGSZgCLQ+a3Sc86vwO9kVfPQfM4Pc0A3XB2FRQjxjBGE+KFiM9ITaRkrtUG1En
	cKZfi9HZiTOLc4kOet1ArLjBTmKfJc+NgxbKA8O9yrF1xULpb3Y+0keXkrhK+HvHfkErxDI/ylJ
	IN/SJ30rQrxtKERLHnIp9H8kEEqPDjATSUYT6vDCWpDY/mgbkNhA+AhwmH9z32x3bfP2XWQ1tXw
	bKlu6AcRVOp1hDzc45m9mCz4bjLOLQqDwJYjKv8vwD21eD6Uta9Er7rBL3+N3omZyGorAfmuPCS
	DKGbCDCdjS0SjLaH9N1/ugf3p2wz7Aq+kIN+5l5SFIwM96T9J8XNTaBQ6xrF3X3G830ZYhCPKm0
	Y381qnGiwk9H51N+BHkXP0Q8dpaW+7zopokur2KzzyX57P3KHKxWNfyYPqs0ZA6n2yL610fNF0q
	YOduwDvkjbS4JiQg3Zxz8pbUMSSCtTh4UoQNf
X-Received: by 2002:a05:6830:2641:b0:826:b77:adef with SMTP id 46e09a7af769-85d363b89f1mr545837a34.14.1793312860205;
        Thu, 29 Oct 2026 15:27:40 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3545b89asm718163a34.6.2026.10.29.15.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:27:38 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 5/6] serial: 8250: retire canceled RX DMA before reusing the receive buffer
Date: Thu, 29 Oct 2026 16:27:33 -0600
Message-ID: <20261029222734.3086943-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261029-submit-serial-8250-dma-cancel-v1-v8-5-3fd56ba352ed@gmail.com>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com> <20261029-submit-serial-8250-dma-cancel-v1-v8-5-3fd56ba352ed@gmail.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi James,

Thanks for the v8 updates and for opening PR #1 on the TLA+ repo! Confirming
that the v7 issues in Patch 2/6 (lantiq, dz, zs, jsm_cls), Patch 4/6
(__dma_tx_complete tx_running check), and 8250_omap.c shutdown locking all
look resolved in v8.

On Patch 5/6, we updated our TLA+ model for the new rx_pause_pending worker
retry loop:

> +	ret = dmaengine_pause(dma->rxchan);
> +	status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> +	if (status == DMA_ERROR) {
> +		ret = -EIO;
> +		goto recover;
> +	}
> +	if (ret && status != DMA_COMPLETE) {
> +		dma->rx_pause_pending = true;
> +		serial8250_out_IER(p, p->ier);
> +		return ret;
> +	}
...
> +	for (;;) {
> +		scoped_guard(uart_port_lock_irqsave, &p->port) {
> +			if (dma->shutting_down)
> +				return;
> +			if (dma->rx_pause_pending && !dma->rx_terminating)
> +				serial8250_rx_dma_try_flush(p);
> +			retry = dma->rx_pause_pending && !dma->rx_terminating;
> +			recover = dma->rx_err;
> +		}
> +		if (!retry)
> +			break;
> +		usleep_range(1000, 2000);
> +	}

This cleanly resolves the race where a full 4 KB transfer completed in
hardware just before dmaengine_pause() ran while its DMA completion hardirq
was still pending (once serial8250_rx_dma_flush_work() drops port->lock and
sleeps, the pending DMA hardirq runs and marks rx_cookie as DMA_COMPLETE).

However, what happens if dmaengine_pause() fails on a *partial* RX transfer
(0 < count < 4096 bytes) during a normal UART_IIR_RX_TIMEOUT where the remote
peer stopped sending and is waiting for a reply?

(In PR #1's Serial8250RxLifetime.tla, Spec puts WF_vars(ProviderProgress) on
Receive at lines 67-70, which forces the remote peer to always keep
transmitting until count == Capacity and CompleteInHw fires.)

When the peer is idle after sending a partial burst (< 4096 bytes):
1. Hardware never reaches 4096 bytes, so status remains DMA_IN_PROGRESS
   (neither DMA_COMPLETE nor DMA_ERROR).
2. If dmaengine_pause(dma->rxchan) persistently returns an error (-ENXIO,
   -EBUSY, -EAGAIN, -EINVAL, etc.) on that partial transfer,
   serial8250_rx_dma_flush_work() loops forever in `for (;;)` calling
   usleep_range(1000, 2000):
   - It holds a runtime PM reference (`guard(serial8250_rpm)(p)`) and wakes a
     system_percpu_wq worker 500-1000 times per second until the port is closed.
   - RX interrupts remain masked in hardware (`rx_pause_pending == true`), the
     partial bytes are never flushed, and the port never falls back to PIO.
   - On 8250_dw, dw8250_idle_enter() gets -EAGAIN from serial8250_rx_dma_flush()
     while rx_pause_pending is true, causing dw8250_set_divisor() and
     dw8250_check_lcr() to silently abort baud-rate and LCR updates.

Since the only reason to retry pause/status is to let an already-pending DMA
completion hardirq run after port->lock (and local IRQs) are released, could
we bound the retry loop in serial8250_rx_dma_flush_work() to a small number of
iterations (e.g. 5 retries)? If rx_pause_pending is still unresolved after the
retry budget expires, calling serial8250_rx_dma_recover(p) under port->lock
will set `dma->rx_err = true` and `dma->rx_terminating = true`, letting the
worker exit the retry loop, run dmaengine_terminate_sync(dma->rxchan), and
switch cleanly to PIO.

We pushed the updated v8 TLA+ models (`Serial8250RxDmaV8.tla`,
`Serial8250TxDmaV8.tla`, and `./run_v8.sh`) to:
https://github.com/ismell/linux-8250-dma-tla

Thanks,
Raul

