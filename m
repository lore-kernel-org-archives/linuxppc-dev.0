Return-Path: <tsawyer+linuxppc@sandburst.com>
Received: from mta11.adelphia.net (mta11.adelphia.net [68.168.78.205])
	by ozlabs.org (Postfix) with ESMTP id 031E267A65
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Feb 2005 09:31:13 +1100 (EST)
Message-ID: <4220F8B8.7040407@sandburst.com>
Date: Sat, 26 Feb 2005 17:31:20 -0500
From: "Travis B. Sawyer" <tsawyer+linuxppc@sandburst.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <1628E43D99629C46988BE46087A3FBB91C4AA7@ep-01.EmbeddedPlanet.local>	<421F89A0.8070502@sandburst.com>
	<20050225133055.A28918@cox.net>	<421F966D.4060206@rossvideo.com>
	<20050225172941.A30499@cox.net>
In-Reply-To: <20050225172941.A30499@cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Ralph Siemsen <rsiemsen@rossvideo.com>,
	ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: 2.6 4xx GPIO OCP driver?
Reply-To: tsawyer+linuxppc@sandburst.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt Porter wrote:
> On Fri, Feb 25, 2005 at 04:19:41PM -0500, Ralph Siemsen wrote:
>>Will that work on the 440 where the devices sit above 4GB mark?  Or must 
>>one rely on there being an existing TLB mapping to bring them into 
>>32-bit space?

EINVAL.

mmap certainly didn't like the phys address of gpio.  Tried that.
> 
> 
> Ack...that's the one thing we are missing. :-/ I had forgotten
> that driver/char/mem.c  calls remap_pfn_range() directly rather
> than io_remap_page_range(). Had it called the latter, we'd be OK
> since the "bigphys" fixup could take place.  We can fix /dev/mem to
> call io_remap_page_range() when on ppc32 && 36-bit phys...other arches
> do similar tricks in that driver.
> 

Sounds like a plan, I'd be happy to test it out.

> If everybody is happy with mmaping /dev/mem then we can go try that
> route.
> 

Thanx,

Travis
