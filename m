Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8135E606A324
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Qx4FOf3d
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGSvd0TZQz30Vv;
	Sat, 31 Oct 2026 04:36:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793381804;
	cv=none; b=VYFjvHxH00xwtmTB8o25Aq3gMaConwWZPFgyr7xv3UdiQpK4p33Dl77FUP9H8msxHYyBBTUD2WaGnk6ASrEzNgWsUdumWtY8zzFrhOuMotRDisBVIPlNkYr9Z/kPiTpfydrYL+mkkqv9OpLzGGzaQ2RhM/KnOa3VJvOuYvpSUB14NJscqvyOuj2fQylmUreTc3jLgJjH9Vub55t9bVo23ZWYIpmrAhk05LLEpwVn5dUZQ60D7wUtZrL3lvn79dHgOJiOFW5vqzAKqM3Pd9qHwe62Fb80Fbp9dGM3LfkJwH3jHD27vmLbRIkACwpjAxUl4NUKT2Hfne+Uburv3irnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793381804; c=relaxed/relaxed;
	bh=r5fedtBZtI4w1DXYYWOd9TkcAOuj87FP9VlEYhTELuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4kTnX5RTLsoOxp3VfdpFGc28e9D4dbMCJZ4eI5COr+IAoHneOWAj8R4H10Hy3UvcLP8v5y9PKcvEYBtiuaYHdaLUuT/knaWjK//ihpgC3RYmXiz3sDDBfqla4Ovy8KXkNvg4SJeXMVVRHqBvM8KensSOkpDW8QKPm8va+1kyfdWoZnfktbuJ1+70F2UzdrFsVx36qwU2BmV90qJhBI44wslmnCH5QHWb5L8H+bpSO33vNXflQWvECBr265r/qXIMOuKnbqjlpY5/j8hhvqqGM2tugL56M2aXpfdTxYfkd3iffpTJEaHclt166a9YYemtKenfZQwyT7svcMd98m1DA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Qx4FOf3d; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Qx4FOf3d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGSvb03ZDz2xqr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 04:36:41 +1100 (AEDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-8479f46ecd8so450468a34.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793381799; x=1793986599; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r5fedtBZtI4w1DXYYWOd9TkcAOuj87FP9VlEYhTELuQ=;
        b=Qx4FOf3d9Taul13zQgVXsFa2HFQxpNMpsON4tuxrlFnyrnkJeI67Rzoz9NFiZcPimZ
         TVShler7CqYLo36H2sHbVmGJsJ6Mtqn6kMScjwv0BpJDaratgfoA8hHAsPsEKpcxvyg2
         Dp0NETnMZEJQ6TkYCl+MP1GJOlO5/NiI9xccw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793381799; x=1793986599;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r5fedtBZtI4w1DXYYWOd9TkcAOuj87FP9VlEYhTELuQ=;
        b=jViHWuD+Hi/zO8zyH90KBtsmff9tp9qE0hKZP1+6pVu6ULpkTDsN9SHdzCSuSK45gT
         X69fgHFYmDQ/XNTkfjT4PVSRr4EL9BHZDgCtquUD63sz4wXGEnrE9eJxuJ0UVWhC0us7
         i1t5vda7gp7DHClkPfjCKr4gDfZlPpTDO+CyJWTPvdlWHeipAFEsxzG42QlvOju4lIlg
         yAAxKTF03cA7YvjmPFTsJMU+ktEXwzj3w1SvzZ/tvvqjpuq7K5t2mUk6BeYZKbXl8caG
         2kswRrXqGpaqsVrcMNRAcOK18qNo7Tpu1RbMuMJvCrjEmmu9gFxly7YiurGjtlnr9cL2
         eZ9Q==
X-Forwarded-Encrypted: i=1; AKwUvByYbiXRzp9OX7bdqSvIds00uxfvFsjeITgYgqupVyRmhBLBD/nCIyiFqvFzdOPpJzv34Hi5Z0VDzJIt/uA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLvBtEsGNRAb3dhq2dPV+8dwzkzp/KX6ndJGYfquC9Ml+EqXc4I
	iSv18GKmIkfvr6dbY5L6vaUxA+NagoZRTyhlJO+1YgC+VsM137sZMTSox+EwQM+e7Q==
