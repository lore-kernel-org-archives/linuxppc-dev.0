Date: Tue, 8 Feb 2000 17:47:55 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Retrace
In-Reply-To: <20000208155637.001939@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10002081638320.1866-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 8 Feb 2000, Benjamin Herrenschmidt wrote:

> On Tue, Feb 8, 2000, Gabriel Paubert <paubert@iram.es> wrote:
>
> >On x86 you have /dev/port which is disabled on PPC. I once or twice
> >suggested (but was greeted with a deafening silence) that we could
> >resurrect it and add an mmap method so that privileged programs may access
> >I/O ports with:
> >
> >	io_fd= open("/dev/port", O_RDWR);
> >	iobase=mmap(0, device_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> >			io_fd, device_base);
> >
> >
> >> Unfortunately, with weird host bridges like Apple Uni-N (that has 3
> >> busses with 3 different io bases but the same bus number), it's almost
> >> impossible to get it correct, or eventually by parsing /proc/device-tree.
> >
> >Not a problem if device_base is unique, you have to check that
> >device_base+device_size fits within one area. It must be unique at one
> >point to distinguish them from the processor perspective.
>
> device_base may not be unique. Actually, that depends what is device_base
> and how it's retreived. But for example, reading the BARs can give you
> identical io base for devices on different sub-bridges, the distinction
> beeing done by the iobase of the bridge itself.

Indeed. This is becoming quite a mess: actually in 2.3 I had an idea some
time ago in which the resource tree would describe all the iobase and
othre translation offsets. I have however only booted a machine with this
patch on my PC where it is not actually used (so it compiles but not much
more). The idea is that for every resource you get the value to use with
ioremap or in/out through a small function:

	deviobase = ioport_ptr(dev->resource[0]);

	data = inl(deviobase+register_offset);

and for an MMIO mapped area:

	mmioptr = ioremap(ioremap_ptr(dev->resource[1]));

	data = readl(mmioptr+register_offset);

The first case has one interesting side effect: inl and outl no more have
to systematically add iobase on every I/O access, decreasing code bloat
(just objdump the i8259.o and look at the code for i8259_init: iobase is
reloaded from memory for every out instruction, i.e. about 10 times
which is useless bloat): e

# objdump arch/ppc/kernel/i8259.o  --disassemble --reloc
[snipped]
00000000 <i8259_init>:
   0:   94 21 ff f0     stwu    r1,-16(r1)
   4:   7c 08 02 a6     mflr    r0
   8:   90 01 00 14     stw     r0,20(r1)
   c:   3d 60 00 00     lis     r11,0
                        e: R_PPC_ADDR16_HA      isa_io_base
  10:   81 2b 00 00     lwz     r9,0(r11)
                        12: R_PPC_ADDR16_LO     isa_io_base
  14:   39 00 00 11     li      r8,17
  18:   99 09 00 20     stb     r8,32(r9)
  1c:   7c 00 06 ac     eieio
  20:   81 4b 00 00     lwz     r10,0(r11)
                        22: R_PPC_ADDR16_LO     isa_io_base
  24:   38 00 00 00     li      r0,0
  28:   98 0a 00 21     stb     r0,33(r10)
  2c:   7c 00 06 ac     eieio
  30:   81 2b 00 00     lwz     r9,0(r11)
                        32: R_PPC_ADDR16_LO     isa_io_base
  34:   38 00 00 04     li      r0,4
  38:   98 09 00 21     stb     r0,33(r9)
  3c:   7c 00 06 ac     eieio
  40:   81 4b 00 00     lwz     r10,0(r11)
                        42: R_PPC_ADDR16_LO     isa_io_base
  44:   38 e0 00 01     li      r7,1
  48:   98 ea 00 21     stb     r7,33(r10)
  4c:   7c 00 06 ac     eieio
  50:   81 2b 00 00     lwz     r9,0(r11)
                        52: R_PPC_ADDR16_LO     isa_io_base
  54:   99 09 00 a0     stb     r8,160(r9)
  58:   7c 00 06 ac     eieio
  5c:   81 4b 00 00     lwz     r10,0(r11)
                        5e: R_PPC_ADDR16_LO     isa_io_base
  60:   38 00 00 08     li      r0,8
  64:   98 0a 00 a1     stb     r0,161(r10)
  68:   7c 00 06 ac     eieio
  6c:   81 0b 00 00     lwz     r8,0(r11)
                        6e: R_PPC_ADDR16_LO     isa_io_base
  70:   38 00 00 02     li      r0,2
  74:   98 08 00 a1     stb     r0,161(r8)
  78:   7c 00 06 ac     eieio
  7c:   81 2b 00 00     lwz     r9,0(r11)
                        7e: R_PPC_ADDR16_LO     isa_io_base
  80:   98 e9 00 a1     stb     r7,161(r9)
  84:   7c 00 06 ac     eieio
  88:   3d 00 00 00     lis     r8,0

etc...

Done the right way, every outb would be 3 instead of 4 instructions.
That's even worse for PCI drivers, since each out often involves loading
a base address from a descriptor, fetching I/O base and performing an
addition (3 instructions at least) for every I/O accesses. That's bloat...

> The fact is that macos don't care, since it's completely based on the
> device-tree, MacOS-drivers call in/out functions that use the base
> address of the parent bridge.

