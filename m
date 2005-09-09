Return-Path: <walt.wimer@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id EE7B068224
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Sep 2005 05:09:07 +1000 (EST)
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
In-Reply-To: <1126287092.21092.14.camel@excalibur.timesys.com>
References: <1126287092.21092.14.camel@excalibur.timesys.com>
Content-Type: text/plain
Date: Fri, 09 Sep 2005 15:09:05 -0400
Message-Id: <1126292945.21092.26.camel@excalibur.timesys.com>
Mime-Version: 1.0
Subject: Re: Marvell MV64360 interrupt question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thinking about this some more, I think the cascade mechanism I suggested
earlier is backwards.  Architecturally, I think it makes more sense to
define a platform-specific function like boardXYZ_get_irq() in
boardXYZ_setup.c that knows all of the idiosyncrasies of the board and
calls whatever standard PIC libraries it needs in order to do the right
thing.  Then we set ppc_md.get_irq = boardXYZ_get_irq;

I looked around, and lo and behold, the Radstone PPC7D already "stole"
my idea.  :-)  :-)

    static int ppc7d_get_irq(struct pt_regs *regs)
    {
        int irq;

        irq = mv64360_get_irq(regs);
        if (irq == (mv64360_irq_base + MV64x60_IRQ_GPP28))
            irq = i8259_irq(regs);
        return irq;
    }


Any comments on the "extra" mv64x60_read() call in mv64360_get_irq() are
still welcome.



Thanks!

Walt



On Fri, 2005-09-09 at 13:31 -0400, Walter L. Wimer III wrote:
> BTW, the reason I'm looking at this code is that the board I'm working
> on has a cascaded interrupt controller (implemented in an FPGA) feeding
> into the MV64360 interrupt controller.  I'm thinking about adding a
> cascade mechanism to mv64360_pic.c similar to the one in the OpenPIC
> code (i.e. like the openpic_hookup_cascade() function).  Any opinions on
> whether this is a good idea or a bad one?
> 
> 
> 
> Thanks!!!
> 
> Walt
