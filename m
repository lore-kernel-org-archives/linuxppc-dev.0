Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23B760A2622
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OteCXL3u
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGGKv2lYfz30Vs;
	Fri, 30 Oct 2026 20:40:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793353219;
	cv=none; b=ZXv2Si6uGdTG/sz/ojK1WZKCB97FVh01MIPExlJZDFUo1saMPhvxBIqRWdJU9tJTknHk5RRhUsiISOuBLeJ/O5uDUScEG4Fd70t7rutu3HAWWnZicANQClD2TgtsiISDMxejncJADI4MxK+/OCteYjxxBS1lsOCIjArwJDJIpns3ORWBzkHyw3/4ef+xC4PJjnYGwB+rQHDRO34dYIsOSY1XvTzGGFlXjBg8uGqJoPCOhm9B2U15P7nqLZ0O/8CBw4jk+iVF+msevcQdp3+QyVyRitca5NHntrikfaMOiEBMipsoRQXgeJWL/C19PUEGm+OWIJQtUbzlJ8BlOdx1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793353219; c=relaxed/relaxed;
	bh=OGxTx5VTRibU/s9XnjHXs/1x5TiFEbymfoF86VCpiMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoEdZnnTa8OXj7OomqvvxZzPFtygFA1PGoTBt7mK8xuCKOikydVrT/sYSKoqwN/p3GtSHy2l3QJuKWIqelkbk5lrpEwsopRRLiYshv/8A9nZo7KfQj7L5MSQsvV4Vch2pPJ4fKyUmw+gv+OBz1gFsEgeDqmQ1xkG6QSz66h5FsKfjYVqjyAJ+2FOJOpwjnuHRb+zfmr8nnDWsTFRg62pAc/XjvK1uZaIuanaDXDhsq/xx4uRVCIf1GNDsQp2q3tCQZC4jUiEIe6iInO4wtU/N8Spbpmubgn4L/MDEGmpBPE7YdBDjWD2sprHcbqRFW+0NOdYu1YNs7bpMwvdrj9dlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OteCXL3u; dkim-atps=neutral; spf=pass (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OteCXL3u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGGKs61JWz30Vm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 20:40:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793353218; x=1824889218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oih7GtI7xMzGahP76vQil5qWDbgK0U9SZz4iJvlgoJY=;
  b=OteCXL3uGvV9Ue0TDEC2znxAZeCu2RJsaj7Lu2BXf5DHvl60tV+B2s3a
   PxGnwaBqpnuRvh8AaYAtThBcT2igjQhHUztVuETKVXebHn93Eh/ebWxPg
   frnyconrY/SrCM3nz5eXmQG808qAdSqBJ1/U3FwP4MDo1MPwjpl2BJBzk
   E0XtPOELnlkSW8I3WYDgFYeqBdohuilVnnWdLyMgTdjvpzYwt6s/ljXYv
   Z5J5eCJZ9Gwwu+UrtGm7MPDcSG/gfVSX9QrnHynBbDA5tWf/hBzY/wadu
   biL9I12tyAt6dGgSQNsYv2HPNWyD2z3Stc6xFQfDSd3663JQwGBo2dhXs
   w==;
X-CSE-ConnectionGUID: wPOHfo1/TxypPIpZypXIMg==
X-CSE-MsgGUID: VdSbPIFXSHCJ+W23HAbNZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2128801"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2128801"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:40:15 -0700
X-CSE-ConnectionGUID: 4kQkNl98Qy6vjhZtyQi8Sw==
X-CSE-MsgGUID: dJ/QkbhGQBS9LRHlVFiP0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7184902"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:40:10 -0700
Date: Fri, 30 Oct 2026 11:40:07 +0200
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
Message-ID: <auRl9ztbav4nHi7U@ashevche-desk.local>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com>
 <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local>
 <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
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
In-Reply-To: <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 11:19:59AM -0600, James Hilliard wrote:
> On Thu, Oct 29, 2026 at 8:24 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Oct 29, 2026 at 01:37:02AM -0600, James Hilliard wrote:

...

> > > +     while (rx_ret || tx_ret) {
> > > +             dev_err_ratelimited(p->port.dev,
> > > +                                 "DMA termination failed: RX %d, TX %d; retrying\n",
> > > +                                 rx_ret, tx_ret);
> >
> > > +             msleep(100);
> >
> > Huh?!
> >
> > > +             if (rx_ret)
> > > +                     rx_ret = dmaengine_terminate_sync(dma->rxchan);
> > > +             if (tx_ret)
> > > +                     tx_ret = dmaengine_terminate_sync(dma->txchan);
> > > +     }
> >
> > This is unacceptable. Sleeping is okay, but value should really match the
> > baudspeed and other parameters of the transfer.
> 
> This sleep is backoff after dmaengine_terminate_sync() has returned
> an error, rather than an estimate of UART transmission time. Each
> retry asks the provider to stop the channel again; elapsed time is
> never treated as evidence that the resources are safe to free.
> 
> The particular 100 ms interval has no hardware-derived justification.
> However, I don't yet see a sound way to derive the retry cadence from
> baud rate either. RX can be waiting for input, TX can be held by flow
> control, and callback retirement is a separate requirement from
> moving bytes through the UART.
> 
> Do you have a particular provider failure mode in mind where retrying
> termination should follow the serial transfer timing? I'd like to
> base the interval on the condition that can make termination succeed,
> rather than substitute a wire-time estimate for an arbitrary delay.

Termination of DMA sometimes require to clean up internal FIFOs and other state
machines. That's what happens on HW side. In the software waiting for too much
may lead to the very big undesired latencies. The value of 100ms sounds insane
to me for the HSUART cases (megabaud range of speed). Also note, not every PCB
design uses HW flow control, so this may be even worse for them.

> Regardless of the retry interval, shutdown cannot release the buffers
> until the provider establishes that DMA and its callbacks have stopped.

-- 
With Best Regards,
Andy Shevchenko



