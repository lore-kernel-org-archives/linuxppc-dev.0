Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D24606A31C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 31 Oct 2026 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GMBBpezE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGs2p4d71z2yDm;
	Sat, 31 Oct 2026 19:44:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793436258;
	cv=none; b=EzLOQ2oeJEwS3HYa0NtGUM+5+BxOcAqSS9sojaQl1cC+YifgbS+QYcYoToY6tT7WgKA0mBRrAtFuPMDCNwAhg7pH247oGSycrwFe5ZxxmF35z+5jKe+JJWBSXbqEwlsDT5MQltYiWyPl+euoT3XCJNGs20gD5LbMbLo3Y7QO3oIBVJ6BUNv5W5FQXoqtkaupzQpMfRdad6TskxdxyFW9nLxesxVaWjzWRsCWodN3O8UHpByf4f9pI073AWQ2YpSKFFLkCDOs4XeC5/M4/pM7WDiYukU/tcLNZjwjp+9wa6Hs3/I9biQiOtJSwPeuMGC65tkrwHbF8ntQUmjkAxqaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793436258; c=relaxed/relaxed;
	bh=W7C9cpmzdFca870tYxpXsF2MjrgsKkdtNJLk6fjsOEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpytksoIyv73BRG+gPvf4GRIGQyl20rOtBrFfTEle1A/8DqkBrQf4ZCLuv+4LDZQaWcEsm0Nqw3eNKH3m9LEh8/7cDRAH5sz+bFWgVA/QktxFKrXSs/CfqptVbvCrpW1fcZFiA6fn7SyRcuVvp8qtgP8PFySxLxT2KBGwNDN3tRuSeUR0FNKZwR817xwX13YwchPeE25E4YSKBaUBtoDQwkkpE4wqLWTWY7MkKdtJ16a3BAJBZGbXj+7P2dP6rdSTdpw72pWI/CaNLg/i+RbX/Tui9mzPceVbU9+LwvcsauutUOxmFiJguzkN5lMlTd3h7rKEXN/CAvjmGjDwMIusg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GMBBpezE; dkim-atps=neutral; spf=pass (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GMBBpezE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGs2l2pp3z2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 19:44:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793436255; x=1824972255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wn8SFowoel5epk8m5Si6mxTN8wfKc2MuePpSe+sjbLY=;
  b=GMBBpezE7VNrLtXUl7S1WHZ8MkZgQKrorh6y+YH9DzoOIrgCy0TfVp91
   B3RkMMtjaKmx2FU0gqItdv2rFbN5Jz5/0b8updrXvbIU8U9rl+zn83km3
   DO13db97yyeRJK3nYMP/tVGIYOaBoNQs84wJuBg4/BLg+zGxjKwHEoBAS
   zHx316GZkIVvJcKPkLdE3x7oUwwhJH4gWo3LvjLiHayYviPQsXG5uE1/S
   4zgF6pRgVabYAo7nL/kPabXEJAIUAaJAyF2hpCfJ01gC4uY0MYb3+0vLq
   Up1K5RKwDCWt+lu5h2SCGMf0GEin0QXpRjE7PSVhRc6hGz5MM/wS8+Vmo
   A==;
X-CSE-ConnectionGUID: p0blEECrQBCE7Moi3WHNiQ==
X-CSE-MsgGUID: IhN2YsPlS2mlXA61QWFF+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2185105"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2185105"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 01:44:08 -0700
X-CSE-ConnectionGUID: kFJld0R6TF22hO1251niqA==
X-CSE-MsgGUID: vR+J2NnMRyGUqn4j6kuC/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="6184723"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 01:44:03 -0700
Date: Sat, 31 Oct 2026 10:44:00 +0200
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
Message-ID: <auWqUIBUs0_7bnGU@ashevche-desk.local>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com>
 <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local>
 <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
 <auRl9ztbav4nHi7U@ashevche-desk.local>
 <CADvTj4p8tjwdftg+H11ob0iaBZKxXrTdkSmhfZHjOYunm5tr9w@mail.gmail.com>
 <auTZtteCFnuoMD3p@ashevche-desk.local>
 <CADvTj4rXXAEnTyu_AzpF41a2YSHHG1ANozCUSePBoH3QZYbBQg@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4rXXAEnTyu_AzpF41a2YSHHG1ANozCUSePBoH3QZYbBQg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 12:08:52PM -0600, James Hilliard wrote:
> On Fri, Oct 30, 2026 at 11:54 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Oct 30, 2026 at 11:09:53AM -0600, James Hilliard wrote:
> > > On Fri, Oct 30, 2026 at 3:40 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Oct 29, 2026 at 11:19:59AM -0600, James Hilliard wrote:
> > > > > On Thu, Oct 29, 2026 at 8:24 AM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Thu, Oct 29, 2026 at 01:37:02AM -0600, James Hilliard wrote:

...

> > > > > > > +     while (rx_ret || tx_ret) {
> > > > > > > +             dev_err_ratelimited(p->port.dev,
> > > > > > > +                                 "DMA termination failed: RX %d, TX %d; retrying\n",
> > > > > > > +                                 rx_ret, tx_ret);
> > > > > >
> > > > > > > +             msleep(100);
> > > > > >
> > > > > > Huh?!
> > > > > >
> > > > > > > +             if (rx_ret)
> > > > > > > +                     rx_ret = dmaengine_terminate_sync(dma->rxchan);
> > > > > > > +             if (tx_ret)
> > > > > > > +                     tx_ret = dmaengine_terminate_sync(dma->txchan);
> > > > > > > +     }
> > > > > >
> > > > > > This is unacceptable. Sleeping is okay, but value should really match the
> > > > > > baudspeed and other parameters of the transfer.
> > > > >
> > > > > This sleep is backoff after dmaengine_terminate_sync() has returned
> > > > > an error, rather than an estimate of UART transmission time. Each
> > > > > retry asks the provider to stop the channel again; elapsed time is
> > > > > never treated as evidence that the resources are safe to free.
> > > > >
> > > > > The particular 100 ms interval has no hardware-derived justification.
> > > > > However, I don't yet see a sound way to derive the retry cadence from
> > > > > baud rate either. RX can be waiting for input, TX can be held by flow
> > > > > control, and callback retirement is a separate requirement from
> > > > > moving bytes through the UART.
> > > > >
> > > > > Do you have a particular provider failure mode in mind where retrying
> > > > > termination should follow the serial transfer timing? I'd like to
> > > > > base the interval on the condition that can make termination succeed,
> > > > > rather than substitute a wire-time estimate for an arbitrary delay.
> > > >
> > > > Termination of DMA sometimes require to clean up internal FIFOs and other state
> > > > machines. That's what happens on HW side. In the software waiting for too much
> > > > may lead to the very big undesired latencies. The value of 100ms sounds insane
> > > > to me for the HSUART cases (megabaud range of speed). Also note, not every PCB
> > > > design uses HW flow control, so this may be even worse for them.
> > >
> > > The 100 ms interval can add unnecessary teardown latency if a failed
> > > termination becomes retryable much sooner. There is no hardware-derived
> > > justification for that particular value.
> > >
> > > The FIFO/state-machine draining is part of the provider's stop sequence.
> > > For example, DW performs its FIFO-empty polling inside
> > > dwc_terminate_all(). If termination succeeds, this patch proceeds without
> > > the retry sleep, regardless of baud rate. The sleep is only reached
> > > after an error during DMA release, not during normal RX delivery.
> > >
> > > Baud rate can influence how quickly a transmit FIFO drains, even without
> > > flow control. However, the termination error does not tell 8250 whether
> > > that drain is still progressing, how much remains, or whether the
> > > controller needs a different recovery operation. That distinction matters
> > > when choosing a retry interval: a shorter interval reduces the added
> > > latency, but does not establish that retrying can recover the channel.
> > >
> > > There is also a specific API detail here: dmaengine_terminate_sync()
> > > returns immediately if device_terminate_all() fails, without reaching
> > > dmaengine_synchronize(). Consequently, an error leaves callback draining
> > > unconfirmed as well. The retry cadence can change, but resource release
> > > still requires successful termination and synchronization.
> >
> > Most likely this is AI slop. I can't see the justification for 100ms.
> > Can you explain that?
> 
> 100 ms was an arbitrary backoff to avoid a tight retry loop if
> termination keeps failing. It was not derived from the baud rate,
> FIFO depth, or a DMA provider's recovery timing.
> 
> That motivation explains sleeping between retries, but not choosing
> 100 ms. I don't have evidence supporting that particular interval.

Yep. And that's what my point is about. Any big sleeps has to be explained
and justified.

> > > > > Regardless of the retry interval, shutdown cannot release the buffers
> > > > > until the provider establishes that DMA and its callbacks have stopped.

-- 
With Best Regards,
Andy Shevchenko



