Date: Sun, 1 Oct 2000 19:59:55 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: R Shapiro <rshapiro@bbn.com>, Michel Dänzer <daenzerm@student.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org, Jon Erick Ween <jween@som.llu.edu>
Subject: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + ati driver
 with rage II/rage pro)
In-Reply-To: <Pine.LNX.4.21.0009301652040.2538-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.10.10010011928450.9543-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I think it is fixable at the X PCI probe level, I just don't know how to
> > do it (can you say entangled web of maze?).
> >
> > Another idea (strictly in the Unix tradition): X knows how to mess up the
> > PCI config from user space so why shouldn't we, before X gets a shot at
> > it? 'Just' write the correct mapping to the offending BAR from a rc
> > script. Obvious drawback: the kernel OF tree won't be updated, and the
> > kernel can't safeguard against insane BAR settings (at least I can't tell
> > how that would work, one of the PCI gurus please enlighten me). Makes a
> > nice local DOS tool.
>
> Hmm fixing the resources from userland wont help you, you have to do it
> before atyfb starts up. If i remember right from your logs X didn't had
> any problems doing the relocation.

While I still think having a userland PCI resource fixup tool would be
nice (at least for debugging purpose) I also promised to come up with a
sanitized version of the atyfb resource fixup patch. Here it is, please
test it (especially Jon, and R. Shapiro) and tell me if it works.

A few remarks on why this patch is necessary, what it does (and doesn't):

On some Powermacs/books with Mach64 graphics, MacOS overrides the PCI
resource mapping set up by OF (IO, MMIO and video RAM all separate,
nonoverlapping regions) to make MMIO overlap the video RAM region. The X
server thinks that's not legit, and disables (or relocates) one of these
regions (video RAM in my case), thereby crashing the kernel on the first
fbdev syscall.
Some of these Powermacs cannot use yaboot (preserving the correct OF
mapping), so another way to fix the overlap mapping as early as possible
is required. 2.3 and 2.4 kernels do this at PCI init time now (thanks to
Geert's PCI resource patch), using the generic memory resource information
in the kernel. 2.2 kernels don't have that generic resource handling so
atyfb is the natural place for the fix here.

My patch first checks that the address OF uses for the atyfb MMIO region
(0x80881000) is not taken by any other PCI device. If another device uses
that area, an alternate area (immediately adjacent to the video RAM area)
is checked. If a free area is found atyfb changes the PCI BAR
corresponding to the MMIO area, the PCI device entry and the OF device
tree node for atyfb.

I'm not positive R. Shapiro's problems with multiple heads are solved by
this (the PCI logs looked sane already), but it definitely helps on
Wallstreet and Lombard models, and perhaps a few others.

Side note:
The MMIO register area is accessible not only by a separate PCI mapping
but also via two aliased register areas at the very end of the LE and BE
video RAM apertures (just make atyfb zero the whole video RAM and you'll
see). atyfb uses one of these areas to access the MMIO registers, that's
why 1) relocating or disabling the video RAM area hurts, and 2) relocating
the separate MMIO mapping after atyfb startup would help remove the
overlap without any adverse effect I can see, aside from the kernel's
view of this PCI resource being at odds with reality. Resolving the PCI
mapping before atyfb starts up keeps X from changing the mapping (no
illegal overlap anymore) and the kernel still has valid resource
information.

The patch is relative to 2.2.17pre20-benh1 but should apply cleanly to
anything between 2.2.14 and 2.2.18. It is not required for 2.3 and 2.4
kernels.

	Michael

--- drivers/video/atyfb.c.benh	Wed Aug 23 20:26:33 2000
+++ drivers/video/atyfb.c	Sat Sep 30 14:29:11 2000
@@ -3241,14 +3241,72 @@
 #endif
 }

