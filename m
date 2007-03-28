Return-Path: <dgibson@ozlabs.org>
Date: Wed, 28 Mar 2007 16:21:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] DTC: Add support for a C-like #include "file" mechanism.
Message-ID: <20070328062159.GJ27401@localhost.localdomain>
References: <1174681120.32390.82.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1174681120.32390.82.camel@ld0161-tx32>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 23, 2007 at 03:18:41PM -0500, Jon Loeliger wrote:
> 
> Keeps track of open files in a stack, and assigns
> a filenum to source positions for each lexical token.
> Modified error reporting to show source file as well.
> No policy on file directory basis has been decided.
> Still handles stdin.

I have some issues with the details of this approach.

[snip]
> @@ -49,7 +51,27 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>  
>  %%
>  
> +#[ \t]*include		BEGIN(INCLUDE);

I don't think using this CPP like syntax is a good idea, for several
reasons.  Firstly, if people see '#include' in the file, they're
likely to assume that the file is actually processed by CPP and so
#define and other CPP directives will work.  Second, the circumstances
under which this token will be recognized, and what's valid after it
aren't *quite* the same as CPP which is also potentially confusing.
Thirdly, '#include' is technically a valid property name, they can be
disambiguated lexically in various ways, but they're all pretty ugly.

If we need new keywords in the dts, which need to be lexically
distinct from property and node names, I suggest we do what I did for
memreserve and use /s (so '/include/' in this case).  Because of its
use in paths, / is one of the few characters we can be pretty
confident won't appear in node or property names.

However, in any case.  It's not clear to me that an include facility
built into dtc itself it particularly useful without some sort of
reasonable macro system as well, which would be substantially more
complex to implement.

So, instead of doing this in dtc itself, I really suggest we instead
use m4 to preprocess dts files, which gives us both include and macro
facilities.  If that turns out to be inadequate or too inconvenient
for people's needs, then we can revisit putting these facilities into
dtc itself - and out experience with using m4 is likely to give us a
much better understanding of how the built-in system need to work.

> +<INCLUDE>[ \t]*		/* whitespace before file name */

You don't need this rule - the lex rule which ignores whitespace is
recognized in all starting conditions, including <INCLUDE>.

> +<INCLUDE>\"[^"\n]*\"	{
> +			yytext[strlen(yytext) - 1] = 0;
> +			if (!push_input_file(yytext + 1)) {
> +				/* Some unrecoverable error.*/

Should be some kind of error message here.

[snip]
> diff --git a/srcposstack.h b/srcposstack.h
> new file mode 100644
> index 0000000..b4a459b
> --- /dev/null
> +++ b/srcposstack.h
> @@ -0,0 +1,138 @@
> +/*
> + * Copyright 2007 Jon Loeliger, Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *                                                                       
> + *  You should have received a copy of the GNU General Public License    
> + *  along with this program; if not, write to the Free Software          
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
> + *                                                                   USA 
> + */
> +
> +#include "srcpos.h"
> +
> +
> +/*
> + * This code should only be included into the lexical analysis.
> + * It references global context symbols that are only present
> + * in the generated lex.yy,c file.
> + */
> +
> +#ifdef FLEX_SCANNER
> +
> +
> +/*
> + * Stack of nested include file contexts.
> + */
> +
> +struct incl_file {
> +	int filenum;
> +	FILE *file;
> +	YY_BUFFER_STATE yy_prev_buf;
> +	int yy_prev_lineno;
> +	struct incl_file *prev;
> +};
> +
> +struct incl_file *incl_file_stack;
> +
> +
> +/*
> + * Detect infinite include recursion.
> + */
> +#define MAX_INCLUDE_DEPTH	(100)
> +
> +static int incl_depth = 0;
> +
> +
> +
> +int push_input_file(const char *filename)

Functions of this sort of size shouldn't go in a .h (particularly when
not marked static).  Either put then in srcpos.c, or directly into
dtc-lexer.l in the (currently empty) third section.

[snip]
> diff --git a/treesource.c b/treesource.c
> index e9bbaa5..c067b20 100644
> --- a/treesource.c
> +++ b/treesource.c
> @@ -19,6 +19,7 @@
>   */
>  
>  #include "dtc.h"
> +#include "srcpos.h"
>  
>  extern FILE *yyin;
>  extern int yyparse(void);
> @@ -26,11 +27,12 @@ extern void yyerror(char const *);
>  
>  struct boot_info *the_boot_info;
>  
> -struct boot_info *dt_from_source(FILE *f)
> +struct boot_info *dt_from_source(const char *fname)
>  {
>  	the_boot_info = NULL;
>  
> -	yyin = f;
> +	push_input_file(fname);
> +
>  	if (yyparse() != 0)
>  		return NULL;

It's not at all clear to me how these changes still handle input from
stdin.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