In this case the only solution is to build in knowledge of the actual tree
in the resource tree on linux 2.3. That's what my patch tries to do but I
never tried to actually implement it fully...

> I have in mind the possibility of defining fake bridges in the kernel to
> work around the Uni-N problem as a whole, but this leads to a bunch of
> other problems (like desynchro with the device-tree, which can be
> annoying for other things) and I'm not familiar enough with 2.3.x PCI
> layer yet.
>
> What's the usual method used by X-like apps to get the base of a device ?
> /proc/pci ?
>
> We could also have /proc/pci export "fixed" bases that already take into
> account the iobase of the bridge.

And this would lead to a mess when you want to find free space to allocate
new base registers. You have to decide whether the tree describes physical
addresses the side of the device or the side of the CPU, Martin Mares
claimed that we should always use CPU view. I have come to the
conclusion that this is not the right way (especially if you want dynamic
allocation to work and to stay simple).

> We are in a realm where I lack experience with Linux to be able to tell
> which solution is better (and have more chances of beeing accepted ;)

I don't know if my solution has any chance of being accepted by people who
think that there is only one arch out there (guess which one)... Anyway
the starting point of my idea is appended. The you should actually map
everything from the single top address space to describe your system and
could parse /proc/iomem to find your device (there are 2 separate top
address space /proc/iomem and /proc/ioports only on x86, on other archs
/proc/ioports coould be a subset of /proc/iomem but this is not even
guaranteed to be sufficient since you may have 2 separate branches mapping
PCI I/O space from /proc/iomem). Note that the next step is to insert
lines in /proc/iomem which describe nontransparent mappings with an easily
parsed format...

Ok, enough for this post.

	Gabriel.

Common subdirectories: linux-2.3/include/linux/byteorder and lx23local/include/linux/byteorder
diff -u linux-2.3/include/linux/ioport.h lx23local/include/linux/ioport.h
--- linux-2.3/include/linux/ioport.h	Wed Dec  8 16:20:59 1999
+++ lx23local/include/linux/ioport.h	Mon Dec 13 18:00:55 1999
@@ -35,6 +35,7 @@
 #define IORESOURCE_RANGELENGTH	0x00008000
 #define IORESOURCE_SHADOWABLE	0x00010000

+#define IORESOURCE_NONTRANSPARENT 0x10000000
 #define IORESOURCE_UNSET	0x20000000
 #define IORESOURCE_AUTO		0x40000000
 #define IORESOURCE_BUSY		0x80000000	/* Driver has marked this resource busy */
Common subdirectories: linux-2.3/include/linux/lockd and lx23local/include/linux/lockd
Common subdirectories: linux-2.3/include/linux/nfsd and lx23local/include/linux/nfsd
Common subdirectories: linux-2.3/include/linux/sunrpc and lx23local/include/linux/sunrpc
diff -u linux-2.3/kernel/resource.c lx23local/kernel/resource.c
--- linux-2.3/kernel/resource.c	Thu Dec 16 10:28:06 1999
+++ lx23local/kernel/resource.c	Thu Dec 16 10:34:42 1999
@@ -43,6 +43,7 @@
 		buf += sprintf(buf, fmt + offset, from, to, name);
 		if (entry->child)
 			buf = do_resource_list(entry->child, fmt, offset-2, buf, end);
+		if (entry->flags & IORESOURCE_NONTRANSPARENT) break;
 		entry = entry->sibling;
 	}

@@ -54,11 +55,11 @@
 	char *fmt;
 	int retval;

-	fmt = "        %08lx-%08lx : %s\n";
+	fmt = "            %08lx-%08lx : %s\n";
 	if (root->end < 0x10000)
-		fmt = "        %04lx-%04lx : %s\n";
+		fmt = "            %04lx-%04lx : %s\n";
 	read_lock(&resource_lock);
-	retval = do_resource_list(root->child, fmt, 8, buf, buf + size) - buf;
+	retval = do_resource_list(root->child, fmt, 12, buf, buf + size) - buf;
 	read_unlock(&resource_lock);
 	return retval;
 }
@@ -266,6 +267,40 @@
 	}
 	printk("Trying to free nonexistent resource <%04lx-%04lx>\n", start, end);
 }
+
+unsigned long ioremap_ptr(struct resource * res) {
+	unsigned long addr = res->start;
+	while (res = res->parent) {
+		if (res->flags & IORESOURCE_NONTRANSPARENT) {
+			addr += res->parent->start - res->start;
+		}
+	}
+	return addr;
+}
+
+unsigned long iospace_ptr(struct resource * res) {
+	unsigned long addr = res->start;
+	while (res = res->parent) {
+		if (res->flags & IORESOURCE_NONTRANSPARENT) {
+			/* Using the sibling is a kludge to avoid
+			 * adding fields to the resource struct.
+			 * Non transparent resources are not suppposed
+			 * to have siblings since they are inserted to
+			 * describe a mapping, so the sibling field is used
+			 * as the kernel virtual address at which the
+			 * I/O space is permanently mapped.
+			 */
+			if (res->sibling) {
+				addr += (unsigned long) res->sibling
+				  - res->start;
+				break;
+			}
+			addr += res->parent->start - res->start;
+		}
+	}
+	return addr;
+}
+

 /*
  * Called from init/main.c to reserve IO ports.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
