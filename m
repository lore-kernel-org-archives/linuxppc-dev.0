Message-ID: <383EB081.4C32B8E1@switchboard.ericsson.se>
Date: Fri, 26 Nov 1999 17:08:33 +0100
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: dan@netx4.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: ads fads 860 patch
Content-Type: multipart/mixed;
 boundary="------------904187F94F277E456804AC60"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------904187F94F277E456804AC60
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello all,

Here comes my embedded-2.2.13 patch for ADS and FADS.

The following works:

ADS and FADS NFSROOT.
Only 860 tested.

Does not work:

fec.c with FADS860T.

The following files are not properly changed
they are only changed to be able to compile.... quick fix.

arch/ppc/kernel/ksysm.c
arch/ppc/kernel/setup.c
arch/ppc/mm/init.c

They have nothing to do with ADS / FADS.

Have a nice weekend!

Cheers /

Magnus Damm
--------------904187F94F277E456804AC60
Content-Type: text/plain; charset=us-ascii;
 name="ads_fads_embedded-2_2_13.patch"
Content-Disposition: inline;
 filename="ads_fads_embedded-2_2_13.patch"
Content-Transfer-Encoding: 7bit

diff -ruN embedded_2.2.13_org/arch/ppc/8xx_io/commproc.h embedded-2.2.13/arch/ppc/8xx_io/commproc.h
--- embedded_2.2.13_org/arch/ppc/8xx_io/commproc.h	Sat Oct 23 01:14:48 1999
+++ embedded-2.2.13/arch/ppc/8xx_io/commproc.h	Fri Nov 26 16:10:00 1999
@@ -457,6 +457,33 @@
 #define SICR_ENET_CLKRT	((uint)0x0000003d)
 #endif
 
+#if defined(CONFIG_ADS) || defined(CONFIG_FADS)
+
+/*
+ * The Motorola (F)ADS boards has got ethernet on SCC1.
+ */
+
+#define PA_ENET_RXD	((ushort)0x0001)
+#define PA_ENET_TXD	((ushort)0x0002)
+
+#define PA_ENET_TCLK	((ushort)0x0100)
+#define PA_ENET_RCLK	((ushort)0x0200)
+#define PB_ENET_TENA	((ushort)0x00001000)
+
+#define PC_ENET_CLSN	((ushort)0x0010)
+#define PC_ENET_RENA	((ushort)0x0020)
+
+#define SICR_ENET_MASK	((uint)0x000000ff)
+#define SICR_ENET_CLKRT	((uint)0x0000002c) // T=CLK1, R=CLK2
+
+/* 68160 PHY control */
+
+#define PC_ENET_ETHLOOP ((ushort)0x0800)
+#define PC_ENET_TPFLDL  ((ushort)0x0400)
+#define PC_ENET_TPSQEL  ((ushort)0x0200)
+
+#endif
+
 /* SCC Event register as used by Ethernet.
 */
 #define SCCE_ENET_GRA	((ushort)0x0080)	/* Graceful stop complete */
diff -ruN embedded_2.2.13_org/arch/ppc/8xx_io/enet.c embedded-2.2.13/arch/ppc/8xx_io/enet.c
--- embedded_2.2.13_org/arch/ppc/8xx_io/enet.c	Fri Oct 22 23:24:13 1999
+++ embedded-2.2.13/arch/ppc/8xx_io/enet.c	Fri Nov 26 15:40:21 1999
@@ -981,6 +981,23 @@
 	immap->im_ioport.iop_pcdat &= ~PC_BSE_LOOPBACK;
 #endif
 
+#if defined(CONFIG_ADS) || defined(CONFIG_FADS)
+	cp->cp_pbpar |= PB_ENET_TENA;
+	cp->cp_pbdir |= PB_ENET_TENA;
+
+        /* Port C is used to control the PHY, 68160.			
+	*/		
+        immap->im_ioport.iop_pcdir |=					
+	  (PC_ENET_ETHLOOP | PC_ENET_TPFLDL | PC_ENET_TPSQEL);		
+									
+        immap->im_ioport.iop_pcdat |= PC_ENET_TPFLDL;			
+        immap->im_ioport.iop_pcdat &= ~(PC_ENET_ETHLOOP | PC_ENET_TPSQEL);
+
+	/* Enable the PHY in Board Control Status Register 1 */
+
+        *((uint *)BCSR1) &= ~BCSR1_ETHEN;       
+#endif
+
 	dev->base_addr = (unsigned long)ep;
 	dev->priv = cep;
 #if 0
