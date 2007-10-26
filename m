Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 4/4] DTC: Begin the path to sane literals and expressions.
In-Reply-To: Your message of "Fri, 26 Oct 2007 11:28:32 +1000."
	<20071026012832.GC457@localhost.localdomain>
References: <E1Iivsg-00078a-Vp@jdl.com>
	<20071020084737.GG26642@localhost.localdomain>
	<E1Il7O5-00036T-Iy@jdl.com>
	<20071026012832.GC457@localhost.localdomain>
Date: Fri, 26 Oct 2007 08:07:49 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IlOuj-0000lw-7E@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> 
> Ah... I think I see the source of our misunderstanding.  Sorry if I
> was unclear.  I'm not saying that the version token would be
> invisible to the parser, just that it would be recognized by the lexer
> first.

Ah! Right.  OK, I see what you are saying now.

> The nice thing about having a token, is that if necessary we can
> completely change the grammar for each version, without having to have
> tangled rules that have to generate yyerror()s in some circumstances
> depending on the version variable.  The alternate grammars can be
> encoded directly into the yacc rules:
> 	startsymbol : version0_file
> 		    | V1_TOKEN version1_file
> 		    | V2_TOKEN version2_file
> 		    ;

Hmmm...  Now that I see that your symbol is still in the grammar,
I can see this part as well.  OK.  I'll buy it.

> > > I'm also inclined to leave the syntax for bytestrings as it is, in
> > 
> > Why?  Why not be allowed to form up a series of expressions
> > that make up a byte string? Am I missing something obvious here?
> 
> Because part of the point of bytestrings is to provide representation
> for binary data.  For a MAC address, say
> 	[0x00 0x0a 0xe4 0x2c 0x23 0x1f]
> is way bulkier than
> 	[000ae42c231f]

No, I think you misuderstand what I was after.  I'm not after the
the latter [000ae4...].  In that case, there would be multiple
expressions, each no bigger than 8 bits wide:

    [ expr expr expr    expr  expr      expr ]
    [ 0x00   10 0x4  0x20+12 '0'+3  0x20 - 1 ]

or whatever seemed appropriate.  It would not be one giant value.

> And in bytestring context, I suspect having every expression result be
> truncated to bytesize will be way more of a gotcha than in cell
> context.

Which is why we run a semantic checking as well and warn on
values not fitting in container sizes.

> I suspect we can get the expression flexibility we want here by
> providing the right operators to act *on* bytestrings, rather than
> within bytestrings.

That too.  No problem.  I suspect some may be functional, though.
Haven't thought about that a bunch yet.  I just want to get
basis stuff in first.


> Hrm.  I think just exprval or intval would be better.  Actually
> probably intval, since last we spoke I though we were planning on
> having expressions of string and bytestring types as well.

Except I think we want more generalized than that.

> Incidentally, there's another problem here: we haven't solved the
> problem about having to allow property names with initial digits.

I know.

> That's a particular problem here, because although we can make
> literals scanned in preference to propnames of the same length, in
> this case
> 	0x1234..0xabcd
> Will be scanned as one huge propname.

I know.  White space is mandatory right now.

> This might work for you at the moment, if you've still got all the
> lexer states, but I was really hoping we could ditch most of them with
> the new literals.

Which is really why they are all still there.  Longer term,
I want to _quit_ supporting "version 0" and remove the cruft...

> But you haven't actually addressed my concern about this.  Actually
> it's worse that I said then, because
> 	<0x10000000 -999>
> is ambiguous.  Is it a single subtraction expression, or one literal
> cell followed by an expression cell with a unary '-'?

Gah.

Paren'ed expressions may be the thing to do.
How do you feel about comma separation?

Anyone else care to chime in?

> > > > +unsigned int dts_version = 0;

> Yeah, I figured this out after.  Youch, an even tighter and harder to
> follow coupling between lexer and parser execution order.  I can think
> of at least two better ways to do this.

I'm listening... :-)

> 1) handle d# b# etc. at the lexer lexel, with a regex like
> (d#{WS}*[0-9]+).  Strictly speaking that changes the language, but I
> don't think anyone's been insane enough to do something like "d#
> /*stupid comment*/ 999".  That would remove the whole ugly
> opt_cell_base tangle from the grammar.

That seems like it could work...

> 2) Have the lexer just pass up literals as strings, and let the parser
> do the conversion to integer, based on the grammatical context.  I
> think this is preferable because it has other advantages: we can do
> the distinction between 64-bit values for memreserve and 32-bit values
> for cell at the grammatical level.  It can also be used to handle the
> propname/literal ambiguity without lexer states (I had a patch a while
> back which removed the MEMRESERVE and CELLDATA lex states using this
> technique).

I'm not so keen on that approach, I don't think.

> > The same call to set_dts_version() as any other case.
> 
> Erm... which same call to set_dts_version()?  Surely not the one in
> the parser..

I'm clearly not understanding your point, I'm afraid.  There are
static default values here:

    /*
     * DTS sourcefile version.
     */
    unsigned int dts_version = 0;
    unsigned int expr_default_base = 10;

And there is a call to set_dts_version() made when any DTS file
is parsed, which happens before any -O option is even handled.

What am I missing?

jdl
