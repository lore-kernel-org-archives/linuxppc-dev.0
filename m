Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19318606A32D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UXlzdz+r
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQQjF22Jkz2xVY;
	Fri, 13 Nov 2026 03:25:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794500721;
	cv=none; b=DdBLifNGr1iJSWg+OydA1r+X1ng1gRl1D3+sURxEOqeWyMbcw/TyJYq3guTGcS07or1l885OLRAEM+htGdQyte5H/Zc0j9iv36kkuuEeRzcPfAkUSogwXNlBfDc/EcaAHUeV0M0eii2kV8np/ECH25C6054h7Id4BOG9TK3hfgmmtnQnPz5SmdrG0YUIxb46HryeUIFyvi9L24cuXR7WFm+OZDVXyqwwWD7kjTeaj+2vu0IETstmsEKO8Zr1wFKh04tBvk/ZsvC2kAGftoBRZIteRlc07JvCj0hOrYcqsc30pB0DziyXBy0hVwF2a3wJzStWDiG48lqhhqjiHM3S0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794500721; c=relaxed/relaxed;
	bh=fK+KayHuMk1WLqGXM0FWu4AqIcNDWECGkJlS8riGoXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOqUX4nydhbvV0s2i8GPSzbyR3R3AxcQsExKQj4Z3CLz9F+XOMKm7K+jeRRrbOsQDKjLVbxnQ2FeACKzAtZsA72l86mjM2nmqvZ3egVzH3mH4uThYExJZIlleTAtfD5Lo7fj07j7m3+qoPxS4LcGxoFz7niZOXie2sj21+NGwYAnvsc4AI84xs/B4rSjoLX42DUj5wbZju6brt7VR6l5ig3AO3fAuLv3jOLMlS6eWDijHmedeFGCFS3KmXOJOepYN8fSvgMX1htth3gavrUHQkLiuRwszKLLVPJk2ONp0N0lYnhVdkPCkJTENZPDC6ew5nnA4RZAN0gnVV3Fy5HDGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UXlzdz+r; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UXlzdz+r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQQjD0HRYz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 03:25:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794500720; x=1826036720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N5TD4x09GpjorduT+9U5ri+f2Wg+jHuK49uPpuooduc=;
  b=UXlzdz+rpvIeoE1sxeD+VSlHhztDZ8oUr/zLMp+/UgWLLkmTgSXdy2yB
   LRoO8L3JIG3J8WD0/IyiGHcAna4MmmS8xr+rYwQCa4cCszMI5UYTnsb0S
   5XzDcNAHSC0URrk9xkWa+5at1xLy3pnHaAFaqATrRKWxMyvK8MBXrMFVO
   LCLIqLDn1mtcHjz+M302V70JJk5hAUvLPQCT719almxLyMuAs3Q7p/kZs
   biJtixsiNnhw5MNwR2T3HLprezHYTo6WZR7RZRhuW+OChsAWUmPdGqAji
   L7UrqfA1ey6U7VIhgf+idr3OfOLnSsQBYNulT4ezESl6QgOMwqNCAWVs/
   Q==;
X-CSE-ConnectionGUID: ar0bRjD9SX6J+b08YY7Q/Q==
X-CSE-MsgGUID: FjP3IsaMTISiAm0hvEfSdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3327920"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3327920"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:25:17 -0800
X-CSE-ConnectionGUID: TnkoF7cSQhGSY4qBUZnvsQ==
X-CSE-MsgGUID: fs1JvJIRS5GJfJVCmUIcXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8612454"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:25:10 -0800
Date: Thu, 12 Nov 2026 18:25:07 +0200
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
Subject: Re: [PATCH v12 7/8] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Message-ID: <avXoY3vG0JgNdWYJ@ashevche-desk.local>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
 <20261111-submit-serial-8250-dma-cancel-v1-v12-7-9e3456bc2555@gmail.com>
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
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-7-9e3456bc2555@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 03:16:32PM -0700, James Hilliard wrote:
> The generic RX timeout path pauses a transfer, copies its data and
> terminates it asynchronously. Clearing rx_running at that point lets a
> new receive reuse the buffer and cookie while the old callback has not
> yet run. Inspecting the new cookie cannot distinguish that callback from
> the completion of a new transfer.
> 
> Reserve the receive buffer until a worker has drained the canceled
> callbacks. Keep FIFO access separate from callback retirement: after a
> successful pause and termination, clear rx_running while rx_terminating
> prevents another descriptor from reusing the buffer. Deliver the paused
> data before allowing the interrupt handler to drain the FIFO through PIO.
> Normal retirement only releases ownership and leaves subsequent receive
> handling to the UART interrupt.
> 
> Preserve the normal completion-path LSR read and gate DMA resubmission on
> the receive interrupt enable, so stop_rx() prevents another transfer while
> the status read retains its existing side effects.
> 
> Reject new flush work and PIO receive handling during shutdown, including
> late Intel MID DMA timeouts. Stop and drain retirement work before freeing
> the channels and buffer. Once RX has stopped, allow the idle flush used by
> DesignWare LCR recovery during shutdown. Clear the shutdown guard before
> startup configures the UART and tests its interrupts.
> 
> Check pause failures before accessing the buffer. A successful pause is
> the quiescence guarantee, even when a provider still reports IN_PROGRESS.
> Also accept DMA_COMPLETE after a failed pause: completion can stop the
> channel before its callback acquires the port lock, leaving nothing for
> the provider to pause. Retire that completed transfer normally.
> 
> A failed pause with an incomplete cookie is ambiguous: hardware may have
> finished while its completion interrupt is still pending. Initially retain
> the transfer and retry pause and status in the worker. Mask receive
> interrupts to prevent a timeout storm and keep callbacks from copying or
> resubmitting this worker-owned transfer. Back off retries from 1 ms,
> allowing completion and shutdown to wake the worker immediately.
> 
> After one second of unsuccessful pause retries, stop the transfer with
> dmaengine_terminate_sync() outside the port lock. An indefinite wait could
> otherwise leave a request/response peer waiting for data that is stuck in
> a partial DMA buffer. Report that recovery discards the pending payload:
> without a stable residue it cannot safely be copied. Keep rx_running,
> rx_pause_pending and rx_terminating set until termination has stopped DMA
> and drained its callbacks. Then restore receive handling and allow another
> DMA descriptor, without latching a permanent PIO fallback for a pause
> timeout. This trades the stalled transfer's data for continued reception.
> 
> If synchronous termination fails, retain ownership and retry with a delay
> that doubles from 1 ms to one second. Report the first failure and ongoing
> failures every five seconds for this recovery. Completion and shutdown
> wake the retry wait; shutdown takes over final channel retirement. A
> permanent termination failure still leaves RX masked and its storage
> reserved: the pause retry budget does not guarantee recovery from a
> provider that cannot stop. Each flush starts with a fresh retry budget.
> 
> RX DMA admission already requires cmd_pause. A provider whose hardware
> cannot pause must advertise that correctly. If pause nevertheless returns
> -ENOSYS or -EOPNOTSUPP for an incomplete transfer, enter synchronous
> recovery immediately. Unsupported pause, DMA_ERROR and asynchronous
> termination failure retain the error fallback to PIO until reopen.
> 
> Keep the requested enables in the existing IER shadow and filter hardware
> writes during pause retries and recovery, including termios, RS485 and
> overrun-backoff changes. Apply the current enables after retirement so
> stop_rx() and shutdown remain effective. Hold a runtime PM reference
> around worker register accesses.
> 
> Abort the DesignWare idle sequence when RX cannot be stopped. Allow the
> empty-FIFO timeout workaround once DMA has released the FIFO, including
> while callbacks retire. Exclude FIFO resets during RX DMA recovery.

