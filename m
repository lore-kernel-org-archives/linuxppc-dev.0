Date: Mon, 26 Nov 01 13:01:49 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111262101.AA22136@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Please make K2 Linux bootable without PeeMON again
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

This change in linuxppc_2_4_devel:

ChangeSet@1.666, 2001-11-19 09:10:26-07:00, trini@bill-the-cat.bloom.county
  Remove register magic from platforms which use 'simple'.  A few
  new platforms forgot parse_bootinfo(find_bootinfo()) as well.

  arch/ppc/platforms/k2_setup.c
    1.17 01/11/19 09:10:26 trini@bill-the-cat.bloom.county +0 -15
    Remove cmd_line and initrd register magic.

is a problem for me. On the K2 I do not use zImage or the braindead PeeMON
firmware that it assumes, instead I load vmlinux directly by occult. I need to
continue to able to do this, and I need to keep the interface to vmlinux
register-based so that I can load vmlinux into memory by occult, put the right
values in the right registers, and jump to it. A pointer to bi_recs in a
register is fine, but looking for bi_recs in the magic location isn't. (The
kernel has already been loaded into memory by occult when I get to it, and
without the original ELF header or System.map I cannot determine where will it
look for bi_recs in find_bootinfo.)

The patch below makes the K2 vmlinux expect a pointer to bi_recs in R3 like I
do on the Adirondack and makes the "simple" zImage goo pass a pointer to its
magic bi_recs in R3.

Please either apply this patch or give me some other way to boot Linux on the
K2 without PeeMON. This is the public tree in the free world and it is not
acceptable to force people to use PeeMON, the most developer-hostile ROM
monitor produced by the sickest minds ever.

MS

(Speaking on my own personal behalf only, not on my employer's.)

diff --minimal -Nru a/arch/ppc/boot/common/misc-simple.c b/arch/ppc/boot/common/misc-simple.c
--- a/arch/ppc/boot/common/misc-simple.c	Mon Nov 26 12:33:10 2001
+++ b/arch/ppc/boot/common/misc-simple.c	Mon Nov 26 12:33:10 2001
@@ -57,9 +57,10 @@
 extern unsigned long serial_init(int chan, void *ignored);
 extern void setup_legacy(void);

-void
+struct bootinfo *
 decompress_kernel(unsigned long load_addr, int num_words, unsigned long cksum)
 {
+	struct bootinfo *birecs;

 	int timer = 0;
 	extern unsigned long start;
@@ -158,6 +159,7 @@

 		rec = (struct bi_record *)_ALIGN((unsigned long)(zimage_size) +
 				(1 << 20) - 1, (1 << 20));
+		birecs = rec;

 		rec->tag = BI_FIRST;
 		rec->size = sizeof(struct bi_record);
@@ -183,4 +185,5 @@
 		rec = (struct bi_record *)((unsigned long)rec + rec->size);
 	}
 	puts("Now booting the kernel\n");
+	return(birecs);
 }
diff --minimal -Nru a/arch/ppc/platforms/k2.h b/arch/ppc/platforms/k2.h
--- a/arch/ppc/platforms/k2.h	Mon Nov 26 12:33:10 2001
+++ b/arch/ppc/platforms/k2.h	Mon Nov 26 12:33:10 2001
@@ -1,5 +1,5 @@
 /*
- * arch/ppc/kernel/k2.h
+ * arch/ppc/platforms/k2.h
  *
  * Definitions for SBS K2 board support
  *
@@ -13,8 +13,8 @@
  * option) any later version.
  */

-#ifndef __PPC_KERNEL_K2_H
-#define __PPC_KERNEL_K2_H
+#ifndef __PPC_PLATFORMS_K2_H
+#define __PPC_PLATFORMS_K2_H

 /*
  * SBS K2 definitions
@@ -81,4 +81,4 @@

 #define K2_SYS_SLOT_MASK	0x08

-#endif /* __PPC_KERNEL_K2_H */
+#endif /* __PPC_PLATFORMS_K2_H */
diff --minimal -Nru a/arch/ppc/platforms/k2_pci.c b/arch/ppc/platforms/k2_pci.c
--- a/arch/ppc/platforms/k2_pci.c	Mon Nov 26 12:33:10 2001
+++ b/arch/ppc/platforms/k2_pci.c	Mon Nov 26 12:33:10 2001
@@ -1,5 +1,5 @@
 /*
- * arch/ppc/kernel/k2_pci.c
+ * arch/ppc/platforms/k2_pci.c
  *
  * PCI support for SBS K2
  *
diff --minimal -Nru a/arch/ppc/platforms/k2_setup.c b/arch/ppc/platforms/k2_setup.c
--- a/arch/ppc/platforms/k2_setup.c	Mon Nov 26 12:33:10 2001
+++ b/arch/ppc/platforms/k2_setup.c	Mon Nov 26 12:33:10 2001
@@ -1,5 +1,5 @@
 /*
- * arch/ppc/kernel/k2_setup.c
+ * arch/ppc/platforms/k2_setup.c
  *
  * Board setup routines for SBS K2
  *
@@ -346,7 +346,7 @@
 void __init platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7)
 {
-	parse_bootinfo(find_bootinfo());
+	parse_bootinfo((struct bootinfo *) (r3 + KERNELBASE));

 	isa_io_base = K2_ISA_IO_BASE;
 	isa_mem_base = K2_ISA_MEM_BASE;

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
