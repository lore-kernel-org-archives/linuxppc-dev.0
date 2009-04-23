Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 273C5DE111
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 03:46:04 +1000 (EST)
Message-ID: <49F0A957.5080508@harris.com>
Date: Thu, 23 Apr 2009 13:45:59 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC: 440EPx/GRx Sequoia/Rainier U-Boot incorrect
	chipselect number workaround
References: <20090423171222.GA32326@ru.mvista.com>
In-Reply-To: <20090423171222.GA32326@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine Barshak wrote:
> Some U-Boot versions incorrectly set the number of chipselects to two
> for Sequoia/Rainier boards while they only have one chipselect hardwired.
> This patch adds a workaround for this, hardcoding the number of chipselects
> to one for sequioa/rainer board models and reading the actual value from
> the memory controller register DDR0_10 otherwise.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---
>  arch/powerpc/boot/4xx.c |   52 +++++++++++++++++++++++++++++++++++++----------
>  1 files changed, 41 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
> index 5c87843..6196067 100644
> --- a/arch/powerpc/boot/4xx.c
> +++ b/arch/powerpc/boot/4xx.c
> @@ -158,21 +158,33 @@ void ibm440spe_fixup_memsize(void)
>  
>  #define DDR_GET_VAL(val, mask, shift)	(((val) >> (shift)) & (mask))
>  
> -void ibm4xx_denali_fixup_memsize(void)
> +/*
> + * Some U-Boot versions set the number of chipselects to two
> + * for Sequoia/Rainier boards while they only have one chipselect
> + * hardwired. Hardcode the number of chipselects to one 
> + * for sequioa/rainer board models or read the actual value
> + * from the memory controller register DDR0_10 otherwise.
> + */
> +static inline u32 ibm4xx_denali_get_cs(void)
>  {
> -	u32 val, max_cs, max_col, max_row;
> -	u32 cs, col, row, bank, dpath;
> -	unsigned long memsize;
> +	void *devp;
> +	char model[64];
> +	u32 val, cs;
>  
> -	val = SDRAM0_READ(DDR0_02);
> -	if (!DDR_GET_VAL(val, DDR_START, DDR_START_SHIFT))
> -		fatal("DDR controller is not initialized\n");
> +	devp = finddevice("/");
> +	if (!devp)
> +		goto read_cs;
>  
> -	/* get maximum cs col and row values */
> -	max_cs  = DDR_GET_VAL(val, DDR_MAX_CS_REG, DDR_MAX_CS_REG_SHIFT);
> -	max_col = DDR_GET_VAL(val, DDR_MAX_COL_REG, DDR_MAX_COL_REG_SHIFT);
> -	max_row = DDR_GET_VAL(val, DDR_MAX_ROW_REG, DDR_MAX_ROW_REG_SHIFT);
> +	if (getprop(devp, "model", model, sizeof(model)) <= 0)
> +		goto read_cs;
>  
> +	model[sizeof(model)-1] = 0;
> +
> +	if (!strcmp(model, "amcc,sequoia") ||
> +	    !strcmp(model, "amcc,rainier"))
> +		return 1;
> +
> +read_cs:
>  	/* get CS value */
>  	val = SDRAM0_READ(DDR0_10);
>  
> @@ -183,7 +195,25 @@ void ibm4xx_denali_fixup_memsize(void)
>  			cs++;
>  		val = val >> 1;
>  	}
> +	return cs;
> +}
> +
> +void ibm4xx_denali_fixup_memsize(void)
> +{
> +	u32 val, max_cs, max_col, max_row;
> +	u32 cs, col, row, bank, dpath;
> +	unsigned long memsize;
> +
> +	val = SDRAM0_READ(DDR0_02);
> +	if (!DDR_GET_VAL(val, DDR_START, DDR_START_SHIFT))
> +		fatal("DDR controller is not initialized\n");
> +
> +	/* get maximum cs col and row values */
> +	max_cs  = DDR_GET_VAL(val, DDR_MAX_CS_REG, DDR_MAX_CS_REG_SHIFT);
> +	max_col = DDR_GET_VAL(val, DDR_MAX_COL_REG, DDR_MAX_COL_REG_SHIFT);
> +	max_row = DDR_GET_VAL(val, DDR_MAX_ROW_REG, DDR_MAX_ROW_REG_SHIFT);
>  
> +	cs = ibm4xx_denali_get_cs();
>  	if (!cs)
>  		fatal("No memory installed\n");
>  	if (cs > max_cs)
> 

Thanks for doing this so quickly!

I applied your patch plus my patch - my custom board reports
the correct memory size.  Therefore,

Acked-by: Steven A. Falco <sfalco@harris.com>

Clearly, both your and my patches must be applied together or
"bad things will happen".

BTW, I got a whitespace warning when applying your patch:

Applying: PowerPC: 440EPx/GRx Sequoia/Rainier U-Boot incorrect chipselect number workaround
/proj/hydra/sw/sfalco/linux-2.6-denx/.git/rebase-apply/patch:17: trailing whitespace.
 * hardwired. Hardcode the number of chipselects to one
warning: 1 line adds whitespace errors.

	Steve
