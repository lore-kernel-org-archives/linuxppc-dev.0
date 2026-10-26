Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F887606A323
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SpDGmp1J
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jD47y4RdSz2yKn;
	Tue, 27 Oct 2026 06:54:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793044446;
	cv=none; b=Ycf2O3CVw9Wq/f3OmgVbt1ZMowA8mcckBzcrLmCR+iKUl545uI8tRBZNuk7TpVcE3D2LoPqB/m3QsvSV9FsFEOgZEV+a5Kt6X16/hJYNcs7PQ9R15iuL5WaZ6OTyg1p35yzzVZBdXjVOABJQx7TlxAVkP8SPlhuoUhHc1CGLP4DMLOZRX7DGqJjzwjDFnVo8t1Uby3u9mNN0TTcZ9Pksyxw/ZuV59XYFZLabH5k+r4jnq40SENxIFKKPIcojkK/uVuEPChbxcYLDFXVafEOcB40uYVkXXPH5hHLo+OD4mb/6HHj4Dj5C5V5pddZI4JJBL4EwRJcaVdFn1kkz02M4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793044446; c=relaxed/relaxed;
	bh=i+NDmw4lwf3hRzODAHlKBNdsDK4Mb0dC93HrLNynbZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7jqdH2jdI8FGtJxCeD55hv2B6UbChs5xGs7URWjoIgP/H5vJOxYwHFlZg04Ylcq0uunonaF3Eij2Nvxm/efa0andzXh9L9h7kI1VMk00LJ7vVhCPmKdejHbGWM0rr+hNFcKWgZblZ85SMvW8FqmcvSBiC8xsc1BJYiFb1L9kw20cVUPzZ33RvesPLXqfldkQzGy75HcAfvLxTgIi/CH2JqGBBPx8tkqPugPjvjII8OJ55i49n9Gw4LsN2pmFN2FFjjytyEjQNVbxQ3jkXKIXKPXs80FutNL4YcCL1TzlTCRBvWAXDCA2zOVMl6bKNF5NCtzaNG67Wppe6W5iySz9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SpDGmp1J; dkim-atps=neutral; spf=pass (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SpDGmp1J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jD47v2LJMz2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 06:54:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793044444; x=1824580444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FV51n/PiZWx6bvBfOkBqCKkoCYD8qfwCN0puYCkV0os=;
  b=SpDGmp1J2i9cJpf3J/3bt4Zjlbpp0mJogGkvzaX70r8yprnqFmxCsh5H
   /5EPDHDkAFQIz2A7jZfYXvAolb126AKVWdncY2M00Yv9u1inK3m6DHLNi
   Zz5bI0kmIKw/XhR1OeJSw18CzUn1oMb0ZsS107Wntws6J2mFWoZD1eeyJ
   SO5313/NJr62MGXu2JiQXh8N8G17eMLQh8ro6of2DRzs9zTRb1gMTXwvM
   7FouHboSAKtFTgfDjrJZVuliXQjf/pmor6F44l9VFFGytQcXZzFcV+v9b
   Ig8VZlyQWnwFzc8gO3GtHMO5S++5vAySihczi5QkbpIWdqugOdfoB3wqC
   A==;
X-CSE-ConnectionGUID: UaGP1izuStKzpb/n1It3iA==
X-CSE-MsgGUID: oj29Qh85S/W0Y63uos8gCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1615447"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1615447"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 12:53:55 -0700
X-CSE-ConnectionGUID: Dj09to7/Sbe2r8g4P5Lwuw==
X-CSE-MsgGUID: qCd0O6T5QDOWwhS++gg2Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4710651"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 12:53:48 -0700
Date: Mon, 26 Oct 2026 21:53:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
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
Message-ID: <at-vyZ1sDhYPu0W5@ashevche-desk.local>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
 <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
 <at4bw-G8czG-G7Wl@ashevche-desk.local>
 <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
 <at5qKehogAjTa-fA@ashevche-desk.local>
 <CADvTj4qSgE6Rc--mWuqAcc8HTqN9EFOS_JM8Hp8e_=ka_ZLa6w@mail.gmail.com>
 <at8eDFj2WNaXDaot@ashevche-desk.local>
 <CADvTj4oNz-bnSZP+kfau-7wBSWLjLTP5jrr6nLfdCHNPo3pS6w@mail.gmail.com>
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
In-Reply-To: <CADvTj4oNz-bnSZP+kfau-7wBSWLjLTP5jrr6nLfdCHNPo3pS6w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 10:45:54AM -0600, James Hilliard wrote:
> On Mon, Oct 26, 2026 at 3:33 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, Oct 25, 2026 at 04:11:08PM -0600, James Hilliard wrote:
> > > On Sun, Oct 25, 2026 at 2:44 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard wrote:

...

> > > > Some people might want to test the stuff. And sending too often you actually
> > > > will get the opposite results, people will be tired to even start reviewing
> > > > and/or testing your code as it's changed way too quickly.
> > >
> > > My thought process was that people wouldn't want to be testing code that
> > > had known bugs flagged in Sashiko reviews.
> >
> > Sashiko reviews are not visible in my or any other mailbox. To see them I have
> > to go to some URL and so on, meaning to waste time to see why on the earth the
> > new version has been sent.
> 
> Maybe the Sashiko reviews are getting caught in spam filtering or something?
> They are showing up for me and on the mailing list[0] so I'm a bit confused why
> you aren't seeing them. You shouldn't have to go to the web interface[1] to look
> up the reviews.
> 
> [0] https://lore.kernel.org/all/sashiko-outbox-183574@kernel.org/
> 
> [1] https://sashiko.dev/
> 
> > It's better before addressing Sashiko comments,
> > reply to all people involved and to Sashiko's original email, so it will be
> > visible in the previous version why you issued (actually about to issue) the
> > next version.
> 
> Hmm, maybe it makes sense to enable recipients in the reply_to config[2]?

It's up to the list owners / subsystem maintainers.

> [2] https://github.com/sashiko-dev/sashiko/blob/v.0.6.3/projects/linux/mailing_lists.toml#L290
> 
> > And before even issuing it, wait for a while, people might
> > disagree with Sashiko judgement or your replies on how to address that.
> 
> I was assuming everyone was seeing the Sashiko reviews getting posted to
> the mailing list already. The are ending up in lore so unless someone isn't
> subscribed to the list I'm not sure why they wouldn't be seeing those reviews
> already.

I assume you already answered your Q. mailing list in this sense doesn't mean
recipients. I think it simply goes to the mailing list without forwarding.

You can ask at helpdesk@ how this is configured on the kernel.org side.

> > TL;DR: this mailing list is *not* a playground with you and Sashiko, the whole
> > community is behind it.

> > > > Settle down first
> > > > with something, put on the cover letter the answer why not all Sashiko's
> > > > comments are being addressed (for example, due to amount of patches or the
> > > > series being focused on a certain issue).
> > >
> > > So, in general I've been always attempting to resolve known Sashiko issues
> > > in every subsequent re-spin, so that would be a bit tricky since I wouldn't be
> > > aware of the Sashiko issues until after the series has already been sent.
> > >
> > > Usually the subsequent issues that get flagged are new issues only discovered
> > > after each new re-spin.
> > >
> > > I do have a bunch of UART/DMA related patches that don't have flagged Sashiko
> > > issues so it probably makes sense to try and review those first while the larger
> > > series that have Sashiko flagged issues are still stabilizing.
> >
> > Yes.
> >
> > > > > [0] https://github.com/sashiko-dev/sashiko/pull/389

-- 
With Best Regards,
Andy Shevchenko



