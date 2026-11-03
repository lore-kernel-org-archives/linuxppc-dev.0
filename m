Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B86606A327
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=heTdwZ4B
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJw5p6Cs9z2xjP;
	Wed, 04 Nov 2026 04:09:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793725742;
	cv=none; b=nh9JAmyScPQMoiV7FY/d6MVtwMMIj2KG5bHJFpzT/nGu2MIS2u0kHsQ+WxeaTnKZIn6px0G9My9pzz6ifJP++KTVfMf6HWt7YiyP7n+kt2pcBdBy7tnLX8TA2vtaUstT2Rc1g8LIvjre1nTR0JQmDQP2vUjs8ZNE4+ZveOQ4CEExg5v0rErDqYsLY1sPaZYBfoMIBhng0G0YvYxFtULsaK+gZNu0YRWit1CQEpvxu7qq794go9qORVR1reb3ODcnmbhYhOo4mTPOjJGwvsxy6WkspoiVHt87cYXqDty14qEDyKy8QOnTDqZYVtSYXv/uEm/tt/fnyHzLMtEsRuFCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793725742; c=relaxed/relaxed;
	bh=7OtorZTCub4hIrC0NxSIXMmmJ1EiV6CLt9CpRNRER7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KL1JT90EQTHO+LZ3CQS7b6DpA6tULZvxFlHin5hQxkfPAz0hFzmfre7QqUQRN2tmadv7StTqJdk9P9GqaUb6dcikc2mfk4aHRcmzx/O3N+FQHVPfaB+OwbRWJRlxF/WesZ/l8mdH5jBbJL+sED2CJ+8bw8FQMWKFct2xA0bdkG8pecrOVVquZdYdzzGqoiLR+TV1HG+8CfEGFcolPtqarMRKxJt6hmytLmpmj7pGzuSLCTUM8TRzgLtyHYOhhGs4IVD0nl5+ajXxjAyoGvvUiSS+ZfguTaOaebGPq4CVMU7fqfVanzkfDQAfGZpb+xLkHvIoloSXa3pCkCuWSi2PrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=heTdwZ4B; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=heTdwZ4B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJw5n30XCz2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 04:09:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793725742; x=1825261742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kzOMXBdWLJQFKe7hbRAZJzr2q8dSOIdKIXVdm/WjI1A=;
  b=heTdwZ4BmmkM0ZuBVZAZZCRbg0D6MMgD3s4Wd2F4pXD/wUJhGjChENF1
   G5C7TeIZ961+KG++miPGmWZffRBSTWOfBqhgut6wP406lZ+S6UX/vStax
   b7Bu4oqeoPGYZEeXix7PxSgilxmzhBIxHyhAE1w4+x/f7eVzc8f5xffib
   6HL0VIMXFPMjz6cF0XDJq9yOOTT4laBAcKg5vltE0lrj8E/BeDZ8PYFLx
   MViK95Wk8zx8srWg4d2T5XD5sffLG3RUI134QQVPuxIeHKO3KpY5rtfI/
   bqootyUqatpSwIiMv8XRpepuZSckyXKcx7U2tQVwNjo8Okh3Z/QEMpjcq
   Q==;
X-CSE-ConnectionGUID: Pg18HNSxRlqVXFfX+wqIAQ==
X-CSE-MsgGUID: sGvWi126RUy1lAqeBiZKww==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2343739"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2343739"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:08:58 -0800
X-CSE-ConnectionGUID: l3z2TcvyTaalmoEHrpiZCQ==
X-CSE-MsgGUID: /HBnWMLARr6XaNehCmxvyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6560590"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:08:52 -0800
Date: Tue, 3 Nov 2026 19:08:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raul E Rangel <rrangel@chromium.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Timur Tabi <timur@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 5/8] serial: core: allow drivers to reserve flushed
 transmit storage
Message-ID: <auoVIR05PNyU8EEt@ashevche-desk.local>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-5-9159caade148@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-5-9159caade148@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 04:14:32PM -0700, James Hilliard wrote:
> uart_flush_buffer() resets the transmit FIFO before calling the driver's
> flush callback. An asynchronous DMA transfer can still access that storage
> after the callback returns, while a new write can immediately reuse it.
> 
> Add uart_xmit_block() and uart_xmit_unblock() so a driver can reserve the
> flushed storage until its transfer and completion callbacks have retired.
> Serialize the reservation with FIFO producers using the port lock.
> 
> While the storage is reserved, write_room() reports no space and write()
> and put_char() accept no data. Defer write-ready notifications until the
> reservation is released, preserving one-shot TTY wakeups. Keep the flush's
> write-ready notification under the port lock so it cannot race another
> reservation.
> 
> Wake tty->write_wait after flushing even when writes remain blocked.
> tty_wait_until_sent() waits for the logical FIFO to empty, independently
> of whether its storage can be reused. Notify these drain waiters without
> invoking the line discipline's write_wakeup() callback, so a reservation
> does not prevent a completed logical flush from waking a drain waiter or
> consume a one-shot write-ready notification prematurely.
> 
> Suppress ordinary TX starts while the FIFO storage is blocked. Preserve
> high-priority flow-control characters, which use separate storage.
> Releasing the reservation wakes writers through the existing TTY wakeup
> path. This preserves immediate logical flushing while applying write
> backpressure until the storage is reusable.
> 
> Track port readiness separately from DMA ownership. Retirement releases the
> reservation even during startup or shutdown, while writes and wakeups stay
> gated until successful startup or resume. Reopening or restarting a port
> wakes deferred writers with either a new or retained FIFO. Restart queued
> output when reusing a FIFO after suspension. Keep its write-ready
> notification pending until the retained output drains below the normal
> wakeup threshold.
> 
> Publish resume readiness under the same port lock as the TX restart,
> without clearing any reservation. A concurrent flush can then reserve a
> new transfer without resume releasing its storage prematurely.
> 
> Assert the port-lock requirement at uart_write_wakeup(), alongside the
> reservation helpers, so callers cannot inspect readiness or release a
> one-shot notification concurrently with a reservation change.

...

> +	/* Retained output must drain before consuming a write-ready notification. */
> +	if (kfifo_len(&state->port.xmit_fifo) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);

I believe I have seen this already a few times. Perhaps a helper with
documented idea behind it?

-- 
With Best Regards,
Andy Shevchenko



