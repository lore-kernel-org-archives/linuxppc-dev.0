Date: Tue, 6 Nov 01 13:12:22 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111062112.AA03106@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: PATCH for Adirondack
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

I have some changes for my Adirondack port below. Please check them in. I've
changed the names of IDE IRQ #defines from IDE1/IDE2 to IDE0/IDE1 as that's how
the IDE port connectors are labeled on the board, added the IDE native mode IRQ
to the PCI interrupt map so that IDE can work correctly, and converted the boot
interface to bi_recs. The last change requires the new runlnx, which is already
in my CVS. The new runlnx can boot both old and new kernels controlled by a
boot flag.

MS

diff -Nru a/arch/ppc/kernel/adir.h b/arch/ppc/kernel/adir.h
--- a/arch/ppc/kernel/adir.h	Tue Nov  6 12:39:29 2001
+++ b/arch/ppc/kernel/adir.h	Tue Nov  6 12:39:29 2001
@@ -73,8 +73,8 @@
 #define	ADIR_IRQ_PARALLEL	7
 #define	ADIR_IRQ_VIA_AUDIO	10
 #define	ADIR_IRQ_VIA_USB	11
-#define	ADIR_IRQ_IDE1		14
-#define	ADIR_IRQ_IDE2		15
+#define	ADIR_IRQ_IDE0		14
+#define	ADIR_IRQ_IDE1		15
 #define	ADIR_IRQ_PCI0_INTA	16
 #define	ADIR_IRQ_PCI0_INTB	17
 #define	ADIR_IRQ_PCI0_INTC	18
diff -Nru a/arch/ppc/kernel/adir_pci.c b/arch/ppc/kernel/adir_pci.c
--- a/arch/ppc/kernel/adir_pci.c	Tue Nov  6 12:39:29 2001
+++ b/arch/ppc/kernel/adir_pci.c	Tue Nov  6 12:39:29 2001
@@ -78,7 +78,7 @@
 		 *             A          B          C          D
 		 */
 		{
-    /* south bridge */	PCIIRQ(NONE,      NONE,      VIA_AUDIO, VIA_USB)
+    /* south bridge */	PCIIRQ(IDE0,      NONE,      VIA_AUDIO, VIA_USB)
     /* Ethernet 0 */	PCIIRQ(MBETH0,    MBETH0,    MBETH0,    MBETH0)
     /* PCI0 slot 1 */	PCIIRQ(PCI0_INTB, PCI0_INTC, PCI0_INTD, PCI0_INTA)
     /* PCI0 slot 2 */	PCIIRQ(PCI0_INTC, PCI0_INTD, PCI0_INTA, PCI0_INTB)
diff -Nru a/arch/ppc/kernel/adir_setup.c b/arch/ppc/kernel/adir_setup.c
--- a/arch/ppc/kernel/adir_setup.c	Tue Nov  6 12:39:29 2001
+++ b/arch/ppc/kernel/adir_setup.c	Tue Nov  6 12:39:29 2001
@@ -186,29 +186,10 @@
 platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	      unsigned long r6, unsigned long r7)
 {
-	parse_bootinfo(find_bootinfo());
-
 	/*
-	 * On the Adirondack we pass the memory size in R3 until the Linux/PPC
-	 * maintainers get their act together and fix bi_recs so we can use
-	 * those instead.
+	 * On the Adirondack we use bi_recs and pass the pointer to them in R3.
 	 */
-	boot_mem_size = r3;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	if ( r4 )
-	{
-		initrd_start = r4 + KERNELBASE;
-		initrd_end = r5 + KERNELBASE;
-	}
-#endif
-
-	/* Copy cmd_line parameters */
-	if ( r6 )
-	{
-		*(char *)(r7 + KERNELBASE) = 0;
-		strcpy(cmd_line, (char *)(r6+KERNELBASE));
-	}
+	parse_bootinfo(r3 + KERNELBASE);

 	/* Remember, isa_io_base is virtual but isa_mem_base is physical! */
 	isa_io_base = ADIR_PCI32_VIRT_IO_BASE;
@@ -225,7 +206,7 @@

 	ppc_md.find_end_of_memory = adir_find_end_of_memory;
 	ppc_md.setup_io_mappings = adir_map_io;
-
+
 	ppc_md.restart = adir_restart;
 	ppc_md.power_off = adir_power_off;
 	ppc_md.halt = adir_halt;

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
