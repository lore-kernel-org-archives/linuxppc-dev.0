Date: Tue, 27 Nov 01 14:36:12 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111272236.AA25257@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: A little fix
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK, I goofed. It's struct bi_record, not struct bootinfo. I have no idea how I
could have screwed it up and how could the compiler have missed it. Is it
another gcc extension to allow struct never_heard_of * as OK? The patch below
fixes it. It also fixes a remaining bit of the kernel=>platforms rename.

MS

diff --minimal -Nru a/arch/ppc/boot/common/misc-simple.c b/arch/ppc/boot/common/misc-simple.c
--- a/arch/ppc/boot/common/misc-simple.c	Tue Nov 27 14:21:26 2001
+++ b/arch/ppc/boot/common/misc-simple.c	Tue Nov 27 14:21:26 2001
@@ -58,13 +58,13 @@
 extern void gunzip(void *, int, unsigned char *, int *);
 extern void setup_legacy(void);

-struct bootinfo *
+struct bi_record *
 decompress_kernel(unsigned long load_addr, int num_words, unsigned long cksum)
 {
 	int timer = 0;
 	char *cp, ch;
 	struct bi_record *rec;
-	struct bootinfo *birecs;
+	struct bi_record *birecs;

 	setup_legacy();
 	com_port = serial_init(0, NULL);
diff --minimal -Nru a/arch/ppc/platforms/adir_setup.c b/arch/ppc/platforms/adir_setup.c
--- a/arch/ppc/platforms/adir_setup.c	Tue Nov 27 14:21:26 2001
+++ b/arch/ppc/platforms/adir_setup.c	Tue Nov 27 14:21:26 2001
@@ -181,7 +181,7 @@
 	/*
 	 * On the Adirondack we use bi_recs and pass the pointer to them in R3.
 	 */
-	parse_bootinfo((struct bootinfo *) (r3 + KERNELBASE));
+	parse_bootinfo((struct bi_record *) (r3 + KERNELBASE));

 	/* Remember, isa_io_base is virtual but isa_mem_base is physical! */
 	isa_io_base = ADIR_PCI32_VIRT_IO_BASE;
diff --minimal -Nru a/arch/ppc/platforms/k2.h b/arch/ppc/platforms/k2.h
--- a/arch/ppc/platforms/k2.h	Tue Nov 27 14:21:26 2001
+++ b/arch/ppc/platforms/k2.h	Tue Nov 27 14:21:26 2001
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
diff --minimal -Nru a/arch/ppc/platforms/k2_setup.c b/arch/ppc/platforms/k2_setup.c
--- a/arch/ppc/platforms/k2_setup.c	Tue Nov 27 14:21:26 2001
+++ b/arch/ppc/platforms/k2_setup.c	Tue Nov 27 14:21:26 2001
@@ -346,7 +346,7 @@
 void __init platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7)
 {
-	parse_bootinfo((struct bootinfo *) (r3 + KERNELBASE));
+	parse_bootinfo((struct bi_record *) (r3 + KERNELBASE));

 	isa_io_base = K2_ISA_IO_BASE;
 	isa_mem_base = K2_ISA_MEM_BASE;

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
