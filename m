Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 66812DE397
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 03:40:10 +1100 (EST)
Date: Tue, 13 Jan 2009 08:40:08 -0800
From: Ira Snyder <iws@ovro.caltech.edu>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC v5] net: add PCINet driver
Message-ID: <20090113164007.GA7434@ovro.caltech.edu>
References: <20090107195052.GA24981@ovro.caltech.edu>
	<200901131302.52754.rusty@rustcorp.com.au>
	<20090113033420.GA11065@ovro.caltech.edu>
	<200901131733.04341.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200901131733.04341.arnd@arndb.de>
Cc: netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	shemminger@vyatta.com, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 13, 2009 at 05:33:03PM +0100, Arnd Bergmann wrote:
> On Tuesday 13 January 2009, Ira Snyder wrote:
> > On Tue, Jan 13, 2009 at 01:02:52PM +1030, Rusty Russell wrote:
> > > 
> > >    Interesting system: the guest being able to access the
> > >    host's memory but not (fully) vice-versa makes this a
> > >    little different from the current implementations where
> > >    that was assumed.  virtio assumes that the guest will
> > >    publish buffers and someone else (ie. the host) will access them.    
> > 
> > The guest system /could/ publish all of its RAM, but with 256MB per
> > board, 19 boards per cPCI crate, that's way too much for a 32-bit PC to
> > map into it's memory space. That's the real reason I use the 1MB
> > windows. I could make them bigger (16MB would be fine, I think), but I
> > doubt it would make much of a difference to the implementation.
> 
> The way we do it in the existing driver for cell, both sides export
> just a little part of their memory to the other side, and they
> also both get access to one channel of the DMA engine, which is
> enough to transfer larger data sections, as the DMA engine has
> access to all the memory on both sides.

So do you program one channel of the DMA engine from the host side and
another channel from the guest side?

I tried to avoid having the host program the DMA controller at all.
Using the DMAEngine API on the guest did better than I could achieve by
programming the registers manually. I didn't use chaining or any of the
fancier features in my tests, though.

Ira
