Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E63DBDDE9E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 08:43:46 +1000 (EST)
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A201@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A201@MERCURY.inside.istor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <305AA45A-EF86-4661-80F6-AA1996893A3D@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: How do external irq's get mapped?
Date: Wed, 2 May 2007 17:43:46 -0500
To: Charles Krinke <ckrinke@istor.com>
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 2, 2007, at 17:11, Charles Krinke wrote:

>> The new problem is that if I set the irq to 112, when it is
>> insmodded, I
>> get an error from open_pic.c of the form:
>>
>> Open_pic.c:720 invalid irq 112
>>
>> This seems to be coming from the macro at line 144 in open_pic.c
>>
>> #define check_arg_irq(irq) \
>>     if (irq < open_pic_irq_offset || irq >=
>> NumSources+open_pic_irq_offset \
>> 	|| ISR[irq - open_pic_irq_offset] == 0) { \
>>       printk("open_pic.c:%d: invalid irq %d\n", __LINE__, irq); \
>>       dump_stack(); }
>
>
> Any  chance you can identify:
>
> 1) Where this macro is being called from when it fails
>
> 2) Which of the 3 conditions above are actually true
>
> Andy
>
> Dear Andy:
>
> In our system, open_pic_irq_offset=80, numSources=60, *but* ISR[irq -
> open_pic_irq_offset]=NULL when irq 112 is enabled.
>
> It looks to me like each call to openpic_set_sources inits ISR[]
> elements according to the first two arguments. We have two calls to
> openpic_set_sources.
>
> Internal irqs 00..31, 1st openpic_set_sources(0, 32) -- ISR[0..32]
> External irqs 48..60, 2nd openpic_set_sources(48, 12) -- ISR[48..60]


Heh.  Whoops!  I didn't see the gap.  112-127 are, indeed, unmapped  
in this implementation.  Sorry about that.  You're going to want 80 
+48 = 128 for EXT0

>
> But ISR[112] is never initialized in the source base.
>
> I tried the cheap shot of adding a third openpic_set_sources(112, 12),
> but I suspect the real answer is a bit more complicated then that.


Yeah, that would set up interrupts from 192 to 203, which *also*  
don't exist.

Andy
