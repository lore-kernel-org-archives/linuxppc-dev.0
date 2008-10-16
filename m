Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2DBCADE1A1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Oct 2008 20:22:56 +1100 (EST)
Message-ID: <48F707C9.6040203@embedded-sol.com>
Date: Thu, 16 Oct 2008 11:22:17 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: External interrupt on 460EX
References: <48F60192.6050803@embedded-sol.com>
	<200810151700.30741.sr@denx.de>	<48F609D2.5000301@embedded-sol.com>
	<200810160944.54428.sr@denx.de>
In-Reply-To: <200810160944.54428.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Stefan

Stefan Roese wrote:
> Felix,
>
> On Wednesday 15 October 2008, Felix Radensky wrote:
>   
>>>> The interrupt is connected to GPIO 45. U-Boot (1.3.4) configures this
>>>> pin as external interrupt 12 (interrupt 20 in UIC 3). I've added the
>>>> following
>>>> entry to board device tree (in opb section)
>>>>
>>>> cpld@2,0 {
>>>>     device_type = "cpld";
>>>>     interrupts = <20 1>;
>>>>         
>>> Is this interrupt active on rising edge? This is what you have configured
>>> here. When you need level, active low, then you need to write:
>>>
>>>      interrupts = <20 8>;
>>>
>>> And be careful which dts version you are using. Is this 20 decimal or
>>> hex?
>>>       
>> The interrupt is indeed level, active low. Where can I find information
>> on UIC
>> interrupt settings for device tree ?
>>     
>
> Not sure if this is really documented. Those values are from 
> include/asm-ppc/irq.h:
>
> #define IRQ_TYPE_NONE           0x00000000      /* Default, unspecified type 
> */
> #define IRQ_TYPE_EDGE_RISING    0x00000001      /* Edge rising type */
> #define IRQ_TYPE_EDGE_FALLING   0x00000002      /* Edge falling type */
> #define IRQ_TYPE_EDGE_BOTH (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING)
> #define IRQ_TYPE_LEVEL_HIGH     0x00000004      /* Level high type */
> #define IRQ_TYPE_LEVEL_LOW      0x00000008      /* Level low type */
>
>   
Thanks for clarification. I was looking at booting-without-of.txt and 
took my number
from there.
>> I'm using dtc 1.2.0, 20 is decimal. 
>> Is it ok ?
>>     
>
> This doesn't really depend on the dtc version but on the version of the dts 
> file itself. Is your dts a v1 dts file? Do you have this in your dts:
>
> /dts-v1/;
>
> ?
>
> If yes, then you have a v1 dts file and all number without 0x are decimal 
> numbers. Then the "20" is correct for ext IRQ 12. If not then this number is 
> hex and you should write "14" instead.
>
>   
Bingo !!! That was my problem. I've started getting interrupts  after 
changing the irq
number to 14.

Thanks a lot !!! Your answers are great as always.

Felix.
