From: "Andy Lowe" <andy_lowe@mvista.com>
To: <rowejames@acmsystems.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCI interrupt masking, CSR on the MPC8250 
Date: Mon, 26 May 2003 13:13:46 -0500
Message-ID: <DIEAKNAFAEAMABGFAOOKKEJJEIAA.andy_lowe@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Rowe wrote:
> The kernel is crashing at boot on my MPC8250 when the PCI interrupts are
> being masked during boot in mpc8266ads_pci.c::mpc8266ads_init_irq(). The
> line of code is
>
> *(volatile) unsigned long *) PCI_INT_MASK_REG |= 0xfff00000;
>
> PCI_INT_MASK_REG is defined in ads8260.h to be 0xf8200004. I've looked
> through the MPC8260 User's Manual as well as the PCI Bridge addendum and
> cannot find the register at this location. Where did this address come
> from? Is this board specific?

All of the code in the file mpc8266ads_pci.c is specific to the Motorola
MPC8266ADS-PCI reference board.  The interrupt handling code in this file is
for an external interrupt controller unique to the MPC8266ADS-PCI board; it
would not be applicable to your custom board.

> In the same header I also see that BCSR_ADDR is set to 0xf8000000. I
> cannot find this area of memory or a description of the CSR in the
> documentation. Judging by its address, I think I will get a Machine
> Check here as well once the kernel gets that far. What exactly is a CSR?

BCSR is short for Board Control and Status Registers.  This is a bank of
external registers implemented on the MPC826xADS boards.  Your custom board
won't have these registers.

The MPC8266ADS support in the linuxppc-devel kernel is designed to be used
with u-boot.  The memory controller and the PCI bridge are both initialized
in u-boot and not in the kernel.  The physical memory map assumed in the
kernel must match the memory map actually implemented in u-boot.  I just
checked the u-boot CVS, and it looks like the MPC8266ADS PCI support was
checked in three days ago.  I haven't verified this myself yet, but you
should be able to use the latest u-boot to boot the latest linuxppc-devel
kernel as-is on the MPC8266ADS board with PCI support.

Andy

Andy Lowe
MontaVista Software
email: andy_lowe@mvista.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
