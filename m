Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: yellowdog-devel@lists.terrasoftsolutions.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: problems with Sonnet Tempo ATA-100 - Is it supported?
Date: Mon, 10 Jun 2002 22:39:34 -0400
Cc: yellowdog-devel@lists.terrasoftsolutions.com
References: <200206102232.16457.kevin.hendricks@sympatico.ca>
In-Reply-To: <200206102232.16457.kevin.hendricks@sympatico.ca>
MIME-Version: 1.0
Message-Id: <200206102239.34798.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Just to be specific, here is the patch I applied to the pdc202xx.c driver
based on Promise's own code correction sent to the linux kernel mailing
list.

This fix is what got me past the hung partition table.

--- pdc202xx.c.orig     Sat Jun  8 12:57:04 2002
+++ pdc202xx.c  Fri Jun  7 19:31:27 2002
@@ -985,7 +985,7 @@
        ide_hwif_t *hwif        = HWIF(drive);
        struct pci_dev *dev     = hwif->pci_dev;
        unsigned long high_16   = pci_resource_start(dev, 4);
-       unsigned long atapi_reg = high_16 + (hwif->channel ? 0x24 : 0x00);
+       unsigned long atapi_reg = high_16 + (hwif->channel ? 0x24 : 0x20);
        unsigned long dma_base  = hwif->dma_base;

        switch (dev->device) {
@@ -994,11 +994,11 @@
                case PCI_DEVICE_ID_PROMISE_20269:
                case PCI_DEVICE_ID_PROMISE_20268R:
                case PCI_DEVICE_ID_PROMISE_20268:
+               case PCI_DEVICE_ID_PROMISE_20262:
                        newchip = 1;
                        break;
                case PCI_DEVICE_ID_PROMISE_20267:
                case PCI_DEVICE_ID_PROMISE_20265:
-               case PCI_DEVICE_ID_PROMISE_20262:
                        hardware48hack = 1;
                        clock = IN_BYTE(high_16 + 0x11);
                default:


Ideas welcome.

Thanks,

Kevin


On June 10, 2002 10:32, Kevin B. Hendricks wrote:
> Hi,
>
> I have a Sonnet Tempo ATA100 I use when I boot under MacOSX that I have
> been trying to make useful under Linux.
>
> I looked and the chip is  Promise 20268 so I enabled the PDC202XX driver
> in Linux as a module and applied the latest fixes that were talked about
> recently on the kernel mailing list archive (direct from Promise).
>
> Finally... the partition table is now readable on that drive (it has
> never worked with any pdc202xx driver up to this point) but I now get
> some funny error messages about "IN from bad port XXX at C02cfa68
>
> My System.map shows the following for that address:
> c02cfa3c T pci_init_pdc202xx
>
> Here is the relevant piece of the dmesg (this is with Ben's latest
> kernel rsynced on Saturday with some patches to get past the partition
> table hang direct from Promise via the linux kernel mailing list
> archive.
>
> PDC20268: IDE controller on PCI bus 01 dev a0
> PDC20268: chipset revision 2
> PDC20268: not 100% native mode: will probe irqs later
> IN from bad port 41f at c02cfa68
> IN from bad port 41a at c02cfa84
> IN from bad port 41b at c02cfaa0
> PDC20268: ROM enabled at 0x80090000
> IN from bad port 3 at c02cfe1c
>     ide2: BM-DMA at 0x0400-0x0407, BIOS settings: hde:pio, hdf:pio
> IN from bad port 3 at c02cfe1c
>     ide3: BM-DMA at 0x0408-0x040f, BIOS settings: hdg:pio, hdh:pio
> ...
> hde: WDC WD600BB-32BSA0, ATA DISK drive
> ...
> hde: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63,
> UDMA(33)
> ...
>  hde: [mac] hde1 hde2 hde3 hde4 hde5 hde6 hde7 hde8 hde9 hde10 hde11
> hde12
>
>
> So the latest patches on the kernel list for the pdc 202xx are a big
> improvement (no more hanging at the partition map) but still not quite
> right.
>
> Here is what lspci -v says about the card:
>
> 01:14.0 Unknown mass storage controller: Promise Technology, Inc. 20268
> (rev 02)
>  (prog-if 85)
>         Subsystem: Promise Technology, Inc.: Unknown device ad68
>         Flags: bus master, 66Mhz, slow devsel, latency 16, IRQ 54
>         I/O ports at 0440 [size=8]
>         I/O ports at 0430 [size=4]
>         I/O ports at 0420 [size=8]
>         I/O ports at 0410 [size=4]
>         I/O ports at 0400 [size=16]
>         Memory at 800a0000 (32-bit, non-prefetchable) [size=64K]
>         Expansion ROM at 80090000 [disabled] [size=64K]
>         Capabilities: <available only to root>
>
> I noticed that I/O ports are enable (not disabled).  I thought all I/O
> was MMIO (memory mapped) but I am unsure if this is the case.
>
> This card works fine under MacOSX, and Mac OS9 and I hoped PPC Linux
> which is why I bought it.
>
> Can someone give me some hints about where to look to fix this?  Is it
> just that the pdc202XX driver is not compatbile with ppc linux?
>
> Is anyone else using a Sonnet Tempo ATA100 pci card successfully with
> DMA and if so which driver?
>
> Thanks,
>
> Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
