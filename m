From: jeff.boyd@att.net
Message-Id: <200303101316.HAA25661@lists.linuxppc.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 36 bit DMA address on IBM 440 PPC
Date: Mon, 10 Mar 2003 13:15:57 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am having a problem doing PCI/memory DMA on the IBM 440 PPC because it has a
36 bit DMA address to/from the PCI bus (3_8000_0000), but the resource
structure uses an unsigned long (which is a 32 bit quantity for gcc) to
store 'physical/bus/dma' address. There is a kludge to get proper page table
entries, which is to remap the 32 bit quatities into their 36 bit counterparts
and then sending them on to __ioremap which takes a (36 bit) physical address
input. This of course is no help to DMA, which wants not cpu (virtual) address,
but physical (translated) address. I have done a similar kludge, making the 32
to 36 bit translation into a function which a driver doing DMA can use.
However, it seems to me that the real answer here is to change the resource
definition to use a phys_addr_t rather than an unsigned long, for start/end.
Does anyone know if this change has been made anywhere, or if it is being
planned?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
