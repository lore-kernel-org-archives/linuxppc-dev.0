Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 606AA67CE1
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 07:54:37 +1000 (EST)
In-Reply-To: <C6870308-059D-40F8-8567-7A11AFAD2AE2@kernel.crashing.org>
References: <Pine.LNX.4.61.0610161554580.6266@ld0175-tx32.am.freescale.net>
	<C6870308-059D-40F8-8567-7A11AFAD2AE2@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <87415DCF-94DA-4D33-8255-3D6E2E72C06E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Slight refactor of interrupt mapping for FSL parts
Date: Mon, 16 Oct 2006 16:54:29 -0500
To: Andy Fleming <afleming@freescale.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 16, 2006, at 4:37 PM, Kumar Gala wrote:

>
> On Oct 16, 2006, at 3:57 PM, Andy Fleming wrote:
>
>>
>> * Cleaned up interrupt mapping a little by adding a helper
>>   function which parses the irq out of the device-tree, and puts
>>   it into a resource.
>> * Changed the PHY Layer to use NO_IRQ instead of -1 for PHY_POLL.
>>   This means that polling will always be used if mapping the
>>   interrupt fails for any reason.
>
> You forgot to fixup the arch/ppc users of this.
>
>
>> ---
>>  arch/powerpc/sysdev/fsl_soc.c |   33 +++++++++++++++
>> +-----------------
>>  include/linux/phy.h           |    2 +-
>>  2 files changed, 17 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/
>> fsl_soc.c
>> index dbe92ae..aa24b51 100644
>> --- a/arch/powerpc/sysdev/fsl_soc.c
>> +++ b/arch/powerpc/sysdev/fsl_soc.c
>> @@ -146,7 +146,7 @@ static int __init gfar_mdio_of_init(void
>>  		}
>>
>>  		for (k = 0; k < 32; k++)
>> -			mdio_data.irq[k] = -1;
>> +			mdio_data.irq[k] = NO_IRQ;
>>
>>  		while ((child = of_get_next_child(np, child)) != NULL) {
>>  			int irq = irq_of_parse_and_map(child, 0);
>> @@ -177,6 +177,13 @@ static const char *gfar_tx_intr = "tx";
>>  static const char *gfar_rx_intr = "rx";
>>  static const char *gfar_err_intr = "error";
>>
>> +
>> +void of_irq_to_resource(struct device_node *dev, int index, struct
>> resource *r)
>> +{
>> +	r->start = r->end = irq_of_parse_and_map(dev, index);
>> +	r->flags = IORESOURCE_IRQ;
>> +}
>
> Why don't you stick this in prom_parse.c (and add a prototype to  
> prom.h)

Actually, just implement it in the header.

- k
