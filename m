Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 57059DDDE4
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 07:03:22 +1000 (EST)
Date: Fri, 5 Oct 2007 14:03:20 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC] [PATCH] PowerPC: add more than 4MB kernel image size
	support to bootwarapper
Message-ID: <20071005210320.GE6663@mag.az.mvista.com>
References: <20070924113627.GA30504@ru.mvista.com>
	<20070925022935.GI30338@localhost.localdomain>
	<46FD0E4D.30305@ru.mvista.com>
	<20071003055005.GD18978@localhost.localdomain>
	<20071005015849.GA9862@mag.az.mvista.com>
	<20071005173054.GA4295@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071005173054.GA4295@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 05, 2007 at 12:30:54PM -0500, Scott Wood wrote:
> On Thu, Oct 04, 2007 at 06:58:49PM -0700, Mark A. Greer wrote:
> > Having the link address jump around depending on the size of the kernel
> > or zImage is wrong IMHO.  It just screams "weird can't boot issues."
> > We need a way to specify exactly where we want the zImage linked no
> > matter what the kernel or zImage size.
> 
> Why?

Why?  Because its only safe to download a zImage to certain "safe" locations.
Where those "safe" locations are vary by firmware, firmware version, and
zImage size.  This is the issue we're discussing.

I've already explained _why_ the link address matters WRT where its downloaded.

> The zImage is relocatable.  It doesn't matter where it's linked.

We know...and a zImage running at an address it wasn't linked at is
not the issue.

> > Also, being able to control the link address (that is, the download
> > address with some firmwares) is not a u-boot specific issue and we
> > shouldn't make a u-boot specific solution.
> 
> How is this a u-boot specific solution?

Because the hoops being jumped through in the patch(es) are to make
u-boot happy and no other firmware.

> > The more general problem is that some firmwares examine the ELF header
> > and download the zImage to address it was linked at.  Some firmwares let
> > you override this but some don't and those are the problem ones.
> 
> That's not the more general problem; it's the same problem with a different
> file format.

True, I misspoke.  I'll restate it this way:

The more general problem is that some firmwares will only download to
the address the zImage is linked at.  So, we need to control what that
link address is."

> > I still like my idea best.  I haven't coded yet it so I don't have a patch
> > but this is what I mean:
> > 
> > 1) add a config option (default 4MB) for the link address
> > 2) add a parameter to the wrapper script thru which we pass the value in
> >    the config option
> > 3) the wrapper script changes the VMA/LMA to the address specified
> >    (objcopy --change-addresses=<some math to get correct incr> ?).
> 
> I'd much rather it be automatic than require the user to guess an
> appropriate value (and be aware in the first place that it needs to be set).

Sure, automatic is nice; conjuring up the magic to make it work in all
situations isn't.

Having the link address--and therefore the download address on some
systems--mysteriously and uncontrollably jump around based on the zImage
size is asking for trouble.

Mark
