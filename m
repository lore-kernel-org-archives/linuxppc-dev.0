Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2142606A33B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IOZQc/+s
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNZmS2RHyz2xdX;
	Tue, 10 Nov 2026 03:21:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::234"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794241304;
	cv=none; b=F/cusx30YQpLnSoAy8K1O88nvcAXm7QJwbyzxUacXXWh3wgtp0MGNeJb4JgZU+kv8iXwngoiEWo2OBXCgs6aK0lVLOlcsGHCdMTh3Qb12ulHYl1oGdy9qvL5o17tJ88+7qlSOmSqXZY/lci1e8z52mLvLEMBcLmhG8VplpBgl+WuXEfa2M+tbBPS4EQrql7YaKLnLw+lY2AEhETnSHW+kK6/rrhRVP8Ey3q3YYdSFrUjBbwGx/Cxl+0gXFhBFNBq8+49kh3pF3BMAqvEryQKBa0nk3R0bCv+JHDCGo3BnAfZXpaUK8jMosFzshlqgkn7x3r4eqbP5k6M3xHMj23oGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794241304; c=relaxed/relaxed;
	bh=ATsD9Xu4uSt2b+wnr6JUehFjGprw+gnrB702q3SrL8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AND1y3YyvkpTa+m4RqRdNg01Np5bUbAdWddAErv6k4avVOlcuHeIu0W+1+WpVgzh4LcqJ+xGTlgRMhJfUfhzEbz+NX8gmfcHRjn7Sln4ZmfZ/oc8wNOpu2BXB5hss+tPIT8CVEsgXwcPujgLvq/3XI7SNZGk4gmrUwOY7OKW1cvDZPfylmfSSG3hJ2dpWruzpVOvHVwlirXSbHbC1Fo8vk1foql3EKjtsgqKi0BphwNZsKg3rV12Z4hBmufOPW+aEkqcqeLgoTkr0asKTse15k/S9yn7XTz8UkmuY9HDdCk6vmgZR2CtB33n/l0jUYKlENHCIhCsGJBDsIwDHxmUWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IOZQc/+s; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IOZQc/+s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNZmR09jJz2xRm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 03:21:41 +1100 (AEDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-4f66bb2ab57so298275b6e.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 08:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794241299; x=1794846099; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ATsD9Xu4uSt2b+wnr6JUehFjGprw+gnrB702q3SrL8o=;
        b=IOZQc/+s7k2f9mSowWX4WHvtstMPTT1IHW3HYnzspuR99VEi9ywv3Dh7XWcseR1dfR
         OypaXUtrca2lhgR+jK4eZ9Mr5YA7GOLKGuah+/qODqctdrm6/htydRJsdPHr3qVQihJH
         IWEHZ7rnbCUjCyYA1NesS/UnLunyMguC3fee8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241299; x=1794846099;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATsD9Xu4uSt2b+wnr6JUehFjGprw+gnrB702q3SrL8o=;
        b=oAznnY5GCZvxjeAsNPvboiTr9wXkrm5Pah+vb6w/xCMwbXViMfgSWySiyTrBkkrVSe
         VQkkC4mYVDid0G9LDntyXm5HenTR+Xi/1wPCyiFPJGzIOEvDF+Dn1u2s42+CA5yT4qtr
         BxybnK1IEEhjk1/8OmiyEXReJVcjlY6BLNb1ausuv7WIYIlW7nVmG/QyCPKg8H1SIHOF
         mE2hYpftRfZj6evAzKVUH441MpS9IetvZ97C63sLPAlYk6Pu9XAtjXSFiApO25M+lF/D
         uUJ5CRV81cUAZgeLGnFMmYAHyXorVw0a1wEbSwgUsyVcU3SuZShVFu+J1lM6Mry/JWq5
         j2mA==
X-Forwarded-Encrypted: i=1; AL+hErESw7wk+owmkTU7oji4waGTdQA4ZWqdXhiumvTTcT978t1iX1VPiB/7HYSVX03Qio+3nsXW2P44hF2vbJ0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+iSZmn/aaaXbDsPyDb0YdTdGriBwFqzGG9f5Nrl/gYHscIoqIH
	pwrLfBM6VIqaub6oFcLt/EEp8qXAo4TlAvvL9oDX/Ev4Em34RQiX4zuSwRC7ocrSdQ==
X-Gm-Gg: AYBFou1F462g8x0iM5y9LYGfWy7uO3jc139gjKpyDr/J82gET4iAPUweeYGh0Uatfdo
	/HnjMWPDBUBvdXathNDlp08oSS0BZMHzw0+NPJbLVhh0MpCCQiInfjrq8PrwukF4rpqog+0Nvc0
	a9jZoh42J8WHL0CefvmEiW8MDk1vTUo32zegwdGpOU/nAjy0mhmby6PtKhDSTF+/Dkyud8X/nVi
	ejL5GxjnBqMsPmN9WIfZj7zlsMs5YVTkZWD9vd1EntCrPSq4iNhwEJFl40uqJSTfSV22CljZl9e
	hZZvRbRebnCejjxOjO7SQlYYf0UqtcOWgGa9810Kc6uEFh6D08kEWFbIdW/Pl7JZYh5waxFsOQg
	HZzhxvWqftFQj9refoE7wdUBHMbNBeHMQVeh1UfJ+zUtdOd0jgSeHXBteEOXJ6OBmajvACtGNMk
	G1Pi5idJEvoOPNWrD2pSIB1lNTq425Zg+dHnsUIaCH56vNPEgUbbTKdTbdKGT4rqnFQ+MLKQYJq
	8U3GOOYuB47dkRiLaY34XMPmQvF7wW12i8A+FbB79UH+pcO8o1CsOCP93xA+I7yh55NEnUXeFbf
	kbyQWf+Ue5y9fyJ9jUZbaULSg9icTJ3Ia8hyxmrsapcax8pmk9hu9EkEfpVz8WpGMoXu1bgdN6n
	xwdAzWhthCYR1uxc=
X-Received: by 2002:a05:6808:159f:b0:4d6:90f3:74a1 with SMTP id 5614622812f47-5683ccd209amr89819b6e.44.1794241299242;
        Mon, 09 Nov 2026 08:21:39 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ade694062csm5510676fac.8.2026.11.09.08.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:21:38 -0800 (PST)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Raul E Rangel <rrangel@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v10 7/8] serial: 8250: retire canceled RX DMA before reusing the receive buffer
