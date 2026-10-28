Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BFA606A323
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UbVBrSt3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFKdj077zz2xPb;
	Thu, 29 Oct 2026 08:05:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::233"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793220536;
	cv=none; b=MLDBtdUeawdOaWUlwtoWDxcn/gDoyIlA4nDTdEPGxvTQnBMA6tGdqKlQd+ytFVlQd6/IetnJ52aDAiuiVEmXDuKp07mID5KrjVaO9FeTeFzzZStg2De/iotkxsScccvP9ztGoQzteOK0B+PxvOYJWlGHxTc8N01V6xk4SkadzxGlSCLWSs2TeRHyTWTlFlKK51G6ZypUEO9rFjbEzUkevbfzXRyyqpCItfqfY9kGbw3hdr6IVW3zraLMSQyv3Kh5fi2R6CfOH6qaliF0QHNdA0dZWHO97hntqajpLMZA73l78ug7tcGw4EtHsRGnpQuQgGAd3031Rv7BBrkUaqtw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793220536; c=relaxed/relaxed;
	bh=KlFs5O5F58aRmAuOBc20ZN5pSWMjbwV9elx9B8mpSCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlXf8eMgFGeG0BTBAqYoROoroshNgQ4Ubu7pCRSTgVq6PWkI+/MjAO7P8E09rtX8FN/XwGQcQWCKQ+ufRwRb2+HKIrtNKGcuDA1cQZNXQekmpFPRpEjRGw/P/1p7Omyrmy9E12YYDMSQtrKIiOxxA7FAgnlMpg2JqydvTYs+O3KXES8+L8nLAGqhDczS7Vmn2Gg8BdlsdKZns4hBYUr2giOwXgdaMiol9P3YRSuD8qh9TJIjQgLvMomxCTZyMgU074e7xgFQiQkKJQalUeQ7zz1wrpydkwMTvah0tPpoY83K53oCCZQqvJZqWwk7jlTR/Xl8B8cHM2sLMa8MxiVYUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UbVBrSt3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UbVBrSt3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFKGH4YGxz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 07:48:55 +1100 (AEDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-4d7034a99a9so864920b6e.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 13:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793220533; x=1793825333; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KlFs5O5F58aRmAuOBc20ZN5pSWMjbwV9elx9B8mpSCE=;
        b=UbVBrSt3IRLk2FsVsy0v9CBiBS+FplvGIicYXPIIggC8wfz1oTTxqyv3Hhs/5fHyMz
         0CH2GO8Dc2dj++4jLHOoxYClBgbTdhZ9lS4JYc7LxZ+wvqSNMiDkX+AlM5fwP6ajBQBH
         zmgAL7sLyQvF5NYXKZDUB+wIO+1exiVI7WI1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793220533; x=1793825333;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KlFs5O5F58aRmAuOBc20ZN5pSWMjbwV9elx9B8mpSCE=;
        b=AppMCL9GmrnbAiBXdJrFWsRadwUs5Qh5Y5+egk5iiH2tQhcAUqPib18p8f6JwpFZ7H
         yBsF2/9rkgdZ3BgsErE9e833VACIouJehVIOKx/Otswr5xHs7Pd04E8+Q7EOOHSE1C6s
         e+qj2AEK1p1iM9qzEUtvJbkR8xy8QtLzddMov87Jxse2GHAZ/ESqZx6Q/ANtp9IHaRQD
         lB6DpjTsxMvPMdtBJjkyL2pUK9iRKmZPF5rPMbhYiegvplwpqo5FeHt8oRSYQgSzk3g5
         7GHVRQH3vMdsgbUVk0gjh+do5X61FdLIc2GR56SpjErgwItFEzKtLyArFmOn4SYDdzuI
         cs8w==
X-Forwarded-Encrypted: i=1; AKwUvBzcJV/lsWF9W/9JR+2RfhPlyxKrhHaUy2JB0pY1sK7x2udx9mt5Bn4c/4Qn3bhAueJZENrU3u6gd3AHSjg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ908IgvnQj3y+eIio2BuY0R+cpcUbaiFHhbuhbm16VSA7MUdkG
	QQLorHD2SE5eG0P1N48dzw2l8ZIaT62goPit16+i+79jnZZ8BdPaya/nEHgv7trZhA==
X-Gm-Gg: AYBFou1V/0MHy5cReo4LfuvIZum0v2vuleJqIhocqv21jMzCdFB/PNuQuKaFFvrqtm9
	kKSQ0rQ08zscG05JEAfrOI2sk0VaNxuNE7ruAwuQY29AGcAY3d/wQnLfhN0GQXhgMmZg/zPO/Y1
	4QRouboJ8Xa1ugnJEVPqlTQJZzJkO/MmFH964t6O0/LZuQBBUrehcDq7eeLL15Of07tIPtJWIvF
	aw19+a5hhcfK3RDbjATWMvWfkXoZ+VfgLqcUVVS6aAAgAa/QRzgil6QxPdJAylDC4juS83iOUG8
	rIb16k5pBwzYVwkubIm0XFfTeBoV+az4fO8RJxBdgKNilhgN411HP3vatBGUK0XKhi8WE74nDYO
	tY/0ryR3v2AMnokCSpl5fkPRiKm8BSJqlnvKrmxop+8aoDGdo7jPBp5B+P8BWNG3LvBj7YzkTgS
	qThlue8YfDkI3oQxRfuMWC9Qm9bYJir5hMfxfNGEci/fZyylutD7B0Henrj8h7dq5DWP8WgpVwn
	Jl6Uy0OjYjOv6f9hC9ot1qX5iy5uucil0kXt097sbQtHcrJVUWtCY5FjckluMUmryHCSrmPhL39
	3bmdQMoPjXm28EC+7Ct6Doxl6lIkrO+qO1l3IeXEYTw/M0f2PUBI2MGYjv3inSRLfcabX80iOhw
	Nri+QwYw2a16PscvRZw==
X-Received: by 2002:a05:6808:4fe6:b0:4d6:90d3:e18b with SMTP id 5614622812f47-56383e93e14mr3396274b6e.52.1793220532771;
        Wed, 28 Oct 2026 13:48:52 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (202.168.136.34.bc.googleusercontent.com. [34.136.168.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c363902esm2281137b6e.2.2026.10.28.13.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:48:52 -0700 (PDT)
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
Subject: Re: [PATCH v7 4/5] serial: 8250: drain canceled TX DMA before reusing its buffer
Date: Wed, 28 Oct 2026 14:48:46 -0600
Message-ID: <20261028204847.3471382-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261027-submit-serial-8250-dma-cancel-v1-v7-4-985a023ba4b4@gmail.com>
References: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com> <20261027-submit-serial-8250-dma-cancel-v1-v7-4-985a023ba4b4@gmail.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi James,

> @@ -37,26 +40,35 @@ static void __dma_tx_complete(void *param)
>  	struct uart_8250_port *p = param;
>  	struct uart_8250_dma *dma = p->dma;
>  
>  	guard(uart_port_lock_irqsave)(&p->port);
>  
> -	if (dma->shutting_down)
> +	if (serial8250_tx_dma_blocked(dma))
>  		return;
> -
> -	if (!dma->tx_running)
> -		return;
> -
>  	serial8250_tx_dma_complete(p);
>  }

Removing `if (!dma->tx_running) return;` and relying solely on
dmaengine_synchronize(dma->txchan) to drain completion callbacks breaks on
DMAengine drivers used with 8250 UARTs that do not implement
.device_synchronize (where dmaengine_synchronize() is a no-op), including:
- drivers/dma/sun6i-dma.c (Allwinner H616, cited in the commit message)
- drivers/dma/dw/core.c (dw_dmac)
- drivers/dma/pl330.c
- drivers/dma/mediatek/mtk-uart-apdma.c

On those controllers, if Transfer #1's completion tasklet (vchan_complete,
dw_dma_tasklet, or pl330_tasklet) has already dequeued the completed descriptor
on another CPU, dropped the channel lock, and is waiting on port->lock at the
start of __dma_tx_complete() when uart_flush_buffer() ->
serial8250_tx_dma_flush() runs:
1. serial8250_tx_dma_flush_work() calls dmaengine_synchronize() (which returns
   immediately because .device_synchronize is NULL), acquires port->lock,
   clears dma->tx_terminating = false, and calls serial8250_tx_dma_complete(p)
   -> uart_xmit_unblock(&p->port).
2. If no new transfer has started yet (dma->tx_running == 0), Transfer #1's
   in-flight callback acquires port->lock, sees !serial8250_tx_dma_blocked(dma),
   and runs serial8250_tx_dma_complete(p) a second time even though
   dma->tx_running is 0.
3. If a writer has already started Transfer #2 (dma->tx_running == 1,
   dma->tx_flushed == false), Transfer #1's stale callback runs
   serial8250_tx_dma_complete(p) while Transfer #2 is still active in hardware,
   syncing tx_addr for CPU, advancing xmit_fifo by Transfer #2's tx_size, and
   submitting Transfer #3 concurrently with Transfer #2.

In addition to implementing .device_synchronize in the affected DMAengine
drivers, __dma_tx_complete() (and omap_8250_dma_tx_complete() for symmetry)
should keep `if (!dma->tx_running) return;` and check
`dmaengine_tx_status(dma->txchan, dma->tx_cookie, NULL) == DMA_COMPLETE`
(matching dma_rx_complete()).

We modeled the v7 TX and RX DMA cancellation state machines in TLA+ to verify
both the counterexample traces above and the fix:
https://github.com/ismell/linux-8250-dma-tla

Thanks,
Raul

