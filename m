Return-Path: <dgibson@ozlabs.org>
Date: Wed, 21 Feb 2007 11:16:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [RFC 3/3] zImage: Exception vector support
Message-ID: <20070221001623.GA10231@localhost.localdomain>
References: <45D7A914.4040000@am.sony.com>
	<20070220022538.GH17818@localhost.localdomain>
	<45DB0448.9080301@am.sony.com> <45DB1759.2010302@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45DB1759.2010302@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 20, 2007 at 07:44:25AM -0800, Geoff Levand wrote:
> Geoff Levand wrote:
> > David Gibson wrote:
> >> On Sat, Feb 17, 2007 at 05:17:08PM -0800, Geoff Levand wrote:
> >>> Add SMP exception vector support to the powerpc zImage bootwrapper.  For
> >>> platforms which have entry points in the vector table.  This implements
> >>> SMP entry via the system reset vector.
> >> 
> >> I really don't like having always-included code take over the absolute
> >> start of the zImage's address space.  The whole idea in my entry
> >> cleanup patch is that the platform code gets control of the "head.S"
> >> area, so we can potentially support platforms with conflicting
> >> hard-wired requirements for things at specific offsets.
> >> 
> >> I think this belongs in a ps3.o, which will define _zimage_start to be
> >> identical to the reset vector.
> >> 
> > 
> > I need two entry points, one for the first stage loader (0x100), and one
> > for a second stage kexec loader (_zimage_start).

Ok, in that case you can have a separate _zimage_start from the reset
vector.

> Sorry, I should have been more clear.  This is what I have in the wrapper.
> My intension was that head.S is only used for platforms that need it.
> 
> +ps3)
> +    platformo="$object/head.o $object/ps3-hvcall.o $object/ps3.o"
> +    ;;
> 
> Having those vectors makes a 4MB dead gap in the binary image.  The ps3's
> loader supports a gziped image so there is no problem, but for the general
> case of binary images, there is no way we can have those always in there.

Ah, ok, that's reasonable.  However, for the time being, PS3 is the
only platform that needs this.  I think it would be better to do this
as a PS3 specific wrapper initially.  Later, if we get other platforms
that need a reset vector we can see what's really common and
consolidate it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
