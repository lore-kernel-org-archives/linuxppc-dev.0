Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 041CEDDF23
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 21:26:05 +1000 (EST)
Subject: Re: [PATCH] Sam440ep support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hlk2nd6r5.wl%tiwai@suse.de>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<6DA6B1DA-11B5-4B89-88AD-561B4D17B33B@kernel.crashing.org>
	<20080505195054.172000@gmx.net> <1210031058.21644.120.camel@pasglop>
	<20080506075115.269150@gmx.net> <1210063719.21644.162.camel@pasglop>
	<20080506091622.269180@gmx.net> <1210068747.21644.164.camel@pasglop>
	<s5hlk2nd6r5.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Tue, 06 May 2008 21:25:53 +1000
Message-Id: <1210073153.21644.175.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cjg@cruxppc.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-05-06 at 13:14 +0200, Takashi Iwai wrote:
> > sg allocations are usually lists of page, so virt_to_page shouldn't
> be a
> > problem in the first place, though we still need some way to get the
> > right prot attributes.
> 
> The problem is that ALSA SG buffer is composed from pages allocated
> via dma_alloc_coherent(), and the pages are retrieved via virt_to_page
> for DMA pages, as found in sound/core/sgbuf.c.
> 
> I didn't care about SG-buffer cases in my initial patch, and it's a
> bit messy.  The current code requires page lists becasue it calls
> vmap() to get a virtually linear buffer.

Hrm... the problem is that you aren't supposed to make up sglists with
the result of dma_alloc_coherent... It might be a limitation of our core
DMA API, but that's we have to deal with today..

If you're going to make up sglists and call vmap, you should allocate
pages with normal GFP. If that is a problem vs. DMA'bility of those
pages, then ... we have a problem :-)

I don't think we can easily update the DMA API at this stage. What we
could do is provide a way to retrieve the struct page array from the
result of dma_alloc_coherent...

Ben.
