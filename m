Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id A6EBC67A6F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Feb 2005 11:30:20 +1100 (EST)
Date: Fri, 25 Feb 2005 17:29:41 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Ralph Siemsen <rsiemsen@rossvideo.com>
Message-ID: <20050225172941.A30499@cox.net>
References: <1628E43D99629C46988BE46087A3FBB91C4AA7@ep-01.EmbeddedPlanet.local>
	<421F89A0.8070502@sandburst.com> <20050225133055.A28918@cox.net>
	<421F966D.4060206@rossvideo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <421F966D.4060206@rossvideo.com>;
	from rsiemsen@rossvideo.com on Fri, Feb 25, 2005 at 04:19:41PM
	-0500
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: 2.6 4xx GPIO OCP driver?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Feb 25, 2005 at 04:19:41PM -0500, Ralph Siemsen wrote:
> Matt Porter wrote:
> 
> > I didn't bother merging it upstream at one time. It wasn't clear
> > if the driver had any value over just mmaping /dev/mem to bang
> > on the couple gpio registers directly. [...]
> 
> Will that work on the 440 where the devices sit above 4GB mark?  Or must 
> one rely on there being an existing TLB mapping to bring them into 
> 32-bit space?

Ack...that's the one thing we are missing. :-/ I had forgotten
that driver/char/mem.c  calls remap_pfn_range() directly rather
than io_remap_page_range(). Had it called the latter, we'd be OK
since the "bigphys" fixup could take place.  We can fix /dev/mem to
call io_remap_page_range() when on ppc32 && 36-bit phys...other arches
do similar tricks in that driver.

If everybody is happy with mmaping /dev/mem then we can go try that
route.

-Matt
