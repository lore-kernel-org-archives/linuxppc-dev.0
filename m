Return-Path: <dgibson@ozlabs.org>
Date: Sat, 20 Oct 2007 18:47:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 4/4] DTC: Begin the path to sane literals and expressions.
Message-ID: <20071020084737.GG26642@localhost.localdomain>
References: <E1Iivsg-00078a-Vp@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1Iivsg-00078a-Vp@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 12:43:30PM -0500, Jon Loeliger wrote:
> 
> Add support for the "/dts-version/ <number>;" statment.
> Make legacy DTS files version 0 whether explicitly stated
> or implied by a lack of /dts-version/ statement.
> 
> Begin supporting a new /dts-version/ 1 that changes the
> format of the literals in a DTS source file.  In the new
> format, hex constants are prefixed with 0x or 0X, and
> bare numbers are decimal or octal according to standard
> conventions.

Hurrah!  Except that there's a few small details, and one biggish
detail that concern me.

> Property names have been limited to start with
> characters from the set [a-zA-Z,._#?].  That is, the
> digits and the expression symbols have been removed.

Good call.  Note that the rationale for the property and node name
regexes is a bit fuzzy: there's a standard for what's allowed in
IEEE1275, but existing IBM and Apple device trees break it in a number
of ways.  

> Use of "d#', "o#", "h#" and "b#" are gone in version 1.

Also good.  We might want to keep b#, since there's no C way of doing
binary literals, but in that case I'd suggest recognizing it at the
lexical level, not the grammar level as we do now (which would mean a
space between the b# and the digits would no longer be permissible).

> Several warnings are introduced for debatable constructs.
> 
> - Only /dts-version/ 0 and 1 are supported yet.
> 
> - A missing /dts-version/ statement garners a
>   suggestion to add one, and defaults to verion 0.
> 
> - The /memreserve/ construct using "-" for ranges looks
>   suspiciously like the subtraction of two expressions,
>   so its syntax has been changed to use ".." as the range
>   indicator.

Ah, yes.  An irritating change, but a necessary one, I agree.


Now my big concern with this patch: the dts_version global, set by the
parser, used by the lexer.  I assume you've tested this and it works
in practice, but you're relying on the semantic action from the .y
file being executed before the lexer meets any token that depends on
it.

I don't know about you, but I have to think pretty hard about how flow
of control will move between lexer and parser rules in a shift-reduce
parser at the best of times.  With the %glr-parser option, bison will
use the Tomita algorithm.  That means the parser state could be split
if there are ambiguities, or non-LALR(1) portions of the grammar
(which there are).  In that case the execution of the parser rules
will be delayed until after the split is resolved again, however many
tokens down the track.

Now, I'll grant that such a grammar ambiguity is unlikely around the
version statement.  But given the complexity of the situation, it
seems pretty risky to rely on execution ordering between parser and
lexer - I don't even know if there's a guarantee that bison won't
buffer lexer tokens before parsing them, which would screw us up in a
much less involved way.

Therefore, I'd prefer that instead of having this general version
number, we introduce a separate token for each new version.  So
/dts-version-1/ or whatever.  Any new, incompatible, dts version is a
big deal in any case - not something we want to happen often - so a
new token for each version is not a big deal, I think.  With this
approach, the version flag can be tripped in the lexer, and the
ordering of lexer rule execution is obvious.


A few more minor comments below:

[snip]
> diff --git a/dtc-lexer.l b/dtc-lexer.l
> index 278a96e..a1c52c4 100644
> --- a/dtc-lexer.l
> +++ b/dtc-lexer.l
> @@ -22,12 +22,19 @@
>  
>  %x INCLUDE
>  %x CELLDATA
> +%x CELLDATA_LEGACY
>  %x BYTESTRING
> +%x BYTESTRING_LEGACY
>  %x MEMRESERVE
> +%x MEMRESERVE_LEGACY

With the new syntax, integeral literals should no longer be ambiguous
with property or node names.  Therefore, we should only need legacy
CELLDATA and MEMRESERVE states, new-style literals can be recognized
in INITIAL state.

I'm also inclined to leave the syntax for bytestrings as it is, in
whichcase we should only need one lexical state for that, too.

[snip]
> +<*>{DOT}{DOT}	{

You should be able to just use \.\. or ".." here rather than having to
indirect through a character class.

[snip]
> +0(x|X){HEXDIGIT}+	{

Does C recognize both 0x and 0X, or just 0x?  I don't remember off the
top of my head.

[snip]
> +u64 expr_from_string(char *s, unsigned int base)
> +{
> +	u64 v;
> +	char *e;
> +
> +	v = strtoull(s, &e, base);
> +	if (*e) {
> +		fprintf(stderr,
> +			"Line %d: Invalid literal value '%s' : "
> +			"%c is not a base %d digit; %lld assumed\n",
> +			yylloc.first_line, s, *e,
> +			base == 0 ? expr_default_base : base,
> +			(unsigned long long) v);

Do we need this error checking?  Won't the regexes mean that the
string *must* be a valid literal by this point?

[snip]
> @@ -46,25 +47,27 @@ extern struct boot_info *the_boot_info;
>  	int hexlen;
>  	u64 addr;
>  	struct reserve_info *re;
> +	u64 ire;

What's "ire" supposed to be short for?

[snip]
> +	| label DT_MEMRESERVE expr '-' expr ';'

Oh.. you haven't actually abolished the '-' syntax, even in version 1
mode.  Since we're already making an incompatible syntax change, we
should really make this one at the same time.

[snip]
> +cell:
> +	  expr
> +		{
> +			$$ = expr_cell_value($1);
> +		}
> +	;
> +
> +expr:
> +	  expr_primary
> +	;
> +
> +expr_primary:
> +	  opt_cell_base DT_LITERAL
> +		{
> +			$$ = $2;
> +		}

Hrm.  I realise you haven't actually implemented expressions here, but
I think these names suggest a wrong direction.  I think we should only
allow literals and bracketed expressions in celldata, not bare
expressions.  Why?  Because mistaking the following:
	<0x00000000 0xf0000000 + 0x00001000 0x80000000>
as being 4 rather than 3 cells long is rather easier than mistaking:
	<0x00000000 (0xf0000000 + 0x00001000) 0x80000000>

[snip[
>  bytestring:
> -	  bytestring DT_BYTE
> +	  bytestring expr

Urg... I don't know that allowing expressions in bytestrings is not a
very good idea.  Better, I think to keep the existing syntax here, and
just think of [abcd1234deadbeef] as a rather long sort of literal
itself.

[snip]
> +void yywarn(char const *s, ...)

Ick.. we can tolerate yyblah() names for the things we inherit from
yacc, but lets not introduce our own, hey.

[snip]
> +unsigned int dts_version = 0;
> +unsigned int expr_default_base = 10;
> +
> +
> +void set_dts_version(u64 vers)
> +{
> +	if (vers > 1) {
> +		yywarn("Unknown version %lld; 0 assumed\n", vers);
> +		dts_version = 0;
> +	} else {
> +		dts_version = vers;
> +	}
> +
> +	if (dts_version == 0) {
> +		expr_default_base = 16;
> +		in_lexer_use_base = 16;
> +	} else {
> +		expr_default_base = 10;
> +		in_lexer_use_base = 10;

Uh.. I don't think we should need either of expr_default_base and
in_lexer_use_base, let alone both..

[snip]
> -		fprintf(f, "%x", be32_to_cpu(*cp++));
> +		if (dts_version == 0) {

Where does dts_version get set in the -Odts case?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
