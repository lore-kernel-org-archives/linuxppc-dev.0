Return-Path: <dgibson@ozlabs.org>
Date: Fri, 21 Dec 2007 11:29:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RESEND DTC PATCH 2/2] Add support for binary includes.
Message-ID: <20071221002922.GF2665@localhost.localdomain>
References: <20071220195259.GA1238@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071220195259.GA1238@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com, u-boot-users@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 20, 2007 at 01:52:59PM -0600, Scott Wood wrote:
> A property's data can be populated with a file's contents
> as follows:
> 
> node {
> 	prop = /bin-include/ "path/to/data";
> };

I'd be inclined to use /incbin/ rather than /bin-include/.  It's only
slightly less obvious, but it's then the same as the gas pseudo-op as
well as being a little briefer.

> Search paths are not yet implemented; non-absolute lookups are relative to
> the directory from which dtc was invoked.

Hrm.  I think that's a bit too bogus.  Although it's rather more work
to implement, I think we have to make relative paths relative to the
location of the dts file until search paths are implemented.

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Apologies if you get this twice, but AFAICT the original got eaten by our
> mail server.
> 
>  dtc-lexer.l  |    6 ++++++
>  dtc-parser.y |   26 ++++++++++++++++++++++++++
>  dtc.h        |    1 +
>  3 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/dtc-lexer.l b/dtc-lexer.l
> index c811b22..1f3e6d6 100644
> --- a/dtc-lexer.l
> +++ b/dtc-lexer.l
> @@ -190,6 +190,12 @@ static int dts_version; /* = 0 */
>  			return DT_PROPNODENAME;
>  		}
>  
> +"/bin-include/"	{
> +			yylloc.filenum = srcpos_filenum;
> +			yylloc.first_line = yylineno;
> +			DPRINT("Binary Include\n");
> +			return DT_BININCLUDE;
> +		}
>  
>  <*>[[:space:]]+	/* eat whitespace */
>  
> diff --git a/dtc-parser.y b/dtc-parser.y
> index 4a0181d..c7ed715 100644
> --- a/dtc-parser.y
> +++ b/dtc-parser.y
> @@ -21,6 +21,8 @@
>  %locations
>  
>  %{
> +#include <sys/stat.h>
> +
>  #include "dtc.h"
>  #include "srcpos.h"
>  
> @@ -58,6 +60,7 @@ extern struct boot_info *the_boot_info;
>  %token <data> DT_STRING
>  %token <labelref> DT_LABEL
>  %token <labelref> DT_REF
> +%token DT_BININCLUDE
>  
>  %type <data> propdata
>  %type <data> propdataprefix
> @@ -196,6 +199,29 @@ propdata:
>  		{
>  			$$ = data_add_marker($1, REF_PATH, $2);
>  		}
> +	| propdataprefix DT_BININCLUDE DT_STRING
> +		{
> +			struct stat st;
> +			FILE *f;
> +			int fd;
> +			
> +			f = fopen($3.val, "rb");
> +			if (!f) {
> +				yyerrorf("Cannot open file \"%s\": %s",
> +				         $3.val, strerror(errno));
> +				YYERROR;

Hrm.  I'm not sure that being unable to open the file should cause a
*parse* error which is what YYERROR will do.  Probably better to print
an error message, but let the parsing continue, with the property
value being as though the file were empty.

> +			}
> +
> +			fd = fileno(f);
> +			if (fstat(fd, &st) < 0) {
> +				yyerrorf("Cannot stat file \"%s\": %s",
> +				         $3.val, strerror(errno));
> +				YYERROR;
> +			}

I'm also not sure that stat()ing the file is a good way to get the
size.  This requires that the included file be a regular file with a
sane st_size value, and I can imagine cases where it might be useful
to incbin from a /dev node or other special file.  Obviosuly
implementing that will require work to data_copy_file().

Actually, I think the way to go here would be to have two variants of
the incbin directive:  one which takes just a filename and includes
the whole file contents, another which takes a filename and a number
and includes just the first N bytes of the file.

> +			$$ = data_merge($1, data_copy_file(f, st.st_size));
> +			fclose(f);
> +		}
>  	| propdata DT_LABEL
>  		{
>  			$$ = data_add_marker($1, LABEL, $2);
> diff --git a/dtc.h b/dtc.h
> index 9b89689..87b5bb1 100644
> --- a/dtc.h
> +++ b/dtc.h
> @@ -138,6 +138,7 @@ struct data data_grow_for(struct data d, int xlen);
>  struct data data_copy_mem(const char *mem, int len);
>  struct data data_copy_escape_string(const char *s, int len);
>  struct data data_copy_file(FILE *f, size_t len);
> +struct data data_bin_include(const char *filename);

This looks like a hangover from an earlier version.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
