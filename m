Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9A0606A330
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=J30+TKxz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGSvd1bzfz30W5;
	Sat, 31 Oct 2026 04:36:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793381805;
	cv=none; b=jocxxcWhOENmUv/pgXQ55aH2di2KfWjxi1RxtypRweyBWyVrLnjcVtub2hz6Dwzz6Uw0A2adrzb1WM91UsTw+w7O2DwhlbXQq9Fn1jb3zOHzlOZYdrINhcDezywkYN+0UIT/RYDsceqp8Oev8TPP2oyzf/IIHJFvpd58wLRC3NoVsU7dnrUf10euo/29WckxClDf45tTvwLA+aOeRsdFcvRJoIlS1Lbhg9zBzTH1CiIyX5nfYVqHTcYdmw4DsQJjDxcbGDoFN8AAVZAO3mlvs4Qe6kPYFz+EIT+GcXeUA+73jLna+PxJ+ZGBkkzc6G0GUrMxmaDZd9Z4YOM8mOofQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793381805; c=relaxed/relaxed;
	bh=p+eb7dwaVi2e/2az0lhLRof2o3XdtzLR7+wZ1rytyEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aS+himvuHTn3d5NgcflDNNv0guDwKDhl/7j7KsjqdR/GyqBkIh1pG7qOnWrWmaNy8UJeCy6NC3eoXH7bF08z79ZPZr+pbNUPYVhZXbk5g9+oofFKAsstBnimCGA00bwD5giXA1iRGJlXzH0jX7clkxj+3KzTTdmrO/yIaDOZDDDQIdlwO2iYJxiTKMs2ASAACWyOSmSR8/PKqRVptsmx8MIIYEo1+nKsoxNPIriepy0GzEJUDwe8eIVue7P2ndyBw5GsDME2O3bReqGCvwSkfYn4PgB+dsfQlctk0Di321z0l2wr+LaNo7NVJaMsyhLT6Onk42Xw8mTqQu8jLVJ7eA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=J30+TKxz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=J30+TKxz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGSvb08HWz30Vd
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 04:36:42 +1100 (AEDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-847ac7ccd85so723620a34.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793381800; x=1793986600; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p+eb7dwaVi2e/2az0lhLRof2o3XdtzLR7+wZ1rytyEE=;
        b=J30+TKxzKw+DxqSs/P+Unl+mKp8b4aEp1QHTZRmtUc8gRS21/yx73ubP9UQIL+1gtu
         EhFBhNyarxmM7rQgllJDODXaRnfELA6WpCzSeAiQxgKk3FOSaLXRt94nZUsPNVAk5/3r
         OvW2Z03N6tO1N3M3AFhTBILXCIoUCTdbQb3OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793381800; x=1793986600;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p+eb7dwaVi2e/2az0lhLRof2o3XdtzLR7+wZ1rytyEE=;
        b=0P4cq6eVd084EjFqX4KtOHX8BRECM0WazsmhPcE6fhDvKvbpHSJo0BdSnVA1EyU3wm
         1xo9v3WldhXim5LufiQUf97xvwPWBoRF4ipQiJRxN7fHec5w+cZsJ3wAaqyNWP2M7B9/
         mQx340pmp8LcFQC7Q8pHAIoK9YQpyOycm/bVdwDjECpr6PGBdVv7M/B4fG2jxiX3qB9E
         iHBQeIYCvWtyrOIMAx3i/QOueUvoheI1S8cjFkhGyo5uEcmoNvmttIxUJGzRigtB0DFP
         EMsC5NZrNHLXqQoEMgOd036IVAW6hxjdEb+6luTgnd3fYKtziHaNzrRPxADmlVVhwQBr
         CByQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLNglbQo160BWw9QRUNExpLdiFWy2cu3YvknxJ/VczfWMm47tK1sWY1SzdhKXskLrUFXskkQDkAtnob5Q=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLtFFqUd6BxsNu/GA3jT0NHMJHdwR0w3a3esmFi4Lq07rGh4AIS
	dO35o8T1kJ8I2zixdxnm9j8BX2D69e0W5ynlvVkOzi4N5P5G6iVaby7BhRx9uJVOxw==
X-Gm-Gg: AYBFou3OCWIhu5I33S41uAipgCPoYj2xzxoFWLWsT0wT/2VkltFtF5PONmNC0S+qEf4
	h5UbECebCGVMOTquDg8xXh0oyKVLS+0Uthdltrwy10FHWZtDqvbcRsY/bc6NDjY0Rhxt6IBapav
	SxZRzDcdjnqNtweNOdcEwc3Ov0XqUwv9azBGAAFVj3y9ByGE2xuIW72f34zX0HBcd5F6ZwmGAn1
	otE3tl2ELP2T4BA0Z0TOoKNkMTLNxQ5WyKEpWAs2Ul98e9VvJk70SlQZ+u7kK8riZcPjeq9Ej2F
	eznWu6v57QiC21zjymW8Z11JmkEQT+JDIebu63Z01B3y5xs8wNrgFaTLXJ7uGFcwcDnwzyPMkMs
	nWS76v/ukgI+KegyAJjEjpLGccAej+gHHcHiSICOLoSFzFFOhihUptBiA7B4AR3JHEL8Gw78SlD
	w3bpFRq7Sg4Q4JbS6/eOs5aBc2yYEqRfBQbQkRO9Ui58Bb6patA8myg+WpVfdshLHYG8gJKUmOO
	Cnf8AEprdr0mxWDYZf0fi9kSy94+LduMsC+Oh3JmF3cMcQrMgnzK2mxnOZx5JKs1kwyICjXh5aH
	+qvZ+xqaj/bB1QM2skJ+ZXRCfeTGW/ez3xHdXfRkrVKW3fVxDGiMSw4tSK9uxBhMTOOLTgArYOD
	hpgie/T+6I3LEJr6r
X-Received: by 2002:a05:6830:7181:b0:81b:ac9a:5681 with SMTP id 46e09a7af769-85d3649ebddmr2330039a34.29.1793381799663;
        Fri, 30 Oct 2026 10:36:39 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354efebesm2497044a34.19.2026.10.30.10.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:36:39 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?UTF-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
Subject: Re: [PATCH v8 6/6] serial: 8250: retain DMA resources when termination fails
Date: Fri, 30 Oct 2026 11:36:35 -0600
Message-ID: <20261030173635.2186490-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <CADvTj4rRtKyq_7yhpfwGQrbOA=k_jxQymTpZSvdVBB0A-xR-Rw@mail.gmail.com>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com> <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com> <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local> <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com> <20261029222734.3086943-2-rrangel@chromium.org> <CADvTj4rRtKyq_7yhpfwGQrbOA=k_jxQymTpZSvdVBB0A-xR-Rw@mail.gmail.com>
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
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,T_SPF_TEMPERROR,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 6:35 PM James Hilliard <james.hilliard1@gmail.com> wrote:
> That is the current behavior. Returning from shutdown allows serial
> core to free the TX buffer and removal to release the callback
> context. The retry loop prevents those releases, but a permanent
> termination failure blocks teardown indefinitely
...
> Retaining the buffers and channels does not preserve the complete
> callback context.
>
> The callbacks carry a uart_8250_port pointer. For DW, the DMA state is
> embedded in devm-managed private data, which can be freed after
> unbind. The registered 8250 port slot can also be reused. Retaining
> the DMA channel does not prevent either operation.
...
> Clearing up->dma does not stop hardware accesses. After unsuccessful
> termination, the channel may still access the UART FIFO, so reopening
> with PIO can introduce concurrent FIFO access.
>
> A hardware-specific stop/reset sequence could establish quiescence,
> but its implementation and effects on other channels depend on the
> controller. If the channel cannot be stopped, quarantine also needs
> to preserve callback-context lifetimes and prevent unsafe port reuse.
...
> The current callbacks fetch p->dma before acquiring the port lock.
> A callback can therefore retain the old non-NULL pointer across the
> assignment of NULL. Checking that cached pointer does not protect
> its backing allocation from being freed.
>
> When termination returns an error, dmaengine_terminate_sync() also
> returns without calling dmaengine_synchronize(), so callback draining
> has not been established.

Those are all good points. We added port reopen and a `NoConcurrentFifoAccess`
invariant to `Serial8250TxDmaV8.tla`
(`Serial8250TxDmaV8_QuarantinePioReopenHazard.cfg`), and TLC immediately
confirmed your point on FIFO contention: clearing `up->dma = NULL` and
falling back to PIO when reopening after a failed `dmaengine_terminate_sync()`
violates `NoConcurrentFifoAccess` in 7 states because the un-terminated DMA
descriptor can still access the hardware UART FIFO concurrently with PIO.

We can satisfy all three constraints while still preventing normal `close()`,
`hangup()`, and system `suspend()` from hanging forever in
`TASK_UNINTERRUPTIBLE` under `port->mutex` across the three lifecycle edges:

1. **On `close()` / `hangup()` / `uart_suspend_port()` (`serial8250_release_dma()` & `uart_free_xmit_buf()`)**:
   - Bound the retry loop in `serial8250_terminate_dma()` (with a short
     backoff rather than an unbounded `msleep(100)`, guarding
     `if (dma->rxchan)` / `if (dma->txchan)`) and release whichever
     channel(s) terminated cleanly (`rx_ret == 0` or `tx_ret == 0`).
   - If `rx_ret != 0` or `tx_ret != 0`, **keep `up->dma` intact** (do not set
     `up->dma = NULL`, including in `8250_omap.c:omap_8250_shutdown()`), keep
     `dma->shutting_down = true`, and retain the failed channel and its
     buffer (`dma->rxchan` / `dma->rx_buf` when `rx_ret != 0`; `dma->txchan`
     and mapped `dma->tx_addr` when `tx_ret != 0`).
   - When `tx_ret != 0`, explicitly call `uart_xmit_block(&p->port)` under
     `p->port.lock` (`state->xmit_blocked = true`, since `xmit_blocked` is
     otherwise only set when `uart_flush_buffer()` ran prior to `close()`),
     and in `serial_core.c:uart_free_xmit_buf()`, return early under
     `uport->lock` if `state->xmit_blocked` is set (without clearing
     `port->xmit_buf = NULL`, resetting `port->xmit_fifo`, or calling
     `kfree(xmit_buf)`).
   - Because `up->dma` is not cleared and `struct uart_8250_dma` /
     `struct uart_8250_port` remain allocated on the bound device during
     `close()`, `hangup()`, and `suspend()`, any callback that was not
     drained by `dmaengine_terminate_sync()` safely loads a valid `p->dma`,
     observes `dma->shutting_down == true` under `port->lock`, and returns
     without UAF—while `close()`, `hangup()`, and system `suspend()` return
     cleanly without hanging in `D` state or triggering `hung_task_panic`.

2. **On subsequent `open()` (`serial8250_do_startup()` & `omap_8250_startup()`)**:
   - At the very start of `serial8250_do_startup()` (`8250_port.c:2356`) and
     `omap_8250_startup()` (`8250_omap.c:724`)—after acquiring runtime PM,
     and **before** clearing `up->dma->shutting_down = false`, touching
     `UART_FCR` / `UART_RX` / `UART_TX`, or setting up IRQs/timers—if
     `up->dma && (up->dma->rxchan || up->dma->txchan)` is still non-NULL from
     a prior failed termination, retry `serial8250_release_dma(up)` first:
     - If `up->dma->rxchan || up->dma->txchan` is **still** non-NULL
       (termination still failed), immediately return `-EIO` and **fail
       `startup()`** (do *not* clear `up->dma = NULL` and do *not* fall back
       to PIO while the wedged DMA channel may still touch the UART FIFO).
     - If termination succeeded on retry (`rxchan == NULL && txchan == NULL`,
       which also unblocked `state->xmit_blocked`), reset `xmit_fifo` and
       proceed with normal startup and `serial8250_request_dma(up)`.

3. **On driver unbind (`serial8250_unregister_port()` / `serial_core_remove_one_port()`)**:
   - Driver removal is the *only* point where `devm`-allocated
     `struct uart_8250_dma` and the `serial8250_ports[]` slot are about to be
     freed/reused (note also that `serial_core_remove_one_port()` at
     `serial_core.c:3336` only calls `uart_shutdown()` when
     `tty_port_initialized(port)` is true, so if the port was already closed
     with a quarantined channel, unbind must still drain/release it).
   - Restricting blocking termination wait to driver unbind (when a channel is
     still active/quarantined) prevents `close()`, `hangup()`, and system
     `suspend()` from ever hanging the kernel in `msleep(100)`.

We verified this quarantine + `-EIO` reopen contract in
`Serial8250TxDmaV8_TerminateRetryHang_Fixed.cfg` (`AllowReopen = TRUE`,
`ReopenFallbackToPio = FALSE`), which passes all safety and liveness
properties (`NoUsersAtFree`, `BoundedTerminateRetries`,
`NoConcurrentFifoAccess`, `QuarantineImpliesXmitBlocked`, `ShutdownProgress`)
with 0 errors:
https://github.com/ismell/linux-8250-dma-tla

Thanks,
Raul

