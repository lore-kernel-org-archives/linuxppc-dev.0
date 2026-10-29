Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D6606B6E7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P2ugtpaC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFmZl1VWgz30RN;
	Fri, 30 Oct 2026 01:19:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793283583;
	cv=none; b=DQs1vMUrfIU4ZUbHPhISdOxVwYbUTVO1ULOp2FpY1b1/akK+sOmvMBc4A0DmS/N2TKmDbJKxDOJ+LYIQnUKRlIUzhbyGeBsTYvPDgqdZtQz73AxLZv5KFLPDxGbvflDmGn/ZkQflr+WLk1DrjJB1QZ79xa0lmXFF7/bwzqI+lCtQ4+A0bfJCMG7fI5AnOFoo4RJJQvBMWgLeomv/w5H6NzCFoF4x5ZWFu4UwjdOIYAoPJae5qpLq3xN8bQAUPUwgH7PpkIM+kM6PXLplUbjCSNbPooM0f5M3KIp285n92DDPgUDBL8lFGSoT7RNkB6YwsAsXctivepKu4JxifC3i0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793283583; c=relaxed/relaxed;
	bh=0t7g2WC+b9FztvwqiERlUGDT4mF51ROculYuxl9U52o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZJK1G/oFPl3UnjN40OsJjqpMGumSKTMiV1+DwIPZ9KnM2eoX7+N2U7hm8dJnAgG6OGofmMX8/RDQ/nUwLM/uxjp1WH4twhUEvz9l1w7aIQCygE3b1dIiC1sCeI1Hpn+t/3TNriDWbdKmKg8ie+yfs9QM3gv8t2pYChFQsEVjiojEGGByFT7VXMBTAulYXNLVsYzZAF1lF+XBzNoTYkoieKWIF52o9iRzNl19ABCazHWXCbClYe/F+XWAn4VQP1kjwXH/l0kfM34JSqBNvQULSv1KiO4X7KmqPH6zLsq+BiS6xR5iIgl1GbDUw/pIWFJ2AN9NivNcPpizlx4UHXg6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P2ugtpaC; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P2ugtpaC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFmZj6Yghz2yjN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 01:19:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793283582; x=1824819582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ks0QnF665NpX8S1B9/P4xaJFMSaRvnc+QpU5Vun1o38=;
  b=P2ugtpaC5ZywUSLFtAdmujFqrPVyyBNCcVWNKcwB5fCSYUEToFGQLv1u
   4bMkB5fojJ2zVy3LX6MrYnLePZXpDBb3YIlnk1Q2w/UGel+DZH/r1s3aD
   pz1iIyD9G/PmblNHU2GZVQE4uy/YZr81gBktY8VpB91sWh9BrVq1Y1w8h
   zEKHOSY8HNXSFb3ueVzyte315/YTZVAIU2hdLQJN7w+Gnyz2pBxS4uXs8
   lTezWr3DY9xaJYAoCEoY47zs4yvUGAbNnCXJnG2og3IlIwzeAk0fKCc9E
   hZU/Rdz1a9Rkl+wLGSCs8BK+LNXgtFcv7i+8gf8+DwEeOv7ksTxTTuutF
   g==;
X-CSE-ConnectionGUID: /zDj4EY6TBGiExu4XziYHA==
X-CSE-MsgGUID: 7c9DpqPTTnemPoQL7f3j9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1934267"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1934267"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 07:19:34 -0700
X-CSE-ConnectionGUID: QyJOQ8qDTY+boqh3NJr+/A==
X-CSE-MsgGUID: 7B3JJIPERS6eyiaI7RVCSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5119312"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 07:19:28 -0700
Date: Thu, 29 Oct 2026 16:19:25 +0200
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
Subject: Re: [PATCH v8 4/6] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Message-ID: <auNV7Vco5O3vVwRH@ashevche-desk.local>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-4-3fd56ba352ed@gmail.com>
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
In-Reply-To: <20261029-submit-serial-8250-dma-cancel-v1-v8-4-3fd56ba352ed@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 01:37:00AM -0600, James Hilliard wrote:
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

> -	bool			shutting_down;
> +	bool			shutting_down:1;
> +	bool			tx_terminating:1;
> +	bool			tx_flushed:1;

What is the meaning of bool XXX:1? Have you checked with `pahole` the result?

-- 
With Best Regards,
Andy Shevchenko



