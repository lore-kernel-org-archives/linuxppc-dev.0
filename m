Date: Tue, 6 Nov 01 20:43:59 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111070443.AA04232@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: i8259.c cleanup
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hollis@austin.ibm.com wrote:

> Anyways, by reading from 0xbffffff0 we can get the active irq without having
> to play with the 8259 directly (which we were doing wrong; see above URL).
> This is true on the IBM PReP's because the 8259's are implemented in the Fire
> Coral SIO bridge (which is on the PCI bus), so it can respond to the PHB's
> interrupt request. (Unless I'm mistaken it's the PHB, in this case MPC105,
> which decodes 0xbffffff0 and asks the system interrupt controller to supply
> the active irq number.)

Different host bridges provide different means for generating PCI Interrupt
Acknowledge cycles. None of the bridges I've worked with (IBM CPC700, IBM
CPC710, and Galileo GT64260) does it via BFFFFFF0. CPC710 does it via a
register in the IBM PHB structure for each of its two PCI interfaces, CPC700
has a special register, and GT64260 has special registers for PCI0 and PCI1
Interrupt Acknowledge in its internal registers space.

> The following patch (to linuxppc_2_4_devel) does exactly that - it reads from
> 0xbffffff0 instead of the 8259 directly.

i8259.c is not specific to PREP, it's used by many platforms in the tree. Your
patch as posted will break a lot of platforms in the tree, including all SBS
boards which use one of the above host bridges and 8259s in a south bridge.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
