Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9A606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Oct 2026 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S14jnShx
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCTJn4ggBz2xfK;
	Mon, 26 Oct 2026 07:44:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792961081;
	cv=none; b=NWKRBJickdt0hIwa8M9it4Op3mImwkFrw5gQ2lntjwKABWCspD6cutXJeoXcEUMxkZc+FS2TvHo30hF1ggNXt0yDyFmMQ8kTzTfJNBFuQz1LZdescl7eIvocdvcuJAebpd6R4WUExq+H91som6ThaUw+o6yMWLd7z2Mqpr8BbxveynfvtJ+QzRTXppjwd17c+aHQBv5siyLCCCM5ZwQHDvfZgeDU5kTZtXR9fYRglhxHHVKJ7DEpGaUeYijsStGT2e7iz5GrZ2h5hqbYpRt43BAd6TYEIcSlz+vcrEu5YRJSeLkDl47AxTVKiPqL0Op7CCNxLRfd0LZj+IZ2afMB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792961081; c=relaxed/relaxed;
	bh=Y1K0RTnG4l4ygM2F8GtIx4eTiSY/f4ozYtbSxngz744=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yhvax5nZlIC7pUzcrxWs5vFkd3/G3e/7HxnZUctyelYj4d18L4mboqZnPrxEiect/ZlZmOLmz1IZdcmcFcrVYzaf1JRZUV0H3QWMKXZzPOsKlEKi9xiP8nvcbz/CD327da19/h0kDZsKW8O/LxfoQr2Ic+5HYYEZ1n9UDFldtJlGGCo0uYyA79/ceKaOSUemsBvD8DD+jES+Eui4gGi4KTZeusIfjtaun/L8SWe8fc8JubKXHPcZRU/ym+By1siYM2dDKklWp56aZ4StQdUuqxyd7fw0hnb56hKHYIgu7+JsMmviE8udMj7fFnhwagmnfkySSllOTbXLEWINOp+DOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S14jnShx; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S14jnShx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCTJk4LHkz2xdY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 07:44:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792961079; x=1824497079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eXznDtSLHr+NGm3eF9RB5EGJ3G5yfhG0QIJwsysSxZw=;
  b=S14jnShxf8C+Uhk05SbutNarWibFIm0IpxR2pnPjZB6helFUD/2Owa1W
   ELj/TwINpxezAwStFWBfSYkrf2+IufBMFArhfPbJyBXj64afduHAQC+X/
   HmlghpfLMj1zR2S00vt538ia1N4F3BsyhOwspgePQaNyYnAmkm7UZ0l35
   bPDTVLWQTnIczvqbheri1ZBO6uoUlT93rzcYBsQmUXCHf3eMS0E8pFvpf
   whAQO84pzMYAwfxre4UzAl+dG8GTC27TGhg+iXs34+nu5FAzTREuZCeUs
   /JzWkEwcyBBU7VcgxH1L4XjxNBJHAa9UPaohAPPJ+MYPOYZssbRJgwOlY
   w==;
X-CSE-ConnectionGUID: jfBsK9euSZeiEz0c8kb27Q==
X-CSE-MsgGUID: hk1cJsCDRhuavNycxcC/vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1527861"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1527861"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:44:33 -0700
X-CSE-ConnectionGUID: EMIh884NTLyiP+HifSGEoA==
X-CSE-MsgGUID: K9IknHoWQhyv10Qz/UdTGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4080612"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:44:27 -0700
Date: Sun, 25 Oct 2026 22:44:25 +0200
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
Message-ID: <at5qKehogAjTa-fA@ashevche-desk.local>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
 <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
 <at4bw-G8czG-G7Wl@ashevche-desk.local>
 <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
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
In-Reply-To: <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard wrote:
> On Sun, Oct 25, 2026 at 9:10 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, Oct 25, 2026 at 05:10:03AM +0000, Maciej W. Rozycki wrote:
> > > On Sat, 24 Oct 2026, James Hilliard wrote:
> > >
> > > > uart_write_wakeup() expects the UART port lock to be held. Several worker,
> > > > DMA completion and interrupt paths call it without that lock, including
> > > > indirect calls from uart_handle_cts_change() and the transmit helpers.
> > >
> > >  Fair enough, and thank you for the cleanup and spotting the issue in the
> > > first place, however...
> >
> > He already issues a v6. I think the tactics against AI contributions should be
> > to not answer for a week or so until there will be a quiescent week.
> 
> At least with the workflow I've been using, a good signal for quiescence is
> simply whether or not the Sashiko reviewer found issues.
> 
> I am feeding the Sashiko prompts into my local agent but it seems to
> sometimes miss issues that get flagged by the public Sashiko reviewer
> still.
> 
> I've been attempting to peel off independently reviewable fixes where
> feasible as well to minimize the amount of patches/code during respins
> as well.
> 
> > At least that's what I learn from this patch storm.
> 
> Whenever my local branch accumulates significant refactoring/changes
> due to Sashiko or manual reviews I generally try and send out the new
> revision fairly quickly in an attempt to avoid reviewers wasting time
> reviewing code that is obsoleted by the new fixes/changes in my local
> branch.
> 
> Locally I actually have far more UART related patches in an integration
> tree that I've held off on sending for now since they are dependent upon
> the prerequisite fixes I have already sent. My unposted patches actually
> have an even larger amount of code changes than all the UART related
> patches that I've posted so far, at least when measured in terms of total
> lines of code changed.
> 
> The large amount of patches I ended up with seems to have mostly come
> about due to the AI agent identifying most of these bugs while iterating on
> and debugging new features(most of which are still largely unsent so far).
> 
> The strategy I've been using is to send small isolated fixes separately and
> then reference them as needed in the larger series that depend on them.
> I figure this should make the changes easier to review than having them
> all in a larger series. I contributed the changes[0] to make this compatible
> with the Sashiko reviewer actually.
> 
> I also use a custom AI agent controlled hardware in the loop test harness
> which makes iterating/testing changes much faster since the AI agent can
> autonomously test and iterate on changes far faster than is possible to do
> manually. This test setup also allows much more thorough testing as a lot
> of error handling or uncommonly hit code paths can then be tested using
> AI generated fault injection tests on real hardware tailored to the specific
> fix being validated. I manually review the final changes before sending as
> well of course.
> 
> I'm constantly refining these patch development/review workflows as well
> so feel free to give me any suggestions for anything I should change to
> make review easier.

I already gave one: slow down. Better think than loop through AI and keep
Sashiko busy. Your patches are valuable, no questions, but they are way
too complicated to catch on withing an hours or a couple of days time frame.

Some people might want to test the stuff. And sending too often you actually
will get the opposite results, people will be tired to even start reviewing
and/or testing your code as it's changed way too quickly. Settle down first
with something, put on the cover letter the answer why not all Sashiko's
comments are being addressed (for example, due to amount of patches or the
series being focused on a certain issue).

> [0] https://github.com/sashiko-dev/sashiko/pull/389

-- 
With Best Regards,
Andy Shevchenko



