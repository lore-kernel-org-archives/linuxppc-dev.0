Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13A54679E0
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Mar 2006 10:12:43 +1100 (EST)
Subject: Re: Unmapping pages from the linear addressing without HIGHMEM	support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <051c9d8f422b0e5289b7083367cf44ca@embeddedalley.com>
References: <1141942301.3603.12.camel@localhost.localdomain>
	<22544.1141981797@www088.gmx.net>
	<051c9d8f422b0e5289b7083367cf44ca@embeddedalley.com>
Content-Type: text/plain
Date: Sat, 11 Mar 2006 10:12:31 +1100
Message-Id: <1142032351.4057.29.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-03-10 at 07:59 -0500, Dan Malek wrote:
> On Mar 10, 2006, at 4:09 AM, Gerhard Pircher wrote:
> 
> > That would mean I cannot reuse the code in dma-mapping.c, right?
> 
> Sure you can.  All you need to do is turn of BAT mapping, which
> is as easy as using the 'nobats' command line parameter and
> all of this code should just work for you.

And the kernel will blow up in flames under various funny circumstances
and you'll lose a fair amount of performances.

The 6xx kernel requires at least the IBAT mapping the kernel text. Some
of the exception handling code path can't deal with getting a hash fault
at critical locations (they can mostly deal with data hash misses
nowadays, but the code has to be accessible at all times).

> > ...   but I guess I have to setup my own page table for the reserved
> > DMA memory area and implement my own alloc_pages() function!?
> 
> No, that's already done for you behind all of these functions.
> 
> Thanks.
> 
> 	-- Dan
> 
> 
