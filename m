Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA8F606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FsVrGbKu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNlYs02xVz2xQs;
	Tue, 10 Nov 2026 09:58:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794265088;
	cv=none; b=Uh0g4ytfd5dHaiv1b4RaW2sU0+IMxc/nt0A0Hq/L09GlBCnjrNViJOx6Yg7CgaFUVfe/5pj73P7SJTM9NHDu5ncnC3xNHDR21K/OyNbVA9XWc5GDQLz7d2bfCKUxDetch8vI5WzF/nxZydizkXy/eokdmzhke4LfmzImcmfahJW2ZjoV3NU1dBOZFRey6kuuTwGBNG9Ep1qSsPtFlr86plepFsD3PCHOGgI/c8yuE+qXlxBlYmc9MGTBop0Ja3cFgwUtSVcX/SPT92JkmtB8Ou9jfBPhuUmO9iY9aGTZqEh5P8Zy9key2m/WD4/UDY5S9XT3WNESwOmyUAtLpykYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794265088; c=relaxed/relaxed;
	bh=APuVGr9Syfi20cMf1JwWjHvFw/aqU07E3GrFheF9DSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWuvDyO6pXmzoMXi+8RCe+bnCPbQTsl+NC5akmDaWI793EmCL8QA5xLN8ZCdHt8DIfMplr2Y+HbsX/TKlgbLRABPDn9ax+DtssnPlJ8FRYVHY6kiwYxWdj/w8hstwNg575MzxD0h4X1iPP+14YI3wIiBSi8eIrupENEROmbglTWVTtBuYbjsnVCNbsLbCp1k+cd57hRogYxyScqlCMbNjyh9Wt3+XT3Aec7T0h+aOWybgvi2SStloW13hXhh2NOpvqSNbFRGcjQvCYPumtLDsikTPKuxOSm1b42JIB29VwkXVGWn3UGcQfNmUVFBGuU19NmsEqrj9kY9xI/a6Yf6Jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FsVrGbKu; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FsVrGbKu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNlYp0f6Bz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 09:58:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794265087; x=1825801087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gLk2yVe76ajtu1KrWCk+zmfgNuAUqzVJtyq7tY5vbag=;
  b=FsVrGbKusY3w35d4jgjD1OV7FLK/246BI7YERo8QmG2XNkvPWU0ONktl
   yXkI8s51nVuc1DRjTsbMafmFtJ0wFMeCX/CTu7ZnGhXCgh1yxOje3Yn3v
   279sLThYFryWXd2CBHXQHTxFke7bcQy0qifbkXxEOIZnwFAkRKmOMBZRP
   VXFfX1caRjF8IJJoL9/ykm3G7B4s/H/MBzFZ8/Cq1W1ipaWR8EsKj35GQ
   y3C5eOcNh+lQWZvayAOiRlzJor7bkF0Da1Bze9sTqHs5Ig2ndhj8f2edD
   ZrrYXZlacfQM9skEawaMyVRv6lYfjx1w8Cx4LKcUOORWkCvGCs4/CAFmD
   g==;
X-CSE-ConnectionGUID: 1dxZ+CswSiO2RkkhiPRLRQ==
X-CSE-MsgGUID: /QUCI89fSU2TXrM+V5AVMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2899345"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2899345"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:58:02 -0800
X-CSE-ConnectionGUID: T3RHJ0ZVRUiHpNbWBPbDdg==
X-CSE-MsgGUID: /OnDlxXBTTKRLkahbt7bZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7998415"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:57:55 -0800
Date: Tue, 10 Nov 2026 00:57:53 +0200
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
Subject: Re: [PATCH v10 2/8] serial: serialize asynchronous write wakeups
 with the port lock
