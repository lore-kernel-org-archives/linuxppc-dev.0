Message-ID: <20021214003254.94837.qmail@web11501.mail.yahoo.com>
Date: Fri, 13 Dec 2002 16:32:54 -0800 (PST)
From: Khai Trinh <kqtrinh@yahoo.com>
Subject: DMA question for ppc440 PCI board
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi folks,

Does anyone out there work on 440 based PCI board?

I have a DMA problem with the 440 DMA controller. In
our application, the 440 based PCI board is living in
a Solaris host platform. Our PCI board is running with
linux version 2.4.17. So, there are Host software,
driver and embedded linux software, driver, etc...We
want to move data in and out between the Host and the
board. We have defined a messaging system to allow
host software to send messages to the embedded
software. When it comes to time to do DMA, the host
sends a DMA request message containing the PCI bus
address and size of the DMA transfer to the embedded
software.

When the embedded software starts programming the DMA
controller, the 440 requires that the PCI bus address
be mapped to the 440 PLB local bus address. There are
3 sets of POM registers on the 440 supposed to allow
us to remap the PCI bus address into PLB local
address. I did that. But when I started programming
the DMA src register with the PCI mapped PLB address,
and the dst register with the locally allocated
buffer, and enable DMA, no DMA is taken place? What am
I missing? Please advice...

I can even tried to use ioremap64() and pass it with
the mapped LPB address to get kernel virtual address.
The kernel address looks good (ie: c0228000). The one
big problem is that the moment I dereferenced the
virtual pointer using readl, the kernel panic...

That suggested to me that somehow I wasn't able to
perform the map correctly.

I would be appreciated if anyone out there can give me
advice on this problem I have.

Thanks,
--Khai


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
