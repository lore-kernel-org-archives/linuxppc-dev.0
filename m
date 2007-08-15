Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CBAF8DDE47
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 07:29:13 +1000 (EST)
Message-ID: <46C3701E.3090205@freescale.com>
Date: Wed, 15 Aug 2007 16:29:02 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] powerpc: fix i2c device string format
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>
	<Pine.LNX.4.60.0707032356270.3876@poirot.grange>
	<E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
	<Pine.LNX.4.60.0707180010330.3535@poirot.grange>
	<87DC7695-382B-4641-B9D9-75ACB49D41A4@kernel.crashing.org>
	<Pine.LNX.4.60.0707191932300.3365@poirot.grange>
	<719AE7E4-FE6D-4973-8887-F787EC8ABC85@kernel.crashing.org>
	<Pine.LNX.4.60.0707202219340.3946@poirot.grange>
	<235e0ff22961e25016727c0e74fd0c0f@kernel.crashing.org>
	<Pine.LNX.4.60.0708010739560.4228@poirot.grange>
	<19a13f8700d078abc4cab0064a7d0183@kernel.crashing.org>
	<Pine.LNX.4.60.0708012053240.7394@poirot.grange>
	<46B0F030.9030007@freescale.com>
	<Pine.LNX.4.60.0708080023030.8493@poirot.grange>
	<3368b27f860fafb35d10f6352e9055bf@kernel.crashing.org>
	<Pine.LNX.4.60.0708092233130.5995@poirot.grange>
	<18114.39893.913684.592560@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.60.0708152106090.10160@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0708152106090.10160@poirot.grange>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski wrote:
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
> index 727453d..c0d66df 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -320,21 +320,26 @@ static struct i2c_driver_device i2c_devices[] __initdata = {
>  	{"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
>  };
>  
> -static int __init of_find_i2c_driver(struct device_node *node, struct i2c_board_info *info)
> +static int __init of_find_i2c_driver(struct device_node *node,
> +				     struct i2c_board_info *info)
>  {
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
>  		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
>  			continue;
> -		strncpy(info->driver_name, i2c_devices[i].i2c_driver, KOBJ_NAME_LEN);
> -		strncpy(info->type, i2c_devices[i].i2c_type, I2C_NAME_SIZE);
> +		if (strlcpy(info->driver_name, i2c_devices[i].i2c_driver,
> +			    KOBJ_NAME_LEN) >= KOBJ_NAME_LEN ||
> +		    strlcpy(info->type, i2c_devices[i].i2c_type,
> +			    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
> +			return -ENOMEM;
>  		return 0;
>  	}
>  	return -ENODEV;
>  }

BTW, is there any reason this stuff is fsl_soc specific?  I'd think 
prom_parse.c (or better yet, drivers/of/ or drivers/i2c/, now that some 
OF calls have been factored out) would be a better place.

-Scott
