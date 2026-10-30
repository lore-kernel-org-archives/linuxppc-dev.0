Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC390606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hwwsqr+3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGGBC2y02z30C6;
	Fri, 30 Oct 2026 20:33:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793352819;
	cv=none; b=kr9LV+wpUu8Za1Fwl8Xsjs4/zOw7grjJ6sv9c2lGDThmSILCqXHAvWHiyDTVGq2Ptdd0spfty0SWlYvGGDj2C01b2VaTNoGPrwXWxIi2TI4K8kToU1Fq/0AMQfZZpbWQ1n/vSIMnRDURtUFNw0mNeVXVc3HNT0alVGDicCj2cp9TeNwG8ASe6de37qtJDgwrZu0sXgXbFrEAUwNDdaVXO0XxWoQbzVLDZml0PFeWuw7Ub70hRFpkzPshC9SpMbBacIgFJgYFlx8RLayjZCxQUeWE1xZt3ng19QdmaktKZbVRTIVCMj/zasNIxV+lOceacaAckzJTAhnVFtPwEAX1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793352819; c=relaxed/relaxed;
	bh=PCRyiewkbGG036lTwBa+174OovhhVRwZfC2vW3ZeNTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFPbZzgQCrTSOPkSPx6dkrqvUCymcYL/pGj1cj0AyP5SvGAWodY7/Wn7rqcCdJKRnE+VuhF07olfvNz8nUbUOjyWGl+j1Vohr+WRu+lI6i5hhfNNA35VK948nQimlHR57d1CXAgWWdWU+GCrTG0fQkdI5AXcg0ZV8/vGtIA/Lmca++I1h1Hxdq3iP0TSidmSByCYy7nL48GvybCvbaVK/gnlbGPC8AvSlBj7l0A5wImIgMoYZTMBM8Cc7HEYdQmDFB8OJF39zp01+lSyAsNd5+7Suasmy1nMrDxvZVRggT4zErtFvt3eMegCfJ0sxaGgSOh2z+YghAisbY29nsOIcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hwwsqr+3; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hwwsqr+3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGGB84QM8z2yFj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 20:33:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793352818; x=1824888818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qrpI44bWZaGg8MfD8DnU+yqorhMutYP7dQKRrMv1F3w=;
  b=hwwsqr+3RyeMOnrkG8/WdVOPxiF3efd+pYn1JslQe7PnuN/yTbfNzTVc
   Civnx/Zt2zFMjGs/n1ebasjiSdhgNdJqEOd0/tqIZ+UwBZ/jwQHL5fb8l
   99hMQUhNJjGlDMSLC1vi/sFbKBE4fotXT4avKhW+Tr27Mv7EB6nD3yG5E
   TH5OTtm8gfQ5JNZ31VyQd7xaiL7Ua2Femg9IiDChmBVcqbLaIYWZZ/Y/P
   +r+xlBvXDCF/FsXbbBlKBnCH1ac+/2KWSDH08yvo14+xDGtT9TKWwxpBL
   LqOVFEwzAIH93MDX/K5sixoYLS1RvJTuZ/rJcv1elq+BqNaL/zMIRDXcz
   g==;
X-CSE-ConnectionGUID: PzLYmIG4SLWeh2YFIC7obw==
X-CSE-MsgGUID: z7Mr3kYbTr28ANCNnUVfjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1999330"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="1999330"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:33:31 -0700
X-CSE-ConnectionGUID: qDHB30c7T6+C24I5cmm90w==
X-CSE-MsgGUID: v4Xg4+SIQQa629rjFUEQMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5926976"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:33:25 -0700
Date: Fri, 30 Oct 2026 11:33:23 +0200
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
Message-ID: <auRkY2h-NJvFszQE@ashevche-desk.local>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-4-3fd56ba352ed@gmail.com>
 <auNV7Vco5O3vVwRH@ashevche-desk.local>
 <CADvTj4oi6dFzWkjFXie1U49A70Y7Mb=4exga-=2SmG7fN2pLrA@mail.gmail.com>
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
In-Reply-To: <CADvTj4oi6dFzWkjFXie1U49A70Y7Mb=4exga-=2SmG7fN2pLrA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 11:15:23AM -0600, James Hilliard wrote:
> On Thu, Oct 29, 2026 at 8:19 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Oct 29, 2026 at 01:37:00AM -0600, James Hilliard wrote:

...

> > > -     bool                    shutting_down;
> > > +     bool                    shutting_down:1;
> > > +     bool                    tx_terminating:1;
> > > +     bool                    tx_flushed:1;
> >
> > What is the meaning of bool XXX:1? Have you checked with `pahole` the result?
> 
> These are one-bit boolean fields, intended to pack the state flags
> into one byte.
> 
> I've now compared layout probes using the kernel type definitions and
> saved build flags, changing only those bitfields to ordinary bools.
> For the complete v8 structure, including the RX flags, pahole reports:
> 
>                             Bitfields   Plain bool
>     ARM32 / Clang               212         220
>     ARM64 / GCC                 368         376
>     ARM64 / GCC / PREEMPT_RT     368         376
> 
> The sizes are in bytes. All six flags share one byte in the packed
> version. This saves eight bytes in each checked configuration.

Thanks for checking!

> The packing is a layout choice, not an atomicity mechanism; updates
> still require the UART port lock. Given the measured saving, I'd keep
> it unless there is another concern with using bool bitfields here.

I'm just worrying that bool bitfields are implementation defined and
might have some side-effects. But I see elsewhere in the kernel similar
approach, so I guess so far it didn't trigger any suspicious behaviour.

-- 
With Best Regards,
Andy Shevchenko



