Message-ID: <3E355AD7.50300@control.lth.se>
Date: Mon, 27 Jan 2003 17:14:15 +0100
From: Anders Blomdell <anders.blomdell@control.lth.se>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: PrPMC800 NON-Monarch patch
Content-Type: multipart/mixed;
 boundary="------------020708090909080007050308"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------020708090909080007050308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

To whom do I send pathes to the linuxppc_2_4_devel tree?

Enclosed in this mail is a small patch that [partly] enables the
PrPMC800 to run in NON-MONARCH mode on a PCI system. The following has
been done:

   1. arch/ppc/kernel/harrier.c:
        consider PCI/PPC memory/IO size mismatches non-fatal,
        this will probably be changed back when all the memory
        handling is in place.

   2. arch/ppc/platforms/prpmc800.h:
        added some comments and a utility macro for harrier register
        access.

   3. arch/ppc/platforms/prpmc800_pci.c:
        added some extra interrupt mappings to 'prpmc_map_irq(...)', this
        routine needs major overhaul though...

        added a 'prpmc800_find_hostbridge()' function to find a local
        harrier chip, this was previously done by reading from
        PCI_DEVFN(0,0), which does not work in the NON-MONARCH case.

        added a NON-MONARCH branch to the 'prpmc800_find_hostbridge(...)'
        that takes care of (some) of the issues related to not being
        in control of the PCI bus.

   4. include/asm-ppc/harrier.h:
        added some new defines

Regards

Anders Blomdell

--------------020708090909080007050308
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="2003-01-27.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2003-01-27.patch"

