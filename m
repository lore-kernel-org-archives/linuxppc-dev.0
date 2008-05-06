Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DDD93DE011
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 21:34:53 +1000 (EST)
Subject: Re: [PATCH] Sam440ep support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hiqxrd5yg.wl%tiwai@suse.de>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<6DA6B1DA-11B5-4B89-88AD-561B4D17B33B@kernel.crashing.org>
	<20080505195054.172000@gmx.net> <1210031058.21644.120.camel@pasglop>
	<20080506075115.269150@gmx.net> <1210063719.21644.162.camel@pasglop>
	<20080506091622.269180@gmx.net> <1210068747.21644.164.camel@pasglop>
	<s5hlk2nd6r5.wl%tiwai@suse.de> <1210073153.21644.175.camel@pasglop>
	<s5hiqxrd5yg.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Tue, 06 May 2008 21:34:43 +1000
Message-Id: <1210073683.21644.180.camel@pasglop>
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


On Tue, 2008-05-06 at 13:31 +0200, Takashi Iwai wrote:
> > I don't think we can easily update the DMA API at this stage. What
> we
> > could do is provide a way to retrieve the struct page array from the
> > result of dma_alloc_coherent...
> 
> In most cases, it can be obtained via pfn_to_page(), I suppose.  But,
> it's definitely arch-specific thingy, and a generic solution would be
> really appreciated.

You can't get a pfn out of the result of dma_alloc_coherent on
non-coherent powerpc at least. It's a virtual mapping created from the
underlying pages set to be non-cacheable. virt_to_* will do no good.

> Alternatively, we can change the ALSA PCM core code that accesses the
> virtual linear buffer and handles SG-buffers as they are.  Maybe it'll
> give a bit more useful clean-up in the whole memory-management codes
> in ALSA in the end.

I need to get my head around what the exact usage in Alsa is, and it's a
bit too late for me to thing right now :-)

Ben.
