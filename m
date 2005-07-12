Return-Path: <dgibson@ozlabs.org>
Date: Tue, 12 Jul 2005 12:01:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Message-ID: <20050712020126.GE3945@localhost.localdomain>
References: <1120859097.8609.15.camel@cashmere.sps.mot.com>
	<20050711045532.GC32545@localhost.localdomain>
	<1121116950.15394.14.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1121116950.15394.14.camel@cashmere.sps.mot.com>
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

On Mon, Jul 11, 2005 at 04:22:30PM -0500, Jon Loeliger wrote:
> On Sun, 2005-07-10 at 23:55, David Gibson wrote:
> > On Fri, Jul 08, 2005 at 04:44:58PM -0500, Jon Loeliger wrote:
> > > David and Ben,
> > > 
> > > This patch adds support for memreserve to the DTC's notion
> > > of the "source file".  That is, you can now say this:
> > >         
> > >         
> > >         memreserve =	<
> > >         		 0000 0001  0000 0002
> > >         		 0000 0003  0000 0004
> > >         		>
> 
> > 
> > Hrm.. nice idea, but I don't really like the syntax.  It looks like a
> > property definition, which it's really not,
> 
> Well, syntax is relatively easy to change.  I picked one 
> that was already present in the grammar and lex code.
> I wanted to use something more braces oriented, but it
> got gross looking once I decided to use the "struct data"
> parts for the cell_t values.
> 
> >  and forcing the user to
> > split up these 64-bit quantities into cells is kind of silly.
> 
> Hey, I didn't set that up! :-)  There wasn't an existing
> clean way to state 64 bit values, and an arbitrary list of
> them.  So I uh, leveraged the existing cell_t support!

Cells make sense for the actual OF-like data, becayse they're an OF
concept.  For memreserve, which is purely Linux specific, they don't/

> >   Plus
> > the fact that "memreserve" is lexed as a reserved word means it can't
> > be used as a property name.
> 
> Yeah, I wasn't happy about that either.  Wasn't sure
> what you wanted to do to "fix" that.  Thought it better
> to get the code into your hands than try to discuss the
> issues via mail.

Yeah... I have some ideas, maybe replacing some of the start
conditions with a lexical tie-in from the parser level.  I'll see what
I can come up with.

> >   And it really ought to have a ';' at the
> > end, for consistency.
> 
> Sure.  Easy.
> 
> And, I actually anticipated making the "header" parts
> of the grammar be more general, of which then the memory
> reserve area would be just one part.  For example, suppose
> you wanted to specify the "version" too:
> 
>     /header/ = {
>         version  = 10;
>         memreserve = < .... ....  .... .... >;
>     };

Perhaps, I don't think there's anything else that we really want to
set for now.  I don't think version should be set in the source file.

> Or so.

Actually, I'm having second thoughts on the form I suggested before.
I'm now leaning towards:

	/memreserve/ 00000001-00000002;
	/memreserve/ 00000003-00000004;

	/ {
		...
	};

> > Hrm... wonder how to do this, without making the lex and yacc stuff
> > too unspeakable.
> > 
> > Maybe
> > 
> > /memreserve/ = {  00000001-00000002;
> > 		  00000003-00000004;
> > 	       };
> > 
> > I'm not that fond of the /.../ form, although the '/' is the best way
> > I can think of to ensure it can't be confused with a property or node
> > name.  We'lll also need some sort of lexing magic so that it actually
> > recognizes the things within as numbers, not property names, too.
> > Hrm... will need to think about that.
> 
> Which was sort of the problem I faced... :-)
> 
> > > There is minor fiddling with the -R flag that needs to be
> > > resolved at this point.
> > 
> > I think -R should add the given number of extra empty entries, on top
> > of the ones given in the source.
> 
> Except now you have to carry the count along in the header.
> How else do you know if the _first_ or _last_ 0-size value
> really ends the list?  Well, you could maybe assume ordered
> parts an subtract the base offset of the memreserve section
> from the following section to get its total size.  Gross, though.
> 
> 
> > > Please feel free to adjust my coding approach or argument
> > > passing or whatever as needed.  Hope this helps!
> > 
> > Yeah, there are some things I'd like to change (in addition to the
> > input syntax itself), but I'm thinking about just applying it and
> > fixing up afterwards.
> 
> That sounds good.
> 
> > Biggest thing is that rather than passing the tree itself and the
> > memreserve info about as two parameters all over the place, I'd rather
> > create a new structure which has both (and later can have anything
> > else that might be needed).
> 
> If you'd like, I'll do this work.
> 
> jdl
> 
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
