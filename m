Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C1606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hRKyZ2T5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFmgr430gz30Sv;
	Fri, 30 Oct 2026 01:24:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793283848;
	cv=none; b=VxaMkUyI59JYFi/hv8+i4hmai1J3i5M/ZjgqpODvQzrE9BelSl+Oo5BroMYlsSFW/o2YtN/b8UrRJ7M+iXsdSg0JXzrXJBwwW9qnaCt6jXNBHxOq/+1CQAhqtCCYajOmeJfBOXiAPB6ruWGhD+wCR3ta+/2eLNn3jcJZuEZF6jArgaDa7f1Bb3HTil+tSlY7rU5rFWvwaOtMkUjL2ysneI9caGAE499qW6bIm5vxs20sr+P1OIWd/H1yvcM68V6ev7mRbS/BWJvIh8wqdYknR5eK73/qKN9zwyp0N/VlVk03XWE640g24TQL4HKMvPk/PCIAFNugex9G0f1wWEfF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793283848; c=relaxed/relaxed;
	bh=YOVZz2rEk4lZKDa87ycfgL661H0zQluemrPyROYbb/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuD8n3Gfg3JT2VdDG+PA6TdsMtk2mAO7mvIRzAs2UN+dXkkYC25XILRx35Vp1/D4PeSmtMEqDD1Bte4XSKS0YQG6fCLODZiQR9V3Bn5e47B5vNi7Py+HY6YGkbexdrChmq40FrIjlTvyyHn0WoqMge4SHEryfZS+17TzjtID49qxBmKdps4SBOb6LClN0l29Jwf3omFt6o30c6pk+kL0WHf6Ro/guRJ0BnlAPWj3TDf3sVgB3/0QsJtSfuz18rQzkwzLJhi9n3LG9wPYnwBCP1wmpEbk7rWDsi//LcIi36rQpfTs/YcGlK01YANi6XVMlvxnEzwD6oSyYtiGQ91tWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hRKyZ2T5; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hRKyZ2T5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFmgq1695z30RN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 01:24:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793283848; x=1824819848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WhRRgDbVMLz+/BSdD0pXKUEHAh8FgmgnlTctJGj8+kQ=;
  b=hRKyZ2T5rStdMrjEOw2V/4x5IwKIEDTc/DG7eMPHkcGpl7BGy7THut2K
   GzhrKivyjXz+SG8uXRN8dtjCzhaRet2tK4OimdE/qat+4sQitGNooHJ1G
   1lfnNrcub9thzP0sQHWeM4VaqCTeGUIknjhwzHezGq0ZZ7jsvOlGLw6iG
   yhDRXh75Cp90n1fkp6r9XCNxoGU9+FXkNmaBjLtlaK1kVGYpPzPTahzU6
   EBVud5ty9OSbZdbFjEyZskoG3T/EuoJ74eXsYyhMhJkPG3k7v8C9Q3T+M
   kEt7z7/xtTVXxqPwouFSdwb9MSLdYmE4aOsCG7riGmZf8dqgtNqy4X8gk
   w==;
X-CSE-ConnectionGUID: qlI7bkqIS66uM64JZX1XzA==
X-CSE-MsgGUID: 3NwOffTeSc6pOMlRvyAxNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2054101"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2054101"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 07:24:05 -0700
X-CSE-ConnectionGUID: D+lewELqRqCYi5Up37o2Mw==
X-CSE-MsgGUID: HmFeHfhUSC2AV3hAqUA+YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5293371"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 07:23:59 -0700
Date: Thu, 29 Oct 2026 16:23:56 +0200
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
Subject: Re: [PATCH v8 6/6] serial: 8250: retain DMA resources when
 termination fails
Message-ID: <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com>
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
In-Reply-To: <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 01:37:02AM -0600, James Hilliard wrote:
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
> A permanently failed DMA engine blocks close or removal. This deliberately
> retains the buffers, mappings, channels and callback context until the
> provider can establish that they are no longer in use.

...

> +	while (rx_ret || tx_ret) {
> +		dev_err_ratelimited(p->port.dev,
> +				    "DMA termination failed: RX %d, TX %d; retrying\n",
> +				    rx_ret, tx_ret);

> +		msleep(100);

Huh?!

> +		if (rx_ret)
> +			rx_ret = dmaengine_terminate_sync(dma->rxchan);
> +		if (tx_ret)
> +			tx_ret = dmaengine_terminate_sync(dma->txchan);
> +	}

This is unacceptable. Sleeping is okay, but value should really match the
baudspeed and other parameters of the transfer.

-- 
With Best Regards,
Andy Shevchenko



