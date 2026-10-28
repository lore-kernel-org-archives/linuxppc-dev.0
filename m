Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8395F606A320
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XMx5dwV9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFKdv5QlGz2xjv;
	Thu, 29 Oct 2026 08:05:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793220539;
	cv=none; b=m65TN9hg9o5NYDr6edfqcyBzgcczzJ9vcSqafl+t0mpnx5U5idnY3WQYK8vW+DAtbiI8qcnp1Jzq2rIAWse1nyJbmQYhHSAMCFGwyyaie8xkIhQ+EV2AVPiuiu21x8/2fMG4JMXEcwYj0LJBuJN+u9WVHO/99WG/ednKOtoYxtxUwpK57+u8J9p221YLzJNC6B438FrdmyAdWKm+6H1ovfn/27BVJ9pYxLky3tOdljU1i1FUaZxtOrY1fvSAXxNXWGtZqSWX9xriBA8xS03bBY0ajh5p2UskwGiSF0JkfiMgBX5i41izVqs9bXTrkFmmEnc7cyc6Wo/w5kdvfesm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793220539; c=relaxed/relaxed;
	bh=vc9uFw9UVF1A8RYaaUz33Ia3H+vJB3EZ/DUe+0FMK90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMw3x3QbUcYb2FMel8/rK7JuHjkk0F5Mu9epHkN/E6TaA/NWOgz5CKAFjOe6S2zCd0rbSf5xbI1Cg5rpofJo2mQUK93And9Ii3dKmuUlEbveVjiVgeuD80+kxDYblXvmt9tDJyIm6nIc7VXZ0xMYHvOE2INanvI3+Jwcb2IFS1v2EOcnGlYi0+aHBllFDoxv3QMknoXveXIH74IxgKHhDeBwzQbois8Fk4kcf3e8McNikg5PnJtSObjAOaXAIy+UauL+ayEKGOrfE2Cwrf6eNxotc7I3ADCh7CMCYZnhWFwfeZgXzgjEOu0r5ogONHU6YSAxGi2vPFNwBMPktv6B6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XMx5dwV9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XMx5dwV9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFKGK3w2jz2xQs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 07:48:57 +1100 (AEDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-4b28d7c729fso813284b6e.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 13:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793220535; x=1793825335; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vc9uFw9UVF1A8RYaaUz33Ia3H+vJB3EZ/DUe+0FMK90=;
        b=XMx5dwV9aXooYwDk86ldOU/g7tdnZDDNP3t6WA8QTjSuWa2+Yzx5LMuM4MGseOEZs8
         5ubaZGW3OlxV72dlvadn11u81N41Q21zd+z6ctxTos4Wdeh1wXeqlI7D1OsnAUKbYSCd
         24Puxe7szdxrzRaDqNDohKvfrMQa3Kt4vhMVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793220535; x=1793825335;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vc9uFw9UVF1A8RYaaUz33Ia3H+vJB3EZ/DUe+0FMK90=;
        b=tqGE+KInQvyEj0M+LT4WzSFr/fBhFoEd0EX2IPSjR86Lbb1NL89kRwihAf0gVVFPvQ
         gXFes0/VZqa9+B1cHRRzyUcbmIbuLMMARbZfV3pWYT7A68ejw6xuf8cxFwSnykb4Vgx+
         lGVc6eFamKE0vm82QyR4icZ1KygviHR0JQwHTkCEK4ET1Qk8KfOYonolHldjnxub7FZF
         AbiZxWc2ctbzVKPCeOvLlwzaPL2UG5sVvs5eLdlLqQNRgDkWeecAR/F54p0OCL4inUO1
         Bjysb5hJ40T8NHi7XsE3Ntiw+QF7h3oX7wuwPka2a4x7xXMQbE3sc6ItMGJ2E84N8z0p
         uHFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqtlxqIVlRL+PoJ2xM8k5m5YVZzIkWkvLiEhiYjVP8LAXOEdp2G0UF1nB+kDOPdYcSCzewzSWtKemf0lc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLm3ukLkLEy1K/iemZH85gW7LTOxeYql5J9rHlCRBNXii5kG3Sx
	QHuSifvrPADpGObHLi5aAsOdTonqXAHLD3C2K9v4wBkEEaF0XWoujoT+Y8Owlc5Hrg==
X-Gm-Gg: AYBFou3DBJoBEvRJnMssTW8alAJlvAb915CusIHbF2rROmbiMfeVZuBZaXxvVE7RLjQ
	LWUnArct2GAeUdOrKadsacKiQCwTVPsF4rq0dgCHu0Jv+PYZT/y522jk73MQ8Z47kmvKpdHa+dF
	pLPn/HEBNh1hmuJGTGm+k6r9iwns+/3W3UXPvxiG5Ak5IHlCucpju+yQ3J64pjCwqSgGqS7ytmu
	rLyGJA0r3O2qnKFBYuagotJmyZVJgqLpEh2bgep6uHbaIR6ZOCw/M/E9k1s0jTPR7gl0TDo+aaO
	DHgKX7jdsQmnFT2nRiXuTzmOH15hCiaEoCbj5QIW4fYLuoGlNiDoDTVAXhMfYscHDGognCHCMXA
	+XEIkO9jc/qtzlhGX+lJZhm/YmgmAQuwFLCoUbwOkX3MxfSHN96+PPVT9Lij9PJvhB+3zCGbAWg
	2NvV4qFIvjBeJtC7LnVlbF9orow1iOIuqSYNZQqlkkzHGaXhyuD5/cd2CbnOI0tMcnYZhWrvBkd
	7n1Qv1QQZ8C9FZAFM7CZUiqMesyAwBRiOAd/EaPawToPrXasq94ULd19/diDfRJIufiMP2RaVU5
	KYRjf1YGbANNmZ0O90mZx48b9QNLXPICn9j/kuL3XbB6PxbOmsYEEAag04uaZW3BHExfd97fwuu
	OKL/amliISbO/jNJitQ==
X-Received: by 2002:a05:6808:5090:b0:4c3:9892:96c3 with SMTP id 5614622812f47-56385c45dbbmr2597003b6e.22.1793220534711;
        Wed, 28 Oct 2026 13:48:54 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (202.168.136.34.bc.googleusercontent.com. [34.136.168.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c363902esm2281137b6e.2.2026.10.28.13.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:48:54 -0700 (PDT)
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
Subject: Re: [PATCH v7 5/5] serial: 8250: retire canceled RX DMA before reusing the receive buffer
Date: Wed, 28 Oct 2026 14:48:47 -0600
Message-ID: <20261028204847.3471382-3-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261027-submit-serial-8250-dma-cancel-v1-v7-5-985a023ba4b4@gmail.com>
References: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com> <20261027-submit-serial-8250-dma-cancel-v1-v7-5-985a023ba4b4@gmail.com>
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi James,

In serial8250_rx_dma_flush():

> +	ret = dmaengine_pause(dma->rxchan);
> +	status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> +	/* A completed transfer may reject pause before its callback gets the lock. */
> +	if (ret && status != DMA_COMPLETE)
> +		goto recover;

Checking `status != DMA_COMPLETE` assumes that whenever the hardware DMA channel
has finished transferring the buffer (causing dmaengine_pause() to fail because
the channel is no longer active), dmaengine_tx_status() will already return
DMA_COMPLETE.

However, dma_cookie_status() only returns DMA_COMPLETE after the DMA driver's
interrupt handler has called dma_cookie_complete() / vchan_cookie_complete().
Because serial8250_rx_dma_flush() runs under uart_port_lock_irqsave() in the
UART ISR, if the RX DMA transfer finishes in hardware just before
dmaengine_pause() is called (or while local IRQs are masked on the same CPU
before the DMAC hardirq is serviced):
- On dw-axi-dmac (drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c, used with
  8250_dw), hardware clears CH_EN in DMAC_CHEN when the transfer completes, so
  dma_chan_pause() times out polling DWAXIDMAC_IRQ_SUSPENDED and returns
  -EAGAIN, while dma_chan_tx_status() still returns DMA_IN_PROGRESS because
  dw_axi_dma_interrupt() has not called vchan_cookie_complete() yet (and
  dma_chan_tx_status() also reports state.residue = length for non-cyclic
  transfers until dw_axi_dma_interrupt() runs).
- Similarly, tegra_adma_pause() (drivers/dma/tegra210-adma.c:696) returns
  -EBUSY and omap_dma_pause() (drivers/dma/ti/omap-dma.c:513) returns -EINVAL
  if the hardware channel cleared CCR_ENABLE before the DMA ISR ran, while
  dma_cookie_status() still returns DMA_IN_PROGRESS.

In that window, `if (ret && status != DMA_COMPLETE)` jumps to `recover:`,
dropping up to 4 KB of received data and permanently disabling RX DMA
(dma->rx_err = true) on a normal transfer completion.

Also, on a related shutdown note in drivers/tty/serial/8250/8250_omap.c:
omap_8250_shutdown() (line 775) still calls omap_8250_rx_dma_flush(up) before
taking port->lock to set up->dma->shutting_down = true and clear UART_IER = 0
(lines 783-786). Because __dma_rx_do_complete() clears
UART_OMAP_IER2_RHR_IT_DIS and dma->rx_running = 0, an RX interrupt or callback
in that window can see shutting_down == false and restart RX DMA right before
serial8250_release_dma(up).

We also published the TLA+ model and TLC counterexample trace
(Serial8250RxDmaV7_HwDoneBeforeIrq.cfg) here:
https://github.com/ismell/linux-8250-dma-tla

Thanks,
Raul