@@ -1005,4 +1022,14 @@
 
 	return 0;
 }
+
+
+
+
+
+
+
+
+
+
 
diff -ruN embedded_2.2.13_org/arch/ppc/8xx_io/uart.c embedded-2.2.13/arch/ppc/8xx_io/uart.c
--- embedded_2.2.13_org/arch/ppc/8xx_io/uart.c	Thu Oct 21 00:02:21 1999
+++ embedded-2.2.13/arch/ppc/8xx_io/uart.c	Fri Nov 26 15:41:06 1999
@@ -2417,7 +2417,12 @@
 		 * make it out of the transmit buffer.
 		 */
 		if (i == CONFIG_SERIAL_CONSOLE_PORT)
+#if defined(CONFIG_ADS) || defined(CONFIG_FADS)
+			mdelay(200);
+#else
 			mdelay(2);
+#endif
+
 #endif
 		info = kmalloc(sizeof(ser_info_t), GFP_KERNEL);
 		if (info) {
diff -ruN embedded_2.2.13_org/arch/ppc/config.in embedded-2.2.13/arch/ppc/config.in
--- embedded_2.2.13_org/arch/ppc/config.in	Fri Oct 22 23:56:10 1999
+++ embedded-2.2.13/arch/ppc/config.in	Thu Nov 25 16:02:25 1999
@@ -31,7 +31,9 @@
 	 MBX		CONFIG_MBX \
 	 RPXL		CONFIG_RPXLITE \
 	 RPXC		CONFIG_RPXCLASSIC \
-	 BSE-IP		CONFIG_BSEIP" PowerMac
+	 BSE-IP		CONFIG_BSEIP	   \
+	 ADS 		CONFIG_ADS \
+	 FADS  		CONFIG_FADS" PowerMac
 
 bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_ALL_PPC" != "y" ];then
diff -ruN embedded_2.2.13_org/arch/ppc/kernel/irq.c embedded-2.2.13/arch/ppc/kernel/irq.c
--- embedded_2.2.13_org/arch/ppc/kernel/irq.c	Fri Oct 22 22:48:22 1999
+++ embedded-2.2.13/arch/ppc/kernel/irq.c	Thu Nov 25 16:56:46 1999
@@ -54,9 +54,13 @@
 #include <asm/gg2.h>
 #include <asm/cache.h>
 #include <asm/prom.h>
+
+#ifdef CONFIG_APUS
 #include <asm/amigaints.h>
 #include <asm/amigahw.h>
 #include <asm/amigappc.h>
+#endif /* CONFIG_APUS */
+
 #include <asm/ptrace.h>
 
 #include "local_irq.h"
diff -ruN embedded_2.2.13_org/arch/ppc/kernel/ppc8xx_pic.c embedded-2.2.13/arch/ppc/kernel/ppc8xx_pic.c
--- embedded_2.2.13_org/arch/ppc/kernel/ppc8xx_pic.c	Fri Oct 22 22:50:42 1999
+++ embedded-2.2.13/arch/ppc/kernel/ppc8xx_pic.c	Fri Nov 26 13:22:59 1999
@@ -137,6 +137,8 @@
 	ppc_irq_dispatch_handler( regs, irq );
 }
 