Date: Mon,  9 Nov 2026 09:21:34 -0700
Message-ID: <20261109162135.906262-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-7-e6227ddb95b1@gmail.com>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com> <20261108-submit-serial-8250-dma-cancel-v1-v10-7-e6227ddb95b1@gmail.com> <CADvTj4qXcOqS-wDrrN-x3sXUQr5BtFBeGzz_wqpW8WJ1DMPg+g@mail.gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi James,

Thanks for dropping the unused rx_pause_wakeup lines in omap_8250_shutdown()
in v10. Following up here on your question from the v9 7/8 thread:

On Tue, Nov 03, 2026 at 11:05:42AM -0700, James Hilliard wrote:
> For pause-capable hardware, a recovery timeout does not have to prove
> that the failure is permanent. The concern is what happens after that
> timeout: the current recovery path discards the pending transfer and
> leaves RX on PIO until reopen.
>
> Is there a recovery approach that avoids an indefinite RX stall
> without turning a potentially temporary pause failure into loss of DMA
> for the rest of the open session?

Yes — the only reason the current recovery path disables RX DMA for the
rest of the open session is that serial8250_rx_dma_recover() sets
dma->rx_err = true and serial8250_rx_dma_flush_work() leaves it set
after dmaengine_terminate_sync(dma->rxchan) succeeds, which causes
serial8250_rx_dma() to return -EIO until reopen.

Notice that struct uart_8250_dma already distinguishes a normal
post-pause async termination from an unpaused transfer that needs
synchronous termination:
- When serial8250_rx_dma_try_flush() succeeds, it calls
  dmaengine_terminate_async(dma->rxchan), sets dma->rx_terminating =
  true, and clears dma->rx_running = 0.
- When serial8250_rx_dma_try_flush() fails, dma->rx_running remains 1.

So we can decouple bounded pause-timeout recovery from sticky PIO
fallback without adding any new struct fields:

1. In serial8250_rx_dma_flush_work(), if retry is still true when the
   1-second retry budget expires (or immediately if ret == -ENOSYS ||
   ret == -EOPNOTSUPP):
   - If ret == -ENOSYS || ret == -EOPNOTSUPP (e.g. Tegra186 where
     hw_support_pause is false), call serial8250_rx_dma_recover(p) so
     dma->rx_err = true permanently falls back to PIO for the session.
   - Otherwise (a pause timeout such as -EAGAIN, -EBUSY, or
     -ETIMEDOUT), set dma->rx_terminating = true while keeping
     dma->rx_running = 1, dma->rx_pause_pending = true, and
     dma->rx_err = false, and set retry = false.

2. Derive recover from persistent state under port->lock:

     recover = dma->rx_err || (dma->rx_running && dma->rx_terminating);
     fall_back_pio = dma->rx_err;

   And in serial8250_rx_dma_recovering() (8250.h):

     return up->dma &&
            (up->dma->rx_pause_pending ||
             ((up->dma->rx_err || up->dma->rx_running) &&
              up->dma->rx_terminating));

3. In if (recover), run ret = dmaengine_terminate_sync(dma->rxchan):
   - While dmaengine_terminate_sync() runs outside port->lock,
     serial8250_rx_dma_recovering() is true (keeping RX interrupts
     masked in UART_IER and skip_rx = true) and dma->rx_terminating is
     true (blocking dma_rx_complete() and serial8250_rx_dma()).
   - If dmaengine_terminate_sync(dma->rxchan) fails (ret != 0), latch
     dma->rx_err = true under port->lock and return early so RX stays
     masked and the buffer stays owned by DMA.
   - If dmaengine_terminate_sync(dma->rxchan) succeeds (ret == 0), the
     existing post-sync cleanup block clears rx_pause_pending,
     rx_terminating, and rx_running and restores UART_IER with
     dma->rx_err == false.

Because 8250 RX DMA is armed on-demand when rx_running == 0 and
!rx_err, any trigger-tail bytes remaining in the UART RX FIFO below the
RDI trigger level are drained via PIO on UART_IIR_RX_TIMEOUT, and the
next UART_IIR_RDI interrupt submits a fresh RX DMA descriptor — so RX
DMA remains active for the rest of the open session.

(Regarding the dw-axi-dmac driver mentioned on v10 7/8:
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c has separate provider
bugs where dw_axi_dma_interrupt() clears CH_INTSTATUS across all
channels including DWAXIDMAC_IRQ_SUSPENDED, dma_chan_pause() leaves
DMAC_CHSUSPREG and chan->is_paused = true set when returning -EAGAIN,
and dma_chan_terminate_all() only clears DMAC_CHEN without clearing
DMAC_CHSUSPREG or chan->is_paused. Those belong in a dw-axi-dmac
driver fix, whereas the non-sticky pause-timeout recovery above ensures
8250_dma.c never stalls RX indefinitely on a pause timeout while
keeping RX DMA enabled for subsequent transfers.)

Thanks,
Raul

