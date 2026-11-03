Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6339606A32C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A61xRQmx
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJwhl4rRsz2xdX;
	Wed, 04 Nov 2026 04:35:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793727351;
	cv=none; b=fmnwKjwzO7iZTf3m9wYOVN3tSjRFjMPD8lFw/QMNeFaa3RRfmDU8lpgx3+ZU3icW30nTZq6McIZ1RX5x7sBwm/ddoLQ+nP5hBwYAjdBL1GrkvNPRNDgkTl28pJDGtccxfAyEnZbxRfzBcVMUVnuiTaABHIhP5Bb0k6vF95VX13U7nMujImqbK2GgKRVGSxwUssl/pF5L8U/LQm7y5BOSXdOTeL93VF8mZrHPCDDQqlvNQVLt//OF9vLC7pOKocv65IyAZR785/r0UShvTT3m5y/BC3yNLkz3PGyy5kRH/8sRikiitQ7Ns6siogn7uVaubx9Te678j0Tggi6f1Jzb7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793727351; c=relaxed/relaxed;
	bh=OMTWKoka/WJZWYrKcZxYXVvF/9BfOI9GPrShvLim+Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfkAuRzaBf4sHEVVRDapG6isPtnj3hNLC6ANH3L4hIHimtHZIZgq/M/0is9CG+ZO0K/BTsYGMpxJ7P/NhSbjwzP+YaTwelOChGiwYCSyc53SvxZJtXctSxZF35YfR9xERExoCOdSTgpwk3M9yOApIKpXzRLB2E7ov9B9wBFMjPq70ekgB9TH2UmifwNd9WacmGCW29aQ3MT4l6iWZsFyNexNVUthz8XgtnP66dmbSTLIt7+1hyYmWTkJXsL13bTPR4Ghvzb4Q/4yvXxWNlgo1u2RmstPc6sPt8diPDEYvnZakxoGM8gcuniNWF7FARagh+NZgR0V5blTxZlyX8sZRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A61xRQmx; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A61xRQmx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJwhk3xjRz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 04:35:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793727351; x=1825263351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fIwZFXRauHVGTvmkvF0p5ts2dhitRW5zxXOPkRVPeoQ=;
  b=A61xRQmxJjfRGbEV4ycXWOVC98QR+ObHwXO2h4TPkGJbd8EbZdJnIVhZ
   NebSQm4yWEOug8YfvHLAsuIZb3jA+SfBgOIu62Yz9oC5+XEzUljqTnn0c
   YIU9V1a5+xt67t9BSPl+ofQn27W9tzLhxemTwcaZqpE3+goLIBAmSgAsl
   jCIZdb86KZoBVmpi6Xu9R38+MKTiNQnn1ek0bUFfUhQ1vdQu1rJVoL2kS
   jMEo4TeBnFvQduZYAMUe0u6EQEQOqSITTqksjDN1GenYfb/gEa5NzOVrX
   ZIZF6GvaVz3Ryl6zD0vnQjFjDR30hGU58DHwkKNAO3aZX3RJ53OGuEo33
   w==;
X-CSE-ConnectionGUID: b7WJ6RSPT/axQDfLcetBdw==
X-CSE-MsgGUID: 0jO5paNfRceQdDU8CospPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2554348"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2554348"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:35:49 -0800
X-CSE-ConnectionGUID: cOWXPWO/THODlghOQi+WaA==
X-CSE-MsgGUID: yU58d79/R8mJ9+oiuIlMKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6498070"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:35:42 -0800
Date: Tue, 3 Nov 2026 19:35:39 +0200
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
Subject: Re: [PATCH v9 8/8] serial: 8250: retain DMA resources when
 termination fails
Message-ID: <auoba7ZhfzaMTkzw@ashevche-desk.local>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-8-9159caade148@gmail.com>
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
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-8-9159caade148@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 04:14:35PM -0700, James Hilliard wrote:
> serial8250_release_dma() ignores the return from dmaengine_terminate_sync()
> before freeing the coherent RX buffer, unmapping the TX FIFO and releasing
> the channels. If the provider fails to stop a channel, the DMAengine
> wrapper returns the error without synchronizing its callbacks. Hardware
> or a detached callback can then access the released storage and state.
> 
> Checking the error and returning early would not preserve their lifetime:
> serial core frees the TX FIFO after the driver's shutdown callback returns,
> and port removal can then release the callback context as well.
> 
> Require successful synchronous termination of both channels before
> releasing any DMA resources. Retry failed channels after a sleep outside
> the port lock, leaving channels that have already stopped and drained
> alone. Keep the shutdown gate and storage reservation in place throughout
> the retries.
> 
> Start retries with a 1 ms sleep and double it up to one second. This
> makes short-lived failures responsive while bounding sustained retry
> activity; neither delay is a hardware timeout. Report the initial failure,
> rate-limit ongoing failures with the elapsed time and current RX/TX error
> codes, and report recovery once both channels have stopped and drained.
> 
> A permanently failed DMA engine blocks close or removal. This deliberately
> retains the buffers, mappings, channels and callback context until the
> provider can establish that they are no longer in use.

...

> +static void serial8250_terminate_dma(struct uart_8250_port *p)
> +{
> +	struct uart_8250_dma *dma = p->dma;
> +	unsigned int delay_us = USEC_PER_MSEC;

Don't use multipliers without a number, it's harder to read (when syntax
highlighting is on) and follow in general.

1 * USEC_PER_MSEC

> +	ktime_t start;
> +	int rx_ret, tx_ret;
> +
> +	rx_ret = dmaengine_terminate_sync(dma->rxchan);
> +	tx_ret = dmaengine_terminate_sync(dma->txchan);
> +	if (!rx_ret && !tx_ret)
> +		return;
> +
> +	start = ktime_get();
> +	dev_err(p->port.dev,
> +		"DMA termination failed: RX %d, TX %d; teardown blocked\n",
> +		rx_ret, tx_ret);
> +
> +	/*
> +	 * Shutdown cannot return while DMA owns storage or callback state:
> +	 * serial core frees the TX FIFO afterwards, and removal frees the port.
> +	 * Retain both channels and retry outside the port lock. A permanently
> +	 * failed DMA engine therefore prevents teardown from completing.
> +	 */
> +	while (rx_ret || tx_ret) {
> +		fsleep(delay_us);
> +		/* Retry promptly at first, then limit sustained retry activity. */
> +		delay_us = min(delay_us * 2, USEC_PER_SEC);

Ditto.

> +		if (rx_ret)
> +			rx_ret = dmaengine_terminate_sync(dma->rxchan);
> +		if (tx_ret)
> +			tx_ret = dmaengine_terminate_sync(dma->txchan);
> +		if (rx_ret || tx_ret)
> +			dev_err_ratelimited(p->port.dev,
> +					    "DMA termination still failing after %lld ms: RX %d, TX %d\n",
> +					    ktime_ms_delta(ktime_get(), start), rx_ret, tx_ret);
> +	}
> +	dev_info(p->port.dev, "DMA termination recovered after %lld ms\n",
> +		 ktime_ms_delta(ktime_get(), start));
> +}

-- 
With Best Regards,
Andy Shevchenko



