Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0E972DDED6
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 09:19:20 +1100 (EST)
Message-ID: <47E97A65.5010700@freescale.com>
Date: Tue, 25 Mar 2008 17:19:17 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: York Sun <yorksun@freescale.com>
Subject: Re: [PATCH 1/2 v3] Driver for Freescale 8610 and 5121 DIU
References: <120648043867-git-send-email-yorksun@freescale.com>
	<12064804383051-git-send-email-yorksun@freescale.com>
In-Reply-To: <12064804383051-git-send-email-yorksun@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-fbdev-devel@lists.sourceforge.net, a.p.zijlstra@chello.nl,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

York Sun wrote:
> +    Example (MPC8610HPCD)
> +	diu@2c000 {

display@2c000

> +		device_type = "lcd";

No device_type.

> +		compatible = "fsl-diu";

"fsl,diu".

> +    s) Freescale on board FPGA
> +
> +    This is the memory-mapped registers for on board FPGA.
> +
> +    Required properities:
> +    - compatible : should be "fsl,fpga-pixis".
> +    - reg : should contain the address and the lenght of the FPPGA register
> +      set.
> +
> +    Example (MPC8610HPCD)
> +	fpga {

board-control@e8000000 {

> +config FB_FSL_DIU
> +	tristate "Freescale MPC8610/MPC5121 DIU framebuffer support"

Are these the only chips that will ever implement this?

> +	depends on FB && (MPC8610 || MPC5121)

depends on FB && FSL_SOC

> +		cmfbi = machine_data->fsl_diu_info[index+1]->par;
> +		if ((mfbi->x_aoi_d + var->xres) >
> +				machine_data->fsl_diu_info[0]->var.xres)
> +			mfbi->x_aoi_d = machine_data->fsl_diu_info[0]->var.xres
> +					- var->xres;
> +		if (mfbi->x_aoi_d < 0)
> +			mfbi->x_aoi_d = 0;
> +		if ((var->xres + mfbi->x_aoi_d) >
> +				machine_data->fsl_diu_info[0]->var.xres)
> +			var->xres = machine_data->fsl_diu_info[0]->var.xres
> +					- mfbi->x_aoi_d;
> +
> +		if (cmfbi->count > 0) {		/* AOI1 is open */
> +			if ((mfbi->y_aoi_d + var->yres) > cmfbi->y_aoi_d)
> +				mfbi->y_aoi_d = cmfbi->y_aoi_d - var->yres;
> +			if (mfbi->y_aoi_d < 0)
> +				mfbi->y_aoi_d = 0;
> +			if ((var->yres + mfbi->y_aoi_d) > cmfbi->y_aoi_d)
> +				var->yres = cmfbi->y_aoi_d - mfbi->y_aoi_d;
> +		} else {				/* AOI1 is close */
> +			if ((mfbi->y_aoi_d + var->yres) >
> +					machine_data->fsl_diu_info[0]->var.yres)
> +				mfbi->y_aoi_d =
> +					machine_data->fsl_diu_info[0]->var.yres
> +					- var->yres;
> +			if (mfbi->y_aoi_d < 0)
> +				mfbi->y_aoi_d = 0;
> +			if ((var->yres + mfbi->y_aoi_d) >
> +					machine_data->fsl_diu_info[0]->var.yres)
> +				var->yres =
> +					machine_data->fsl_diu_info[0]->var.yres
> +					- mfbi->y_aoi_d;
> +		}
> +		break;
> +	case 2:			/* AOI 1 */
> +	case 4:
> +		pmfbi = machine_data->fsl_diu_info[index-1]->par;
> +		if ((mfbi->x_aoi_d + var->xres) >
> +				machine_data->fsl_diu_info[0]->var.xres)
> +			mfbi->x_aoi_d = machine_data->fsl_diu_info[0]->var.xres
> +					- var->xres;
> +		if (mfbi->x_aoi_d < 0)
> +			mfbi->x_aoi_d = 0;
> +		if ((var->xres + mfbi->x_aoi_d) >
> +				machine_data->fsl_diu_info[0]->var.xres)
> +			var->xres = machine_data->fsl_diu_info[0]->var.xres
> +					- mfbi->x_aoi_d;
> +
> +		if (pmfbi->count > 0) {		/* AOI0 is open */
> +			if ((mfbi->y_aoi_d + var->yres) >
> +					machine_data->fsl_diu_info[0]->var.yres)
> +				mfbi->y_aoi_d =
> +					machine_data->fsl_diu_info[0]->var.yres
> +					- var->yres;
> +			if (mfbi->y_aoi_d < (pmfbi->y_aoi_d +
> +				machine_data->fsl_diu_info[index-1]->var.yres))
> +				mfbi->y_aoi_d = pmfbi->y_aoi_d +
> +				  machine_data->fsl_diu_info[index-1]->var.yres;
> +			if ((var->yres + mfbi->y_aoi_d) >
> +					machine_data->fsl_diu_info[0]->var.yres)
> +				var->yres =
> +					machine_data->fsl_diu_info[0]->var.yres
> +					- mfbi->y_aoi_d;
> +		} else {				/* AOI0 is close */
> +			if ((mfbi->y_aoi_d + var->yres) >
> +				machine_data->fsl_diu_info[0]->var.yres)
> +				mfbi->y_aoi_d =
> +					machine_data->fsl_diu_info[0]->var.yres
> +					- var->yres;
> +			if (mfbi->y_aoi_d < 0)
> +				mfbi->y_aoi_d = 0;
> +			if ((var->yres + mfbi->y_aoi_d) >
> +				machine_data->fsl_diu_info[0]->var.yres)
> +				var->yres =
> +					machine_data->fsl_diu_info[0]->var.yres
> +					- mfbi->y_aoi_d;

Could you split some of this up into separate functions at lower 
indentation levels to make it more readable?

> +#define CNVT_TOHW(val, width) ((((val)<<(width))+0x7FFF-(val))>>16)
> +			red = CNVT_TOHW(red, info->var.red.length);
> +			green = CNVT_TOHW(green, info->var.green.length);
> +			blue = CNVT_TOHW(blue, info->var.blue.length);
> +			transp = CNVT_TOHW(transp, info->var.transp.length);
> +#undef CNVT_TOHW

Define a function for this.

> +	switch (cmd) {
> +	case MFB_SET_PIXFMT:
> +		if (!arg)
> +			return -EINVAL;
> +		if (copy_from_user((void *)&pix_fmt, (void *)arg,
> +				sizeof(pix_fmt)))

(void __user *)arg
No cast on &pix_fmt.

> +#if defined(CONFIG_NOT_COHERENT_CACHE)
> +		else if (status & INT_VSYNC) {
> +			int i;
> +			unsigned int *ptr;
> +			ptr  = coherence_data;
> +			for (i = 0; i < 1024*8; i++)
> +				*ptr++ = 0;

As I said in an internal review, this is not enough, and it's 
inefficient.  Read rather than write, and do so only once per cache 
line, but the size you access has to be at least 13/8 of the cache size 
for an 8-way plru cache.

-Scott
