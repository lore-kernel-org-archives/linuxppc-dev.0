Date: Thu, 21 Feb 2002 09:33:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Patch to make ppc_md.progress useful on 4xx
Message-ID: <20020221163347.GB719@opus.bloom.county>
References: <20020221005647.GA19976@zax> <3C740658.9060706@pacbell.net> <20020221042710.GA1658@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020221042710.GA1658@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Feb 21, 2002 at 03:27:10PM +1100, David Gibson wrote:
>
> On Wed, Feb 20, 2002 at 08:26:00PM +0000, Armin wrote:
> > David Gibson wrote:
> > >Currently, ppc_md.progress on 4xx just does a printk(), which means
> > >its messages won't be displayed until console_init() at which point
> > >it's usually too late to be useful.
> > >
> > >The patch below changes ppc4xx_progress() to write directly to the
> > >serial port.  I'd like to get comments before pushing the change,
> > >because I don't want to break 4xx machines that I don't have (and so
> > >can't test).
> > >
> > >At the moment it should only affect 405GP.  NP405H and NP405L support
> > >should be trivial (I've only refrained from adding it because I can't
> > >test it myself).  STBxxxx should be possible but will be much
> > >yuckier.  It would be nice to have it work on all 4xx though, to get
> > >rid of the nasty #ifdef in ppc4xx_setup.c.
> >
> > What Patch?
> >
> > I can test on some of the boards
>
> Ah, crud.  Forgot to attach it.  Ok, this time for sure.

It looks alright.  The thing is all of the systems which use an
ns1655x-style uart can use mostly the same code (provided a BAT or TLB
is setup for early access).  If you could try and forward port the
following (old, partially non applying I'm sure) patch that'd be great.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== include/asm-ppc/btext.h 1.3 vs edited =====
--- 1.3/include/asm-ppc/btext.h	Mon Aug 20 06:13:36 2001
+++ edited/include/asm-ppc/btext.h	Tue Sep 11 14:45:57 2001
@@ -5,6 +5,10 @@
  * Definitions for using the procedures in btext.c.
  *
  * Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *
+ * This is also a convenient place to place stuff for the NS1655x version
+ * of the ppc_md.progress routine.  -- Tom <trini@kernel.crashing.org>
+ *
  */
 #ifndef __PPC_BTEXT_H
 #define __PPC_BTEXT_H
@@ -19,6 +23,7 @@

 extern boot_infos_t *disp_bi;
 extern int boot_text_mapped;
+extern int mmu_is_setup;

 void btext_init(boot_infos_t *bi);
 void btext_welcome(boot_infos_t* bi);
===== arch/ppc/mm/init.c 1.52 vs edited =====
--- 1.52/arch/ppc/mm/init.c	Tue Aug 28 15:57:35 2001
+++ edited/arch/ppc/mm/init.c	Tue Sep 11 14:45:57 2001
@@ -345,14 +345,17 @@
 	/* Initialize the context management stuff */
 	mmu_context_init();

-	if (ppc_md.progress)
-		ppc_md.progress("MMU:exit", 0x211);
-
 #ifdef CONFIG_BOOTX_TEXT
 	/* Must be done last, or ppc_md.progress will die */
 	if (have_of)
 		map_boot_text();
 #endif
+#ifdef CONFIG_DEBUG_TEXT
+	mmu_is_setup = 1;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("MMU:exit", 0x211);
 }

 /* This is only called until mem_init is done. */
===== arch/ppc/kernel/Makefile 1.54 vs edited =====
--- 1.54/arch/ppc/kernel/Makefile	Mon Sep 10 19:01:27 2001
+++ edited/arch/ppc/kernel/Makefile	Tue Sep 11 14:45:57 2001
@@ -109,6 +109,7 @@
 					iSeries_dma.o iSeries_pic.o \
 					iSeries_misc.S
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
+obj-$(CONFIG_DEBUG_TEXT)	+= stext.o

 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_ALL_PPC)		+= pmac_smp.o chrp_smp.o
===== arch/ppc/kernel/prep_setup.c 1.46 vs edited =====
--- 1.46/arch/ppc/kernel/prep_setup.c	Sun Sep  9 12:28:35 2001
+++ edited/arch/ppc/kernel/prep_setup.c	Tue Sep 11 14:45:57 2001
@@ -93,6 +93,7 @@
 extern unsigned char pckbd_sysrq_xlate[128];

 extern void prep_find_bridges(void);
+extern void serial_progress(char *s, unsigned short hex);
 extern char saved_command_line[256];

 int _prep_type;
@@ -947,6 +948,9 @@
 	ppc_md.ppc_kbd_sysrq_xlate	 = pckbd_sysrq_xlate;
 	SYSRQ_KEY = 0x54;
 #endif