diff -urb orig.2003-01-27/arch/ppc/kernel/harrier.c 2003-01-27/arch/ppc/kernel/harrier.c
--- orig.2003-01-27/arch/ppc/kernel/harrier.c	Sun Jan 26 21:08:03 2003
+++ 2003-01-27/arch/ppc/kernel/harrier.c	Mon Jan 27 16:37:16 2003
@@ -70,7 +70,7 @@
 	     (hose->io_space.end - hose->io_space.start))) {
 		printk("harrier_init: %s\n",
 			"PPC and PCI memory or I/O space sizes don't match");
-		return -1;
+		/* return -1; */
 	}

 	if ((processor_mpic_base & 0xfffc0000) != processor_mpic_base) {


diff -urb orig.2003-01-27/arch/ppc/platforms/prpmc800.h 2003-01-27/arch/ppc/platforms/prpmc800.h
--- orig.2003-01-27/arch/ppc/platforms/prpmc800.h	Sun Jan 26 21:09:31 2003
+++ 2003-01-27/arch/ppc/platforms/prpmc800.h	Mon Jan 27 14:57:26 2003
@@ -26,9 +26,12 @@
 #ifndef __ASMPPC_PRPMC800_H
 #define __ASMPPC_PRPMC800_H

+/* These two addresses depend on OTAD3/OTOF3/OTAT3 being correct */
 #define PRPMC800_PCI_CONFIG_ADDR		0xfe000cf8
 #define PRPMC800_PCI_CONFIG_DATA		0xfe000cfc

+/* The following addresses may be used for MONARCHS, otherwise
+ * we have better use what is given to us. */
 #define PRPMC800_PROC_PCI_IO_START		0xfe400000U
 #define PRPMC800_PROC_PCI_IO_END		0xfeefffffU
 #define PRPMC800_PCI_IO_START			0x00000000U
@@ -52,5 +55,7 @@

 #define PRPMC800_BASE_BAUD			1843200

+/* Utility macro to access harrier registers from XCSR base */
+#define HARRIER_REG(name) (PRPMC800_HARRIER_XCSR_BASE+HARRIER_##name##_OFF)

 #endif /* __ASMPPC_PRPMC800_H */


diff -urb orig.2003-01-27/arch/ppc/platforms/prpmc800_pci.c 2003-01-27/arch/ppc/platforms/prpmc800_pci.c
--- orig.2003-01-27/arch/ppc/platforms/prpmc800_pci.c	Sun Jan 26 21:08:44 2003
+++ 2003-01-27/arch/ppc/platforms/prpmc800_pci.c	Mon Jan 27 16:44:13 2003
@@ -43,17 +43,72 @@
 		{12,	0,	0,	0},  /* IDSEL 14 - Ethernet, base */
 		{0,	0,	0,	0},  /* IDSEL 15 - unused */
 		{10,	11,	12,	9},  /* IDSEL 16 - PMC A1, PMC1 */
+		/* IDSEL 16 is also ADC-PMC2 1A*/
 		{10,	11,	12,	9},  /* IDSEL 17 - PrPMC-A-B, PMC2-B */
 		{11,	12,	9,	10}, /* IDSEL 18 - PMC A1-B, PMC1-B */
+		/* IDSEL 18 is also ADC-PMC2 2A*/
 		{0,	0,	0,	0},  /* IDSEL 19 - unused */
 		{9,	10,	11,	12}, /* IDSEL 20 - P2P Bridge */
 		{11,	12,	9,	10}, /* IDSEL 21 - PMC A2, carrier */
 		{12,	9,	10,	11}, /* IDSEL 22 - PMC A2-B, carrier */
+		// FIXME: We need some better way to handle this mapping
+		// in a generic way. How can one find out what kind of
+		// carrier we are in???
+		{ 10 , 11, 12, 9 }, /* IDSEL 23 ADC-PMC2 1B */
+		{ 10 , 11, 12, 9 }, /* IDSEL 24 ADC-PMC2 2B */
+/*
+# ADC-PMC2 1 & 2
+1 PCI Function 00/10/0 (00008000) ID/Revision.........=480B1057/02 (Inactive)
+2 PCI Function 00/12/0 (00009000) ID/Revision.........=480B1057/02 (Inactive)
+1 PCI Function 00/17/0 (0000B800) ID/Revision.........=12098086/09 (Inactive)
+2 PCI Function 00/18/0 (0000C000) ID/Revision.........=12098086/09 (Inactive)
+
+# PrPMC carrier
+PCI Function 00/00/0 (00000000) ID/Revision.........=480B1057/02
+PCI Function 00/11/0 (00008800) ID/Revision.........=12098086/09
+PCI Function 00/14/0 (0000A000) ID/Revision.........=00261011/05
+PCI Function 01/02/0 (00011000) ID/Revision.........=12098086/09
+PCI Function 01/05/0 (00012800) ID/Revision.........=12098086/09
+*/
 	};
-	const long min_idsel = 14, max_idsel = 22, irqs_per_slot = 4;
+	const long min_idsel = 14, max_idsel = 24, irqs_per_slot = 4;
 	return PCI_IRQ_TABLE_LOOKUP;
 };

