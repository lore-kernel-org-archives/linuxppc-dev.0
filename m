Return-Path: <adrian@rhlx01.hs-esslingen.de>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rhlx01.hs-esslingen.de", Issuer "HE CA - G02" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1EFE6DDF2A
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 23:31:35 +1100 (EST)
Date: Tue, 24 Mar 2009 13:31:31 +0100
From: Adrian Reber <adrian@lisas.de>
To: Mark Nelson <markn@au1.ibm.com>
Subject: Re: [PATCH] powerpc/wdrtas: Update wdrtas_get_interval to use
	rtas_data_buf
Message-ID: <20090324123131.GC24724@lisas.de>
References: <200903241730.41711.markn@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200903241730.41711.markn@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Utz Bacher <utz.bacher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 24, 2009 at 05:30:41PM +1100, Mark Nelson wrote:
> The buffer passed to the ibm,get-system-parameter RTAS call must be
> in the RMA. To ensure we pass an address in the RMA use rtas_data_buf
> for the actual RTAS call and then copy the result to value. We can't
> just make it static because this can be compiled in as a module.
> 
> Also add the WDRTAS_SP_SPI_LEN so we don't litter '4' throughout the
> function.
> 
> Signed-off-by: Mark Nelson <markn@au1.ibm.com>
> ---
> 
> Adrian, does this patch cause any problems for your pxcabs?

No, it even helps. I have no tried the watchdog until now, but without the
patch I get: 

   wdrtas: could not get sp_spi watchdog timeout (0). Continuing

and with the patch it reads the correct value. So only with your patch
it works like it is supposed to. Thanks!

Tested-by: Adrian Reber <adrian@lisas.de>

> Thanks!
> Mark
> 
>  drivers/watchdog/wdrtas.c |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> Index: upstream/drivers/watchdog/wdrtas.c
> ===================================================================
> --- upstream.orig/drivers/watchdog/wdrtas.c
> +++ upstream/drivers/watchdog/wdrtas.c
> @@ -106,6 +106,8 @@ static int wdrtas_set_interval(int inter
>  	return result;
>  }
>  
> +#define WDRTAS_SP_SPI_LEN 4
> +
>  /**
>   * wdrtas_get_interval - returns the current watchdog interval
>   * @fallback_value: value (in seconds) to use, if the RTAS call fails
> @@ -119,10 +121,17 @@ static int wdrtas_set_interval(int inter
>  static int wdrtas_get_interval(int fallback_value)
>  {
>  	long result;
> -	char value[4];
> +	char value[WDRTAS_SP_SPI_LEN];
>  
> +	spin_lock(&rtas_data_buf_lock);
> +	memset(rtas_data_buf, 0, WDRTAS_SP_SPI_LEN);
>  	result = rtas_call(wdrtas_token_get_sp, 3, 1, NULL,
> -			   WDRTAS_SP_SPI, (void *)__pa(&value), 4);
> +			   WDRTAS_SP_SPI, __pa(rtas_data_buf),
> +			   WDRTAS_SP_SPI_LEN);
> +
> +	memcpy(value, rtas_data_buf, WDRTAS_SP_SPI_LEN);
> +	spin_unlock(&rtas_data_buf_lock);
> +
>  	if (value[0] != 0 || value[1] != 2 || value[3] != 0 || result < 0) {
>  		printk(KERN_WARNING "wdrtas: could not get sp_spi watchdog "
>  		       "timeout (%li). Continuing\n", result);

		Adrian

-- 
Adrian Reber <adrian@lisas.de>            http://lisas.de/~adrian/
There's coffee in that nebula!
		-- Capt. Kathryn Janeway, Star Trek: Voyager, "The Cloud"