+#endif
+#ifdef CONFIG_DEBUG_TEXT
+	ppc_md.progress          = serial_progress;
 #endif

 #ifdef CONFIG_SMP
===== arch/ppc/kernel/zx4500_setup.c 1.8 vs edited =====
--- 1.8/arch/ppc/kernel/zx4500_setup.c	Fri Aug 17 16:00:50 2001
+++ edited/arch/ppc/kernel/zx4500_setup.c	Tue Sep 11 14:45:57 2001
@@ -58,6 +58,8 @@
 #include "mpc10x.h"
 #include "zx4500.h"

+extern void serial_progress(char *s, unsigned short hex);
+
 static u_char zx4500_openpic_initsenses[] __initdata = {
 	0,	/* 0-15 are not used on an 8240 EPIC */
 	0,	/* 1 */
@@ -291,41 +293,6 @@
 	return;
 }

-#ifdef	CONFIG_SERIAL_TEXT_DEBUG
-#include <linux/serialP.h>
-#include <linux/serial_reg.h>
-#include <asm/serial.h>
-
-static struct serial_state rs_table[RS_TABLE_SIZE] = {
-	SERIAL_PORT_DFNS	/* Defined in <asm/serial.h> */
-};
-
-void
-zx4500_progress(char *s, unsigned short hex)
-{
-	volatile char c;
-	volatile unsigned long com_port;
-	u16 shift;
-
-	com_port = rs_table[0].port;
-	shift = rs_table[0].iomem_reg_shift;
-
-	while ((c = *s++) != 0) {
-		while ((*((volatile unsigned char *)com_port +
-				(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-		                ;
-	        *(volatile unsigned char *)com_port = c;
-
-		if (c == '\n') {
-			while ((*((volatile unsigned char *)com_port +
-				(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-					;
-	        	*(volatile unsigned char *)com_port = '\r';
-		}
-	}
-}
-#endif	/* CONFIG_SERIAL_TEXT_DEBUG */
-
 void __init
 platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	      unsigned long r6, unsigned long r7)
@@ -372,11 +339,11 @@
 	ppc_md.heartbeat_reset = 0;
 	ppc_md.heartbeat_count = 0;

-#ifdef	CONFIG_SERIAL_TEXT_DEBUG
-	ppc_md.progress = zx4500_progress;
-#else	/* !CONFIG_SERIAL_TEXT_DEBUG */
+#ifdef CONFIG_DEBUG_TEXT
+	ppc_md.progress = serial_progress;
+#else
 	ppc_md.progress = NULL;
-#endif	/* CONFIG_SERIAL_TEXT_DEBUG */
+#endif

 	return;
 }
===== arch/ppc/kernel/mcpn765_setup.c 1.9 vs edited =====
--- 1.9/arch/ppc/kernel/mcpn765_setup.c	Fri Aug 17 16:00:49 2001
+++ edited/arch/ppc/kernel/mcpn765_setup.c	Tue Sep 11 14:45:57 2001
@@ -72,6 +72,7 @@

 extern u_int openpic_irq(void);
 extern char cmd_line[];
+extern void serial_progress(char *s, unsigned short hex);

 int use_of_interrupt_tree = 0;

@@ -79,7 +80,6 @@

 TODC_ALLOC();

-
 static void __init
 mcpn765_setup_arch(void)
 {
@@ -95,7 +95,7 @@
 		ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
 	else
 #endif
-#ifdef	CONFIG_ROOT_NFS
+#ifdef CONFIG_ROOT_NFS
 		ROOT_DEV = to_kdev_t(0x00FF);	/* /dev/nfs pseudo device */
 #else
 		ROOT_DEV = to_kdev_t(0x0802);	/* /dev/sda2 SCSI disk */
@@ -432,7 +432,7 @@
 		  mtspr 0x21f,%1\n \
 		  isync\n \
 		  sync "
-		:: "r" (bat3u), "r" (bat3l));
+		: "=r" (bat3u), "=r" (bat3l));

 		mapping_set = 1;
 	}
@@ -440,41 +440,6 @@
 	return;
 }

-#ifdef CONFIG_SERIAL_TEXT_DEBUG
-#include <linux/serialP.h>
-#include <linux/serial_reg.h>
-#include <asm/serial.h>
-
-static struct serial_state rs_table[RS_TABLE_SIZE] = {
-	SERIAL_PORT_DFNS	/* Defined in <asm/serial.h> */
-};
-
-void
-mcpn765_progress(char *s, unsigned short hex)
-{
-	volatile char c;
-	volatile unsigned long com_port;
-	u16 shift;
-
-	com_port = rs_table[0].port;
-	shift = rs_table[0].iomem_reg_shift;
-
-	while ((c = *s++) != 0) {
-		while ((*((volatile unsigned char *)com_port +
-				(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-		                ;
-	        *(volatile unsigned char *)com_port = c;
-
-		if (c == '\n') {
-			while ((*((volatile unsigned char *)com_port +
-				(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-					;
-	        	*(volatile unsigned char *)com_port = '\r';
-		}
-	}
-}
-#endif	/* CONFIG_SERIAL_TEXT_DEBUG */
-
 void __init
 platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	      unsigned long r6, unsigned long r7)
@@ -529,11 +494,11 @@
 	ppc_md.heartbeat_reset = 0;
 	ppc_md.heartbeat_count = 0;

-#ifdef	CONFIG_SERIAL_TEXT_DEBUG
-	ppc_md.progress = mcpn765_progress;
-#else	/* !CONFIG_SERIAL_TEXT_DEBUG */
+#ifdef CONFIG_DEBUG_TEXT
+	ppc_md.progress = serial_progress;
+#else
 	ppc_md.progress = NULL;
-#endif	/* CONFIG_SERIAL_TEXT_DEBUG */
+#endif

 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
         ppc_ide_md.insw = mcpn765_ide_insw;
===== arch/ppc/kernel/ppc4xx_setup.c 1.3 vs edited =====
--- 1.3/arch/ppc/kernel/ppc4xx_setup.c	Sun Sep  9 18:57:26 2001
+++ edited/arch/ppc/kernel/ppc4xx_setup.c	Tue Sep 11 14:45:57 2001
@@ -63,6 +63,7 @@
 #ifdef CONFIG_PCI
 extern void ppc4xx_find_bridges(void);
 #endif
+extern void serial_progress(char *s, unsigned short hex);

 #ifdef CONFIG_VT
 extern int pckbd_setkeycode(unsigned int scancode, unsigned int keycode);
@@ -515,7 +510,6 @@

 	ppc_md.find_end_of_memory = ppc4xx_find_end_of_memory;
 	ppc_md.setup_io_mappings = m4xx_map_io;
-	ppc_md.progress = NULL;

 #ifdef CONFIG_VT
 	ppc_md.kbd_setkeycode = pckbd_setkeycode;
@@ -535,6 +529,9 @@

 #ifdef CONFIG_MAGIC_SYSRQ
 	ppc_md.ppc_kbd_sysrq_xlate = NULL;
+#endif
+#ifdef CONFIG_DEBUG_TEXT
+	ppc_md.progress = serial_progress;
 #endif


===== arch/ppc/kernel/sandpoint_setup.c 1.11 vs edited =====
--- 1.11/arch/ppc/kernel/sandpoint_setup.c	Mon Sep 10 20:03:26 2001
+++ edited/arch/ppc/kernel/sandpoint_setup.c	Tue Sep 11 14:45:57 2001
@@ -102,6 +102,8 @@
 extern char pckbd_unexpected_up(unsigned char keycode);
 extern void pckbd_leds(unsigned char leds);
 extern void pckbd_init_hw(void);
+extern void serial_progress(char *s, unsigned short hex);
+
 extern unsigned char pckbd_sysrq_xlate[128];

 static void	sandpoint_halt(void);
@@ -569,7 +571,7 @@
 		  mtspr 0x21f,%1\n \
 		  isync\n \
 		  sync "
-		:: "r" (bat3u), "r" (bat3l));
+		: "=r" (bat3u), "=r" (bat3l));

 		mapping_set = 1;
 	}
@@ -577,43 +579,6 @@
 	return;
 }

-#ifdef	CONFIG_SERIAL_TEXT_DEBUG
-#include <linux/serialP.h>
-#include <linux/serial_reg.h>
-#include <asm/serial.h>
-
-static struct serial_state rs_table[RS_TABLE_SIZE] = {
-	SERIAL_PORT_DFNS	/* Defined in <asm/serial.h> */
-};
-
-void
-sandpoint_progress(char *s, unsigned short hex)
-{
-	volatile char c;
-	volatile unsigned long com_port;
-	u16 shift;
-
-	com_port = rs_table[0].port;
-	shift = rs_table[0].iomem_reg_shift;
-
-	while ((c = *s++) != 0) {
-		while ((*((volatile unsigned char *)com_port +
-				(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-		                ;
-	        *(volatile unsigned char *)com_port = c;
-
-		if (c == '\n') {
-			while ((*((volatile unsigned char *)com_port +
-				(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-					;
-	        	*(volatile unsigned char *)com_port = '\r';
-		}
-	}
-}
-#endif	/* CONFIG_SERIAL_TEXT_DEBUG */
-
-__init void sandpoint_setup_pci_ptrs(void);
-
 TODC_ALLOC();

 void __init
@@ -672,11 +637,11 @@
 	ppc_md.heartbeat_reset = 0;
 	ppc_md.heartbeat_count = 0;

-#ifdef	CONFIG_SERIAL_TEXT_DEBUG
-	ppc_md.progress = sandpoint_progress;
-#else	/* !CONFIG_SERIAL_TEXT_DEBUG */
+#ifdef CONFIG_DEBUG_TEXT
+	ppc_md.progress = serial_progress;
+#else
 	ppc_md.progress = NULL;
-#endif	/* CONFIG_SERIAL_TEXT_DEBUG */
+#endif

 #ifdef CONFIG_VT
 	ppc_md.kbd_setkeycode    = pckbd_setkeycode;
--- /dev/null
+++ arch/ppc/kernel/stext.c
/*
 * BK Id: %F% %I% %G% %U% %#%
 *
 * Procedures for printing to the serial port early on in the boot process.
 * This currently only works for NS1655x style uarts.  This won't work on
 * MPC8xx right now.
 *
 * Tom Rini <trini@kernel.crashing.org>
 */
#include <linux/serial.h>
#include <linux/serialP.h>
#include <linux/serial_reg.h>
#include <linux/init.h>
#include <asm/delay.h>
#include <asm/io.h>
#include <asm/serial.h>

int mmu_is_setup = 0;

static struct serial_state rs_table[RS_TABLE_SIZE] = {
	SERIAL_PORT_DFNS	/* Defined in <asm/serial.h> */
};
static unsigned long com_port;
static u16 shift;

/* Split this up into init, drawstring -> drawchar && drawhex (->drawchar) */

#if 0
/*
 * Setup where the serial port is, and what the register shift is, if any.
 */
void __init
serial_progress_init(void)
{
	/* We need to find out which type io we're expecting.  If it's
	 * 'SERIAL_IO_PORT', we get an offset from the isa_io_base.
	 * If it's 'SERIAL_IO_MEM', we can the exact location.  -- Tom */
	switch (rs_table[0].io_type) {
		case SERIAL_IO_PORT:
			com_port = rs_table[0].port;
			com_port += isa_io_base;
			break;
		case SERIAL_IO_MEM:
			com_port = (unsigned long)rs_table[0].iomem_base;
			break;
		default:
			/* We can't deal with it. */
			return;
	}
	shift = rs_table[0].iomem_reg_shift;
}
#endif

static void
serial_printchar(char c)
{
#if 0
	while ((inb(com_port + (UART_LSR << shift))
			& UART_LSR_THRE) == 0)
                ;
#else
	udelay(1000); /* 10ms */
#endif
	outb(c, com_port);
}

static void
serial_printhex(unsigned long v)
{
	static char hex_table[] = "0123456789abcdef";

	serial_printchar(hex_table[(v >> 28) & 0x0000000FUL]);
	serial_printchar(hex_table[(v >> 24) & 0x0000000FUL]);
	serial_printchar(hex_table[(v >> 20) & 0x0000000FUL]);
	serial_printchar(hex_table[(v >> 16) & 0x0000000FUL]);
	serial_printchar(hex_table[(v >> 12) & 0x0000000FUL]);
	serial_printchar(hex_table[(v >>  8) & 0x0000000FUL]);
	serial_printchar(hex_table[(v >>  4) & 0x0000000FUL]);
	serial_printchar(hex_table[(v >>  0) & 0x0000000FUL]);
}

/*
 * Take a message and a hex number, and then print
 */
void
serial_progress(char *s, unsigned short hex)
{
	char *div = " : 0x";

	/* If we aren't done twiddling with the MMU, we shouldn't try and
	 * touch thw HW.  A printk is safe tho. */
	if ( !mmu_is_setup ) {
		printk("%s : 0x%04x\n", s, hex);
		return;
	}

	/* Not quite right */
	/* We need to find out which type io we're expecting.  If it's
	 * 'SERIAL_IO_PORT', we get an offset from the isa_io_base.
	 * If it's 'SERIAL_IO_MEM', we can the exact location.  -- Tom */
	switch (rs_table[0].io_type) {
		case SERIAL_IO_PORT:
			com_port = rs_table[0].port;
//			com_port += isa_io_base;
			break;
		case SERIAL_IO_MEM:
			com_port = (unsigned long)rs_table[0].iomem_base;
			break;
		default:
			/* We can't deal with it. */
			return;
	}
	shift = rs_table[0].iomem_reg_shift;

	/* Print out the message we got. */
	while (*s)
		serial_printchar(*s++);

	/* Now print " : 0x" */
	while (*div)
		serial_printchar(*div++);

	/* Now the hex */
	serial_printhex(hex);

	/* Newline */
	serial_printchar('\r');
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
