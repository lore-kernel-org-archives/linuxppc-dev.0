Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <sea6b726.000@mail.frequentis.com>
Date: Wed, 23 Apr 2003 15:54:07 +0200
From: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: PCMCIA Porting
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

The last 2 weeks I worked full time on PCMCIA. We have a custom board with a MPC860T 10/100MBit Ethernet one PCMCIA slot 8MB flash and 32MB RAM.

First at all: It works now fine. And I want to thank everyone who posted information to this issue (Magnus Damm, Matthew Locke, Wolfgang Denk and all others). But this the point for my mail:
It was/is very difficult to get all needed information, to get it to work, so I want to list my steps there, that it is maybe easier to do this work again.

O.K. here is a history of my work:

I linked the pcmcia stuff directly to the kernel (driver/pcmcia), because I think I understand it right Wolfgang, your PCMCIA onyl works if PPCBoot setup the PCMCIA port. But we don't use PPCBoot (shame about that .... ) and it seems to be to complicated/more work to add the whole stuff into our boot up sequence. I know that we loose the possibilty to mount root from a flash card, but we could live with that. Maybe Wolfgang has another hint for me ... :-)

However, I start of course where everyone startet:

http://lists.linuxppc.org/linuxppc-embedded/200002/msg00093.html and http://lists.linuxppc.org/linuxppc-embedded/200005/msg00227.html.

We portet also the mvista kernel 2.4.2 to the denx kernel 2.4.4
Then I add the _IO_BASE etc to the board specific h file and ioremap it as desribed (arch/ppc/kernem/mm/init.c)

-Fine-

Next step was to add the m8xx_pcmcia.c file to drivers/pcmcia and adapt the Config.in and Makefile. Then I do the board specific stuff for power supply in m8xx_pcmcia.c. Till now everything works fine.

But from this point on it becomes difficult, because from now on the interrupts comes up.

The first issue was in cs.c in drivers/pcmcia in the function pcmcia_request_irq

     /* Short cut: if there are no ISA interrupts, then it is PCI */
#if 0
    if (!s->cap.irq_mask) {
	irq = s->cap.pci_irq;
	ret = (irq) ? 0 : CS_IN_USE;
        printk("Uhu: %08x %08x\n",s->cap.irq_mask,s->cap.pci_irq);
#endif
    if (s->cap.irq_mask == (1 << s->cap.pci_irq)) {
	irq = s->cap.pci_irq;
        printk("Uhu: %08x %08x\n",s->cap.irq_mask,s->cap.pci_irq);
#ifdef CONFIG_ISA
    } else if (s->irq.AssignedIRQ != 0) {
	/* If the interrupt is already assigned, it must match */
	irq = s->irq.AssignedIRQ;
	if (req->IRQInfo1 & IRQ_INFO2_VALID) {
	    u_int mask = req->IRQInfo2 & s->cap.irq_mask;
	    ret = ((mask >> irq) & 1) ? 0 : CS_BAD_ARGS;
	} else
	    ret = ((req->IRQInfo1&IRQ_MASK) == irq) ? 0 : CS_BAD_ARGS;
    } else {
	ret = CS_IN_USE;
	if (req->IRQInfo1 & IRQ_INFO2_VALID) {
	    u_int try, mask = req->IRQInfo2 & s->cap.irq_mask;
	    for (try = 0; try < 2; try++) {
		for (irq = 0; irq < 32; irq++)
		    if ((mask >> irq) & 1) {
			ret = try_irq(req->Attributes, irq, try);
			if (ret == 0) break;
		    }
		if (ret == 0) break;
	    }
	} else {
	    irq = req->IRQInfo1 & IRQ_MASK;
	    ret = try_irq(req->Attributes, irq, 1);
	}
#else /* Right now m8xx specific */
    } else if (s->irq.AssignedIRQ != 0) {
	/* If the interrupt is already assigned, it must match */
	irq = s->irq.AssignedIRQ;
	if (req->IRQInfo1 & IRQ_INFO2_VALID) {
	    mask = req->IRQInfo2 & s->cap.irq_mask;
	    ret = ((mask >> irq) & 1) ? 0 : CS_BAD_ARGS;
	} else
	    ret = ((req->IRQInfo1&IRQ_MASK) == irq) ? 0 : CS_BAD_ARGS;
    } else {
	    ret = 0;
	    irq = 7; //SIU_LEVEL4
#endif
    }

The #if 0 and #if CONFIG_ISA tree is the original one, and the #else /*Right now m8xx specific */ part was taken from sourceforge pcmcia-cs 3.2.4.

The last point was the request_irq function. I don't change the defines in the h files, I change the function itself: arch/ppc/kernel/ppc8xx_pic.c. There (in request_irq) I call always the request_8xxirq function.

>From now on it works. I used for the first steps the file system from the eldk and copy then the necessary files (cardctl, cardmgr, scripts) to our filesystem.

I hope I didn't forget anything, please tell me if I've done a lot of nonsense, and I hope this will help in future if anyone has to do these steps anyway

best regards
Gerhard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