+#endif
+
 /* Only the MBX uses the external 8259.  This allows us to catch standard
  * drivers that may mess up the internal interrupt controllers, and also
  * allow them to run without modification on the MBX.
@@ -145,7 +147,10 @@
 	unsigned long irqflags, const char * devname, void *dev_id)
 {
 
-	irq += i8259_pic.irq_offset;
-	return (request_8xxirq(irq, handler, irqflags, devname, dev_id));
-}
+#ifdef CONFIG_MBX
+        irq += i8259_pic.irq_offset;
+        return (request_8xxirq(irq, handler, irqflags, devname, dev_id));
+#else
+        panic("request_irq");
 #endif
+}
diff -ruN embedded_2.2.13_org/arch/ppc/kernel/ppc_ksyms.c embedded-2.2.13/arch/ppc/kernel/ppc_ksyms.c
--- embedded_2.2.13_org/arch/ppc/kernel/ppc_ksyms.c	Tue Oct 19 22:23:16 1999
+++ embedded-2.2.13/arch/ppc/kernel/ppc_ksyms.c	Thu Nov 25 16:53:51 1999
@@ -69,6 +69,7 @@
 EXPORT_SYMBOL(ppc_local_irq_count);
 EXPORT_SYMBOL(ppc_local_bh_count);
 
+#if 0 // damm
 EXPORT_SYMBOL(isa_io_base);
 EXPORT_SYMBOL(isa_mem_base);
 EXPORT_SYMBOL(pci_dram_offset);
@@ -77,6 +78,7 @@
 EXPORT_SYMBOL(DMA_MODE_WRITE);
 EXPORT_SYMBOL(_prep_type);
 EXPORT_SYMBOL(ucSystemType);
+#endif
 
 EXPORT_SYMBOL(atomic_add);
 EXPORT_SYMBOL(atomic_sub);
@@ -180,19 +182,21 @@
 
 EXPORT_SYMBOL(_machine);
 EXPORT_SYMBOL(ppc_md);
-
+#if 0 //damm
 EXPORT_SYMBOL(adb_request);
 EXPORT_SYMBOL(adb_register);
 EXPORT_SYMBOL(cuda_request);
 EXPORT_SYMBOL(cuda_poll);
 EXPORT_SYMBOL(pmu_request);
 EXPORT_SYMBOL(pmu_poll);
+#endif
 #ifdef CONFIG_PMAC_PBOOK
 EXPORT_SYMBOL(pmu_register_sleep_notifier);
 EXPORT_SYMBOL(pmu_unregister_sleep_notifier);
 EXPORT_SYMBOL(pmu_enable_irled);
 #endif CONFIG_PMAC_PBOOK
 EXPORT_SYMBOL(abort);
+#if 0 // damm
 EXPORT_SYMBOL(find_devices);
 EXPORT_SYMBOL(find_type_devices);
 EXPORT_SYMBOL(find_compatible_devices);
@@ -204,6 +208,7 @@
 EXPORT_SYMBOL(feature_set);
 EXPORT_SYMBOL(feature_clear);
 EXPORT_SYMBOL(feature_test);
+#endif
 #ifdef CONFIG_SCSI
 EXPORT_SYMBOL(note_scsi_host);
 #endif
@@ -214,7 +219,7 @@
 #endif /* CONFIG_PMAC */
 
 EXPORT_SYMBOL(abs);
-EXPORT_SYMBOL(device_is_compatible);
+// damm EXPORT_SYMBOL(device_is_compatible);
 
 EXPORT_SYMBOL_NOVERS(__ashrdi3);
 EXPORT_SYMBOL_NOVERS(__lshrdi3);
diff -ruN embedded_2.2.13_org/arch/ppc/kernel/setup.c embedded-2.2.13/arch/ppc/kernel/setup.c
--- embedded_2.2.13_org/arch/ppc/kernel/setup.c	Fri Oct 22 22:57:32 1999
+++ embedded-2.2.13/arch/ppc/kernel/setup.c	Thu Nov 25 16:55:52 1999
@@ -22,7 +22,7 @@
 #include <asm/processor.h>
 #include <asm/pgtable.h>
 #include <asm/bootinfo.h>
-#include <asm/setup.h>
+//#include <asm/setup.h>
 #include <asm/amigappc.h>
 #include <asm/smp.h>
 #ifdef CONFIG_8xx
diff -ruN embedded_2.2.13_org/arch/ppc/mbxboot/head.S embedded-2.2.13/arch/ppc/mbxboot/head.S
--- embedded_2.2.13_org/arch/ppc/mbxboot/head.S	Thu Oct 21 00:33:51 1999
+++ embedded-2.2.13/arch/ppc/mbxboot/head.S	Thu Nov 25 16:26:24 1999
@@ -37,6 +37,10 @@
  *		...and the first and second functions listed above are
  *			done for us (it knows ELF images).
  *
