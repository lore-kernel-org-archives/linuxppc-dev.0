Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 22F65DDF87
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Mar 2007 10:14:14 +1100 (EST)
Date: Sat, 3 Mar 2007 17:25:41 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] DMA 4GB boundary protection
Message-ID: <20070303232541.GA8028@lixom.net>
References: <1172872183.5310.145.camel@goblue>
	<20070302222748.GA1206@lixom.net>
	<1172910451.8184.51.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1172910451.8184.51.camel@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 03, 2007 at 09:27:31AM +0100, Benjamin Herrenschmidt wrote:
> On Fri, 2007-03-02 at 16:27 -0600, Olof Johansson wrote:
> > On Fri, Mar 02, 2007 at 03:49:43PM -0600, Jake Moilanen wrote:
> > > There are many adapters which can not handle DMAing acrosss any 4 GB
> > > boundary.  For instance the latest Emulex adapters.  
> > > 
> > > This normally is not an issue as firmware gives us dma-windows under
> > > 4gigs.  However, some of the new System-P boxes have dma-windows above
> > > 4gigs, and this present a problem.
> > > 
> > > I propose fixing it in the IOMMU allocation instead of making each
> > > driver protect against it as it is more efficient, and won't require
> > > changing every driver which has not considered this issue.
> > 
> > Sorry, but you need to fix the drivers. They might be used on a system
> > without an IOMMU, or with direct mapping. It's particularily likely in
> > the case of DAC-capable devices, and that's the only case for which you
> > can cross a 4GB boundary in the first place.
> 
> Hrm... ok, that would be ideal, _but_
> 
> - We currently don't have platforms that DMA > 32 bits and don't have an
> iommu

Up until this week, we didn't have a platform that did DMA > 32, period.

On PPC I suppose there's only one right now that can do it without IOMMU,
and that's 1682M. I'd expect there to be more in the future. On non-PPC
I'm sure there's several.

> - Drivers are broken -today- and I doubt they can all be audited and
> fixed (and fixes bacported to distros) quickly

Yes, and the chance of them getting audited and fixed suddenly drops to
0% once we put this in instead. The same problem applies to this patch
with respect to backporting it to distros.

> - That problem is very common and can be very hard to debug when it
> happens.

So let's just make someone else suffer instead?

> So while I agree, the logical fix would be in the drivers, I think that
> -also- making sure the iommu code will not hand off sections crossing 4G
> boundaries does make some sense. It will at least reduce the likehood of
> strange and hard to debug problems on those setups that do have an iommu
> and >4G of RAM, which is pretty much all of them at the moment on ppc64.

Even though most ppc64 platforms have more than 4GB of ram, the IOMMUs
have up until now not done more than 32-bit addresses. This 4GB boundary
bug won't affect the majority of users out there, only those on platforms
whose firmware gives out address ranges that crosses the 4GB boundary.

Besides virtualization, there's no need to use an IOMMU with devices
that can address the full memory range of the system anyway. In most
cases it just hurts performance.

> Can you double check the correctness of the patch ? I'll have a better
> look myself next week hopefully.

It's incorrect as posted, and I think it can be done in a nicer
manner. I'll post feedback to the patch.


-Olof
