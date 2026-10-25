Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9DA606A31B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Oct 2026 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rq+NaXAV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCKzc2yVJz2xWt;
	Mon, 26 Oct 2026 02:14:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792941260;
	cv=none; b=KEZnda4OXVK9PAH8OR/XddggqhDnHRM9d81D6kD9JcNUnxdW02ICjWXNXf2s/Bsd6CXvruuJf2mmdoe/aMaFVlJEFXgurcNqZaugBgX/9OtPw07DpFSW64qhLk706xYxMQDcfJG6fxL17xZBJ1uttzU8939NrfYf8+/nsbddnQGlnkaBfz0xlisHv/ZHehwpDK0hTZPfUD/kMfJhRBwOAVGwV/vY90g5ryldhKG5+GlfPtSVLlBbMmBPDbrT9U0P18xyW7cju74Z4j4tqhrlz6Jloxj2arhCVr8WgfOg3IUYk/lSu65o5ytLHAVd9Fgyl3isnTHHZsynlKLP94xw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792941260; c=relaxed/relaxed;
	bh=EanEzITabyL5hHZuLfjLX/O3m0p6a+JE+WfvVu35z0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqIr5q5EGz5mwwrbaGhKNrXx2+vSROSzbpVwDmK1qwn2luS89N6fHQJuvSXyCSZ5N7GXIbYBA0zwvttHto7huxghNXhERThXN+iUEZSsadkHNxr7LeNaRgjfI7o8mRs2CgqFKV0sDRsJB1xODzlbRHBBxlBQNvf7kw4bsYS0pjpg3JZL9jiq4wCMODS8hP+Ag0JIWdKZIt/i+Pe4+blVW5eUZXFGDFs3GtvC6y1gOAb/Pr5NtZJKarm6uiXAjRJoS9rwjzrW2qn7dQ+v736eOPl9AlWLQ7DJe7x1Ka9XUGIDcFVCCzOGkJGTbEgN57jk3iw9M7FnTJDKWAYSjM4lLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rq+NaXAV; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rq+NaXAV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCKzb04kLz2xKQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 02:14:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792941260; x=1824477260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nMuoICu3+/kegamQPU1fMK0Jut2zai+WN1izIEFxGgY=;
  b=Rq+NaXAVxJwMfDxr00d0vim5ENGx4ZqBmKoR0I8TUyxmbMobASniyrYk
   F+9ktHA+jKr863bcozvP3eYeekICOVZCr4xDHWUbrQJjhqo/CrOH6Uv/8
   P4Kc0jEoo2KeeMlcquF43TNIFU3/wn+SL3PjUWe2GK6moHJJKnU6wFOD5
   tbb+/ybpTMN/n/C9jJAkPgGNSCEv5Xh0rFcwJgrGdZ2IZQY8o4OXaX6rB
   tqLFDhgFSierKTqR5II0G5HHZ/DUhxeART7zH47HVfmGJFPgA+DfGbNha
   d+jBT0qgVjPo+cQ7A22ID1LnVn5KuibJ72GuPHc4s/hy4hRZLqvFBqRC2
   g==;
X-CSE-ConnectionGUID: cA1GWN4zQdaLyJCf3Wh68A==
X-CSE-MsgGUID: a7SdewjxTfWeGY8XqkD4cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1623523"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1623523"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 08:14:15 -0700
X-CSE-ConnectionGUID: RDohAcVYTJKTr0jTExw2+A==
X-CSE-MsgGUID: leqgv13GQjy/DN5fHtD87A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4188329"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 08:14:09 -0700
Date: Sun, 25 Oct 2026 17:14:06 +0200
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
	Timur Tabi <timur@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 2/5] serial: serialize asynchronous write wakeups with
 the port lock
Message-ID: <at4cvnsjHndzY5o3@ashevche-desk.local>
References: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v6-2-6f366591f566@gmail.com>
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
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v6-2-6f366591f566@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 24, 2026 at 02:52:27PM -0600, James Hilliard wrote:
> uart_write_wakeup() expects the UART port lock to be held. Several worker,
> DMA completion and interrupt paths call it without that lock, including
> indirect calls from uart_handle_cts_change() and the transmit helpers.
> 
> Take the port lock around these notifications or their transmit helper.
> Keep sleeping SPI and regmap accesses outside the locked region, and keep
> the FSL LPUART completion lock held through its wakeup. Acquire the port
> lock after releasing private channel locks to preserve the ordering used
> by UART callbacks. In the MUX timer, publish available FIFO space under
> the port lock and keep the hardware FIFO-drain wait outside it.
> 
> Use IRQ-safe locking in the Atmel RX and TX tasklets and SB1250 termios
> path, since their interrupt handlers now acquire the same port lock.
> Preserve the caller's interrupt state when releasing those locks.
> 
> Serialize CLPS711x TX servicing and its interrupt-enable state with the
> port lock. Disable TX interrupts without waiting in stop_tx(), since a
> threaded handler may need that same lock. Have an already queued handler
> leave stopped output untouched, and drain it outside the lock during
> shutdown before the transmit FIFO can be released.
> 
> SCCNXP handles interrupts under a controller lock which its UART callbacks
> acquire with the port lock already held. Collect the ports needing wakeups
> while servicing the controller, then release that lock before taking each
> port lock and rechecking the wakeup threshold. Removal drains the IRQ or
> timer before unregistering the ports.
> 
> This serializes write notifications with port-locked serial-core state
> changes, allowing readiness and transmit-storage reservations to gate the
> notification without a check-versus-shutdown race.

...

> -static void sccnxp_handle_events(struct sccnxp_port *s)
> +static unsigned int sccnxp_handle_events(struct sccnxp_port *s)
>  {
> +	unsigned int wakeup = 0;

unsigned long

>  	int i;
>  	u8 isr;

> @@ -491,20 +491,43 @@ static void sccnxp_handle_events(struct sccnxp_port *s)
>  		for (i = 0; i < s->uart.nr; i++) {
>  			if (s->opened[i] && (isr & ISR_RXRDY(i)))
>  				sccnxp_handle_rx(&s->port[i]);
> -			if (s->opened[i] && (isr & ISR_TXRDY(i)))
> -				sccnxp_handle_tx(&s->port[i]);
> +			if (s->opened[i] && (isr & ISR_TXRDY(i)) &&
> +			    sccnxp_handle_tx(&s->port[i]))
> +				wakeup |= BIT(i);
>  		}
>  	} while (1);
> +
> +	return wakeup;
> +}
> +
> +static void sccnxp_write_wakeup(struct sccnxp_port *s, unsigned int wakeup)

unsigned long

> +{

> +	int i;

Why is 'i' signed?

> +	/* UART callbacks take s->lock with the port lock already held. */

> +	for (i = 0; i < s->uart.nr; i++) {
> +		struct uart_port *port = &s->port[i];
> +
> +		if (!(wakeup & BIT(i)))
> +			continue;

NIH [1] for_each_set_bit()

> +		scoped_guard(uart_port_lock_irqsave, port) {
> +			if (kfifo_len(&port->state->port.xmit_fifo) < WAKEUP_CHARS)
> +				uart_write_wakeup(port);
> +		}
> +	}
>  }

NIH syndrome is one of the weakest points of AI, please, read and study
the code you are changing.

[1]: https://en.wikipedia.org/wiki/Not_invented_here

-- 
With Best Regards,
Andy Shevchenko



