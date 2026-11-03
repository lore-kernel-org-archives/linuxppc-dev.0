Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936D5606A338
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h5PmctGv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJwNJ0McCz2xdX;
	Wed, 04 Nov 2026 04:21:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793726495;
	cv=none; b=gtCQ3x4+u0IOv9Nks/8FPCfgPKFmhFBRkYPn/3bSUNa+jB662/ERdZu9JY14AgF1ustmu6Tbhe8oxldrsVjG9bv6R+7L8KXlojREDGLE32Lw+N5TK2yY5JS4HP/YiY63l9OT0WLxaSqidspMfA0Ax4jbZlcRElWHDc68d2MO6viNZy83YgOsOzKkX2AmmFoQljsI9gRyaYzEKoPFpgzwuK3Z6E0bX178c6D4n4Ez1GhqgIpLQ0LqdqUv/8vEIT1eNeyo/U4IpFCfBXHeXCxp3nuC7wGkgUhWx4DPmUX6uXHCP3izBZUSL01Y7B/Et+I4++4HF5uTtukqr/mFtHcvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793726495; c=relaxed/relaxed;
	bh=jybwex6KEtiVVB5Q7MO/0FLbDCSae5cKl7r/Ekti9JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0lbqNF6ma2ukE0b8dUXoYN+BoHWjMpjUU7LbwSPywA/i7jgTx+ETx8RAE9BFu5uetRrf0kFIQ0XwPVwFU9p8MeMOBoPv3JKET6C7LzogL1+xjkSiIHaWK8ZmYV+K4JIRnM4Ce3l1iOrP7cGVJLOTMnl4lWq87eddH/z+7I8KaAY/34lTbNbtnzwxIjHMYzBC2MbtMcmk+/tGx4ijMWcwcVMJpjcDbbKfQURNPVO1bPmbS4Wm4H/y7CMKX7GrDbcYK4UV5UCF9yWXhzkM0N9Opo8/W/KojC1dOWeovRjmX55BwQlU3cVQPho4PfGbc8gYfTVxerNVBrM0Fn2EZTf4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h5PmctGv; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h5PmctGv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJwNG1Z6zz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 04:21:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793726495; x=1825262495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MsQh6jwB+YXfuoggHvsVrFxpE0KnVT/xHsMAp3keNjk=;
  b=h5PmctGvmD3Zz1ci6K5oeUKNYbkaOEJrVzpcKy0bPyE2siybT0YRi4TV
   DhSRsGImic/Ein2ibPjhWZ5dJb/p1FvA6jVAuuLZaXKneFRHVKVB1nOLN
   ynN0ZWzyRJLClSc7weRc61v1M5xJLkD+b8Xa4ss34ua5iQmT7TBC+PS83
   MD309+wcCNlRfVEdiEKqkW010Y5lbXyYa370gISrm/8S8sS5mk/mBu4V0
   2Sma2gyYpskOLI2LcGOJZ3SUVFRV9oEf4H8GIg6FmELZDqkdgQjiV/iXA
   ibRcHKvdjjWlfoNv40ZUaXhiIbCh8DOK3QalcGms4WVvZw09UP0oElup5
   w==;
X-CSE-ConnectionGUID: 4AfhjGAoQBqEwYHjkjKtJQ==
X-CSE-MsgGUID: 3ynHChUxQHy6rozNfBf2aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2369594"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2369594"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:21:32 -0800
X-CSE-ConnectionGUID: 04u2Hyb+SN6wX57K1GcXbQ==
X-CSE-MsgGUID: mdIQ21nhR56Tg3Q1sMOFvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6331418"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:21:25 -0800
Date: Tue, 3 Nov 2026 19:21:22 +0200
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
Subject: Re: [PATCH v9 6/8] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Message-ID: <auoYEjduLH9GlAFp@ashevche-desk.local>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-6-9159caade148@gmail.com>
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
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-6-9159caade148@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 04:14:33PM -0700, James Hilliard wrote:
> uart_flush_buffer() resets the transmit kfifo before calling the driver.
> serial8250_tx_dma_flush() terminates DMA asynchronously and clears
> tx_running, allowing a new write to replace tx_size while a detached
> callback has not yet run. That callback can then consume bytes
> from the new transmission. Reusing the reset kfifo can also overwrite the
> source of a transfer that has not stopped yet.
> 
> Reserve the flushed FIFO storage through serial core before returning
> from the flush callback. Keep tx_running set until a worker synchronizes
> the terminated channel, suppressing old callbacks and new submissions
> during that interval. Return the mapping to CPU ownership before releasing
> the reservation and waking writers. Normal transfers continue to use the
> FIFO directly.
> 
> Reuse the locked completion processing after retirement, including OMAP
> delayed register restoration and transmitter-empty handling. Take a runtime
> PM reference around worker UART accesses and drain the worker before
> releasing the channels. Shutdown releases the FIFO reservation after
> stopping DMA and unmapping its source. Serial core keeps writes and wakeups
> gated until startup or resume makes the port ready again.
> 
> Track a flushed FIFO separately from the transfer length. If termination
> fails, retain the reservation until normal completion and account the
> completed bytes without advancing the reset FIFO. After successful
> cancellation, process a zero-length completion once callbacks have drained.
> 
> The race was found by inspecting cancellation and restart while preparing
> H616 UART DMA support.
> 
> Retain the tx_running check in both completion callbacks. Releasing the
> reservation relies on the DMA provider draining detached callbacks when
> dmaengine_synchronize() returns; provider callback-lifetime fixes supply
> that guarantee for controllers which previously lacked it.

...

> -	if (!dma->tx_running)
> +	if (!dma->tx_running || serial8250_tx_dma_blocked(dma))
>  		return;

> -	if (!dma->tx_running)
> +	if (!dma->tx_running || serial8250_tx_dma_blocked(dma))
>  		return;

...

>  	guard(uart_port_lock_irqsave)(&p->port);
>  
> -	if (dma->shutting_down)
> +	if (serial8250_tx_dma_blocked(dma) || !dma->tx_running)
>  		return;

Try to make these checks consistent. It's always better to choose the order and
be aware of the potential side-effects of the bit-wise operations.

...

> -	if (dma->shutting_down || dma->tx_running)
> +	if (serial8250_tx_dma_blocked(dma) || dma->tx_running)
>  		return 0;
>  	if (uart_tx_stopped(&p->port) || kfifo_is_empty(&tport->xmit_fifo)) {

-- 
With Best Regards,
Andy Shevchenko



