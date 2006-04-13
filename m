Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 04F0867A01
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 02:08:06 +1000 (EST)
Date: Thu, 13 Apr 2006 11:07:12 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB,
	V2
Message-ID: <20060413160712.GG24769@pb15.lixom.net>
References: <20060413020559.GC24769@pb15.lixom.net>
	<20060413022809.GD24769@pb15.lixom.net>
	<20060413025233.GE24769@pb15.lixom.net>
	<20060413064027.GH10412@granada.merseine.nu>
	<1144925149.4935.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1144925149.4935.14.camel@localhost.localdomain>
From: Olof Johansson <olof@lixom.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 13, 2006 at 08:45:49PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2006-04-13 at 09:40 +0300, Muli Ben-Yehuda wrote:
> > On Wed, Apr 12, 2006 at 09:52:33PM -0500, Olof Johansson wrote:
> > 
> > > iommu=off can still be used for those who don't want to deal with the
> > > overhead (and don't need it for any devices).
> > 
> > I've been pondering walking the PCI bus before deciding to enable an
> > IOMMU and checking each device's DMA mask. Is this something that you
> > considered and rejected, or just something no one got around to doing?
> 
> It would do the trick for airport cards in G5s.. a little bit of OF
> walking to find the card.

Walking the DT means we need to hardcode it on PCI IDs, since the Apple
OF doesn't give the Airport device a logical name. It's probably easier
to implement than walking PCI, but we'd need to maintain a table. My
vote is for PCI walking, I'll give that a shot over the weekend.

> It won't help with cardbus broadcom's but then, there is currently no G5
> with a cardbus adaptor that I know of :) It's possible I suppose to get
> a pci<->cardbus adapter but I suppose in that case, we can ignore it ...

Yep, that should be rare enough.

-Olof