+ * On the (F)ADS,
+ *		R1 - Stack pointer at a high memory address.
+ *              R3 - Pointer to Board Information Block.
+ *		
  * For other embedded boards we build the Board Information Block.
  */
 
@@ -45,8 +49,12 @@
 	bl	start_
 start_:
 #ifndef CONFIG_MBX
-	lis	r11, local_bd_info@h
-	ori	r11, r11, local_bd_info@l
+#if defined(CONFIG_ADS) || defined(CONFIG_FADS)
+	mr	r11,r3		/* Save pointer to residual/board data */
+#else
+ 	lis	r11, local_bd_info@h
+ 	ori	r11, r11, local_bd_info@l
+#endif
 
 	mfmsr	r3		/* Turn off interrupts  */
 	li	r4,0
@@ -241,7 +249,7 @@
 	blr
 
 	.comm	.stack,4096*2,4
-#ifndef CONFIG_MBX
+#if !(defined(CONFIG_MBX) || defined(CONFIG_ADS) || defined(CONFIG_FADS))
 local_bd_info:
 	.long	0
 	.long	0x01000000
@@ -251,3 +259,4 @@
 	.long	0
 	.long	0
 #endif
+
diff -ruN embedded_2.2.13_org/arch/ppc/mbxboot/m8xx_tty.c embedded-2.2.13/arch/ppc/mbxboot/m8xx_tty.c
--- embedded_2.2.13_org/arch/ppc/mbxboot/m8xx_tty.c	Thu Oct 21 00:33:51 1999
+++ embedded-2.2.13/arch/ppc/mbxboot/m8xx_tty.c	Thu Nov 25 16:31:01 1999
@@ -100,6 +100,13 @@
 	cp->cp_brgc1 =
 		((((bd->bi_intfreq * 1000000)/16) / bd->bi_baudrate) << 1) | CPM_BRG_EN;
 
+#if defined(CONFIG_ADS) || defined(CONFIG_FADS)
+	/* Enable SMC1 in Board Control Status Register 1 */
+
+        *((uint *)BCSR1) &= ~BCSR1_RS232EN_1;       
+#endif
+
+
 #else /* CONFIG_MBX */
 	if (*MBX_CSR1 & CSR1_COMEN) {
 		/* COM1 is enabled.  Initialize SMC1 and use it for
diff -ruN embedded_2.2.13_org/arch/ppc/mm/init.c embedded-2.2.13/arch/ppc/mm/init.c
--- embedded_2.2.13_org/arch/ppc/mm/init.c	Sat Oct 23 00:51:30 1999
+++ embedded-2.2.13/arch/ppc/mm/init.c	Thu Nov 25 16:59:56 1999
@@ -51,8 +51,10 @@
 #include <asm/smp.h>
 #include <asm/bootx.h>
 /* APUS includes */
+#ifdef CONFIG_APUS
 #include <asm/setup.h>
 #include <asm/amigahw.h>
+#endif /* CONFIG_APUS */
 /* END APUS includes */
 
 int prom_trashed;
@@ -72,7 +74,7 @@
 unsigned long ioremap_bot;
 unsigned long avail_start;
 extern int num_memory;
-extern struct mem_info memory[NUM_MEMINFO];
+extern struct mem_info memory[];
 extern boot_infos_t *boot_infos;
 #ifndef __SMP__
 struct pgtable_cache_struct quicklists;
@@ -1102,6 +1104,10 @@
         ioremap(PCI_CSR_ADDR, PCI_CSR_SIZE);
 	ioremap(RPX_CSR_ADDR, RPX_CSR_SIZE);
 #endif
+#if defined(CONFIG_ADS) || defined(CONFIG_FADS)
+	ioremap(BCSR_ADDR, BCSR_SIZE);
+#endif
+
 #endif /* CONFIG_8xx */
 }
 
