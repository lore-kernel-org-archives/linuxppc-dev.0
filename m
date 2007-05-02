Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7A443DDF88
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 04:43:00 +1000 (EST)
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1FC@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1FC@MERCURY.inside.istor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <762644B1-26D0-4D16-BA36-55364CACB0D4@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: How do external irq's get mapped?
Date: Wed, 2 May 2007 13:42:56 -0500
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


On May 1, 2007, at 18:11, Charles Krinke wrote:

> Please pardon the top post, it is done to help my local compatriots  
> read
> more easily.
>
> Andy, our MPC85xx_OPENPIC_IRQ_OFFSET is 80, but the call to
> openpic_init(MPC85xx_OPENPIC_IRQ_OFFSET) occurs after the two calls to
> openpic_set_sources. This leads me to believe that the mapping goes
>
> Internal irqs are 00..31 based on first openpic_set_sources(0, 32, ..)
> External irqs are 48..60 based on second openpic_set_sources(48, 12,
> ...)
>
> Then we have the openpic_init(80) call.
>
> So, I though the external IRQ0 was mapped to 48. But is it really  
> mapped
> to 80 + 32 or 112 instead. If that is the case, there is another
> problem.


Yeah, the set_sources functions just initialize the array of  
interrupts.  The openpic_init() actually gives them numbers and stuff.


>
> The new problem is that if I set the irq to 112, when it is  
> insmodded, I
> get an error from open_pic.c of the form:
>
> Open_pic.c:720 invalid irq 112
>
> This seems to be coming from the macro at line 144 in open_pic.c
>
> #define check_arg_irq(irq) \
>     if (irq < open_pic_irq_offset || irq >=
> NumSources+open_pic_irq_offset \
> 	|| ISR[irq - open_pic_irq_offset] == 0) { \
>       printk("open_pic.c:%d: invalid irq %d\n", __LINE__, irq); \
>       dump_stack(); }


Any  chance you can identify:

1) Where this macro is being called from when it fails

2) Which of the 3 conditions above are actually true

Andy
