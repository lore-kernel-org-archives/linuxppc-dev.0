Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C9606D832
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gZZQX2Bo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJtqM5L1fz3byl;
	Wed, 04 Nov 2026 03:11:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::22f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793722287;
	cv=none; b=o1ACILF37cNDX2WeesmXU7nMgCl9tVaA23sSY372vm6gTzZiJvBK1gBlv7n3pZ7MAMIbwa6p2XqTS7TAId4buXFPtALvb8psK1C+PU7g/MGRfxOAPcNIpxM+dk7P9GfzF20ZV35JryVO0nlScOzLCbPXPwq5hmK5x5r9hprNARyLUt076DLa1N6fV4lsI6LvIaWWEouMRh9fLQ2/TTHd9HcvUS8kTRfUxIyqFwUyBrnTivozrXxdovpVYGB6pD0zIVszU6GVWmH1kdMHzEqMRkGI09VYHPuYrHQ2+1Cdalq3Gcy6kpRfU1B7hPRQONAdouI2TTB48IBPVCL2akY4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793722287; c=relaxed/relaxed;
	bh=rNwvKOCdTYC9J02wHQU8L2xZ+KavqPuMAcm6uI6YuYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obDTV9deMWnVhWgHvYmAcIDciRu3v8gEn4nOor3zQ+43Oswjlp0/DRrKdpzDXjM9iC5ExvUuAF+wkty47Ivmm1SPhzigUT7/tKc5ZAwL57girG0Q+PBKQr1N5OlJKj0wNa+j6CRxO21ABLeg0r/oirDmiwO0oFSFZ+lRctP/CZsxehF2cA94l/GeNMQjp0rElvxruiyMJ217g9IIErIuSEoqD2350GVi/7zmQf/xieFzG0nHQn2Aw2yzdHXUYrkTg/m8aEanX/iX4gxi5LZm6gzTkeDfCvl7Sc5o7ze/JFEQyqhWdBV00uJobzmCIwqm7LlGk08Nfacu/6S0zjG4/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gZZQX2Bo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gZZQX2Bo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJtqM0MPrz30P3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 03:11:26 +1100 (AEDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-53ec9237600so2447671b6e.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 08:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793722284; x=1794327084; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rNwvKOCdTYC9J02wHQU8L2xZ+KavqPuMAcm6uI6YuYg=;
        b=gZZQX2Boc5GYlUYVNiiF1fNHx5oj39aFngAXOi43ILpb6/5l1g5AIzPRqFUdER08ex
         ZOBl9QFTMWsDkNUHHSAQSYP2NIz92kCZcSBDXeo7heNJYR2miC2X5BVPGdNq+TT/tG4i
         /ef+l1Eds8/1BfNvSTviKSquHeFFB3RF1npgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722284; x=1794327084;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rNwvKOCdTYC9J02wHQU8L2xZ+KavqPuMAcm6uI6YuYg=;
        b=oTnKdJDCWUR+hJxmfO6+gVP3MOqPi2YcvqN5caZHGNhLUkQULBd2Ywq6/plrYs/HBE
         17YAYuZ+t5/3QBzqSQp4hKlv6ZMl0xNGQsib57UVRvYpcEqI7dyjzO5FpqetX5AFU8Pw
         Tm0Xj379EixzspifTGKvhX96L6P37URzUKMOjkWCwmhQwa6O5BK/8N25O218lJtSOmcm
         UX8pZm2N+Zsne3xwLDmRLO0rQAs+eYs+2o3hPfFtWV5RyTJls0lvGAX6bFD7pZiS/g90
         u4xBG6RVOX24CODNUlSyQk/2TcLB9t/+1CyxINhYHfhykeEIHqD/amgHk4W8huOyP67c
         zteA==
X-Forwarded-Encrypted: i=1; AKwUvBxjrFyRsXPa6w4qUPcFT1rCdEZ1AjGTHCN/xF9pB/L3QkVFuUlgleOsFXfplLzR0H7jOIywKTRGZFKVxFw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8g85t5Uwbl+Scm8iSwrzUiOeFR+gJ2aKIhJ1SuBOFbal7y24t1
	dzp/OqFkZZUFY/MXams99M467U79aryl2mw4jKdDNnHZckCLM/4wZ1iXQOwzVVs8Pg==
X-Gm-Gg: AYBFou0eusBR7xYM5eg/N2LOsEFrPV5Zjl9gZUClWz9G4PneUEbCIOnZpXhoO6QqOr7
	UWklXPoKV/lwHWAnDraDQnhXYxiBgPbbCL3nkovftwkdtnfS621UK0pwm3SC+zOGqZxNVKBzczE
	yNJebcCrBnR97PY8y72LIuQBC4hUXUdXKiWg5l0xpZFXvxiDMWOz+J3M5CtVFEuBdHjSrlHX0co
	2yOxDMPUTRi7iVIUPxd6aM61UhYMqfrtE/TBhByh2m+kerx7sarHiX7dQtuIbOC16jN5gKzPc0h
	r2nyGx8FRqq+hoERkIoWvl/IMnrRk7aIpJjsN1LSSVwOoVstdX0Fs/Kb1rG7a1SUzCUQvSkarbz
	N0UIF+8zmDqmSibaNtedod3xQ3DwecO0Pi1T5Es8JLHy0TJptyMkQbjansQT5ETG7f9poWraaqR
	bNM8VoUsmID3rlMEAyiJUI4iZE+cLfEwI838+Um6r1rxD5SbMwf8OqyHtwOJGWVbohNz0K5IxLs
	Dr8SFIDYTITFWqYVrxx+hb27SGXTy/o9xiWTBBQl5wArvSF9f3mc6VbeMWbsCIpEvt7dOupW4Mz
	I+y3iIUYZxRZh3JnftTclqyxbb33L6quG/D2QYmfxjZrSALu61TCCPwmJVVX8EyCwIWqw4ACcl+
	esSP73EjAC94Pjpg=
X-Received: by 2002:a05:6808:2218:b0:52b:7641:33a6 with SMTP id 5614622812f47-5640deea502mr9137854b6e.14.1793722284423;
        Tue, 03 Nov 2026 08:11:24 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95dc0sm11688383b6e.6.2026.11.03.08.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:11:22 -0800 (PST)
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
Subject: Re: [PATCH v9 8/8] serial: 8250: retain DMA resources when termination fails
Date: Tue,  3 Nov 2026 09:11:04 -0700
Message-ID: <20261103161104.2449407-8-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-8-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-8-9159caade148@gmail.com>
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

Thanks for replacing the fixed 100 ms sleep with exponential backoff
(1 ms -> 1 s) and adding the initial/ongoing/recovery diagnostics in v9.

Following up on our v8 discussion regarding blocking in
serial8250_terminate_dma() versus non-blocking resource quarantine:

1. Why non-blocking quarantine cannot be done purely inside 8250_dma:
   I agree with your v8 reply and the updated commit message here that
   serial8250_release_dma() cannot simply return early while leaving
   serial_core to proceed with normal teardown:

   a) Immediately after serial8250_release_dma(up) returns in
      serial8250_do_shutdown() (8250_port.c:2474-2511, and similarly in
      omap_8250_shutdown() at 8250_omap.c:794-803), the 8250 driver itself
      clears the hardware FIFOs (serial8250_clear_fifos()), reads UART_RX,
      frees the IRQ (up->ops->release_irq(up)), and drops runtime PM
      (serial8250_rpm_put_tx(up) / serial8250_rpm_put(up)).
   b) In uart_tty_port_shutdown() (serial_core.c:1841-1853), immediately
      after uart_port_shutdown(port) returns, serial_core unconditionally
      calls uart_free_xmit_buf(port) (line 1850) — freeing the page that
      dma->tx_addr is still DMA-mapped to — and powers down the UART via
      uart_change_pm(state, UART_PM_STATE_OFF) (line 1852). Likewise,
      uart_suspend_port() (serial_core.c:2502-2514) calls ops->shutdown(uport)
      (line 2502) and unconditionally sets UART_PM_STATE_OFF (line 2512).
   c) Even if startup() returns -EIO on reopen when DMA is still active,
      uart_port_startup() (serial_core.c:422-423) has:
        if (retval && capable(CAP_SYS_ADMIN))
                return 1;
      which causes uart_port_activate() (serial_core.c:2060-2062) to set
      tty_port_set_active(port, true) with tty_port_initialized(port) == false
      and allows root open() (serial_core.c:2040-2042) to succeed (0). From
      that state, ioctl(TIOCSSERIAL) -> uart_set_info() (serial_core.c:1068)
      -> uart_shutdown() (serial_core.c:466-511, which calls
      uart_free_xmit_buf() at line 510 outside if (tty_port_initialized))
      or uart_hangup() (serial_core.c:1942-1950) or uart_change_port() ->
      release_port() (serial_core.c:932-933, 1072) can free the TX buffer,
      power down the UART, and release MMIO mappings while DMA is active.

   We modeled these cross-layer paths in Serial8250TxDmaV8.tla
   (QuarantineGuardsShutdown, QuarantineGuardsAdminOpen, and
   NoDmaOnPoweredOffUart in Serial8250TxDmaV8_UnguardedQuarantineHazard.cfg
   and Serial8250TxDmaV8_AdminReopenQuarantineHazard.cfg vs.
   Serial8250TxDmaV8_TerminateRetryHang_Fixed.cfg, alongside
   Serial8250TxDmaV8_QuarantinePioReopenHazard.cfg at
   https://github.com/ismell/linux-8250-dma-tla), and TLC confirms that
   quarantine without those serial_core and PM guards violates
   NoDmaOnPoweredOffUart / NoConcurrentFifoAccess (in 6 states) and
   NoUsersAtFree (in 7 states). Given that enforcing non-blocking quarantine
   requires coordinated changes across serial_core.c, runtime PM, and 8250
   shutdown, addressing non-blocking quarantine in a separate follow-up
   series and documenting the limitation here makes sense.

2. What in-tree DMAengine providers actually return from terminate_all:
   For context on when the retry loop in serial8250_terminate_dma() can
   trigger, I audited all 78 .device_terminate_all implementations in
   drivers/dma/:
   - 64 out of 78 unconditionally return 0.
   - Among DMA controllers used with 8250 UARTs, synchronous FIFO-draining
     drivers (drivers/dma/dw/core.c dwc_chan_pause ~40 us,
     drivers/dma/idma64.c idma64_chan_deactivate ~100 us) already poll in
     microseconds inside terminate_all and return 0.
   - The only 8250-paired DMA controllers that can return non-zero are:
     * drivers/dma/tegra186-gpc-dma.c (tegra_dma_terminate_all, lines
       714-743), which already polls readl_relaxed_poll_timeout_atomic()
       for up to 5000 us (5 ms) in tegra_dma_stop_client() / tegra_dma_pause()
       / tegra_dma_pause_noerr() (lines 389-414, 676-712) before returning
       -ETIMEDOUT; and
     * drivers/dma/at_xdmac.c (at_xdmac_device_terminate_all, lines
       1999-2039), which only returns < 0 if pm_runtime_resume_and_get()
       fails.
     (Even across all 14 non-zero .device_terminate_all implementations in
     drivers/dma/, the only one designed around a caller retry loop is
     cppi41_stop_chan() -> cppi41_tear_down_chan() in drivers/dma/ti/cppi41.c:
     652-770, which is a USB MUSB controller used only by musb_cppi41.c.)

Thanks,
Raul

