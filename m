Date: Fri, 24 Mar 2000 10:02:57 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Timothy A. Seufert" <tas@mindspring.com>
cc: mlan@cpu.lu, bh40@calva.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <v04220802b500d91f6693@[10.0.0.42]>
Message-ID: <Pine.GSO.4.10.10003240958290.7616-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Timothy A. Seufert wrote:
> At 8:22 PM +0100 3/23/00, Michel Lanners wrote:
>
> >That's obviously an issue. I think we should decide once and for all
> >whether the OF tree is supposed to be up-to-date once the system is
> >running. If so, then all fixups (also changing base address) need to be
> >re-sync'ed into the OF tree, which is not done now... Or we just leave
> >the OF tree alone and work only with the PCI_dev list.
>
> It's not up to me, because I don't understand the code well enough to
> contribute directly, but I'll offer these points in favor of not
> updating OF:
>
>
> 1. Duplication of information across multiple data structures is
> evil.  It should be avoided at all costs.
>
> If there was a really, really good reason to keep OF up to date
> (like, say, if we could break back into the OF console like you can
> on Sparcs), then it would be OK.  Otherwise it is most likely
> unnecessary bloat, and leads to potential confusion (and bugs).  Is
> there any such reason on ppc?

Offb is one thing that comes to my mind. But this can easily be solved by
scanning for OF displays before PCI fixup and updating the values returned from
the scanning in pcibios_update_resource() if corresponding resources are
modified.

> 2. Most arch types obviously don't have an OF tree at all.
> Presumably they just do everything with the pci_dev list.  Therefore,
> ppc should too -- it's a bad idea to be different in an unnecessary
> way.

I favor using PCI probing for everything as well, since it means more
integration with existing drivers and less PPC-specific code.

Another advantage of no longer using the information from the OF tree is that
we can just call pci_assign_unassigned_resources() and get everything
reassigned, without worrying about inconsistencies with the OF device tree.

BTW, if you do want to keep the OF device tree consistent,
pcibios_update_resource() is the place to do this.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