diff -ruN embedded_2.2.13_org/include/asm-ppc/ads.h embedded-2.2.13/include/asm-ppc/ads.h
--- embedded_2.2.13_org/include/asm-ppc/ads.h	Thu Jan  1 01:00:00 1970
+++ embedded-2.2.13/include/asm-ppc/ads.h	Fri Nov 26 15:35:53 1999
@@ -0,0 +1,156 @@
+/*
+ * A collection of structures, addresses, and values associated with
+ * the Motorola ADS board.  
+ * Various sources - mostly fads.h
+ *
+ * Magnus Damm <damm@bitsmart.com>
+ */
+
+#ifndef __MACH_ADS_DEFS
+#define __MACH_ADS_DEFS
+
+/*
+ * 1999-nov-26: The ADS is using the following physical memorymap:
+ *
+ * ff020000 -> ff02ffff : pcmcia   
+ * ff010000 -> ff01ffff : BCSR     connected to CS1, setup by 8xxrom
+ * ff000000 -> ff00ffff : IMAP     internal in the cpu
+ * fe000000 -> ffnnnnnn : flash    connected to CS0, setup by 8xxrom 
+ * 00000000 -> nnnnnnnn : dram     setup by 8xxrom
+ */
+
+/* ------------------------------------------------------------------------- */
+/* 8xxrom                                                                    */
+
+#define IMMR_VALUE              0xff000000      /* needed by linux too */
+
+#define BR0_VALUE               (FLASH_ADDR | 1)
+#define OR0_VALUE               0xfff00d34      /* 1 Mbyte until detected */
+
+#define BR1_VALUE               (BCSR_ADDR | 1)
+#define OR1_VALUE               0xffff8110      /* 64Kbyte address space */
+
+/* the other CS:s are determined by looking at parameters in BCSRx */
+
+#define SIUMCR_VALUE            0x01632400 /* values according to the manual */
+#define SYPCR_VALUE             0xffffff88
+#define TBSCR_VALUE             0x00c2
+#define RTCSC_VALUE             0x01c2
+#define PISCR_VALUE             0x0082
+
+/* ------------------------------------------------------------------------- */
+/* linux                                                                     */
+
+#ifndef __ASSEMBLY__
+
+#define PCMCIA_MEM_ADDR		((uint)0xff020000)
+#define PCMCIA_MEM_SIZE		((uint)(64 * 1024))
+
+#define BCSR_ADDR		((uint) 0xff010000)
+#define BCSR_SIZE		((uint)(64 * 1024))
+
+#define	BCSR0			((uint) (BCSR_ADDR + 00))
+#define	BCSR1			((uint) (BCSR_ADDR + 0x04))
+#define	BCSR2			((uint) (BCSR_ADDR + 0x08))
+#define	BCSR3			((uint) (BCSR_ADDR + 0x0c))
+
+#define IMAP_ADDR		((uint) IMMR_VALUE)
+#define IMAP_SIZE		((uint)(64 * 1024))
+
+#define FLASH_ADDR		((uint) 0xfe000000)
+#define FLASH_SIZE		((uint)(8 * 1024 * 1024)) /* max 8Mbyte */
+
+
+/* A Board Information structure that is given to a program when
+ * prom starts it up.
+ */
+
+typedef struct bd_info {
+	unsigned int	bi_memstart;	/* Memory start address */
+	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
+	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
+	unsigned int	bi_busfreq;	/* Bus Freq, in Hz */
+	unsigned char	bi_enetaddr[6];
+	unsigned int	bi_baudrate;
+} bd_t;
+
+extern bd_t m8xx_board_info;
+
+/* ADS bitvalues taken from Helmut Buchsbaum's FADS
+ * see MPC8xxADS User's Manual for a proper description
+ * of the following structures
+ */
+
+#define BCSR0_ERB       ((uint)0x80000000)
+#define BCSR0_IP        ((uint)0x40000000)
+#define BCSR0_BDIS      ((uint)0x10000000)
+#define BCSR0_BPS_MASK  ((uint)0x0C000000)
+#define BCSR0_ISB_MASK  ((uint)0x01800000)
+#define BCSR0_DBGC_MASK ((uint)0x00600000)
+#define BCSR0_DBPC_MASK ((uint)0x00180000)
+#define BCSR0_EBDF_MASK ((uint)0x00060000)
+ 
+#define BCSR1_FLASH_EN           ((uint)0x80000000)
+#define BCSR1_DRAM_EN            ((uint)0x40000000)
+#define BCSR1_ETHEN              ((uint)0x20000000)
+#define BCSR1_IRDEN              ((uint)0x10000000)
+#define BCSR1_FLASH_CFG_EN       ((uint)0x08000000)
+#define BCSR1_CNT_REG_EN_PROTECT ((uint)0x04000000)
+#define BCSR1_BCSR_EN            ((uint)0x02000000)
+#define BCSR1_RS232EN_1          ((uint)0x01000000)
+#define BCSR1_PCCEN              ((uint)0x00800000)
+#define BCSR1_PCCVCCON           ((uint)0x00400000)
+#define BCSR1_PCCVPP_MASK        ((uint)0x00300000)
+#define BCSR1_DRAM_HALF_WORD     ((uint)0x00080000)
+#define BCSR1_RS232EN_2          ((uint)0x00040000)
+
+#define BCSR2_FLASH_PD_MASK      ((uint)0xF0000000)
+#define BCSR2_DRAM_EDO           ((uint)0x08000000)
+#define BCSR2_DRAM_PD_MASK       ((uint)0x07800000)
+#define BCSR2_DRAM_PD_SHIFT      (23)
+#define BCSR2_EXTTOLI_MASK       ((uint)0x00780000)
+
+#define BCSR3_CNT_REG_EN_PROTECT ((ushort)0x0400)
+#define BCSR3_BREVNR0            ((ushort)0x0080)
+#define BCSR3_FLASH_PD_MASK      ((ushort)0x0070)
+#define BCSR3_BREVN1             ((ushort)0x0008)
+#define BCSR3_BREVN2_MASK        ((ushort)0x0003)
+
+/* We don't use the 8259.
+*/
+#define NR_8259_INTS	0
+
+/* Machine type
+*/
+#define _MACH_8xx (_MACH_ads)
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __MACH_ADS_DEFS */
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
diff -ruN embedded_2.2.13_org/include/asm-ppc/fads.h embedded-2.2.13/include/asm-ppc/fads.h
--- embedded_2.2.13_org/include/asm-ppc/fads.h	Tue Oct 19 23:21:16 1999
+++ embedded-2.2.13/include/asm-ppc/fads.h	Fri Nov 26 16:19:59 1999
@@ -1,13 +1,70 @@
-
 /*
  * A collection of structures, addresses, and values associated with
  * the Motorola 860T FADS board.  Copied from the MBX stuff.
+ * Magnus Damm added defines for 8xxrom and extended bd_info.
+ * Helmut Buchsbaum added bitvalues for BCSRx
  *
  * Copyright (c) 1998 Dan Malek (dmalek@jlc.net)
  */
