Return-Path: <dgibson@ozlabs.org>
Date: Fri, 26 Oct 2007 11:28:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 4/4] DTC: Begin the path to sane literals and expressions.
Message-ID: <20071026012832.GC457@localhost.localdomain>
References: <E1Iivsg-00078a-Vp@jdl.com>
	<20071020084737.GG26642@localhost.localdomain>
	<E1Il7O5-00036T-Iy@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1Il7O5-00036T-Iy@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 25, 2007 at 01:24:57PM -0500, Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
> > > Use of "d#', "o#", "h#" and "b#" are gone in version 1.
> > 
> > Also good.  We might want to keep b#, since there's no C way of doing
> > binary literals, but in that case I'd suggest recognizing it at the
> > lexical level, not the grammar level as we do now (which would mean a
> > space between the b# and the digits would no longer be permissible).
> 
> I added 0(b|B)[01]+ literal support.

Ok.

[snip]
> > Therefore, I'd prefer that instead of having this general version
> > number, we introduce a separate token for each new version.  So
> > /dts-version-1/ or whatever.  Any new, incompatible, dts version is a
> > big deal in any case - not something we want to happen often - so a
> > new token for each version is not a big deal, I think.  With this
> > approach, the version flag can be tripped in the lexer, and the
> > ordering of lexer rule execution is obvious.
> 
> I don't see how this will work at the purely lexical level in
> a reliable way.  Sure, I see the lexer matching the token and
> setting some variable (dts_version = 0 or 1) as needed.

> But there is no really good way to enforce that this happens at
> an early enough state that it covers the rest of the file short
> of having a staged lexical context state machine.  And that just
> seems way hacky to me.
>
> With it in the grammar, we can enforce it being early in the file
> and can be assured of it happening in time to affect the rest of
> the parse.  Personally, I think having it be a general statement
> like:

Ah... I think I see the source of our misunderstanding.  Sorry if I
was unclear.  I'm not saying that the version token would be
invisible to the parser, just that it would be recognized by the lexer
first.

So, the grammar would still need to specify that the magic version
token comes first, of course.  A file which had it in the middle would
lex very strangely, but it wouldn't matter because it will never pass
the parser anyway.

>     /<option>/ <value> ;
> 
> makes a whole lot more sense than having the purely lexical
> context.  Future versions of the DTS files will be syntactically
> correct even when moving to a (now) hypothetical version 2 file.

I see that as bad thing not a good thing.  The only reason to bump the
version number is for *incompatible* source changes - that's why we're
doing it now, because the new representation would be ambiguous with
the current representation without something specifying which we're
using.  Therefore future files *shouldn't* be syntactically correct
with a current parser.

The nice thing about having a token, is that if necessary we can
completely change the grammar for each version, without having to have
tangled rules that have to generate yyerror()s in some circumstances
depending on the version variable.  The alternate grammars can be
encoded directly into the yacc rules:
	startsymbol : version0_file
		    | V1_TOKEN version1_file
		    | V2_TOKEN version2_file
		    ;

> > I'm also inclined to leave the syntax for bytestrings as it is, in
> 
> Why?  Why not be allowed to form up a series of expressions
> that make up a byte string? Am I missing something obvious here?

Because part of the point of bytestrings is to provide representation
for binary data.  For a MAC address, say
	[0x00 0x0a 0xe4 0x2c 0x23 0x1f]
is way bulkier than
	[000ae42c231f]

And in bytestring context, I suspect having every expression result be
truncated to bytesize will be way more of a gotcha than in cell
context.

I suspect we can get the expression flexibility we want here by
providing the right operators to act *on* bytestrings, rather than
within bytestrings.

[snip]
> > > +u64 expr_from_string(char *s, unsigned int base)
> > > +{
> > > +	u64 v;
> > > +	char *e;
> > > +
> > > +	v = strtoull(s, &e, base);
> > > +	if (*e) {
> > > +		fprintf(stderr,
> > > +			"Line %d: Invalid literal value '%s' : "
> > > +			"%c is not a base %d digit; %lld assumed\n",
> > > +			yylloc.first_line, s, *e,
> > > +			base == 0 ? expr_default_base : base,
> > > +			(unsigned long long) v);
> > 
> > Do we need this error checking?  Won't the regexes mean that the
> > string *must* be a valid literal by this point?
> 
> It's still needed for the legacy bits where you have modified
> the base for the following numbers.  Specifically, you can say
> something like "d# 123abc" and it will scan lexically, but
> not be correct semantically still.  Blah.

Uh, yeah, that.  And as I realised afterwards also in case some one
writes 09999.  The latter can be banned in the grammar, but not doing
so will give better error messages (e.g. "invalid digits in octal
literal" instead of "syntax error").

Actually, possibly we should make the literal regex allow [0-9a-zA-Z]
after the initial digit or 0x, so that 0xabcdzoom gives an error,
rather than parsing as a literal followed by a name, which could be
confusing to say the least.  Of course that will make the literal/name
ambiguity worse (see below).

> > > @@ -46,25 +47,27 @@ extern struct boot_info *the_boot_info;
> > >  	int hexlen;
> > >  	u64 addr;
> > >  	struct reserve_info *re;
> > > +	u64 ire;
> > 
> > What's "ire" supposed to be short for?
> 
> Oh, longer term.  I have a intermediate representation for
> expressions up my sleeve.  Sorry, wasn't clear there...

Hrm.  I think just exprval or intval would be better.  Actually
probably intval, since last we spoke I though we were planning on
having expressions of string and bytestring types as well.

> > > +	| label DT_MEMRESERVE expr '-' expr ';'
> > 
> > Oh.. you haven't actually abolished the '-' syntax, even in version 1
> > mode.  Since we're already making an incompatible syntax change, we
> > should really make this one at the same time.
> 
> I can make that fail, no problem.

Incidentally, there's another problem here: we haven't solved the
problem about having to allow property names with initial digits.
That's a particular problem here, because although we can make
literals scanned in preference to propnames of the same length, in
this case
	0x1234..0xabcd
Will be scanned as one huge propname.

This might work for you at the moment, if you've still got all the
lexer states, but I was really hoping we could ditch most of them with
the new literals.

> > > +cell:
> > > +	  expr
> > > +		{
> > > +			$$ = expr_cell_value($1);
> > > +		}
> > > +	;
> > > +
> > > +expr:
> > > +	  expr_primary
> > > +	;
> > > +
> > > +expr_primary:
> > > +	  opt_cell_base DT_LITERAL
> > > +		{
> > > +			$$ = $2;
> > > +		}
> > 
> > Hrm.  I realise you haven't actually implemented expressions here, but
> 
> Right.  Initial framework....

But you haven't actually addressed my concern about this.  Actually
it's worse that I said then, because
	<0x10000000 -999>
is ambiguous.  Is it a single subtraction expression, or one literal
cell followed by an expression cell with a unary '-'?

[snip]
> > > +unsigned int dts_version = 0;
> > > +unsigned int expr_default_base = 10;
> > > +
> > > +
> > > +void set_dts_version(u64 vers)
> > > +{
> > > +	if (vers > 1) {
> > > +		yywarn("Unknown version %lld; 0 assumed\n", vers);
> > > +		dts_version = 0;
> > > +	} else {
> > > +		dts_version = vers;
> > > +	}
> > > +
> > > +	if (dts_version == 0) {
> > > +		expr_default_base = 16;
> > > +		in_lexer_use_base = 16;
> > > +	} else {
> > > +		expr_default_base = 10;
> > > +		in_lexer_use_base = 10;
> > 
> > Uh.. I don't think we should need either of expr_default_base and
> > in_lexer_use_base, let alone both..
> 
> You need to temporarily know what the base of the next number
> will be for "d#"-like constructs, and then you need to know
> what to revert to again (default).  Sure, we could consult the
> dts_version again directly at that time if you'd rather.

Yeah, I figured this out after.  Youch, an even tighter and harder to
follow coupling between lexer and parser execution order.  I can think
of at least two better ways to do this.

1) handle d# b# etc. at the lexer lexel, with a regex like
(d#{WS}*[0-9]+).  Strictly speaking that changes the language, but I
don't think anyone's been insane enough to do something like "d#
/*stupid comment*/ 999".  That would remove the whole ugly
opt_cell_base tangle from the grammar.

2) Have the lexer just pass up literals as strings, and let the parser
do the conversion to integer, based on the grammatical context.  I
think this is preferable because it has other advantages: we can do
the distinction between 64-bit values for memreserve and 32-bit values
for cell at the grammatical level.  It can also be used to handle the
propname/literal ambiguity without lexer states (I had a patch a while
back which removed the MEMRESERVE and CELLDATA lex states using this
technique).

> > > -		fprintf(f, "%x", be32_to_cpu(*cp++));
> > > +		if (dts_version == 0) {
> > 
> > Where does dts_version get set in the -Odts case?
> 
> The same call to set_dts_version() as any other case.

Erm... which same call to set_dts_version()?  Surely not the one in
the parser..

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
