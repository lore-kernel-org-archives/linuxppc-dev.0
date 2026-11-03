Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0C606A337
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BnnhUOVB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJwfn5GwSz2xdX;
	Wed, 04 Nov 2026 04:34:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793727249;
	cv=none; b=SNr/6B71ewswWNJ/98DM//NwlQc0V8Z/ogGnKMqnsPmZZ5MlFmrkS6FwchS2OUpDt4FhyKHxOav8ExX0CpJeyStfalQ1BPddGh+myAlN8RZc213Fxria7WHldGt+iuqlbsiJ1ypXRrcH//GcYul8r6S5TUs9mxthyr9CpCj2aud0ToKhuef6FZaAPa3Dbp+BF4RhHXasRaCbckYhLwebFWK2e+50F8GtqecM579YNamNuAtrIEbMNqKRq0II314Qj7rFxrDTSv8y6KjqcPjo2VqzrEh2KPbpbqwaFKnsDWN9MWQNF/jQA+9RvspjQmkDDBnfc0+AubcZKovc1pfu2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793727249; c=relaxed/relaxed;
	bh=9UcRpPSsRhlipdcCEsDUgVHpPcmKiyEddVOVJ0G9Q8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=do2OJ0BSRaREHeLraFO9fJAoQ2XbvD55w5iQPRADqV9SjDVZ2TGW7pN1/v2ZMkjKFTHiJTyHdb1yePVWSsK6UJwIWMvRQXOQkoXCex9EGpfnfpy8H1xIrw5MIxBgJHgXXa+8xqBWAHrLOC5yc90jwUCwdKci/vVs9/9LckcQYPbyx8CRW2oojTnhqEyXg0+X1SyTm5i2jIXIfgZMuPg9GjqtF44bFyRDEFC4dxOhKw2Tf0Az8hH8HZ3wr65rr4sBEUiZt19jC4X1k/Xl2PQJLaUGMVkVK+G3ZBBGExN4DgiNPp/kxitHTR3KcPbnLBONDyEb87dBvC59kZNoJne3dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BnnhUOVB; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BnnhUOVB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJwfk5S4lz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 04:34:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793727248; x=1825263248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FmHbGGcycCrMITeIaxJ+abCxz6KIp/2jkTTgvrkruIQ=;
  b=BnnhUOVB6vzUZI1dz4FhBOnZMDo6I/HfAZU8LSsWQnfZyJ7bei97Fb68
   kRFiUgU8RYWPQsSlv+6d2FK2PNfS4lEOkFU1UDmZo0s4HMujgwyWkcgcP
   7gbnNI5jPl7IQ6/k7EzlMG7TS3b1ABb6T3+FQUgRiGY/ZMsi50LEhqt7g
   vE0awVOsmwnyoxU7qMcLMACx52XqU4vQhDdYRA5FmchD78JGyiRJshhro
   74L8itAAtwujURhla4UlTIOHBxx/aFXKTxbwVKGGfjCTJ04qTe+dSxEXp
   nGW5plPEkueUuyswZVvfMsHiQSjJohAJYHZ/PzqZtpJnIudHjprWcSNSL
   w==;
X-CSE-ConnectionGUID: +eY4NVrbSqq0PXmTtaYABw==
X-CSE-MsgGUID: cA9PIS9eQqar7Yw4yDCQGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2554129"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2554129"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:33:45 -0800
X-CSE-ConnectionGUID: doqn3+hwSlmHUiX0nFomXA==
X-CSE-MsgGUID: yJkRR5kfSE6zDCY2IToN7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6497402"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:33:38 -0800
Date: Tue, 3 Nov 2026 19:33:36 +0200
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
Subject: Re: [PATCH v9 7/8] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Message-ID: <auoa8OWBxqaQuKRq@ashevche-desk.local>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-7-9159caade148@gmail.com>
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
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-7-9159caade148@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 04:14:34PM -0700, James Hilliard wrote:
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
> finished while its completion interrupt is still pending. Canceling that
> descriptor can discard the entire completed receive buffer and switch
> permanently to PIO. Retain the transfer and retry pause and status in the
> worker, with receive interrupts masked to prevent a timeout interrupt
> storm. The worker copies only after a successful pause or reported
> completion, then terminates and drains the old callback before reuse.
> The pending-pause guard keeps callbacks from copying or resubmitting the
> transfer concurrently.
> 
> Start pause retries at 1 ms and double the delay up to one second to limit
> CPU use during persistent failure. Sleep outside the port lock on a timed
> waitqueue, with completion and shutdown publishing a wakeup under the
> same lock as the worker's retry check. This also catches notifications
> arriving just before the worker sleeps, avoiding a full backoff delay
> after completion or during shutdown. Reset the delay for each new flush.
> Report a stall lasting at least one second once per flush, rate-limited
> across repeated stalls. A provider which never pauses or completes retains
> RX ownership until an error or shutdown; a timeout alone cannot establish
> that discarding the buffer is safe.
> 
> On DMA_ERROR or termination failure, let the worker stop DMA before
> handing the FIFO to PIO. Keep the requested enables in the existing IER
> shadow and filter hardware writes during pause retries and recovery,
> including termios, RS485 and overrun-backoff changes. Apply the current
> enables after retirement so stop_rx() and shutdown remain effective.
> Hold a runtime PM reference around worker register accesses and keep RX
> on PIO until reopen after a confirmed error.
> 
> Abort the DesignWare idle sequence when RX cannot be stopped. Allow
> the empty-FIFO timeout workaround once DMA has released the FIFO, including
> while callbacks retire. Exclude FIFO resets during RX DMA recovery. If the
> provider still cannot terminate the channel in process context, retain
> its buffer and leave receive interrupts masked.

