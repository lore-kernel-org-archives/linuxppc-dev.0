From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>,
	Ralph Blach <rcblach@us.ibm.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IO_BASE woes.
Date: Wed, 5 Dec 2001 21:08:26 +0100
Message-Id: <20011205200826.9049@smtp.wanadoo.fr>
In-Reply-To: <3C0E7378.9040706@embeddededge.com>
References: <3C0E7378.9040706@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Ralph Blach wrote:
>
>
>> Along with the PCI, this spells a lot of rewrite of code.
>
>Well, I wouldn't say lots.
>
>A properly written PCI driver isn't an issue, since it shouldn't
>use in/out with IO_BASE any more, especially on PowerPC.  When
>you stumble into drivers that don't do this, they should be modified
>and changes submitted to the author.
>
>For "ISA" chips on processor busses, you just need to get into the
>habit of doing something similar as we should be doing with PCI.
>Simply ioremap the address and use the I/O memory read/write operations.
>I regularly do this, it only requires changes to a few lines of code,
>and sometimes the authors will actually accept the changes.

Well... I can still understand why this is a problem for him. First
there are still PCI drivers that need ibx/outx & PIO, and for
PCMCIA, the current PCMCIA code & drivers more/less makes it
mandatory to support PIO as well.

The best solution I beleive is along those lines:

 - Change 4xx _IO_BASE definition to use the software IO base as used
by the common platform (CONFIG_ALL_PPC). Provided that you properly
set isa_io_base in arch, PCI IOs will still work out of the box.

 - Treat PCMCIA like if it was on a different PCI domain. AFAIK, all
pcmcia drivers can grok beeing passed a base to use for their IO
accesses. Pass them a virtual address which is the virtual address
of the IO space of the PCMCIA bridge minus _IO_BASE (the vitual
address of the PCI IO space). If drivers are written properly,
pointer arithmetic will then make their inx/outx tap the proper
IO space. Example:

   pcmcia_io_base = ioremap(PCMCIA_PHYS_IO_BASE, 0x10000);

Then pass to the pcmcia layer an available IO resource of the
form pcmcia_io_base - _IO_BASE + whatever offset. The net result
for drivers will be to pass inx/outx an address of the form
pcmcia_io_base - _IO_BASE + port. inx/outx will then do +_IO_BASE,
thus causing an access to pcmcia_io_base + port, which is what
you want.

 - For ISA-like devices on EBC, if those drivers can use a base address,
use the exact same trick as PCMCIA. Else, hack the drivers to use mmio
instead, in most cases it's just a matter of search/replace inx/outx
occurence with a driver custom macro that takes into account an
ioremap'ed base.

Note: The reason most of this is so crappy is that x86 still has
separate IO instructions with no remapping facility and some devices
still make use of that. In 2.5, there will hopefully be mandatory
use of an ioremap-like function for PIO as well, which will let
the platform code "cook" whatever virtual pointer is needed.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
