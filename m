Return-Path: <cdumoulin@ics-ltd.com>
Received: from mx6-6.spamtrap.magma.ca (mx6-6.spamtrap.magma.ca
	[209.217.78.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC8EF67B70
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Jun 2006 07:38:15 +1000 (EST)
Received: from mail1.magma.ca (mail1.internal.magma.ca [10.0.10.11])
	by mx6-6.spamtrap.magma.ca (8.13.1/8.13.1) with ESMTP id k5FLaCjF003729
	for <linuxppc-embedded@ozlabs.org>; Thu, 15 Jun 2006 17:36:12 -0400
Received: from [192.9.200.156] ([64.26.174.130]) (authenticated bits=0)
	by mail1.magma.ca (Magma's Mail Server) with ESMTP id k5FLc91i017507
	for <linuxppc-embedded@ozlabs.org>; Thu, 15 Jun 2006 17:38:10 -0400
Message-ID: <4491D34B.4060201@ics-ltd.com>
Date: Thu, 15 Jun 2006 17:38:19 -0400
From: Chris Dumoulin <cdumoulin@ics-ltd.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Interrupt occurs but UIC0 MSR is still 0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,
I'm working with a 2.6 linux kernel in a board with a PPC405 in a Virtex 
II Pro FPGA. I'm trying to generate interrupts and handle them in a 
device driver that I've written.
Here is the sequence of events that happen currently:
1. I generate an interrupt by setting registers in an interrupt 
controller we've got in the FPGA (it's a Xilinx LogicCORE OPB Interrupt 
Controller).
2. The function do_IRQ, in arch/powerpc/kernel/irq.c, is called.
3. ppc_md.get_irq is called from do_IRQ.
4. ppc_md.get_irq points to ppc4xx_pic_get_irq in 
arch/ppc/syslib/ppc4xx_pic.c.
5. ppc4xx_pic_get_irq reads the MSR from UIC0 to determine the IRQ. In 
my case, the MSR is all zero, so ppc4xx_pic_get_irq returns -1.
6. After this, we return from the interrupt, and do_IRQ is called again 
and again, going through the same steps indefinitely.

I've looked at the UIC0 registers, and the SR, MSR, and ER registers are 
all 0. How can an interrupt be triggered, but all the UIC0 bits are 0? 
Is it possible that I'm not actually accessing UIC0? I've got the 
following in my arch/ppc/platforms/4xx/my_board.h file:
#define DCRN_UIC0_BASE 0x0C0
#define UIC0 DCRN_UIC0_BASE

Any ideas would be appreciated.

Cheers,
Chris Dumoulin
-- 
*--Christopher Dumoulin--*
Software Team Leader

<http://ics-ltd.com/>
<http://ics-ltd.com/>

Interactive Circuits and Systems Ltd.
5430 Canotek Road
Ottawa, ON
K1J 9G2
(613)749-9241
1-800-267-9794 (USA only)

------------------------------------------------------------------------
This e-mail is private and confidential and is for the addressee only. 
If misdirected, please notify us by telephone and confirm that it has 
been deleted from your system and any hard copies destroyed. You are 
strictly prohibited from using, printing, distributing or disseminating 
it or any information contained in it save to the intended recipient.
