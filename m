Return-Path: <cdumoulin@ics-ltd.com>
Received: from mx3-2.spamtrap.magma.ca (mx3-2.spamtrap.magma.ca
	[209.217.78.169])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A8B667B60
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Jun 2006 00:38:06 +1000 (EST)
Message-ID: <4492C24C.6070502@ics-ltd.com>
Date: Fri, 16 Jun 2006 10:38:04 -0400
From: Chris Dumoulin <cdumoulin@ics-ltd.com>
MIME-Version: 1.0
To: Chris Dumoulin <cdumoulin@ics-ltd.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Interrupt occurs but UIC0 MSR is still 0
References: <4491D34B.4060201@ics-ltd.com>
	<20060616020221.GA3366@gate.ebshome.net>
In-Reply-To: <20060616020221.GA3366@gate.ebshome.net>
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

Thanks Eugene,
You were right on the money. I changed the appropriate Makefile to 
include xilinx_pic.c, instead of ppc4xx_pic.c, and things are now 
working. It seems like the UIC of the PPC405 isn't used (or doesn't 
exist) in the Virtex II Pro. The interrupt servicing code interfaces 
with an external interrupt controller (OPB Interrupt Controller, in my 
case) instead.

Regards,
Chris Dumoulin

Eugene Surovegin wrote:
> On Thu, Jun 15, 2006 at 05:38:19PM -0400, Chris Dumoulin wrote:
>   
>> Hi All,
>> I'm working with a 2.6 linux kernel in a board with a PPC405 in a Virtex 
>> II Pro FPGA. I'm trying to generate interrupts and handle them in a 
>> device driver that I've written.
>> Here is the sequence of events that happen currently:
>> 1. I generate an interrupt by setting registers in an interrupt 
>> controller we've got in the FPGA (it's a Xilinx LogicCORE OPB Interrupt 
>> Controller).
>> 2. The function do_IRQ, in arch/powerpc/kernel/irq.c, is called.
>> 3. ppc_md.get_irq is called from do_IRQ.
>> 4. ppc_md.get_irq points to ppc4xx_pic_get_irq in 
>> arch/ppc/syslib/ppc4xx_pic.c.
>> 5. ppc4xx_pic_get_irq reads the MSR from UIC0 to determine the IRQ. In 
>> my case, the MSR is all zero, so ppc4xx_pic_get_irq returns -1.
>> 6. After this, we return from the interrupt, and do_IRQ is called again 
>> and again, going through the same steps indefinitely.
>>     
>
> I don't think ppc4xx_pic.c is correct file for Xilinx Virtex II Pro. 
> You should be using xilinx_pic.c probably.
>
>   


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
