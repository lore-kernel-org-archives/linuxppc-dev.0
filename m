Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 00F01DE049
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 17:35:37 +1100 (EST)
Message-ID: <47885FB7.8000705@pikatech.com>
Date: Sat, 12 Jan 2008 01:35:35 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 1/5] Warp Base Platform
References: <47852C41.8000506@pikatech.com>
	<20080111115143.4ed89ab6@zod.rchland.ibm.com>
	<4787FE23.7010201@pikatech.com> <200801120723.29393.sr@denx.de>
In-Reply-To: <200801120723.29393.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> On Saturday 12 January 2008, Sean MacLennan wrote:
>   
>> Josh Boyer wrote:
>>     
>>>> +		if (gpio_base == NULL) {
>>>> +			printk("ERROR: Unable to remap GPIO base.\n");
>>>> +			return;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	leds = readl(gpio_base + 0x100);
>>>>         
>>> Do you really want readl here?  That will byte-swap.
>>>       
>> According to the docs I got from the hardware guys, this is correct.
>> That does *not* mean they didn't get it wrong. Unfortunately, it was
>> just on a piece of paper and I don't know if I still have it.
>>     
>
> You are accessing the 440EP GPIO controller here right? Then you really should 
> use big endian access routines. From you code I assume that you have 
> connected the LED signals to GPIO00 and GPIO01. I suggest to use code that 
> looks like this:
>
> #define LED_GREEN	(0x80000000 >> 0)
> #define LED_RED		(0x80000000 >> 1)
>
> 	leds = in_be32(gpio_base);
>
> 	switch (green) {
> 	case 0: leds &= ~LED_GREEN; break;
> 	case 1: leds |=  LED_GREEN; break;
> 	}
> 	switch (red) {
> 	case 0: leds &= ~LED_RED; break;
> 	case 1: leds |=  LED_RED; break;
> 	}
>
>        outbe32(leds, gpio_base);
>
> And when you change the dts to describe both GPIO controllers you should map 
> the 2nd one and remove the 0x100 offset above as I have done above.
>
> Best regards,
> Stefan
>   
Ok. I will look into that. What is the best practice for looking up the 
second GPIO controller? I have been using of_find_compatible_type. I 
could call it a second time with a from arg.

Cheers,
    Sean
