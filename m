Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7BE29B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 05:56:07 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 039DCDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 05:56:05 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n77Ju2LC025589
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2009 12:56:02 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n77JuYnR000291
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2009 14:56:35 -0500 (CDT)
Date: Fri, 7 Aug 2009 14:56:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kenneth Johansson <kenneth@southpole.se>
Subject: Re: 5121 cache handling.
Message-ID: <20090807195600.GB11681@b07421-ec1.am.freescale.net>
References: <1249649632.4940.38.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1249649632.4940.38.camel@localhost>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 07, 2009 at 02:53:52PM +0200, Kenneth Johansson wrote:
> on 5121 there is a e300 core that unfortunately is connected to the rest
> of the SOC with a bus that do not support coherency.
> 
> solution for many driver has been to use uncached memory. But for the
> framebuffer that is not going to work as the performance impact of doing
> graphics operations on uncached memory is to large.
> 
> currently the "solution" is to flush the cache in the interrupt
> handler. 
> 
> #if defined(CONFIG_NOT_COHERENT_CACHE)
>                         int i;
>                         unsigned int *ptr;
>                         ptr  = coherence_data;
>                         for (i = 0; i < 1024*8; i++)
>                                 *ptr++ = 0;
> #endif
> 
> Now this apparently is not enough on a e300 core that has a PLRU cache
> replacement algorithm. but what is the optimal solution? 

Which driver (in which kernel) are you looking at?

drivers/video/fsl-diu-fb.c in current mainline has properly sized
coherence data.  It also does a dcbz (on unused data) instead of loads,
as it's apparently faster (though I'd think you'd get more traffic
flushing those zeroes out later on, compared to a clean line that can
just be discarded).

> should not the framebuffer be marked as cache write through. that is the
> W bit should be set in the tlb mapping. Why is this not done ? is that
> feature also not working on 5121 ??

It probably would have been too slow.

> problem with doing it over just the framebuffer is that a 1024x768
> buffer is 98304 cache lines it's going to take a considerable time to
> do. 

That's why we flush the whole cache instead.

> how many cycles does it take per cache line if we never get a hit ??
> 3cycles at 400MHz gives 4.5milisec/sec or 4-5% overhead
> 
> 1024*768*4/32*3*(1/400000000)*60
> .04423680000000000000
> 
> 52kB on the other hand is only 1664 lines but is obviously going to have
> to do a lot of actual memory writes also for any modified cache line and
> later a lot of reads to read back what was evicted. 

During periods of framebuffer activity, a lot of those cache lines likely
are for the framebuffer, so you'll still have those same issues.

If current performance is inadequate, you may want to consider using the
MMU and timers to figure out when the framebuffer is active, and stop the
sync when it's not.

-Scott
