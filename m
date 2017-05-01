Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGc196fp1zDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 17:46:05 +1000 (AEST)
Subject: Re: powerpc/8xx: Adding support of IRQ in MPC8xx GPIO
To: Scott Wood <oss@buserror.net>
References: <20170309094204.ACF5567992@localhost.localdomain>
 <20170430064826.fags33gcyvpqigah@home.buserror.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <b0129071-0b09-a357-d262-19cf335f8224@c-s.fr>
Date: Mon, 1 May 2017 09:46:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170430064826.fags33gcyvpqigah@home.buserror.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 30/04/2017 à 08:48, Scott Wood a écrit :
> On Thu, Mar 09, 2017 at 10:42:04AM +0100, Christophe Leroy wrote:
>> This patch allows the use of IRQ to notify the change of GPIO status
>> on MPC8xx CPM IO ports. This then allows to associate IRQs to GPIOs
>> in the Device Tree.
>>
>> Ex:
>> 	CPM1_PIO_C: gpio-controller@960 {
>> 		#gpio-cells = <2>;
>> 		compatible = "fsl,cpm1-pario-bank-c";
>> 		reg = <0x960 0x10>;
>> 		interrupts = <1 2 6 9 10 11 14 15 23 24 26 31>;
>> 		interrupts-mask = <0x0fff>;
>> 		interrupt-parent = <&CPM_PIC>;
>> 		gpio-controller;
>> 	};
>>
>> The property 'interrupts-mask' defines which of the 16 GPIOs have
>> the associated interrupts defined in the 'interrupts' property.
>
> Binding?  Should also be named something like "fsl,cpm1-gpio-irq-mask",

Ok, done in v2

>
>>  static int cpm1_gpio16_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>>  {
>>  	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>> @@ -618,6 +633,7 @@ int cpm1_gpiochip_add16(struct device_node *np)
>>  	struct cpm1_gpio16_chip *cpm1_gc;
>>  	struct of_mm_gpio_chip *mm_gc;
>>  	struct gpio_chip *gc;
>> +	u16 mask;
>>
>>  	cpm1_gc = kzalloc(sizeof(*cpm1_gc), GFP_KERNEL);
>>  	if (!cpm1_gc)
>
>> @@ -625,6 +641,14 @@ int cpm1_gpiochip_add16(struct device_node *np)
>>
>>  	spin_lock_init(&cpm1_gc->lock);
>>
>> +	if (!of_property_read_u16(np, "interrupts-mask", &mask)) {
>> +		int i, j;
>> +
>> +		for (i = 0, j = 0; i < 16; i++)
>> +			if (mask & (1 << (15 - i)))
>> +				cpm1_gc->irq[i] = irq_of_parse_and_map(np, j++);
>> +	}
>
> Do we really need to use MSB-first bit numbering here?

Well, I think it is better to keep the GPIOs in the same order as in the 
CPM1 registers, like everywhere else in that driver, isn't it ?

The registers have GPIO 0 in the MSB and GPIO15 in the LSB.

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