...

> +static void serial8250_rx_dma_flush_work(struct work_struct *work)
> +{
> +	struct uart_8250_dma *dma = container_of(work, struct uart_8250_dma, rx_flush_work);
> +	struct uart_8250_port *p = dma->port;
> +	unsigned int delay_us = 1 * USEC_PER_MSEC;
> +	ktime_t start = ktime_get();
> +	bool recover, retry, restore_rx, fallback;
> +	bool timed_out = false;
> +	int ret = 0;

Once set, it gets never cleared.

> +	guard(serial8250_rpm)(p);
> +
> +	for (;;) {
> +		scoped_guard(uart_port_lock_irqsave, &p->port) {
> +			/* Shutdown cancels this work and drains both DMA channels. */
> +			if (dma->shutting_down)
> +				return;
> +			/* Serialize reset with completion and shutdown notifications. */
> +			WRITE_ONCE(dma->rx_pause_wakeup, false);
> +			retry = dma->rx_pause_pending && !dma->rx_terminating;
> +			if (retry) {
> +				ret = serial8250_rx_dma_try_flush(p);
> +				retry = dma->rx_pause_pending && !dma->rx_terminating;
> +				if (retry &&
> +				    ktime_ms_delta(ktime_get(), start) >= 1 * MSEC_PER_SEC) {
> +					dma->rx_terminating = true;
> +					timed_out = true;
> +					retry = false;
> +				}
> +			}
> +			recover = dma->rx_err || (dma->rx_running && dma->rx_terminating);
> +			fallback = dma->rx_err;
> +		}
> +		if (!retry)
> +			break;
> +		/* Notifications also cover completion or shutdown before sleeping. */
> +		wait_event_hrtimeout(dma->rx_pause_wait, READ_ONCE(dma->rx_pause_wakeup),
> +				     ns_to_ktime(delay_us * NSEC_PER_USEC));
> +		delay_us = min(delay_us * 2, 1 * USEC_PER_SEC);
> +	}
> +
> +	if (timed_out)
> +		dev_warn(p->port.dev, "RX DMA pause timed out: %d; discarding pending data\n", ret);

So here is the potential to get timed_out == true and stale ret. Yes, I see
that code couples them, but the logic of the above is quite complicated.

The scoped_guard() piece better to be in a separate helper (and replaced with
guard()() to make it on indentation level down).

> +	if (recover) {
> +		if (serial8250_rx_dma_terminate(p))
> +			return;
> +	} else {
> +		dmaengine_synchronize(dma->rxchan);
> +	}
> +
> +	scoped_guard(uart_port_lock_irqsave, &p->port) {
> +		restore_rx = recover || dma->rx_pause_pending;
> +		dma->rx_pause_pending = false;
> +		dma->rx_terminating = false;
> +		dma->rx_running = 0;
> +		if (dma->shutting_down)
> +			return;
> +
> +		if (!restore_rx)
> +			return;
> +
> +		/* Apply the current enables, including any intervening stop_rx(). */
> +		serial8250_out_IER(p, p->ier);
> +	}
> +	if (fallback)
> +		dev_warn(p->port.dev, "RX DMA failed, using PIO\n");
>  }

...

Overall it makes me think if this is a common DMA issue when we try to stop
ongoing transfers, shouldn't it be solved once for all somewhere in DMAengine?

-- 
With Best Regards,
Andy Shevchenko



