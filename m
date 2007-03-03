Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D123DDDFA7
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Mar 2007 10:17:44 +1100 (EST)
Date: Sat, 3 Mar 2007 17:29:15 -0600
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH] DMA 4GB boundary protection
Message-ID: <20070303232915.GB8028@lixom.net>
References: <1172872183.5310.145.camel@goblue>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1172872183.5310.145.camel@goblue>
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

On Fri, Mar 02, 2007 at 03:49:43PM -0600, Jake Moilanen wrote:
> This normally is not an issue as firmware gives us dma-windows under
> 4gigs.  However, some of the new System-P boxes have dma-windows above
> 4gigs, and this present a problem.

Above 4 gigs, or that crosses the 4GB boundary? There's a difference.

> I propose fixing it in the IOMMU allocation instead of making each
> driver protect against it as it is more efficient, and won't require
> changing every driver which has not considered this issue.

The drawback of this patch is that it adds code to every single allocation.
Instead, you should just mark the last entry before the 4GB boundary
as allocated when you setup the bitmaps for the table. That way, no
allocation will ever be able to cross over.

Even nicer would be to only do it when a boot option is specified, so
we actually have a chance to expose and find the driver bugs instead of
papering them over.

Also, remember to use IOMMU_PAGE_SHIFT instead of PAGE_SHIFT, they might
be different.


-Olof
