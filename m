Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 9C77F67D06
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 07:56:13 +1100 (EST)
In-Reply-To: <1162857862.28571.376.camel@localhost.localdomain>
References: <Pine.LNX.4.61.0611061711510.10818@ld0175-tx32.am.freescale.net>
	<1162857862.28571.376.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1870077E-A388-4F1A-977C-241CB718676F@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] of_irq_to_resource now returns the virq
Date: Tue, 7 Nov 2006 14:56:08 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 6, 2006, at 18:04, Benjamin Herrenschmidt wrote:

> On Mon, 2006-11-06 at 17:13 -0600, Andy Fleming wrote:
>> Mostly this is to allow for error checking (check the return for  
>> NO_IRQ)
>>
>> Signed-off-by: Andrew Fleming <afleming@freescale.com>
>> ---
>> For 2.6.20
>>
>>  include/asm-powerpc/prom.h |   13 ++++++++++---
>>  1 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
>> index 933ba27..e9226e3 100644
>> --- a/include/asm-powerpc/prom.h
>> +++ b/include/asm-powerpc/prom.h
>> @@ -334,10 +334,17 @@ extern int of_irq_map_one(struct device_
>>  struct pci_dev;
>>  extern int of_irq_map_pci(struct pci_dev *pdev, struct of_irq  
>> *out_irq);
>>
>> -static inline void of_irq_to_resource(struct device_node *dev,  
>> int index, struct resource *r)
>> +static inline int of_irq_to_resource(struct device_node *dev, int  
>> index, struct resource *r)
>>  {
>> -	r->start = r->end = irq_of_parse_and_map(dev, index);
>> -	r->flags = IORESOURCE_IRQ;
>> +	int irq = irq_of_parse_and_map(dev, index);
>> +
>> +	/* Only dereference the resource if the irq is valid. */
>> +	if (irq != NO_IRQ) {
>
> What about if (irq != NO_IRQ && r) ?

Yeah, that's a good idea.  The reason I didn't want to dereference r  
if the IRQ was invalid was originally because I wanted my gianfar  
setup code to do this:

	while (of_irq_to_resource(np, n_res, &r[++n_res]) != NO_IRQ);

That way, I didn't have to do bounds checking on the array, as long  
as I made sure that it could hold all the possible interrupts.  I  
eventually decided that was a bad idea (since I had to hard-code that  
anyway, but that of_irq_to_resource() might as well not fill in a  
resource if the IRQ is bad.  I'm about to submit the code that uses  
this function, but now it does bounds checking.

>
>> +		r->start = r->end = irq;
>> +		r->flags = IORESOURCE_IRQ;
>> +	}
>> +
>> +	return irq;
>>  }
>
> That way, if somebody doesn't care about the resource, just pass NULL,
> though I suppose we should then also change the name of the  
> function to
> something like of_map_one_irq() ..


Well, I think it would just be irq_of_parse_and_map(), then.  :)


>
> Ben.
>
