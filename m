Date: Mon, 26 Nov 01 12:41:37 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111262041.AA22080@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Adirondack port minor patch
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

Below is a little patch for the Adirondack port. Fixes one compiler warning and
and header comments.

MS

diff --minimal -Nru a/arch/ppc/platforms/adir.h b/arch/ppc/platforms/adir.h
--- a/arch/ppc/platforms/adir.h	Mon Nov 26 12:33:10 2001
+++ b/arch/ppc/platforms/adir.h	Mon Nov 26 12:33:10 2001
@@ -1,13 +1,13 @@
 /*
- * arch/ppc/kernel/adir.h
+ * arch/ppc/platforms/adir.h
  *
  * Definitions for SBS Adirondack board support
  *
  * By Michael Sokolov <msokolov@ivan.Harhan.ORG>
  */

-#ifndef __PPC_KERNEL_ADIR_H
-#define __PPC_KERNEL_ADIR_H
+#ifndef __PPC_PLATFORMS_ADIR_H
+#define __PPC_PLATFORMS_ADIR_H

 /*
  * SBS Adirondack definitions
@@ -92,4 +92,4 @@
 #define	ADIR_IRQ_VT82C686_INTR	30
 #define	ADIR_IRQ_INTERPROC	31

-#endif /* __PPC_KERNEL_ADIR_H */
+#endif /* __PPC_PLATFORMS_ADIR_H */
diff --minimal -Nru a/arch/ppc/platforms/adir_pci.c b/arch/ppc/platforms/adir_pci.c
--- a/arch/ppc/platforms/adir_pci.c	Mon Nov 26 12:33:10 2001
+++ b/arch/ppc/platforms/adir_pci.c	Mon Nov 26 12:33:10 2001
@@ -1,5 +1,5 @@
 /*
- * arch/ppc/kernel/adir_pci.c
+ * arch/ppc/platforms/adir_pci.c
  *
  * PCI support for SBS Adirondack
  *
diff --minimal -Nru a/arch/ppc/platforms/adir_pic.c b/arch/ppc/platforms/adir_pic.c
--- a/arch/ppc/platforms/adir_pic.c	Mon Nov 26 12:33:10 2001
+++ b/arch/ppc/platforms/adir_pic.c	Mon Nov 26 12:33:10 2001
@@ -1,5 +1,5 @@
 /*
- * arch/ppc/kernel/adir_pic.c
+ * arch/ppc/platforms/adir_pic.c
  *
  * Interrupt controller support for SBS Adirondack
  *
diff --minimal -Nru a/arch/ppc/platforms/adir_setup.c b/arch/ppc/platforms/adir_setup.c
--- a/arch/ppc/platforms/adir_setup.c	Mon Nov 26 12:33:10 2001
+++ b/arch/ppc/platforms/adir_setup.c	Mon Nov 26 12:33:10 2001
@@ -1,5 +1,5 @@
 /*
- * arch/ppc/kernel/adir_setup.c
+ * arch/ppc/platforms/adir_setup.c
  *
  * Board setup routines for SBS Adirondack
  *
@@ -181,7 +181,7 @@
 	/*
 	 * On the Adirondack we use bi_recs and pass the pointer to them in R3.
 	 */
-	parse_bootinfo(r3 + KERNELBASE);
+	parse_bootinfo((struct bootinfo *) (r3 + KERNELBASE));

 	/* Remember, isa_io_base is virtual but isa_mem_base is physical! */
 	isa_io_base = ADIR_PCI32_VIRT_IO_BASE;

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
