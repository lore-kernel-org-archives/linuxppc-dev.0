Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVkc42Wj8zDrpW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 14:24:03 +1000 (AEST)
Message-ID: <1473392840.30217.170.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
 ulf.hansson@linaro.org, Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org, Mark Rutland
 <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King
 <linux@arm.linux.org.uk>, Jochen Friedrich <jochen@scram.de>, Joerg Roedel
 <joro@8bytes.org>, Claudiu Manoil <claudiu.manoil@freescale.com>, Bhupesh
 Sharma <bhupesh.sharma@freescale.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 leoyang.li@nxp.com, xiaobo.xie@nxp.com
Date: Thu, 08 Sep 2016 22:47:20 -0500
In-Reply-To: <1473150503-9550-6-git-send-email-yangbo.lu@nxp.com>
References: <1473150503-9550-1-git-send-email-yangbo.lu@nxp.com>
 <1473150503-9550-6-git-send-email-yangbo.lu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [v11, 5/8] soc: fsl: add GUTS driver for QorIQ platforms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-06 at 16:28 +0800, Yangbo Lu wrote:
> The global utilities block controls power management, I/O device
> enabling, power-onreset(POR) configuration monitoring, alternate
> function selection for multiplexed signals,and clock control.
> 
> This patch adds a driver to manage and access global utilities block.
> Initially only reading SVR and registering soc device are supported.
> Other guts accesses, such as reading RCW, should eventually be moved
> into this driver as well.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Signed-off-by: Scott Wood <oss@buserror.net>

Don't put my signoff on patches that I didn't put it on myself.  Definitely
don't put mine *after* yours on patches that were last modified by you.

If you want to mention that the soc_id encoding was my suggestion, then do so
explicitly.

> +/* SoC attribute definition for QorIQ platform */
> +static const struct soc_device_attribute qoriq_soc[] = {
> +#ifdef CONFIG_PPC
> +	/*
> +	 * Power Architecture-based SoCs T Series
> +	 */
> +
> +	/* SoC: T1024/T1014/T1023/T1013 Rev: 1.0 */
> +	{ .soc_id	= "svr:0x85400010,name:T1024,die:T1024",
> +	  .revision	= "1.0",
> +	},
> +	{ .soc_id	= "svr:0x85480010,name:T1024E,die:T1024",
> +	  .revision	= "1.0",
> +	},

Revision could be computed from the low 8 bits of SVR (just as you do for unknown SVRs).

We could move the die name into .family:

	{
		.soc_id = "svr:0x85490010,name:T1023E,",
		.family = "QorIQ T1024",
	}

I see you dropped svre (and the trailing comma), though I guess the vast
majority of potential users will be looking at .family.  In which case do we
even need name?  If we just make the soc_id be "svr:0xnnnnnnnn" then we could
shrink the table to an svr+mask that identifies each die.  I'd still want to
keep the "svr:" even if we're giving up on the general tagging system, to make
it clear what the number refers to, and to provide some defense against users
who match only against soc_id rather than soc_id+family.  Or we could go
further and format soc_id as "QorIQ SVR 0xnnnnnnnn" so that soc_id-only
matches are fully acceptable rather than just less dangerous.

> +static const struct soc_device_attribute *fsl_soc_device_match(
> +	unsigned int svr, const struct soc_device_attribute *matches)
> +{
> +	char svr_match[50];
> +	int n;
> +
> +	n = sprintf(svr_match, "*%08x*", svr);

n = sprintf(svr_match, "svr:0x%08x,*", svr);

(according to the current encoding)

> +
> +	do {
> +		if (!matches->soc_id)
> +			return NULL;
> +		if (glob_match(svr_match, matches->soc_id))
> +			break;
> +	} while (matches++);

Are you expecting "matches++" to ever evaluate as false?

> +	/* Register soc device */
> +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +	if (!soc_dev_attr) {
> +		ret = -ENOMEM;
> +		goto out_unmap;
> +	}

Couldn't this be statically allocated?

> +
> +	machine = of_flat_dt_get_machine_name();
> +	if (machine)
> +		soc_dev_attr->machine = kasprintf(GFP_KERNEL, "%s",
> machine);
> +
> +	soc_dev_attr->family = kasprintf(GFP_KERNEL, "QorIQ");
> +
> +	svr = fsl_guts_get_svr();
> +	fsl_soc = fsl_soc_device_match(svr, qoriq_soc);
> +	if (fsl_soc) {
> +		soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%s",
> +						 fsl_soc->soc_id);

You can use kstrdup() if you're just copying the string as is.

> +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%s",
> +						   fsl_soc->revision);
> +	} else {
> +		soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "0x%08x",
> svr);

	kasprintf(GFP_KERNEL, "svr:0x%08x,", svr);


> +
> +	soc_dev = soc_device_register(soc_dev_attr);
> +	if (IS_ERR(soc_dev)) {
> +		ret = -ENODEV;

Why are you changing the error code?

> +		goto out;
> +	} else {

Unnecessary "else".

> +		pr_info("Detected: %s\n", soc_dev_attr->machine);

Machine: %s

> +		pr_info("Detected SoC family: %s\n", soc_dev_attr->family);
> +		pr_info("Detected SoC ID: %s, revision: %s\n",
> +			soc_dev_attr->soc_id, soc_dev_attr->revision);

s/Detected //g


> +	}
> +	return 0;
> +out:
> +	kfree(soc_dev_attr->machine);
> +	kfree(soc_dev_attr->family);
> +	kfree(soc_dev_attr->soc_id);
> +	kfree(soc_dev_attr->revision);
> +	kfree(soc_dev_attr);
> +out_unmap:
> +	iounmap(guts->regs);
> +out_free:
> +	kfree(guts);

devm

> +static int fsl_guts_remove(struct platform_device *dev)
> +{
> +	kfree(soc_dev_attr->machine);
> +	kfree(soc_dev_attr->family);
> +	kfree(soc_dev_attr->soc_id);
> +	kfree(soc_dev_attr->revision);
> +	kfree(soc_dev_attr);
> +	soc_device_unregister(soc_dev);
> +	iounmap(guts->regs);
> +	kfree(guts);
> +	return 0;
> +}

Don't free the memory before you unregister the device that uses it (moot if
you use devm).

>  
> +#ifdef CONFIG_FSL_GUTS
> +unsigned int fsl_guts_get_svr(void);
> +#endif

Don't ifdef prototypes (unless you're going to provide a stub alternative).

-Scott
