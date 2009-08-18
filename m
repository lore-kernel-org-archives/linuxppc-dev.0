Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9CFD2B70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 15:18:04 +1000 (EST)
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id D3345DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 15:18:02 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	3FC7931B697
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 07:17:59 +0200 (CEST)
Received: from [192.168.1.6] ([87.97.91.33])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KOK00JBT41W45F3@invitel.hu> for
	linuxppc-dev@ozlabs.org; Tue, 18 Aug 2009 07:17:59 +0200 (CEST)
Date: Tue, 18 Aug 2009 07:24:27 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: simple gpio driver
In-reply-to: <fa686aa40908171418k57ce5ff6iac44a72171bcf14a@mail.gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Message-id: <4A8A3B0B.6020708@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <4A83A976.60608@denx.de>
	<fa686aa40908171418k57ce5ff6iac44a72171bcf14a@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Grant,

Grant Likely wrote:
> On Wed, Aug 12, 2009 at 11:49 PM, Heiko Schocher<hs@denx.de> wrote:
>> Hello Anton,
>>
>> i am trying to use the arch/powerpc/sysdev/simple_gpio.c driver,
>> for accessing some gpios, and found, that u8_gpio_get()
>> returns not only a 1 or a 0, instead it returns the real bit
>> position from the gpio:
>>
>> gpio    return
>> base    value
>> 0       0/0x01
>> 1       0/0x02
>> 2       0/0x04
>> 3       0/0x08
>> 4       0/0x10
>> 5       0/0x20
>> 6       0/0x40
>> 7       0/0x80
>>
>> I also use the arch/powerpc/platforms/52xx/mpc52xx_gpio.c and
>> mpc52xx_gpt.c drivers, they all return for a gpio just a 1 or 0,
>> which seems correct to me, because a gpio can have only 1 or 0
>> as state ... what do you think?
> 
> I think returning '1' is perhaps slightly 'better' (however you define

Yep.

> that), but I don't think the caller should make any assumptions beyond
> zero/non-zero.

Hmm... why? I think a gpio_pin can have as value only 0 or 1.
Ah, if you say zero versus non zero ... hmm... okay.

>> I solved this issue (if it is) with the following patch:
>>
>> diff --git a/arch/powerpc/sysdev/simple_gpio.c b/arch/powerpc/sysdev/simple_gpio.c
>> index 43c4569..bb0d79c 100644
>> --- a/arch/powerpc/sysdev/simple_gpio.c
>> +++ b/arch/powerpc/sysdev/simple_gpio.c
>> @@ -46,7 +46,7 @@ static int u8_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>>  {
>>        struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>>
>> -       return in_8(mm_gc->regs) & u8_pin2mask(gpio);
>> +       return (in_8(mm_gc->regs) & u8_pin2mask(gpio) ? 1 : 0);
> 
> For clarity, the brackets should be just around the & operands, and
> "!= 0" instead of "? 1 : 0" might result in slightly smaller code.
> 
> return (in_8(mm_gc->regs) & u8_pin2mask(gpio)) != 0;

Yep, you are right, thanks for the info.

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
