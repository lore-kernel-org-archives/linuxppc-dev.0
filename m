Date: Thu, 21 Sep 2000 13:07:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI bridge bases, IDE on the B&W G3
Message-ID: <20000921130739.A482@opus.bloom.county>
References: <20000921214446.A865@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000921214446.A865@ibrium.se>; from samuel@ibrium.se on Thu, Sep 21, 2000 at 09:44:47PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 21, 2000 at 09:44:47PM +0200, Samuel Rydh wrote:

> - The B&W G3 has two PCI-buses. The second one is
> accessed through a DEC,21154 controller. The expension
> slots as well as the internal CMD646 IDE-controller is on
> the second bus. The problem is that the bridge reports
> zero in the both baseregisters (the new PCI resource
> allocation scheme then fails miserably). This problem
> is simply fixed by (arch/ppc/kernel/pci.c):
>
>  void __init pcibios_fixup_bus(struct pci_bus *bus)
>  {
> +       pci_read_bridge_bases(bus);
> +
>         if ( ppc_md.pcibios_fixup_bus )
>                 ppc_md.pcibios_fixup_bus(bus);
>  }

Hmm, I wonder if this will fix all of thouse pci resource conflicts I see here.

> - The pci card was never enabled. I solved this by calling
> pci_enable_device(dev) by hand. But... shouldn't this really
> be done automatically by the generic ide layer?

Nope.  the driver for that card should be doing pci_enable_device(dev).

> - If yaboot loads the kernel (or the yaboot config file?)
> from the ACARD IDE-bus, then the card will not work (lost
> interrupts). The same problem (lost interrupts) occurs if
> one tries to boot from the built-in CMD646 controller.
> Possibly, IDE devices are not left in a good state by the
> firmware/yaboot on the B&W G3?

iirc, around 2.4.0-test5 or 6 there were some IDE updates and the only working
IDE driver for us right now is/was ide-pmac.  Ben knows more tho :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
