MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE : MPC5200Lite PCI & IRQ
Date: Fri, 18 Jun 2004 12:06:20 +0200
Message-ID: <5A96167EBCEA8440A48790B5419953AE13C46A@gr-lafayette.lacie.com>
From: "Bertrand Baudet" <bbaudet@lacie.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>, <jgarzik@redhat.com>,
	<B.Zolnierkiewicz@elka.pw.edu.pl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well, there is not only the IDE driver; the USB driver does it as well:

In the 2.4.25, from the "drivers/usb/host/usb-ohci.c", in the 'ohci_pci_probe' function:

And in the 2.6.7, from "drivers/usb/core/hcd-pci.c", in the 'usb_hcd_pci_probe' function:

if (!dev->irq) {
	err("found OHCI device with no IRQ assigned. check BIOS settings!");
	pci_disable_device (dev);
	return -ENODEV;
}

There are probably other drivers that have the wrong assumption that IRQ 0
is an unassigned IRQ.


Bertrand


-----Message d'origine-----
De : David Woodhouse [mailto:dwmw2@infradead.org]
Envoyé : vendredi 18 juin 2004 11:29
À : Bertrand Baudet
Cc : linuxppc-embedded@lists.linuxppc.org; jgarzik@redhat.com; B.Zolnierkiewicz@elka.pw.edu.pl
Objet : Re: MPC5200Lite PCI & IRQ

On Fri, 2004-06-04 at 15:00 +0200, Bertrand Baudet wrote:
> Hi,
>
> I'm trying to plug a sata card in the PCI slot of the MPC5200Lite.
...
> By default the IRQ line of the sata card is 0,
...
> From the source code, it looks like a value 0 for the IRQ means the IRQ
> is disabled.
>
> From "drivers/ide/ide-probe.c", in the 'hwif_init' function:
> ...
> if (!hwif->irq) {
>    if (!(hwif->irq = ide_default_irq(hwif->io_ports[IDE_DATA_OFFSET])))
>    {
>       printk("%s: DISABLED, NO IRQ\n", hwif->name);
>       return (hwif->present = 0);
>    }
> }
> ...
>
> Commenting out the above code allow the PCI card to run properly.

This is a bug in the IDE driver. Zero is a perfectly valid IRQ number --
I have boxes where PCI slots get IRQ #0 too. Please fix the IDE driver
and send the patch to the IDE maintainer.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
