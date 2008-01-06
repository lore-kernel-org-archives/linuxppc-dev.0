Return-Path: <dgibson@ozlabs.org>
Date: Sun, 6 Jan 2008 14:37:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] Handle absolute pathnames correctly in dtc_open_file.
Message-ID: <20080106033716.GL4326@localhost.localdomain>
References: <20080104211045.GB28991@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080104211045.GB28991@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 04, 2008 at 03:10:45PM -0600, Scott Wood wrote:
> Also, free file->dir when freeing file.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  srcpos.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/srcpos.c b/srcpos.c
> index 7340c33..7a0c47e 100644
> --- a/srcpos.c
> +++ b/srcpos.c
> @@ -86,6 +86,16 @@ struct dtc_file *dtc_open_file(const char *fname,
>  		return file;
>  	}
>  
> +	if (fname[0] == '/') {
> +		file->file = fopen(fname, "r");
> +
> +		if (!file->file)
> +			goto out;
> +
> +		file->name = strdup(fname);
> +		return file;
> +	}
> +
>  	if (!search)
>  		search = &default_search;
>  
> @@ -100,6 +110,7 @@ struct dtc_file *dtc_open_file(const char *fname,
>  	}
>  
>  out:
> +	free((void *)file->dir);

That cast shouldn't be there.

>  	free(file);
>  	return NULL;
>  }
> @@ -109,5 +120,6 @@ void dtc_close_file(struct dtc_file *file)
>  	if (fclose(file->file))
>  		die("Error closing \"%s\": %s\n", file->name, strerror(errno));
>  
> +	free((void *)file->dir);

Or here.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
