Message-ID: <3C05F807.9090806@humboldt.co.uk>
Date: Thu, 29 Nov 2001 08:55:35 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_init_hwif_ports
References: <15365.51839.327359.844495@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:


> Platforms with a PCI IDE controller should use the pci-ide driver
> instead of trying to use ide_default_io_base and ide_init_hwif_ports
> to point the IDE code at the IDE registers.  In other words, only
> those platforms with an ISA IDE controller (prep, any others?) should
> ever need to have their ide_default_io_base return anything other than
> 0.
>
> So I am proposing to drop ppc_md.ide_init_hwif_ports and change the
> definition of ide_init_hwif_ports in include/asm-ppc/ide.h to the one
> above.


The one important thing that the ide_init_hwif function handles for one
of my boards (and for the sandpoint) is the knowledge that the irqs are
14 and 15. If left to its own devices the pci-ide code  will assume that
both channels are on the same irq, which leaves the second channel
running without interrupts.

But I'd be happy with any simpler way of communicating "just use 14 and
15" to the pci-ide driver.

--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
