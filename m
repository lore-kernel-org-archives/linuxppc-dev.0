Return-Path: <felix@embedded-sol.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AA0B7B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 01:12:49 +1000 (EST)
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19D04DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 01:12:48 +1000 (EST)
Message-ID: <4A818A4C.8060502@embedded-sol.com>
Date: Tue, 11 Aug 2009 18:12:12 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] powerpc/85xx: Workaround MPC8536 GPIO 1 errata.
References: <> <1249981458-16102-1-git-send-email-felix@embedded-sol.com>
	<20090811134450.GA9820@oksana.dev.rtsoft.ru>
In-Reply-To: <20090811134450.GA9820@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Anton Vorontsov wrote:
> On Tue, Aug 11, 2009 at 12:04:18PM +0300, Felix Radensky wrote:
>> On MPC8536 Rev 1.0 the status of GPIO pins configured
>> as output cannot be determined by reading GPDAT register.
>> Workaround by reading the status of input pins from GPDAT
>> and the status of output pins from a shadow register.
>>
>> Signed-off-by: Felix Radensky <felix@embedded-sol.com>
>> ---
>>  arch/powerpc/sysdev/mpc8xxx_gpio.c |    6 +++++-
>>  1 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
>> index 103eace..0b996f3 100644
>> --- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
>> +++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
>> @@ -56,9 +56,13 @@ static void mpc8xxx_gpio_save_regs(struct of_mm_gpio_chip *mm)
>>  
>>  static int mpc8xxx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>>  {
>> +	u32 val;
>>  	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
>> +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
>> +	
>> +	val = in_be32(mm->regs + GPIO_DAT) && ~in_be32(mm->regs + GPIO_DIR);
> 
> Are you sure about &&?


No, that's obviously a typo. Bitwise & intended.

> 
> Plus, this are two reads instead of just one. I think it'll be better
> to implement mpc8536_gpio_get(), and then do
> 
> if (of_device_is_compatible(np, ... 8536-gpio-bank ...))
> 	gc->get = mpc8536_gpio_get;
> else
> 	gc->get = mpc8xxx_gpio_get;

The reads are from 2 different registers, how do you propose to replace
them by a single read ?

I'll implement mpc8572_gpio_get(), suitable for both 8572 and 8536.


> 
>> -	return in_be32(mm->regs + GPIO_DAT) & mpc8xxx_gpio2mask(gpio);
>> +	return (val | mpc8xxx_gc->data) & mpc8xxx_gpio2mask(gpio);
>>  }
>>  
>>  static void mpc8xxx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> 
> Thanks,
> 
