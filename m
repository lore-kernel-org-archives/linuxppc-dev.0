Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 300F4DDF2F
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 01:33:10 +1000 (EST)
Date: Mon, 31 Mar 2008 10:33:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv2 2/3] ep8248e: Reference SMC parameter RAM base in the
	device tree.
Message-ID: <20080331153301.GA23806@ld0162-tx32.am.freescale.net>
References: <200803261217.46671.laurentp@cse-semaphore.com>
	<200803281854.28595.laurentp@cse-semaphore.com>
	<47ED33FC.3020107@freescale.com>
	<200803311109.02422.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200803311109.02422.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 31, 2008 at 11:08:58AM +0200, Laurent Pinchart wrote:
> On Friday 28 March 2008 19:07, Scott Wood wrote:
> > Yes, it tells you the virtual address when it's not an identity mapping. 
> >   It's not currently used on CPM platforms, but might be used down the 
> > road with a QE device on 85xx.
> 
> Will the virtual-reg property on the muram node list the addresses of all 
> muram chunks or the address of the first chunk only ?

It should list all the chunks.  If you want the size of each chunk, just
look at the reg property.

> > >> Even the end of the first reg resource would be OK.
> > > 
> > > If I use the end of the first resource, can I assume it spans 0x0000
> > > - 0x8000 to set the default tx BD address in Kconfig ?
> > 
> > No, especially seeing as it doesn't on any existing boards. :-)
> 
> I still need a default value :-) It obviously won't work for all boards.

Just before 0x8000 won't work for any board, because that area is
reserved on CPM2.

> > You could set the default to just before 0x2000 with board-specific 
> > exceptions, though.
> 
> We're getting a bit lost. I'll try to summarize the discussion.
> 
> - The muram node has a reg property that lists the offsets and sizes of all 
> muram chunks, and an optional virtual-reg property that lists the virtual 
> address of all chunks/the first chunk only.
> 
> - From the above information I can locate a section of muram at the end of the 
> first chunk (easy) or at the end of the muram (not really difficult, just a 
> bit more complex, especially if chunks are not sorted by their start 
> address).
> 
> - Kconfig needs a default address for the tx BD. This depends on the 
> allocation strategy (end of first chunk vs. end of last chunk). Is there some 
> consistent default across QE devices ?

0x2000 minus sizeof(...) would be a good default for CPM1 and CPM2 (8280
has its first chunk go up to 0x4000, but for some reason that didn't get
reflected in the dts for the one 8280 board in-tree).

-Scott
