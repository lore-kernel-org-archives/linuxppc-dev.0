Return-Path: <BATV+54e4ee8a974e2d9aaca0+2375+infradead.org+dwmw2@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4EF25B7D08
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Feb 2010 23:50:05 +1100 (EST)
Subject: Re: [PATCH 3/4] Provide VIO modalias
From: David Woodhouse <dwmw2@infradead.org>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <20100205135354.GI12001@hansolo.jdub.homelinux.org>
References: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
	<20100205135354.GI12001@hansolo.jdub.homelinux.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Feb 2010 12:50:00 +0000
Message-ID: <1266929400.30247.2585.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-02-05 at 08:53 -0500, Josh Boyer wrote:
> Provide a modalias entry for VIO devices in sysfs.  I believe
> this was another initrd generation bugfix for anaconda.
> 
> ---

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>

Not entirely sure why this didn't get upstream when I first did it;
maybe I just posted it once and then forgot about it?

> diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> index f988672..12a0851 100644
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -294,9 +294,27 @@ static ssize_t devspec_show(struct device *dev,
>  	return sprintf(buf, "%s\n", of_node ? of_node->full_name : "none");
>  }
>  
> +static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	const struct vio_dev *vio_dev = to_vio_dev(dev);
> +	struct device_node *dn;
> +	const char *cp;
> +
> +	dn = dev->archdata.of_node;
> +	if (!dn)
> +		return -ENODEV;
> +	cp = of_get_property(dn, "compatible", NULL);
> +	if (!cp)
> +		return -ENODEV;
> +
> +	return sprintf(buf, "vio:T%sS%s\n", vio_dev->type, cp);
> +}
> +
>  static struct device_attribute vio_dev_attrs[] = {
>  	__ATTR_RO(name),
>  	__ATTR_RO(devspec),
> +	__ATTR_RO(modalias),
>  	__ATTR_NULL
>  };
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