X-Gm-Gg: AYBFou3+jQoI8H/wlxzVVvUSq29zkWlbsa5kDIreyZJUniL2qdqYVep3zpvrCJ6w+U1
	uNJ8tRv2oiJ+o2zXHNdpyHAcNrP5NZTThgtuvy5dCad/PhPEaTD2WG8bTNHiw+FkwNKH+SciAgn
	bCd5ST1GI4FGPji72f+RFhF32uFlAo/+XrOdBo0Y2Otpo7S2teC/wIDkMUbBMZ+ZqCi81sjwXgX
	0uWfAdEAEA8jVHjnyYzHPK0akb8UTwaq+O2h72dHexcSmO0ORgR/cA9Wf3lACt2Jvno4kVacAXA
	MG9o2cCi2r5gTyrMUD5Kn8djg/Yu4hm+2rWnIQRztiiEITJ8C5cDVq2tYQtnuSkxrdzPH25Ura6
	jQGHL22D0Bs6HpVUHo52Zcnkct9/2sZIXJgQm9pEQJA0WP1sCo5g9jEeUvD43HsaNlYlkbRDSEo
	F+xTe9pom3i2OuZcwqpBW+Atyn2OXVa9/IDVw4AxKd2cCikR4WCGq1Z3QgfQWklC3F/wyj8cv56
	yamI0oLXnRl+ciSGn9F5lIB063/dSQjyPNB1CF6H257OKlWd68PFmwkBg63bs91i2KYFTIHnglU
	efuUKCCrGDXnehPqDah7oEv7Xqq8y7Z+K1IzJaxJbQOS9jTZQc2QpyGcBSWQYcLdcgDdDdn445w
	wck83elaYiV/EAZU=
X-Received: by 2002:a05:6820:625:b0:709:529a:4775 with SMTP id 006d021491bc7-714f6e7ffc6mr1212713eaf.50.1793381798577;
        Fri, 30 Oct 2026 10:36:38 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354efebesm2497044a34.19.2026.10.30.10.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:36:37 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?UTF-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
	Pali =?UTF-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
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
Date: Fri, 30 Oct 2026 11:36:34 -0600
Message-ID: <20261030173635.2186490-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <CADvTj4qK-1SX_+YZW1jdW-e5JOZ2iz3vAK_8UvkyZWb0rAeyiQ@mail.gmail.com>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com> <20261029-submit-serial-8250-dma-cancel-v1-v8-5-3fd56ba352ed@gmail.com> <20261029222734.3086943-1-rrangel@chromium.org> <CADvTj4qK-1SX_+YZW1jdW-e5JOZ2iz3vAK_8UvkyZWb0rAeyiQ@mail.gmail.com>
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

On Thu, Oct 29, 2026 at 6:32 PM James Hilliard <james.hilliard1@gmail.com> wrote:
> With a persistent pause failure and an incomplete transfer, the
> worker keeps retrying. RX remains masked and the runtime PM reference
> is held until the condition resolves or shutdown takes over. There
> is no receive-progress guarantee if the peer remains idle and pause
> continues to fail.
...
> A failed pause with an incomplete cookie does not distinguish a
> persistent hardware fault from completion that has not yet been
> published. A fixed retry limit does not resolve that ambiguity.
>
> Terminating after the limit may discard received data, including a
> completed buffer whose completion is still unpublished. Successful
> termination would make subsequent buffer reuse safe, but would not
> recover those bytes. This would therefore be a potentially lossy
> error-recovery policy rather than a lossless timeout flush.

Checking the in-tree dmaengine providers shows why bounding the retry loop
and escalating to recovery is necessary in practice:

