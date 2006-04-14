Return-Path: <muli@granada.merseine.nu>
Received: from mtaout3.012.net.il (mtaout3.012.net.il [84.95.2.7])
	by ozlabs.org (Postfix) with ESMTP id 1A069679E1
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 01:19:23 +1000 (EST)
Received: from granada.merseine.nu ([87.69.40.180])
	by i_mtaout3.012.net.il (HyperSendmail v2004.12)
	with ESMTP id <0IXP00GA9VOU6Z40@i_mtaout3.012.net.il> for
	linuxppc-dev@ozlabs.org; Fri, 14 Apr 2006 17:46:07 +0300 (IDT)
Date: Fri, 14 Apr 2006 17:48:30 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB,
	V2
In-reply-to: <1144961564.4935.24.camel@localhost.localdomain>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-id: <20060414144830.GQ10412@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20060413020559.GC24769@pb15.lixom.net>
	<20060413022809.GD24769@pb15.lixom.net>
	<20060413025233.GE24769@pb15.lixom.net>
	<20060413064027.GH10412@granada.merseine.nu>
	<1144925149.4935.14.camel@localhost.localdomain>
	<20060413160712.GG24769@pb15.lixom.net>
	<20060413173121.GJ10412@granada.merseine.nu>
	<1144961564.4935.24.camel@localhost.localdomain>
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

On Fri, Apr 14, 2006 at 06:52:44AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2006-04-13 at 20:31 +0300, Muli Ben-Yehuda wrote:
> > On Thu, Apr 13, 2006 at 11:07:12AM -0500, Olof Johansson wrote:
> > 
> > > Walking the DT means we need to hardcode it on PCI IDs, since the Apple
> > > OF doesn't give the Airport device a logical name. It's probably easier
> > > to implement than walking PCI, but we'd need to maintain a table. My
> > > vote is for PCI walking, I'll give that a shot over the weekend.
> > 
> > Cool! bonus points if you do it in drivers/pci and we can steal it
> > easily for Calgary on x8-64 :-)
> 
> How so ? Anything remotely related to the iommu is totally different...
> Besides, on x86-64, laptops _are_ more common, and thus the problem of
> cardbus cards is much more significant.

What I had in mind is an interface that given a PCI bridge will tell
you what's the most restrictive DMA mask for a device on that bridge,
so that you'll know whether you need to enable the IOMMU for that
bridge. I'll even settle for a function that tells you what's the most
restrictive DMA mask in the system, preiod. There's nothing inherently
arch specific about this.

(and as a side note, the IOMMU we are working on on x86-64 is Calgary,
which is actually roughly the same chipset used in some PPC
machines...)

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/
