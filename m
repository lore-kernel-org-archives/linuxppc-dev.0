Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0D06E67B7B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Jun 2006 12:02:25 +1000 (EST)
Date: Thu, 15 Jun 2006 19:02:21 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Chris Dumoulin <cdumoulin@ics-ltd.com>
Subject: Re: Interrupt occurs but UIC0 MSR is still 0
Message-ID: <20060616020221.GA3366@gate.ebshome.net>
References: <4491D34B.4060201@ics-ltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4491D34B.4060201@ics-ltd.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 15, 2006 at 05:38:19PM -0400, Chris Dumoulin wrote:
> Hi All,
> I'm working with a 2.6 linux kernel in a board with a PPC405 in a Virtex 
> II Pro FPGA. I'm trying to generate interrupts and handle them in a 
> device driver that I've written.
> Here is the sequence of events that happen currently:
> 1. I generate an interrupt by setting registers in an interrupt 
> controller we've got in the FPGA (it's a Xilinx LogicCORE OPB Interrupt 
> Controller).
> 2. The function do_IRQ, in arch/powerpc/kernel/irq.c, is called.
> 3. ppc_md.get_irq is called from do_IRQ.
> 4. ppc_md.get_irq points to ppc4xx_pic_get_irq in 
> arch/ppc/syslib/ppc4xx_pic.c.
> 5. ppc4xx_pic_get_irq reads the MSR from UIC0 to determine the IRQ. In 
> my case, the MSR is all zero, so ppc4xx_pic_get_irq returns -1.
> 6. After this, we return from the interrupt, and do_IRQ is called again 
> and again, going through the same steps indefinitely.

I don't think ppc4xx_pic.c is correct file for Xilinx Virtex II Pro. 
You should be using xilinx_pic.c probably.

-- 
Eugene
