Subject: PCI interrupt masking, CSR on the MPC8250
From: Jim Rowe <rowejames@acmsystems.com>
To: linuxppc-embedded@lists.linuxppc.org
Message-Id: <1053952637.3773.26.camel@kneedragger>
Mime-Version: 1.0
Date: 26 May 2003 05:37:18 -0700
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have a question on some of Dan's code for the PCI support of the
MPC8266.

The kernel is crashing at boot on my MPC8250 when the PCI interrupts are
being masked during boot in mpc8266ads_pci.c::mpc8266ads_init_irq(). The
line of code is

*(volatile) unsigned long *) PCI_INT_MASK_REG |= 0xfff00000;

PCI_INT_MASK_REG is defined in ads8260.h to be 0xf8200004. I've looked
through the MPC8260 User's Manual as well as the PCI Bridge addendum and
cannot find the register at this location. Where did this address come
from? Is this board specific? The only PCI Mask register that I found in
the documentation is named SIPNR_H located at IMAP_ADDR+0x10C08 (from
the PCI Bridge addendum section 1.7), and PCI has only one bit in here.

In the same header I also see that BCSR_ADDR is set to 0xf8000000. I
cannot find this area of memory or a description of the CSR in the
documentation. Judging by its address, I think I will get a Machine
Check here as well once the kernel gets that far. What exactly is a CSR?

Thanks for any help!

-- James


--
Jim Rowe
Advanced CounterMeasure Systems
Phone: (916)669-4304
Email: jrowe@acmsystems.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
