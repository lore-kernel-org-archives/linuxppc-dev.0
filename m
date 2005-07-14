Return-Path: <dgibson@ozlabs.org>
Date: Thu, 14 Jul 2005 11:02:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <20050714010246.GC15769@sneetch.ozlabs.ibm.com>
References: <1120859097.8609.15.camel@cashmere.sps.mot.com>
	<20050711045532.GC32545@localhost.localdomain>
	<1121116950.15394.14.camel@cashmere.sps.mot.com>
	<20050712020126.GE3945@localhost.localdomain>
	<597c90908e1aae7e7917be736d8901a3@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <597c90908e1aae7e7917be736d8901a3@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH: Add memreserve to DTC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 12, 2005 at 10:02:16AM +0200, Segher Boessenkool wrote:
> >>> and forcing the user to
> >>>split up these 64-bit quantities into cells is kind of silly.
> >>
> >>Hey, I didn't set that up! :-)  There wasn't an existing
> >>clean way to state 64 bit values, and an arbitrary list of
> >>them.  So I uh, leveraged the existing cell_t support!
> >
> >Cells make sense for the actual OF-like data, becayse they're an OF
> >concept.  For memreserve, which is purely Linux specific, they don't/
> 
> No.  This is _not_ what is called a cell.  "Cell" is a Forth concept.
> A cell can be any size.  Open Firmware puts the extra restriction on it
> to be _at least_ 32 bits.
> 
> The thing you are referring to is what is called in OF
> 
> 	"32-bit integer property encoding format".
> 
> It is defined to always be 32-bit, and not the cell size of the 
> firmware,
> so that you can use a 64-bit firmware with a 32-bit OS, and vice versa
> (of course there could be different reasons why this isn't practical, 
> but
> that's not the point).
> 
> In OF words, this format is normally abbreviated as "int".

My mistake, I misunderstood the terminology.  But the basic point is
that lots of things in the kernel already assume a cell is 32-bits, so
it would be silly to try and change that here.  This is not true for
the memreserve values.

> Btw -- beware of the fact that such an "int" does _not_ have any
> alignment restrictions -- so you better read it byte by byte...

Erm.. in what context.  dtc never reads ints from the blob format as
ints - properties are just byte strings to it.  At present you can't
mix cell input format with other sorts, which means the ints must, in
fact, be aligned, since properties are.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
