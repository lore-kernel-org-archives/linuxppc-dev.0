Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 4/4] DTC: Begin the path to sane literals and expressions.
In-Reply-To: Your message of "Sat, 20 Oct 2007 18:47:37 +1000."
	<20071020084737.GG26642@localhost.localdomain>
References: <E1Iivsg-00078a-Vp@jdl.com>
	<20071020084737.GG26642@localhost.localdomain>
Date: Thu, 25 Oct 2007 13:24:57 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Il7O5-00036T-Iy@jdl.com>
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
> > Use of "d#', "o#", "h#" and "b#" are gone in version 1.
> 
> Also good.  We might want to keep b#, since there's no C way of doing
> binary literals, but in that case I'd suggest recognizing it at the
> lexical level, not the grammar level as we do now (which would mean a
> space between the b# and the digits would no longer be permissible).

I added 0(b|B)[01]+ literal support.

> Now my big concern with this patch: the dts_version global, set by the
> parser, used by the lexer.  I assume you've tested this and it works
> in practice,

Yes.

> but you're relying on the semantic action from the .y
> file being executed before the lexer meets any token that depends on
> it.

Of course that is how it works.  No problem.

> I don't know about you, but I have to think pretty hard about how flow
> of control will move between lexer and parser rules in a shift-reduce
> parser at the best of times.  With the %glr-parser option, bison will
> use the Tomita algorithm.  That means the parser state could be split
> if there are ambiguities, or non-LALR(1) portions of the grammar
> (which there are).  In that case the execution of the parser rules
> will be delayed until after the split is resolved again, however many
> tokens down the track.

So, I removed the ambiguity.

> Therefore, I'd prefer that instead of having this general version
> number, we introduce a separate token for each new version.  So
> /dts-version-1/ or whatever.  Any new, incompatible, dts version is a
> big deal in any case - not something we want to happen often - so a
> new token for each version is not a big deal, I think.  With this
> approach, the version flag can be tripped in the lexer, and the
> ordering of lexer rule execution is obvious.

I don't see how this will work at the purely lexical level in
a reliable way.  Sure, I see the lexer matching the token and
setting some variable (dts_version = 0 or 1) as needed.

But there is no really good way to enforce that this happens at
an early enough state that it covers the rest of the file short
of having a staged lexical context state machine.  And that just
seems way hacky to me.

With it in the grammar, we can enforce it being early in the file
and can be assured of it happening in time to affect the rest of
the parse.  Personally, I think having it be a general statement
like:

    /<option>/ <value> ;

makes a whole lot more sense than having the purely lexical
context.  Future versions of the DTS files will be syntactically
correct even when moving to a (now) hypothetical version 2 file.


> I'm also inclined to leave the syntax for bytestrings as it is, in

Why?  Why not be allowed to form up a series of expressions
that make up a byte string? Am I missing something obvious here?

> [snip]
> > +<*>{DOT}{DOT}	{
> 
> You should be able to just use \.\. or ".." here rather than having to
> indirect through a character class.

Oh, yeah, I meant to revert that again.  No problem.

> > +0(x|X){HEXDIGIT}+	{
> 
> Does C recognize both 0x and 0X, or just 0x?  I don't remember off the
> top of my head.

Yep.

> > +u64 expr_from_string(char *s, unsigned int base)
> > +{
> > +	u64 v;
> > +	char *e;
> > +
> > +	v = strtoull(s, &e, base);
> > +	if (*e) {
> > +		fprintf(stderr,
> > +			"Line %d: Invalid literal value '%s' : "
> > +			"%c is not a base %d digit; %lld assumed\n",
> > +			yylloc.first_line, s, *e,
> > +			base == 0 ? expr_default_base : base,
> > +			(unsigned long long) v);
> 
> Do we need this error checking?  Won't the regexes mean that the
> string *must* be a valid literal by this point?

It's still needed for the legacy bits where you have modified
the base for the following numbers.  Specifically, you can say
something like "d# 123abc" and it will scan lexically, but
not be correct semantically still.  Blah.

> > @@ -46,25 +47,27 @@ extern struct boot_info *the_boot_info;
> >  	int hexlen;
> >  	u64 addr;
> >  	struct reserve_info *re;
> > +	u64 ire;
> 
> What's "ire" supposed to be short for?

Oh, longer term.  I have a intermediate representation for
expressions up my sleeve.  Sorry, wasn't clear there...

> > +	| label DT_MEMRESERVE expr '-' expr ';'
> 
> Oh.. you haven't actually abolished the '-' syntax, even in version 1
> mode.  Since we're already making an incompatible syntax change, we
> should really make this one at the same time.

I can make that fail, no problem.

> > +cell:
> > +	  expr
> > +		{
> > +			$$ = expr_cell_value($1);
> > +		}
> > +	;
> > +
> > +expr:
> > +	  expr_primary
> > +	;
> > +
> > +expr_primary:
> > +	  opt_cell_base DT_LITERAL
> > +		{
> > +			$$ = $2;
> > +		}
> 
> Hrm.  I realise you haven't actually implemented expressions here, but

Right.  Initial framework....

> > +void yywarn(char const *s, ...)
> 
> Ick.. we can tolerate yyblah() names for the things we inherit from
> yacc, but lets not introduce our own, hey.

It's pretty normal, I think.  But we can introduce something else
and map yyerror() into an error variant.  Got name suggestions?



> > +unsigned int dts_version = 0;
> > +unsigned int expr_default_base = 10;
> > +
> > +
> > +void set_dts_version(u64 vers)
> > +{
> > +	if (vers > 1) {
> > +		yywarn("Unknown version %lld; 0 assumed\n", vers);
> > +		dts_version = 0;
> > +	} else {
> > +		dts_version = vers;
> > +	}
> > +
> > +	if (dts_version == 0) {
> > +		expr_default_base = 16;
> > +		in_lexer_use_base = 16;
> > +	} else {
> > +		expr_default_base = 10;
> > +		in_lexer_use_base = 10;
> 
> Uh.. I don't think we should need either of expr_default_base and
> in_lexer_use_base, let alone both..

You need to temporarily know what the base of the next number
will be for "d#"-like constructs, and then you need to know
what to revert to again (default).  Sure, we could consult the
dts_version again directly at that time if you'd rather.


> > -		fprintf(f, "%x", be32_to_cpu(*cp++));
> > +		if (dts_version == 0) {
> 
> Where does dts_version get set in the -Odts case?

The same call to set_dts_version() as any other case.

jdl
