Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: using cpm interrupts on 8xx
From: Nate Pletcher <pletch@po.cwru.edu>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Date: 22 May 2002 10:58:47 -0400
Message-Id: <1022079528.1226.15.camel@soundgarden>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm trying to use IDMA CPM interrupts on custom MPC855t hardware similar
to an Embedded Planet CLLF or RPX Lite board.  We're using MontaVista's
Hard Hat Linux CDK 1.2 with the 2.2.14 kernel and included tools.

I'm writing a kernel module to control an onboard FPGA that must DMA
data.  I've read through the kernel source in arch/ppc/kernel/irq.c and
arch/ppc/8xx_io/commproc.c and searched the linuxppc-embedded archives,
but I'm still not clear on how to use request_8xxirq() and
cpm_install_handler().  Do I need to register a handler for the SIU
interrupt for the CPM and then another handler for the individual IDMA
interrupt from the CPM?  Perhaps someone could point me to some
documentation on how to register a CPM interrupt handler.

The interrupt hardware on the 8xx is multilevel (CPM interrupts
multiplexed into SIU) so it seems that both functions would be
necessary.  I have read all the MPC8xx documentation on the interrupt
hardware so I'm familiar with the structure, but I'm unsure how PPC
Linux is setup to handle this.  What do I need to do myself and what is
provided by the request_/free_irq interface?

This is my first Linux device driver so any help on registering
interrupt handlers on PPC 8xx would be appreciated.

Thanks,
Nate


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
