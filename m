Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 04E372BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 19:36:44 +1100 (EST)
Date: Wed, 12 Jan 2005 00:36:37 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <galak@somerset.sps.mot.com>
Message-ID: <20050112083637.GA13794@gate.ebshome.net>
References: <Pine.LNX.4.61.0501120133080.21665@blarg.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0501120133080.21665@blarg.somerset.sps.mot.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: RFC: [PATCH] platform device driver model support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 12, 2005 at 01:43:09AM -0600, Kumar Gala wrote:
> 
> Please take a look at the following patch.  It adds driver model support 
> via platform devices to 85xx.  This is originally based on patches from 
> Jason M. 
> 
> The idea behind the code is that for a give family: 4xx, 8xx, 82xx, 83xx, 
> 85xx, 86xx we will have structure defns for the following:
> 
> enum ppc_soc_devices 
> in asm-ppc/<family.h>:
>   list of all unique devices in the family
> 
> struct platform_device soc_platform_devices[]
> in arch/ppc/platforms/<family>/<family>_devices.c:
>   describes all platform devices that exist in the family
> 
> struct soc_spec soc_specs[]
> in arch/ppc/platforms/<family>/<family>_soc.c:
>   describes each unique chip in the family and what devices it has

Well, there is a problem right here at least for 4xx. 
Current OCP implementation is much more flexible IMHO.

For 4xx is not uncommon when you have the same "logical" device at the 
different places with different "properties" (e.h. different channel, 
etc).

Your case (85xx) looks simpler - all you need is a list of devices 
which particular SoC supports, without significant differences in 
"properties". This will not work that easy for 4xx.

In fact, I don't see any gain (at least for 4xx) in all these changes. 
It makes 4xx much more tangled IMHO, because we'll still need all 
those ibm405gp.c, ibm405ep.c, ibm440gp.c etc.

Please note, using platform_device is orthogonal to the way we 
describe each SoC (this is what I don't quite like in your patch), and 
I don't have any strong objections to using platform_device instead of 
OCP or feature_call or whatever for communication with device drivers.

> Plus the following functions:
> 
> identify_soc_by_id() -- determine soc by an int id
> identify_soc_by_name() -- determin soc by name (useful in some 82xx cases)
> ppc_soc_get_pdata() -- get platform_data pointer so board code can modify
> ppc_soc_update_paddr() -- update iomem resources with a given paddr

IMHO, ppc_soc_update_paddr - is a very confusing name, in fact, from 
first read I though it _changes_ paddr to the new value, not _adds_ it 
:)

Probably this function should be made 85xx specific as I cannot come 
up with any use for it in 4xx (we don't have anything similar to 
CCSRBAR ;).


[snip]

> +
> +struct platform_device soc_platform_devices[] = {
> +	[MPC85xx_TSEC1] = {
> +		.name = "fsl-gianfar",
> +		.id	= 1,
> +		.dev.platform_data = &mpc85xx_tsec1_pdata,
> +		.num_resources	 = 4,
> +		.resource = (struct resource[]) {
> +			{
> +				.start	= MPC85xx_ENET1_OFFSET,
> +				.end	= MPC85xx_ENET1_OFFSET +
> +						MPC85xx_ENET1_SIZE - 1,
> +				.flags	= IORESOURCE_MEM,
> +			},
> +			{
> +				.name	= "tx",
> +				.start	= MPC85xx_IRQ_TSEC1_TX,
> +				.end	= MPC85xx_IRQ_TSEC1_TX,
> +				.flags	= IORESOURCE_IRQ,
> +			},
> +			{
> +				.name	= "rx",
> +				.start	= MPC85xx_IRQ_TSEC1_RX,
> +				.end	= MPC85xx_IRQ_TSEC1_RX,
> +				.flags	= IORESOURCE_IRQ,
> +			},
> +			{
> +				.name	= "error",
> +				.start	= MPC85xx_IRQ_TSEC1_ERROR,
> +				.end	= MPC85xx_IRQ_TSEC1_ERROR,
> +				.flags	= IORESOURCE_IRQ,
> +			},
[snip]


I already wrote about this but repeat again :(. 

Why put all these defines (e.g. for memory regions) into header when 
the only user is this particular file. It doesn't help readability and 
only obfuscates sources (and 4xx is a very good example of such mess 
:)


--
Eugene
