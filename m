Date: Mon, 28 Aug 2000 14:42:52 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Monro <davidm@amberdata.demon.co.uk>
cc: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCI resource initialisation
In-Reply-To: <39A826A6.D551486F@amberdata.demon.co.uk>
Message-ID: <Pine.LNX.4.10.10008281437040.372-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 26 Aug 2000, David Monro wrote:
> As I see it we have a few choices:
>
> do:
> 	pci_scan_bus(0, &generic_pci_ops, NULL);
>         if (ppc_md.pcibios_fixup)
>                 ppc_md.pcibios_fixup();
>         pcibios_claim_resources(&pci_root_buses);
> 	pci_assign_unassigned_resources();
>
> which should allocate any left alone by the original code, and does
> work, but still means we have to hack the original resources (eg on IBM
> 850s the SCSI hos adapters seem to always get allocated IO port
> resources above 0x20000000, which we relocate in a not very safe manner
> down to 0x01000000). It also assumes we don't need to do any more fixups
> for the newly discovered resources.
>
> or we could do:
> 	pci_scan_bus(0, &generic_pci_ops, NULL);
> 	pci_assign_unassigned_resources();
>         if (ppc_md.pcibios_fixup)
>                 ppc_md.pcibios_fixup();
>
> which results in the kernel completely reassigning all the PCI
> resources. This should mean that the resources all get allocated in
> areas that we would like to find them in, and means that the
> pcibios_fixup code should be a little simpler. This is my preferred
> solution, but I guess might break something.

You could also start from my patches for the CHRP LongTrail (which seems to
work fine on PowerMac as well, especially on 7200 with extra SCSI cards :-).
It assigns resources to all devices that don't have (valid) resources
assigned.

By making sure you fill in the parent pointer of each PCI device you can
control the region resources should be allocated from (see the LongTrail code
for an example). If this parent resource doesn't contain addresses above
0x20000000, the kernel will relocate the SCSI in the 850, just like you want.
That way you don't need an explicit fixup to reassign it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
