Date: Fri, 24 Mar 2000 14:36:59 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.GSO.4.10.10003241323360.7616-100000@dandelion.sonytel.be>
Message-ID: <Pine.LNX.4.10.10003241427400.21215-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > On a somewhat related issue (the PCI mapping funnies for the Lombard and
> > possibly other Rage Pro devices): what are the penalties if I 'correct'
> > the PCI mapping for the Rage Pro within atyfb_of_init?
>
> atyfb_of_init() no longer exists. Atyfb uses PCI probing only now.

Define 'now' please.

> > Probing the PCI config in atyfb_of_init (code stolen from the non-OFFB
> > case), I get:
> >
> >  atyfb_of_init: got 2 adresses for ATY: 81000000-81ffffff 80881000-80881fff
> >  atyfb: chunk 0 base 0x81000000 breg 16 io 0 pbase 0x81000000 size 0x1000000
> >  atydb: chunk 1 base 0x80881000 breg 20 io 1 pbase 0xc01 size 0x100
> >  atydb: chunk 2 base 0x0 breg 24 io 0 pbase 0x81fff000 size 0x1000
> >  atydb: chunk 3 base 0x4 breg 28 io 0 pbase 0x0 size 0x0
> >
> > I'd like to correct the first one to only include the big endian aperture,
>
> Why? Atyfb has no troubles finding the big endian aperture on its own.

Stupid X doesn't query atyfb on this and stomps on the PCI resources.
atyfb finds the BE aperture because someone hardcoded that it's at
base + 0x800000 :-)

> > and the third one to use the little endian aperture (0x817ff000). Can this
> > be done in atyfb_init?
>
> Third one? ATI Mach64 chips have 2 PCI windows only, AFAIK.

1 is the I/O region, 0 is vram, 2 is MMIO. 1 conflicts with some other
device (though lspci reports it as disabled anyway), 0 and 1 overlap. X
outsmarts us and disables 0 for the benefit of 2.
lspci also reports three regions, in the same order, with the same
addresses (I sent you a lspci log when hunting down the 2.3.48 atyfb bug).

> I think chunk 0 maps to PCI BAR 0 and chunk 2 maps to PCI BAR 1. Don't know
> what chunk 1 and 3 are.

Here's how I read them, don't know how this translates to BAR 0 or 1:

--- drivers/video/atyfb.c.org	Thu Mar 23 22:32:01 2000
+++ drivers/video/atyfb.c	Thu Mar 23 22:28:42 2000
@@ -3191,7 +3191,7 @@
     u8 bus, devfn;
     u16 cmd;
     struct fb_info_aty *info;
-    int i;
+    int i, naddr;

     if (device_is_compatible(dp, "ATY,264LTPro")) {
 	/* XXX kludge for now */
@@ -3219,6 +3219,13 @@
 	    return;
     }

+    printk("atyfb_of_init: got %d OF adresses for ATY:\n", dp->n_addrs);
+    for (i = 0; i < dp->n_addrs; i++)
+	printk(" %08x-%08x", dp->addrs[i].address,
+	       dp->addrs[i].address+dp->addrs[i].size-1);
+    if (dp->n_addrs)
+	printk("\n");
+
     info = kmalloc(sizeof(struct fb_info_aty), GFP_ATOMIC);
     if (!info) {
 	printk("atyfb_of_init: can't alloc fb_info_aty\n");
@@ -3241,6 +3248,38 @@

     /* enable memory-space accesses using config-space command register */
     if (pci_device_loc(dp, &bus, &devfn) == 0) {
+
+	for (i = 0; i < dp->n_addrs + 2; i++) {
+	    int io, breg = PCI_BASE_ADDRESS_0 + (i << 2);
+	    unsigned long base;
+	    u32 size, pbase;
+
+	    base = dp->addrs[i].address;
+
+	    pcibios_read_config_dword(bus, devfn, breg, &pbase);
+	    pcibios_write_config_dword(bus, devfn, breg, 0xffffffff);
+	    pcibios_read_config_dword(bus, devfn, breg, &size);
+	    pcibios_write_config_dword(bus, devfn, breg, pbase);
+
+	    io = (pbase & PCI_BASE_ADDRESS_SPACE)==PCI_BASE_ADDRESS_SPACE_IO;
+
+	    if (io)
+		size &= ~1;
+	    size = ~(size) + 1;
+
+	    if (size == 0)
+	    	break;
+
+	    printk("atyfb: chunk %d ofbase 0x%lx breg %d io %d pbase 0x%lx size 0x%lx \n",
+		i, base, breg, io, pbase, size);
+
+	}
+
+	naddr = i;
+	printk("atyfb: found %d PCI addresses total. \n", i);
+
+	/* insert fixup code here ?? */
+
 	pcibios_read_config_word(bus, devfn, PCI_COMMAND, &cmd);
 	if (cmd != 0xffff) {
 	    cmd |= PCI_COMMAND_MEMORY;

As I said, I adapted code from elsewhere in atyfb.c. I'm just getting my
feet wet WRT PCI.

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
