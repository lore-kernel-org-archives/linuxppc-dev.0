Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A6460DE073
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 07:23:31 +1000 (EST)
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F3@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F3@MERCURY.inside.istor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A500BD9D-500C-485A-A806-77B8C430F333@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: How do external irq's get mapped?
Date: Fri, 27 Apr 2007 16:23:31 -0500
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


On Apr 27, 2007, at 15:58, Charles Krinke wrote:

> A little further on IRQ mapping. I was incorrect in saying enet_tx  
> is at
> 19. According to MPC8555ERM.pdf the TSEC1_tx, TSEC_rx and DUART are at
>
> 13 TSEC1_tx   (maps to 93)
> 14 TSEC1_rx   (maps to 94)
> 26 DUART      (maps to 106)
>
> A 'cat /proc/interrupts' shows this 93, 94 & 106 mapping:

Ok that makes sense.
>
> root@sff1:~# cat /proc/interrupts
>            CPU0
>   2:          0   i8259     Edge      82c59 secondary cascade
>  32:          0   CPM2 SIU  Level     ichar
>  93:      10701   OpenPIC   Level     enet_tx
>  94:      13945   OpenPIC   Level     enet_rx
>  98:          0   OpenPIC   Level     enet_error
> 106:        542   OpenPIC   Level     serial
> 107:          0   OpenPIC   Level     i2c-mpc
> 110:          0   OpenPIC   Level     cpm2_cascade
> 128:          0   OpenPIC   Level     <NULL>
> BAD:          0
> root@sff1:~#
>
> Looking at arch/ppc/platforms/85xx/mpc85xx_cds_common.c, I can see the
> mpc85xx_cds_openpic[] array and since CONFIG_PCI is defined, the first
> four entries for IRQ0..3 (or INTA, INTB, INTC & INTD) have non-zero
> entries containing (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), which
> should be OK.


Are you using arch/ppc?  You should probably avoid that.  However, it  
does mean that you are probably using hard-coded irq offsets (rather  
than reading the numbers from the device tree.  What you are seeing  
is the result of adding the number of I8259 interrupts (16) to the  
number of CPM interrupts (64).  Then the internal interrupts start at  
80, and there are 32 of them, and the external interrupts would start  
at 112.  If you look at the arch/ppc code, it defines PIRQA-D, and  
they will be board-specific.


> This leads to a couple of new questions.
>
> 1. We have no 8259 in our design. Is this a concern as we are always
> calling the i8259_init() routine.


Yeah, don't do that.  Just wastes time, and could potentially screw  
around with something else on your bus.


>
> 2. The 'cat /proc/interrupts' shows 82c59 secondary cascade. Again,  
> does
> this matter?

That's potentially a big problem, as the 8259 cascade is hooked up to  
one of the external interrupts.  This might cause your kernel to  
interpret an interrupt as an i8259 interrupt, which could have all  
sorts of strange side-effects.


> 3. The offset between TSEC1_tx of 13-->93 is a constant of 80 decimal.
> Is this a clue to what the irq should be set to for external IRQ0 in
> this design?


Yeah.  112.  However, you really should switch to using arch/powerpc,  
and device trees.  In that instance, you set the irq to the pin  
number (1-4), and the kernel will map that based on the interrupt-map  
property of the pci node.  It was for precisely this type of problem  
that the irq numbers were virtualized.  The IRQ numbers in arch/ppc  
actually change depending on whether you've *configured* the CPM or not.

Andy
