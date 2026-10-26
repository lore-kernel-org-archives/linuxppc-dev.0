Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0132B606A31B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K6KCNWAt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCpNT3fDRz2yDs;
	Mon, 26 Oct 2026 20:34:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793007241;
	cv=none; b=M6VZjsvSzjaUV3Pyhy31mgO4VrqiUhgtiXLkBWy7cdCz/8aFFJQlJvMjBxZp5EyBhFZByhYQdR/tMxI/QAfcVrHUy4cKRIF3kLO/H/PqIJ8HfXsUSkd4BIZ7DdrnEqXdhptYtanVmYr2NQQhsA08I+L9GGsZxBwhngmoRqcKb5aHe3kIafruKtI8rtqGcb6OTkf5Xpg2J83kSU26ZqB4q5QkslXWZ9LS9U8LMdSc8IIZw9admIw1Fl2kiz3gvDH8T1zp01gJzKsJK2bUpVZ4N9d06/gNAagOOcIqM7KbXUpGB/oinfFO+CEUltKQ9APNjM8vLLcQqPV8RxzyoDqH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793007241; c=relaxed/relaxed;
	bh=0WRy0PlXijTVPaZN+8guL59byar3K3OLJbxaZMhuvdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ol8W1jO2zA8B6W9esesZSHyHkEXMQu2HLF2JrNd1IGtLtQZeRvt72RD4W6/W+BdutBlBvdxORgCE13mG1BJJmmlieeaYaEx4AoTqM5/EHGAR06Dv8ELh5XUdzDRwO/PF0KwDZRhrB1mb7vu8Xdm6dE305kI/GxTGm5KBpJ6nsdIfFJO6kBCRH6kurNfQ1NKIWvW/r+4SB1wcgCwJYeDKe9jAwI9hctES//bjdnXtx/kQNGqT/rvsq0/O6zJVDgHgOdmK7P9FLYasiOQWDuKGM+Dd989yVgtg9Fr3wIn6HXLAgcB0+f2h+6GS15ljYjGhK3/incysAW7xjsIdu7TDNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K6KCNWAt; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K6KCNWAt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCpNQ22lCz2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 20:33:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793007239; x=1824543239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=f84sV62ooKOvjIhQKXtEC/TuKGIbIDblS98potdMs0c=;
  b=K6KCNWAtn6hy3BPC6KKAfTSN9d98c2Jm4+539qW6CmI8+v279KoaIzQo
   lQaP6S8HQLZ57XfH0OcSdrElW1+4QgyIRV/aG+5BYxleEimIVIQSXx8/M
   db7clNbk96qRxnYNtX73KWDw/BIlMFEK55aGabIVa0UFm33D71y3O++cl
   mzuKK2zeWHsnV1bZE8dqdK/ewDbYXNFdRi/r9nRK2dlFtQ1HhI0fqMRg9
   u2c9wxNGvregzokumBxhRtTKxKkTuNCEQlD2B/Gxet9hE0ok4X+llqeFx
   MGaPhT6jP+5XLQ4T7OuZivuNPmV0w241Txzz/jAFHOVCWNfpfXUEFuF9d
   w==;
X-CSE-ConnectionGUID: NVmGXgoGSpW6h16oIJZqrQ==
X-CSE-MsgGUID: SGdocVm8QnWhyKv1N4eIeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1546618"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1546618"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:33:53 -0700
X-CSE-ConnectionGUID: fVvhHvtoSG2AkfgtDxVUUQ==
X-CSE-MsgGUID: OqFYijmUSTSItatMUaeiwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4200056"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:31:59 -0700
Date: Mon, 26 Oct 2026 11:31:56 +0200
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
Message-ID: <at8eDFj2WNaXDaot@ashevche-desk.local>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
 <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
 <at4bw-G8czG-G7Wl@ashevche-desk.local>
 <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
 <at5qKehogAjTa-fA@ashevche-desk.local>
 <CADvTj4qSgE6Rc--mWuqAcc8HTqN9EFOS_JM8Hp8e_=ka_ZLa6w@mail.gmail.com>
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
In-Reply-To: <CADvTj4qSgE6Rc--mWuqAcc8HTqN9EFOS_JM8Hp8e_=ka_ZLa6w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 04:11:08PM -0600, James Hilliard wrote:
> On Sun, Oct 25, 2026 at 2:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard wrote:

...

> > Some people might want to test the stuff. And sending too often you actually
> > will get the opposite results, people will be tired to even start reviewing
> > and/or testing your code as it's changed way too quickly.
> 
> My thought process was that people wouldn't want to be testing code that
> had known bugs flagged in Sashiko reviews.

Sashiko reviews are not visible in my or any other mailbox. To see them I have
to go to some URL and so on, meaning to waste time to see why on the earth the
new version has been sent. It's better before addressing Sashiko comments,
reply to all people involved and to Sashiko's original email, so it will be
visible in the previous version why you issued (actually about to issue) the
next version. And before even issuing it, wait for a while, people might
disagree with Sashiko judgement or your replies on how to address that.

TL;DR: this mailing list is *not* a playground with you and Sashiko, the whole
community is behind it.

> > Settle down first
> > with something, put on the cover letter the answer why not all Sashiko's
> > comments are being addressed (for example, due to amount of patches or the
> > series being focused on a certain issue).
> 
> So, in general I've been always attempting to resolve known Sashiko issues
> in every subsequent re-spin, so that would be a bit tricky since I wouldn't be
> aware of the Sashiko issues until after the series has already been sent.
> 
> Usually the subsequent issues that get flagged are new issues only discovered
> after each new re-spin.
> 
> I do have a bunch of UART/DMA related patches that don't have flagged Sashiko
> issues so it probably makes sense to try and review those first while the larger
> series that have Sashiko flagged issues are still stabilizing.

Yes.

> > > [0] https://github.com/sashiko-dev/sashiko/pull/389

-- 
With Best Regards,
Andy Shevchenko