+
 #ifndef __MACH_FADS_DEFS
 #define __MACH_FADS_DEFS
 
+/*
+ * 1999-nov-26: The FADS is using the following physical memorymap:
+ *
+ * ff020000 -> ff02ffff : pcmcia   
+ * ff010000 -> ff01ffff : BCSR       connected to CS1, setup by 8xxrom
+ * ff000000 -> ff00ffff : IMAP       internal in the cpu
+ * fe000000 -> ffnnnnnn : flash      connected to CS0, setup by 8xxrom 
+ * 00000000 -> nnnnnnnn : sdram/dram setup by 8xxrom
+ */
+
+/* ------------------------------------------------------------------------- */
+/* 8xxrom                                                                    */
+
+#define IMMR_VALUE              0xff000000      /* needed by linux too */
+
+#define BR0_VALUE               (FLASH_ADDR | 1)
+#define OR0_VALUE               0xfff00d34      /* 1 Mbyte until detected */
+
+#define BR1_VALUE               (BCSR_ADDR | 1)
+#define OR1_VALUE               0xffff8110      /* 64Kbyte address space */
+
+/* the other CS:s are determined by looking at parameters in BCSRx */
+
+/* values according to the manual */
+
+#define SIUMCR_VALUE 0x01012400  //0x01012440  
+#define SYPCR_VALUE  0xffffff88  /* disable watchdog (11-9) */
+#define TBSCR_VALUE  0x00c2
+#define RTCSC_VALUE  0x00c2
+#define PISCR_VALUE  0x0082
+
+/* ------------------------------------------------------------------------- */
+/* linux                                                                     */
+
+#ifndef __ASSEMBLY__
+
+#define PCMCIA_MEM_ADDR		((uint)0xff020000)
+#define PCMCIA_MEM_SIZE		((uint)(64 * 1024))
+
+#define BCSR_ADDR		((uint) 0xff010000)
+#define BCSR_SIZE		((uint)(64 * 1024))
+
+#define	BCSR0			((uint) (BCSR_ADDR + 00))
+#define	BCSR1			((uint) (BCSR_ADDR + 0x04))
+#define	BCSR2			((uint) (BCSR_ADDR + 0x08))
+#define	BCSR3			((uint) (BCSR_ADDR + 0x0c))
+#define	BCSR4			((uint) (BCSR_ADDR + 0x10))
+
+#define IMAP_ADDR		((uint) IMMR_VALUE)
+#define IMAP_SIZE		((uint)(64 * 1024))
+
+#define FLASH_ADDR		((uint) 0xfe000000)
+#define FLASH_SIZE		((uint)(8 * 1024 * 1024)) /* max 8Mbyte */
+
+
 /* A Board Information structure that is given to a program when
  * prom starts it up.
  */
