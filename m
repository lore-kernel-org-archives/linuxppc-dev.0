Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 9EEB5DDEC7
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2007 07:52:59 +1000 (EST)
Date: Fri, 12 Oct 2007 14:53:11 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC] [PATCH] PowerPC: add more than 4MB kernel image size
	support to bootwarapper
Message-ID: <20071012215311.GD22894@mag.az.mvista.com>
References: <20070924113627.GA30504@ru.mvista.com>
	<20070925022935.GI30338@localhost.localdomain>
	<46FD0E4D.30305@ru.mvista.com>
	<20071003055005.GD18978@localhost.localdomain>
	<20071005015849.GA9862@mag.az.mvista.com>
	<20071005173054.GA4295@loki.buserror.net>
	<20071005210320.GE6663@mag.az.mvista.com>
	<47098882.1010900@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47098882.1010900@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 07, 2007 at 08:31:46PM -0500, Scott Wood wrote:

Sorry for the delay, Scott.

> Mark A. Greer wrote:
> >Why?  Because its only safe to download a zImage to certain "safe" 
> >locations.
> >Where those "safe" locations are vary by firmware, firmware version, and
> >zImage size.  This is the issue we're discussing.
> 
> In theory, yes -- but in practice the odds of this particular heuristic 
> choosing an unsuitable address seem slim.

Yes, it probably will work fairly well for most powerpc 32-bit platforms
since the default in arch/ppc was 8MB (but there was a manual override
that was used by some platforms).  That still doesn't make it safe for
everyone 32-bit or 64-bit.

> >I've already explained _why_ the link address matters WRT where its 
> >downloaded.
> 
> Sorry, I was being a bit too pendantic with respect to the distinction 
> between link and load address.

And I was probably too impatient.  Sorry.

> >>>Also, being able to control the link address (that is, the download
> >>>address with some firmwares) is not a u-boot specific issue and we
> >>>shouldn't make a u-boot specific solution.
> >>How is this a u-boot specific solution?
> >
> >Because the hoops being jumped through in the patch(es) are to make
> >u-boot happy and no other firmware.
> 
> No, the "hoops" (which I don't think are sufficiently complicated to 
> warrant such a name)

Not yet maybe but as exceptions come along
	". = ALIGN((_kend - _kstart + 64*1024), (4*1024*1024));"
will become more complicated.

> are to address a generic issue with the bootwrapper 
> -- it wants to put the kernel at zero.  It'd be really nice if, in the 
> absense of a vmlinux_alloc method, the generic code would do an ordinary 
> malloc() if there's not enough room at zero.

Actually, that's a good idea but its only for safety sake.  When you
unpack the kernel at somewhere other than 0, there will be an additional
copy very early during kernel boot to copy itself to address 0.  So, if
we add that feature we should print a warning so the user knows extra
time was spent copying the kernel to 0.  If we can come up with a simple
way to control the link address we can avoid that copy.

> >>I'd much rather it be automatic than require the user to guess an
> >>appropriate value (and be aware in the first place that it needs to be 
> >>set).
> >
> >Sure, automatic is nice; conjuring up the magic to make it work in all
> >situations isn't.
> 
> I think this heuristic would work in most situations, so if we do add a 
> manual override it should be an override, and not something that 
> everybody has to put up with.

Okay, so how about we just leave the default at 4MB and come up with
that manual override??  ;)

> >Having the link address--and therefore the download address on some
> >systems--mysteriously and uncontrollably jump around based on the zImage
> >size is asking for trouble.
> 
> It's a source of potential issues, but I think "asking for trouble" is 
> exaggerating somewhat.

Noted and disagreed with. :)

Mark