1. `serial8250_request_dma()` (`8250_dma.c:428`) checks `caps.cmd_pause`,
   which `dma_get_slave_caps()` (`drivers/dma/dmaengine.c:614`) sets purely
   from `!!device->device_pause`. However, `drivers/dma/tegra186-gpc-dma.c`
   (lines 422-423, 1351, 1521) unconditionally assigns
   `tdma->dma_dev.device_pause = tegra_dma_device_pause` (so
   `caps.cmd_pause == true`), and then returns `-ENOSYS` at runtime on
   Tegra186 where `tdc->tdma->chip_data->hw_support_pause` is false. And on
   Tegra194/234/264 (`tegra186-gpc-dma.c:399-413`) and Tegra210
   (`tegra210-adma.c:574-579`), `.device_pause()` polls a hardware busy bit
   with an atomic timeout and returns `-ETIMEDOUT` or `-EBUSY` if an active
   burst does not pause in time.

2. In the in-tree providers where `.device_pause()` returns an error because
   a transfer already completed—such as `drivers/dma/ti/edma.c:870, 1468-1469`
   (returning `-EINVAL` when `!echan->edesc`) and
   `drivers/dma/stm32/stm32-dma.c:751-753, 836, 1432` (returning `-EPERM`
   when `chan->status != DMA_IN_PROGRESS`)—the DMA hardirq handler calls
   `vchan_cookie_complete()` *before* clearing the active descriptor, so
   `dmaengine_tx_status()` already reports `DMA_COMPLETE` on the very first
   check in `serial8250_rx_dma_try_flush()`.

   Even on a controller where hardware rejects `pause` the instant the 4096th
   byte finishes while its completion hardirq is still masked by `port->lock`,
   the only thing delaying `completed_cookie` publication is local IRQ masking
   under `port->lock`. Once `serial8250_rx_dma_flush_work()` drops `port->lock`
   (enabling local IRQs) and sleeps `usleep_range(1000, 2000)` in process
   context, any pending DMA completion hardirq runs in microseconds. Across
   5 retries (5-10 ms with `port->lock` released on each sleep), a completed
   4 KB transfer will have published `DMA_COMPLETE`.

   By contrast, leaving the `for (;;)` loop unbounded turns any persistent
   `dmaengine_pause()` error (`-ENOSYS`, `-EINVAL`, `-EBUSY`, `-ETIMEDOUT`) on
   a partial transfer into a guaranteed 100% loss of all current and future RX
   data until `close()`, a 500-1000 Hz `system_percpu_wq` spin, a permanent
   runtime-PM leak, and silently aborted `dw8250_set_divisor()` /
   `dw8250_check_lcr()` calls (`-EAGAIN`). Escalating to recovery after a
   bounded retry budget is strictly better than wedging the receiver forever.

> That requires termination to succeed and callbacks to be drained.
> If termination fails, the channel may still access the FIFO, so PIO
> must remain excluded.
>
> The recovery requirements depend on why the provider cannot pause.

Agreed—and `serial8250_rx_dma_flush_work()` in Patch 5/6 already enforces
that when `serial8250_rx_dma_recover(p)` is called (`8250_dma.c:210-216`):

	if (recover) {
		ret = dmaengine_terminate_sync(dma->rxchan);
		if (ret) {
			/* Retain ownership and keep RX masked if DMA cannot be stopped. */
			dev_err(p->port.dev, "failed to stop RX DMA: %d\n", ret);
			return;
		}
	}

When `serial8250_rx_dma_recover(p)` sets `dma->rx_err = true` and
`dma->rx_terminating = true`, the worker exits the retry loop and calls
`dmaengine_terminate_sync(dma->rxchan)`. If `dmaengine_terminate_sync()`
returns non-zero, the worker returns early at line 215 with
`dma->rx_terminating == true` and `dma->rx_running == 1`, keeping RX
interrupts masked in `IER` and keeping PIO excluded (`serial8250_rx_dma_flush()`
continues returning `-EIO`). It only clears `dma->rx_running = 0` and unmasks
`IER` for PIO fallback after `dmaengine_terminate_sync(dma->rxchan)` succeeds
(`ret == 0`).

Thanks,
Raul

