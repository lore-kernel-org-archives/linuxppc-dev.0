Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BB5FB67D77
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 11:10:09 +1000 (EST)
Subject: Re: [PATCH] uninorth: Add module param 'aperture' for aperture size
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
In-Reply-To: <1159966604.23084.236.camel@thor.lorrainebruecke.local>
References: <1159966604.23084.236.camel@thor.lorrainebruecke.local>
Content-Type: text/plain; charset=utf-8
Date: Thu, 05 Oct 2006 11:09:42 +1000
Message-Id: <1160010582.5887.57.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Dave Jones <davej@codemonkey.org.uk>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-10-04 at 14:56 +0200, Michel Dänzer wrote:
> In contrast to most if not all PC BIOSes, OpenFirmware (OF) on PowerMacs with
> UniNorth bridges does not allow changing the aperture size. The size set up by
> OF is usually 16 MB, which is too low for graphics intensive environments.
> Hence, add a module parameter that allows changing the aperture size at driver
> initialization time. When the parameter is not specified, the default is 32 MB.
> 
> Signed-off-by: Michel Dänzer <michel@tungstengraphics.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

(it should probably go in 2.6.19, patch has been around for some time)

> ---
> 
> Reversed a 'value == variable' test, as suggested by Andreas Schwab (thanks!).
> 
>  drivers/char/agp/uninorth-agp.c |   54 +++++++++++++++++++++++++--------------
>  1 files changed, 35 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
> index 78c8cb2..c2b6f7d 100644
> --- a/drivers/char/agp/uninorth-agp.c
> +++ b/drivers/char/agp/uninorth-agp.c
> @@ -27,32 +27,42 @@ #include "agp.h"
>  static int uninorth_rev;
>  static int is_u3;
>  
> +static char __devinitdata *aperture = NULL;
>  
>  static int uninorth_fetch_size(void)
>  {
> -	int i;
> -	u32 temp;
> -	struct aper_size_info_32 *values;
> -
> -	pci_read_config_dword(agp_bridge->dev, UNI_N_CFG_GART_BASE, &temp);
> -	temp &= ~(0xfffff000);
> -	values = A_SIZE_32(agp_bridge->driver->aperture_sizes);
> -
> -	for (i = 0; i < agp_bridge->driver->num_aperture_sizes; i++) {
> -		if (temp == values[i].size_value) {
> -			agp_bridge->previous_size =
> -			    agp_bridge->current_size = (void *) (values + i);
> -			agp_bridge->aperture_size_idx = i;
> -			return values[i].size;
> +	int i, size = 0;
> +	struct aper_size_info_32 *values =
> +	    A_SIZE_32(agp_bridge->driver->aperture_sizes);
> +
> +	if (aperture) {
> +		char *save = aperture;
> +
> +		size = memparse(aperture, &aperture) >> 20;
> +		aperture = save;
> +
> +		for (i = 0; i < agp_bridge->driver->num_aperture_sizes; i++)
> +			if (size == values[i].size)
> +				break;
> +
> +		if (i == agp_bridge->driver->num_aperture_sizes) {
> +			printk(KERN_ERR PFX "Invalid aperture size, using"
> +			       " default\n");
> +			size = 0;
> +			aperture = NULL;
>  		}
>  	}
>  
> -	agp_bridge->previous_size =
> -	    agp_bridge->current_size = (void *) (values + 1);
> -	agp_bridge->aperture_size_idx = 1;
> -	return values[1].size;
> +	if (!size) {
> +		for (i = 0; i < agp_bridge->driver->num_aperture_sizes; i++)
> +			if (values[i].size == 32)
> +				break;
> +	}
>  
> -	return 0;
> +	agp_bridge->previous_size =
> +	    agp_bridge->current_size = (void *)(values + i);
> +	agp_bridge->aperture_size_idx = i;
> +	return values[i].size;
>  }
>  
>  static void uninorth_tlbflush(struct agp_memory *mem)
> @@ -668,5 +678,11 @@ static void __exit agp_uninorth_cleanup(
>  module_init(agp_uninorth_init);
>  module_exit(agp_uninorth_cleanup);
>  
> +module_param(aperture, charp, 0);
> +MODULE_PARM_DESC(aperture,
> +		 "Aperture size, must be power of two between 4MB and an\n"
> +		 "\t\tupper limit specific to the UniNorth revision.\n"
> +		 "\t\tDefault: 32M");
> +
>  MODULE_AUTHOR("Ben Herrenschmidt & Paul Mackerras");
>  MODULE_LICENSE("GPL");
> -- 
> 1.4.2.1
> 
> 
> -- 
> Earthling Michel Dänzer           |          http://tungstengraphics.com
> Libre software enthusiast         |          Debian, X and DRI developer
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
