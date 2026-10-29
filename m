Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7103A606A32D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JPsPhQ+i
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFmXz1HpQz30RN;
	Fri, 30 Oct 2026 01:18:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793283491;
	cv=none; b=Nd4w4l0CsFrJBYRsAtmxDFyaaV4kC5g1rDJMFi8kE+ZyWkUycoInwwkn/uhazSFj+hCw/xj8kt/AXvYvu+QOhfYU0xPEVS1hZurhG35ccKOwGasij7zlyb0G4Bu+7O9rbJ3e5iZueqDKzk/134S+uIPYrL71EyK0fOSeqvK1MKypt+vAtJ0qHVjHcuhtBxxESiHHbLJtKjAshOqdB5fQR+PBOiuIvxP5+O6orwgW78weoKqILWUJ38WaBOkRYAKzINQlrcB2e6U7OUAmxO9pmlk7Sj6tC2SflJjvnJr8a9bBVE31Cm9plko/DRaXJlQNcjA1JvLvuL7TY0TRTqgJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793283491; c=relaxed/relaxed;
	bh=sIAQApOwnlBHdqOEDUSf5m4YrfU7jMgmgx2VS57GmCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKPBK9YqRo+cDwubM1Rd0G4P8nCc8VeeL3qxtHUCxVQusd56tpEupYCJsLSOiegHOwy4QDa6w3a4Cn27+bYDnppRWw+7+PMzvG/XcQzLwGya4N1WiDwDz+LgJ+Jv5o2bIHzn0OxAJULJC+08+UtE/LETW6pbNrf+Y6Z3i1vYbEmxed/raBGkgF4Cbh9tKZZ9rHenqp+2/tK701xiQPzt1sINvLgeiSwd4b9TpOpX97EcHj7Bsn0Hb+UKrez/auM5A+9xHBuXa6zT6PWNWiSOfzTytPY7FSmI+I3WaV0MTPhq2XxyjW56ftQ8dboEKAy+dwxHiDLfGDX/Peo4xW73XA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JPsPhQ+i; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JPsPhQ+i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFmXw2NdTz2yh4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 01:18:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793283489; x=1824819489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iUgkTmbEVGLMzWydqtXX3ASQZZhoDtXfz4hj/j8HhZA=;
  b=JPsPhQ+iqmhcmfei8hPyg8PsqQZhbEMqgtk+DGxqarO5dyYEiuX/euUD
   h/z71GBe7tRoYOCfXO1don0h3nkPQt4M3G1cwJakPFOGKH1SOokbucfTD
   HPwjQOM7wdWw8GSMOmNHCuPHjrMSKlfBD5hQ7dTJxPCClZoK+c8grFc4z
   lB4jcJfa98iFZEM4t+IQrkitkeWooUGvyup+r7Vn7Ra2G9Pq14207DopM
   +5tYzxpf6QTYy4Mv2/bxjLsM4Jc9sGEjypI5pmVr+3TfHkQ87n9QRXjpY
   ltS8M8EbW9TEOTNmEJZnojgpLcFns6bEjyx2iZk9hgsVGbeV0eqGLGmcR
   w==;
X-CSE-ConnectionGUID: UnMJhK3pQCKoBMbbK1/sUQ==
X-CSE-MsgGUID: XgkyHEKtSjWSnGJj3smrAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1920063"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1920063"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 07:18:04 -0700
X-CSE-ConnectionGUID: T8QAYLthTXiOO95NU/4lBA==
X-CSE-MsgGUID: hFAuv5gvS4KywM5Cg6kQPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5148330"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 07:17:57 -0700
Date: Thu, 29 Oct 2026 16:17:55 +0200
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
Subject: Re: [PATCH v8 2/6] serial: serialize asynchronous write wakeups with
 the port lock
Message-ID: <auNVk_Y8iiAXyFa3@ashevche-desk.local>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-2-3fd56ba352ed@gmail.com>
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
In-Reply-To: <20261029-submit-serial-8250-dma-cancel-v1-v8-2-3fd56ba352ed@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 01:36:58AM -0600, James Hilliard wrote:
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

> static irqreturn_t serial21285_tx_chars(int irq, void *dev_id)

>  	struct uart_port *port = dev_id;
>  	u8 ch;
>  
> +	guard(uart_port_lock_irqsave)(port);

Why _irqsave?

>  	uart_port_tx_limited(port, ch, 256,
>  		!(*CSR_UARTFLG & 0x20),
>  		*CSR_UARTDR = ch,

...

Same Q everywhere (it might be legit in some cases,
it might be too strong in others).

-- 
With Best Regards,
Andy Shevchenko