@@ -16,24 +73,106 @@
 	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
 	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
 	unsigned int	bi_busfreq;	/* Bus Freq, in Hz */
+	unsigned char	bi_enetaddr[6];
+	unsigned int	bi_baudrate;
 } bd_t;
 
 extern bd_t m8xx_board_info;
 
-/* Memory map is configured by the PROM startup.
- * I tried to follow the FADS manual, although the startup PROM
- * dictates this.
+/* FADS bitvalues by Helmut Buchsbaum
+ * see MPC8xxADS User's Manual for a proper description
+ * of the following structures
  */
-#define BCSR_ADDR		((uint)0x02100000)
-#define BCSR_SIZE		((uint)(64 * 1024))
-#define	BCSR0			((uint)0x02100000)
-#define	BCSR1			((uint)0x02100004)
-#define	BCSR2			((uint)0x02100008)
-#define	BCSR3			((uint)0x0210000c)
-#define	BCSR4			((uint)0x02100010)
-#define IMAP_ADDR		((uint)0x02200000)
-#define IMAP_SIZE		((uint)(64 * 1024))
-#define PCMCIA_MEM_ADDR		((uint)0x04000000)
-#define PCMCIA_MEM_SIZE		((uint)(64 * 1024))
+
+#define BCSR0_ERB       ((uint)0x80000000)
+#define BCSR0_IP        ((uint)0x40000000)
+#define BCSR0_BDIS      ((uint)0x10000000)
+#define BCSR0_BPS_MASK  ((uint)0x0C000000)
+#define BCSR0_ISB_MASK  ((uint)0x01800000)
+#define BCSR0_DBGC_MASK ((uint)0x00600000)
+#define BCSR0_DBPC_MASK ((uint)0x00180000)
+#define BCSR0_EBDF_MASK ((uint)0x00060000)
+ 
+#define BCSR1_FLASH_EN           ((uint)0x80000000)
+#define BCSR1_DRAM_EN            ((uint)0x40000000)
+#define BCSR1_ETHEN              ((uint)0x20000000)
+#define BCSR1_IRDEN              ((uint)0x10000000)
+#define BCSR1_FLASH_CFG_EN       ((uint)0x08000000)
+#define BCSR1_CNT_REG_EN_PROTECT ((uint)0x04000000)
+#define BCSR1_BCSR_EN            ((uint)0x02000000)
+#define BCSR1_RS232EN_1          ((uint)0x01000000)
+#define BCSR1_PCCEN              ((uint)0x00800000)
+#define BCSR1_PCCVCC0            ((uint)0x00400000)
+#define BCSR1_PCCVPP_MASK        ((uint)0x00300000)
+#define BCSR1_DRAM_HALF_WORD     ((uint)0x00080000)
+#define BCSR1_RS232EN_2          ((uint)0x00040000)
+#define BCSR1_SDRAM_EN           ((uint)0x00020000)
+#define BCSR1_PCCVCC1            ((uint)0x00010000)
+ 
+#define BCSR2_FLASH_PD_MASK      ((uint)0xF0000000)
+#define BCSR2_DRAM_PD_MASK       ((uint)0x07800000)
+#define BCSR2_DRAM_PD_SHIFT      (23)
+#define BCSR2_EXTTOLI_MASK       ((uint)0x00780000)
+#define BCSR2_DBREVNR_MASK       ((uint)0x00030000)
+ 
+#define BCSR3_DBID_MASK          ((ushort)0x3800)
+#define BCSR3_CNT_REG_EN_PROTECT ((ushort)0x0400)
+#define BCSR3_BREVNR0            ((ushort)0x0080)
+#define BCSR3_FLASH_PD_MASK      ((ushort)0x0070)
+#define BCSR3_BREVN1             ((ushort)0x0008)
+#define BCSR3_BREVN2_MASK        ((ushort)0x0003)
+ 
+#define BCSR4_ETHLOOP            ((uint)0x80000000)
+#define BCSR4_TFPLDL             ((uint)0x40000000)
+#define BCSR4_TPSQEL             ((uint)0x20000000)
+#define BCSR4_SIGNAL_LAMP        ((uint)0x10000000)
+#ifdef CONFIG_MPC823
+#define BCSR4_USB_EN             ((uint)0x08000000)
+#endif /* CONFIG_MPC823 */
+#ifdef CONFIG_MPC860SAR
+#define BCSR4_UTOPIA_EN          ((uint)0x08000000)
+#endif /* CONFIG_MPC860SAR */
+#ifdef CONFIG_MPC860T
+#define BCSR4_FETH_EN            ((uint)0x08000000)
+#endif /* CONFIG_MPC860T */
+#define BCSR4_USB_SPEED          ((uint)0x04000000)
+#define BCSR4_VCCO               ((uint)0x02000000)
+#define BCSR4_VIDEO_ON           ((uint)0x00800000)
+#define BCSR4_VDO_EKT_CLK_EN     ((uint)0x00400000)
+#define BCSR4_VIDEO_RST          ((uint)0x00200000)
+#define BCSR4_MODEM_EN           ((uint)0x00100000)
+#define BCSR4_DATA_VOICE         ((uint)0x00080000)
+
+#ifdef CONFIG_MPC860T
+
+/* Interrupt level assignments.
+*/
+#define FEC_INTERRUPT	SIU_LEVEL1	/* FEC interrupt */
+
+#endif /* CONFIG_MPC860T */
+
+/* We don't use the 8259.
+*/
+#define NR_8259_INTS	0
+
+/* Machine type
+*/
+#define _MACH_8xx (_MACH_fads)
+
+#endif /* __ASSEMBLY__ */
 
 #endif
