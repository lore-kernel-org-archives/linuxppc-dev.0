Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B21CF2C0093
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2013 13:12:44 +1100 (EST)
Message-ID: <1357611149.16285.54.camel@pasglop>
Subject: Re: [PATCH] lsprop: Fixes to work correctly when built little endian
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 08 Jan 2013 13:12:29 +1100
In-Reply-To: <1357532610-19416-1-git-send-email-michael@ellerman.id.au>
References: <1357532610-19416-1-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: nfont@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-01-07 at 15:23 +1100, Michael Ellerman wrote:
> Add and use dt_swap_int() to byte swap on little endian.
> 
> Also declare buf as unsigned char, so that we don't sign extend when
> printing values from it.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> 
> Ben, based on your patch, can you add your s-o-b? :
>   https://lists.ozlabs.org/pipermail/linuxppc-dev/2008-May/056088.html

I didn't know powerpc-utils required sob's :-)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  src/lsprop.c |   17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/src/lsprop.c b/src/lsprop.c
> index 5969a97..38a8fa5 100644
> --- a/src/lsprop.c
> +++ b/src/lsprop.c
> @@ -13,11 +13,22 @@
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <dirent.h>
> +#include <endian.h>
> +#include <byteswap.h>
> +
> +static inline unsigned int dt_swap_int(unsigned int data)
> +{
> +#if __BYTE_ORDER == __LITTLE_ENDIAN
> +	return bswap_32(data);
> +#else
> +	return data;
> +#endif
> +}
>  
>  int recurse;
>  int maxbytes = 128;
>  int words_per_line = 0;
> -char *buf;
> +unsigned char *buf;
>  
>  void lsprop(FILE *f, char *name);
>  void lsdir(char *name);
> @@ -183,7 +194,7 @@ void lsprop(FILE *f, char *name)
>      } else if ((n & 3) == 0) {
>  	nw = n >> 2;
>  	if (nw == 1) {
> -	    i = *(int *)buf;
> +	    i = dt_swap_int(*(int *)buf);
>  	    printf(" %.8x", i);
>  	    if (i > -0x10000 && !(i >= 0 && i <= 9))
>  		printf(" (%d)", i);
> @@ -201,7 +212,7 @@ void lsprop(FILE *f, char *name)
>  		if (i != 0)
>  		    printf("\n\t\t");
>  		for (j = 0; j < npl && i + j < nw; ++j)
> -		    printf(" %.8x", ((unsigned int *)buf)[i+j]);
> +		    printf(" %.8x", dt_swap_int(((unsigned int *)buf)[i+j]));
>  	    }
>  	}
>      } else {