Message-ID: <avJP8Sym_LQX9UVc@ashevche-desk.local>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
 <20261108-submit-serial-8250-dma-cancel-v1-v10-2-e6227ddb95b1@gmail.com>
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
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-2-e6227ddb95b1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 08, 2026 at 08:50:11PM -0700, James Hilliard wrote:
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
> Use plain port locking in hard-IRQ handlers and in helpers whose callers
> already mask interrupts. Atmel status handling is also called during
> resume, where lock_suspended is acquired with interrupts disabled; JSM
> interrupt processing holds its IRQ-saving board lock. Keep IRQ-saving
> locking in workers, tasklets and other mixed-context paths.
> 
> Take the port lock after requesting the ST ASC interrupt and hold it
> through startup's transmit servicing and RX interrupt enable. The transmit
> helper can notify writers even when the FIFO is empty, and serial core
> calls startup without holding the port spinlock.
> 
> Use IRQ-safe locking in the Atmel RX and TX tasklets and SB1250 termios
> path, since their interrupt handlers now acquire the same port lock.
> Preserve the caller's interrupt state when releasing those locks.
> 
> On SB1250, lock modem-state updates after reading and filtering the change
> status, and wake modem-status waiters after unlocking. Take the TX lock
> inside its service routine so RX-only interrupts need no acquisition.
> Keep that lock across x_char handling, FIFO consumption and the decision
> to mask TX interrupts: a writer must not enqueue data and enable TX between
> the empty-FIFO check and the interrupt-mask write. Each TX invocation sends
> at most one character.
> 
> Serialize CLPS711x TX servicing and its interrupt-enable state with the
> port lock. Disable TX interrupts without waiting in stop_tx(), since a
> threaded handler may need that same lock. Have an already queued handler
> leave stopped output untouched, and drain it outside the lock during
> shutdown before the transmit FIFO can be released.
> 
> SCCNXP handles interrupts under a controller lock which its UART callbacks
> acquire with the port lock already held. Collect the ports needing wakeups
> in an unsigned long bitmap while servicing the controller, then release
> that lock before visiting the set bits, taking each port lock and
> rechecking the wakeup threshold. Removal drains the IRQ or timer before
> unregistering the ports.
> 
> This serializes write notifications with port-locked serial-core state
> changes, allowing readiness and transmit-storage reservations to gate the
> notification without a check-versus-shutdown race.
> 
> Cover DZ TX servicing and JSM Classic modem notifications as well. On
> DECstation ZS, acquire the port lock before the SCC lock and notify writers
> after releasing the SCC lock. Defer normal TX restart after console output
> to a worker, since console output can already run under the port lock.
> Check transmitter readiness before consuming another character and drain
> the restart worker during shutdown and removal. Release Lantiq's hardware
> lock through the transmit helper's completion hook before notifying the
> line discipline.

...

> --- a/drivers/tty/serial/sb1250-duart.c
> +++ b/drivers/tty/serial/sb1250-duart.c

> -	if (delta & (M_DUART_IN_PIN0_VAL << S_DUART_IN_PIN_CHNG))
> -		uart_handle_cts_change(uport, !(delta & M_DUART_IN_PIN0_VAL));
> +	if (!(delta & ((M_DUART_IN_PIN2_VAL | M_DUART_IN_PIN0_VAL) <<
> +		       S_DUART_IN_PIN_CHNG)))

Just keep it a single line.

> +		return;
>  
> -	if (delta & (M_DUART_IN_PIN2_VAL << S_DUART_IN_PIN_CHNG))
> -		uport->icount.dsr++;
> +	scoped_guard(uart_port_lock, uport) {
> +		if (delta & (M_DUART_IN_PIN0_VAL << S_DUART_IN_PIN_CHNG))
> +			uart_handle_cts_change(uport, !(delta & M_DUART_IN_PIN0_VAL));
>  
> -	if (delta & ((M_DUART_IN_PIN2_VAL | M_DUART_IN_PIN0_VAL) <<
> -		     S_DUART_IN_PIN_CHNG))
> -		wake_up_interruptible(&uport->state->port.delta_msr_wait);
> +		if (delta & (M_DUART_IN_PIN2_VAL << S_DUART_IN_PIN_CHNG))
> +			uport->icount.dsr++;
> +	}

...

> --- a/drivers/tty/serial/sccnxp.c
> +++ b/drivers/tty/serial/sccnxp.c

> -static void sccnxp_handle_events(struct sccnxp_port *s)
> +static unsigned long sccnxp_handle_events(struct sccnxp_port *s)
>  {
> +	unsigned long wakeup = 0;
>  	int i;
>  	u8 isr;
>  
> @@ -491,20 +492,40 @@ static void sccnxp_handle_events(struct sccnxp_port *s)
>  		for (i = 0; i < s->uart.nr; i++) {
>  			if (s->opened[i] && (isr & ISR_RXRDY(i)))
>  				sccnxp_handle_rx(&s->port[i]);
> -			if (s->opened[i] && (isr & ISR_TXRDY(i)))
> -				sccnxp_handle_tx(&s->port[i]);
> +			if (s->opened[i] && (isr & ISR_TXRDY(i)) &&
> +			    sccnxp_handle_tx(&s->port[i]))
> +				wakeup |= BIT(i);

__set_bit()

>  		}
>  	} while (1);
> +
> +	return wakeup;
> +}

-- 
With Best Regards,
Andy Shevchenko



