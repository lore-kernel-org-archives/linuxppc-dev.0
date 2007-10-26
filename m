Return-Path: <dgibson@ozlabs.org>
Date: Sat, 27 Oct 2007 00:03:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 4/4] DTC: Begin the path to sane literals and expressions.
Message-ID: <20071026140329.GA15404@localhost.localdomain>
References: <E1Iivsg-00078a-Vp@jdl.com>
	<20071020084737.GG26642@localhost.localdomain>
	<E1Il7O5-00036T-Iy@jdl.com>
	<20071026012832.GC457@localhost.localdomain>
	<E1IlOuj-0000lw-7E@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IlOuj-0000lw-7E@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 26, 2007 at 08:07:49AM -0500, Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
> > 
> > Ah... I think I see the source of our misunderstanding.  Sorry if I
> > was unclear.  I'm not saying that the version token would be
> > invisible to the parser, just that it would be recognized by the lexer
> > first.
> 
> Ah! Right.  OK, I see what you are saying now.
> 
> > The nice thing about having a token, is that if necessary we can
> > completely change the grammar for each version, without having to have
> > tangled rules that have to generate yyerror()s in some circumstances
> > depending on the version variable.  The alternate grammars can be
> > encoded directly into the yacc rules:
> > 	startsymbol : version0_file
> > 		    | V1_TOKEN version1_file
> > 		    | V2_TOKEN version2_file
> > 		    ;
> 
> Hmmm...  Now that I see that your symbol is still in the grammar,
> I can see this part as well.  OK.  I'll buy it.

Yay! :)

> > > > I'm also inclined to leave the syntax for bytestrings as it is, in
> > > 
> > > Why?  Why not be allowed to form up a series of expressions
> > > that make up a byte string? Am I missing something obvious here?
> > 
> > Because part of the point of bytestrings is to provide representation
> > for binary data.  For a MAC address, say
> > 	[0x00 0x0a 0xe4 0x2c 0x23 0x1f]
> > is way bulkier than
> > 	[000ae42c231f]
> 
> No, I think you misuderstand what I was after.  I'm not after the
> the latter [000ae4...].  In that case, there would be multiple
> expressions, each no bigger than 8 bits wide:
> 
>     [ expr expr expr    expr  expr      expr ]
>     [ 0x00   10 0x4  0x20+12 '0'+3  0x20 - 1 ]
> 
> or whatever seemed appropriate.  It would not be one giant value.

Yes, I realise that.  My point is that [000ae42c231f] is valid *now*
and is a nice compact way of doing explicit bytestrings.  That would
become much bulkier with your proposal.

[snip]
> > Incidentally, there's another problem here: we haven't solved the
> > problem about having to allow property names with initial digits.
> 
> I know.

Yeah, have a look at my 1/2 patch - it addresses this, and I think a
bunch of related problems that would come with expression syntax.

> > That's a particular problem here, because although we can make
> > literals scanned in preference to propnames of the same length, in
> > this case
> > 	0x1234..0xabcd
> > Will be scanned as one huge propname.
> 
> I know.  White space is mandatory right now.

Ick.

> > This might work for you at the moment, if you've still got all the
> > lexer states, but I was really hoping we could ditch most of them with
> > the new literals.
> 
> Which is really why they are all still there.  Longer term,
> I want to _quit_ supporting "version 0" and remove the cruft...
> 
> > But you haven't actually addressed my concern about this.  Actually
> > it's worse that I said then, because
> > 	<0x10000000 -999>
> > is ambiguous.  Is it a single subtraction expression, or one literal
> > cell followed by an expression cell with a unary '-'?
> 
> Gah.
> 
> Paren'ed expressions may be the thing to do.
> How do you feel about comma separation?

I'm not keen on it.  I think paren'ed expressions are reasonable.
Grammatically the cell values would be literal | '(' expr ')'.  As
you've probably noticed in your expression research, there's generally
already a non-terminal just like that within expression grammars,
anyway.

[snip]
> > > The same call to set_dts_version() as any other case.
> > 
> > Erm... which same call to set_dts_version()?  Surely not the one in
> > the parser..
> 
> I'm clearly not understanding your point, I'm afraid.  There are
> static default values here:
> 
>     /*
>      * DTS sourcefile version.
>      */
>     unsigned int dts_version = 0;
>     unsigned int expr_default_base = 10;
> 
> And there is a call to set_dts_version() made when any DTS file
> is parsed, which happens before any -O option is even handled.
> 
> What am I missing?

The dts version for output should be independent of the dts version
for input (in fact it should probably be locked to v1).  In -Idtb
-Odts mode, there will be no dts file parsed before dts output, and it
would be neat if -Idts -Odts mode would convert from v0 to v1 (another
thing on my to-do list is to change things so -Idts -Odts will
preserve labels from input to output).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
