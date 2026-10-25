Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EA1606A31F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Oct 2026 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iBvgtqkk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCKts3kvgz2xKQ;
	Mon, 26 Oct 2026 02:10:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792941013;
	cv=none; b=ZS0AI5qTqp1yRhHNPgFsUXzSXRji5HQ3KQmRmc8FChNMXoEng+29/Om0WR6fMhCT7C6x2/dZeiTB9xgyAKCdChLJsEK3N9JixTLUXKmXawbQvqJfzot40ETbXfRNyIacYSWV+DbZHOLwWID290CPurOMZDwFzmCplWYheYZTB5ekov3XFKXdNZ/2elEmxejg8G0qHrQz0feunJK/WkHl6JvCo1wleI8Z98lu3uYxlW6FMKCHfHinJyrtDiC7pA5Atisj9buJ4WwMyOco2N6MJXXPdq5aaQo1BkSySWIbDY4bYHkITgFEC9ujhv0kHooPd76jtOYNuejVthGneMqBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792941013; c=relaxed/relaxed;
	bh=g9Cjhr9HIGyxWaiefhej0MIXutOky0k6Ipx1aCyOOYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtFwNN+QvrRU0MNhfADI8mH8xqIvhs25FgXAaUbTYLb+v0HP+g9yHOIRgADGTn66OUtxAYQc0UapxMjiTWxq7+aUkGYiZDjq5m9hfg3TwhhKEQKrVkiX/BIdeZr0QcE5xCNllNCQSfAcOq+r38ujyW/65ClqMGNFvHvE0KY4vbNwGYkiFf/gva0DOoRC7H5iXu/s6VssK3WWg0H1ncqvMa/QWdFfaE824PUVXT5UWp/knP0ZfJIftbwjmQwu83ktEXLGILqlrqynTebjyzNzKtVyeOUVQ1koArHU0PzA0XzmxZTAmKSKHUHfzD+dco6RD5R+l//ZDy+ev2sZRkVh6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iBvgtqkk; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iBvgtqkk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCKtn6BPfz2xKN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 02:10:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792941011; x=1824477011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sA5QKtn9sanR6lQV8toNGWBsgGwYIwudn1w2NIqY2pw=;
  b=iBvgtqkkYvVK9PfQvjVpkCvTUZLBBZ+F0BTLnsA86mnlePjZon36PraV
   tunaUwR1VI9xVriSz3e6S2ez4Iel142rd0wg5nFm6iBUdvnbPiDyvXnwX
   VazC18mZDBI4RHSWK2XONENzyAnJdjXq5GPvYAZ9pcAbRfeXTQqtFh2I9
   DretmHayCRlpikKNc/f5BLvCslTtovWX8zpz53Wbea41GRtlYhEuV4zvX
   QlQkbYIgzBw8Te0VcWnNcWkLac7HTsev708MSZCWKWMJbcJoWyO01jtba
   EF+qk4WgtNEobpHk86XZR27i7vG3kqvuc64rpU53qbZPSUcVLNDXxaSwV
   w==;
X-CSE-ConnectionGUID: PhRNW25FQzywOSbNqRW7DQ==
X-CSE-MsgGUID: p5gY8LyIQmiCKXmnNgaoTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1514237"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1514237"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 08:10:04 -0700
X-CSE-ConnectionGUID: m5yKUqx3Syu8lkGMnczCnA==
X-CSE-MsgGUID: IKd3c9pGR1yxq5RGFZfCAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4150612"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 08:09:57 -0700
Date: Sun, 25 Oct 2026 17:09:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: James Hilliard <james.hilliard1@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
Message-ID: <at4bw-G8czG-G7Wl@ashevche-desk.local>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
 <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
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
In-Reply-To: <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 05:10:03AM +0000, Maciej W. Rozycki wrote:
> On Sat, 24 Oct 2026, James Hilliard wrote:
> 
> > uart_write_wakeup() expects the UART port lock to be held. Several worker,
> > DMA completion and interrupt paths call it without that lock, including
> > indirect calls from uart_handle_cts_change() and the transmit helpers.
> 
>  Fair enough, and thank you for the cleanup and spotting the issue in the 
> first place, however...

He already issues a v6. I think the tactics against AI contributions should be
to not answer for a week or so until there will be a quiescent week. At least
that's what I learn from this patch storm.

-- 
With Best Regards,
Andy Shevchenko



