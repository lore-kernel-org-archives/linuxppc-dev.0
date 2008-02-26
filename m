Return-Path: <dgibson@ozlabs.org>
Date: Tue, 26 Feb 2008 11:39:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Add support for binary includes.
Message-ID: <20080226003955.GA24382@localhost.localdomain>
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 20, 2008 at 01:19:41PM -0600, Scott Wood wrote:
> A property's data can be populated with a file's contents
> as follows:
> 
> node {
> 	prop = /incbin/("path/to/data");
> };
> 
> A subset of a file can be included by passing start and size parameters.
> For example, to include bytes 8 through 23:
> 
> node {
> 	prop = /incbin/("path/to/data", 8, 16);
> };
> 
> As with /include/, non-absolute paths are looked for in the directory
> of the source file that includes them.

Well, while I discuss the syntax with Jon, here's some comments on the
implementation.


> diff --git a/Makefile b/Makefile
> index 8a47c34..d4d935c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -16,7 +16,7 @@ LOCAL_VERSION =
>  CONFIG_LOCALVERSION =
>  
>  CPPFLAGS = -I libfdt
> -CFLAGS = -Wall -g -Os
> +CFLAGS = -Wall -g -Os -D_FILE_OFFSET_BITS=64

Is this portable?

>  
>  BISON = bison
>  LEX = flex
> diff --git a/data.c b/data.c
> index a94718c..f9464bf 100644
> --- a/data.c
> +++ b/data.c
> @@ -19,6 +19,7 @@
>   */
>  
>  #include "dtc.h"
> +#include "srcpos.h"
>  
>  void data_free(struct data d)
>  {
> @@ -189,7 +190,41 @@ struct data data_copy_file(FILE *f, size_t len)
>  	d = data_grow_for(empty_data, len);
>  
>  	d.len = len;
> -	fread(d.val, len, 1, f);
> +	if (fread(d.val, len, 1, f) != 1) {
> +		yyerrorf("Couldn't read %zu bytes from file: %s",
> +		         len, feof(f) ? "end-of-file" : strerror(errno));
> +		return empty_data;

Ugh.
	1) Error messages direct to the user really don't belong in
data.c's low-level support routines.  This does mean we might need to
substantially change this function so there's some other way of
reporting the error to the caller who can report it.
	2) The horrid name 'yyerror()' exists only to match what bison
expects.  It should never be used outside the parse code (we probably
should create more generally usable error/warning functions, though).
	3) Is %zu portable?

> +	}
> +
> +	return d;
> +}
> +
> +struct data data_copy_file_all(FILE *f)

It should be possible to combine these two functions.

> +{
> +	char buf[4096];
> +	struct data d = empty_data;
> +
> +	while (1) {
> +		size_t ret = fread(buf, 1, sizeof(buf), f);
> +		if (ret == 0) {
> +			if (!feof(f))
> +				yyerrorf("Error reading file: %s", strerror(errno));
> +
> +			break;
> +		}
> +
> +		assert(ret <= sizeof(buf));
> +
> +		d = data_grow_for(d, ret);
> +		memcpy(d.val + d.len, buf, ret);
> +
> +		if (d.len + ret < d.len) {
> +			yyerror("Binary include too large");

Hrm.  A test which will cover this case should go into
data_grow_for(), I think.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