+
+
+
+
+
+
+
+
+
+
+
+
+
+
diff -ruN embedded_2.2.13_org/include/asm-ppc/mpc8xx.h embedded-2.2.13/include/asm-ppc/mpc8xx.h
--- embedded_2.2.13_org/include/asm-ppc/mpc8xx.h	Sat Oct 23 01:10:04 1999
+++ embedded-2.2.13/include/asm-ppc/mpc8xx.h	Fri Nov 26 16:20:13 1999
@@ -12,6 +12,10 @@
 #include <asm/mbx.h>
 #endif
 
+#ifdef CONFIG_ADS
+#include <asm/ads.h>
+#endif
+
 #ifdef CONFIG_FADS
 #include <asm/fads.h>
 #endif
@@ -54,3 +58,19 @@
 		       void *dev_id);
 
 #endif
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
diff -ruN embedded_2.2.13_org/include/asm-ppc/processor.h embedded-2.2.13/include/asm-ppc/processor.h
--- embedded_2.2.13_org/include/asm-ppc/processor.h	Sat Oct 23 01:10:02 1999
+++ embedded-2.2.13/include/asm-ppc/processor.h	Thu Nov 25 16:46:00 1999
@@ -70,6 +70,7 @@
 #define _MACH_bseip   128 /* Bright Star Engineering ip-Engine */
 #define _MACH_yk      256 /* Motorola Yellowknife */
 #define _MACH_rpxclassic 512  /* RPCG RPX-Classic 8xx board */
+#define _MACH_ads     1024    /* Motorola ADS board */
 
 /* see residual.h for these */
 #define _PREP_Motorola 0x01  /* motorola prep */

--------------904187F94F277E456804AC60--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
