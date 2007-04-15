Return-Path: <dgibson@ozlabs.org>
Date: Sun, 15 Apr 2007 10:44:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gvb.uboot@gmail.com>
Subject: Re: [PATCH dtc] Fix reserve map output for asm format.
Message-ID: <20070415004417.GE9104@localhost.localdomain>
References: <20070414221526.GA23870@dellserver.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070414221526.GA23870@dellserver.lan>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 14, 2007 at 06:15:27PM -0400, Jerry Van Baren wrote:
> Add extra reserve map slots output for asm format (previously done for dtb
>   output).
> Use cmalloc to pre-zero memory (for dtb input) and handle dtb (binary)
>   input being shorter than the total blob length (result of putting
>   extra space in the blob).
> 
> Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
> ---
> 
> Hi Jon:
> 
> Some simple fixes for handling extra reserve slots and extra space in
> the blob.
> 
> Best regards,
> gvb
> 
>  dtc.h      |    4 ++--
>  flattree.c |   14 +++++++++++---
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/dtc.h b/dtc.h
> index 8cfe1a1..e77f9d1 100644
> --- a/dtc.h
> +++ b/dtc.h
> @@ -55,10 +55,10 @@ static inline void die(char * str, ...)
>  
>  static inline void *xmalloc(size_t len)
>  {
> -	void *new = malloc(len);
> +	void *new = calloc(len, 1);
>  
>  	if (! new)
> -		die("malloc() failed\n");
> +		die("calloc() failed\n");
>  
>  	return new;
>  }

I'm less that thrilled about this change.  There's a semi-standard
definition of "xmalloc()" and using callc() isn't it.  I'd prefer the
clearing was done in the caller.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
