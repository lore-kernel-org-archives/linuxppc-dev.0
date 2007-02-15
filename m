Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 Feb 2007 09:19:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
Message-ID: <20070215221907.GC19126@localhost.localdomain>
References: <E1HHkAL-0005Xl-2f@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1HHkAL-0005Xl-2f@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 15, 2007 at 11:13:05AM -0600, Jon Loeliger wrote:
> 
> New syntax d#, b#, o# and h# allow for an explicit prefix
> on cell values to specify their base.  Eg: <d# 123>
> 
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
[snip]
> 
> ---
> 
> Beginnings of test cases in the next patch.
> Don't stress the yylloc too much.  We'll eventually
> work to make that better and more general later.
> 
> 
>  data.c       |   21 +++++++++++++++++++++
>  dtc-lexer.l  |   21 +++++++++++++++------
>  dtc-parser.y |   16 ++++++++++++++--
>  dtc.h        |    1 +
>  4 files changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/data.c b/data.c
> index 1907a1a..c6c2350 100644
> --- a/data.c
> +++ b/data.c
> @@ -19,6 +19,7 @@
>   */
>  
>  #include "dtc.h"
> +#include "dtc-parser.tab.h"
>  
>  void fixup_free(struct fixup *f)
>  {
> @@ -224,6 +225,26 @@ struct data data_merge(struct data d1, struct data d2)
>  	return d;
>  }
>  
> +/*
> + * Convert a string representation of a numberic cell
> + * in the given base into a cell.
> + */
> +cell_t data_convert_cell(char *s, unsigned int base)

I'd prefer a different name for this - and possibly it should go in a
different file.  The data_* prefix should be for functions that
actually manipulate struct data objects.

> +{
> +	cell_t c;
> +	extern YYLTYPE yylloc;
> +
> +	c = strtoul(s, NULL, base);
> +	if (errno == EINVAL || errno == ERANGE) {
> +		fprintf(stderr,
> +			"Line %d: Invalid cell value '%s'; %d assumed\n",
> +			yylloc.first_line, s, c);
> +	}

And I'd really prefer to keep the yyblah junk confined to the parser
code.  I think it would be better to move this function into
dtc-parser.y

Otherwise looks pretty good.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
