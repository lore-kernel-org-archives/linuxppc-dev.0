Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB63606A326
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c3vq2DPa
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGTHv2PFRz30Vd;
	Sat, 31 Oct 2026 04:54:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793382859;
	cv=none; b=TU+y2HG0MWnRlOW2Enl9Z+YFp/Vod3cN3CdIEYqTlt+2trVqsIYzXpgdFhFuhPsCx0XoXXWCgFTIBGFqd8LShJb+zVYGhQi549l8ie2Ol/lKqGvhx1UbBaitUv/ZLEAiQvLrFl0/Az5RPHXykl2WIhvP9NCxKmAB6+SOg2gdOtQ2OrxN9iToJv/Rok16Crxi9oCCYKs2AcUHF/ZubiWgShVE/BRwzKQGr9uIDOugJjXDxTjSojY74HCQ4BmDNtZsT7KZF1PY45Jh4exlwiABHaELPgjj3fPskbBk59/9l/P/6o5kDImJ6PypHV4aIdu4J71FhMx+kPr4lbUyiNQkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793382859; c=relaxed/relaxed;
	bh=vFtK92loJ0xr1IzJVV1xwMCKKp55jpNQBYy00GgLoCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8v+qaC1SarbZ3gcvodIjZTmRBEUEWx9KQ8j9YEuIjkOonEcR4JrYUZea82Cf45JMchrAYYtPPc7xUPqRyByIAKRhgKCsxiZ1hFatySZMtShgU7K4EDC4VZ62/wN3eiMgR9VwvipbBfA5Otuey/oAQyRppA7G84vdn6PnxXg7URrSitpi8Mu4kvhNCbWGfbzkPprl0UqvMIVUbCNn5ct3D4/lMKtlNR5VxomabvU5hdrFoZgsfqdYLw4TAOBel5e5AKWRtWQO9IeXP4g7mrbWOTd33NOSag5Eq8MejZux4bFOQIfXi6Tprun+kYZB0pDICraaxbobe4zB9mER4DOdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c3vq2DPa; dkim-atps=neutral; spf=pass (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c3vq2DPa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGTHr5JMKz30Tf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 04:54:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793382857; x=1824918857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IzqHLossDmxKbFc+aGxUKjOQbcSxP3c6buURWcuw2Tc=;
  b=c3vq2DPa4SSxYYevp+7LCov83tzDkMxAqjh5PljlYD3c2j2y0GKPasFw
   I7czM/OIYTdAVlG0V2WPMxM4hF72L6nDGoSbOgsYHGQUbZX3SBy4RH8ri
   U16usVo2INn+m8hV014YFAJ/4Y35yXLZH39NdVlRGV1JaRnw313e6ZPab
   BmiO5/I7bmVxcnLoaBs0dYM56AUf+srJ99L8uefa+LvReiEDEiuAzQorb
   yz2FeVOxH2lAgBFArpbV7YPyPvJZ0q5RmxfIsB7y8VIioEu8nu/zeQCqN
   DDkIkE1oQDLhkhIFoaTGiciEPOi/kPNWhflW1pB6D3uTprRXMe8YNFk40
   A==;
X-CSE-ConnectionGUID: shO6o40HTLiJz0aPs/ETcA==
X-CSE-MsgGUID: uG7o7MkaTGaHFpUdfK0drw==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2170313"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2170313"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:54:07 -0700
X-CSE-ConnectionGUID: 4l33Hy4iTb6mNx52iAPxHQ==
X-CSE-MsgGUID: aoBFLn+ZRDe7lWiftDeSQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5516478"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:54:01 -0700
Date: Fri, 30 Oct 2026 19:53:58 +0200
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
Message-ID: <auTZtteCFnuoMD3p@ashevche-desk.local>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com>
 <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local>
 <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
 <auRl9ztbav4nHi7U@ashevche-desk.local>
 <CADvTj4p8tjwdftg+H11ob0iaBZKxXrTdkSmhfZHjOYunm5tr9w@mail.gmail.com>
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
In-Reply-To: <CADvTj4p8tjwdftg+H11ob0iaBZKxXrTdkSmhfZHjOYunm5tr9w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 11:09:53AM -0600, James Hilliard wrote:
> On Fri, Oct 30, 2026 at 3:40 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Oct 29, 2026 at 11:19:59AM -0600, James Hilliard wrote:
> > > On Thu, Oct 29, 2026 at 8:24 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Oct 29, 2026 at 01:37:02AM -0600, James Hilliard wrote:

...

> > > > > +     while (rx_ret || tx_ret) {
> > > > > +             dev_err_ratelimited(p->port.dev,
> > > > > +                                 "DMA termination failed: RX %d, TX %d; retrying\n",
> > > > > +                                 rx_ret, tx_ret);
> > > >
> > > > > +             msleep(100);
> > > >
> > > > Huh?!
> > > >
> > > > > +             if (rx_ret)
> > > > > +                     rx_ret = dmaengine_terminate_sync(dma->rxchan);
> > > > > +             if (tx_ret)
> > > > > +                     tx_ret = dmaengine_terminate_sync(dma->txchan);
> > > > > +     }
> > > >
> > > > This is unacceptable. Sleeping is okay, but value should really match the
> > > > baudspeed and other parameters of the transfer.
> > >
> > > This sleep is backoff after dmaengine_terminate_sync() has returned
> > > an error, rather than an estimate of UART transmission time. Each
> > > retry asks the provider to stop the channel again; elapsed time is
> > > never treated as evidence that the resources are safe to free.
> > >
> > > The particular 100 ms interval has no hardware-derived justification.
> > > However, I don't yet see a sound way to derive the retry cadence from
> > > baud rate either. RX can be waiting for input, TX can be held by flow
> > > control, and callback retirement is a separate requirement from
> > > moving bytes through the UART.
> > >
> > > Do you have a particular provider failure mode in mind where retrying
> > > termination should follow the serial transfer timing? I'd like to
> > > base the interval on the condition that can make termination succeed,
> > > rather than substitute a wire-time estimate for an arbitrary delay.
> >
> > Termination of DMA sometimes require to clean up internal FIFOs and other state
> > machines. That's what happens on HW side. In the software waiting for too much
> > may lead to the very big undesired latencies. The value of 100ms sounds insane
> > to me for the HSUART cases (megabaud range of speed). Also note, not every PCB
> > design uses HW flow control, so this may be even worse for them.
> 
> The 100 ms interval can add unnecessary teardown latency if a failed
> termination becomes retryable much sooner. There is no hardware-derived
> justification for that particular value.
> 
> The FIFO/state-machine draining is part of the provider's stop sequence.
> For example, DW performs its FIFO-empty polling inside
> dwc_terminate_all(). If termination succeeds, this patch proceeds without
> the retry sleep, regardless of baud rate. The sleep is only reached
> after an error during DMA release, not during normal RX delivery.
> 
> Baud rate can influence how quickly a transmit FIFO drains, even without
> flow control. However, the termination error does not tell 8250 whether
> that drain is still progressing, how much remains, or whether the
> controller needs a different recovery operation. That distinction matters
> when choosing a retry interval: a shorter interval reduces the added
> latency, but does not establish that retrying can recover the channel.
> 
> There is also a specific API detail here: dmaengine_terminate_sync()
> returns immediately if device_terminate_all() fails, without reaching
> dmaengine_synchronize(). Consequently, an error leaves callback draining
> unconfirmed as well. The retry cadence can change, but resource release
> still requires successful termination and synchronization.

Most likely this is AI slop. I can't see the justification for 100ms.
Can you explain that?

> > > Regardless of the retry interval, shutdown cannot release the buffers
> > > until the provider establishes that DMA and its callbacks have stopped.

-- 
With Best Regards,
Andy Shevchenko



