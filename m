Return-Path: <lark@linux.net.cn>
Received: from mx.linux.net.cn (unknown [210.82.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0F6DBDDEE7
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 19:04:29 +1100 (EST)
Message-ID: <48F30108.2040409@linux.net.cn>
Date: Mon, 13 Oct 2008 16:04:24 +0800
From: Wang Jian <lark@linux.net.cn>
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH RFC] pata_platform: add 8 bit data io support
References: <20081011180014.GA4908@debian> <48F2F5EE.6060201@gmail.com>
In-Reply-To: <48F2F5EE.6060201@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tejun Heo wrote:
> Hello,
> 
> Wang Jian wrote:
>> +static void pata_platform_postreset(struct ata_link *link, unsigned int *classes)
>> +{
>> +	struct ata_port *ap = link->ap;
>> +	struct ata_device *dev;
>> +	u8 select = ATA_DEVICE_OBS;
>> +
>> +	/* Call default callback first */
>> +	ata_sff_postreset(link, classes);
>> +
>> +	if (!(ap->flags & ATA_FLAG_8BIT_DATA))
>> +		return;
>> +
>> +	/* Set 8-bit mode. We know we can do that */
>> +	ata_link_for_each_dev(dev, link) {
>> +		if (dev->devno)
>> +			select |= ATA_DEV1;
>> +
>> +		iowrite8(SETFEATURES_8BIT_ON, ap->ioaddr.feature_addr);
>> +		iowrite8(select, ap->ioaddr.device_addr);
>> +		iowrite8(ATA_CMD_SET_FEATURES, ap->ioaddr.command_addr);
> 
> Aieee... Please don't do this.  I think it best belongs to
> ata_dev_configure() or ->dev_config() if you wanna put it in low level
> driver.
> 

Good.

I remember the spec states that this setfeature command should be issued
every time reset is issued. This is just a quick and safe hack.

I will look into libata deeper and figure out how to do it better per your
suggestion.

>> @@ -106,7 +159,8 @@ int __devinit __pata_platform_probe(struct device *dev,
>>  				    struct resource *ctl_res,
>>  				    struct resource *irq_res,
>>  				    unsigned int ioport_shift,
>> -				    int __pio_mask)
>> +				    int __pio_mask,
>> +				    unsigned int data_width)
>>  {
>>  	struct ata_host *host;
>>  	struct ata_port *ap;
>> @@ -140,6 +194,9 @@ int __devinit __pata_platform_probe(struct device *dev,
>>  	ap->pio_mask = __pio_mask;
>>  	ap->flags |= ATA_FLAG_SLAVE_POSS;
>>  
>> +	if (data_width == ATA_DATA_WIDTH_8BIT)
>> +		ap->flags |= ATA_FLAG_8BIT_DATA;
> 
> It's strange to define ATA_DATA_WIDTH_* constants in ata.h and only
> use it in ata_platform.

I have expressed in another reply that the best place the code belongs to
should be decided first. The usage of flags looks ugly too :)

> 
> Overall, I think the bulk of the 8bit PIO implementation should go
> into the libata core layer and transfer width should be property of
> struct ata_device - probably right above or below pio/dma_mode and
> xfer_mode/shift fields.
> 

Yes, I agree it'd better go into libata core layer. But for transfer
width, I think it is not belongs to ata_device. It's about how ata
controller wired for data line. (In my case, it is how CF card wired).
Am I wrong?


Best regards
