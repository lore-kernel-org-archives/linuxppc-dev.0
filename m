MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE : MPC5200Lite and PCI card IRQ
Date: Wed, 2 Jun 2004 16:21:41 +0200
Message-ID: <5A96167EBCEA8440A48790B5419953AE13C43D@gr-lafayette.lacie.com>
From: "Bertrand Baudet" <bbaudet@lacie.com>
To: <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well,

I have the answer to my question:
Yes, the IRQ is automatically unmasked with the IRQ# from the PCI conf.

In fact the INT A of the PCI is linked to the IRQ0 of the MPC5200.

I'm trying to add a SATA PCI card (with Sii3112 chipset).

But it looks like in ide-probe.c if hwif->irq is set to 0, the IRQ is not
set. Unfortunately, in the case of the MPC5200, the IRQ0 has a value of 0.
Which disable the device.

After commenting out:
/*
if (!hwif->irq) {
	if (!(hwif->irq = ide_default_irq(hwif->io_ports[IDE_DATA_OFFSET])))
      {
              printk("%s: DISABLED, NO IRQ\n", hwif->name);
              return (hwif->present = 0);
      }
}
*/
the SATA card works properly.


Can someone correct me if I'm wrong: setting 0 to hwif->irq means that
there is no IRQ# defined. Right?



Regards,
Bertrand

-----Message d'origine-----
De : owner-linuxppc-dev@lists.linuxppc.org [mailto:owner-linuxppc-dev@lists.linuxppc.org] De la part de Bertrand Baudet
Envoyé : mercredi 2 juin 2004 11:20
À : linuxppc-dev@lists.linuxppc.org
Objet : MPC5200Lite and PCI card IRQ


Hi,

I'm trying to plug a PCI card on my MPC5200Lite board but I have some
trouble enabling the IRQ.

>From U-Boot, I'm setting the interruption line to IRQ 49. By default,
the interruption line is set to 0.

But when the driver is loaded, it doesn't look like the IRQ is unmasked.
The IRQ# is reported by the driver but when I look at /proc/interrupt,
I have:
           CPU0
49:          0  MPC5xxx Edge


What needs to be done in order to have the IRQ automatically enabled for
the
PCI card installed? (using linux kernel from DENX devel cvs)

Actually, how does it work? When the PCI driver probes the devices, will
it
enable the IRQ set for the PCI device? Or is it the driver for this PCI
card
that needs to enable the IRQ?

I tried to enable the IRQ once the drive reports the IRQ# by calling
enable_irq directly, but I'm getting a "enable_irq(49) unbalanced"




Regards,
Bertrand


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
