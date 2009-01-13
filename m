Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 9DC26DE19E
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 03:33:19 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Ira Snyder <iws@ovro.caltech.edu>
Subject: Re: [PATCH RFC v5] net: add PCINet driver
Date: Tue, 13 Jan 2009 17:33:03 +0100
References: <20090107195052.GA24981@ovro.caltech.edu>
	<200901131302.52754.rusty@rustcorp.com.au>
	<20090113033420.GA11065@ovro.caltech.edu>
In-Reply-To: <20090113033420.GA11065@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901131733.04341.arnd@arndb.de>
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

On Tuesday 13 January 2009, Ira Snyder wrote:
> On Tue, Jan 13, 2009 at 01:02:52PM +1030, Rusty Russell wrote:
> > 
> >    Interesting system: the guest being able to access the
> >    host's memory but not (fully) vice-versa makes this a
> >    little different from the current implementations where
> >    that was assumed.  virtio assumes that the guest will
> >    publish buffers and someone else (ie. the host) will access them.    
> 
> The guest system /could/ publish all of its RAM, but with 256MB per
> board, 19 boards per cPCI crate, that's way too much for a 32-bit PC to
> map into it's memory space. That's the real reason I use the 1MB
> windows. I could make them bigger (16MB would be fine, I think), but I
> doubt it would make much of a difference to the implementation.

The way we do it in the existing driver for cell, both sides export
just a little part of their memory to the other side, and they
also both get access to one channel of the DMA engine, which is
enough to transfer larger data sections, as the DMA engine has
access to all the memory on both sides.

	Arnd <><
