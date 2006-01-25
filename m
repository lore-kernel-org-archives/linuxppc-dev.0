Return-Path: <sr@denx.de>
Received: from natsluvver.rzone.de (natsluvver.rzone.de [81.169.145.176])
	by ozlabs.org (Postfix) with ESMTP id 22F6568A45
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jan 2006 21:28:11 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite/440EP is there a global interrupt enable mask?
Date: Wed, 25 Jan 2006 11:28:05 +0100
References: <43CC3E37.4040707@softadvances.com>
	<43D66D06.9090904@ovro.caltech.edu>
	<43D67AF6.6070403@ovro.caltech.edu>
In-Reply-To: <43D67AF6.6070403@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601251128.05370.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

On Tuesday 24 January 2006 20:07, David Hawkins wrote:
> I'm writing a simple driver to test IRQ handling on the
> AMCC Yosemite board. The board has an 8x2 header with several
> GPIO pins, a number of which can be configured as IRQ inputs.
>
> I have setup GPIO46 as output, and GPIO47 as input, and
> selected IRQ8 on that pin.

OK. So far good.

<snip>

> So, is there a kernel wide interrupt enable mask that I really
> should be using? Or, an interrupt enable API? I initially
> thought that when I registered an interrupt using
> request_irq() that the kernel would go off an enable the
> requested IRQ, but this test shows that it did not.

Yes, the request_irq() should enable the requested IRQ. You seem to have used 
the wrong IRQ number though. Please see below.

> #include <linux/module.h>   /* kernel modules                    */
> #include <linux/interrupt.h>/* request_irq(), etc                */
> #include <asm/io.h>         /* ioremap64(), iounmap(), readl()   */
>
> static char *name = "yosemite_irq";
> static unsigned long long base = 0x0EF600C00; // 36-bit address
> static unsigned int size = 0x44;
> static char *kernel;
> static int irq = 8;

You are using the "External IRQ 8". This results in IRQ number 19 of the 2nd 
interrupt controller of the 440ep. So please try (19+32) as the IRQ number 
upon requesting the interrupt.

Best regards,
Stefan