+u32 __init
+prpmc800_find_hostbridge(void) {
+  /*
+   * Scan the PCI bus until we find our own hostbridge.
+   * This is probably unnecessary, since we could just as well
+   * check if the Harrier is available from the PowerPC bus...
+   */
+  u32 result, id;
+  int bus, slot;
+
+  result = 0;
+
+  for (bus = 0 ; bus < 255 ; bus++) {
+    /* Probably overkill to search beyond bus 0... */
+    for (slot = 0 ; slot < 32 ; slot++) {
+      early_read_config_dword(0, bus, PCI_DEVFN(slot,0), PCI_VENDOR_ID, &id);
+      if (id == HARRIER_VEND_DEV_ID) {
+       /* Check if this is our harrier chip, this is done by
+        * reading the PSTA register from the PCI side and checking
+	* the LBA (Loop Back Access) bit.
+        */
+	u8 psta;
+
+	early_read_config_byte(0, bus, PCI_DEVFN(slot,0), HARRIER_PSTA_PCI_OFF,
+			       &psta);
+	if (psta & HARRIER_PSTA_LBA_MASK) {
+	  result = id;
+	}
+      }
+    }
+  }
+  return result;
+}
+
 void __init
 prpmc800_find_bridges(void)
 {
@@ -68,6 +123,10 @@
 	hose->last_busno = 0xff;
 	hose->pci_mem_offset = PRPMC800_PCI_PHY_MEM_OFFSET;

+	if (in_8((u8 *)HARRIER_REG(MISC_CSR)) & HARRIER_SCON_MASK) {
+	  /* On a monarch we are free to decide the pci mapping ourselves */
+	  printk("PrPMC800 MONARCH\n");
+
 	pci_init_resource(&hose->io_resource,
 		PRPMC800_PCI_IO_START,
 		PRPMC800_PCI_IO_END,
@@ -89,13 +148,84 @@
 	setup_indirect_pci(hose,
 			PRPMC800_PCI_CONFIG_ADDR,
 			PRPMC800_PCI_CONFIG_DATA);
+	} else {
+	  /* On a non-monarch we have to behave, so setup pci to mimic
+	   * what's already in the harrier */
+
+	  printk("PrPMC800 NON-MONARCH\n");
+	  /*
+	   * Since the PPC7-Bug does stray accesses into PCI I/O space,
+	   * that might lead to hangups on the host system, we warn if
+	   * PCI I/O space is mapped (since that indicates there is a
+	   * risk that resources on the PCI bus gets corrupted), then
+	   * we happily enable the same PCI I/O space, while (temporarily)
+	   * disabling all other outbound translations.
+	   *
+	   * But if  OTAD3/OTAT3/OTOF3 are not properly initialized, we will
+	   * not be able to scan the PCI bus...
+	   */
+	  if (in_be32((u32 *)HARRIER_REG(OTOF3)) & HARRIER_OTOF_ENABLE) {
+	    printk("PCI-I/O was enabled, host should disable OTOF3/OTAT3,\n");
+	    printk("or strange things may happen when using PPC7-Bug.\n");
+	  }
+	  out_be32((u32 *)HARRIER_REG(OTAD0), 0);
+	  out_be32((u32 *)HARRIER_REG(OTOF0), 0);
+	  out_be32((u32 *)HARRIER_REG(OTAD1), 0);
+	  out_be32((u32 *)HARRIER_REG(OTOF1), 0);
+	  out_be32((u32 *)HARRIER_REG(OTAD2), 0);
+	  out_be32((u32 *)HARRIER_REG(OTOF2), 0);
+	  out_be32((u32 *)HARRIER_REG(OTAD3), 0xfe00fe00);
+	  out_be32((u32 *)HARRIER_REG(OTOF3), 0x02000080);
+
+	  {
+	    /* Read the current PCI mappings, and setup resources to
+	       agree with this */
+	    int i;
+
+	    for (i = 0 ; i < 4 ; i++) {
+	      u32 itat = in_le32((u32 *)(HARRIER_REG(ITAT0)+i*8));
+	      if (itat & HARRIER_ITAT_ENABLE) {
+		u32 itsz = in_le32((u32 *)(HARRIER_REG(ITSZ0)+i*8));
+		u32 itbar = in_le32((u32 *)(HARRIER_REG(ITBAR0)+i*4));
+		if (itat & HARRIER_ITAT_MEMORY) {
+		  u32 pci_start = itbar & HARRIER_ITBAR_BASE_MASK;
+		  u32 pci_end =
+		    pci_start + (4096<<(itsz&HARRIER_ITSZ_SIZE_MASK));
+		  pci_init_resource(&hose->mem_resources[0],
+				    pci_start,
+				    pci_end,
+				    IORESOURCE_MEM,
+				    "PCI host bridge");
+		  hose->mem_space.start = pci_start;
+		  hose->mem_space.end = pci_end;
+		  printk("PrPMC800 PCI memory %d: %x-%x\n",
+			 i, pci_start, pci_end);
+		} else {
+		  printk("PrPMC800 PCI io %d: %x\n",
+			 i, itat);
+		}
+	      }
+	    }
+	  }
+
+	  pci_init_resource(&hose->io_resource,
+			    PRPMC800_PCI_IO_START,
+			    PRPMC800_PCI_IO_END,
+			    IORESOURCE_IO,
+			    "PCI host bridge");
+
+	  hose->io_space.start = PRPMC800_PCI_IO_START;
+	  hose->io_space.end = PRPMC800_PCI_IO_END;
+	  hose->io_base_virt = (void *)PRPMC800_ISA_IO_BASE;
+
+	  setup_indirect_pci(hose,
+			     PRPMC800_PCI_CONFIG_ADDR,
+			     PRPMC800_PCI_CONFIG_DATA);
+
+	}

 	/* Get host bridge vendor/dev id */
-	early_read_config_dword(hose,
-				0,
-				PCI_DEVFN(0,0),
-				PCI_VENDOR_ID,
-				&host_bridge);
+	host_bridge = prpmc800_find_hostbridge();

 	switch (host_bridge) {
 	case HARRIER_VEND_DEV_ID:


diff -urb orig.2003-01-27/include/asm-ppc/harrier.h 2003-01-27/include/asm-ppc/harrier.h
--- orig.2003-01-27/include/asm-ppc/harrier.h	Mon Jan 27 12:51:29 2003
+++ 2003-01-27/include/asm-ppc/harrier.h	Mon Jan 27 16:26:37 2003
@@ -21,6 +21,10 @@

 #define	HARRIER_VEND_DEV_ID			0x480b1057

+/* Harrier PCI status register */
+#define HARRIER_PSTA_PCI_OFF       		0x83
+#define HARRIER_PSTA_LBA_MASK			0x80
+
 /*
  * Define outbound register offsets.
  */
@@ -33,13 +37,29 @@
 #define HARRIER_OTAD3_OFF			0x238
 #define HARRIER_OTOF3_OFF			0x23c

+#define HARRIER_OTOF_ENABLE                     0x80
+
 /*
  * Define inbound register offsets.
  */
+#define HARRIER_ITBAR0_OFF                     	0x314
+#define HARRIER_ITBAR1_OFF                     	0x318
+#define HARRIER_ITBAR2_OFF                     	0x31c
+#define HARRIER_ITBAR3_OFF                     	0x320
 #define HARRIER_ITSZ0_OFF			0x348
+#define HARRIER_ITAT0_OFF                      	0x34c
 #define HARRIER_ITSZ1_OFF			0x350
+#define HARRIER_ITAT1_OFF                      	0x354
 #define HARRIER_ITSZ2_OFF			0x358
+#define HARRIER_ITAT2_OFF                      	0x35c
 #define HARRIER_ITSZ3_OFF			0x360
+#define HARRIER_ITAT3_OFF                      	0x364
+
+#define HARRIER_ITBAR_BASE_MASK                 0xffff0000
+#define HARRIER_ITAT_ENABLE                     0x80
+#define HARRIER_ITAT_MEMORY                     0x40
+#define HARRIER_ITSZ_SIZE_MASK                  0x0f
+#define HARRIER_ITSZ_OFFSET_MASK                0xffff0000

 /*
  * Define the Memory Controller register offsets.
@@ -65,8 +85,10 @@
 #define HARRIER_UCTL_OFF			0xd0
 #define HARRIER_XTAL64_MASK			0x02

+/* Should accesses (and masks) to the MCSR really be 8 bit? */
 #define HARRIER_MISC_CSR_OFF			0x1c
 #define HARRIER_RSTOUT_MASK			0x01
+#define HARRIER_SCON_MASK                      0x08

 #define HARRIER_MBAR_OFF			0xe0
 #define HARRIER_MPIC_CSR_OFF			0xe4

--------------020708090909080007050308--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
