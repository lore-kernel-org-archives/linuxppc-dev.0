Date: Sun, 18 Jan 2004 15:44:12 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040118144412.GA6897@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 19, 2004 at 10:24:52AM +1100, Benjamin Herrenschmidt wrote:
>
> > Ok, i have done this. I have followed the recomendations of the hardware
> > guy, and did the following :
> >
> >   device 0, function 0 : read access to bytes 0-15, read returns 0 on
> >   regs > 15. Write access fails silently.
>
> Show the code (just in case...)


  #define PEG2_PCI_OP(rw, size, type, op, mask, btrw)
  int __chrp
  peg2_##rw##_config_##size(struct pci_dev *dev, int offset, type val)
  {
          struct pci_controller *hose = dev->sysdata;
          u32 msr;
          u32 data;
          volatile unsigned int *f118 = hose->cfg_peg2_magic;
          volatile unsigned int *f11c = (unsigned int *) f118 + 1;

          /* We won't write on device 0 and only read byte 0-15 of func 0 */
          if (dev->bus->number == 0 || dev->bus->number == 0x10) {
                  if (dev->devfn == 0) {
                          if (!(btrw & 1) && (offset > 15)) {
                                  val = (type) 0x0;
                                  return PCIBIOS_SUCCESSFUL;
                          } else if (btrw & 1) {
                                  return PCIBIOS_SUCCESSFUL;
                          }
                  } else if ((dev->devfn >> 3) == 0) {
                          return PCIBIOS_DEVICE_NOT_FOUND;
                  }
          }

	  if (btrw & 2) {
                /* Disable cpu interrupts */
                msr = mfmsr();
                mtmsr(msr & ~MSR_EE);
                /* Enable PCI -> AGP idsel mapping */
                cfg_write(0x8000, f118, u32, out_be32);
          }

          data = 0x80000000 | ((dev->bus->number - hose->bus_offset) << 16)
                    | (dev->devfn << 8) | (offset & 0xff);
          cfg_write(data, hose->cfg_addr, u32, out_le32);
          cfg_##rw(val, hose->cfg_data + (offset & mask), type, op);

          if (btrw & 2) {
                /* Enable PCI -> AGP idsel mapping */
                cfg_write(0x8000, f11c, u32, out_be32);
                /* Disable cpu interrupts */
                mtmsr(msr);
          }
          return PCIBIOS_SUCCESSFUL;
  }

btrw is 0 for reads and 1 for writes. The second bit (0 or 2) also
encodes if we are on the pci or agp bus, to enable th agp config access
magic.

> >   device 0, function 1-7 : both read and writes fail with
> >   PCIBIOS_DEVICE_NOT_FOUND.
> >
> > Additionnally, i have nullified the ressources with :
> > 	dev->resource[i].flags = 0;
> > 	dev->resource[i].start = 0;
> > 	dev->resource[i].end = 0;
> > from the pcibios_fixup (not the right place, but i don't know where it
> > should be done instead).
>
> A quirk is one of the functions in the table in pci.c but you can
> use the fixup too at this point...

Ok.

> > This allows me to see the host bridge on both buses, and radeonfb works
> > fine :
> >
> > $ lspci
> > 00:00.0 Host bridge: Galileo Technology Ltd.: Unknown device 6460 (rev 03)
> > 00:01.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
> > 00:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c810 (rev 23)
> > 00:0c.0 ISA bridge: VIA Technologies, Inc. VT8231 [PCI-to-ISA Bridge] (rev 10)
> > 00:0c.1 IDE interface: VIA Technologies, Inc.  VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
> > 00:0c.2 USB Controller: VIA Technologies, Inc. USB (rev 1e)
> > 00:0c.3 USB Controller: VIA Technologies, Inc. USB (rev 1e)
> > 00:0c.4 Non-VGA unclassified device: VIA Technologies, Inc. VT8235 ACPI (rev 10)
> > 00:0c.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 40)
> > 00:0c.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 Modem] (rev 20)
> > 00:0d.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 51)
> > 10:00.0 Host bridge: Galileo Technology Ltd.: Unknown device 6460 (rev 03)
> > 10:08.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5964 (rev 01)
> >
> > But :
> >
> > $ hexdump /proc/bus/pci/10/00.0
> > 0000000 ab11 6064 0700 b022 0300 0006 2000 0000
> > 0000010 20df 85cf 20df 85cf 20df 85cf 20df 85cf
> > *
> > 0000040
> >
> > Why in hell do i have 0x20df85cf on all four bars of the config space
> > addresses 0x10 to 0x1f ?
>
> I don't know, make sure you are "filtering" things properly... You
> should return 0xff on anything after 0x10 I suppose (though you
> may want to return 0 for the BARs, I have to dbl check).

I am returning 0 for all of function 0. I dropped the whole struct
pci_dev ressource thingy, and they are well nullified. My limited
understanding of those pci issues let me make a guess though. I think
that either the stuff in the struct pci_dev is set later on (the BARs
are modifiable i think), or those values are read from the struct
pci_dev before i nullify them.

> > Finally, X works, altough DRI freezes after a second or two with my
> > radeon 9200SE, while it works for a Radeon 7500, but this is probably a
> > DRI issue.
>
> Which version of DRI ? Do you have the interrupt routing working
> properly ?

Mmm, maybe i should also allow to read (and write ?) the config 32-bit
word at 0x3c, those include the Interrupt Line and Pin, as well as the
Max_lat and Min_Gnt.

Maybe some of the first 16 bytes would also need to be modifiable, and
there should be no harm in allowing read of the subsytem id and vendor
id ?

As for the DRI version, i use the drm module from the linuxppc-2.4 tree,
using the v2.4.24 TAG to checkout, and the rest of the XFree86 stuff,
including the mesa libraries, from the 4.3.0-0pre1v5 experimental
package, rebuild with the Radeon 9200SE patch from Michel Daenzer.

The freeze happens when i first launch glxinfo, or when i first start
moving a window around (using a debian/unstable default gnome desktop).
I don't remember well, but i think it would also freeze when let running
for a time, but i am not sure. The box is still available trough ssh,
but killing the X server doesn't restore the fbdev console, and freeze
the box.

> > What makes me wonder, is that X needs around 20 seconds to launch, which
> > could not be something normal. It usually takes 5-8 seconds only.
> > Something strange is going on.
>
> Yah, XFree log could be useful.

Ok, i uploaded it at http://people.debian.org/~luther/XFree86.0.log,
since the list was not able to cope with it. I didn't see anything anormal
there though. Altough some of the bus ressources seem to be checked even
if i nullified them.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
