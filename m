Return-Path: <dgibson@ozlabs.org>
Date: Mon, 11 Jul 2005 14:55:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Message-ID: <20050711045532.GC32545@localhost.localdomain>
References: <1120859097.8609.15.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1120859097.8609.15.camel@cashmere.sps.mot.com>
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

On Fri, Jul 08, 2005 at 04:44:58PM -0500, Jon Loeliger wrote:
> David and Ben,
> 
> This patch adds support for memreserve to the DTC's notion
> of the "source file".  That is, you can now say this:
>         
>         
>         memreserve =	<
>         		 0000 0001  0000 0002
>         		 0000 0003  0000 0004
>         		>
>         
>         / {
>         	model = "MPC8555CDS";
>         	compatible = "MPC85xxCDS";
>         	#address-cells = <2>;
>         	#size-cells = <2>;
>         	linux,phandle = <100>;

Hrm.. nice idea, but I don't really like the syntax.  It looks like a
property definition, which it's really not, and forcing the user to
split up these 64-bit quantities into cells is kind of silly.  Plus
the fact that "memreserve" is lexed as a reserved word means it can't
be used as a property name.  And it really ought to have a ';' at the
end, for consistency.

Hrm... wonder how to do this, without making the lex and yacc stuff
too unspeakable.

Maybe

/memreserve/ = {  00000001-00000002;
		  00000003-00000004;
	       };

I'm not that fond of the /.../ form, although the '/' is the best way
I can think of to ensure it can't be confused with a property or node
name.  We'lll also need some sort of lexing magic so that it actually
recognizes the things within as numbers, not property names, too.
Hrm... will need to think about that.

> There is minor fiddling with the -R flag that needs to be
> resolved at this point.

I think -R should add the given number of extra empty entries, on top
of the ones given in the source.

> I've included read and writing for the source and blob formats,
> but don't have a clue what to do with the /proc/devices format.

Just ignore it, I think.  If you need memreserves with fs input, you
can just use -R and patch them in later.

> I've also tinkered the Makefile to do automatic dependency
> file generation and inclusion.  Yep, I got bit by out of
> date dependencies during my development here. :-)

Hrm.. seems kinda overkill for a project this small, but ok.  Although
it would be nice to have this as a separate patch.

> Please feel free to adjust my coding approach or argument
> passing or whatever as needed.  Hope this helps!

Yeah, there are some things I'd like to change (in addition to the
input syntax itself), but I'm thinking about just applying it and
fixing up afterwards.

Biggest thing is that rather than passing the tree itself and the
memreserve info about as two parameters all over the place, I'd rather
create a new structure which has both (and later can have anything
else that might be needed).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
