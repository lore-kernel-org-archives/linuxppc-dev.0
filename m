Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2C84DE530
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 02:27:52 +1000 (EST)
Message-ID: <48B6D1D4.7020202@freescale.com>
Date: Thu, 28 Aug 2008 11:27:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Muller, Ralf (NSN - FI/Espoo)" <ralf.muller@nsn.com>
Subject: Re: Virtual IRQs on 82xx
References: <F9730D1BBC18E749AE72728B74D189E968356A@FIESEXC006.nsn-intra.net>
In-Reply-To: <F9730D1BBC18E749AE72728B74D189E968356A@FIESEXC006.nsn-intra.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Muller, Ralf (NSN - FI/Espoo) wrote:
> I'm using a 8247 custom board and kernl 2.6.21.7

I strongly recommend using something newer.  There was a lot of 82xx 
work going on around that time.

> on the arch/powerpc 
> branch. Here the irq are virtualized  in the irq map functions now I'm 
> facing several problems.
> 
> * I have to manually call irq_create_of_mapping for each CPM interrupt

What's wrong with irq_of_parse_and_map()?

> And the major problem is:
> Now the kernel mixes virtual- and HW-IRQs, e.g. request_irq works with 
> HW_IRQs but the interrupt handler with virtual interrupts, which can't work.

No, request_irq works with virtual interrupts as well.

> For some reason even on a powerpc the first 16 interrupts are reserved 
> for legacy (PC) IRQs,

Right, there are powerpc systems with the same legacy interrupts and the 
same ISA drivers that expect to be able to use ISA IRQs directly as virqs.

> so the easiest mapping HW-IRQ0 -> VIRQ16 a.s.o

The "easiest mapping" is whatever the IRQ subsystem gives you.  This 
isn't something that should be hardcoded.

-Scott
