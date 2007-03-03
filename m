Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AEB4CDE0D4
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Mar 2007 19:28:54 +1100 (EST)
Subject: Re: [PATCH] DMA 4GB boundary protection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070302222748.GA1206@lixom.net>
References: <1172872183.5310.145.camel@goblue>
	<20070302222748.GA1206@lixom.net>
Content-Type: text/plain
Date: Sat, 03 Mar 2007 09:27:31 +0100
Message-Id: <1172910451.8184.51.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-03-02 at 16:27 -0600, Olof Johansson wrote:
> On Fri, Mar 02, 2007 at 03:49:43PM -0600, Jake Moilanen wrote:
> > There are many adapters which can not handle DMAing acrosss any 4 GB
> > boundary.  For instance the latest Emulex adapters.  
> > 
> > This normally is not an issue as firmware gives us dma-windows under
> > 4gigs.  However, some of the new System-P boxes have dma-windows above
> > 4gigs, and this present a problem.
> > 
> > I propose fixing it in the IOMMU allocation instead of making each
> > driver protect against it as it is more efficient, and won't require
> > changing every driver which has not considered this issue.
> 
> Sorry, but you need to fix the drivers. They might be used on a system
> without an IOMMU, or with direct mapping. It's particularily likely in
> the case of DAC-capable devices, and that's the only case for which you
> can cross a 4GB boundary in the first place.

Hrm... ok, that would be ideal, _but_

- We currently don't have platforms that DMA > 32 bits and don't have an
iommu

- Drivers are broken -today- and I doubt they can all be audited and
fixed (and fixes bacported to distros) quickly

- That problem is very common and can be very hard to debug when it
happens.

So while I agree, the logical fix would be in the drivers, I think that
-also- making sure the iommu code will not hand off sections crossing 4G
boundaries does make some sense. It will at least reduce the likehood of
strange and hard to debug problems on those setups that do have an iommu
and >4G of RAM, which is pretty much all of them at the moment on ppc64.

Can you double check the correctness of the patch ? I'll have a better
look myself next week hopefully.

Ben.