...

> +static inline bool serial8250_rx_dma_running(struct uart_8250_port *up)
> +{
> +	return up->dma && up->dma->rx_running;
> +}
> +
> +static inline bool serial8250_rx_dma_recovering(struct uart_8250_port *up)
> +{
> +	return up->dma && (up->dma->rx_pause_pending ||
> +			   (up->dma->rx_err && up->dma->rx_terminating));

Slightly better formatting is to put some line breaks.

	return up->dma &&
	       (up->dma->rx_pause_pending || (up->dma->rx_err && up->dma->rx_terminating));

Alternatively

	if (!up->dma)
		return false;

	return up->dma->rx_pause_pending || (up->dma->rx_err && up->dma->rx_terminating);

> +}

> +/* Keep the desired enables in up->ier while RX DMA recovery masks hardware. */
> +static inline void serial8250_out_IER(struct uart_8250_port *up, u8 ier)
> +{
> +	lockdep_assert_held_once(&up->port.lock);
> +
> +	if (up->dma && up->dma->shutting_down)
> +		ier = 0;
> +	else if (serial8250_rx_dma_recovering(up))
> +		ier &= ~(UART_IER_RDI | UART_IER_RLSI | UART_IER_RTOIE);
> +	serial_out(up, UART_IER, ier);
> +}

...

>  	struct tty_port		*tty_port = &p->port.state->port;
> -	struct dma_tx_state	state;
> -	enum dma_status		dma_status;
> -	int			count;
> -
> -	/*
> -	 * New DMA Rx can be started during the completion handler before it
> -	 * could acquire port's lock and it might still be ongoing. Don't to
> -	 * anything in such case.
> -	 */
> -	dma_status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> -	if (dma_status == DMA_IN_PROGRESS)
> -		return;
> -
> -	count = dma->rx_size - state.residue;
> +	size_t			count = dma->rx_size - state->residue;

No need to put too many spaces between type and variable name.
(Yes, the first one will be left untouched.)

...

> +static void serial8250_rx_dma_flush_work(struct work_struct *work)
> +{
> +	struct uart_8250_dma *dma = container_of(work, struct uart_8250_dma, rx_flush_work);
> +	struct uart_8250_port *p = dma->port;
> +	unsigned int delay_us = USEC_PER_MSEC;
> +	ktime_t start = ktime_get();
> +	bool recover, retry, restore_rx;
> +	bool warned = false;
> +	int ret;
> +
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
> +			}
> +			recover = dma->rx_err;
> +		}
> +		if (!retry)
> +			break;
> +		if (!warned && ktime_ms_delta(ktime_get(), start) >= MSEC_PER_SEC) {
> +			dev_warn_ratelimited(p->port.dev,
> +					     "RX DMA pause stalled: %d; retaining transfer and retrying\n",
> +					     ret);

_ratelimited() is a slop of AI without understanding the code. It makes nonsense
in combination with warned.

> +			warned = true;

Altogether NIH _once().

> +		}
> +		/* Notifications also cover completion or shutdown before sleeping. */
> +		wait_event_hrtimeout(dma->rx_pause_wait, READ_ONCE(dma->rx_pause_wakeup),
> +				     ns_to_ktime(delay_us * NSEC_PER_USEC));
> +		delay_us = min(delay_us * 2, USEC_PER_SEC);
> +	}
> +
> +	if (recover) {
> +		ret = dmaengine_terminate_sync(dma->rxchan);
> +		if (ret) {
> +			/* Retain ownership and keep RX masked if DMA cannot be stopped. */
> +			dev_err(p->port.dev, "failed to stop RX DMA: %d\n", ret);
> +			return;
> +		}
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
> +	if (recover)
> +		dev_warn(p->port.dev, "RX DMA failed, using PIO\n");
>  }

...

> -void serial8250_rx_dma_flush(struct uart_8250_port *p)
> +int serial8250_rx_dma_flush(struct uart_8250_port *p)
>  {
>  	struct uart_8250_dma *dma = p->dma;
> +	int ret;
>  
> -	if (!dma || !dma->rxchan || !dma->rx_running)
> -		return;
> +	lockdep_assert_held_once(&p->port.lock);
>  
> -	dmaengine_pause(dma->rxchan);
> -	__dma_rx_complete(p);
> -	dmaengine_terminate_async(dma->rxchan);
> +	if (!dma || !dma->rx_running)

You introduced a helper serial8250_rx_dma_running(). Use it.

> +		return 0;
> +	/* A late interrupt must not hand a still-active receiver to PIO. */
> +	if (dma->shutting_down)
> +		return -ESHUTDOWN;
> +	if (dma->rx_terminating)
> +		return -EIO;
> +	if (dma->rx_pause_pending)
> +		return -EAGAIN;
> +
> +	ret = serial8250_rx_dma_try_flush(p);
> +	schedule_work(&dma->rx_flush_work);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(serial8250_rx_dma_flush);

...

>  	/* Manually stop the Rx DMA transfer when acting as flow controller */
> -	if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_running && rx_timeout) {
> +	if (quirks & DW_UART_QUIRK_IS_DMA_FC && rx_timeout &&
> +	    serial8250_rx_dma_running(up) && !up->dma->rx_terminating &&
> +	    !up->dma->rx_pause_pending) {

Re-wrap it logically (also be consistent with parentheses
when & versus && is used).

	if ((quirks & DW_UART_QUIRK_IS_DMA_FC) && rx_timeout &&
	    serial8250_rx_dma_running(up) &&
	    !up->dma->rx_terminating && !up->dma->rx_pause_pending) {

>  	}

-- 
With Best Regards,
Andy Shevchenko



