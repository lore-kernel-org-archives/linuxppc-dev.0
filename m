Return-Path: <kenneth@southpole.se>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7D946B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 06:17:09 +1000 (EST)
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by ozlabs.org (Postfix) with ESMTP id 135D2DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 06:17:08 +1000 (EST)
Subject: Re: 5121 cache handling.
From: Kenneth Johansson <kenneth@southpole.se>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090807195600.GB11681@b07421-ec1.am.freescale.net>
References: <1249649632.4940.38.camel@localhost>
	<20090807195600.GB11681@b07421-ec1.am.freescale.net>
Content-Type: text/plain
Date: Mon, 10 Aug 2009 22:16:24 +0200
Message-Id: <1249935384.7077.35.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-08-07 at 14:56 -0500, Scott Wood wrote:
> On Fri, Aug 07, 2009 at 02:53:52PM +0200, Kenneth Johansson wrote:
> > on 5121 there is a e300 core that unfortunately is connected to the rest
> > of the SOC with a bus that do not support coherency.
> > 
> > solution for many driver has been to use uncached memory. But for the
> > framebuffer that is not going to work as the performance impact of doing
> > graphics operations on uncached memory is to large.
> > 
> > currently the "solution" is to flush the cache in the interrupt
> > handler. 
> > 
> > #if defined(CONFIG_NOT_COHERENT_CACHE)
> >                         int i;
> >                         unsigned int *ptr;
> >                         ptr  = coherence_data;
> >                         for (i = 0; i < 1024*8; i++)
> >                                 *ptr++ = 0;
> > #endif
> > 
> > Now this apparently is not enough on a e300 core that has a PLRU cache
> > replacement algorithm. but what is the optimal solution? 
> 
> Which driver (in which kernel) are you looking at?

The one included in ltib 2009-06-02 for ads5121. Thought that was
including the latest drivers.

> drivers/video/fsl-diu-fb.c in current mainline has properly sized
> coherence data.  It also does a dcbz (on unused data) instead of loads,
> as it's apparently faster (though I'd think you'd get more traffic
> flushing those zeroes out later on, compared to a clean line that can
> just be discarded).

It's hard to know exactly how things behave when cache is involved.

But the code allocate the 52KB buffer with vmalloc that cant be right as
cache is stored with physical address the 52KB data need to be 52KB
continuous in physical address and vmalloc do not guarantee that.

> > should not the framebuffer be marked as cache write through. that is the
> > W bit should be set in the tlb mapping. Why is this not done ? is that
> > feature also not working on 5121 ??
> 
> It probably would have been too slow.

how much slower would write through be ? I thought it was not that big
of a difference from copy back.
