Return-Path: <dgibson@ozlabs.org>
Date: Wed, 21 Feb 2007 11:16:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC 3/3] zImage: Exception vector support
Message-ID: <20070221001653.GB10231@localhost.localdomain>
References: <45D7A914.4040000@am.sony.com>
	<20070220022538.GH17818@localhost.localdomain>
	<45DB0448.9080301@am.sony.com> <45DB1759.2010302@am.sony.com>
	<fc45fc62b1568ccaedb712d3a6eb5ca0@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fc45fc62b1568ccaedb712d3a6eb5ca0@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 20, 2007 at 05:02:11PM +0100, Segher Boessenkool wrote:
> > +ps3)
> > +    platformo="$object/head.o $object/ps3-hvcall.o $object/ps3.o"
> > +    ;;
> >
> > Having those vectors makes a 4MB dead gap in the binary image.  The 
> > ps3's
> > loader supports a gziped image so there is no problem, but for the 
> > general
> > case of binary images, there is no way we can have those always in 
> > there.
> 
> If this is an ELF file, you can put the exception vectors in a
> separate segment.  Or if you don't need the entry point to
> be in the low region, (and you don't need that unless your
> boot loader ignores the entry point in the ELF header), you can
> copy the vectors in at startup and have no code linked at 0 at
> all.

No, the initial loader has a hard-wired entry point, that's why this
is necessary.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
