Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (mta23.gyao.ne.jp [125.63.38.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1ADC8DDF46
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 00:20:45 +1100 (EST)
Date: Tue, 16 Dec 2008 22:18:49 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RESEND][PATCH] uio: Add of_platform_driver to uio_pdrv_genirq
Message-ID: <20081216131849.GA30249@linux-sh.org>
References: <1229007937-5501-1-git-send-email-w.sang@pengutronix.de>
	<20081216122524.GA29546@linux-sh.org>
	<20081216124156.GD3275@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081216124156.GD3275@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, hjk@linutronix.de, gregkh@suse.de,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 16, 2008 at 01:41:56PM +0100, Wolfram Sang wrote:
> > In addition to the stuff pointed out by Greg, I don't see what you
> > actually gain by hacking the OF crap in to this driver. You would be
> > better off layering the OF driver on top of this, rather than trying to
> > make them live together in the same file.
> > 
> > See pata_platform/pata_of_platform for an example of how to do this a bit
> > more sanely.
> 
> See my reply just posted. I found two ways to go, and from reading
> discussions on the lists, finally decided for this way. May have been
> the wrong path, but nothing that could not be changed.
> 
I guess there are a couple of things to consider. If it fits in fairly
nicely and can be optimized out for the users that don't care, then
integration generally makes sense. In this case however you have a large
and insular block that is ifdef'ed in and selected by Kconfig, suggesting
that the only benefit is for your driver which wishes to tie in to parts
of uio_pdrv_genirq, with there being no benefits the other way. This sort
of situation suggests you are better off layering and simply exposing the
functionality you need from uio_pdrv_genirq. This was certainly the case
with pata_platform as well, and it worked out pretty well there compared
to hacking it in-place.
