Return-Path: <htejun@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.190])
	by ozlabs.org (Postfix) with ESMTP id C3A4DDDE21
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 18:18:35 +1100 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so935487tib.13
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 00:18:33 -0700 (PDT)
Message-ID: <48F2F5EE.6060201@gmail.com>
Date: Mon, 13 Oct 2008 16:17:02 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Wang Jian <lark@linux.net.cn>
Subject: Re: [PATCH RFC] pata_platform: add 8 bit data io support
References: <20081011180014.GA4908@debian>
In-Reply-To: <20081011180014.GA4908@debian>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

Wang Jian wrote:
> +static void pata_platform_postreset(struct ata_link *link, unsigned int *classes)
> +{
> +	struct ata_port *ap = link->ap;
> +	struct ata_device *dev;
> +	u8 select = ATA_DEVICE_OBS;
> +
> +	/* Call default callback first */
> +	ata_sff_postreset(link, classes);
> +
> +	if (!(ap->flags & ATA_FLAG_8BIT_DATA))
> +		return;
> +
> +	/* Set 8-bit mode. We know we can do that */
> +	ata_link_for_each_dev(dev, link) {
> +		if (dev->devno)
> +			select |= ATA_DEV1;
> +
> +		iowrite8(SETFEATURES_8BIT_ON, ap->ioaddr.feature_addr);
> +		iowrite8(select, ap->ioaddr.device_addr);
> +		iowrite8(ATA_CMD_SET_FEATURES, ap->ioaddr.command_addr);

Aieee... Please don't do this.  I think it best belongs to
ata_dev_configure() or ->dev_config() if you wanna put it in low level
driver.

> @@ -106,7 +159,8 @@ int __devinit __pata_platform_probe(struct device *dev,
>  				    struct resource *ctl_res,
>  				    struct resource *irq_res,
>  				    unsigned int ioport_shift,
> -				    int __pio_mask)
> +				    int __pio_mask,
> +				    unsigned int data_width)
>  {
>  	struct ata_host *host;
>  	struct ata_port *ap;
> @@ -140,6 +194,9 @@ int __devinit __pata_platform_probe(struct device *dev,
>  	ap->pio_mask = __pio_mask;
>  	ap->flags |= ATA_FLAG_SLAVE_POSS;
>  
> +	if (data_width == ATA_DATA_WIDTH_8BIT)
> +		ap->flags |= ATA_FLAG_8BIT_DATA;

It's strange to define ATA_DATA_WIDTH_* constants in ata.h and only
use it in ata_platform.

Overall, I think the bulk of the 8bit PIO implementation should go
into the libata core layer and transfer width should be property of
struct ata_device - probably right above or below pio/dma_mode and
xfer_mode/shift fields.

Thanks.

-- 
tejun
