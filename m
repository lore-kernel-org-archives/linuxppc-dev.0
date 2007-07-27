Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 275FEDDDCA
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 17:51:34 +1000 (EST)
In-Reply-To: <20070726210507.18829b9a@vitb.ru.mvista.com>
References: <20070726135655.GA5643@localhost.localdomain>
	<20070726164508.GB28491@ld0162-tx32.am.freescale.net>
	<20070726210507.18829b9a@vitb.ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E0500C84-58E2-4216-BB8F-0FCB714D9BE2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH] fsl_soc: add support for fsl_spi
Date: Fri, 27 Jul 2007 02:52:23 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 26, 2007, at 12:05 PM, Vitaly Bordug wrote:

> On Thu, 26 Jul 2007 11:45:08 -0500
> Scott Wood <scottwood@freescale.com> wrote:
>
>> On Thu, Jul 26, 2007 at 05:56:55PM +0400, Anton Vorontsov wrote:
>>> +void (*fsl_spi_activate_cs)(u8 cs, u8 polarity) = NULL;
>>> +EXPORT_SYMBOL(fsl_spi_activate_cs);
>>> +void (*fsl_spi_deactivate_cs)(u8 cs, u8 polarity) = NULL;
>>> +EXPORT_SYMBOL(fsl_spi_deactivate_cs);
>>
>> What are these for?  It looks like you're using them to set pins,
>> but that should be done in the firmware (and if the firmware  
>> sucks, then
>> do it in the platform code at bootup).
>>
> That is not exactly the point.
> I won't respond for Anton, but we already had such hooks justified  
> in SPI case iirc.

No they are used for runtime chip select handling.  The SPI  
controller is able to handle multiple devices, however the chipselect  
is not specified by SPI and thus it left to board code.

>>> +static int __init fsl_spi_of_init(void)
>>> +{
>>> +	struct device_node *np;
>>> +	unsigned int i;
>>> +
>>> +	for (np = NULL, i = 1;
>>> +	     (np = of_find_compatible_node(np, "spi", "fsl_spi")) != NULL;
>>> +	     i++) {
>>
>> s/fsl_spi/fsl,mpc8323-spi/, please.
>>
>> Why not make the fsl spi driver an of_platform device?
>>
> Because this particular thing is not ppc-only from what I recall.

The device node name already existed before this patch.

- k
