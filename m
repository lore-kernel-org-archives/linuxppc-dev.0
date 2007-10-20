Return-Path: <dgibson@ozlabs.org>
Date: Sat, 20 Oct 2007 17:19:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 3/4] DTC: Appease the printf() format $Gods with a correct
	type.
Message-ID: <20071020071920.GF26642@localhost.localdomain>
References: <E1IivsP-00078Q-Hf@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IivsP-00078Q-Hf@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 12:43:13PM -0500, Jon Loeliger wrote:
> 
> Signed-off-by: Jon Loeliger <jdl@freescale.com>

Hrm.... I'm very dubious about this.

What compiler/platform is this?  I can't off the top of my head think
of one where size_t shouldn't be promoted to int automatically.
Or there's the %z modifier, which explicitly specifies a size_t, but
I'm not sure if that's C99 or a glibc extension.


> ---
>  tests/get_name.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/tests/get_name.c b/tests/get_name.c
> index 2481741..a76bdf8 100644
> --- a/tests/get_name.c
> +++ b/tests/get_name.c
> @@ -55,7 +55,7 @@ void check_name(void *fdt, const char *path)
>  
>  	if (len != strlen(getname))
>  		FAIL("fdt_get_name(%s) returned length %d instead of %d",
> -		     path, len, strlen(getname));
> +		     path, len, (int) strlen(getname));
>  
>  	/* Now check that it doesn't break if we omit len */
>  	getname2 = fdt_get_name(fdt, offset, NULL);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
