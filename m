Date: Fri, 10 Jan 2003 11:55:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Todd Poynor <tpoynor@mvista.com>, Ken Inoue <keninoue@us.ibm.com>
Subject: 405LP PCMCIA cleanup
Message-ID: <20030110005533.GC19829@zax.zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The patch below makes some cleanups to the handling of the PCMCIA
interface on the 405LP.  In particular, it removes the need for a
hardcoded io_block_mapping() in the board setup code, replacing it
with ioremap()s.

Unfortunately, the ioremap()s can't live in the pccf_4xx driver
itself, since this would lead to _IO_BASE and ISA_MEM_BASE being
initialized far too late.  So instead, I use the hack of an
ibm405lp_setup_pccf() function provided in ibm405lp.c, to be used by
the board setup code.

This is tested on Arctic-II, but not on Beech.  If there aren't
serious objections, I'll commit it to linuxppc_2_4_devel.

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ppc_ksyms.c linux-bartholomew/arch/ppc/kernel/ppc_ksyms.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ppc_ksyms.c	2003-01-07 22:00:10.000000000 +1100
+++ linux-bartholomew/arch/ppc/kernel/ppc_ksyms.c	2003-01-09 16:16:33.000000000 +1100
@@ -175,7 +175,7 @@
 EXPORT_SYMBOL(ppc_ide_md);
 #endif

-#if defined(CONFIG_PCI) || defined(CONFIG_BEECH)
+#if defined(CONFIG_PCI)
 EXPORT_SYMBOL_NOVERS(isa_io_base);
 EXPORT_SYMBOL_NOVERS(isa_mem_base);
 #endif
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/Makefile linux-bartholomew/arch/ppc/platforms/Makefile
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/Makefile	2002-12-20 15:23:32.000000000 +1100
+++ linux-bartholomew/arch/ppc/platforms/Makefile	2003-01-08 17:00:39.000000000 +1100
@@ -24,7 +24,7 @@

 O_TARGET := platform.o

-export-objs			:= prep_setup.o beech.o ibm405lp.o
+export-objs			:= prep_setup.o beech.o ibm405lp.o arctic2.o

 obj-$(CONFIG_CEDER)		+= ceder.o ibmnp405l.o
 obj-$(CONFIG_CPCI405)		+= cpci405.o ibm405gp.o
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/arctic2.c linux-bartholomew/arch/ppc/platforms/arctic2.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/arctic2.c	2002-12-16 12:59:59.000000000 +1100
+++ linux-bartholomew/arch/ppc/platforms/arctic2.c	2003-01-09 17:14:48.000000000 +1100
@@ -47,6 +47,15 @@

 #include <platforms/arctic2.h>

+/* Virtual address of the PCCF macro, which needs to be ioremap()ed
+ * and initialized by the board setup code. */
+volatile u16 *pccf_4xx_macro_vaddr;
+unsigned long pccf_4xx_io_base;
+unsigned long pccf_4xx_mem_base;
+EXPORT_SYMBOL(pccf_4xx_macro_vaddr);
+EXPORT_SYMBOL(pccf_4xx_io_base);
+EXPORT_SYMBOL(pccf_4xx_mem_base);
+
 void __init
 board_setup_arch(void)
 {
@@ -63,8 +72,8 @@
 			 ARCTIC2_FPGA8_SIZE, _PAGE_IO);
 	io_block_mapping(ARCTIC2_FPGA16_VADDR, ARCTIC2_FPGA16_PADDR,
 			 ARCTIC2_FPGA16_SIZE, _PAGE_IO);
-	io_block_mapping(SUBZERO_BEECH_PCMCIA_VADDR, SUBZERO_BEECH_PCMCIA_PADDR,
-			 SUBZERO_BEECH_PCMCIA_SIZE, _PAGE_IO);
+	ibm405lp_setup_pccf(&pccf_4xx_macro_vaddr, &pccf_4xx_io_base,
+			    &pccf_4xx_mem_base);
 }

 void __init
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/arctic2.h linux-bartholomew/arch/ppc/platforms/arctic2.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/arctic2.h	2002-12-18 11:53:11.000000000 +1100
+++ linux-bartholomew/arch/ppc/platforms/arctic2.h	2003-01-09 16:19:10.000000000 +1100
@@ -60,6 +60,10 @@

 #define PPC4xx_MACHINE_NAME	"IBM Arctic II"

