Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C423606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=foaH66qz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQQS90Zn5z2xWt;
	Fri, 13 Nov 2026 03:14:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794500041;
	cv=none; b=cDqQEpHE1T8zJhNVZsevSP8tNJ+DHJUv/03405AL6W7mONsR6pFbSiUWpdpmcgmzpol8tM/X+P1WqIhxKPYeP/FvSE8RpQxkM1OCynPTV5eqG29/JBV6LmWj8eHierOGCHktLzgbXOLQCQ9bTfmtE+GpzrXRB0qTNyGi6Q4nfStjIlC9cJeg74VS9iowUaKlBFuPetem/MNuql82+TWntkfS1Sh7dyrffbRf8xgZDUrCOpnlkTzn1R5vG93zbGhs0vhiYRMqHTriHTpPLNtaquDvTFUQp9AgEcRY0z6PjNE2RxWUPT80PtXcq5H6imsoZf1d5RteqvwkWOaJ3kUtYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794500041; c=relaxed/relaxed;
	bh=c4OknN5YfqROvQIcmXbW+MOiSND7LTxhC21JuzqOEYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pbpnyi9pLxp7GdKsgX408IbogrgCQWIMC0XYznTA2Z3LlBKIAp6lKxnkrwggx4B5VOsC1XeqBpKVu+87E9rExM/12ptGE7/nxwqXJpcTDPmAdBD6HSA/1BY3Ob8TM+BuXxO+234lIOK838yXRBQ9/as/F+75Gwb2JFe6JD+FeVFxYiGCzcLjt6rYL1RdVZwDZ8HAABFvMd/M/5h6mfhL0BS5BhRoPkblcxf9xEyPzjVTATHL74zdM0f4fPGpVlmtgpwdCKRNKlvDST4eE2IuknFPZ+w582R19U322PIsV1/dbkrap567EDt9e3fMUJCxG2aSCK4VJB1mg89PL3gpKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=foaH66qz; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=foaH66qz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQQS81Vnlz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 03:13:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794500041; x=1826036041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P3eY0n6vlSPXz45ttiFWukVb0XOFJGYuxSNON9DZg6w=;
  b=foaH66qzjFLH0+NlLRTeIJL8MRmxObEzzSMgR9lBiWjPqeblfA3mGbTT
   +1kMtu0xuj5uPT7x43ypuIeWJSvSo0NfxpKlHPqN7csdKKhQMqGICfljs
   G1TDPNNiBWlpnEXE+KwL27olpM8oWoLNX+7wlniNJa+fEonrAa3HHVFJz
   PMT4ItEewRdDSxXPjLqz9BJyR4hVlnpLC+RLq8nMrwmvp0YdSz5kJSvKA
   hKntmz9YFxIYW8eKe+4IERbuFZ5Z96CItfYZ/abmzrCStwIb6M9bozVOf
   ojeFPxjHfDUcqhk1hZTT4EF2zJxJMW2QJ/0Axmqk1S5iKdEXiWL0e2j+8
   Q==;
X-CSE-ConnectionGUID: cHh7DD32S1a3jT156kQNKg==
X-CSE-MsgGUID: AD+ROesdTEi/Mu/U3CluYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3210545"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3210545"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:13:58 -0800
X-CSE-ConnectionGUID: YpTlbcAPQJGxf1iKlOYuBw==
X-CSE-MsgGUID: 7vG+U6ikQHSqNIVXrFRQLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8519157"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:13:51 -0800
Date: Thu, 12 Nov 2026 18:13:49 +0200
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
Subject: Re: [PATCH v12 5/8] serial: core: allow drivers to reserve flushed
 transmit storage
Message-ID: <avXlve7ROG9jb6AH@ashevche-desk.local>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
 <20261111-submit-serial-8250-dma-cancel-v1-v12-5-9e3456bc2555@gmail.com>
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
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-5-9e3456bc2555@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 03:16:30PM -0700, James Hilliard wrote:
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
> wakeup threshold. Share that threshold check with generic 8250 and OMAP
> TX DMA completion through uart_write_wakeup_if_needed().
> 
> Publish resume readiness under the same port lock as the TX restart,
> without clearing any reservation. A concurrent flush can then reserve a
> new transfer without resume releasing its storage prematurely.
> 
> Assert the port-lock requirement at uart_write_wakeup(), alongside the
> reservation helpers, so callers cannot inspect readiness or release a
> one-shot notification concurrently with a reservation change.

...

>  void uart_write_wakeup(struct uart_port *port);

> +void uart_xmit_block(struct uart_port *port);
> +void uart_xmit_unblock(struct uart_port *port);

These are not used in the below helper, so, move them after it, with that
the uart_xmit_*() and uart_write_*() will be grouped.

> +/**
> + * uart_write_wakeup_if_needed - notify writers when queued output is low
> + * @port: port to be processed
> + *
> + * Keep one-shot write-wakeup notifications pending until fewer than
> + * %WAKEUP_CHARS remain in the transmit FIFO. This also applies to output
> + * retained across suspend and resume.
> + *
> + * Context: @port->lock held.
> + */
> +static inline void uart_write_wakeup_if_needed(struct uart_port *port)
> +{
> +	if (kfifo_len(&port->state->port.xmit_fifo) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);
> +}

-- 
With Best Regards,
Andy Shevchenko



