Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 98D5F2C011C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 09:50:15 +1100 (EST)
Message-ID: <1384987801.26969.114.camel@pasglop>
Subject: Re: [PATCH v2] offb: make the screen properties endian safe
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Date: Thu, 21 Nov 2013 09:50:01 +1100
In-Reply-To: <1383212192-3622-1-git-send-email-clg@fr.ibm.com>
References: <1383185307.5117.74.camel@pasglop>
 <1383212192-3622-1-git-send-email-clg@fr.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-10-31 at 10:36 +0100, Cédric Le Goater wrote:
> The "screen" properties : depth, width, height, linebytes need
> to be converted to the host endian order when read from the device
> tree.
> 
> Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
> ---

Did you actually test that ? IE, using emulated VGA in qemu for
example ?

I'm asking because there are a few interesting nits here...

 - fbdev *generally* assume native endian framebuffer, but of course
under qemu today, the adapter will use a big endian frame buffer
aperture. You can compile in support for foreign endian but I don't know
how that actually works.

 - The setcolreg fix ... the "value" is used 2 lines above your endian
swap, is that correct ?

Cheers
Ben.


> Changes in v2:
> 
>  - replaced be32_to_cpu() by be32_to_cpup() 
>  - fixed setcolreg ops 
> 
>  drivers/video/offb.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/offb.c b/drivers/video/offb.c
> index 0c4f343..68e8415 100644
> --- a/drivers/video/offb.c
> +++ b/drivers/video/offb.c
> @@ -120,7 +120,7 @@ static int offb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
>  			mask <<= info->var.transp.offset;
>  			value |= mask;
>  		}
> -		pal[regno] = value;
> +		pal[regno] = cpu_to_be32(value);
>  		return 0;
>  	}
>  
> @@ -536,7 +536,7 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
>  	unsigned int flags, rsize, addr_prop = 0;
>  	unsigned long max_size = 0;
>  	u64 rstart, address = OF_BAD_ADDR;
> -	const u32 *pp, *addrp, *up;
> +	const __be32 *pp, *addrp, *up;
>  	u64 asize;
>  	int foreign_endian = 0;
>  
> @@ -552,25 +552,25 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
>  	if (pp == NULL)
>  		pp = of_get_property(dp, "depth", &len);
>  	if (pp && len == sizeof(u32))
> -		depth = *pp;
> +		depth = be32_to_cpup(pp);
>  
>  	pp = of_get_property(dp, "linux,bootx-width", &len);
>  	if (pp == NULL)
>  		pp = of_get_property(dp, "width", &len);
>  	if (pp && len == sizeof(u32))
> -		width = *pp;
> +		width = be32_to_cpup(pp);
>  
>  	pp = of_get_property(dp, "linux,bootx-height", &len);
>  	if (pp == NULL)
>  		pp = of_get_property(dp, "height", &len);
>  	if (pp && len == sizeof(u32))
> -		height = *pp;
> +		height = be32_to_cpup(pp);
>  
>  	pp = of_get_property(dp, "linux,bootx-linebytes", &len);
>  	if (pp == NULL)
>  		pp = of_get_property(dp, "linebytes", &len);
>  	if (pp && len == sizeof(u32) && (*pp != 0xffffffffu))
> -		pitch = *pp;
> +		pitch = be32_to_cpup(pp);
>  	else
>  		pitch = width * ((depth + 7) / 8);
>  
