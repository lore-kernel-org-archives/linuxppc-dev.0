Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id F01F1DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Nov 2008 19:52:39 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KyN52-0006ct-BR
	for linuxppc-embedded@ozlabs.org; Fri, 07 Nov 2008 00:52:36 -0800
Message-ID: <20376306.post@talk.nabble.com>
Date: Fri, 7 Nov 2008 00:52:36 -0800 (PST)
From: wael showair <showair2003@yahoo.com>
To: linuxppc-embedded@ozlabs.org
Subject: How to register an interrupt under linux?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Dear all,
First here is the setup i've:
1. The board is SPTWIMAX-CC1E board 
2. The processor is MPC8555 i found it in the powerpc family NOT ppc family.
Also the board contains DSP core.
3. Linux Kernel 2.6.19-rc5 running on the MPC8555 processor side.

I aim to let the DSP processor interrupts the MPC8555 processor so i think
the first step is to register an interrupt handler for an interrupt number.
i found this in the linux API request_irq. so 

i make a simple module & write in it
request_irq(4,my_handler,SA_INTERRUPT,"DSP",NULL); but unfortunately it
returns -ENOSYS. i have tracked the error & i found this is because the
irq_chip structure was not set.

so i added the API of set_irq_chip as follows:

irqChip.enable = NULL;
irqChip.disable = NULL;
irqChip.startup = NULL;
irqChip.shutdown = NULL;

so that all of these functions will be set to the default APIs
(default_enable,default_disable,default_startup & default_shutdown)

then i passed this struct to the set_irq_chip as follows:

set_irq_chip(4,&irqChip);

& at last i call request_irq.
 ***********************************************************
My code:

irqChip.enable = NULL;
irqChip.disable = NULL;
irqChip.startup = NULL;
irqChip.shutdown = NULL;

set_irq_chip(4,&irqChip);

request_irq(4,my_handler,SA_INTERRUPT,"DSP",NULL);
********************************************************

 but unfortunately when i tried to insert my module i got a segmentation
fault. i have tracked it & i found this is because of the unmask function of
my interrupt irq_chip was not set.
so do i have to implement it & if so, should i write a code that enables my
irq_number for the MPC8555 processor or what?

At last i want you to tell me if this is the right way to register my
interrupt_handler for a certain interrupt_number under linux? this is my
aim.
thanks in advance for your help
-- 
View this message in context: http://www.nabble.com/How-to-register-an-interrupt-under-linux--tp20376306p20376306.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
