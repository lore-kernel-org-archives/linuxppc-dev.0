Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 37644DDF2A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 May 2007 09:11:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How do external irq's get mapped?
Date: Tue, 1 May 2007 16:11:05 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1FC@MERCURY.inside.istor.com>
In-Reply-To: <269D8EB0-71BD-4C93-BD60-E7E14C533D84@freescale.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Andy Fleming" <afleming@freescale.com>
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

Please pardon the top post, it is done to help my local compatriots read
more easily.

Andy, our MPC85xx_OPENPIC_IRQ_OFFSET is 80, but the call to
openpic_init(MPC85xx_OPENPIC_IRQ_OFFSET) occurs after the two calls to
openpic_set_sources. This leads me to believe that the mapping goes

Internal irqs are 00..31 based on first openpic_set_sources(0, 32, ..)
External irqs are 48..60 based on second openpic_set_sources(48, 12,
...)

Then we have the openpic_init(80) call.

So, I though the external IRQ0 was mapped to 48. But is it really mapped
to 80 + 32 or 112 instead. If that is the case, there is another
problem.=20

The new problem is that if I set the irq to 112, when it is insmodded, I
get an error from open_pic.c of the form:

Open_pic.c:720 invalid irq 112

This seems to be coming from the macro at line 144 in open_pic.c

#define check_arg_irq(irq) \
    if (irq < open_pic_irq_offset || irq >=3D
NumSources+open_pic_irq_offset \
	|| ISR[irq - open_pic_irq_offset] =3D=3D 0) { \
      printk("open_pic.c:%d: invalid irq %d\n", __LINE__, irq); \
      dump_stack(); }

Charles




-----Original Message-----
From: Andy Fleming [mailto:afleming@freescale.com]=20
Sent: Monday, April 30, 2007 5:23 PM
To: Charles Krinke
Cc: Sergei Shtylyov; Randy Brown; Chris Carlson; Kevin Smith;
linuxppc-embedded@ozlabs.org
Subject: Re: How do external irq's get mapped?


On Apr 30, 2007, at 09:32, Charles Krinke wrote:

>
>
> At this point, I would just like to confirm I am thinking clearly and
> now understand the IRQ mapping. We are constrained to finish this
> project with the kernel we started with, linux-2.6.17.11, so this
> discussion is centered around that code base. This is my understanding
> based on last week's e-mails and my research.
>
> 1. In arch/ppc/platforms/85xx/mpc85xx_cds_common.c is the
> mpc85xx_cds_openpic_initsenses[] whose first 4 members are set to
> IRQ_SENSE_LEVEL or'ed with IRQ_POLARITY_NEGATIVE. This means the first
> four external interrupts are enabled and neg polarity. I can use these
> entries as is and change the others from 0x0 as I need more of the
> external interrupt pins.
>
> Just for reference, here are a few lines from mpc85xx_cds_init_IRQ
>
> mpc85xx_cds_init_IRQ(void)
> {
> 	openpic_set_sources(0, 32, OpenPIC_Addr + 0x10200);
> 	/* Map PIC IRQs 0-11 */
> 	openpic_set_sources(48, 12, OpenPIC_Addr + 0x10000);


This line is almost more important:

         openpic_init(MPC85xx_OPENPIC_IRQ_OFFSET);

You need to find out what that is defined to be.  My tree says it's =20
defined as CPM_IRQ_OFFSET + NR_CPM_INTS (or 0, if CONFIG_CPM2 isn't =20
defined).

So that's the 80, if NR_8259_INTS is 16.  Otherwise it's 64.  So 112 =20
could work, but if you have your config different, the numbers will =20
move.


>
> 2. In this routine, the first openpic_set_source call is for the 32
> internal IRQ's and the second openpic_set_sources maps the 12 external
> IRQ's beginning at 48, so that means my external IRQ mapping is:
>
> ExtIrQ    LinuxIrqNum
> 0		48 (first four are enabled)
> 1		49
> 2		50
> 3		51
> 4		52 (last 8 not enabled by default)
> 5		53
> 6		54
> 7		55
> 8		56
> 9		57=09
> 10		58=09
> 11		59
>
> Is this correct?


Depends on your configuration.  But probably not.  The CPM takes up =20
some space, too.

Andy