+#include <asm/pccf_4xx.h>
+#define _IO_BASE		(pccf_4xx_io_base)
+#define _ISA_MEM_BASE		(pccf_4xx_mem_base)
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_ARCTIC2_H__ */
 #endif /* __KERNEL__ */
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/beech.c linux-bartholomew/arch/ppc/platforms/beech.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/beech.c	2003-01-01 22:47:20.000000000 +1100
+++ linux-bartholomew/arch/ppc/platforms/beech.c	2003-01-09 17:14:58.000000000 +1100
@@ -45,8 +45,6 @@
 static void beech_ebc_setup(void);
 static void beech_fpga_setup(void);

-unsigned long isa_io_base;
-unsigned long isa_mem_base;
 volatile u8 *beech_fpga_reg_0 = NULL;
 volatile u8 *beech_fpga_reg_2 = NULL;
 volatile u8 *beech_fpga_reg_4 = NULL;
@@ -55,6 +53,15 @@
 EXPORT_SYMBOL(beech_fpga_reg_2);
 EXPORT_SYMBOL(beech_fpga_reg_4);

+/* Virtual address of the PCCF macro, which needs to be ioremap()ed
+ * and initialized by the board setup code. */
+volatile u16 *pccf_4xx_macro_vaddr;
+unsigned long pccf_4xx_io_base;
+unsigned long pccf_4xx_mem_base;
+EXPORT_SYMBOL(pccf_4xx_macro_vaddr);
+EXPORT_SYMBOL(pccf_4xx_io_base);
+EXPORT_SYMBOL(pccf_4xx_mem_base);
+
 /*
    Beech board physical memory map:

@@ -119,6 +126,8 @@
 void __init
 board_io_mapping(void)
 {
+	ibm405lp_setup_pccf(&pccf_4xx_macro_vaddr, &pccf_4xx_io_base,
+			    &pccf_4xx_mem_base);
 }

 void __init
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/beech.h linux-bartholomew/arch/ppc/platforms/beech.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/beech.h	2002-12-18 11:53:11.000000000 +1100
+++ linux-bartholomew/arch/ppc/platforms/beech.h	2003-01-09 16:15:43.000000000 +1100
@@ -166,13 +166,6 @@
 #define BEECH_FREE_AREA_OFFSET BEECH_KERNEL_SIZE
 #define BEECH_FREE_AREA_SIZE   (BEECH_BIGFLASH_SIZE - BEECH_KERNEL_SIZE)

-/* The PCMCIA controller driver 4xx_pccf.c is responsible for the EBC setup of
-   PCMCIA.  Externally, EBC bank selects 3..7 take on PCMCIA functions when
-   PCMCIA is enabled. */
-
-#define BEECH_PCMCIA_PADDR		((uint)0xf0000000)
-#define BEECH_PCMCIA_SIZE		((uint)(32 * 1024 * 1024))
-
 /* We do not currently support the internal clock mode for the UART.  This
    limits the minimum OPB frequency to just over 2X the UART oscillator
    frequency. At OPB frequencies less than this the serial port will not
@@ -185,12 +178,12 @@

 #define PPC4xx_MACHINE_NAME		"IBM 405LP Beech"

-#define _IO_BASE        isa_io_base
-#define _ISA_MEM_BASE   isa_mem_base
-#define PCI_DRAM_OFFSET 0
+#define PCI_DRAM_OFFSET		0
+
+#include <asm/pccf_4xx.h>
+#define _IO_BASE		(pccf_4xx_io_base)
+#define _ISA_MEM_BASE		(pccf_4xx_mem_base)

-extern unsigned long isa_io_base;
-extern unsigned long isa_mem_base;

 /****************************************************************************
  * Non-standard board support follows
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibm405lp.c linux-bartholomew/arch/ppc/platforms/ibm405lp.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibm405lp.c	2003-01-01 22:47:20.000000000 +1100
+++ linux-bartholomew/arch/ppc/platforms/ibm405lp.c	2003-01-09 17:29:42.000000000 +1100
@@ -43,6 +43,7 @@
 #include <asm/time.h>
 #include <asm/uaccess.h>
 #include <asm/ocp.h>
+#include <asm/pccf_4xx.h>

 struct ocp_def core_ocp[] = {
 	{UART, UART0_IO_BASE, UART0_INT},
@@ -266,6 +267,109 @@
 	}
 }

+/* Somewhat misleading name, as well as the EBC, this sets up the UIC
+   and CPC ready for PCMCIA operation */
+static void
+pccf_ebc_setup(void)
+{
+	/* Set up EBC bank 4 as per PCCF docs., assuming 66 MHz EBC bus. The
+	   ready timeout is set for 1024 cycles (~ 15 us at 66 MHz), unless
+	   someone else has already set it for 2048.  In the event of a
+	   timeout we'll get a Data Machine Check. */
+
+	unsigned long bits, mask, flags;
+
+	save_flags(flags);
+	cli();
+
+	/* Program EBC0_CFG for ready timeout */
+
+	mtdcr(DCRN_EBC0_CFGADDR, DCRN_EBC0_CFG);
+	bits = mfdcr(DCRN_EBC0_CFGDATA);
+	if ((bits & EBC_CFG_RTC) != EBC_CFG_RTC_2048)
+		mtdcr(DCRN_EBC0_CFGDATA, (bits & ~EBC_CFG_RTC) | EBC_CFG_RTC_1024);
+
+	/* Program EBC bank properties : 32 MB, 16-bit RW bank;
+	   BME = 0, TWT = 22, CSN = 2, OEN = 3, WBN = WBF = 0, TH = 5,
+	   RE = 1, SOR = 0, BEM = 1 */
+
+	mtdcr(DCRN_EBC0_CFGADDR, DCRN_EBC0_B4CR);
+	mtdcr(DCRN_EBC0_CFGDATA, (PCCF_4XX_PADDR & 0xfff00000) | 0x000ba000);
+	mtdcr(DCRN_EBC0_CFGADDR, DCRN_EBC0_B4AP);
+	mtdcr(DCRN_EBC0_CFGDATA, 0x0b0b0b40);
+
+	/* Program the UIC for active-high, level-triggered interrupts.  Note
+	   that the active-low PCMCIA interrupt pin is inverted by the PCCF
+	   macro.  */
+
+	mask = (0x80000000 >> PCCF_4XX_MACRO_IRQ) |
+		(0x80000000 >> PCCF_4XX_CARD_IRQ);
+
+	bits = mfdcr(DCRN_UIC0_PR);
+	bits |= mask;
+	mtdcr(DCRN_UIC0_PR, bits);
+
+	bits = mfdcr(DCRN_UIC0_TR);
+	bits &= ~mask;
+	mtdcr(DCRN_UIC0_TR, bits);
+
+	/* Clear CPC0_CR0[PCMD] to enable the PCMCIA controller */
+
+	mtdcr(DCRN_CPC0_CR0, mfdcr(DCRN_CPC0_CR0) & ~0x00000200);
+
+	restore_flags(flags);
+}
+
+/* Map the PCCF controller's memory windows.
+ *
+ * HACK ALERT: Logically this belongs in the pccf_4xx driver itself,
+ * however that causes problems because it happens so late in
+ * initialization.  We want to use some ISA-ish drivers (notably
+ * 8390.c) on memory mapped devices by using the
+ * ioaddr=(memaddr-_IO_BASE) hack.  If _IO_BASE is the PCMCIA ISA IO
+ * space (which we want so PC Card drivers using ISA IO work) but is
+ * not initialized until the pccf_4xx driver starts, this could well
+ * be after drivers like 8390 have initialized and computed a fake
+ * "IO" address which is now incorrect.  Putting the ioremap()ing of
+ * the PCCF macro in the chip/board setup code works around this
+ * problem. */
+int
+ibm405lp_setup_pccf(volatile u16 **vaddr, unsigned long *io_base,
+		    unsigned long *mem_base)
+{
+	pccf_ebc_setup();
+
+	*vaddr = ioremap(PCCF_4XX_MACRO_PADDR, PCCF_4XX_MACRO_WINSIZE);
+
+	if (*vaddr == NULL) {
+		printk(KERN_ERR "pccf_4xx: ioremap macro at 0x%lx failed.\n",
+		       PCCF_4XX_MACRO_PADDR);
+		return -EBUSY;
+	}
+
+	printk("ibm405lp_setup_pcmcia:  phys addr = %lx,  virt addr = %p\n",
+	       PCCF_4XX_MACRO_PADDR, *vaddr);
+
+	*io_base = (unsigned long) ioremap(PCCF_4XX_IO_PADDR,
+					   PCCF_4XX_IO_WINSIZE);
+	if (*io_base == 0) {
+		printk(KERN_ERR "pccf_4xx: ioremap io at 0x%lx failed.\n",
+		       PCCF_4XX_IO_PADDR);
+		return -EBUSY;
+	}
+
+	*mem_base = (unsigned long) ioremap(PCCF_4XX_MEM_PADDR,
+					    PCCF_4XX_MEM_WINSIZE);
+	if (*mem_base == 0) {
+		printk(KERN_ERR "pccf_4xx: ioremap mem at 0x%lx failed.\n",
+		       PCCF_4XX_MEM_PADDR);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+
 /****************************************************************************
  * TODC
  ****************************************************************************/
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibm405lp.h linux-bartholomew/arch/ppc/platforms/ibm405lp.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibm405lp.h	2002-12-18 11:53:11.000000000 +1100
+++ linux-bartholomew/arch/ppc/platforms/ibm405lp.h	2003-01-09 17:55:53.000000000 +1100
@@ -316,6 +316,16 @@

 #define TDES0_IO_BASE  0xef600b00

+/* The PCMCIA controller driver 4xx_pccf.c is responsible for the EBC setup of
+   PCMCIA.  Externally, EBC bank selects 3..7 take on PCMCIA functions when
+   PCMCIA is enabled. */
+
+#define PCCF_4XX_PADDR		(0xf0000000UL)
+#define PCCF_4XX_SIZE		(32 * 1024 * 1024)
+#define PCCF_4XX_MACRO_IRQ	UIC_IRQ_EIR5
+#define PCCF_4XX_CARD_IRQ	UIC_IRQ_EIR6
+
+
 /*****************************************************************************
  * CPM bits for the 405LP.  Field names are as documented in the 405LP manual.
  * Backwards-compatible synonyms appear at the end.
@@ -901,6 +911,8 @@
  ****************************************************************************/

 int ibm405lp_set_pixclk(unsigned pixclk_min, unsigned pixclk_max);
+int ibm405lp_setup_pccf(volatile u16 **vaddr, unsigned long *io_base,
+			unsigned long *mem_base);

 void ibm405lp_reset_sdram(u32 new_rtr, u32 new_tr);

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/subzero.h linux-bartholomew/arch/ppc/platforms/subzero.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/subzero.h	2002-12-16 13:00:04.000000000 +1100
+++ linux-bartholomew/arch/ppc/platforms/subzero.h	2003-01-09 16:19:20.000000000 +1100
@@ -88,21 +88,7 @@
 #define SUBZERO_BOOTFLASH_PADDR  (SUBZERO_BANK0_PADDR)
 #define SUBZERO_BOOTFLASH_SIZE   ((uint)(32 * 1024 * 1024))

-/* The PCMCIA controller driver 4xx_pccf.c is responsible for the EBC setup of
-   PCMCIA.  Externally, EBC bank selects 3..7 take on PCMCIA functions when
-   PCMCIA is enabled. */
-
-#define SUBZERO_BEECH_PCMCIA_PADDR     ((uint)0xf0000000)
-#define SUBZERO_BEECH_PCMCIA_VADDR     SUBZERO_BEECH_PCMCIA_PADDR
-#define SUBZERO_BEECH_PCMCIA_SIZE      ((uint)(32 * 1024 * 1024))
-
-#define SUBZERO_BEECH_PCMCIA_IO_BASE (SUBZERO_BEECH_PCMCIA_VADDR + 0x01800000)
-
-/* Define _IO_BASE for PCMCIA; other defines are required as well. */
-
-#define _IO_BASE SUBZERO_BEECH_PCMCIA_IO_BASE
-#define _ISA_MEM_BASE 0
-#define PCI_DRAM_OFFSET 0
+#define PCI_DRAM_OFFSET		0

 void *beech_sram_alloc(size_t size);
 int beech_sram_free(void *p);
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/drivers/pcmcia/Config.in linux-bartholomew/drivers/pcmcia/Config.in
--- /home/dgibson/kernel/linuxppc_2_4_devel/drivers/pcmcia/Config.in	2002-08-14 09:23:45.000000000 +1000
+++ linux-bartholomew/drivers/pcmcia/Config.in	2002-12-19 15:21:01.000000000 +1100
@@ -29,7 +29,7 @@
    if [ "$CONFIG_8xx" = "y" ]; then
       dep_tristate '  M8xx support' CONFIG_PCMCIA_M8XX $CONFIG_PCMCIA
    fi
-   if [ "$CONFIG_BEECH" = "y" ]; then
+   if [ "$CONFIG_405LP" = "y" ]; then
       dep_tristate '  IBM 4xx PCCF support' CONFIG_PCMCIA_PCCF_4xx $CONFIG_PCMCIA
    fi
 fi
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/drivers/pcmcia/pccf_4xx.c linux-bartholomew/drivers/pcmcia/pccf_4xx.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/drivers/pcmcia/pccf_4xx.c	2002-08-14 09:23:45.000000000 +1000
+++ linux-bartholomew/drivers/pcmcia/pccf_4xx.c	2003-01-09 17:38:07.000000000 +1100
@@ -236,6 +236,7 @@
 #include <pcmcia/bus_ops.h>

 #include <asm/byteorder.h>
+#include <asm/pccf_4xx.h>

 MODULE_AUTHOR("Eric Van Hensbergen <bergevan@us.ibm.com>");
 MODULE_DESCRIPTION("IBM PCCF 4xx socket driver");
@@ -250,6 +251,8 @@
 static const char *version =
     "pccf_4xx.c $Revision: 1.3 $ $Date: 2001/10/26 02:22:41 $ (Eric Van Hensbergen)";

+#define PCMCIA_DEBUG 0
+
 #ifdef PCMCIA_DEBUG
 static int pc_debug = PCMCIA_DEBUG;
 MODULE_PARM(pc_debug, "i");
@@ -262,44 +265,20 @@

 /* Configurations */

-#define PCMCIA_PADDR  BEECH_PCMCIA_PADDR
-#define MACRO_IRQ     UIC_IRQ_EIR5
-#define CARD_IRQ      UIC_IRQ_EIR6
 #define VCC5V_SUPPORT 1

 /* Minimum bus cycle time (in ns) */

 #define MIN_SPEED 300

-/* Areas that we ioremap() are mapped only as large as necessary to get the job
-   done: Only a few locations of the macro space are used, and legacy IO space
-   is only 64 KB. There is 1 memory window, and 2 virtual IO windows. */
-
-#define PCMCIA_MEM_WIN_SIZE 		(8*1024*1024)
-
-#define PCMCIA_MACRO_OFFSET             0x00000000
-#define PCMCIA_MACRO_PADDR              (PCMCIA_PADDR + PCMCIA_MACRO_OFFSET)
-#define PCMCIA_MACRO_WINSIZE            PAGE_SIZE
-
-#define PCMCIA_ATTRIB_OFFSET     	0x00800000
-#define PCMCIA_ATTRIB_PADDR             (PCMCIA_PADDR + PCMCIA_ATTRIB_OFFSET)
-#define PCMCIA_ATTRIB_WINSIZE         	PCMCIA_MEM_WIN_SIZE
-
-#define PCMCIA_MEM_OFFSET		0x01000000
-#define PCMCIA_MEM_PADDR                (PCMCIA_PADDR + PCMCIA_MEM_OFFSET)
-#define PCMCIA_MEM_WINSIZE            	PCMCIA_MEM_WIN_SIZE
-
-#define PCMCIA_IO_OFFSET         	0x01800000
-#define PCMCIA_IO_PADDR                 (PCMCIA_PADDR + PCMCIA_IO_OFFSET)
-#define PCMCIA_IO_WINSIZE             	0x00010000
+#define PCMCIA_ATTRIB_OFFSET	0x00800000
+#define PCMCIA_ATTRIB_PADDR	(PCCF_4XX_PADDR + PCMCIA_ATTRIB_OFFSET)

 #define PCMCIA_MEM_WIN_NO 		1
 #define PCMCIA_IO_WIN_NO 		2

-volatile unsigned short *pcmcia_macro_vaddr = NULL;
-
 #define PCMCIA_CTRL(offset)\
- ((volatile unsigned short *)((u8 *) pcmcia_macro_vaddr + (offset)))
+ ((volatile unsigned short *)((u8 *) pccf_4xx_macro_vaddr + (offset)))

 /* PCCF control registers are big-endian */

@@ -578,7 +557,7 @@
 	0,			/* No ISA interrupts */
 	PAGE_SIZE,		/* Window size granularity */
 	0,			/* io_offset */
-	CARD_IRQ,		/* Single fixed socket interrupt */
+	PCCF_4XX_CARD_IRQ,		/* Single fixed socket interrupt */
 	NULL,			/* No CardBus support */
 	NULL			/* No virtual bus operations */
 };
@@ -593,60 +572,6 @@
   Configuration-specific code
 ****************************************************************************/

-static void
-ebc_setup(void)
-{
-	/* Set up EBC bank 4 as per PCCF docs., assuming 66 MHz EBC bus. The
-	   ready timeout is set for 1024 cycles (~ 15 us at 66 MHz), unless
-	   someone else has already set it for 2048.  In the event of a
-	   timeout we'll get a Data Machine Check. */
-
-	unsigned long bits, mask, flags;
-
-	save_flags(flags);
-	cli();
-
-	/* Program EBC0_CFG for ready timeout */
-
-	mtdcr(DCRN_EBC0_CFGADDR, DCRN_EBC0_CFG);
-	bits = mfdcr(DCRN_EBC0_CFGDATA);
-	if (get_field32(bits, 2, 4) != 7)
-		mtdcr(DCRN_EBC0_CFGDATA, set_field32(bits, 2, 4, 6));
-
-	/* Program EBC bank properties : 32 MB, 16-bit RW bank;
-	   BME = 0, TWT = 22, CSN = 2, OEN = 3, WBN = WBF = 0, TH = 5,
-	   RE = 1, SOR = 0, BEM = 1 */
-
-	mtdcr(DCRN_EBC0_CFGADDR, DCRN_EBC0_B4CR);
-	mtdcr(DCRN_EBC0_CFGDATA, (PCMCIA_PADDR & 0xfff00000) | 0x000ba000);
-	mtdcr(DCRN_EBC0_CFGADDR, DCRN_EBC0_B4AP);
-	mtdcr(DCRN_EBC0_CFGDATA, 0x0b0b0b40);
-
-	/* Program the UIC for active-high, level-triggered interrupts.  Note
-	   that the active-low PCMCIA interrupt pin is inverted by the PCCF
-	   macro.  */
-
-	mask = (0x80000000 >> MACRO_IRQ) | (0x80000000 >> CARD_IRQ);
-
-	bits = mfdcr(DCRN_UIC0_PR);
-	bits |= mask;
-	mtdcr(DCRN_UIC0_PR, bits);
-
-	bits = mfdcr(DCRN_UIC0_TR);
-	bits &= ~mask;
-	mtdcr(DCRN_UIC0_TR, bits);
-
-#if defined(CONFIG_405LP)
-
-	/* Clear CPC0_CR0[PCMD] to enable the PCMCIA controller */
-
-	mtdcr(DCRN_CPC0_CR0, mfdcr(DCRN_CPC0_CR0) & ~0x00000200);
-
-#endif				/* CONFIG_405LP */
-
-	restore_flags(flags);
-}
-
 /* Voltage control.  See comments at the beginning of the file.

    The 'poweroff' situation is called out separately because we also use the
@@ -1036,10 +961,10 @@

 	if (state->flags & SS_IOCARD) {
 		pcmcia_io();
-		if (state->io_irq && (state->io_irq != CARD_IRQ)) {
+		if (state->io_irq && (state->io_irq != PCCF_4XX_CARD_IRQ)) {
 			printk(KERN_CRIT "pccf_4xx: io_irq requested as %d, "
 			       "should be %d. Aborting.\n",
-			       state->io_irq, CARD_IRQ);
+			       state->io_irq, PCCF_4XX_CARD_IRQ);
 			return -EINVAL;
 		}
 	} else {
@@ -1114,8 +1039,8 @@
 	map = io->map;

 	if ((io->map >= PCMCIA_IO_WIN_NO) ||
-	    (io->start >= PCMCIA_IO_WINSIZE) ||
-	    (io->stop >= PCMCIA_IO_WINSIZE) || (io->stop < io->start)) {
+	    (io->start >= PCCF_4XX_IO_WINSIZE) ||
+	    (io->stop >= PCCF_4XX_IO_WINSIZE) || (io->stop < io->start)) {
 		printk(KERN_ERR "pccf_4xx: set_io_map: Illegal "
 		       "IO map: map = %d, start = 0x%08x, stop = 0x%08x\n",
 		       io->map, io->start, io->stop);
@@ -1197,9 +1122,9 @@

 	if ((mem->map >= PCMCIA_MEM_WIN_NO) ||
 	    (mem->sys_start > mem->sys_stop) ||
-	    ((mem->sys_stop - mem->sys_start) >= PCMCIA_MEM_WINSIZE) ||
+	    ((mem->sys_stop - mem->sys_start) >= PCCF_4XX_MEM_WINSIZE) ||
 	    ((mem->card_start + (mem->sys_stop - mem->sys_start)) >=
-	     PCMCIA_MEM_WINSIZE)) {
+	     PCCF_4XX_MEM_WINSIZE)) {
 		DEBUG(4, "pccf_4xx: set_mem_map: Illegal "
 		      "memory map: map = %d, start = 0x%08lx, stop = 0x%08lx "
 		      "card_start = 0x%08x\n",
@@ -1217,7 +1142,7 @@
 		if (mem->flags & MAP_ATTRIB)
 			mem->sys_start = PCMCIA_ATTRIB_PADDR + mem->card_start;
 		else
-			mem->sys_start = PCMCIA_MEM_PADDR + mem->card_start;
+			mem->sys_start = PCCF_4XX_MEM_PADDR + mem->card_start;
 		mem->sys_stop += mem->sys_start;
 	}

@@ -1311,35 +1236,9 @@

 	printk(KERN_INFO "%s\n", version);

-	pcmcia_macro_vaddr = ioremap(PCMCIA_MACRO_PADDR, PCMCIA_MACRO_WINSIZE);
-
-	if (pcmcia_macro_vaddr == NULL) {
-		printk(KERN_ERR "pccf_4xx: ioremap macro at 0x%x failed.\n",
-		       PCMCIA_MACRO_PADDR);
-		return -EBUSY;
-	}
-
-	isa_io_base =
-	    (unsigned long) ioremap(PCMCIA_IO_PADDR, PCMCIA_IO_WINSIZE);
-
-	if (isa_io_base == 0) {
-		printk(KERN_ERR "pccf_4xx: ioremap io at 0x%x failed.\n",
-		       PCMCIA_IO_PADDR);
-		return -EBUSY;
-	}
-
-	isa_mem_base = (unsigned long) ioremap(PCMCIA_MEM_PADDR,
-					       PCMCIA_MEM_WINSIZE);
-
-	if (isa_mem_base == 0) {
-		printk(KERN_ERR "pccf_4xx: ioremap mem at 0x%x failed.\n",
-		       PCMCIA_MEM_PADDR);
-		return -EBUSY;
-	}
-
-	DEBUG(0, "pccf_4xx: Physical base address is 0x%08x\n", PCMCIA_PADDR);
+	DEBUG(0, "pccf_4xx: Physical base address is 0x%08lx\n", PCCF_4XX_PADDR);
 	DEBUG(0, "pccf_4xx: Virtual base addresses: macro=0x%p, mem=0x%lx"
-	      " io=0x%lx\n", pcmcia_macro_vaddr, _ISA_MEM_BASE, _IO_BASE);
+	      " io=0x%lx\n", pccf_4xx_macro_vaddr, _ISA_MEM_BASE, _IO_BASE);

 	CardServices(GetCardServicesInfo, &serv);
 	if (serv.Revision != CS_RELEASE_CODE) {
@@ -1350,7 +1249,6 @@
 		return -EBUSY;
 	}

-	ebc_setup();		/* Set up EBC (if not already) */
 	pcmcia_mrr();		/* Reset the PCCF Macro */
 	poweroff();		/* Make sure socket is powered down */
 	pcmcia_mask_cdi();	/* Mask card-detect interrupt */
@@ -1359,11 +1257,11 @@

 	/* Note that the PCMCIA macro interrupts are not shared. */

-	socket[0].intr = MACRO_IRQ;
+	socket[0].intr = PCCF_4XX_MACRO_IRQ;

-	if ((error = request_irq(MACRO_IRQ, pccf_4xx_interrupt, 0, "pcmcia",
+	if ((error = request_irq(PCCF_4XX_MACRO_IRQ, pccf_4xx_interrupt, 0, "pcmcia",
 				 &socket[0])) != 0) {
-		printk(KERN_ERR "pccf_4xx: IRQ %d not available!\n", MACRO_IRQ);
+		printk(KERN_ERR "pccf_4xx: IRQ %d not available!\n", PCCF_4XX_MACRO_IRQ);
 		return error;
 	}

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/pccf_4xx.h linux-bartholomew/include/asm-ppc/pccf_4xx.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/pccf_4xx.h	Thu Jan 01 10:00:00 1970
+++ linux-bartholomew/include/asm-ppc/pccf_4xx.h	Thu Jan 09 16:44:25 2003
@@ -0,0 +1,27 @@
+#ifndef __ASM_PCCF_4XX_H
+#define __ASM_PCCF_4XX_H
+
+/* Areas that we ioremap() are mapped only as large as necessary to get the job
+   done: Only a few locations of the macro space are used, and legacy IO space
+   is only 64 KB. There is 1 memory window, and 2 virtual IO windows. */
+
+#define PCCF_4XX_MACRO_OFFSET	0x00000000
+#define PCCF_4XX_MACRO_PADDR	(PCCF_4XX_PADDR + PCCF_4XX_MACRO_OFFSET)
+#define PCCF_4XX_MACRO_WINSIZE	PAGE_SIZE
+
+#define PCCF_4XX_MEM_OFFSET	0x01000000
+#define PCCF_4XX_MEM_PADDR	(PCCF_4XX_PADDR + PCCF_4XX_MEM_OFFSET)
+#define PCCF_4XX_MEM_WINSIZE	(8 * 1024 * 1024)
+
+#define PCCF_4XX_IO_OFFSET	0x01800000
+#define PCCF_4XX_IO_PADDR	(PCCF_4XX_PADDR + PCCF_4XX_IO_OFFSET)
+#define PCCF_4XX_IO_WINSIZE	0x00010000
+
+/* These are declared here, since the pccf_4xx driver needs them, but
+ * must be defined and initialized by the board setup code. */
+extern volatile u16 *pccf_4xx_macro_vaddr;
+extern unsigned long pccf_4xx_io_base;
+extern unsigned long pccf_4xx_mem_base;
+
+#endif /* __ASM_PCCF_4XX_H */
+

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
