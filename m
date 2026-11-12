Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A726606A332
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PBxxXyd8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQQn76QGnz2xVY;
	Fri, 13 Nov 2026 03:28:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794500923;
	cv=none; b=ecOrN6Gx9HHmf9wKk+FXuH83oAr+BI0LKCr93mxIRtL4YSGpNPcNLNawpHO9mYX2VUnBpMqPnfAVtMP5s1iIuVeZtSqizUB2ATCdZotbZTVi69IAYK+q4jKzz4ves6Yfn1NiNzmnTf5Lkn9H6+nMrdqUmRggKQRYuD30nrAKHVFHuRCRxv1ma8Db7RN6sMhUTudam/2GTORPsRs9KkVfaFX9+1kGQdpvvf/ppTRsCwlV0H6K38wxqkb5tjeo0USspGXT2Xw6KuxzCOQQw4ESUfanrc2huwmkLxtfbUKYHhIkzxBe35J3APe03k2XgzXby+hbXy2OVxvHTIM8k6SglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794500923; c=relaxed/relaxed;
	bh=pRpWiPIA4DrUOnjtuQAu5NcMUWFxkdWpzhrlxObt3ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjS20fjXRU98OGA2PIoYUX6TL6JeAv1Cxiw87HwfgO/n7lP+URTnquyhtX9zrNg8F9yy4CqyedYkkV7ZtugvZnEtn9ON/p32mXRSCiy9um6u7tjYPWZh6SrjnTqwZXhxa2CG3OWL4c64NJzvYUiZMcGJWrgzDvgPipHGeRG41u5Qu3ice73+K4uwb3u7S513DBJgEhB1MVZXGV6ydb8DvQLxqmc9ZlGmsYtGbyirbpNEBef/Fv7FUA+P81cGCsvLUZMXO3CwuOE0PKwpu4I6QvANOuuIxTKXjKZ8fHH58NTlAZLOsDtSNZhP3SYHHQNXVEgHoUzzWAIOc0yOgAOSRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PBxxXyd8; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PBxxXyd8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQQn4744Cz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 03:28:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794500921; x=1826036921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sslNQ9t4xM278pmgtdvt48t5+fW2uzyCfGO3Z4539zQ=;
  b=PBxxXyd8/S4l4BJjJj/9KYM7GNO85MaZ415zcSCJfIN+kWD8IbBS9U9s
   ocA60UJj2EwUalKIk+TqmfDjtq82Cbqmd8Jqz8GgjTxOml4pIh1K1aps2
   RmNyxas6xFF5SnAyIoeuMonGdH6Qh8lR0LdfnJaRHXv0BNnJo0S4zP/oh
   cHw8XQMbR8KgZFTMiCao3PuasSLep90ehV1sJota98uXvIHH3VxZfGCl4
   pI67yPX1tpRCU/c2oCWigWxeqY4OyyEToxoOpIml/YRJ2qCQMrfh9IALz
   D9xkS9Dhkz0sa8CPPcnIWGa9NNBeEff9P2lWnssk0CWQXd4GXi8hPd4Lm
   w==;
X-CSE-ConnectionGUID: KudgM/IfSNmWFX4pW7BFRA==
X-CSE-MsgGUID: kAxKJ4H4SYibogQxgIcyKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3328554"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3328554"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:28:37 -0800
X-CSE-ConnectionGUID: QwynKHKvQhyg7yRdcyHipg==
X-CSE-MsgGUID: wXpMW8M6QPu66Rlr12+fkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8613701"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:28:30 -0800
Date: Thu, 12 Nov 2026 18:28:27 +0200
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
Subject: Re: [PATCH v12 8/8] serial: 8250: retain DMA resources when
 termination fails
Message-ID: <avXpK70Fh7kkJGOg@ashevche-desk.local>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
 <20261111-submit-serial-8250-dma-cancel-v1-v12-8-9e3456bc2555@gmail.com>
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
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-8-9e3456bc2555@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 03:16:33PM -0700, James Hilliard wrote:
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
> activity; neither delay is a hardware timeout. Report the initial failure
> and ongoing failures with the elapsed time and current RX/TX error codes.
> Track the five-second progress-report interval separately for each
> teardown, so failures on different ports are reported independently.
> Report recovery once both channels have stopped and drained.
> 
> A permanently failed DMA engine blocks close or removal. This deliberately
> retains the buffers, mappings, channels and callback context until the
> provider can establish that they are no longer in use.

...

> +static void serial8250_terminate_dma(struct uart_8250_port *p)
> +{
> +	struct uart_8250_dma *dma = p->dma;
> +	unsigned int delay_us = 1 * USEC_PER_MSEC;
> +	ktime_t start, last_report;
> +	int rx_ret, tx_ret;

> +	rx_ret = dmaengine_terminate_sync(dma->rxchan);
> +	tx_ret = dmaengine_terminate_sync(dma->txchan);
> +	if (!rx_ret && !tx_ret)
> +		return;

Why not check these already in the loop? See below.

> +	start = ktime_get();
> +	last_report = start;
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

I believe with refactoring this to do {} while () we may deduplicate
the dmaengine_terminate_sync() calls.

> +		fsleep(delay_us);
> +		/* Retry promptly at first, then limit sustained retry activity. */
> +		delay_us = min(delay_us * 2, 1 * USEC_PER_SEC);
> +		if (rx_ret)
> +			rx_ret = dmaengine_terminate_sync(dma->rxchan);
> +		if (tx_ret)
> +			tx_ret = dmaengine_terminate_sync(dma->txchan);
> +		if (rx_ret || tx_ret) {
> +			ktime_t now = ktime_get();
> +
> +			if (ktime_ms_delta(now, last_report) < 5 * MSEC_PER_SEC)
> +				continue;
> +			dev_err(p->port.dev,
> +				"DMA termination still failing after %lld ms: RX %d, TX %d\n",
> +				ktime_ms_delta(now, start), rx_ret, tx_ret);
> +			last_report = now;
> +		}
> +	}
> +	dev_info(p->port.dev, "DMA termination recovered after %lld ms\n",
> +		 ktime_ms_delta(ktime_get(), start));
> +}

-- 
With Best Regards,
Andy Shevchenko



