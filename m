Date: Wed, 7 Nov 01 14:43:28 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111072243.AA06516@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: i8259.c cleanup
Cc: Sven.Dickert@planb.de, davidm@amberdata.demon.co.uk,
	hollis@austin.ibm.com, paubert@iram.es
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert <paubert@iram.es> wrote:

> > Would you say poking the 8259 directly is more "right" than using 0xbffffff0
> > (or equivalent)?
>
> Certainly not. Most ISA bridges (which are the part which contains the
> dual 8259 Pathetic Interrupt Controller), are tested in an x86
> environment, which generate PCI interrupt acknowledge cycles. So hitting
> hardware bugs is much less likely than with polling.

In the PPC world, however, this requires the following assumptions:

1. That the 8259 pair is in a PCI-to-ISA south bridge.

2. That the above bridge is connected to the PPC-to-PCI host bridge by an
   uninterrupted PCI bus. PCI-to-PCI bridges in between may not pass Interrupt
   Acknowledge cycles. There is an SBS board coming up that will have a GT64260
   host bridge, a VT82C686B south bridge, and a P2P bridge in between. I don't
   know if the P2P bridge will pass Interrupt Acknowledge cycles, but I don't
   think there is a requirement that it does. If it does, great, but if it
   doesn't, I'm not going to tell the hardware engineers to change their
   design. We've proven the VT82C686B working on the Adirondack, and the
   Adirondack port in the current linuxppc_2_4_devel works beautifully with the
   i8259.c code using polls.

3. The host bridge must allow you to generate Interrupt Acknowledge cycles, and
   you have to know how it does it, as all host bridges do it differently.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
