Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D8D0ADDF27
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 10:22:40 +1000 (EST)
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F7@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F7@MERCURY.inside.istor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <269D8EB0-71BD-4C93-BD60-E7E14C533D84@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: How do external irq's get mapped?
Date: Mon, 30 Apr 2007 19:22:33 -0500
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

You need to find out what that is defined to be.  My tree says it's  
defined as CPM_IRQ_OFFSET + NR_CPM_INTS (or 0, if CONFIG_CPM2 isn't  
defined).

So that's the 80, if NR_8259_INTS is 16.  Otherwise it's 64.  So 112  
could work, but if you have your config different, the numbers will  
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
> 9		57	
> 10		58	
> 11		59
>
> Is this correct?


Depends on your configuration.  But probably not.  The CPM takes up  
some space, too.

Andy
