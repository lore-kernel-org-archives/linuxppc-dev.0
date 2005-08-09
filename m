Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id CD17068059
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 08:42:32 +1000 (EST)
In-Reply-To: <20050809150131.7eac43ad.akpm@osdl.org>
References: <20050809150131.7eac43ad.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3779A304-7AFC-4476-B0FC-794BD0351270@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 9 Aug 2005 17:42:31 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Gala Kumar K.-galak" <galak@freescale.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: Added support for the Book-E style Watchdog Timer
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 9, 2005, at 5:01 PM, Andrew Morton wrote:

> Kumar Gala <galak@freescale.com> wrote:
>
>>
>> PowerPC 40x and Book-E processors support a watchdog timer at the
>>
> processor
>
>> core level.  The timer has implementation dependent timeout
>>
> frequencies
>
>> that can be configured by software.
>>
>> One the first Watchdog timeout we get a critical exception.  It is
>>
> left
>
>> to board specific code to determine what should happen at this point.
>>
> If
>
>> nothing is done and another timeout period expires the processor may
>> attempt to reset the machine.
>>
>> Command line parameters:
>>   wdt=0 : disable watchdog (default)
>>   wdt=1 : enable watchdog
>>
>>   wdt_period=N : N sets the value of the Watchdog Timer Period.
>>
>>   The Watchdog Timer Period meaning is implementation specific. Check
>>   User Manual for the processor for more details.
>>
>> This patch is based off of work done by Takeharu Kato.
>>
>> ...
>>
>> +#ifdef CONFIG_BOOKE_WDT
>> +/* Checks wdt=x and wdt_period=xx command-line option */
>> +int __init early_parse_wdt(char *p)
>> +{
>> +    extern u32 wdt_enable;
>> +
>> +    if (p && strncmp(p, "0", 1) != 0)
>> +           wdt_enable = 1;
>> +
>> +    return 0;
>> +}
>> +early_param("wdt", early_parse_wdt);
>> +
>> +int __init early_parse_wdt_period (char *p)
>> +{
>> +    extern u32 wdt_period;
>> +
>> +    if (p)
>> +        wdt_period = simple_strtoul(p, NULL, 0);
>> +
>> +    return 0;
>> +}
>>
>
>
> Would prefer to see the declaration of wdt_period in a header file,
> please.
>
> But beware that wdt_enable() is already a static symbol in a couple of
> watchdog drivers.  It might be best to rename the ppc global to
> something
> less generic-sounding while you're there.

Ok, will make these changes and send an updated patch.

- kumar
