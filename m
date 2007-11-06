Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Nov 2007 10:11:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] DTC: Polish up the DTS Version 1 implementation.
Message-ID: <20071106231120.GG31367@localhost.localdomain>
References: <E1IpWlT-0007Qd-IX@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IpWlT-0007Qd-IX@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 06, 2007 at 04:19:19PM -0600, Jon Loeliger wrote:
> From: Jon Loeliger <jdl@freescale.com>
> 
> Fixes BYTESTRING lexing.
> Allows -O dts output to be emitted in a given (1) format version.

Ok... I'd actually be more inclined to remove the option and just have
-Odts *always* use the newer version.

Having dtc be able to convert dts versions forward is easy and
useful.  Coverting backwards is far more complicated, because as well
as the actualy incompatible version changes, there's the question of
which dtc version supported which dts features.  Not worth it, I
think.

> Skirts around a range check problem in eval_literal() for now.
> 
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---
> 
> David,
> 
> This patch is directly on top of your prior two patches.
> Lemme know what you think.

On top of my two dts-v1 patches that is, I assume?

> diff --git a/dtc-lexer.l b/dtc-lexer.l
> index 1c262d2..b18c0d1 100644
> --- a/dtc-lexer.l
> +++ b/dtc-lexer.l
> @@ -190,6 +190,10 @@ static int dts_version; /* = 0 */
>  <*>.		{
>  			yylloc.filenum = srcpos_filenum;
>  			yylloc.first_line = yylineno;
> +			if (yytext[0] == '[') {
> +				DPRINT("BYTESTRING\n");
> +				BEGIN(BYTESTRING);
> +			}

Ow... that's rather embarrassing, that I didn't even notice I'd
totally broken bytestrings.  Really must add some bytestrings to
test_tree1.dts so this actually gets checked by the testsuite.

>  			if ((yytext[0] == '{')
>  			    || (yytext[0] == ';')) {
>  				DPRINT("<PROPNODENAME>\n");
> diff --git a/dtc-parser.y b/dtc-parser.y
> index ffb2299..652199f 100644
> --- a/dtc-parser.y
> +++ b/dtc-parser.y
> @@ -297,17 +297,23 @@ label:
>  
>  %%
>  
> -void yyerror (char const *s)
> +void yyerror(char const *s)
>  {
>  	const char *fname = srcpos_filename_for_num(yylloc.filenum);
>  
>  	if (strcmp(fname, "-") == 0)
>  		fname = "stdin";
>  
> -	fprintf(stderr, "%s:%d %s\n",
> +	fprintf(stderr, "%s:%d Error: %s\n",
>  		fname, yylloc.first_line, s);

Not really related changes, but whatever..

>  }
>  
> +/*
> + * bits is unused, but it should be 32 or 64 as needed.
> + *
> + * FIXME: However, with bits == 64, ((1ULL << bits) - 1)
> + * overflows before you can actually do the range test.
> + */
>  unsigned long long eval_literal(const char *s, int base, int bits)
>  {
>  	unsigned long long val;
> @@ -317,9 +323,10 @@ unsigned long long eval_literal(const char *s, int base, int bits)
>  	val = strtoull(s, &e, base);
>  	if (*e)
>  		yyerror("bad characters in literal");
> -	else if ((errno == ERANGE) || (val > ((1ULL << bits)-1)))
> +	else if (errno == ERANGE)
>  		yyerror("literal out of range");
>  	else if (errno != 0)
>  		yyerror("bad literal");
> +

Ok.. I don't understand why you've pulled out the range checking
against bits here.

>  	return val;
>  }
> diff --git a/dtc.c b/dtc.c
> index bbef829..38313f5 100644
> --- a/dtc.c
> +++ b/dtc.c
> @@ -225,7 +225,7 @@ int main(int argc, char *argv[])
>  	}
>  
>  	if (streq(outform, "dts")) {
> -		dt_to_source(outf, bi);
> +		dt_to_source(outf, bi, 1);
>  	} else if (streq(outform, "dtb")) {
>  		dt_to_blob(outf, bi, outversion, boot_cpuid_phys);
>  	} else if (streq(outform, "asm")) {
> diff --git a/dtc.h b/dtc.h
> index d080153..ba2027b 100644
> --- a/dtc.h
> +++ b/dtc.h
> @@ -238,7 +238,7 @@ struct boot_info *dt_from_blob(FILE *f);
>  
>  /* Tree source */
>  
> -void dt_to_source(FILE *f, struct boot_info *bi);
> +void dt_to_source(FILE *f, struct boot_info *bi, int dts_version);
>  struct boot_info *dt_from_source(const char *f);
>  
>  /* FS trees */
> diff --git a/treesource.c b/treesource.c
> index 376ebc8..ac0c777 100644
> --- a/treesource.c
> +++ b/treesource.c
> @@ -140,14 +140,18 @@ static void write_propval_string(FILE *f, struct data val)
>  	fprintf(f, "\";\n");
>  }
>  
> -static void write_propval_cells(FILE *f, struct data val)
> +static void write_propval_cells(FILE *f, struct data val, int dts_version)
>  {
>  	void *propend = val.val + val.len;
>  	cell_t *cp = (cell_t *)val.val;
>  
>  	fprintf(f, " = <");
>  	for (;;) {
> -		fprintf(f, "%x", be32_to_cpu(*cp++));
> +		if (dts_version == 0) {
> +			fprintf(f, "%x", be32_to_cpu(*cp++));
> +		} else {
> +			fprintf(f, "0x%x", be32_to_cpu(*cp++));
> +		}
>  		if ((void *)cp >= propend)
>  			break;
>  		fprintf(f, " ");
> @@ -155,14 +159,18 @@ static void write_propval_cells(FILE *f, struct data val)
>  	fprintf(f, ">;\n");
>  }
>  
> -static void write_propval_bytes(FILE *f, struct data val)
> +static void write_propval_bytes(FILE *f, struct data val, int dts_version)
>  {
>  	void *propend = val.val + val.len;
>  	char *bp = val.val;
>  
>  	fprintf(f, " = [");
>  	for (;;) {
> -		fprintf(f, "%02hhx", *bp++);
> +		if (dts_version == 0) {
> +			fprintf(f, "%02hhx", *bp++);
> +		} else {
> +			fprintf(f, "0x%02hhx", *bp++);
> +		}

Uh.. not quite right.  My patch (intentionally) leaves bytestrings as
pure hex, without 0x.  We can argue about whether that's a good idea,
if you like, but in any case input and output should match.

To avoid this sort of problem, I suggest before we apply the dts-v1
transition, we apply the patch I'm working on (I'll try to get it out
today), which adds a bunch of extra testcases checking that using dtc
to go dtb->dts->dtb preserves everything.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