+/*
+ * Check PCI resource overlap between any PCI device (but mydev) and this region.
+ * This function does not discriminate between IO and memory space so memory regions
+ * will be considered to overlap IO regions though they might be decoded separate on
+ * machines with separate memory and IO access. This being for PPC I don't care - MSch.
+ */
+__initfunc(int atyfb_check_overlap(struct pci_dev *mydev, unsigned long mybase, unsigned int mysize))
+{
+
+    int i,j;
+    struct pci_dev *pdev;
+
+    for (pdev = pci_devices; pdev; pdev = pdev->next) {
+
+	if (pdev == mydev)
+	    continue;
+
+        for (i = 0, j = 2; i < 6 && pdev->base_address[i]; i++) {
+	    int io, breg = PCI_BASE_ADDRESS_0 + (i << 2);
+	    unsigned long base;
+	    u32 size, pbase;
+
+	    base = pdev->base_address[i];
+
+	    if (!base)
+	        continue;
+
+	    io = (base & PCI_BASE_ADDRESS_SPACE)==PCI_BASE_ADDRESS_SPACE_IO;
+
+	    pci_read_config_dword(pdev, breg, &pbase);
+	    pci_write_config_dword(pdev, breg, 0xffffffff);
+	    pci_read_config_dword(pdev, breg, &size);
+	    pci_write_config_dword(pdev, breg, pbase);
+
+	    if (io) {
+		size &= PCI_BASE_ADDRESS_IO_MASK;
+		base &= PCI_BASE_ADDRESS_IO_MASK;
+	    } else {
+		size &= PCI_BASE_ADDRESS_MEM_MASK;
+		base &= PCI_BASE_ADDRESS_MEM_MASK;
+	    }
+	    size = ~(size) + 1;
+
+	    if ( (base < mybase+mysize-1 && base+size-1 >= mybase)
+	    	 || (mybase < base+size-1 && mybase+mysize-1 >= base) ) {
+		printk("\nPCI resource conflict: %lx-%lx overlaps %lx-%lx !\n",
+		    base, base+size-1, mybase, mybase+mysize-1);
+		return 1;	/* conflicting region overlaps */
+	    }
+
+        }
+    }
+
+    return 0;			/* no conflicting region found */
+
+}
+
+
 #ifdef CONFIG_FB_OF
 __initfunc(void atyfb_of_init(struct device_node *dp))
 {
-    unsigned long addr;
+    unsigned long addr, io_base=NULL;
     u8 bus, devfn;
     u16 cmd;
     struct fb_info_aty *info;
-    int i;
+    int i, i_frame, i_regs, i_io, naddr;

     if (device_is_compatible(dp, "ATY,264LTPro")) {
 	/* XXX kludge for now */
@@ -3283,6 +3341,12 @@
     }
     memset(info, 0, sizeof(struct fb_info_aty));

+    /*
+     * Use register set in the little endian aperture regardless of what was set
+     * up in OF or the PCI registers for MMIO. We could use the registers in the
+     * big endian aperture as well (at least on some LTPro), or set up a separate
+     * PCI mapping. Seems to work either way (again, on my Lombard) - MSch.
+     */
     info->ati_regbase_phys = 0x7ff000+addr;
     info->ati_regbase = (unsigned long)ioremap(info->ati_regbase_phys,
 						   0x2000);
@@ -3296,8 +3360,49 @@
     info->ati_regbase_phys += 0xc00;
     info->ati_regbase += 0xc00;

-    /* enable memory-space accesses using config-space command register */
+    /* search PCI config space for VRAM, IO and MMIO regions */
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
+	    if (io) {
+		size &= ~1;
+		pbase &= ~1;
+		i_io = i;
+	    }
+
+	    size = ~(size) + 1;
+
+	    if (size == 0)
+	    	break;
+
+	    if (!base) {
+		dp->addrs[i].address = pbase;
+		dp->addrs[i].size = size;
+	    }
+	    if (pbase == addr) {
+		i_frame = i;
+	    } else if (size == 0x1000) {
+		i_regs = i;
+		io_base = pbase;
+            }
+	}
+
+	naddr = i;
+
+        /* enable memory-space accesses using config-space command register */
 	pcibios_read_config_word(bus, devfn, PCI_COMMAND, &cmd);
 	if (cmd != 0xffff) {
 	    cmd |= PCI_COMMAND_MEMORY;
@@ -3318,6 +3423,105 @@
 	    printk("atyfb_init: ioremap() returned NULL\n");
 	    kfree(info);
 	    return;
+    }
+
+    /*
+     * Fix MMIO mapping if MMIO and VRAM PCI mappings set up by MacOS overlap - MSch.
+     * Note that we can't move the VRAM base address to the BE aperture (this would move the whole
+     * VRAM region, not resize it) so it's easier to remap MMIO someplace else.
+     */
+    if ( (dp->addrs[i_frame].address < dp->addrs[i_regs].address+dp->addrs[i_regs].size
+	 && dp->addrs[i_frame].address+dp->addrs[i_frame].size >= dp->addrs[i_regs].address)
+    	 || (dp->addrs[i_regs].address < dp->addrs[i_frame].address+dp->addrs[i_frame].size
+    	    && dp->addrs[i_regs].address+dp->addrs[i_regs].size >= dp->addrs[i_frame].address) ) {
+
+	    struct pci_dev *pdev = pci_find_slot(bus, devfn);
+	    int io, breg = PCI_BASE_ADDRESS_0 + (i_regs << 2);
+	    int flags;
+	    unsigned long base;
+	    u32 size, pbase, new;
+
+	    base = dp->addrs[i_regs].address;
+
+	    pcibios_read_config_dword(bus, devfn, breg, &pbase);
+	    pcibios_write_config_dword(bus, devfn, breg, 0xffffffff);
+	    pcibios_read_config_dword(bus, devfn, breg, &size);
+	    pcibios_write_config_dword(bus, devfn, breg, pbase);
+
+	    io = (pbase & PCI_BASE_ADDRESS_SPACE)==PCI_BASE_ADDRESS_SPACE_IO;
+	    flags = (pbase & PCI_BASE_ADDRESS_MEM_MASK);
+
+	    if (io) {
+		size &= ~1;
+		pbase &= ~1;
+	    }
+	    size = ~(size) + 1;
+
+	    printk("atyfb: region %d ofbase 0x%lx breg %d io %d pbase 0x%lx size 0x%lx overlaps VRAM ",
+		i_regs, base, breg, io, pbase, size);
+
+	    /*
+	     * Best guess: try address used by OF/yaboot, check for overlap with existing devices!
+	     */
+	    new = 0x80881000;
+
+	    if (atyfb_check_overlap(pdev, new, size)) {
+		/*
+		 * Something overlaps our new mapping. Move MMIO before frame buffer and past I/O for now.
+		 * Need to walk PCI resources to find guaranteed free spot (currently we bail out when our
+		 * next best guess is taken as well).
+		 */
+		if (dp->addrs[i_io].address+dp->addrs[i_io].size+dp->addrs[i_regs].size < dp->addrs[i_frame].address) {
+		    new = (dp->addrs[i_io].address&0xff000000) | (dp->addrs[i_regs].address&0x00ffffff);
+		} else {
+		    new = (dp->addrs[i_frame].address+dp->addrs[i_frame].size);
+		}
+		if (atyfb_check_overlap(pdev, new, size)) {
+		    printk("\natyfb: can't resolve overlap, bailing out!\n");
+		    /* gotos are evil */
+		    new = base;
+		}
+	    }
+
+	    new |= flags & 0x0f;
+
+	    pcibios_write_config_dword(bus, devfn, breg, new);
+
+	    pcibios_read_config_dword(bus, devfn, breg, &pbase);
+	    pcibios_write_config_dword(bus, devfn, breg, 0xffffffff);
+	    pcibios_read_config_dword(bus, devfn, breg, &size);
+	    pcibios_write_config_dword(bus, devfn, breg, pbase);
+
+	    if (new != pbase)
+	    	printk("atyfb: failed to remap MMIO region! \n");
+
+	    /* update PCI struct */
+	    if (!pdev)
+	    	printk("atyfb: no pci_dev registered for device!\n");
+	    else
+	    	pdev->base_address[i_regs] = pbase;
+
+	    io = (pbase & PCI_BASE_ADDRESS_SPACE)==PCI_BASE_ADDRESS_SPACE_IO;
+	    flags = (pbase & ~PCI_BASE_ADDRESS_MEM_MASK);
+
+	    if (io) {
+		size &= ~1;
+		pbase &= ~1;
+	    }
+	    size = ~(size) + 1;
+
+	    printk(" - reassigned to pbase 0x%lx size 0x%lx ! \n", pbase, size);
+
+	    /* update OF device tree */
+	    dp->addrs[i_regs].address = pbase;
+
+	    /*
+	     * Note: we only fixed up PCI config and brought the OF device tree
+	     * in line with the new PCI config. regbase still is mapped to the original
+	     * location in the LE aperture which overlaps with the full (LE and BE)
+	     * VRAM. If someone at xfree ever starts to check if regbase falls within
+	     * the PCI region of VRAM, slap them silly - MSch.
+	     */
     }

     if (!aty_init(info, dp->full_name)) {

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
