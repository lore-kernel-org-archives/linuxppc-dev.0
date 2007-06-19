Return-Path: <dgibson@ozlabs.org>
Date: Tue, 19 Jun 2007 11:25:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] boot: find initrd location from device-tree
Message-ID: <20070619012557.GB24530@localhost.localdomain>
References: <111819314606b8b45671.846930886.miltonm@bga.com>
	<4672EE95.3030407@freescale.com>
	<fbae4506b772f07d2a8c1d230bea82c8@bga.com>
	<bfbd4f126c427f590198a3e50a789b0c@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bfbd4f126c427f590198a3e50a789b0c@kernel.crashing.org>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 18, 2007 at 02:52:12PM +0200, Segher Boessenkool wrote:
> >>> +     /* if the initrd is above 4G, its untouchable in 32 bit mode */
> >>> +     if (initrd_end <= UINT_MAX && initrd_start < initrd_end) {
> >>> +             loader_info.initrd_addr = initrd_start;
> >>> +             loader_info.initrd_size  = initrd_end - initrd_start;
> >>> +     } else {
> >>> +             printf("ignoring loader supplied initrd parameters\n");
> >>
> >> Saying why might be helpful.
> >
> > Hmm... well, that would mean seperating the && of the if; there are two
> > possible reasons. (1) this 32-bit code can't handle such large
> > addresses (in which case a 64-bit kernel may work), and (2) end is >=
> > start (which means there really isn't any data.  I suppose I could
> > reverse the sense of the if, use an else if, and make the final else
> > the good path.
> 
> "ignoring loader supplied nonsensical initrd parameters"
> 
> You do need to fix the comment, though :-)
> 
> >>> +#define _LIBC_LIMITS_H_              /* don't recurse to system's
> >> headers */
> >>> +#include <limits.h>          /* MAX_UINT, etc */
> >>> +
> >>
> >> I think it's really a bad idea to use any headers from outside the
> >> boot context here.  We're dealing with explicit sized ints, so we can
> >> safely define our own constants giving the limit values.
> >
> > As I said in the patch changelog, the only headers picked up here are
> > libgcc.
> 
> Which the kernel doesn't use.  It _should_ be fine
> nevertheless, <limits.h> is part of the "freestanding"
> headers -- why do you need to do a "libc" trick though?
> This doesn't work when not using glibc I guess?

IMO if it needs this define magic to work properly, it's not a good
idea to include it at all.  Especially since avoiding it is easy and
safe in this case.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
