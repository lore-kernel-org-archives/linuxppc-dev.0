Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 74410DE454
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 04:31:13 +1100 (EST)
Message-ID: <47ED2B35.4030601@freescale.com>
Date: Fri, 28 Mar 2008 12:30:29 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: York Sun <yorksun@freescale.com>
Subject: Re: [PATCH 1/2 v4] Driver for Freescale 8610 and 5121 DIU
References: <12066720572512-git-send-email-yorksun@freescale.com>
	<12066720572314-git-send-email-yorksun@freescale.com>
In-Reply-To: <12066720572314-git-send-email-yorksun@freescale.com>
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
> +static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
> +		       unsigned long arg)
> +{
> +	struct mfb_info *mfbi = info->par;
> +	struct diu_ad *ad = mfbi->ad;
> +	struct mfb_chroma_key ck;
> +	unsigned char global_alpha;
> +	struct aoi_display_offset aoi_d;
> +	__u32 pix_fmt;
> +
> +	switch (cmd) {
> +	case MFB_SET_PIXFMT:
> +		if (!arg)
> +			return -EINVAL;
> +		if (copy_from_user(&pix_fmt, (void __user *)arg,
> +				sizeof(pix_fmt)))

OK, you fixed the cast here...

> +			return -EFAULT;
> +		ad->pix_fmt = pix_fmt;
> +		pr_debug("Set pixel format to 0x%08x\n", ad->pix_fmt);
> +		break;
> +	case MFB_GET_PIXFMT:
> +		if (!arg)
> +			return -EINVAL;
> +		pix_fmt = ad->pix_fmt;
> +		if (copy_to_user((void *)arg, &pix_fmt, sizeof(pix_fmt)))
> +			return -EFAULT;
> +		pr_debug("get pixel format 0x%08x\n", ad->pix_fmt);
> +		break;
> +	case MFB_SET_AOID:
> +		if (!arg)
> +			return -EINVAL;
> +		if (copy_from_user(&aoi_d, (void *)arg, sizeof(aoi_d)))
> +			return -EFAULT;

...but not anywhere else.  All user pointers should have a __user 
annotation.

> +	default:
> +		printk(KERN_ERR "Unknown ioctl command (0x%08X)\n", cmd);
> +		return 0;

return -ENOIOCTLCMD;

> +	/* Read to clear the status */
> +	status = in_be32(&(hw->int_status));
> +
> +	ret = request_irq(irq, fsl_diu_isr, 0, "diu", 0);
> +	if (ret)
> +		pr_info("Request diu IRQ failed.\n");
> +	else {
> +		ints = INT_PARERR | INT_LS_BF_VS;
> +#if !defined(CONFIG_NOT_COHERENT_CACHE)
> +		ints |=	INT_VSYNC;
> +#endif
> +		if (dr.mode == MFB_MODE2 || dr.mode == MFB_MODE3)
> +			ints |= INT_VSYNC_WB;
> +
> +		/* Read to clear the status */
> +		status = in_be32(&(hw->int_status));
> +		out_be32(&(hw->int_mask), ints);

These parentheses are unnecessary; just do &hw->int_mask, etc.

-Scott
