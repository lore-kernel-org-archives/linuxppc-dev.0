Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C992EDDF13
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 08:25:33 +1100 (EST)
Date: Wed, 21 Mar 2007 16:39:45 -0500
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH] DMA 4GB boundary protection
Message-ID: <20070321213945.GA11404@lixom.net>
References: <1172872183.5310.145.camel@goblue>
	<20070303232915.GB8028@lixom.net>
	<1174511149.5225.135.camel@goblue>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1174511149.5225.135.camel@goblue>
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

On Wed, Mar 21, 2007 at 04:05:48PM -0500, Jake Moilanen wrote:
> > > I propose fixing it in the IOMMU allocation instead of making each
> > > driver protect against it as it is more efficient, and won't require
> > > changing every driver which has not considered this issue.
> > 
> > The drawback of this patch is that it adds code to every single allocation.
> > Instead, you should just mark the last entry before the 4GB boundary
> > as allocated when you setup the bitmaps for the table. That way, no
> > allocation will ever be able to cross over.
> 
> Agreed.  While it's not an issue at 4KB, when we go to say 64k, or 16MB
> TCE sizes, this extra space will be wasted.  But, I believe we'll need a
> little code for this anyways.

Doing 16MB mappings will have it's challenges anyway, especially for
things such as network and file I/O. It's similar to what happens for
64kB base page size and the buffer cache: lots and lots of waste, and
the risk of running out of address space is high (depending on how big
the window is per device, of course).

> > Even nicer would be to only do it when a boot option is specified, so
> > we actually have a chance to expose and find the driver bugs instead of
> > papering them over.
> 
> Done.
> 
> > Also, remember to use IOMMU_PAGE_SHIFT instead of PAGE_SHIFT, they might
> > be different.
> 
> Yup...
> 
> Here's a patch addressing Olof's concerns.

Thanks, I'll have a closer look at it tonight.


-Olof
