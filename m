Date: Fri, 22 Sep 2000 12:17:45 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Samuel Rydh <samuel@ibrium.se>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI bridge bases, IDE on the B&W G3
In-Reply-To: <20000921214446.A865@ibrium.se>
Message-ID: <Pine.LNX.4.10.10009221216310.377-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 21 Sep 2000, Samuel Rydh wrote:
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
>
> (i386 does it this way too).

Aha! I think this will also solve the problems on the G4.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
