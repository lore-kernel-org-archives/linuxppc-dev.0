Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A5B47B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 23:58:05 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 108DDDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 23:58:04 +1000 (EST)
Message-Id: <EA28151F-CC69-4940-A6EB-42138BD86CAB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090811134450.GA9820@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH] powerpc/85xx: Workaround MPC8536 GPIO 1 errata.
Date: Tue, 11 Aug 2009 08:57:55 -0500
References: <> <1249981458-16102-1-git-send-email-felix@embedded-sol.com>
	<20090811134450.GA9820@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Felix Radensky <felix@embedded-sol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 11, 2009, at 8:44 AM, Anton Vorontsov wrote:

> On Tue, Aug 11, 2009 at 12:04:18PM +0300, Felix Radensky wrote:
>> On MPC8536 Rev 1.0 the status of GPIO pins configured
>> as output cannot be determined by reading GPDAT register.
>> Workaround by reading the status of input pins from GPDAT
>> and the status of output pins from a shadow register.
>>
>> Signed-off-by: Felix Radensky <felix@embedded-sol.com>
>> ---
>> arch/powerpc/sysdev/mpc8xxx_gpio.c |    6 +++++-
>> 1 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/ 
>> sysdev/mpc8xxx_gpio.c
>> index 103eace..0b996f3 100644
>> --- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
>> +++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
>> @@ -56,9 +56,13 @@ static void mpc8xxx_gpio_save_regs(struct  
>> of_mm_gpio_chip *mm)
>>
>> static int mpc8xxx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>> {
>> +	u32 val;
>> 	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
>> +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
>> +	
>> +	val = in_be32(mm->regs + GPIO_DAT) && ~in_be32(mm->regs +  
>> GPIO_DIR);
>
> Are you sure about &&?
>
> Plus, this are two reads instead of just one. I think it'll be better
> to implement mpc8536_gpio_get(), and then do
>
> if (of_device_is_compatible(np, ... 8536-gpio-bank ...))
> 	gc->get = mpc8536_gpio_get;
> else
> 	gc->get = mpc8xxx_gpio_get;

I think 8572 has the same errata.

>
>> -	return in_be32(mm->regs + GPIO_DAT) & mpc8xxx_gpio2mask(gpio);
>> +	return (val | mpc8xxx_gc->data) & mpc8xxx_gpio2mask(gpio);
>> }
>>
>> static void mpc8xxx_gpio_set(struct gpio_chip *gc, unsigned int  
>> gpio, int val)
>
> Thanks,
>
> -- 
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
