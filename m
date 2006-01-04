Return-Path: <dhlii@comcast.net>
Received: from rwcrmhc12.comcast.net (unknown [216.148.227.153])
	by ozlabs.org (Postfix) with ESMTP id 71FC8689B0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 10:27:55 +1100 (EST)
Message-ID: <43BC57C1.6010807@comcast.net>
Date: Wed, 04 Jan 2006 18:18:25 -0500
From: "David H. Lynch Jr." <dhlii@comcast.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
References: <11359385991901-git-send-email-grant.likely@secretlab.ca>	<43B5E37A.4020008@dlasys.net>	<43B601CC.1000102@secretlab.ca>
	<43B6B32A.5060606@dlasys.net> <43B95448.3040407@secretlab.ca>
In-Reply-To: <43B95448.3040407@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: RESEND:[RFC] Pico E12 (Xilinx V4) patches to 2.6.15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

	Some sympathy and patience please. This is my first attempt to post a
patch. Many aspects are working. A few listed below, are not.
	
This is against
git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Signed-off-by: David H. Lynch Jr. <dhlii@dlasystems.net>

I could not figure out how to seek to the 2.6.14 tag so it is against
HEAD/2.6.15

I am also presuming that git diff produces a unified diff. I do not try
to read diffs - I typically do my diff/merges with vim, but it looks
about right to me.

There are basically 5 parts, and I have no idea how to easily separate
the pieces:
	1). Separating the Xilinx Virtex II Pro from the Xilinx Virtex IV. I
believe Grant and others have done this too, and this may conflict. Most
of these changes were "borrowed" from some 2.4 Linux stuff I got from
Xilinx.
	2). Pico E12 specific items.
	3). Implementation of the Xilinx UartLite serial port(s).
	4). Implementation of a pseudo serial port(s) driver for the Pico
Keyhole port. The keyhole is a port-port interface between the E12 and a
host computer over the CF connector.
	5). a collection of flyspecks of debugging code scattered all over.

	Status/Overview:

		The Pico E12 is a Virtex IV/PPC405 implemented on a CF card.  The
objective is to leave as much of the FPGA free for the development of
application specific logic. Pico provides their own SDK that includes
Both windows and Linux host/development software. That software
impliments a filesystem on the E12 flash, as well as loading and
executing FPGA .bit files, and .elf files.
	The kernel built from this patch:
		will load with a modified version of the standard Pico loader - either
they are including my trivial modifications, or I am working on moving
them into the kernel boot code.
		Runs on the Xilinx V4/PPC405 in the current E12's.
		Requires an FPGA image with only the PPC405 and either the Xilinx
UartLite or the Pico Keyhole. Use of the Xilinx PIC is optional, and is
currently controlled by the xparameter_pico-e12.h file
		At this instant everything works up through and including loading
/init (or a standalone shell). Executing init or a standalone shell does
not appear to work - or more accurately console IO ceases without
explanation when either /init or a shell start.
		Console input from the Keyhole port does not work - neither the host
side not the kernel side are implemented.
		Console input from the Uartlite is pretty much untested.
		Boot/debugging "console" support for both the UartLite and Keyhole are
implemented to the same level as similar facilities exist for the 8250.

diff --git a/README.pico b/README.pico
new file mode 120000
index 0000000..3daad5a
--- /dev/null
+++ b/README.pico
@@ -0,0 +1 @@
+pico/README.pico
\ No newline at end of file
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index cc3f64c..7c4318a 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -53,7 +53,7 @@ menu "Processor"

 choice
 	prompt "Processor Type"
-	default 6xx
+	default 4xx

 config 6xx
 	bool "6xx/7xx/74xx/52xx/82xx/83xx"
diff --git a/arch/ppc/boot/common/misc-common.c
b/arch/ppc/boot/common/misc-common.c
index e79e6b3..a50762a 100644
--- a/arch/ppc/boot/common/misc-common.c
+++ b/arch/ppc/boot/common/misc-common.c
@@ -57,10 +57,15 @@ static int _cvt(unsigned long val, char

 void _vprintk(void(*putc)(const char), const char *fmt0, va_list ap);
 unsigned char *ISA_io = NULL;
+#ifdef CONFIG_PICO_E12
+unsigned int *ISA_iow = NULL;
+#endif

 #if defined(CONFIG_SERIAL_CPM_CONSOLE) ||
defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)\
+	|| defined(CONFIG_SERIAL_KEYHOLE_CONSOLE)
 extern unsigned long com_port;

 extern int serial_tstc(unsigned long com_port);
@@ -83,7 +88,9 @@ int tstc(void)
 {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) ||
defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE) \
+	|| defined(CONFIG_SERIAL_KEYHOLE_CONSOLE)
 	if(keyb_present)
 		return (CRT_tstc() || serial_tstc(com_port));
 	else
@@ -98,7 +105,9 @@ int getc(void)
 	while (1) {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) ||
defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE) \
+	|| defined(CONFIG_SERIAL_KEYHOLE_CONSOLE)
 		if (serial_tstc(com_port))
 			return (serial_getc(com_port));
 #endif /* serial console */
@@ -115,7 +124,9 @@ putc(const char c)

 #if defined(CONFIG_SERIAL_CPM_CONSOLE) ||
defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE) \
+	|| defined(CONFIG_SERIAL_KEYHOLE_CONSOLE)
 	serial_putc(com_port, c);
 	if ( c == '\n' )
 		serial_putc(com_port, '\r');
@@ -164,7 +175,9 @@ void puts(const char *s)
 	while ( ( c = *s++ ) != '\0' ) {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) ||
defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE) \
+	|| defined(CONFIG_SERIAL_KEYHOLE_CONSOLE)
 	        serial_putc(com_port, c);
 	        if ( c == '\n' ) serial_putc(com_port, '\r');
 #endif /* serial console */
@@ -271,6 +284,15 @@ void gunzip(void *dst, int dstlen, unsig
 	*lenp = s.next_out - (unsigned char *) dst;
 	zlib_inflateEnd(&s);
 }
+#if 0
+void
+puthexb(unsigned char val)
+{
+	char digits[] = "0123456789abcdef" ;
+	putc(digits[(val/16) & 0x0F]);
+	putc(digits[val & 0x0F]);
+}
+#endif

 void
 puthex(unsigned long val)
@@ -488,8 +510,13 @@ _dump_buf_with_offset(unsigned char *p,
 			{
 				_printk("  ");
 			}
+#if defined(CONFIG_PICO_DEBUG)
+// more readable dump
+			 _printk(" ");
+#else
 			if ((i % 2) == 1) _printk(" ");
 			if ((i % 8) == 7) _printk(" ");
+#endif
 		}
 		_printk(" |");
 		for (i = 0;  i < 16;  i++)
diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
index f3e9c53..3094f1c 100644
--- a/arch/ppc/boot/simple/Makefile
+++ b/arch/ppc/boot/simple/Makefile
@@ -188,6 +188,7 @@ OBJCOPY_ARGS			:= -O elf32-powerpc
 boot-y				:= head.o relocate.o $(extra.o-y) $(misc-y)
 boot-$(CONFIG_REDWOOD_5)	+= embed_config.o
 boot-$(CONFIG_REDWOOD_6)	+= embed_config.o
+boot-$(CONFIG_PICO_E12)		+= embed_config.o
 boot-$(CONFIG_8xx)		+= embed_config.o
 boot-$(CONFIG_8260)		+= embed_config.o
 boot-$(CONFIG_BSEIP)		+= iic.o
@@ -202,6 +203,16 @@ boot-$(CONFIG_8260)		+= m8260_tty.o
 endif
 boot-$(CONFIG_SERIAL_MPC52xx_CONSOLE)	+= mpc52xx_tty.o
 boot-$(CONFIG_SERIAL_MPSC_CONSOLE)	+= mv64x60_tty.o
+boot-$(CONFIG_SERIAL_UARTLITE_CONSOLE)	+= uartlite_tty.o
+boot-$(CONFIG_SERIAL_KEYHOLE_CONSOLE)	+= keyhole_tty.o
+#ifdef CONFIG_XILINX_UARTLITE_CONSOLE
+#LIBS				+= $(TOPDIR)/drivers/char/xilinx_uartlite/xuartlite_l.o
+#endif
+# ifeq ($(CONFIG_XILINX_ML300),y)
+# CFLAGS_xuartlite_tty.o		+= -I$(TOPDIR)/drivers/char/xilinx_uartlite
+# EXTRA_CFLAGS			+= -I$(TOPDIR)/arch/ppc/platforms/xilinx_ocp \
+# 					-I$(TOPDIR)/drivers/i2c/xilinx_iic
+# endif

 LIBS				:= $(common)/lib.a $(bootlib)/lib.a
 ifeq ($(CONFIG_PPC_PREP),y)
diff --git a/arch/ppc/boot/simple/embed_config.c
b/arch/ppc/boot/simple/embed_config.c
index 491a691..c4a19ce 100644
--- a/arch/ppc/boot/simple/embed_config.c
+++ b/arch/ppc/boot/simple/embed_config.c
@@ -781,6 +781,49 @@ embed_config(bd_t ** bdp)
 }
 #endif /* CONFIG_XILINX_ML300 */

+#ifdef CONFIG_PICO_E12
+void
+embed_config(bd_t ** bdp)
+{
+	static const unsigned long line_size = 32;
+	static const unsigned long congruence_classes = 256;
+	unsigned long addr;
+	unsigned long dccr;
+	u_char	*cp;
+	int	i;
+	bd_t *bd;
+
+	/*
+	 * Invalidate the data cache if the data cache is turned off.
+	 * - The 405 core does not invalidate the data cache on power-up
+	 *   or reset but does turn off the data cache. We cannot assume
+	 *   that the cache contents are valid.
+	 * - If the data cache is turned on this must have been done by
+	 *   a bootloader and we assume that the cache contents are
+	 *   valid.
+	 */
+	__asm__("mfdccr %0": "=r" (dccr));
+	if (dccr == 0) {
+		for (addr = 0;
+		     addr < (congruence_classes * line_size);
+		     addr += line_size) {
+			__asm__("dccci 0,%0": :"b"(addr));
+		}
+	}
+
+	bd = &bdinfo;
+	*bdp = bd;
+	bd->bi_memsize = (XPAR_PLB_SDRAM_0_HIGHADDR +1);
+	bd->bi_intfreq = XPAR_CORE_CLOCK_FREQ_HZ;
+	bd->bi_busfreq = XPAR_PLB_CLOCK_FREQ_HZ;
+	timebase_period_ns = 1000000000 / bd->bi_tbfreq;
+	/* see bi_tbfreq definition in arch/ppc/platforms/4xx/xilinx_ml300.h */
+	cp = (u_char *)def_enet_addr;
+	for (i=0; i<6; i++) {
+		bd->bi_enetaddr[i] = *cp++;
+	}
+}
+#endif /* CONFIG_PICO_E12 */
 #ifdef CONFIG_IBM_OPENBIOS
 /* This could possibly work for all treeboot roms.
 */
diff --git a/arch/ppc/boot/simple/head.S b/arch/ppc/boot/simple/head.S
index 5e4adc2..e432b64 100644
--- a/arch/ppc/boot/simple/head.S
+++ b/arch/ppc/boot/simple/head.S
@@ -46,6 +46,46 @@ start:
 #endif

 start_:
+#if defined(CONFIG_XILINX_ML300) || defined(CONFIG_PICO_E12) /* PPC
errata 213: only for Virtex-4 */
+	mfccr0	0
+	oris	0,0,0x50000000@h
+	mtccr0	0
+#endif
+
+#if defined(CONFIG_PICO_E12) && defined(CONFIG_PICO_DEBUG) && 0
+// this is preliminary code to get the kernel to work with the Standard
Pico Monitor/load
+	khdbg(0x1a100)
+// Start by disabling MMU - the mappings are
+// 1-1 so this should not cause any problems
+	mfmsr	r8	
+	andi.	r8,r8,(!(MSR_IR|MSR_DR))@l	
+	mtmsr	r8
+	khdbg(0x1a101)
+	khdbgr(r8)
+
+// Now set up parameters to jump into linux
+
+	addis	r8,0,8
+	addis	r8,0,0		// create some stack space for Linux
+	khdbgr(r8)
+
+	subi	r8,r8,129
+	khdbgr(r8)
+	andi.	r8,r8,(!7)@l	
+	khdbgr(r8)
+	subi	r8,r8,4		// make room for null commandline
+	khdbgr(r8)
+	li      r3,0		
+	stw 	r3,0(r8) 	// set null commandline	
+	mr	r3,r8		// set board info to point to nulls on stack
+	mr 	r4,r8		// set command line to point to nulls on stack
+
+	khdbg(0x1b100)
+	khdbgr(r3)
+	khdbgr(r4)
+
+#endif
+
 #ifdef CONFIG_FORCE
 	/* We have some really bad firmware.  We must disable the L1
 	 * icache/dcache now or the board won't boot.
@@ -57,7 +97,7 @@ start_:
 	isync
 #endif

-#if defined(CONFIG_MBX) || defined(CONFIG_RPX8260) ||
defined(CONFIG_PPC_PREP)
+#if defined(CONFIG_MBX) || defined(CONFIG_RPX8260) ||
defined(CONFIG_PPC_PREP) || defined(CONFIG_PICO_E12)
 	mr	r29,r3	/* On the MBX860, r3 is the board info pointer.
 			 * On the RPXSUPER, r3 points to the NVRAM
 			 * configuration keys.
diff --git a/arch/ppc/boot/simple/keyhole_tty.c
b/arch/ppc/boot/simple/keyhole_tty.c
new file mode 100644
index 0000000..ab07ca8
--- /dev/null
+++ b/arch/ppc/boot/simple/keyhole_tty.c
@@ -0,0 +1,93 @@
+/*
+ * arch/ppc/boot/simple/keyhole_tty.c
+ *
+ * Bootloader version of the embedded Xilinx/KEYHOLE driver.
+ *
+ * Author: David H. Lynch Jr. <dhlii@dlasys.net>
+ *
+ * 2005 (c) DLA Systems  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/serial_keyhole.h>
+
+static int MillisecTimeout=1000;
+void usleep(int t) {
+   int ii, waitTime=100;
+    while(t) {
+    	for (ii=0; ii < MillisecTimeout*1000/waitTime; ii++){};
+	t--;
+    }
+}
+
+//Output one 32bit value thru the keyhole.
+static int Koutput(unsigned long cmd, unsigned long kh) {
+	unsigned int status;
+
+	for (;;) {
+		status = serial_in32(XPAR_KEYHOLE, UART_LSR);
+		if ((status & UART_LSR_TXF) == 0) {
+			//careful about the order here. data must be sent last.
+			serial_out32(XPAR_KEYHOLE, UART_LCR,cmd);
+			serial_out32(XPAR_KEYHOLE, UART_TX,kh);    //triggers fifo write
+			return 1;
+		}
+        	usleep(100); //wait if ppc2pc fifo is almost full.
+		// cpu_relax();
+	}
+	return -1;
+} //Koutput...
+
+unsigned long
+serial_init(int chan, void *ignored)
+{
+	return (XPAR_KEYHOLE);
+}
+
+void
+serial_putc(unsigned long com_port, unsigned char c)
+{
+  	KEYHOLE_DATA kh;
+
+	if (c == '\r') return;
+    	kh.u32 = 0; kh.packetType = KHC_FMTD; kh.countWords = 3;
+	Koutput(KH_BEGIN, kh.u32) ;
+	kh.u32 = 0;
+	kh.asci0 = c;
+        Koutput(KH_STR, kh.u32);
+	Koutput(KH_END, kh.u32);
+}
+
+void
+keyhole_puts(char *s)
+{
+	volatile unsigned int progress_debugport;
+	volatile char c;
+
+	progress_debugport = XPAR_KEYHOLE;
+	while ((c = *s++) != 0)
+		serial_putc(progress_debugport, c);
+
+	serial_putc(progress_debugport, '\n');
+	serial_putc(progress_debugport, '\r');
+}
+
+unsigned char
+serial_getc(unsigned long com_port)
+{
+	return '\0';
+}
+
+int
+serial_tstc(unsigned long com_port)
+{
+	return 0;
+}
+
+void
+serial_close(unsigned long com_port)
+{
+}
diff --git a/arch/ppc/boot/simple/misc-embedded.c
b/arch/ppc/boot/simple/misc-embedded.c
index 3865f3f..4d50b19 100644
--- a/arch/ppc/boot/simple/misc-embedded.c
+++ b/arch/ppc/boot/simple/misc-embedded.c
@@ -23,6 +23,12 @@

 #include "nonstdio.h"

+#if defined(CONFIG_PICO_DEBUG)
+#define DEBUG_PRINTK(fmt...)	_printk(fmt)
+#else
+#define DEBUG_PRINTK(fmt...)	do { } while (0)
+#endif
+
 /* The linker tells us where the image is. */
 extern char __image_begin, __image_end;
 extern char __ramdisk_begin, __ramdisk_end;
@@ -90,7 +96,7 @@ load_kernel(unsigned long load_addr, int
 	 * initialize the serial console port.
 	 */
 	embed_config(&bp);
-#if defined(CONFIG_SERIAL_CPM_CONSOLE) ||
defined(CONFIG_SERIAL_8250_CONSOLE)
+#if defined(CONFIG_SERIAL_CPM_CONSOLE) ||
defined(CONFIG_SERIAL_8250_CONSOLE) ||
defined(CONFIG_SERIAL_UARTLITE_CONSOLE) ||
defined(CONFIG_SERIAL_KEYHOLE_CONSOLE)
 	com_port = serial_init(0, bp);
 #endif

@@ -133,6 +139,12 @@ load_kernel(unsigned long load_addr, int
 		puts(" ");
 		puthex((unsigned long)((unsigned long)hold_residual + sizeof(bd_t)));
 		puts("\n");
+// things I want to know
+		//_printk("misc-embedded:load_kernel()\n") ;
+		_printk("memsize:\t%d, %d\n", bp->bi_memsize,
(bp->bi_memsize/(1024*1024))) ;
+		_printk("int  clock:\t%d, %d\n", bp->bi_intfreq,
(bp->bi_intfreq/(1000*1000))) ;
+		_printk("plb_bus clock:\t%d, %d\n", bp->bi_busfreq,
(bp->bi_busfreq/(1000*1000))) ;
+		puts("\n");
 	}

 	/*
@@ -180,11 +192,16 @@ load_kernel(unsigned long load_addr, int
 #ifdef CONFIG_CMDLINE_BOOL
 	memcpy (cmd_line, compiled_string, sizeof(compiled_string));
 #else
+// INITRAMFS and initrd should be handled the same.
+#ifdef CONFIG_INITRAMFS_SOURCE
+	memcpy (cmd_line, ramroot_string, sizeof(ramroot_string));
+#else
 	if ( initrd_size )
 		memcpy (cmd_line, ramroot_string, sizeof(ramroot_string));
 	else
 		memcpy (cmd_line, netroot_string, sizeof(netroot_string));
 #endif
+#endif
 	while ( *cp )
 		putc(*cp++);
 	while (timer++ < 5*1000) {
@@ -267,7 +284,11 @@ load_kernel(unsigned long load_addr, int
 		rec = (struct bi_record *)((unsigned long)rec + rec->size);
 	}
 	puts("Now booting the kernel\n");
-#if defined(CONFIG_SERIAL_CPM_CONSOLE) ||
defined(CONFIG_SERIAL_8250_CONSOLE)
+#if defined(CONFIG_SERIAL_CPM_CONSOLE) ||
defined(CONFIG_SERIAL_8250_CONSOLE) ||
defined(CONFIG_SERIAL_UARTLITE_CONSOLE) ||
defined(CONFIG_SERIAL_KEYHOLE_CONSOLE)
+	// _dump_buf(0,256);
+	// _dump_buf(0x22a0,256);
+	// _dump_buf(0x400000,256);
+
 	serial_close(com_port);
 #endif

diff --git a/arch/ppc/boot/simple/misc.c b/arch/ppc/boot/simple/misc.c
index f415d6c..ca69480 100644
--- a/arch/ppc/boot/simple/misc.c
+++ b/arch/ppc/boot/simple/misc.c
@@ -52,6 +52,8 @@
 	|| defined(CONFIG_VGA_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)) \
+	|| defined(CONFIG_SERIAL_KEYHOLE_CONSOLE)) \
 	&& !defined(CONFIG_GEMINI)
 #define INTERACTIVE_CONSOLE	1
 #endif
diff --git a/arch/ppc/boot/simple/uartlite_tty.c
b/arch/ppc/boot/simple/uartlite_tty.c
new file mode 100644
index 0000000..f491b55
--- /dev/null
+++ b/arch/ppc/boot/simple/uartlite_tty.c
@@ -0,0 +1,100 @@
+/*
+ * arch/ppc/boot/simple/uartlite_tty.c
+ *
+ * Bootloader version of the embedded Xilinx/UARTLITE driver.
+ *
+ *  Author: David H. Lynch Jr. <dhlii@dlasys.net>
+ *  Copyright (C) 2005 DLA Systems
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
 USA
+ *
+ *  $Id: uartlite.c,v 0.10 2005/12/14 10:03:27 dhlii Exp $
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/serial.h>
+#include <asm/serial.h>
+#include "nonstdio.h"
+#include "serial.h"
+
+#include <linux/serial_uartlite.h>
+
+
+static struct serial_state rs_table[RS_TABLE_SIZE] = {
+	SERIAL_PORT_DFNS	/* Defined in <asm/serial.h> */
+};
+
+static int shift;
+
+unsigned long
+serial_init(int chan, void *ignored)
+{
+	unsigned long com_port;
+
+	/* We need to find out which type io we're expecting.  If it's
+	 * 'SERIAL_IO_PORT', we get an offset from the isa_io_base.
+	 * If it's 'SERIAL_IO_MEM', we can the exact location.  -- Tom */
+	switch (rs_table[chan].io_type) {
+		case SERIAL_IO_PORT:
+			com_port = rs_table[chan].port;
+			break;
+		case SERIAL_IO_MEM:
+			com_port = (unsigned long)rs_table[chan].iomem_base;
+			break;
+		default:
+			/* We can't deal with it. */
+			return -1;
+	}
+
+	/* How far apart the registers are. */
+	shift = rs_table[chan].iomem_reg_shift;
+	return (com_port);
+}
+
+void
+serial_putc(unsigned long com_port, unsigned char c)
+{
+    unsigned int status ;
+    do {
+	    status =  serial_in32(com_port, UART_LSR);
+    } while ( status & UART_LSR_TXF);
+    serial_out32(com_port, UART_TX, c);
+}
+
+unsigned char
+serial_getc(unsigned long com_port)
+{
+	unsigned int status ;
+	return 0;
+	do {
+		status = serial_in32(com_port, UART_LSR);
+	}	while ((status  & UART_LSR_DR) == 0) ;
+	return serial_in32(com_port, UART_RX);
+}
+
+int
+serial_tstc(unsigned long com_port)
+{
+	unsigned int status ;
+	return 0;
+	status = serial_in32(com_port, UART_LSR);
+	return (status & UART_LSR_DR);
+}
+
+void
+serial_close(unsigned long com_port)
+{
+}
diff --git a/arch/ppc/configs/pico_e12_defconfig
b/arch/ppc/configs/pico_e12_defconfig
new file mode 100644
index 0000000..ac538d9
--- /dev/null
+++ b/arch/ppc/configs/pico_e12_defconfig
@@ -0,0 +1,580 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.15
+# Tue Jan  3 18:38:41 2006
+#
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+# CONFIG_SYSVIPC is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_SYSCTL is not set
+# CONFIG_HOTPLUG is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_INITRAMFS_SOURCE="/initramfs"
+CONFIG_INITRAMFS_ROOT_UID=0
+CONFIG_INITRAMFS_ROOT_GID=0
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+# CONFIG_MODULE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+# CONFIG_KMOD is not set
+
+#
+# Block layer
+#
+# CONFIG_LBD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
+
+#
+# Processor
+#
+# CONFIG_6xx is not set
+CONFIG_40x=y
+# CONFIG_44x is not set
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+# CONFIG_8xx is not set
+# CONFIG_E200 is not set
+# CONFIG_E500 is not set
+CONFIG_MATH_EMULATION=y
+# CONFIG_KEXEC is not set
+# CONFIG_CPU_FREQ is not set
+CONFIG_4xx=y
+# CONFIG_WANT_EARLY_SERIAL is not set
+
+#
+# IBM 4xx options
+#
+# CONFIG_BUBINGA is not set
+# CONFIG_CPCI405 is not set
+# CONFIG_EP405 is not set
+# CONFIG_REDWOOD_5 is not set
+# CONFIG_REDWOOD_6 is not set
+# CONFIG_SYCAMORE is not set
+# CONFIG_WALNUT is not set
+# CONFIG_XILINX_ML300 is not set
+CONFIG_PICO_E12=y
+CONFIG_IBM405_ERR77=y
+CONFIG_IBM405_ERR51=y
+CONFIG_XILINX_OCP=y
+CONFIG_VIRTEX_IV=y
+CONFIG_EMBEDDEDBOOT=y
+CONFIG_PICO_DEBUG=y
+# CONFIG_PPC4xx_DMA is not set
+CONFIG_UART0_TTYS0=y
+# CONFIG_UART0_TTYS1 is not set
+CONFIG_NOT_COHERENT_CACHE=y
+
+#
+# Platform options
+#
+# CONFIG_PC_KEYBOARD is not set
+# CONFIG_HIGHMEM is not set
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_CMDLINE="console=ttyS0 initcall_debug loglevel=7 S"
+# CONFIG_CMDLINE="console=uartlite console=ttyS0
earlyprintk=uartlite,ttyS0 initcall_debug loglevel=7 S"
+# CONFIG_PM is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
+# CONFIG_SECCOMP is not set
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+# CONFIG_PPC_I8259 is not set
+# CONFIG_PCI is not set
+# CONFIG_PCI_DOMAINS is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# Advanced setup
+#
+CONFIG_ADVANCED_OPTIONS=y
+CONFIG_HIGHMEM_START=0xfe000000
+# CONFIG_LOWMEM_SIZE_BOOL is not set
+CONFIG_LOWMEM_SIZE=0x30000000
+# CONFIG_KERNEL_START_BOOL is not set
+CONFIG_KERNEL_START=0xc0000000
+# CONFIG_TASK_SIZE_BOOL is not set
+CONFIG_TASK_SIZE=0x80000000
+# CONFIG_CONSISTENT_START_BOOL is not set
+CONFIG_CONSISTENT_START=0xff100000
+# CONFIG_CONSISTENT_SIZE_BOOL is not set
+CONFIG_CONSISTENT_SIZE=0x00200000
+# CONFIG_BOOT_LOAD_BOOL is not set
+CONFIG_BOOT_LOAD=0x00400000
+
+#
+# Networking
+#
+# CONFIG_NET is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+CONFIG_DEBUG_DRIVER=y
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=8192
+# CONFIG_BLK_DEV_INITRD is not set
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# I2O device support
+#
+
+#
+# Macintosh device drivers
+#
+# CONFIG_WINDFARM is not set
+
+#
+# Network device support
+#
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+CONFIG_SERIAL_NONSTANDARD=y
+# CONFIG_COMPUTONE is not set
+# CONFIG_ROCKETPORT is not set
+# CONFIG_CYCLADES is not set
+# CONFIG_DIGIEPCA is not set
+# CONFIG_MOXA_INTELLIO is not set
+# CONFIG_MOXA_SMARTIO is not set
+# CONFIG_ISI is not set
+# CONFIG_SYNCLINKMP is not set
+# CONFIG_N_HDLC is not set
+# CONFIG_RISCOM8 is not set
+# CONFIG_SPECIALIX is not set
+# CONFIG_SX is not set
+# CONFIG_RIO is not set
+# CONFIG_STALDRV is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_UARTLITE=y
+CONFIG_SERIAL_UARTLITE_CONSOLE=y
+CONFIG_SERIAL_UARTLITE_NR_UARTS=1
+# CONFIG_SERIAL_KEYHOLE is not set
+# CONFIG_SERIAL_KEYHOLE_CONSOLE=y
+CONFIG_SERIAL_KEYHOLE_DEBUG=y
+# CONFIG_SERIAL_KEYHOLE_NR_UARTS=1
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+
+#
+# Xilinx uartlite devices
+#
+# CONFIG_XILINX_UARTLITE is not set
+CONFIG_UNIX98_PTYS=y
+# CONFIG_LEGACY_PTYS is not set
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_AGP is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+# CONFIG_TELCLOCK is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+# CONFIG_HWMON is not set
+# CONFIG_HWMON_VID is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia Capabilities Port drivers
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+
+#
+# SN Devices
+#
+
+#
+# File systems
+#
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_INOTIFY is not set
+# CONFIG_QUOTA is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_RELAYFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+
+#
+# IBM 40x options
+#
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC32 is not set
+# CONFIG_LIBCRC32C is not set
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_INFO is not set
+CONFIG_DEBUG_FS=y
+# CONFIG_DEBUG_VM is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_KGDB is not set
+# CONFIG_KGDB_TTYS0=y
+# CONFIG_KGDB_TTYS1 is not set
+# CONFIG_KGDB_TTYS2 is not set
+# CONFIG_KGDB_TTYS3 is not set
+# CONFIG_XMON is not set
+# CONFIG_BDI_SWITCH is not set
+CONFIG_SERIAL_TEXT_DEBUG=y
+CONFIG_PPC_OCP=y
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
diff --git a/arch/ppc/kernel/head_4xx.S b/arch/ppc/kernel/head_4xx.S
index 10c261c..c08aa7f 100644
--- a/arch/ppc/kernel/head_4xx.S
+++ b/arch/ppc/kernel/head_4xx.S
@@ -75,13 +75,25 @@ _GLOBAL(_start)
  * ready to work.
  */
 turn_on_mmu:
+#if 0						// debuging code used to find the spurious E12 machine check
problem
+	khdbg(0x57002)
+
+#if defined(CONFIG_PICO_DEBUG) && 0
+	bl	pico_dbg
+#endif
+#endif
 	lis	r0,MSR_KERNEL@h
 	ori	r0,r0,MSR_KERNEL@l
 	mtspr	SPRN_SRR1,r0
-	lis	r0,start_here@h
+	lis	r0,start_here@h			// SPRN_SRR0 is where the rfi resumes execution
 	ori	r0,r0,start_here@l
 	mtspr	SPRN_SRR0,r0
 	SYNC
+// 	PPC405_ERR77_SYNC
+/* We now have the lower 16 Meg mapped into TLB entries, and the caches
+ * ready to work.
+ */
+
 	rfi				/* enables MMU */
 	b	.			/* prevent prefetch past rfi */

@@ -364,6 +376,9 @@ label:
 	b	.		/* prevent prefetch past rfi */

 2:
+	// khdbg(0x55001)
+	// khdbgr(r16)
+	
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
@@ -478,8 +493,11 @@ label:
 	mtspr	SPRN_SPRG7, r11
 	mtspr	SPRN_SPRG6, r12
 #endif
-	mfspr	r10, SPRN_DEAR		/* Get faulting address */

+	// khdbg(0x55000)
+	// khdbgr(r16)
+	mfspr	r10, SPRN_DEAR		/* Get faulting address */
+	// khdbgr(r10)
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
@@ -521,6 +539,8 @@ label:
 	b	finish_tlb_load

 2:	/* Check for possible large-page pmd entry */
+	// khdbg(0x55002)
+	// khdbgr(r16)
 	rlwinm.	r9, r12, 2, 22, 24
 	beq	5f

@@ -621,6 +641,9 @@ label:
 	b	finish_tlb_load

 2:	/* Check for possible large-page pmd entry */
+	// khdbg(0x55003)
+	// khdbgr(r16)
+
 	rlwinm.	r9, r12, 2, 22, 24
 	beq	5f

@@ -732,7 +755,10 @@ label:
 	b	.

 	/* continue normal handling for a critical exception... */
-2:	mfspr	r4,SPRN_DBSR
+2:	
+	// khdbg(0x55004)
+	// khdbgr(r16)
+	mfspr	r4,SPRN_DBSR
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_TEMPLATE(DebugException, 0x2002, \
 		(MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
@@ -769,6 +795,7 @@ DataAccess:
 tlb_4xx_index:
 	.long	0
 finish_tlb_load:
+	// khdbg(0x54002)
 	/* load the next available TLB index.
 	*/
 	lwz	r9, tlb_4xx_index@l(0)
@@ -823,6 +850,11 @@ _GLOBAL(giveup_fpu)
  */
 start_here:

+#if defined(CONFIG_PICO_DEBUG) && 0
+	khdbg(0x56001)
+	addi	r16,r16,1
+#endif
+
 	/* ptr to current */
 	lis	r2,init_task@h
 	ori	r2,r2,init_task@l
@@ -914,7 +946,7 @@ initial_mmu:

 	/* Load the kernel PID.
 	*/
-	li	r0,0
+	li	r0,0			/* Kernel Process ID = 0 */
 	mtspr	SPRN_PID,r0
 	sync

@@ -933,6 +965,24 @@ initial_mmu:

 	tlbwe	r4,r0,TLB_DATA		/* Load the data portion of the entry */
 	tlbwe	r3,r0,TLB_TAG		/* Load the tag portion of the entry */
+// -------
+/* create a temp entry mapping virtual 0 to physical 0 */
+
+#if defined(CONFIG_PICO_E12) && 0
+	lis	r3,0			
+	ori	r3,r3,0
+	addi	r4,r3,0
+
+	clrrwi	r4,r4,10		/* Mask off the real page number */
+	ori	r4,r4,(TLB_WR | TLB_EX)	/* Set the write and execute bits */
+
+	clrrwi	r3,r3,10		/* Mask off the effective page number */
+	ori	r3,r3,(TLB_VALID | TLB_PAGESZ(PAGESZ_16M))
+        li      r0,62                    /* TLB slot 62 */
+	tlbwe	r4,r0,TLB_DATA		/* Load the data portion of the entry */
+	tlbwe	r3,r0,TLB_TAG		/* Load the tag portion of the entry */
+#endif
+// -------

 #if defined(CONFIG_SERIAL_TEXT_DEBUG) && defined(SERIAL_DEBUG_IO_BASE)

@@ -984,6 +1034,81 @@ _GLOBAL(set_context)
 					/* TLBs after changing PID */
 	blr

+#if defined(CONFIG_PICO_DEBUG) &&  0
+// code to try to isolate what was working and what was not when the
E12 went off the rails switching to virtual mode
+pico_dbg:
+	khdbg(0x88001)
+	lis	r16,0xdead
+	ori	r16,r16,0xbeef
+	khdbgr(r16)
+	
+	lis	r0,MSR_KERNEL@h
+	ori	r0,r0,MSR_KERNEL@l
+	khdbgr(r0)
+
+
+	lis	r17,start_here@h			// SPRN_SRR0 is where the rfi resumes execution
+	ori	r17,r17,start_here@l
+	khdbgr(r19)
+
+	tophys  (r19,r17)
+	khdbgr(r19)
+
+	lwz	r18,0(r19)
+	khdbgr(r18)
+
+	mfmsr	r0
+	oris	r0,r0,MSR_CE@h	
+	ori	r0,r0,MSR_DR|MSR_IR|MSR_RI	
+	mtmsr	r0
+
+	khdbg(0x88004)
+	khdbgr(r0)
+
+	addi	r16,r16,1
+	khdbgr(r16)
+	khdbgr(r17)
+
+	lwz	r18,0(r17)
+	khdbgr(r18)
+
+	lis	r0,0
+	ori	r0,r0,0
+	mtmsr	r0
+
+	khdbg(0x88005)
+	khdbgr(r0)
+
+	addi	r16,r16,1
+	khdbgr(r16)
+
+	lwz	r18,0(r17)
+	khdbgr(r18)
+
+	khdbg(0x880ff)
+	blr
+
+#if 0	
+	lis	r0,MSR_KERNEL@h
+	ori	r0,r0,MSR_KERNEL@l
+
+	mtspr	SPRN_SRR1,r0
+
+	lis	r0,start_here@h			// SPRN_SRR0 is where the rfi resumes execution
+	ori	r0,r0,start_here@l
+
+
+	mtspr	SPRN_SRR0,r0
+	SYNC
+	PPC405_ERR77_SYNC
+/* We now have the lower 16 Meg mapped into TLB entries, and the caches
+ * ready to work.
+ */
+
+	rfi				/* enables MMU */
+	b	.			/* prevent prefetch past rfi */
+#endif
+#endif
 /* We put a few things here that have to be page-aligned. This stuff
  * goes at the beginning of the data segment, which is page-aligned.
  */
diff --git a/arch/ppc/kernel/process.c b/arch/ppc/kernel/process.c
index 25cbdc8..0e1fdf0 100644
--- a/arch/ppc/kernel/process.c
+++ b/arch/ppc/kernel/process.c
@@ -739,38 +739,11 @@ void show_stack(struct task_struct *tsk,
 #endif
 }

-#if 0
-/*
- * Low level print for debugging - Cort
- */
-int __init ll_printk(const char *fmt, ...)
-{
-        va_list args;
-	char buf[256];
-        int i;
-
-        va_start(args, fmt);
-        i=vsprintf(buf,fmt,args);
-	ll_puts(buf);
-        va_end(args);
-        return i;
-}
+#if defined(CONFIG_PICO_DEBUG)

 int lines = 24, cols = 80;
 int orig_x = 0, orig_y = 0;

-void puthex(unsigned long val)
-{
-	unsigned char buf[10];
-	int i;
-	for (i = 7;  i >= 0;  i--)
-	{
-		buf[i] = "0123456789ABCDEF"[val & 0x0F];
-		val >>= 4;
-	}
-	buf[8] = '\0';
-	prom_print(buf);
-}

 void __init ll_puts(const char *s)
 {
@@ -798,8 +771,12 @@ void __init ll_puts(const char *s)
 	 * vidmem just needs to be setup for it.
 	 * -- Cort
 	 */
-	if ( _machine != _MACH_prep )
+	if ( _machine != _MACH_prep ) {
+#if defined(CONFIG_PICO_DEBUG) && 0
+		if ( ppc_md.progress ) ppc_md.progress(s, 0);
+#endif
 		return;
+	}
 	x = orig_x;
 	y = orig_y;

@@ -827,6 +804,37 @@ void __init ll_puts(const char *s)
 	orig_x = x;
 	orig_y = y;
 }
+void puthex(unsigned long val)
+{
+	unsigned char buf[10];
+	int i;
+	for (i = 7;  i >= 0;  i--)
+	{
+		buf[i] = "0123456789ABCDEF"[val & 0x0F];
+		val >>= 4;
+	}
+	buf[8] = '\0';
+#if defined(CONFIG_PICO_DEBUG)
+	ll_puts(buf);
+#else
+	prom_print(buf);
+#endif
+}
+/*
+ * Low level print for debugging - Cort
+ */
+int __init ll_printk(const char *fmt, ...)
+{
+        va_list args;
+	char buf[256];
+        int i;
+
+        va_start(args, fmt);
+        i=vsprintf(buf,fmt,args);
+	ll_puts(buf);
+        va_end(args);
+        return i;
+}
 #endif

 unsigned long get_wchan(struct task_struct *p)
diff --git a/arch/ppc/kernel/relocate_kernel.S
b/arch/ppc/kernel/relocate_kernel.S
index 9b2ad48..555557b 100644
--- a/arch/ppc/kernel/relocate_kernel.S
+++ b/arch/ppc/kernel/relocate_kernel.S
@@ -33,7 +33,11 @@ relocate_new_kernel:
 	 */

 	mr	r8, r0
+#ifdef CONFIG_PICO_E12
+	ori     r8, r8, MSR_RI			// the E-12 generates spurious Machine checks
+#else
 	ori     r8, r8, MSR_RI|MSR_ME
+#endif
 	mtspr	SPRN_SRR1, r8
 	addi	r8, r4, 1f - relocate_new_kernel
 	mtspr	SPRN_SRR0, r8
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index d883791..5fcbc10 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -57,6 +57,11 @@ config XILINX_ML300
 	help
 	  This option enables support for the Xilinx ML300 evaluation board.

+config PICO_E12
+	bool "Pico-E12"
+	#select WANT_EARLY_SERIAL
+	help
+	  This option enables support for the Pico  E-12 board.
 endchoice

 choice
@@ -174,7 +179,7 @@ config IBM_OCP

 config XILINX_OCP
 	bool
-	depends on XILINX_ML300
+	depends on XILINX_ML300 || PICO_E12
 	default y

 config IBM_EMAC4
@@ -213,6 +218,11 @@ config VIRTEX_II_PRO
 	depends on XILINX_ML300
 	default y

+config VIRTEX_IV
+	bool
+	depends on PICO_E12
+	default y
+
 config STB03xxx
 	bool
 	depends on REDWOOD_5 || REDWOOD_6
@@ -220,7 +230,12 @@ config STB03xxx

 config EMBEDDEDBOOT
 	bool
-	depends on EP405 || XILINX_ML300
+	depends on EP405 || XILINX_ML300 || PICO_E12
+	default y
+
+config PICO_DEBUG
+	bool
+	depends on PICO_E12
 	default y

 config IBM_OPENBIOS
@@ -239,7 +254,7 @@ config PPC4xx_EDMA

 config PPC_GEN550
 	bool
-	depends on 4xx
+	depends on 4xx && !PICO_E12
 	default y

 choice
diff --git a/arch/ppc/platforms/4xx/Makefile
b/arch/ppc/platforms/4xx/Makefile
index c9bb611..d27ad1c 100644
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_REDWOOD_6)		+= redwood6.o
 obj-$(CONFIG_SYCAMORE)		+= sycamore.o
 obj-$(CONFIG_WALNUT)		+= walnut.o
 obj-$(CONFIG_XILINX_ML300)	+= xilinx_ml300.o
+obj-$(CONFIG_PICO_E12)	        += pico_e12.o

 obj-$(CONFIG_405GP)		+= ibm405gp.o
 obj-$(CONFIG_REDWOOD_5)		+= ibmstb4.o
@@ -27,3 +28,4 @@ obj-$(CONFIG_440SPE)		+= ppc440spe.o
 obj-$(CONFIG_405EP)		+= ibm405ep.o
 obj-$(CONFIG_405GPR)		+= ibm405gpr.o
 obj-$(CONFIG_VIRTEX_II_PRO)	+= virtex-ii_pro.o
+obj-$(CONFIG_VIRTEX_IV)		+= virtex-iv.o
diff --git a/arch/ppc/platforms/4xx/pico_e12.c
b/arch/ppc/platforms/4xx/pico_e12.c
new file mode 100644
index 0000000..fc61982
--- /dev/null
+++ b/arch/ppc/platforms/4xx/pico_e12.c
@@ -0,0 +1,450 @@
+/*
+ * arch/ppc/platforms/4xx/pico_e12.c
+ *
+ * Pico E12 board initialization
+ *
+ * Author: DLA Systems
+ *         dhlii@dlasys.net
+ *
+ * 2005 (c) DLA Systems  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is
licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/serialP.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/kgdb.h>
+#include <asm/ocp.h>
+
+#include <platforms/4xx/virtex-iv.h>		/* for NR_SER_PORTS */
+#ifdef CONFIG_SERIAL_UARTLITE
+#include <syslib/uartlite.h>		
+#endif
+#ifdef CONFIG_SERIAL_KEYHOLE
+#include <syslib/keyhole.h>		
+#endif
+
+/*
+ * As an overview of how the following functions (platform_init,
+ * e12_map_io, e12_setup_arch and e12_init_IRQ) fit into the
+ * kernel startup procedure, here's a call tree:
+ *
+ * start_here					arch/ppc/kernel/head_4xx.S
+ *  early_init					arch/ppc/kernel/setup.c
+ *  machine_init				arch/ppc/kernel/setup.c
+ *    platform_init				this file
+ *      ppc4xx_init				arch/ppc/syslib/ppc4xx_setup.c
+ *        parse_bootinfo
+ *          find_bootinfo
+ *        "setup some default ppc_md pointers"
+ *  MMU_init					arch/ppc/mm/init.c
+ *    *ppc_md.setup_io_mappings == e12_map_io	this file
+ *      ppc4xx_map_io				arch/ppc/syslib/ppc4xx_setup.c
+ *  start_kernel				init/main.c
+ *    setup_arch				arch/ppc/kernel/setup.c
+ * #if defined(CONFIG_KGDB)
+ *      *ppc_md.kgdb_map_scc() == gen550_kgdb_map_scc
+ * #endif
+ *      *ppc_md.setup_arch == e12_setup_arch	this file
+ *        ppc4xx_setup_arch			arch/ppc/syslib/ppc4xx_setup.c
+ *          ppc4xx_find_bridges			arch/ppc/syslib/ppc405_pci.c
+ *    init_IRQ					arch/ppc/kernel/irq.c
+ *      *ppc_md.init_IRQ == e12_init_IRQ	this file
+ *        ppc4xx_init_IRQ			arch/ppc/syslib/ppc4xx_setup.c
+ *          ppc4xx_pic_init			arch/ppc/syslib/pico_pic.c
+ */
+
+extern unsigned long loops_per_jiffy;
+
+/* Global Variables */
+#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
+
+static volatile unsigned *powerdown_base =
+    (volatile unsigned *) XPAR_POWER_0_POWERDOWN_BASEADDR;
+
+static void
+pico_power_off(void)
+{
+	printk("System Halted\n");
+	local_irq_disable();
+	out_be32(powerdown_base, XPAR_POWER_0_POWERDOWN_VALUE);
+	while (1) ;
+}
+#endif
+
+#if 0
+static void __init ocotea_set_emacdata(void)
+{
+	struct ocp_def *def;
+	struct ocp_func_emac_data *emacdata;
+	int i;
+
+	/*
+	 * Note: Current rev. board only operates in Group 4a
+	 * mode, so we always set EMAC0-1 for SMII and EMAC2-3
+	 * for RGMII (though these could run in RTBI just the same).
+	 *
+	 * The FPGA reg 3 information isn't even suitable for
+	 * determining the phy_mode, so if the board becomes
+	 * usable in !4a, it will be necessary to parse an environment
+	 * variable from the firmware or similar to properly configure
+	 * the phy_map/phy_mode.
+	 */
+	/* Set phy_map, phy_mode, and mac_addr for each EMAC */
+	for (i=0; i<4; i++) {
+		def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, i);
+		emacdata = def->additions;
+		if (i < 2) {
+			emacdata->phy_map = 0x00000001;	/* Skip 0x00 */
+			emacdata->phy_mode = PHY_MODE_SMII;
+		}
+		else {
+			emacdata->phy_map = 0x0000ffff; /* Skip 0x00-0x0f */
+			emacdata->phy_mode = PHY_MODE_RGMII;
+		}
+		if (i == 0)
+			memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
+		else if (i == 1)
+			memcpy(emacdata->mac_addr, __res.bi_enet1addr, 6);
+		else if (i == 2)
+			memcpy(emacdata->mac_addr, __res.bi_enet2addr, 6);
+		else if (i == 3)
+			memcpy(emacdata->mac_addr, __res.bi_enet3addr, 6);
+	}
+}
+/*
+ * Some IRQs unique to CPCI-405.
+ */
+int __init
+ppc405_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	/*
+	 *      PCI IDSEL/INTPIN->INTLINE
+	 *      A       B       C       D
+	 */
+	{
+		{28,	28,	28,	28},	/* IDSEL 15 - cPCI slot 8 */
+		{29,	29,	29,	29},	/* IDSEL 16 - cPCI slot 7 */
+		{30,	30,	30,	30},	/* IDSEL 17 - cPCI slot 6 */
+		{27,	27,	27,	27},	/* IDSEL 18 - cPCI slot 5 */
+		{28,	28,	28,	28},	/* IDSEL 19 - cPCI slot 4 */
+		{29,	29,	29,	29},	/* IDSEL 20 - cPCI slot 3 */
+		{30,	30,	30,	30},	/* IDSEL 21 - cPCI slot 2 */
+        };
+	const long min_idsel = 15, max_idsel = 21, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+};
+#endif
+
+static int
+e12_show_cpuinfo(struct seq_file *m)
+{
+	bd_t *bip = &__res;
+
+	seq_printf(m, "vendor\t\t: Pico\n");
+	//printk("e12_show_cpuinfo():vendor\t\t: Pico\n");
+	seq_printf(m, "machine\t\t: E-12 PPC 405\n");
+	//printk("e12_show_cpuinfo():machine\t\t: E-12 PPC 405\n");
+	seq_printf(m, "machine\t\t: %s\n", PPC4xx_MACHINE_NAME);
+	//printk("e12_show_cpuinfo():machine\t\t: %s\n", PPC4xx_MACHINE_NAME);
+	seq_printf(m, "plb bus clock\t: %ldMHz\n", (long) bip->bi_busfreq /
1000000);
+	//printk("e12_show_cpuinfo():plb bus clock\t: %ldMHz\n", (long)
bip->bi_busfreq / 1000000);
+
+	return 0;
+}
+
+void __init
+e12_map_io(void)
+{
+	ppc4xx_map_io();
+
+#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
+	powerdown_base = ioremap((unsigned long) powerdown_base,
+				 XPAR_POWER_0_POWERDOWN_HIGHADDR -
+				 XPAR_POWER_0_POWERDOWN_BASEADDR + 1);
+#endif
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	io_block_mapping(XPAR_OPB_UARTLITE_0_BASEADDR,
XPAR_OPB_UARTLITE_0_BASEADDR, PAGE_SIZE, _PAGE_IO);
+	io_block_mapping(XPAR_KEYHOLE, XPAR_KEYHOLE, PAGE_SIZE, _PAGE_IO);
+#endif
+}
+
+static void __init
+e12_early_serial_map(void)
+{
+#if defined(CONFIG_SERIAL_UARTLITE) || defined(CONFIG_SERIAL_KEYHOLE)
+	struct serial_state old_ports[] = { SERIAL_PORT_DFNS };
+	struct uart_port port;
+	int i;
+
+	/* Setup ioremapped serial port access */
+	for (i = 0; i < ARRAY_SIZE(old_ports); i++ ) {
+		memset(&port, 0, sizeof(port));
+		port.mapbase = old_ports[i].iomem_base;
+		port.membase = ioremap((phys_addr_t)(old_ports[i].iomem_base), 16);
+		port.irq = old_ports[i].irq;
+		port.uartclk = old_ports[i].baud_base * 16;
+		port.regshift = old_ports[i].iomem_reg_shift;
+		port.iotype = SERIAL_IO_MEM;
+		port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+		port.line = i;
+
+#if defined(CONFIG_SERIAL_UARTLITE)
+		if (port.uartclk) {
+			if (early_serial_setup(&port) != 0) {
+				printk("Early serial init of port %d failed\n", i);
+			}
+		}
+#endif /* CONFIG_SERIAL_UARTLITE  */
+#if defined(CONFIG_SERIAL_KEYHOLE)
+		if (port.uartclk == 0) {
+			if (early_serial_setup(&port) != 0) {
+				printk("Early serial init of port %d failed\n", i);
+			}
+		}
+#endif /*  CONFIG_SERIAL_KEYHOLE */
+	}
+
+#endif /* CONFIG_SERIAL_UARTLITE || CONFIG_SERIAL_KEYHOLE */
+
+#if defined(SERIAL_DEBUG_IO_BASE)
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Purge TLB entry added in head_44x.S for early serial access */
+	_tlbie(SERIAL_DEBUG_IO_BASE);
+#endif
+#endif
+}
+
+void __init
+e12_setup_arch(void)
+{
+	bd_t *bip = &__res;
+	unsigned int freq = 50000000;
+	int i;
+
+	if ( ppc_md.progress ) ppc_md.progress("e12_setup_arch", 0);
+	ppc4xx_setup_arch();	/* calls ppc4xx_find_bridges() */
+#if 0
+	ibm_ocp_set_emac(0, 0);
+
+	if (__res.bi_nvramsize == 512*1024) {
+		/* FIXME: we should properly handle NVRTCs of different sizes */
+		TODC_INIT(TODC_TYPE_DS1557, ep405_nvram, ep405_nvram, ep405_nvram, 8);
+	}
+#endif
+	e12_early_serial_map();
+
+	/* Identify the system */
+	printk(KERN_INFO "Pico Virtex-IV port\n");
+	printk(KERN_INFO "Port by DLA Systems (info@dlasys.net)\n");
+
+#if defined(CONFIG_DEBUG_BRINGUP)
+
+	printk("\n");
+	printk("machine\t: %s\n", PPC4xx_MACHINE_NAME);
+	printk("\n");
+	// printk("bi_s_version\t %s\n", bip->bi_s_version);
+	// printk("bi_r_version\t %s\n", bip->bi_r_version);
+	printk("bi_memsize\t 0x%8.8x\t %dMBytes\n",
bip->bi_memsize,bip->bi_memsize / (1024 * 1000));
+	/*
+	for (i = 0; i < EMAC_NUMS; i++) {
+		printk("bi_enetaddr %d\t %2.2x%2.2x%2.2x-%2.2x%2.2x%2.2x\n", i,
+		       bip->bi_enetaddr[i][0], bip->bi_enetaddr[i][1],
+		       bip->bi_enetaddr[i][2], bip->bi_enetaddr[i][3],
+		       bip->bi_enetaddr[i][4], bip->bi_enetaddr[i][5]);
+	}
+	*/
+	printk("bi_intfreq\t 0x%8.8x\t clock:\t %dMhz\n", bip->bi_intfreq,
bip->bi_intfreq / 1000000);
+	printk("bi_busfreq\t 0x%8.8x\t plb bus clock:\t
%dMHz\n",bip->bi_busfreq, bip->bi_busfreq / 1000000);
+	printk("\n");
+
+#endif
+#if 0
+	struct ocp_def *def;
+	struct ocp_func_emac_data *emacdata;
+
+	/* Set mac_addr for each EMAC */
+	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
+	emacdata = def->additions;
+	emacdata->phy_map = 0x00000001;	/* Skip 0x00 */
+	emacdata->phy_mode = PHY_MODE_RMII;
+	memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
+
+	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 1);
+	emacdata = def->additions;
+	emacdata->phy_map = 0x00000001;	/* Skip 0x00 */
+	emacdata->phy_mode = PHY_MODE_RMII;
+	memcpy(emacdata->mac_addr, __res.bi_enet1addr, 6);
+
+	/*
+	 * Determine various clocks.
+	 * To be completely correct we should get SysClk
+	 * from FPGA, because it can be changed by on-board switches
+	 * --ebs
+	 */
+	ibm440gp_get_clocks(&clocks, 33333333, 6 * 1843200);
+	ocp_sys_info.opb_bus_freq = clocks.opb;
+#endif
+	/* init to some ~sane value until calibrate_delay() runs */
+	// freq = binfo->bi_intfreq;
+
+	/* Set loops_per_jiffy to a half-way reasonable value,
+	   for use until calibrate_delay gets called. */
+	loops_per_jiffy = freq / HZ;
+}
+
+/* Called after board_setup_irq from ppc4xx_init_IRQ(). */
+void __init
+e12_init_irq(void)
+{
+	ppc4xx_init_IRQ();
+}
+
+/*
+ * The Pico supports both uImage and zImage.  If uImage, get the mem size
+ * from the bd info.  If zImage, the bootwrapper adds a BI_MEMSIZE entry in
+ * the bi_rec data which is sucked out and put into boot_mem_size by
+ * parse_bootinfo().  MMU_init() will then use the boot_mem_size for
the mem
+ * size and not call this routine.  The only way this will fail is when
a uImage
+ * is used but the fw doesn't pass in a valid bi_memsize.  This should
never
+ * happen, though.
+ */
+static unsigned long __init
+e12_find_end_of_memory(void)
+{
+	bd_t *bip = &__res;
+	unsigned long total;
+	if (ppc_md.progress)
+		ppc_md.progress("e12_find_end_of_memory", 0);
+	total = bip->bi_memsize;
+	return (total);
+}
+void __init
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	      unsigned long r6, unsigned long r7)
+{
+	printk("platform_init():r3:%lx r4:%lx r5:%lx r6:%lx r7:%lx\n",
r3,r4,r5,r6,r7 );
+#if defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
+	ppc_md.progress = uartlite_progress;
+#endif
+#if defined(CONFIG_SERIAL_KEYHOLE_CONSOLE)
+	ppc_md.progress = keyhole_progress;
+#endif
+#if 0
+	identify_ppc_sys_by_id(mfspr(SPRN_SVR));
+
+	ppc_md.get_irq = openpic_get_irq;
+	ppc_md.get_irq = e12_get_irq;
+	isa_mem_base = 0;
+
+	ppc_md.irq_canonicalize = NULL;
+	ppc_md.init = NULL;
+	ppc_md.time_init = NULL;
+	ppc_md.set_rtc_time = NULL;
+	ppc_md.get_rtc_time = NULL;
+	ppc_md.nvram_read_val = NULL;
+	ppc_md.nvram_write_val = NULL;
+	ppc_md.heartbeat = NULL;
+
+#endif
+
+	ppc_md.progress("platform_init", 0x200);
+	// r3 = 0;
+	ppc4xx_init(r3, r4, r5, r6, r7);
+
+	//ppc_md.setup_arch = ppc4xx_setup_arch;
+	ppc_md.setup_arch = e12_setup_arch;
+	ppc_md.setup_io_mappings = e12_map_io;
+	//ppc_md.init_IRQ = ppc4xx_init_IRQ;
+	ppc_md.init_IRQ = e12_init_irq;
+	//ppc_md.show_cpuinfo = ppc4xx_show_cpuinfo;
+	ppc_md.show_cpuinfo = e12_show_cpuinfo;
+	ppc_md.find_end_of_memory = e12_find_end_of_memory;
+
+#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
+	ppc_md.power_off = pico_power_off;
+#endif
+
+#if defined(CONFIG_SERIAL_UARTLITE)
+#if defined(CONFIG_SERIAL_TEXT_DEBUG)
+	ppc_md.progress = uartlite_progress;
+#endif	/* CONFIG_SERIAL_TEXT_DEBUG */
+#if  defined(CONFIG_KGDB)
+	ppc_md.early_serial_map = e12_early_serial_map;
+#endif	/* CONFIG_KGDB */
+#endif	/* CONFIG_SERIAL_UARTLITE */
+
+#if defined(CONFIG_SERIAL_KEYHOLE)
+#if defined(CONFIG_SERIAL_TEXT_DEBUG)
+	ppc_md.progress = keyhole_progress;
+#endif	/* CONFIG_SERIAL_TEXT_DEBUG */
+#if defined(CONFIG_KGDB)
+	ppc_md.early_serial_map = e12_early_serial_map;
+#endif	/* CONFIG_KGDB */
+#endif	/* CONFIG_SERIAL_KEYHOLE */
+}
+#if 0
+static struct ocp_func_emac_data ibm405gpr_emac0_def = {
+	.rgmii_idx	= -1,		/* No RGMII */
+	.rgmii_mux	= -1,		/* No RGMII */
+	.zmii_idx	= -1,		/* ZMII device index */
+	.zmii_mux	= 0,		/* ZMII input of this EMAC */
+	.mal_idx	= 0,		/* MAL device index */
+	.mal_rx_chan	= 0,		/* MAL rx channel number */
+	.mal_tx_chan	= 0,		/* MAL tx channel number */
+	.wol_irq	= 9,		/* WOL interrupt number */
+	.mdio_idx	= -1,		/* No shared MDIO */
+	.tah_idx	= -1,		/* No TAH */
+};
+OCP_SYSFS_EMAC_DATA()
+
+static struct ocp_func_mal_data ibm405gpr_mal0_def = {
+	.num_tx_chans	= 1,		/* Number of TX channels */
+	.num_rx_chans	= 1,		/* Number of RX channels */
+	.txeob_irq	= 11,		/* TX End Of Buffer IRQ  */
+	.rxeob_irq	= 12,		/* RX End Of Buffer IRQ  */
+	.txde_irq	= 13,		/* TX Descriptor Error IRQ */
+	.rxde_irq	= 14,		/* RX Descriptor Error IRQ */
+	.serr_irq	= 10,		/* MAL System Error IRQ    */
+	.dcr_base	= DCRN_MAL_BASE /* MAL0_CFG DCR number */
+};
+OCP_SYSFS_MAL_DATA()
+
+static struct ocp_func_iic_data ibm405gpr_iic0_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+
+OCP_SYSFS_IIC_DATA()
+
+/* Polarity and triggering settings for internal interrupt sources */
+struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[] __initdata = {
+	{ .polarity 	= 0xffffff80,
+	  .triggering	= 0x10000000,
+	  .ext_irq_mask	= 0x0000007f,	/* IRQ0 - IRQ6 */
+	}
+};
+#endif
+#ifdef DEBUG_FREQ
+static inline void debug_calc_bogomips(void)
+{
+	/* This will cause a recalc of bogomips and display the
+	 * result. We backup/restore the value to avoid affecting the
+	 * core cpufreq framework's own calculation.
+	 */
+	extern void calibrate_delay(void);
+
+	unsigned long save_lpj = loops_per_jiffy;
+	calibrate_delay();
+	loops_per_jiffy = save_lpj;
+}
+#endif /* DEBUG_FREQ */
diff --git a/arch/ppc/platforms/4xx/pico_e12.h
b/arch/ppc/platforms/4xx/pico_e12.h
new file mode 100644
index 0000000..1c4cb1d
--- /dev/null
+++ b/arch/ppc/platforms/4xx/pico_e12.h
@@ -0,0 +1,52 @@
+/*
+ * arch/ppc/platforms/4xx/pico_e12.h
+ *
+ * Include file that defines the Pico E12 evaluation board
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is
licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_PICO_E12_H__
+#define __ASM_PICO_E12_H__
+
+/* E-12 has a Xilinx Virtex-IV processor */
+#include <platforms/4xx/virtex-iv.h>
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+typedef struct board_info {
+	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
+	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address */
+	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
+	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
+} bd_t;
+
+/* Some 4xx parts use a different timebase frequency from the internal
clock.
+*/
+#define bi_tbfreq bi_intfreq
+
+#if defined(CONFIG_PICO_DEBUG)
+#define khdbgc(x)	*(volatile unsigned int *)(XPAR_KEYHOLE+4) = x;
__asm__ __volatile__("eieio");
+#endif
+
+#endif /* !__ASSEMBLY__ */
+
+#define EMAC_NUMS 1
+
+/* We don't need anything mapped.  Size of zero will accomplish that. */
+#define PPC4xx_ONB_IO_PADDR	0u
+#define PPC4xx_ONB_IO_VADDR	0u
+#define PPC4xx_ONB_IO_SIZE	0u
+
+#define PPC4xx_MACHINE_NAME "Pico E12"
+
+#endif /* __ASM_PICO_E12_H__ */
+#endif /* __KERNEL__ */
diff --git a/arch/ppc/platforms/4xx/virtex-iv.c
b/arch/ppc/platforms/4xx/virtex-iv.c
new file mode 100644
index 0000000..1058730
--- /dev/null
+++ b/arch/ppc/platforms/4xx/virtex-iv.c
@@ -0,0 +1,79 @@
+/*
+ * arch/ppc/platforms/4xx/virtex-iv.c
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is
licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <asm/ocp.h>
+#include "virtex-iv.h"
+
+/* Have OCP take care of the serial ports. */
+struct ocp_def core_ocp[] = {
+#ifdef XPAR_OPB_UARTLITE_0_BASEADDR
+	{ .vendor	= OCP_VENDOR_XILINX,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 0,
+	  .paddr	= XPAR_OPB_UARTLITE_0_BASEADDR,
+	  .irq		= XPAR_INTC_0_UARTLITE_0_VEC_ID,
+	  .pm		= OCP_CPM_NA
+	},
+#ifdef XPAR_OPB_UARTLITE_1_BASEADDR
+	{ .vendor	= OCP_VENDOR_XILINX,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= XPAR_OPB_UARTLITE_1_BASEADDR,
+	  .irq		= XPAR_INTC_0_UARTLITE_1_VEC_ID,
+	  .pm		= OCP_CPM_NA
+	},
+#ifdef XPAR_OPB_UARTLITE_2_BASEADDR
+	{ .vendor	= OCP_VENDOR_XILINX,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 2,
+	  .paddr	= XPAR_OPB_UARTLITE_2_BASEADDR,
+	  .irq		= XPAR_INTC_0_UARTLITE_2_VEC_ID,
+	  .pm		= OCP_CPM_NA
+	},
+#ifdef XPAR_OPB_UARTLITE_3_BASEADDR
+	{ .vendor	= OCP_VENDOR_XILINX,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 3,
+	  .paddr	= XPAR_OPB_UARTLITE_3_BASEADDR,
+	  .irq		= XPAR_INTC_0_UARTLITE_3_VEC_ID,
+	  .pm		= OCP_CPM_NA
+	},
+#ifdef XPAR_OPB_UARTLITE_4_BASEADDR
+#error Edit this file to add more devices.
+#endif			/* 4 */
+#endif			/* 3 */
+#endif			/* 2 */
+#endif			/* 1 */
+#endif			/* 0 */
+#ifdef XPAR_KEYHOLE
+	{ .vendor	= OCP_VENDOR_PICO,
+	  .function	= OCP_FUNC_GPIO,
+	  .paddr	= XPAR_KEYHOLE,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA
+	},
+#endif
+#ifdef XPAR_EMAC
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 0,
+	  .paddr	= EMAC0_BASE,
+	  .irq		= 15,
+	  .pm		= IBM_CPM_EMAC0,
+	  .additions	= &ibm405gpr_emac0_def,
+	  .show		= &ocp_show_emac_data,
+	},
+#endif
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
+};
diff --git a/arch/ppc/platforms/4xx/virtex-iv.h
b/arch/ppc/platforms/4xx/virtex-iv.h
new file mode 100644
index 0000000..11a84b3
--- /dev/null
+++ b/arch/ppc/platforms/4xx/virtex-iv.h
@@ -0,0 +1,119 @@
+/*
+ * arch/ppc/platforms/4xx/virtex-iv.h
+ *
+ * Include file that defines the Xilinx Virtex-IV processor
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is
licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_VIRTEXIV_H__
+#define __ASM_VIRTEXIV_H__
+
+#include <linux/config.h>
+#include <asm/xparameters.h>
+
+/* serial defines */
+
+#define RS_TABLE_SIZE  4	/* change this and add more devices below
+				   if you have more then 4 16x50 UARTs */
+
+#define BASE_BAUD		XPAR_OPB_UARTLITE_0_BAUDRATE
+
+/* The serial ports in the Virtex-IV have each I/O byte in the
+ * LSByte of a word.  This means that iomem_reg_shift needs to be 2 to
+ * change the byte offsets into word offsets.  In addition the base
+ * addresses need to have 3 added to them to get to the LSByte.
+ */
+#define STD_UART_OP(num)						 \
+	{ 0, BASE_BAUD, 0, XPAR_INTC_0_UARTLITE_##num##_VEC_ID,	 \
+		ASYNC_BOOT_AUTOCONF,		 			 \
+		.iomem_base = (u8 *)XPAR_OPB_UARTLITE_##num##_BASEADDR,     \
+		.iomem_reg_shift = 2,					 \
+		.io_type = SERIAL_IO_MEM},
+
+#if defined(XPAR_INTC_0_UARTLITE_0_VEC_ID)
+#define UARTLITE_0 STD_UART_OP(0)
+#else
+#define UARTLITE_0
+#endif
+
+#if defined(XPAR_INTC_0_UARTLITE_1_VEC_ID)
+#define UARTLITE_1 STD_UART_OP(1)
+#else
+#define UARTLITE_1
+#endif
+
+#if defined(XPAR_INTC_0_UARTLITE_2_VEC_ID)
+#define UARTLITE_2 STD_UART_OP(2)
+#else
+#define UARTLITE_2
+#endif
+
+#if defined(XPAR_INTC_0_UARTLITE_3_VEC_ID)
+#define UARTLITE_3 STD_UART_OP(3)
+#else
+#define UARTLITE_3
+#endif
+
+#if defined(XPAR_INTC_0_UARTLITE_4_VEC_ID)
+#error Edit this file to add more devices.
+#elif defined(XPAR_INTC_0_UARTLITE_3_VEC_ID)
+#define NR_SER_PORTS	4
+#elif defined(XPAR_INTC_0_UARTLITE_2_VEC_ID)
+#define NR_SER_PORTS	3
+#elif defined(XPAR_INTC_0_UARTLITE_1_VEC_ID)
+#define NR_SER_PORTS	2
+#elif defined(XPAR_INTC_0_UARTLITE_0_VEC_ID)
+#define NR_SER_PORTS	1
+#else
+#define NR_SER_PORTS	0
+#endif
+
+#if defined(CONFIG_SERIAL_KEYHOLE_CONSOLE)
+#define SERIAL_PORT_DFNS	\
+	{ 0, 0, 0, 0,	 \
+		ASYNC_BOOT_AUTOCONF,		 			 \
+		.iomem_base = (u8 *)XPAR_KEYHOLE,     \
+		.iomem_reg_shift = 2,					 \
+		.io_type = SERIAL_IO_MEM}, \
+	UARTLITE_0		\
+	UARTLITE_1		\
+	UARTLITE_2		
+#else
+
+#if defined(CONFIG_UART0_TTYS0)
+#define SERIAL_PORT_DFNS	\
+	UARTLITE_0		\
+	UARTLITE_1		\
+	UARTLITE_2		\
+	UARTLITE_3
+#endif
+
+#if defined(CONFIG_UART0_TTYS1)
+#define SERIAL_PORT_DFNS	\
+	UARTLITE_1		\
+	UARTLITE_0		\
+	UARTLITE_2		\
+	UARTLITE_3
+#endif
+#endif
+
+#define DCRN_CPMFR_BASE	0
+
+#if defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
+#define SERIAL_DEBUG_IO_BASE	XPAR_OPB_UARTLITE_0_BASEADDR
+#endif
+
+#if defined(CONFIG_SERIAL_KEYHOLE_CONSOLE)
+#define SERIAL_DEBUG_IO_BASE	XPAR_KEYHOLE
+#endif
+#include <asm/ibm405.h>
+
+#endif				/* __ASM_VIRTEXIV_H__ */
+#endif				/* __KERNEL__ */
diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters_pico_e12.h
b/arch/ppc/platforms/4xx/xparameters/xparameters_pico_e12.h
new file mode 100644
index 0000000..f553794
--- /dev/null
+++ b/arch/ppc/platforms/4xx/xparameters/xparameters_pico_e12.h
@@ -0,0 +1,146 @@
+/*******************************************************************
+*
+*     Author: Xilinx, Inc.
+*
+*
+*     This program is free software; you can redistribute it and/or
modify it
+*     under the terms of the GNU General Public License as published by the
+*     Free Software Foundation; either version 2 of the License, or (at
your
+*     option) any later version.
+*
+*
+*     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
+*     COURTESY TO YOU. BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
+*     ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD,
+*     XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE
+*     FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR
OBTAINING
+*     ANY THIRD PARTY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
+*     XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
+*     THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY
+*     WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM
+*     CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND
+*     FITNESS FOR A PARTICULAR PURPOSE.
+*
+*
+*     Xilinx hardware products are not intended for use in life support
+*     appliances, devices, or systems. Use in such applications is
+*     expressly prohibited.
+*
+*
+*     (c) Copyright 2002-2004 Xilinx Inc.
+*     All rights reserved.
+*
+*
+*     You should have received a copy of the GNU General Public License
along
+*     with this program; if not, write to the Free Software Foundation,
Inc.,
+*     675 Mass Ave, Cambridge, MA 02139, USA.
+*
+* Description: Driver parameters
+*
+*******************************************************************/
+
+/* Linux Redefines */
+
+/******************************************************************/
+#define XPAR_KEYHOLE XPAR_OPB_PICOE12_EPBASE_R1_0_AR0_BASEADDR
+
+#define XPAR_PLB_DDR_0_BASEADDR XPAR_PLB_SDRAM_0_BASEADDR
+#define XPAR_PLB_DDR_0_HIGHADDR XPAR_PLB_SDRAM_0_HIGHADDR
+
+#define XPAR_CORE_CLOCK_FREQ_HZ XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ
+#define XPAR_PLB_CLOCK_FREQ_HZ 100000000
+#define XPAR_PCI_0_CLOCK_FREQ_HZ XPAR_XPCI_CLOCK_HZ
+#define XPAR_XPCI_CLOCK_HZ 33333333
+
+// #define XPAR_INTC_NUM_INSTANCES XPAR_XINTC_NUM_INSTANCES
+#define XPAR_INTC_NUM_INSTANCES 0
+#define XPAR_INTC_0_BASEADDR XPAR_MYINTC_BASEADDR
+#define XPAR_INTC_0_HIGHADDR XPAR_MYINTC_HIGHADDR
+#define XPAR_INTC_DEVICE_ID XPAR_MYINTC_DEVICE_ID
+#define XPAR_INTC_0_KIND_OF_INTR XPAR_MYINTC_KIND_OF_INTR
+// #define XPAR_INTC_0_UARTLITE_0_VEC_ID
XPAR_MYINTC_OPB_UARTLITE_0_INTERRUPT_INTR
+#define XPAR_INTC_0_UARTLITE_0_VEC_ID -1
+
+#define XPAR_XEMAC_NUM_INSTANCES XPAR_XLLTEMAC_NUM_INSTANCES
+#define XPAR_OPB_ETHERNET_0_BASEADDR XPAR_XLLTEMAC_BASEADDR
+#define XPAR_OPB_ETHERNET_0_HIGHADDR XPAR_XLLTEMAC_HIGHADDR
+#define XPAR_OPB_ETHERNET_0_DEVICE_ID XPAR_XLLTEMAC_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_PLB_BRAM_IF_CNTLR_1_BASEADDR 0xffffc000
+#define XPAR_PLB_BRAM_IF_CNTLR_1_HIGHADDR 0xffffffff
+
+/******************************************************************/
+#define STDIN_BASEADDRESS 0x40600000
+#define STDOUT_BASEADDRESS 0x40600000
+
+#define XPAR_XUARTLITE_NUM_INSTANCES 1
+#define XPAR_OPB_UARTLITE_0_BASEADDR 0x40600000
+#define XPAR_OPB_UARTLITE_0_HIGHADDR 0x4060FFFF
+#define XPAR_OPB_UARTLITE_0_DEVICE_ID 0
+#define XPAR_OPB_UARTLITE_0_BAUDRATE 57600
+#define XPAR_OPB_UARTLITE_0_USE_PARITY 0
+#define XPAR_OPB_UARTLITE_0_ODD_PARITY 1
+#define XPAR_OPB_UARTLITE_0_DATA_BITS 8
+
+/******************************************************************/
+
+#define XPAR_OPB_PICOE12_EPBASE_R1_0_BASEADDR 0x6FFFFF00
+#define XPAR_OPB_PICOE12_EPBASE_R1_0_HIGHADDR 0x6FFFFFFF
+#define XPAR_OPB_PICOE12_EPBASE_R1_0_AR0_BASEADDR 0x70000000
+#define XPAR_OPB_PICOE12_EPBASE_R1_0_AR0_HIGHADDR 0x7000000F
+#define XPAR_OPB_PICOE12_EPBASE_R1_0_AR1_BASEADDR 0x70000010
+#define XPAR_OPB_PICOE12_EPBASE_R1_0_AR1_HIGHADDR 0x70000017
+#define XPAR_OPB_PICOE12_EPBASE_R1_0_AR2_BASEADDR 0x60000000
+#define XPAR_OPB_PICOE12_EPBASE_R1_0_AR2_HIGHADDR 0x67FFFFFF
+
+/******************************************************************/
+
+#define XPAR_PLB_SDRAM_0_BASEADDR 0x00000000
+#define XPAR_PLB_SDRAM_0_HIGHADDR 0x07FFFFFF
+
+/******************************************************************/
+
+#define XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ 300000000
+
+/******************************************************************/
+#define XPAR_PLB_LL_IF_0_BASEADDR 0xA0100000
+#define XPAR_PLB_LL_IF_0_HIGHADDR 0xA01000FF
+
+/******************************************************************/
+
+#define XPAR_XLLTEMAC_NUM_INSTANCES 1
+#define XPAR_XLLTEMAC_BASEADDR 0x140
+#define XPAR_XLLTEMAC_HIGHADDR 0x140
+#define XPAR_XLLTEMAC_DEVICE_ID 0
+#define XPAR_XLLTEMAC_DMA_TYPE 0
+#define XPAR_XLLTEMAC_INCLUDE_GMII 0
+#define XPAR_XLLTEMAC_INCLUDE_STATS 0
+
+//#define XPAR_OPB_ETHERNET_0_ERR_COUNT_EXIST 1
+//#define XPAR_OPB_ETHERNET_0_DMA_PRESENT 1
+//#define XPAR_OPB_ETHERNET_0_MII_EXIST 1
+/******************************************************************/
+
+#define XPAR_INTC_MAX_NUM_INTR_INPUTS 1
+#define XPAR_XINTC_HAS_IPR 1
+#define XPAR_XINTC_USE_DCR 0
+#define XPAR_XINTC_NUM_INSTANCES 1
+#define XPAR_MYINTC_BASEADDR 0x40000000
+#define XPAR_MYINTC_HIGHADDR 0x4000001F
+#define XPAR_MYINTC_DEVICE_ID 0
+#define XPAR_MYINTC_KIND_OF_INTR 0x00000001
+
+#define XPAR_INTC_SINGLE_BASEADDR 0x40000000
+#define XPAR_INTC_SINGLE_HIGHADDR 0x4000001F
+#define XPAR_INTC_SINGLE_DEVICE_ID XPAR_MYINTC_DEVICE_ID
+
+/******************************************************************/
+
+#define XPAR_OPB_UARTLITE_0_INTERRUPT_MASK 0X000001
+// set to -1 to disable
+#define XPAR_MYINTC_OPB_UARTLITE_0_INTERRUPT_INTR 0
+
+/******************************************************************/
+
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index 5b7f2b8..b27dc73 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -17,14 +17,18 @@ obj-$(CONFIG_440GX)		+= ibm440gx_common.
 obj-$(CONFIG_440SP)		+= ibm440gx_common.o ibm440sp_common.o
 obj-$(CONFIG_440SPE)		+= ibm440gx_common.o ibm440sp_common.o
ppc440spe_pcie.o
 ifeq ($(CONFIG_4xx),y)
-ifeq ($(CONFIG_VIRTEX_II_PRO),y)
-obj-$(CONFIG_40x)		+= xilinx_pic.o
-else
-ifeq ($(CONFIG_403),y)
-obj-$(CONFIG_40x)		+= ppc403_pic.o
-else
-obj-$(CONFIG_40x)		+= ppc4xx_pic.o
-endif
+  ifeq ($(CONFIG_VIRTEX_IV),y)
+    obj-$(CONFIG_40x)		+= xilinx_pic.o
+  else
+    ifeq ($(CONFIG_VIRTEX_II_PRO),y)
+      obj-$(CONFIG_40x)		+= xilinx_pic.o
+    else
+      ifeq ($(CONFIG_403),y)
+        obj-$(CONFIG_40x)	+= ppc403_pic.o
+      else
+        obj-$(CONFIG_40x)	+= ppc4xx_pic.o
+      endif
+  endif
 endif
 obj-$(CONFIG_44x)		+= ppc4xx_pic.o
 obj-$(CONFIG_40x)		+= ppc4xx_setup.o
@@ -86,6 +90,12 @@ endif
 ifeq ($(CONFIG_SERIAL_MPSC_CONSOLE),y)
 obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= mv64x60_dbg.o
 endif
+ifeq ($(CONFIG_SERIAL_KEYHOLE_CONSOLE),y)
+obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= keyhole_dbg.o
+endif
+ifeq ($(CONFIG_SERIAL_UARTLITE_CONSOLE),y)
+obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= uartlite_dbg.o
+endif
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_MPC10X_BRIDGE)	+= mpc10x_common.o ppc_sys.o
 obj-$(CONFIG_MPC10X_OPENPIC)	+= open_pic.o
diff --git a/arch/ppc/syslib/keyhole.h b/arch/ppc/syslib/keyhole.h
new file mode 100644
index 0000000..4b7a374
--- /dev/null
+++ b/arch/ppc/syslib/keyhole.h
@@ -0,0 +1,17 @@
+/*
+ * arch/ppc/syslib/keyhole.h
+ *
+ * keyhole prototypes
+ *
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * 2004 (c) MontaVista Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+extern void keyhole_progress(char *, unsigned short);
+extern void keyhole_puts(char *);
+extern void keyhole_init(int, struct uart_port *);
+extern void keyhole_kgdb_map_scc(void);
diff --git a/arch/ppc/syslib/keyhole_dbg.c b/arch/ppc/syslib/keyhole_dbg.c
new file mode 100644
index 0000000..73dd275
--- /dev/null
+++ b/arch/ppc/syslib/keyhole_dbg.c
@@ -0,0 +1,148 @@
+/*
+ * arch/ppc/syslib/keyhole_dbg.c
+ *
+ * Bootloader version of the embedded Xilinx/KEYHOLE driver.
+ *
+ * Author: David H. Lynch Jr. <dhlii@dlasys.net>
+ *
+ * 2005 (c) DLA Systems  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/serial_keyhole.h>
+#include <linux/serial.h>
+#include <linux/tty.h>		/* For linux/serial_core.h */
+#include <linux/serial_core.h>
+#include <linux/serialP.h>
+// #include <linux/serial_reg.h>
+#include <asm/serial.h>
+
+
+/* SERIAL_PORT_DFNS is defined in <asm/serial.h> */
+#ifndef SERIAL_PORT_DFNS
+#define SERIAL_PORT_DFNS
+#endif
+
+static struct serial_state rs_table[RS_TABLE_SIZE] = {
+	SERIAL_PORT_DFNS	/* defined in <asm/serial.h> */
+};
+static int MillisecTimeout=1000;
+void usleep(int t) {
+   int ii, waitTime=100;
+    while(t) {
+    	for (ii=0; ii < MillisecTimeout*1000/waitTime; ii++){};
+	t--;
+    }
+}
+
+//Output one 32bit value thru the keyhole.
+static int keyhole_out(unsigned long cmd, unsigned long kh) {
+	unsigned int status;
+
+	for (;;) {
+		status = serial_in32(XPAR_KEYHOLE, UART_LSR);
+		if ((status & UART_LSR_TXF) == 0) {
+			//careful about the order here. data must be sent last.
+			serial_out32(XPAR_KEYHOLE, UART_LCR, cmd);
+			serial_out32(XPAR_KEYHOLE, UART_TX, kh);    //triggers fifo write
+			return 1;
+		}
+        	usleep(100); //wait if ppc2pc fifo is almost full.
+		// cpu_relax();
+	}
+	return -1;
+} //keyhole_out...
+
+unsigned long
+serial_init(int chan, void *ignored)
+{
+	return (XPAR_KEYHOLE);
+}
+
+void
+serial_putc(unsigned long com_port, unsigned char c)
+{
+  	KEYHOLE_DATA kh;
+
+	if (c == '\r') return;
+    	kh.u32 = 0; kh.packetType = KHC_FMTD; kh.countWords = 3;
+	keyhole_out(KH_BEGIN, kh.u32) ;
+	kh.u32 = 0;
+	kh.asci0 = c;
+        keyhole_out(KH_STR, kh.u32);
+	keyhole_out(KH_END, kh.u32);
+}
+
+void
+keyhole_puts(char *s)
+{
+	volatile unsigned int progress_debugport;
+	volatile char c;
+
+	progress_debugport = XPAR_KEYHOLE;
+	while ((c = *s++) != 0)
+		serial_putc(progress_debugport, c);
+
+	serial_putc(progress_debugport, '\n');
+	serial_putc(progress_debugport, '\r');
+}
+
+unsigned char
+serial_getc(unsigned long com_port)
+{
+	return '\0';
+}
+
+int
+serial_tstc(unsigned long com_port)
+{
+	return 0;
+}
+
+void
+serial_close(unsigned long com_port)
+{
+}
+void
+keyhole_init(int i, struct uart_port *serial_req)
+{
+#if 1
+	rs_table[i].io_type = serial_req->iotype;
+	rs_table[i].port = serial_req->iobase;
+	rs_table[i].iomem_base = serial_req->membase;
+	rs_table[i].iomem_reg_shift = serial_req->regshift;
+	rs_table[i].baud_base =  BASE_BAUD;
+#endif
+}
+
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+void
+keyhole_progress(char *s, unsigned short hex)
+{
+	volatile unsigned int progress_debugport;
+	volatile char c;
+
+	progress_debugport = serial_init(0, NULL);
+
+	serial_putc(progress_debugport, '\r');
+
+	while ((c = *s++) != 0)
+		serial_putc(progress_debugport, c);
+
+	serial_putc(progress_debugport, '\n');
+	serial_putc(progress_debugport, '\r');
+}
+#if 0
+void
+kh_putc(char c)
+{
+	volatile unsigned int progress_debugport;
+	progress_debugport = serial_init(0, NULL);
+
+	serial_putc(progress_debugport, c);
+}
+#endif
+#endif /* CONFIG_SERIAL_TEXT_DEBUG */
diff --git a/arch/ppc/syslib/ppc4xx_setup.c b/arch/ppc/syslib/ppc4xx_setup.c
index e83a83f..c601390 100644
--- a/arch/ppc/syslib/ppc4xx_setup.c
+++ b/arch/ppc/syslib/ppc4xx_setup.c
@@ -41,7 +41,15 @@
 #include <asm/pci-bridge.h>
 #include <asm/bootinfo.h>

+#if defined(CONFIG_SERIAL_8250)
 #include <syslib/gen550.h>
+#endif
+#if defined(CONFIG_SERIAL_KEYHOLE)
+#include <syslib/keyhole.h>
+#endif
+#if defined(CONFIG_SERIAL_UARTLITE)
+#include <syslib/uartlite.h>
+#endif

 /* Function Prototypes */
 extern void abort(void);
@@ -72,11 +80,18 @@ ppc4xx_setup_arch(void)
  *   This routine pretty-prints the platform's internal CPU clock
  *   frequencies into the buffer for usage in /proc/cpuinfo.
  */
+#if defined(CONFIG_PICO_DEBUG)
+#define DEBUG_PRINTK(fmt...)	_printk(fmt)
+#else
+#define DEBUG_PRINTK(fmt...)	do { } while (0)
+#endif
+#define _printk printk

 static int
 ppc4xx_show_percpuinfo(struct seq_file *m, int i)
 {
 	seq_printf(m, "clock\t\t: %ldMHz\n", (long)__res.bi_intfreq / 1000000);
+	_printk("clock\t\t: %ldMHz\n", (long)__res.bi_intfreq / 1000000);

 	return 0;
 }
@@ -174,6 +189,7 @@ ppc4xx_calibrate_decr(void)
 	tb_ticks_per_jiffy = freq / HZ;
 	tb_to_us = mulhwu_scale_factor(freq, 1000000);

+	_printk("freq: %d tb_ticks_per_jiffy: %d tb_to_us: %d\n", freq,
tb_ticks_per_jiffy, tb_to_us);
 	/* Set the time base to zero.
 	   ** At 200 Mhz, time base will rollover in ~2925 years.
 	 */
@@ -226,6 +242,7 @@ void __init
 ppc4xx_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	    unsigned long r6, unsigned long r7)
 {
+	_printk("ppc4xx_init():r3:%lx r4:%lx r5:%lx r6:%lx r7:%lx\n",
r3,r4,r5,r6,r7 );
 	parse_bootinfo(find_bootinfo());

 	/*
@@ -251,6 +268,7 @@ ppc4xx_init(unsigned long r3, unsigned l
 	if (r6) {
 		*(char *) (r7 + KERNELBASE) = 0;
 		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
+		_printk("ppc4xx_init():commandline:%s\n", cmd_line );
 	}

 	/* Initialize machine-dependent vectors */
@@ -269,9 +287,17 @@ ppc4xx_init(unsigned long r3, unsigned l
 	ppc_md.find_end_of_memory = ppc4xx_find_end_of_memory;
 	ppc_md.setup_io_mappings = ppc4xx_map_io;

-#ifdef CONFIG_SERIAL_TEXT_DEBUG
+#if defined(CONFIG_SERIAL_TEXT_DEBUG)
+#if defined(CONFIG_SERIAL_8250)
 	ppc_md.progress = gen550_progress;
 #endif
+#if defined(CONFIG_SERIAL_KEYHOLE)
+	ppc_md.progress = keyhole_progress;
+#endif
+#if defined(CONFIG_SERIAL_UARTLITE)
+	ppc_md.progress = uartlite_progress;
+#endif
+#endif

 #if defined(CONFIG_PCI) && defined(CONFIG_IDE)
 	ppc_ide_md.ide_init_hwif = ppc4xx_ide_init_hwif_ports;
diff --git a/arch/ppc/syslib/uartlite.h b/arch/ppc/syslib/uartlite.h
new file mode 100644
index 0000000..4c5f379
--- /dev/null
+++ b/arch/ppc/syslib/uartlite.h
@@ -0,0 +1,18 @@
+/*
+ * arch/ppc/syslib/uartlite.h
+ *
+ * uartlite prototypes
+ *
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * 2004 (c) MontaVista Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+extern void uartlite_progress(char *, unsigned short);
+extern void uartlite_puts(char *);
+// extern void uartlite_putc(char);
+extern void uartlite_init(int, struct uart_port *);
+extern void uartlite_kgdb_map_scc(void);
diff --git a/arch/ppc/syslib/uartlite_dbg.c b/arch/ppc/syslib/uartlite_dbg.c
new file mode 100644
index 0000000..a693d7a
--- /dev/null
+++ b/arch/ppc/syslib/uartlite_dbg.c
@@ -0,0 +1,160 @@
+/*
+ * arch/ppc/syslib/uartlite_dbg.c
+ *
+ * Bootloader version of the embedded Xilinx/UARTLITE driver.
+ *
+ *  Author: David H. Lynch Jr. <dhlii@dlasys.net>
+ *  Copyright (C) 2005 DLA Systems
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
 USA
+ *
+ *  $Id: uartlite.c,v 0.10 2005/12/14 10:03:27 dhlii Exp $
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/serial.h>
+#include <linux/tty.h>		/* For linux/serial_core.h */
+#include <linux/serial_core.h>
+#include <linux/serialP.h>
+#include <asm/serial.h>
+
+void uartlite_puts(char *s);
+
+/* SERIAL_PORT_DFNS is defined in <asm/serial.h> */
+#ifndef SERIAL_PORT_DFNS
+#define SERIAL_PORT_DFNS
+#endif
+
+#include <linux/serial_uartlite.h>
+
+
+static struct serial_state rs_table[RS_TABLE_SIZE] = {
+	SERIAL_PORT_DFNS	/* Defined in <asm/serial.h> */
+};
+
+static int shift;
+
+unsigned long
+serial_init(int chan, void *ignored)
+{
+	unsigned long com_port;
+
+	/* We need to find out which type io we're expecting.  If it's
+	 * 'SERIAL_IO_PORT', we get an offset from the isa_io_base.
+	 * If it's 'SERIAL_IO_MEM', we can the exact location.  -- Tom */
+	switch (rs_table[chan].io_type) {
+		case SERIAL_IO_PORT:
+			com_port = rs_table[chan].port;
+			break;
+		case SERIAL_IO_MEM:
+			com_port = (unsigned long)rs_table[chan].iomem_base;
+			break;
+		default:
+			/* We can't deal with it. */
+			uartlite_puts("serial_init - oops");
+			return -1;
+	}
+
+	/* How far apart the registers are. */
+	shift = rs_table[chan].iomem_reg_shift;
+//	uartlite_puts("serial_init");
+	return (com_port);
+}
+
+void
+serial_putc(unsigned long com_port, unsigned char c)
+{
+    unsigned int status ;
+    do {
+	    status =  serial_in32(com_port, UART_LSR);
+    } while ( status & UART_LSR_TXF);
+    serial_out32(com_port, UART_TX, c);
+}
+
+void
+uartlite_puts(char *s)
+{
+	volatile unsigned int progress_debugport;
+	volatile char c;
+
+	progress_debugport = XPAR_OPB_UARTLITE_0_BASEADDR;
+	while ((c = *s++) != 0)
+		serial_putc(progress_debugport, c);
+
+	serial_putc(progress_debugport, '\n');
+	serial_putc(progress_debugport, '\r');
+}
+
+unsigned char
+serial_getc(unsigned long com_port)
+{
+	unsigned int status ;
+	return 0;
+	do {
+		status = serial_in32(com_port, UART_LSR) ;
+	} while (!( status & UART_LSR_DR)) ;
+	return serial_in32(com_port, UART_RX);
+}
+
+int
+serial_tstc(unsigned long com_port)
+{
+	unsigned int status ;
+	return 0;
+	status = serial_in32(com_port, UART_LSR);
+	return (status & UART_LSR_DR);
+}
+
+void
+serial_close(unsigned long com_port)
+{
+}
+void
+uartlite_init(int i, struct uart_port *serial_req)
+{
+	rs_table[i].io_type = serial_req->iotype;
+	rs_table[i].port = serial_req->iobase;
+	rs_table[i].iomem_base = serial_req->membase;
+	rs_table[i].iomem_reg_shift = serial_req->regshift;
+	rs_table[i].baud_base =  BASE_BAUD;
+}
+
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+void
+uartlite_progress(char *s, unsigned short hex)
+{
+	volatile unsigned int progress_debugport;
+	volatile char c;
+
+	progress_debugport = serial_init(0, NULL);
+
+	serial_putc(progress_debugport, '\r');
+
+	while ((c = *s++) != 0)
+		serial_putc(progress_debugport, c);
+
+	serial_putc(progress_debugport, '\n');
+	serial_putc(progress_debugport, '\r');
+}
+void
+ul_putc(char c)
+{
+	volatile unsigned int progress_debugport;
+	progress_debugport = serial_init(0, NULL);
+
+	serial_putc(progress_debugport, c);
+}
+#endif /* CONFIG_SERIAL_TEXT_DEBUG */
diff --git a/arch/ppc/syslib/xilinx_pic.c b/arch/ppc/syslib/xilinx_pic.c
index 47f04c7..93d78da 100644
--- a/arch/ppc/syslib/xilinx_pic.c
+++ b/arch/ppc/syslib/xilinx_pic.c
@@ -29,6 +29,8 @@
 #define IVR 6			/* Interrupt Vector Register */
 #define MER 7			/* Master Enable Register */

+// an interupt controller is optional with the Pico E12
+#if defined(XPAR_INTC_NUM_INSTANCES) && (XPAR_INTC_NUM_INSTANCES != 0)
 #if XPAR_XINTC_USE_DCR == 0
 static volatile u32 *intc;
 #define intc_out_be32(addr, mask)     out_be32((addr), (mask))
@@ -38,13 +40,16 @@ static volatile u32 *intc;
 #define intc_out_be32(addr, mask)     mtdcr((addr), (mask))
 #define intc_in_be32(addr)            mfdcr((addr))
 #endif
+#endif

 static void
 xilinx_intc_enable(unsigned int irq)
 {
 	unsigned long mask = (0x00000001 << (irq & 31));
 	pr_debug("enable: %d\n", irq);
+#if defined(XPAR_INTC_NUM_INSTANCES) && (XPAR_INTC_NUM_INSTANCES != 0)
 	intc_out_be32(intc + SIE, mask);
+#endif
 }

 static void
@@ -52,7 +57,9 @@ xilinx_intc_disable(unsigned int irq)
 {
 	unsigned long mask = (0x00000001 << (irq & 31));
 	pr_debug("disable: %d\n", irq);
+#if defined(XPAR_INTC_NUM_INSTANCES) && (XPAR_INTC_NUM_INSTANCES != 0)
 	intc_out_be32(intc + CIE, mask);
+#endif
 }

 static void
@@ -60,9 +67,11 @@ xilinx_intc_disable_and_ack(unsigned int
 {
 	unsigned long mask = (0x00000001 << (irq & 31));
 	pr_debug("disable_and_ack: %d\n", irq);
+#if defined(XPAR_INTC_NUM_INSTANCES) && (XPAR_INTC_NUM_INSTANCES != 0)
 	intc_out_be32(intc + CIE, mask);
 	if (!(irq_desc[irq].status & IRQ_LEVEL))
 		intc_out_be32(intc + IAR, mask);	/* ack edge triggered intr */
+#endif
 }

 static void
@@ -71,12 +80,14 @@ xilinx_intc_end(unsigned int irq)
 	unsigned long mask = (0x00000001 << (irq & 31));

 	pr_debug("end: %d\n", irq);
+#if defined(XPAR_INTC_NUM_INSTANCES) && (XPAR_INTC_NUM_INSTANCES != 0)
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
 		intc_out_be32(intc + SIE, mask);
 		/* ack level sensitive intr */
 		if (irq_desc[irq].status & IRQ_LEVEL)
 			intc_out_be32(intc + IAR, mask);
 	}
+#endif
 }

 static struct hw_interrupt_type xilinx_intc = {
@@ -98,7 +109,11 @@ xilinx_pic_get_irq(struct pt_regs *regs)
 	 * is hardcoded to check for interrupts only on the first INTC.
 	 */

+#if defined(XPAR_INTC_NUM_INSTANCES) && (XPAR_INTC_NUM_INSTANCES != 0)
 	irq = intc_in_be32(intc + IVR);
+#else
+	irq = -1;
+#endif
 	if (irq != -1)
 		irq = irq;

@@ -120,6 +135,7 @@ ppc4xx_pic_init(void)
 #error NR_IRQS > 32 not supported
 #endif

+#if defined(XPAR_INTC_NUM_INSTANCES) && (XPAR_INTC_NUM_INSTANCES != 0)
 #if XPAR_XINTC_USE_DCR == 0
 	intc = ioremap(XPAR_INTC_0_BASEADDR, 32);

@@ -152,4 +168,5 @@ ppc4xx_pic_init(void)
 		else
 			irq_desc[i].status |= IRQ_LEVEL;
 	}
+#endif
 }
diff --git a/config.x86 b/config.x86
new file mode 100644
index 0000000..c6353b8
--- /dev/null
+++ b/config.x86
@@ -0,0 +1,2198 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.14.4
+# Mon Dec 19 21:24:22 2005
+#
+CONFIG_X86=y
+CONFIG_SEMAPHORE_SLEEPERS=y
+CONFIG_MMU=y
+CONFIG_UID16=y
+CONFIG_GENERIC_ISA_DMA=y
+CONFIG_GENERIC_IOMAP=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_EMBEDDED is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+CONFIG_MODVERSIONS=y
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Processor type and features
+#
+CONFIG_X86_PC=y
+# CONFIG_X86_ELAN is not set
+# CONFIG_X86_VOYAGER is not set
+# CONFIG_X86_NUMAQ is not set
+# CONFIG_X86_SUMMIT is not set
+# CONFIG_X86_BIGSMP is not set
+# CONFIG_X86_VISWS is not set
+# CONFIG_X86_GENERICARCH is not set
+# CONFIG_X86_ES7000 is not set
+# CONFIG_M386 is not set
+# CONFIG_M486 is not set
+# CONFIG_M586 is not set
+# CONFIG_M586TSC is not set
+# CONFIG_M586MMX is not set
+# CONFIG_M686 is not set
+CONFIG_MPENTIUMII=y
+# CONFIG_MPENTIUMIII is not set
+# CONFIG_MPENTIUMM is not set
+# CONFIG_MPENTIUM4 is not set
+# CONFIG_MK6 is not set
+# CONFIG_MK7 is not set
+# CONFIG_MK8 is not set
+# CONFIG_MCRUSOE is not set
+# CONFIG_MEFFICEON is not set
+# CONFIG_MWINCHIPC6 is not set
+# CONFIG_MWINCHIP2 is not set
+# CONFIG_MWINCHIP3D is not set
+# CONFIG_MGEODEGX1 is not set
+# CONFIG_MCYRIXIII is not set
+# CONFIG_MVIAC3_2 is not set
+# CONFIG_X86_GENERIC is not set
+CONFIG_X86_CMPXCHG=y
+CONFIG_X86_XADD=y
+CONFIG_X86_L1_CACHE_SHIFT=5
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_X86_WP_WORKS_OK=y
+CONFIG_X86_INVLPG=y
+CONFIG_X86_BSWAP=y
+CONFIG_X86_POPAD_OK=y
+CONFIG_X86_GOOD_APIC=y
+CONFIG_X86_INTEL_USERCOPY=y
+CONFIG_X86_USE_PPRO_CHECKSUM=y
+CONFIG_HPET_TIMER=y
+# CONFIG_SMP is not set
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_X86_UP_APIC=y
+CONFIG_X86_UP_IOAPIC=y
+CONFIG_X86_LOCAL_APIC=y
+CONFIG_X86_IO_APIC=y
+CONFIG_X86_TSC=y
+CONFIG_X86_MCE=y
+CONFIG_X86_MCE_NONFATAL=m
+CONFIG_X86_MCE_P4THERMAL=y
+CONFIG_TOSHIBA=y
+# CONFIG_I8K is not set
+CONFIG_X86_REBOOTFIXUPS=y
+CONFIG_MICROCODE=m
+CONFIG_X86_MSR=m
+CONFIG_X86_CPUID=m
+
+#
+# Firmware Drivers
+#
+# CONFIG_EDD is not set
+# CONFIG_DELL_RBU is not set
+# CONFIG_DCDBAS is not set
+CONFIG_NOHIGHMEM=y
+# CONFIG_HIGHMEM4G is not set
+# CONFIG_HIGHMEM64G is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_MATH_EMULATION is not set
+# CONFIG_MTRR is not set
+# CONFIG_EFI is not set
+# CONFIG_REGPARM is not set
+CONFIG_SECCOMP=y
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+CONFIG_PHYSICAL_START=0x100000
+# CONFIG_KEXEC is not set
+
+#
+# Power management options (ACPI, APM)
+#
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
+
+#
+# ACPI (Advanced Configuration and Power Interface) Support
+#
+CONFIG_ACPI=y
+CONFIG_ACPI_SLEEP=y
+CONFIG_ACPI_SLEEP_PROC_FS=y
+# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
+CONFIG_ACPI_AC=y
+CONFIG_ACPI_BATTERY=y
+CONFIG_ACPI_BUTTON=y
+CONFIG_ACPI_VIDEO=y
+# CONFIG_ACPI_HOTKEY is not set
+CONFIG_ACPI_FAN=y
+CONFIG_ACPI_PROCESSOR=y
+CONFIG_ACPI_THERMAL=y
+CONFIG_ACPI_ASUS=y
+CONFIG_ACPI_IBM=y
+CONFIG_ACPI_TOSHIBA=y
+CONFIG_ACPI_BLACKLIST_YEAR=0
+# CONFIG_ACPI_DEBUG is not set
+CONFIG_ACPI_EC=y
+CONFIG_ACPI_POWER=y
+CONFIG_ACPI_SYSTEM=y
+CONFIG_X86_PM_TIMER=y
+# CONFIG_ACPI_CONTAINER is not set
+
+#
+# APM (Advanced Power Management) BIOS Support
+#
+# CONFIG_APM is not set
+
+#
+# CPU Frequency scaling
+#
+# CONFIG_CPU_FREQ is not set
+
+#
+# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
+#
+CONFIG_PCI=y
+# CONFIG_PCI_GOBIOS is not set
+# CONFIG_PCI_GOMMCONFIG is not set
+# CONFIG_PCI_GODIRECT is not set
+CONFIG_PCI_GOANY=y
+CONFIG_PCI_BIOS=y
+CONFIG_PCI_DIRECT=y
+CONFIG_PCI_MMCONFIG=y
+CONFIG_PCIEPORTBUS=y
+CONFIG_HOTPLUG_PCI_PCIE=m
+# CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE is not set
+CONFIG_PCI_MSI=y
+# CONFIG_PCI_LEGACY_PROC is not set
+CONFIG_ISA_DMA_API=y
+CONFIG_ISA=y
+# CONFIG_EISA is not set
+# CONFIG_MCA is not set
+# CONFIG_SCx200 is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+CONFIG_PCCARD=y
+# CONFIG_PCMCIA_DEBUG is not set
+CONFIG_PCMCIA=y
+CONFIG_PCMCIA_LOAD_CIS=y
+CONFIG_PCMCIA_IOCTL=y
+CONFIG_CARDBUS=y
+
+#
+# PC-card bridges
+#
+CONFIG_YENTA=y
+# CONFIG_PD6729 is not set
+CONFIG_I82092=m
+CONFIG_I82365=m
+# CONFIG_TCIC is not set
+CONFIG_PCMCIA_PROBE=y
+CONFIG_PCCARD_NONSTATIC=y
+
+#
+# PCI Hotplug Support
+#
+CONFIG_HOTPLUG_PCI=m
+CONFIG_HOTPLUG_PCI_FAKE=m
+CONFIG_HOTPLUG_PCI_COMPAQ=m
+CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM=y
+CONFIG_HOTPLUG_PCI_IBM=m
+CONFIG_HOTPLUG_PCI_ACPI=m
+CONFIG_HOTPLUG_PCI_ACPI_IBM=m
+CONFIG_HOTPLUG_PCI_CPCI=y
+CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
+CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
+CONFIG_HOTPLUG_PCI_SHPC=m
+# CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE is not set
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_AOUT=m
+CONFIG_BINFMT_MISC=m
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+CONFIG_PACKET_MMAP=y
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+CONFIG_XFRM_USER=m
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_ASK_IP_FIB_HASH=y
+# CONFIG_IP_FIB_TRIE is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_FWMARK=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_MULTIPATH_CACHED=y
+CONFIG_IP_ROUTE_MULTIPATH_RR=m
+CONFIG_IP_ROUTE_MULTIPATH_RANDOM=m
+CONFIG_IP_ROUTE_MULTIPATH_WRANDOM=m
+CONFIG_IP_ROUTE_MULTIPATH_DRR=m
+CONFIG_IP_ROUTE_VERBOSE=y
+# CONFIG_IP_PNP is not set
+CONFIG_NET_IPIP=m
+CONFIG_NET_IPGRE=m
+CONFIG_NET_IPGRE_BROADCAST=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+CONFIG_INET_AH=y
+CONFIG_INET_ESP=y
+CONFIG_INET_IPCOMP=y
+CONFIG_INET_TUNNEL=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+CONFIG_TCP_CONG_ADVANCED=y
+
+#
+# TCP congestion control
+#
+CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_WESTWOOD=m
+CONFIG_TCP_CONG_HTCP=m
+CONFIG_TCP_CONG_HSTCP=m
+CONFIG_TCP_CONG_HYBLA=m
+CONFIG_TCP_CONG_VEGAS=m
+CONFIG_TCP_CONG_SCALABLE=m
+
+#
+# IP: Virtual Server Configuration
+#
+# CONFIG_IP_VS is not set
+CONFIG_IPV6=m
+CONFIG_IPV6_PRIVACY=y
+CONFIG_INET6_AH=m
+CONFIG_INET6_ESP=m
+CONFIG_INET6_IPCOMP=m
+CONFIG_INET6_TUNNEL=m
+# CONFIG_IPV6_TUNNEL is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+# CONFIG_NETFILTER_NETLINK is not set
+
+#
+# IP: Netfilter Configuration
+#
+CONFIG_IP_NF_CONNTRACK=m
+CONFIG_IP_NF_CT_ACCT=y
+CONFIG_IP_NF_CONNTRACK_MARK=y
+CONFIG_IP_NF_CONNTRACK_EVENTS=y
+CONFIG_IP_NF_CT_PROTO_SCTP=m
+CONFIG_IP_NF_FTP=m
+CONFIG_IP_NF_IRC=m
+CONFIG_IP_NF_NETBIOS_NS=m
+CONFIG_IP_NF_TFTP=m
+CONFIG_IP_NF_AMANDA=m
+CONFIG_IP_NF_PPTP=m
+CONFIG_IP_NF_QUEUE=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_MATCH_LIMIT=m
+CONFIG_IP_NF_MATCH_IPRANGE=m
+CONFIG_IP_NF_MATCH_MAC=m
+CONFIG_IP_NF_MATCH_PKTTYPE=m
+CONFIG_IP_NF_MATCH_MARK=m
+CONFIG_IP_NF_MATCH_MULTIPORT=m
+CONFIG_IP_NF_MATCH_TOS=m
+CONFIG_IP_NF_MATCH_RECENT=m
+CONFIG_IP_NF_MATCH_ECN=m
+CONFIG_IP_NF_MATCH_DSCP=m
+CONFIG_IP_NF_MATCH_AH_ESP=m
+CONFIG_IP_NF_MATCH_LENGTH=m
+CONFIG_IP_NF_MATCH_TTL=m
+CONFIG_IP_NF_MATCH_TCPMSS=m
+CONFIG_IP_NF_MATCH_HELPER=m
+CONFIG_IP_NF_MATCH_STATE=m
+CONFIG_IP_NF_MATCH_CONNTRACK=m
+CONFIG_IP_NF_MATCH_OWNER=m
+CONFIG_IP_NF_MATCH_ADDRTYPE=m
+CONFIG_IP_NF_MATCH_REALM=m
+CONFIG_IP_NF_MATCH_SCTP=m
+CONFIG_IP_NF_MATCH_DCCP=m
+CONFIG_IP_NF_MATCH_COMMENT=m
+CONFIG_IP_NF_MATCH_CONNMARK=m
+CONFIG_IP_NF_MATCH_CONNBYTES=m
+CONFIG_IP_NF_MATCH_HASHLIMIT=m
+CONFIG_IP_NF_MATCH_STRING=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_TARGET_LOG=m
+CONFIG_IP_NF_TARGET_ULOG=m
+CONFIG_IP_NF_TARGET_TCPMSS=m
+CONFIG_IP_NF_TARGET_NFQUEUE=m
+CONFIG_IP_NF_NAT=m
+CONFIG_IP_NF_NAT_NEEDED=y
+CONFIG_IP_NF_TARGET_MASQUERADE=m
+CONFIG_IP_NF_TARGET_REDIRECT=m
+CONFIG_IP_NF_TARGET_NETMAP=m
+CONFIG_IP_NF_TARGET_SAME=m
+CONFIG_IP_NF_NAT_SNMP_BASIC=m
+CONFIG_IP_NF_NAT_IRC=m
+CONFIG_IP_NF_NAT_FTP=m
+CONFIG_IP_NF_NAT_TFTP=m
+CONFIG_IP_NF_NAT_AMANDA=m
+CONFIG_IP_NF_NAT_PPTP=m
+CONFIG_IP_NF_MANGLE=m
+CONFIG_IP_NF_TARGET_TOS=m
+CONFIG_IP_NF_TARGET_ECN=m
+CONFIG_IP_NF_TARGET_DSCP=m
+CONFIG_IP_NF_TARGET_MARK=m
+CONFIG_IP_NF_TARGET_CLASSIFY=m
+CONFIG_IP_NF_TARGET_TTL=m
+CONFIG_IP_NF_TARGET_CONNMARK=m
+CONFIG_IP_NF_TARGET_CLUSTERIP=m
+CONFIG_IP_NF_RAW=m
+CONFIG_IP_NF_TARGET_NOTRACK=m
+CONFIG_IP_NF_ARPTABLES=m
+CONFIG_IP_NF_ARPFILTER=m
+CONFIG_IP_NF_ARP_MANGLE=m
+
+#
+# IPv6: Netfilter Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP6_NF_QUEUE is not set
+# CONFIG_IP6_NF_IPTABLES is not set
+# CONFIG_IP6_NF_TARGET_NFQUEUE is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+CONFIG_IP_SCTP=m
+# CONFIG_SCTP_DBG_MSG is not set
+# CONFIG_SCTP_DBG_OBJCNT is not set
+# CONFIG_SCTP_HMAC_NONE is not set
+# CONFIG_SCTP_HMAC_SHA1 is not set
+CONFIG_SCTP_HMAC_MD5=y
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+CONFIG_NET_SCHED=y
+CONFIG_NET_SCH_CLK_JIFFIES=y
+# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
+# CONFIG_NET_SCH_CLK_CPU is not set
+CONFIG_NET_SCH_CBQ=m
+CONFIG_NET_SCH_HTB=m
+CONFIG_NET_SCH_HFSC=m
+CONFIG_NET_SCH_PRIO=m
+CONFIG_NET_SCH_RED=m
+CONFIG_NET_SCH_SFQ=m
+CONFIG_NET_SCH_TEQL=m
+CONFIG_NET_SCH_TBF=m
+CONFIG_NET_SCH_GRED=m
+CONFIG_NET_SCH_DSMARK=m
+CONFIG_NET_SCH_NETEM=m
+CONFIG_NET_SCH_INGRESS=m
+CONFIG_NET_QOS=y
+CONFIG_NET_ESTIMATOR=y
+CONFIG_NET_CLS=y
+CONFIG_NET_CLS_BASIC=m
+CONFIG_NET_CLS_TCINDEX=m
+CONFIG_NET_CLS_ROUTE4=m
+CONFIG_NET_CLS_ROUTE=y
+CONFIG_NET_CLS_FW=m
+CONFIG_NET_CLS_U32=m
+# CONFIG_CLS_U32_PERF is not set
+# CONFIG_NET_CLS_IND is not set
+# CONFIG_CLS_U32_MARK is not set
+CONFIG_NET_CLS_RSVP=m
+CONFIG_NET_CLS_RSVP6=m
+CONFIG_NET_EMATCH=y
+CONFIG_NET_EMATCH_STACK=32
+CONFIG_NET_EMATCH_CMP=m
+CONFIG_NET_EMATCH_NBYTE=m
+CONFIG_NET_EMATCH_U32=m
+CONFIG_NET_EMATCH_META=m
+CONFIG_NET_EMATCH_TEXT=m
+# CONFIG_NET_CLS_ACT is not set
+CONFIG_NET_CLS_POLICE=y
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+CONFIG_IRDA=m
+
+#
+# IrDA protocols
+#
+CONFIG_IRLAN=m
+CONFIG_IRNET=m
+CONFIG_IRCOMM=m
+# CONFIG_IRDA_ULTRA is not set
+
+#
+# IrDA options
+#
+CONFIG_IRDA_CACHE_LAST_LSAP=y
+CONFIG_IRDA_FAST_RR=y
+CONFIG_IRDA_DEBUG=y
+
+#
+# Infrared-port device drivers
+#
+
+#
+# SIR device drivers
+#
+CONFIG_IRTTY_SIR=m
+
+#
+# Dongle support
+#
+# CONFIG_DONGLE is not set
+
+#
+# Old SIR device drivers
+#
+CONFIG_IRPORT_SIR=m
+
+#
+# Old Serial dongle support
+#
+# CONFIG_DONGLE_OLD is not set
+
+#
+# FIR device drivers
+#
+# CONFIG_USB_IRDA is not set
+# CONFIG_SIGMATEL_FIR is not set
+# CONFIG_NSC_FIR is not set
+# CONFIG_WINBOND_FIR is not set
+CONFIG_TOSHIBA_FIR=m
+CONFIG_SMC_IRCC_FIR=m
+# CONFIG_ALI_FIR is not set
+# CONFIG_VLSI_FIR is not set
+# CONFIG_VIA_FIR is not set
+CONFIG_BT=m
+CONFIG_BT_L2CAP=m
+CONFIG_BT_SCO=m
+CONFIG_BT_RFCOMM=m
+CONFIG_BT_RFCOMM_TTY=y
+CONFIG_BT_BNEP=m
+CONFIG_BT_BNEP_MC_FILTER=y
+CONFIG_BT_BNEP_PROTO_FILTER=y
+CONFIG_BT_HIDP=m
+
+#
+# Bluetooth device drivers
+#
+CONFIG_BT_HCIUSB=m
+CONFIG_BT_HCIUSB_SCO=y
+CONFIG_BT_HCIUART=m
+CONFIG_BT_HCIUART_H4=y
+CONFIG_BT_HCIUART_BCSP=y
+# CONFIG_BT_HCIUART_BCSP_TXCRC is not set
+CONFIG_BT_HCIBCM203X=m
+CONFIG_BT_HCIBPA10X=m
+CONFIG_BT_HCIBFUSB=m
+# CONFIG_BT_HCIDTL1 is not set
+# CONFIG_BT_HCIBT3C is not set
+# CONFIG_BT_HCIBLUECARD is not set
+# CONFIG_BT_HCIBTUART is not set
+# CONFIG_BT_HCIVHCI is not set
+CONFIG_IEEE80211=m
+# CONFIG_IEEE80211_DEBUG is not set
+CONFIG_IEEE80211_CRYPT_WEP=m
+CONFIG_IEEE80211_CRYPT_CCMP=m
+CONFIG_IEEE80211_CRYPT_TKIP=m
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+CONFIG_CONNECTOR=m
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+CONFIG_PNP=y
+# CONFIG_PNP_DEBUG is not set
+
+#
+# Protocols
+#
+CONFIG_ISAPNP=y
+CONFIG_PNPBIOS=y
+CONFIG_PNPBIOS_PROC_FS=y
+CONFIG_PNPACPI=y
+
+#
+# Block devices
+#
+CONFIG_BLK_DEV_FD=m
+# CONFIG_BLK_DEV_XD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_CRYPTOLOOP=m
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_LBD=y
+CONFIG_CDROM_PKTCDVD=m
+CONFIG_CDROM_PKTCDVD_BUFFERS=8
+# CONFIG_CDROM_PKTCDVD_WCACHE is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+# CONFIG_BLK_DEV_HD_IDE is not set
+CONFIG_BLK_DEV_IDEDISK=y
+CONFIG_IDEDISK_MULTI_MODE=y
+# CONFIG_BLK_DEV_IDECS is not set
+CONFIG_BLK_DEV_IDECD=m
+CONFIG_BLK_DEV_IDETAPE=m
+CONFIG_BLK_DEV_IDEFLOPPY=m
+CONFIG_BLK_DEV_IDESCSI=m
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+# CONFIG_IDE_GENERIC is not set
+CONFIG_BLK_DEV_CMD640=y
+# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
+# CONFIG_BLK_DEV_IDEPNP is not set
+CONFIG_BLK_DEV_IDEPCI=y
+CONFIG_IDEPCI_SHARE_IRQ=y
+# CONFIG_BLK_DEV_OFFBOARD is not set
+# CONFIG_BLK_DEV_GENERIC is not set
+# CONFIG_BLK_DEV_OPTI621 is not set
+# CONFIG_BLK_DEV_RZ1000 is not set
+CONFIG_BLK_DEV_IDEDMA_PCI=y
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
+CONFIG_IDEDMA_PCI_AUTO=y
+# CONFIG_IDEDMA_ONLYDISK is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+CONFIG_BLK_DEV_ATIIXP=m
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+CONFIG_BLK_DEV_PIIX=y
+# CONFIG_BLK_DEV_IT821X is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+CONFIG_BLK_DEV_PDC202XX_OLD=y
+CONFIG_PDC202XX_BURST=y
+CONFIG_BLK_DEV_PDC202XX_NEW=y
+# CONFIG_PDC202XX_FORCE is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SIS5513 is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
+# CONFIG_IDE_ARM is not set
+# CONFIG_IDE_CHIPSETS is not set
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_IVB is not set
+CONFIG_IDEDMA_AUTO=y
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+CONFIG_SCSI=y
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_ST=m
+CONFIG_CHR_DEV_OSST=m
+CONFIG_BLK_DEV_SR=m
+CONFIG_BLK_DEV_SR_VENDOR=y
+CONFIG_CHR_DEV_SG=m
+CONFIG_CHR_DEV_SCH=m
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+
+#
+# SCSI Transport Attributes
+#
+CONFIG_SCSI_SPI_ATTRS=m
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_ATTRS is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_7000FASST is not set
+# CONFIG_SCSI_ACARD is not set
+CONFIG_SCSI_AHA152X=m
+# CONFIG_SCSI_AHA1542 is not set
+# CONFIG_SCSI_AACRAID is not set
+CONFIG_SCSI_AIC7XXX=m
+CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
+CONFIG_AIC7XXX_RESET_DELAY_MS=15000
+CONFIG_AIC7XXX_DEBUG_ENABLE=y
+CONFIG_AIC7XXX_DEBUG_MASK=0
+CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_IN2000 is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_MEGARAID_SAS is not set
+CONFIG_SCSI_SATA=y
+# CONFIG_SCSI_SATA_AHCI is not set
+# CONFIG_SCSI_SATA_SVW is not set
+# CONFIG_SCSI_ATA_PIIX is not set
+# CONFIG_SCSI_SATA_MV is not set
+# CONFIG_SCSI_SATA_NV is not set
+CONFIG_SCSI_SATA_PROMISE=y
+# CONFIG_SCSI_SATA_QSTOR is not set
+CONFIG_SCSI_SATA_SX4=y
+# CONFIG_SCSI_SATA_SIL is not set
+# CONFIG_SCSI_SATA_SIS is not set
+# CONFIG_SCSI_SATA_ULI is not set
+# CONFIG_SCSI_SATA_VIA is not set
+# CONFIG_SCSI_SATA_VITESSE is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_SCSI_DMX3191D is not set
+CONFIG_SCSI_DTC3280=m
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+CONFIG_SCSI_GENERIC_NCR5380=m
+CONFIG_SCSI_GENERIC_NCR5380_MMIO=m
+# CONFIG_SCSI_GENERIC_NCR53C400 is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+CONFIG_SCSI_NCR53C406A=m
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_IPR is not set
+# CONFIG_SCSI_PAS16 is not set
+# CONFIG_SCSI_PSI240I is not set
+# CONFIG_SCSI_QLOGIC_FAS is not set
+# CONFIG_SCSI_QLOGIC_FC is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+# CONFIG_SCSI_QLA2XXX is not set
+# CONFIG_SCSI_QLA21XX is not set
+# CONFIG_SCSI_QLA22XX is not set
+# CONFIG_SCSI_QLA2300 is not set
+# CONFIG_SCSI_QLA2322 is not set
+# CONFIG_SCSI_QLA6312 is not set
+# CONFIG_SCSI_QLA24XX is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_SYM53C416 is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_T128 is not set
+# CONFIG_SCSI_U14_34F is not set
+# CONFIG_SCSI_ULTRASTOR is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_DEBUG is not set
+
+#
+# PCMCIA SCSI adapter support
+#
+# CONFIG_PCMCIA_AHA152X is not set
+# CONFIG_PCMCIA_FDOMAIN is not set
+# CONFIG_PCMCIA_NINJA_SCSI is not set
+# CONFIG_PCMCIA_QLOGIC is not set
+# CONFIG_PCMCIA_SYM53C500 is not set
+
+#
+# Old CD-ROM drivers (not SCSI, not IDE)
+#
+# CONFIG_CD_NO_IDESCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+CONFIG_MD=y
+CONFIG_BLK_DEV_MD=m
+CONFIG_MD_LINEAR=m
+CONFIG_MD_RAID0=m
+CONFIG_MD_RAID1=m
+CONFIG_MD_RAID10=m
+CONFIG_MD_RAID5=m
+CONFIG_MD_RAID6=m
+CONFIG_MD_MULTIPATH=m
+CONFIG_MD_FAULTY=m
+CONFIG_BLK_DEV_DM=m
+CONFIG_DM_CRYPT=m
+CONFIG_DM_SNAPSHOT=m
+CONFIG_DM_MIRROR=m
+CONFIG_DM_ZERO=m
+CONFIG_DM_MULTIPATH=m
+CONFIG_DM_MULTIPATH_EMC=m
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+# CONFIG_FUSION_SPI is not set
+# CONFIG_FUSION_FC is not set
+# CONFIG_FUSION_SAS is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+CONFIG_IEEE1394=m
+
+#
+# Subsystem Options
+#
+# CONFIG_IEEE1394_VERBOSEDEBUG is not set
+# CONFIG_IEEE1394_OUI_DB is not set
+CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
+CONFIG_IEEE1394_CONFIG_ROM_IP1394=y
+# CONFIG_IEEE1394_EXPORT_FULL_API is not set
+
+#
+# Device Drivers
+#
+CONFIG_IEEE1394_PCILYNX=m
+CONFIG_IEEE1394_OHCI1394=m
+
+#
+# Protocol Drivers
+#
+CONFIG_IEEE1394_VIDEO1394=m
+CONFIG_IEEE1394_SBP2=m
+# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
+CONFIG_IEEE1394_ETH1394=m
+CONFIG_IEEE1394_DV1394=m
+CONFIG_IEEE1394_RAWIO=m
+# CONFIG_IEEE1394_CMP is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+CONFIG_DUMMY=m
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+CONFIG_TUN=y
+# CONFIG_NET_SB1000 is not set
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# PHY device support
+#
+CONFIG_PHYLIB=m
+CONFIG_PHYCONTROL=y
+
+#
+# MII PHY device drivers
+#
+CONFIG_MARVELL_PHY=m
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+CONFIG_NET_VENDOR_3COM=y
+# CONFIG_EL1 is not set
+CONFIG_EL2=m
+# CONFIG_ELPLUS is not set
+# CONFIG_EL16 is not set
+CONFIG_EL3=m
+# CONFIG_3C515 is not set
+CONFIG_VORTEX=y
+# CONFIG_TYPHOON is not set
+CONFIG_LANCE=m
+# CONFIG_NET_VENDOR_SMC is not set
+# CONFIG_NET_VENDOR_RACAL is not set
+
+#
+# Tulip family network device support
+#
+CONFIG_NET_TULIP=y
+CONFIG_DE2104X=m
+CONFIG_TULIP=m
+CONFIG_TULIP_MWI=y
+CONFIG_TULIP_MMIO=y
+# CONFIG_TULIP_NAPI is not set
+CONFIG_DE4X5=m
+# CONFIG_WINBOND_840 is not set
+# CONFIG_DM9102 is not set
+# CONFIG_ULI526X is not set
+CONFIG_PCMCIA_XIRCOM=m
+CONFIG_PCMCIA_XIRTULIP=m
+# CONFIG_AT1700 is not set
+CONFIG_DEPCA=m
+CONFIG_HP100=m
+CONFIG_NET_ISA=y
+# CONFIG_E2100 is not set
+# CONFIG_EWRK3 is not set
+# CONFIG_EEXPRESS is not set
+# CONFIG_EEXPRESS_PRO is not set
+# CONFIG_HPLAN_PLUS is not set
+# CONFIG_HPLAN is not set
+# CONFIG_LP486E is not set
+# CONFIG_ETH16I is not set
+CONFIG_NE2000=y
+# CONFIG_ZNET is not set
+# CONFIG_SEEQ8005 is not set
+CONFIG_NET_PCI=y
+CONFIG_PCNET32=y
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_AC3200 is not set
+# CONFIG_APRICOT is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+CONFIG_CS89x0=m
+# CONFIG_DGRS is not set
+CONFIG_EEPRO100=y
+CONFIG_E100=y
+# CONFIG_FEALNX is not set
+CONFIG_NATSEMI=y
+CONFIG_NE2K_PCI=y
+CONFIG_8139CP=y
+CONFIG_8139TOO=y
+CONFIG_8139TOO_PIO=y
+CONFIG_8139TOO_TUNE_TWISTER=y
+CONFIG_8139TOO_8129=y
+# CONFIG_8139_OLD_RX_RESET is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+CONFIG_NET_RADIO=y
+
+#
+# Obsolete Wireless cards support (pre-802.11)
+#
+# CONFIG_STRIP is not set
+# CONFIG_ARLAN is not set
+CONFIG_WAVELAN=m
+CONFIG_PCMCIA_WAVELAN=m
+# CONFIG_PCMCIA_NETWAVE is not set
+
+#
+# Wireless 802.11 Frequency Hopping cards support
+#
+# CONFIG_PCMCIA_RAYCS is not set
+
+#
+# Wireless 802.11b ISA/PCI cards support
+#
+CONFIG_IPW2100=m
+CONFIG_IPW2100_MONITOR=y
+# CONFIG_IPW_DEBUG is not set
+CONFIG_IPW2200=m
+CONFIG_AIRO=m
+CONFIG_HERMES=m
+CONFIG_PLX_HERMES=m
+CONFIG_TMD_HERMES=m
+CONFIG_NORTEL_HERMES=m
+CONFIG_PCI_HERMES=m
+CONFIG_ATMEL=m
+CONFIG_PCI_ATMEL=m
+
+#
+# Wireless 802.11b Pcmcia/Cardbus cards support
+#
+CONFIG_PCMCIA_HERMES=m
+# CONFIG_PCMCIA_SPECTRUM is not set
+CONFIG_AIRO_CS=m
+CONFIG_PCMCIA_ATMEL=m
+CONFIG_PCMCIA_WL3501=m
+
+#
+# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
+#
+CONFIG_PRISM54=m
+CONFIG_HOSTAP=m
+CONFIG_HOSTAP_FIRMWARE=y
+CONFIG_HOSTAP_PLX=m
+CONFIG_HOSTAP_PCI=m
+CONFIG_HOSTAP_CS=m
+CONFIG_NET_WIRELESS=y
+
+#
+# PCMCIA network device support
+#
+CONFIG_NET_PCMCIA=y
+CONFIG_PCMCIA_3C589=m
+# CONFIG_PCMCIA_3C574 is not set
+# CONFIG_PCMCIA_FMVJ18X is not set
+CONFIG_PCMCIA_PCNET=m
+# CONFIG_PCMCIA_NMCLAN is not set
+# CONFIG_PCMCIA_SMC91C92 is not set
+CONFIG_PCMCIA_XIRC2PS=m
+# CONFIG_PCMCIA_AXNET is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+CONFIG_PPP=m
+CONFIG_PPP_MULTILINK=y
+CONFIG_PPP_FILTER=y
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_MPPE=m
+CONFIG_PPPOE=m
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=m
+CONFIG_MOUSE_SERIAL=m
+# CONFIG_MOUSE_INPORT is not set
+# CONFIG_MOUSE_LOGIBM is not set
+# CONFIG_MOUSE_PC110PAD is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PCIPS2 is not set
+CONFIG_SERIO_LIBPS2=y
+CONFIG_SERIO_RAW=m
+CONFIG_GAMEPORT=m
+# CONFIG_GAMEPORT_NS558 is not set
+# CONFIG_GAMEPORT_L4 is not set
+# CONFIG_GAMEPORT_EMU10K1 is not set
+# CONFIG_GAMEPORT_FM801 is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+CONFIG_SERIAL_NONSTANDARD=y
+# CONFIG_COMPUTONE is not set
+# CONFIG_ROCKETPORT is not set
+# CONFIG_CYCLADES is not set
+# CONFIG_DIGIEPCA is not set
+# CONFIG_ESPSERIAL is not set
+# CONFIG_MOXA_INTELLIO is not set
+# CONFIG_MOXA_SMARTIO is not set
+# CONFIG_ISI is not set
+# CONFIG_SYNCLINK is not set
+# CONFIG_SYNCLINKMP is not set
+# CONFIG_N_HDLC is not set
+# CONFIG_RISCOM8 is not set
+# CONFIG_SPECIALIX is not set
+# CONFIG_SX is not set
+# CONFIG_RIO is not set
+# CONFIG_STALDRV is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_CONSOLE is not set
+# CONFIG_SERIAL_8250_CS is not set
+# CONFIG_SERIAL_8250_ACPI is not set
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_8250_DETECT_IRQ=y
+# CONFIG_SERIAL_8250_RSA is not set
+# CONFIG_SERIAL_8250_FOURPORT is not set
+# CONFIG_SERIAL_8250_ACCENT is not set
+# CONFIG_SERIAL_8250_BOCA is not set
+# CONFIG_SERIAL_8250_HUB6 is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+# CONFIG_SERIAL_JSM is not set
+
+#
+# Xilinx uartlite devices
+#
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+CONFIG_SOFT_WATCHDOG=m
+# CONFIG_ACQUIRE_WDT is not set
+# CONFIG_ADVANTECH_WDT is not set
+# CONFIG_ALIM1535_WDT is not set
+# CONFIG_ALIM7101_WDT is not set
+# CONFIG_SC520_WDT is not set
+# CONFIG_EUROTECH_WDT is not set
+# CONFIG_IB700_WDT is not set
+# CONFIG_IBMASR is not set
+# CONFIG_WAFER_WDT is not set
+# CONFIG_I6300ESB_WDT is not set
+CONFIG_I8XX_TCO=m
+# CONFIG_SC1200_WDT is not set
+# CONFIG_60XX_WDT is not set
+# CONFIG_SBC8360_WDT is not set
+# CONFIG_CPU5_WDT is not set
+# CONFIG_W83627HF_WDT is not set
+# CONFIG_W83877F_WDT is not set
+# CONFIG_W83977F_WDT is not set
+# CONFIG_MACHZ_WDT is not set
+
+#
+# ISA-based Watchdog Cards
+#
+CONFIG_PCWATCHDOG=m
+# CONFIG_MIXCOMWD is not set
+# CONFIG_WDT is not set
+
+#
+# PCI-based Watchdog Cards
+#
+# CONFIG_PCIPCWATCHDOG is not set
+# CONFIG_WDTPCI is not set
+
+#
+# USB-based Watchdog Cards
+#
+# CONFIG_USBPCWATCHDOG is not set
+CONFIG_HW_RANDOM=m
+CONFIG_NVRAM=m
+CONFIG_RTC=m
+CONFIG_GEN_RTC=m
+CONFIG_GEN_RTC_X=y
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_SONYPI is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_FTAPE is not set
+CONFIG_AGP=m
+CONFIG_AGP_ALI=m
+CONFIG_AGP_ATI=m
+CONFIG_AGP_AMD=m
+# CONFIG_AGP_AMD64 is not set
+CONFIG_AGP_INTEL=m
+# CONFIG_AGP_NVIDIA is not set
+# CONFIG_AGP_SIS is not set
+# CONFIG_AGP_SWORKS is not set
+# CONFIG_AGP_VIA is not set
+# CONFIG_AGP_EFFICEON is not set
+CONFIG_DRM=m
+# CONFIG_DRM_TDFX is not set
+CONFIG_DRM_R128=m
+CONFIG_DRM_RADEON=m
+CONFIG_DRM_I810=m
+# CONFIG_DRM_I830 is not set
+# CONFIG_DRM_I915 is not set
+# CONFIG_DRM_MGA is not set
+# CONFIG_DRM_SIS is not set
+# CONFIG_DRM_VIA is not set
+# CONFIG_DRM_SAVAGE is not set
+
+#
+# PCMCIA character devices
+#
+# CONFIG_SYNCLINK_CS is not set
+# CONFIG_MWAVE is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_HPET is not set
+CONFIG_HANGCHECK_TIMER=m
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
+# I2C support
+#
+CONFIG_I2C=m
+# CONFIG_I2C_CHARDEV is not set
+
+#
+# I2C Algorithms
+#
+CONFIG_I2C_ALGOBIT=m
+CONFIG_I2C_ALGOPCF=m
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_ELEKTOR is not set
+CONFIG_I2C_I801=m
+CONFIG_I2C_I810=m
+CONFIG_I2C_PIIX4=m
+CONFIG_I2C_ISA=m
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_SCx200_ACB is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+CONFIG_I2C_STUB=m
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
+# CONFIG_I2C_PCA_ISA is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_DS1337 is not set
+CONFIG_SENSORS_DS1374=m
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+CONFIG_SENSORS_PCA9539=m
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_RTC8564 is not set
+CONFIG_SENSORS_MAX6875=m
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+
+#
+# Dallas's 1-wire bus
+#
+CONFIG_W1=y
+# CONFIG_W1_MATROX is not set
+CONFIG_W1_DS9490=m
+CONFIG_W1_DS9490_BRIDGE=m
+CONFIG_W1_THERM=m
+CONFIG_W1_SMEM=m
+CONFIG_W1_DS2433=m
+CONFIG_W1_DS2433_CRC=y
+
+#
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
+CONFIG_HWMON_VID=m
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+CONFIG_SENSORS_ADM9240=m
+# CONFIG_SENSORS_ASB100 is not set
+CONFIG_SENSORS_ATXP1=m
+CONFIG_SENSORS_DS1621=m
+# CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_FSCPOS is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
+CONFIG_SENSORS_IT87=m
+CONFIG_SENSORS_LM63=m
+CONFIG_SENSORS_LM75=m
+CONFIG_SENSORS_LM77=m
+CONFIG_SENSORS_LM78=m
+CONFIG_SENSORS_LM80=m
+CONFIG_SENSORS_LM83=m
+CONFIG_SENSORS_LM85=m
+CONFIG_SENSORS_LM87=m
+CONFIG_SENSORS_LM90=m
+# CONFIG_SENSORS_LM92 is not set
+CONFIG_SENSORS_MAX1619=m
+CONFIG_SENSORS_PC87360=m
+# CONFIG_SENSORS_SIS5595 is not set
+CONFIG_SENSORS_SMSC47M1=m
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83792D is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83627HF is not set
+CONFIG_SENSORS_W83627EHF=m
+# CONFIG_SENSORS_HDAPS is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
+# Misc devices
+#
+# CONFIG_IBM_ASM is not set
+
+#
+# Multimedia Capabilities Port drivers
+#
+
+#
+# Multimedia devices
+#
+CONFIG_VIDEO_DEV=m
+
+#
+# Video For Linux
+#
+
+#
+# Video Adapters
+#
+CONFIG_VIDEO_BT848=m
+CONFIG_VIDEO_SAA6588=m
+# CONFIG_VIDEO_PMS is not set
+# CONFIG_VIDEO_CPIA is not set
+# CONFIG_VIDEO_SAA5246A is not set
+# CONFIG_VIDEO_SAA5249 is not set
+# CONFIG_TUNER_3036 is not set
+# CONFIG_VIDEO_STRADIS is not set
+# CONFIG_VIDEO_ZORAN is not set
+# CONFIG_VIDEO_SAA7134 is not set
+# CONFIG_VIDEO_MXB is not set
+# CONFIG_VIDEO_DPC is not set
+# CONFIG_VIDEO_HEXIUM_ORION is not set
+# CONFIG_VIDEO_HEXIUM_GEMINI is not set
+CONFIG_VIDEO_CX88=m
+# CONFIG_VIDEO_OVCAMCHIP is not set
+
+#
+# Radio Adapters
+#
+# CONFIG_RADIO_CADET is not set
+# CONFIG_RADIO_RTRACK is not set
+# CONFIG_RADIO_RTRACK2 is not set
+# CONFIG_RADIO_AZTECH is not set
+# CONFIG_RADIO_GEMTEK is not set
+# CONFIG_RADIO_GEMTEK_PCI is not set
+# CONFIG_RADIO_MAXIRADIO is not set
+# CONFIG_RADIO_MAESTRO is not set
+# CONFIG_RADIO_SF16FMI is not set
+# CONFIG_RADIO_SF16FMR2 is not set
+# CONFIG_RADIO_TERRATEC is not set
+# CONFIG_RADIO_TRUST is not set
+# CONFIG_RADIO_TYPHOON is not set
+# CONFIG_RADIO_ZOLTRIX is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+CONFIG_VIDEO_TUNER=m
+CONFIG_VIDEO_BUF=m
+CONFIG_VIDEO_BTCX=m
+CONFIG_VIDEO_IR=m
+CONFIG_VIDEO_TVEEPROM=m
+
+#
+# Graphics support
+#
+CONFIG_FB=y
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+CONFIG_FB_SOFT_CURSOR=y
+# CONFIG_FB_MACMODES is not set
+CONFIG_FB_MODE_HELPERS=y
+CONFIG_FB_TILEBLITTING=y
+# CONFIG_FB_CIRRUS is not set
+# CONFIG_FB_PM2 is not set
+# CONFIG_FB_CYBER2000 is not set
+# CONFIG_FB_ARC is not set
+# CONFIG_FB_ASILIANT is not set
+# CONFIG_FB_IMSTT is not set
+CONFIG_FB_VGA16=m
+CONFIG_FB_VESA=y
+CONFIG_VIDEO_SELECT=y
+# CONFIG_FB_HGA is not set
+# CONFIG_FB_NVIDIA is not set
+CONFIG_FB_RIVA=m
+# CONFIG_FB_RIVA_I2C is not set
+# CONFIG_FB_RIVA_DEBUG is not set
+CONFIG_FB_I810=m
+CONFIG_FB_I810_GTF=y
+# CONFIG_FB_I810_I2C is not set
+# CONFIG_FB_INTEL is not set
+# CONFIG_FB_MATROX is not set
+CONFIG_FB_RADEON_OLD=m
+CONFIG_FB_RADEON=m
+CONFIG_FB_RADEON_I2C=y
+# CONFIG_FB_RADEON_DEBUG is not set
+CONFIG_FB_ATY128=m
+CONFIG_FB_ATY=m
+CONFIG_FB_ATY_CT=y
+CONFIG_FB_ATY_GENERIC_LCD=y
+# CONFIG_FB_ATY_XL_INIT is not set
+# CONFIG_FB_ATY_GX is not set
+# CONFIG_FB_SAVAGE is not set
+# CONFIG_FB_SIS is not set
+# CONFIG_FB_NEOMAGIC is not set
+# CONFIG_FB_KYRO is not set
+# CONFIG_FB_3DFX is not set
+# CONFIG_FB_VOODOO1 is not set
+CONFIG_FB_CYBLA=m
+CONFIG_FB_TRIDENT=m
+# CONFIG_FB_TRIDENT_ACCEL is not set
+# CONFIG_FB_GEODE is not set
+# CONFIG_FB_S1D13XXX is not set
+CONFIG_FB_VIRTUAL=m
+
+#
+# Console display driver support
+#
+CONFIG_VGA_CONSOLE=y
+# CONFIG_MDA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+
+#
+# Logo configuration
+#
+CONFIG_LOGO=y
+CONFIG_LOGO_LINUX_MONO=y
+CONFIG_LOGO_LINUX_VGA16=y
+CONFIG_LOGO_LINUX_CLUT224=y
+CONFIG_LOGO_LINUX_DEBIAN=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=m
+CONFIG_BACKLIGHT_DEVICE=y
+CONFIG_LCD_CLASS_DEVICE=m
+CONFIG_LCD_DEVICE=y
+
+#
+# Sound
+#
+CONFIG_SOUND=m
+
+#
+# Advanced Linux Sound Architecture
+#
+CONFIG_SND=m
+CONFIG_SND_TIMER=m
+CONFIG_SND_PCM=m
+CONFIG_SND_HWDEP=m
+CONFIG_SND_RAWMIDI=m
+CONFIG_SND_SEQUENCER=m
+CONFIG_SND_SEQ_DUMMY=m
+CONFIG_SND_OSSEMUL=y
+CONFIG_SND_MIXER_OSS=m
+CONFIG_SND_PCM_OSS=m
+CONFIG_SND_SEQUENCER_OSS=y
+CONFIG_SND_RTCTIMER=m
+CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
+CONFIG_SND_VERBOSE_PRINTK=y
+CONFIG_SND_DEBUG=y
+# CONFIG_SND_DEBUG_MEMORY is not set
+CONFIG_SND_DEBUG_DETECT=y
+CONFIG_SND_GENERIC_DRIVER=y
+
+#
+# Generic devices
+#
+CONFIG_SND_MPU401_UART=m
+CONFIG_SND_OPL3_LIB=m
+CONFIG_SND_DUMMY=m
+# CONFIG_SND_VIRMIDI is not set
+# CONFIG_SND_MTPAV is not set
+# CONFIG_SND_SERIAL_U16550 is not set
+CONFIG_SND_MPU401=m
+
+#
+# ISA devices
+#
+CONFIG_SND_CS4231_LIB=m
+# CONFIG_SND_AD1816A is not set
+# CONFIG_SND_AD1848 is not set
+# CONFIG_SND_CS4231 is not set
+# CONFIG_SND_CS4232 is not set
+# CONFIG_SND_CS4236 is not set
+# CONFIG_SND_ES968 is not set
+# CONFIG_SND_ES1688 is not set
+# CONFIG_SND_ES18XX is not set
+# CONFIG_SND_GUSCLASSIC is not set
+# CONFIG_SND_GUSEXTREME is not set
+# CONFIG_SND_GUSMAX is not set
+# CONFIG_SND_INTERWAVE is not set
+# CONFIG_SND_INTERWAVE_STB is not set
+# CONFIG_SND_OPTI92X_AD1848 is not set
+# CONFIG_SND_OPTI92X_CS4231 is not set
+# CONFIG_SND_OPTI93X is not set
+# CONFIG_SND_SB8 is not set
+# CONFIG_SND_SB16 is not set
+# CONFIG_SND_SBAWE is not set
+# CONFIG_SND_WAVEFRONT is not set
+# CONFIG_SND_ALS100 is not set
+# CONFIG_SND_AZT2320 is not set
+# CONFIG_SND_CMI8330 is not set
+# CONFIG_SND_DT019X is not set
+CONFIG_SND_OPL3SA2=m
+# CONFIG_SND_SGALAXY is not set
+# CONFIG_SND_SSCAPE is not set
+CONFIG_SND_AC97_CODEC=m
+CONFIG_SND_AC97_BUS=m
+
+#
+# PCI devices
+#
+# CONFIG_SND_ALI5451 is not set
+CONFIG_SND_ATIIXP=m
+# CONFIG_SND_ATIIXP_MODEM is not set
+CONFIG_SND_AU8810=m
+CONFIG_SND_AU8820=m
+CONFIG_SND_AU8830=m
+# CONFIG_SND_AZT3328 is not set
+CONFIG_SND_BT87X=m
+# CONFIG_SND_BT87X_OVERCLOCK is not set
+CONFIG_SND_CS46XX=m
+CONFIG_SND_CS46XX_NEW_DSP=y
+CONFIG_SND_CS4281=m
+# CONFIG_SND_EMU10K1 is not set
+# CONFIG_SND_EMU10K1X is not set
+# CONFIG_SND_CA0106 is not set
+# CONFIG_SND_KORG1212 is not set
+CONFIG_SND_MIXART=m
+# CONFIG_SND_NM256 is not set
+# CONFIG_SND_RME32 is not set
+# CONFIG_SND_RME96 is not set
+# CONFIG_SND_RME9652 is not set
+# CONFIG_SND_HDSP is not set
+# CONFIG_SND_HDSPM is not set
+# CONFIG_SND_TRIDENT is not set
+# CONFIG_SND_YMFPCI is not set
+# CONFIG_SND_AD1889 is not set
+# CONFIG_SND_ALS4000 is not set
+# CONFIG_SND_CMIPCI is not set
+CONFIG_SND_ENS1370=m
+CONFIG_SND_ENS1371=m
+CONFIG_SND_ES1938=m
+CONFIG_SND_ES1968=m
+# CONFIG_SND_MAESTRO3 is not set
+# CONFIG_SND_FM801 is not set
+# CONFIG_SND_ICE1712 is not set
+# CONFIG_SND_ICE1724 is not set
+CONFIG_SND_INTEL8X0=m
+CONFIG_SND_INTEL8X0M=m
+CONFIG_SND_SONICVIBES=m
+# CONFIG_SND_VIA82XX is not set
+# CONFIG_SND_VIA82XX_MODEM is not set
+# CONFIG_SND_VX222 is not set
+CONFIG_SND_HDA_INTEL=m
+
+#
+# USB devices
+#
+# CONFIG_SND_USB_AUDIO is not set
+# CONFIG_SND_USB_USX2Y is not set
+
+#
+# PCMCIA devices
+#
+# CONFIG_SND_VXPOCKET is not set
+# CONFIG_SND_PDAUDIOCF is not set
+
+#
+# Open Sound System
+#
+CONFIG_SOUND_PRIME=m
+CONFIG_SOUND_BT878=m
+# CONFIG_SOUND_CMPCI is not set
+# CONFIG_SOUND_EMU10K1 is not set
+# CONFIG_SOUND_FUSION is not set
+# CONFIG_SOUND_CS4281 is not set
+# CONFIG_SOUND_ES1370 is not set
+# CONFIG_SOUND_ES1371 is not set
+# CONFIG_SOUND_ESSSOLO1 is not set
+# CONFIG_SOUND_MAESTRO is not set
+# CONFIG_SOUND_MAESTRO3 is not set
+CONFIG_SOUND_ICH=m
+# CONFIG_SOUND_SONICVIBES is not set
+# CONFIG_SOUND_TRIDENT is not set
+# CONFIG_SOUND_MSNDCLAS is not set
+# CONFIG_SOUND_MSNDPIN is not set
+# CONFIG_SOUND_VIA82CXXX is not set
+# CONFIG_SOUND_OSS is not set
+CONFIG_SOUND_TVMIXER=m
+# CONFIG_SOUND_ALI5455 is not set
+# CONFIG_SOUND_FORTE is not set
+# CONFIG_SOUND_RME96XX is not set
+# CONFIG_SOUND_AD1980 is not set
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_BANDWIDTH is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+CONFIG_USB_SUSPEND=y
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_SPLIT_ISO is not set
+# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_OHCI_HCD is not set
+CONFIG_USB_UHCI_HCD=y
+# CONFIG_USB_SL811_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
+
+#
+# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
+#
+CONFIG_USB_ACM=m
+CONFIG_USB_PRINTER=m
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be
needed; see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=m
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+CONFIG_USB_STORAGE_FREECOM=y
+CONFIG_USB_STORAGE_ISD200=y
+CONFIG_USB_STORAGE_DPCM=y
+CONFIG_USB_STORAGE_USBAT=y
+CONFIG_USB_STORAGE_SDDR09=y
+CONFIG_USB_STORAGE_SDDR55=y
+CONFIG_USB_STORAGE_JUMPSHOT=y
+# CONFIG_USB_STORAGE_ONETOUCH is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+CONFIG_USB_HIDINPUT=y
+# CONFIG_HID_FF is not set
+CONFIG_USB_HIDDEV=y
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_ACECAD is not set
+# CONFIG_USB_KBTAB is not set
+# CONFIG_USB_POWERMATE is not set
+# CONFIG_USB_MTOUCH is not set
+# CONFIG_USB_ITMTOUCH is not set
+# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_YEALINK is not set
+# CONFIG_USB_XPAD is not set
+CONFIG_USB_ATI_REMOTE=m
+# CONFIG_USB_KEYSPAN_REMOTE is not set
+# CONFIG_USB_APPLETOUCH is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+CONFIG_USB_MICROTEK=m
+
+#
+# USB Multimedia devices
+#
+# CONFIG_USB_DABUSB is not set
+# CONFIG_USB_VICAM is not set
+# CONFIG_USB_DSBR is not set
+# CONFIG_USB_IBMCAM is not set
+# CONFIG_USB_KONICAWC is not set
+# CONFIG_USB_OV511 is not set
+# CONFIG_USB_SE401 is not set
+# CONFIG_USB_SN9C102 is not set
+# CONFIG_USB_STV680 is not set
+# CONFIG_USB_PWC is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+CONFIG_USB_KAWETH=y
+CONFIG_USB_PEGASUS=y
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_USB_ZD1201 is not set
+CONFIG_USB_MON=y
+
+#
+# USB port drivers
+#
+
+#
+# USB Serial Converter support
+#
+CONFIG_USB_SERIAL=m
+CONFIG_USB_SERIAL_GENERIC=y
+# CONFIG_USB_SERIAL_AIRPRIME is not set
+CONFIG_USB_SERIAL_BELKIN=m
+CONFIG_USB_SERIAL_WHITEHEAT=m
+# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
+# CONFIG_USB_SERIAL_CP2101 is not set
+# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
+# CONFIG_USB_SERIAL_EMPEG is not set
+CONFIG_USB_SERIAL_FTDI_SIO=m
+# CONFIG_USB_SERIAL_VISOR is not set
+# CONFIG_USB_SERIAL_IPAQ is not set
+# CONFIG_USB_SERIAL_IR is not set
+# CONFIG_USB_SERIAL_EDGEPORT is not set
+# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
+# CONFIG_USB_SERIAL_GARMIN is not set
+# CONFIG_USB_SERIAL_IPW is not set
+# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
+# CONFIG_USB_SERIAL_KEYSPAN is not set
+# CONFIG_USB_SERIAL_KLSI is not set
+# CONFIG_USB_SERIAL_KOBIL_SCT is not set
+CONFIG_USB_SERIAL_MCT_U232=m
+# CONFIG_USB_SERIAL_PL2303 is not set
+# CONFIG_USB_SERIAL_HP4X is not set
+# CONFIG_USB_SERIAL_SAFE is not set
+# CONFIG_USB_SERIAL_TI is not set
+# CONFIG_USB_SERIAL_CYBERJACK is not set
+# CONFIG_USB_SERIAL_XIRCOM is not set
+# CONFIG_USB_SERIAL_OMNINET is not set
+CONFIG_USB_EZUSB=y
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_AUERSWALD is not set
+CONFIG_USB_RIO500=m
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+CONFIG_USB_LED=m
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGETKIT is not set
+# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TEST is not set
+
+#
+# USB DSL modem support
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# SN Devices
+#
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=m
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=m
+CONFIG_EXT3_FS_XATTR=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT3_FS_SECURITY=y
+CONFIG_JBD=m
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=m
+CONFIG_REISERFS_FS=y
+# CONFIG_REISERFS_CHECK is not set
+# CONFIG_REISERFS_PROC_INFO is not set
+CONFIG_REISERFS_FS_XATTR=y
+CONFIG_REISERFS_FS_POSIX_ACL=y
+CONFIG_REISERFS_FS_SECURITY=y
+# CONFIG_JFS_FS is not set
+CONFIG_FS_POSIX_ACL=y
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+CONFIG_ROMFS_FS=y
+CONFIG_INOTIFY=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+CONFIG_AUTOFS_FS=m
+CONFIG_AUTOFS4_FS=y
+CONFIG_FUSE_FS=y
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_ZISOFS_FS=m
+CONFIG_UDF_FS=m
+CONFIG_UDF_NLS=y
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+CONFIG_NTFS_FS=m
+# CONFIG_NTFS_DEBUG is not set
+CONFIG_NTFS_RW=y
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_HUGETLBFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+CONFIG_RELAYFS_FS=m
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_ASFS_FS is not set
+CONFIG_HFS_FS=m
+CONFIG_HFSPLUS_FS=m
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_CRAMFS=y
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+# CONFIG_NFS_FS is not set
+# CONFIG_NFSD is not set
+CONFIG_SMB_FS=m
+# CONFIG_SMB_NLS_DEFAULT is not set
+CONFIG_CIFS=m
+CONFIG_CIFS_STATS=y
+CONFIG_CIFS_XATTR=y
+CONFIG_CIFS_POSIX=y
+CONFIG_CIFS_EXPERIMENTAL=y
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+CONFIG_MAC_PARTITION=y
+CONFIG_MSDOS_PARTITION=y
+CONFIG_BSD_DISKLABEL=y
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+CONFIG_LDM_PARTITION=y
+# CONFIG_LDM_DEBUG is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+
+#
+# Native Language Support
+#
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+CONFIG_NLS_UTF8=m
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_DEBUG_BUGVERBOSE=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_X86_FIND_SMP_CONFIG=y
+CONFIG_X86_MPPARSE=y
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+CONFIG_SECURITY=y
+# CONFIG_SECURITY_NETWORK is not set
+CONFIG_SECURITY_CAPABILITIES=y
+# CONFIG_SECURITY_ROOTPLUG is not set
+# CONFIG_SECURITY_SECLVL is not set
+# CONFIG_SECURITY_SELINUX is not set
+
+#
+# Cryptographic options
+#
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_NULL=y
+CONFIG_CRYPTO_MD4=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
+CONFIG_CRYPTO_WP512=m
+CONFIG_CRYPTO_TGR192=m
+CONFIG_CRYPTO_DES=y
+CONFIG_CRYPTO_BLOWFISH=y
+CONFIG_CRYPTO_TWOFISH=y
+CONFIG_CRYPTO_SERPENT=y
+CONFIG_CRYPTO_AES=m
+CONFIG_CRYPTO_AES_586=m
+CONFIG_CRYPTO_CAST5=y
+CONFIG_CRYPTO_CAST6=y
+CONFIG_CRYPTO_TEA=m
+CONFIG_CRYPTO_ARC4=m
+CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_ANUBIS=m
+CONFIG_CRYPTO_DEFLATE=y
+CONFIG_CRYPTO_MICHAEL_MIC=y
+CONFIG_CRYPTO_CRC32C=y
+CONFIG_CRYPTO_TEST=y
+
+#
+# Hardware crypto devices
+#
+# CONFIG_CRYPTO_DEV_PADLOCK is not set
+
+#
+# Library routines
+#
+CONFIG_CRC_CCITT=m
+CONFIG_CRC16=m
+CONFIG_CRC32=y
+CONFIG_LIBCRC32C=y
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_TEXTSEARCH=y
+CONFIG_TEXTSEARCH_KMP=m
+CONFIG_TEXTSEARCH_BM=m
+CONFIG_TEXTSEARCH_FSM=m
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_X86_BIOS_REBOOT=y
+CONFIG_PC=y
+
diff --git a/cross b/cross
new file mode 120000
index 0000000..d11f058
--- /dev/null
+++ b/cross
@@ -0,0 +1 @@
+pico/cross
\ No newline at end of file
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 84e68cd..ee2dfe5 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -414,6 +414,7 @@ config SGI_MBCS
          say Y or M here, otherwise say N.

 source "drivers/serial/Kconfig"
+#source "drivers/char/xilinx_uartlite/Kconfig"

 config UNIX98_PTYS
 	bool "Unix98 PTY support" if EMBEDDED
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 4aeae68..800f4c8 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -119,3 +119,20 @@ $(obj)/defkeymap.c $(obj)/qtronixmap.c:
 	rm $@.tmp

 endif
+# mod-subdirs     +=	xilinx_gpio xilinx_ts xilinx_uartlite xilinx_spi
+# subdir-$(CONFIG_XILINX_GPIO) += xilinx_gpio
+# subdir-$(CONFIG_XILINX_TS) += xilinx_ts
+# subdir-$(CONFIG_XILINX_UARTLITE) += xilinx_uartlite
+# subdir-$(CONFIG_XILINX_SPI) += xilinx_spi
+# obj-$(CONFIG_XILINX_GPIO) += xilinx_gpio/xilinx_gpio.o
+# obj-$(CONFIG_XILINX_TS) += xilinx_ts/xilinx_ts.o
+# obj-$(CONFIG_XILINX_UARTLITE) += xilinx_uartlite/xilinx_uartlite.o
generic_serial.o
+# obj-$(CONFIG_XILINX_SPI) += xilinx_spi/xilinx_spi.o
+# ifeq ($(CONFIG_VIRTEX_II_PRO),y)
+#   ifeq ($(CONFIG_VT),y)
+#     ifeq ($(CONFIG_PC_KEYBOARD),y)
+#       subdir-$(CONFIG_VT) += xilinx_keyb
+#       obj-$(CONFIG_VT) += xilinx_keyb/xilinx_keyb.o
+#     endif
+#   endif
+# endif
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 4cffd34..d559224 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -206,4 +206,6 @@ obj-$(CONFIG_ETRAX_ETHERNET) += cris/
 obj-$(CONFIG_NETCONSOLE) += netconsole.o

 obj-$(CONFIG_FS_ENET) += fs_enet/
-
+#mod-subdirs     +=	xilinx_enet
+#subdir-$(CONFIG_XILINX_ENET) += xilinx_enet
+#obj-$(CONFIG_XILINX_ENET) += xilinx_enet/xilinx_enet.o
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 812bae6..0a0ffc4 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -396,6 +396,63 @@ config SERIAL_MPSC_CONSOLE
 	help
 	  Say Y here if you want to support a serial console on a Marvell MPSC.

+config SERIAL_UARTLITE
+	bool "Xilinx UARTLITE serial port support"
+	depends on PPC32 && PICO_E12
+	select SERIAL_CORE
+	help
+	  Say Y here if you want to use the Xilinx UARTLITE serial controller.
+
+config SERIAL_UARTLITE_CONSOLE
+	bool "Support for console on Xilinx UARTLITE serial port"
+	depends on SERIAL_UARTLITE
+	select SERIAL_CORE_CONSOLE
+	help
+	  Say Y here if you want to support a serial console on a Xilinx UARTLITE.
+
+config SERIAL_UARTLITE_NR_UARTS
+	int "Maximum number of Xilinx UARTLITE serial ports"
+	depends on SERIAL_UARTLITE
+	default "1"
+	help
+	  Set this to the number of serial ports you want the driver
+	  to support.
+
+config SERIAL_UARTLITE_DEBUG
+	bool "Xilinx UARTLITE serial port debugging support"
+	depends on PPC32 && PICO_E12 && !SERIAL_UARTLITE
+	help
+	  Say Y here if you want to use the Xilinx UARTLITE as a debugging port.
+
+config SERIAL_KEYHOLE
+
+	bool "Pico KEYHOLE Pseudo serial port support"
+	depends on PPC32 && PICO_E12
+	select SERIAL_CORE
+	help
+	  Say Y here if you want to use the Pico KEYHOLE serial controller.
+
+config SERIAL_KEYHOLE_CONSOLE
+	bool "Support for console on Pico KEYHOLE serial port"
+	depends on SERIAL_KEYHOLE
+	select SERIAL_CORE_CONSOLE
+	help
+	  Say Y here if you want to support a serial console on a Pico KEYHOLE.
+
+config SERIAL_KEYHOLE_NR_UARTS
+	int "Maximum number of Pico KEYHOLE serial ports"
+	depends on SERIAL_KEYHOLE
+	default "1"
+	help
+	  Set this to the number of serial ports you want the driver
+	  to support.
+
+config SERIAL_KEYHOLE_DEBUG
+	bool "KEYHOLE debugging support"
+	depends on PPC32 && PICO_E12 && !SERIAL_KEYHOLE
+	help
+	  Say Y here if you want to use the Xilinx KEYHOLE as a debugging port.
+
 config SERIAL_PXA
 	bool "PXA serial port support"
 	depends on ARM && ARCH_PXA
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index d7c7c71..7a0af4f 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -11,12 +11,18 @@ serial-8250-$(CONFIG_GSC) += 8250_gsc.o
 serial-8250-$(CONFIG_PCI) += 8250_pci.o
 serial-8250-$(CONFIG_HP300) += 8250_hp300.o

+obj-$(CONFIG_SERIAL_UARTLITE) += printk.o
+obj-$(CONFIG_SERIAL_KEYHOLE) += printk.o
 obj-$(CONFIG_SERIAL_CORE) += serial_core.o
 obj-$(CONFIG_SERIAL_21285) += 21285.o
 obj-$(CONFIG_SERIAL_8250) += 8250.o $(serial-8250-y)
+obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o
+obj-$(CONFIG_SERIAL_KEYHOLE) += keyhole.o
 obj-$(CONFIG_SERIAL_8250_CS) += serial_cs.o
 obj-$(CONFIG_SERIAL_8250_ACORN) += 8250_acorn.o
 obj-$(CONFIG_SERIAL_8250_CONSOLE) += 8250_early.o
+#obj-$(CONFIG_SERIAL_UARTLITE_CONSOLE) += uartlite_early.o
+#obj-$(CONFIG_SERIAL_KEYHOLE_CONSOLE) += keyhole_early.o
 obj-$(CONFIG_SERIAL_8250_FOURPORT) += 8250_fourport.o
 obj-$(CONFIG_SERIAL_8250_ACCENT) += 8250_accent.o
 obj-$(CONFIG_SERIAL_8250_BOCA) += 8250_boca.o
diff --git a/drivers/serial/keyhole.c b/drivers/serial/keyhole.c
new file mode 100644
index 0000000..cd41e91
--- /dev/null
+++ b/drivers/serial/keyhole.c
@@ -0,0 +1,1489 @@
+/*
+ *  linux/drivers/serial/keyhole.c
+ *
+ *  Driver for keyhole ports
+ *
+ *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
+ *  Based on drivers/serial/8250.c.
+ *
+ *  Author: David H. Lynch Jr. <dhlii@dlasys.net>
+ *  Copyright (C) 2005 DLA Systems
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
 USA
+ *
+ *  $Id: keyhole.c,v 0.10 2005/12/14 10:03:27 dhlii Exp $
+ *
+ * A note about mapbase / membase
+ *
+ *  mapbase is the physical address of the IO port.  Currently, we don't
+ *  support this very well, and it may well be dropped from this driver
+ *  in future.  As such, mapbase should be NULL.
+ *
+ *  membase is an 'ioremapped' cookie.  This is compatible with the old
+ *  serial.c driver, and is currently the preferred form.
+ *
+ *  Todo:
+ *  	KEY_HOLE:
+ *  		UART_LSR_DR needs to be properly defined to receive data
+ *  		UART_IIR needs checked it is mapped to the status register
+ *  		UART_IIR_NO_INT is defined as 0, that should ALWAYS result in
checking for IO
+ *  		UART_LSR_TEMT   is defined as UART_LSR_THRE
+ *  	UART_LITE:
+ *  	BOTH:
+ *  		The following "bits" are defined as 0. This keeps the code nearly
identical to other serial drivers
+ *  		while effectively disabling the relevant features
+ *  		UART_LSR_BI
+ *  		UART_LCR_WLEN5
+ *  		UART_LCR_WLEN6
+ *  		UART_LCR_WLEN7
+ *  		UART_LCR_WLEN8
+ *  		UART_LCR_STOP
+ *  		UART_LCR_PARITY
+ *  		UART_LCR_EPAR
+ *  		UART_LSR_BI
+ *  		UART_IER_MSI	- neither has modem status
+ */
+#include <linux/config.h>
+
+#if defined(CONFIG_SERIAL_KEYHOLE_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/tty.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+#include <linux/serial_keyhole.h>
+#include <asm/io.h>
+#include <linux/sysrq.h>
+#include <asm/irq.h>
+/*
+#include <linux/ioport.h>
+#include <linux/serialP.h>
+#include <asm/serial.h>
+#include "keyhole.h"
+#include "keyhole_reg.h"
+*/
+
+
+#define IS_DBG 1
+#define IS_KH 1
+/*
+ * Debugging.
+ */
+#if 0
+#define DEBUG_AUTOCONF(fmt...)	printk(fmt)
+#else
+#define DEBUG_AUTOCONF(fmt...)	do { } while (0)
+#endif
+
+#if 0
+#define DEBUG_INTR(fmt...)	printk(fmt)
+#else
+#define DEBUG_INTR(fmt...)	do { } while (0)
+#endif
+
+#if IS_DBG
+#define DEBUG_PRINTK(fmt...)	_printk(fmt)
+#else
+#define DEBUG_PRINTK(fmt...)	do { } while (0)
+#endif
+
+static void dump_port(struct uart_port *p)
+{
+	DEBUG_PRINTK("keyhole: ");
+	DEBUG_PRINTK("p->line:%d ",p->line);
+	DEBUG_PRINTK("p->iotype:%d ",p->iotype);
+	DEBUG_PRINTK("p->iobase:%x ",p->iobase);
+	DEBUG_PRINTK("p->regshift:%x ",p->regshift);
+	DEBUG_PRINTK("p->flags:%x ",p->flags);
+	DEBUG_PRINTK("p->irq:%x ",p->irq);
+	DEBUG_PRINTK("p->mapbase:%lx ",(unsigned long) p->mapbase);
+	DEBUG_PRINTK("p->membase:%lx \n",(unsigned long) p->membase);
+}
+#define KEYHOLE_ISR_PASS_LIMIT	256
+#define PORT_KEYHOLE_BASE	PORT_KEYHOLE
+#define PORT_INDEX(x)	(x - PORT_KEYHOLE_BASE + 1)
+
+
+/*
+ * We default to IRQ0 for the "no irq" hack.   Some
+ * machine types want others as well - they're free
+ * to redefine this in their header file.
+ */
+#define is_real_interrupt(irq)	((irq) != 0)
+
+
+
+/*
+ * SERIAL_PORT_DFNS tells us about built-in ports that have no
+ * standard enumeration mechanism.   Platforms that can find all
+ * serial ports via mechanisms like ACPI or PCI need not supply it.
+ */
+#ifndef SERIAL_PORT_DFNS
+#define SERIAL_PORT_DFNS
+#endif
+
+static struct old_serial_port old_serial_port[] = {
+	SERIAL_PORT_DFNS /* defined in asm/serial.h */
+};
+
+#define UART_NR	CONFIG_SERIAL_KEYHOLE_NR_UARTS
+// #define UART_NR	ARRAY_SIZE(old_serial_port)
+
+struct keyhole_port {
+	struct uart_port	port;
+	struct timer_list	timer;		/* "no irq" timer */
+	struct list_head	list;		/* ports on this IRQ */
+	unsigned short		capabilities;	/* port capabilities */
+	unsigned int		tx_loadsz;	/* transmit fifo load size */
+	unsigned char		ier;
+	unsigned char		lcr;
+	unsigned char		mcr;
+	unsigned char		lsr_break_flag;
+	unsigned int		count;	
+
+	/*
+	 * We provide a per-port pm hook.
+	 */
+	void			(*pm)(struct uart_port *port,
+				      unsigned int state, unsigned int old);
+};
+
+struct irq_info {
+	spinlock_t		lock;
+	struct list_head	*head;
+};
+
+static struct irq_info irq_lists[NR_IRQS];
+
+/*
+ * Here we define the default xmit fifo size used for each type of UART.
+ */
+static const struct serial_keyhole_config uart_config[] = {
+	[PORT_UNKNOWN] = {
+		.name		= "unknown",
+		.fifo_size	= 1,
+		.tx_loadsz	= 1,
+		.flags		= 0,
+	},
+#if defined(IS_KH)
+	[PORT_INDEX(PORT_KEYHOLE)] = {
+		.name		= "keyhole",
+		.fifo_size	= 1,
+		.tx_loadsz	= 1,
+		.flags		= 0,
+	},
+#else
+	[PORT_INDEX(PORT_KEYHOLE)] = {
+		.name		= "keyhole",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.flags		= UART_CAP_FIFO,
+	},
+#endif
+};
+
+static _INLINE_ unsigned int serial_in(struct keyhole_port *up, int offset)
+{
+	unsigned int value;
+	offset <<= up->port.regshift;
+
+	switch (up->port.iotype) {
+	default:
+		value = (*(volatile unsigned int *) ( up->port.membase + offset));
+		__asm__ __volatile__("eieio");
+		return value;
+	}
+}
+
+static _INLINE_ void
+serial_out(struct keyhole_port *up, int offset, int value)
+{
+	offset <<= up->port.regshift;
+
+	switch (up->port.iotype) {
+	default:
+ 		(*(volatile unsigned int *)( up->port.membase + offset) =value);
+ 		__asm__ __volatile__("eieio");
+		break;
+
+	}
+}
+
+static struct keyhole_port keyhole_ports[UART_NR];
+
+/*
+ *	Wait for transmitter & holding register to empty
+ */
+static inline void
+keyhole_wait_for_xmitr_empty(struct keyhole_port *up)
+{
+	unsigned int status, tmout = 10000;
+
+	/* Wait up to 10ms for the character(s) to be sent. */
+	do {
+		status = serial_in(up, UART_LSR);
+
+		if (status & UART_LSR_BI)
+			up->lsr_break_flag = UART_LSR_BI;
+
+		if (--tmout == 0)
+			break;
+		udelay(1);
+	} while (status & UART_LSR_TXF);
+
+	/* Wait up to 1s for flow control if necessary */
+	if (up->port.flags & UPF_CONS_FLOW) {
+		tmout = 1000000;
+		while (--tmout)
+			udelay(1);
+	}
+}
+
+#if defined(IS_KH)
+
+//Output one 32bit value thru the keyhole.
+void
+keyhole_out(struct keyhole_port *up, unsigned long cmd, unsigned long kh)
+{
+#if 0
+	
+	keyhole_wait_for_xmitr_empty(up);
+	//careful about the order here. data must be sent last.
+	serial_out(up, UART_LCR,cmd);
+	serial_out(up, UART_TX,kh);    		//triggers fifo write
+	return;
+#else
+	unsigned int status;
+
+	for (;;) {
+		status = serial_in(up, UART_LSR);
+		if ((status & UART_LSR_TXF) == 0) {
+			//careful about the order here. data must be sent last.
+			serial_out(up, UART_LCR, cmd);
+			serial_out(up, UART_TX, kh);    //triggers fifo write
+			return;
+		}
+        	udelay(100); //wait if ppc2pc fifo is almost full.
+		// cpu_relax();
+	}
+#endif
+}
+void
+keyhole_putc(struct keyhole_port *up, unsigned char c)
+{
+  	KEYHOLE_DATA kh;
+
+	if (c == '\r') return;
+    	kh.u32 = 0; kh.packetType = KHC_FMTD; kh.countWords = 3;
+	keyhole_out(up,KH_BEGIN, kh.u32) ;
+	kh.u32 = 0;
+	kh.asci0 = c;
+        keyhole_out(up,KH_STR, kh.u32);
+	keyhole_out(up,KH_END, kh.u32);
+}
+
+
+unsigned char
+keyhole_getc(struct keyhole_port *up)
+{
+	return 0;
+}
+
+void
+keyhole_set_ier(struct keyhole_port *up, unsigned int mask)
+{
+}
+#else
+
+void
+keyhole_putc(struct keyhole_port *up, unsigned char c)
+{
+	serial_out(up, UART_TX, c);
+	if (c == '\r')
+		up->count = 0;
+	if (up->count >= 85)
+		keyhole_putc(up, '\r');
+}
+void
+keyhole_putchar(struct keyhole_port *up, unsigned char c)
+{
+	keyhole_wait_for_xmitr_empty(up);
+	keyhole_putc(up,c);
+}
+
+unsigned char
+keyhole_getc(struct keyhole_port *up)
+{
+		return serial_in(up, UART_RX);
+}
+
+void
+keyhole_set_ier(struct keyhole_port *up, unsigned int ier)
+{
+	serial_out(up, UART_IER, ier);
+}
+
+#endif
+
+#if 0
+void
+dbg_putc(unsigned char c)
+{
+	//struct keyhole_port *up = &keyhole_ports[0];
+	struct keyhole_port *up = &old_serial_port[1];
+	return ;
+	if (up->port.membase)
+		keyhole_putchar(up,c);
+}
+#endif
+static void serial_reset( struct keyhole_port *up)
+{
+	(void) serial_in(up, UART_LSR);
+#if !defined(IS_KH)
+	(void) serial_in(up, UART_RX);
+#endif
+}
+
+static void serial_init( struct keyhole_port *up)
+{
+
+	up->capabilities = uart_config[up->port.type].flags;
+	up->mcr = 0;
+	up->ier = 0;
+
+
+#if !defined(IS_KH)
+	/*
+	 * Clear the FIFO buffers and disable them.
+	 * (they will be reeanbled in set_termios())
+	 */
+	up->ier &= ~(UART_LCR_RXF | UART_LCR_TXF);
+	keyhole_set_ier(up, up->ier);
+
+	/*
+	 * Clear the interrupt registers.
+	 */
+	(void) serial_in(up, UART_LSR);
+	(void) serial_in(up, UART_RX);
+	if (up->capabilities & UART_CAP_FIFO) {
+		// there is no FIFO enable/diosable for the Uart Lite
+	}
+#endif
+}
+/*
+	Stop transmitting characters.  This might be due to the CTS
+	line becoming inactive or the tty layer indicating we want
+	to stop transmission due to an XOFF character.
+
+	Locking: up->lock taken.
+	Interrupts: locally disabled.
+	This call must not sleep
+*/
+static void keyhole_stop_tx(struct uart_port *port)
+{
+	struct keyhole_port *up = (struct keyhole_port *)port;
+
+	DEBUG_PRINTK("keyhole_stop_tx()\n");
+// the key_hole port has no IER port, but it might and it seems useful
to fake it
+	if (up->ier & UART_IER_THRI) {
+		up->ier &= ~UART_IER_THRI;
+		keyhole_set_ier(up, up->ier);
+	}
+}
+/*
+	start transmitting characters.
+
+	Locking: up->lock taken.
+	Interrupts: locally disabled.
+	This call must not sleep
+*/
+
+static void keyhole_start_tx(struct uart_port *port)
+{
+	struct keyhole_port *up = (struct keyhole_port *)port;
+	struct circ_buf *xmit = &up->port.info->xmit;
+	DEBUG_PRINTK("keyhole_start_tx()\n");
+	if (!(up->ier & UART_IER_THRI)) {				// are TX interupts enabled ?
+		DEBUG_PRINTK("keyhole_start_tx(01)\n");
+		up->ier |= UART_IER_THRI;				// enable them
+		keyhole_set_ier(up, up->ier);
+
+		keyhole_putc(up, xmit->buf[xmit->tail]);		// send 1 character to kick
things
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		up->port.icount.tx++;
+	}
+	//while((serial_in(up, UART_LSR) & UART_EMPTY) != UART_EMPTY);
+}
+
+static void keyhole_stop_rx(struct uart_port *port)
+{
+	struct keyhole_port *up = (struct keyhole_port *)port;
+
+	DEBUG_PRINTK("keyhole_stop_rx()\n");
+	up->ier &= ~UART_IER_RLSI;					// disable receive interrupts
+	up->port.read_status_mask &= ~UART_LSR_DR;
+	keyhole_set_ier(up, up->ier);
+}
+/*
+	Enable the modem status interrupts.
+
+	Locking: up->lock taken.
+	Interrupts: locally disabled.
+	This call must not sleep
+*/
+static void keyhole_enable_ms(struct uart_port *port)
+{
+	DEBUG_PRINTK("keyhole_enable_ms()\n");
+#if 0
+	struct keyhole_port *up = (struct keyhole_port *)port;
+
+	up->ier |= UART_IER_MSI;					// enable modem status interupts
+	keyhole_set_ier(up, up->ier);
+#endif
+}
+
+static _INLINE_ void
+receive_chars(struct keyhole_port *up, int *status, struct pt_regs *regs)
+{
+	struct tty_struct *tty = up->port.info->tty;
+	unsigned char ch, lsr = *status;
+	int max_count = 256;
+	char flag;
+
+	DEBUG_PRINTK("<");
+	do {
+		/* The following is not allowed by the tty layer and
+		   unsafe. It should be fixed ASAP */
+		if (unlikely(tty->flip.count >= TTY_FLIPBUF_SIZE)) {
+			if (tty->low_latency) {
+				spin_unlock(&up->port.lock);
+				tty_flip_buffer_push(tty);
+				spin_lock(&up->port.lock);
+			}
+			/*
+			 * If this failed then we will throw away the
+			 * bytes but must do so to clear interrupts
+			 */
+		}
+		ch = keyhole_getc(up);
+		flag = TTY_NORMAL;
+		up->port.icount.rx++;
+
+#ifdef CONFIG_SERIAL_KEYHOLE_CONSOLE
+		/*
+		 * Recover the break flag from console xmit
+		 */
+		if (up->port.line == up->port.cons->index) {
+			lsr |= up->lsr_break_flag;
+			up->lsr_break_flag = 0;
+		}
+#endif
+
+		if (unlikely(lsr & (UART_LSR_BI | UART_LSR_PE |
+				    UART_LSR_FE | UART_LSR_OE))) {
+			/*
+			 * For statistics only
+			 */
+			if (lsr & UART_LSR_BI) {
+				lsr &= ~(UART_LSR_FE | UART_LSR_PE);
+				up->port.icount.brk++;
+				/*
+				 * We do the SysRQ and SAK checking
+				 * here because otherwise the break
+				 * may get masked by ignore_status_mask
+				 * or read_status_mask.
+				 */
+				if (uart_handle_break(&up->port))
+					goto ignore_char;
+			} else if (lsr & UART_LSR_PE)
+				up->port.icount.parity++;
+			else if (lsr & UART_LSR_FE)
+				up->port.icount.frame++;
+			if (lsr & UART_LSR_OE)
+				up->port.icount.overrun++;
+
+			/*
+			 * Mask off conditions which should be ignored.
+			 */
+			lsr &= up->port.read_status_mask;
+
+			if (lsr & UART_LSR_BI) {
+				DEBUG_INTR("handling break....");
+				flag = TTY_BREAK;
+			} else if (lsr & UART_LSR_PE)
+				flag = TTY_PARITY;
+			else if (lsr & UART_LSR_FE)
+				flag = TTY_FRAME;
+		}
+		if (uart_handle_sysrq_char(&up->port, ch, regs))
+			goto ignore_char;
+
+		uart_insert_char(&up->port, lsr, UART_LSR_OE, ch, flag);
+
+	ignore_char:
+		lsr = serial_in(up, UART_LSR);
+	} while ((lsr & UART_LSR_DR) && (max_count-- > 0));
+	spin_unlock(&up->port.lock);
+	tty_flip_buffer_push(tty);
+	spin_lock(&up->port.lock);
+	*status = lsr;
+}
+
+static _INLINE_ void transmit_chars(struct keyhole_port *up)
+{
+	struct circ_buf *xmit = &up->port.info->xmit;
+	int count;
+	DEBUG_PRINTK("transmit_chars()  %c",up->port.x_char);
+
+	DEBUG_PRINTK("<%c", up->port.x_char);
+	if (up->port.x_char) {
+		DEBUG_PRINTK("+");
+		keyhole_putc(up, up->port.x_char);
+		up->port.icount.tx++;
+		up->port.x_char = 0;
+		return;
+	}
+	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
+		DEBUG_PRINTK("$");
+		keyhole_stop_tx(&up->port);
+		return;
+	}
+
+	count = up->tx_loadsz;
+	do {
+		DEBUG_PRINTK("(%c)",xmit->buf[xmit->tail]);
+		DEBUG_PRINTK("&");
+		keyhole_putc(up, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		up->port.icount.tx++;
+		if (uart_circ_empty(xmit))
+			break;
+		// while (!serial_in(up, UART_LSR) & UART_LSR_THRE);
+
+	} while (--count > 0);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&up->port);
+
+	DEBUG_INTR("THRE...");
+
+	if (uart_circ_empty(xmit))
+		keyhole_stop_tx(&up->port);
+#if defined(IS_DBG) && 0
+	DEBUG_PRINTK("\n");
+#endif
+	DEBUG_PRINTK(">");
+}
+
+/*
+ * This handles the interrupt from one port.
+ */
+static inline void
+keyhole_handle_port(struct keyhole_port *up, struct pt_regs *regs)
+{
+	unsigned int status = serial_in(up, UART_LSR);
+
+	DEBUG_INTR("status = %x...", status);
+
+	DEBUG_PRINTK("!");
+	DEBUG_PRINTK("status %02x\n", status);
+	if (status & UART_LSR_DR)
+		receive_chars(up, &status, regs);
+	// if (status & UART_LSR_THRE)
+	if (!(status & UART_LSR_TXF))
+		transmit_chars(up);
+}
+
+/*
+ * This is the serial driver's interrupt routine.
+ *
+ * Arjan thinks the old way was overly complex, so it got simplified.
+ * Alan disagrees, saying that need the complexity to handle the weird
+ * nature of ISA shared interrupts.  (This is a special exception.)
+ *
+ * In order to handle ISA shared interrupts properly, we need to check
+ * that all ports have been serviced, and therefore the ISA interrupt
+ * line has been de-asserted.
+ *
+ * This means we need to loop through all ports. checking that they
+ * don't have an interrupt pending.
+ */
+static irqreturn_t keyhole_interrupt(int irq, void *dev_id,
+	struct pt_regs *regs)
+{
+	struct irq_info *i = dev_id;
+	struct list_head *l, *end = NULL;
+	int pass_counter = 0, handled = 0;
+
+	DEBUG_INTR("keyhole_interrupt(%d)...", irq);
+
+	spin_lock(&i->lock);
+
+	l = i->head;
+	do {
+		struct keyhole_port *up;
+		unsigned int iir;
+
+		up = list_entry(l, struct keyhole_port, list);
+
+		iir = serial_in(up, UART_IIR);
+		if (!(iir & UART_IIR_NO_INT)) {
+			spin_lock(&up->port.lock);
+			keyhole_handle_port(up, regs);
+			spin_unlock(&up->port.lock);
+
+			handled = 1;
+
+			end = NULL;
+		} else if (end == NULL)
+			end = l;
+
+		l = l->next;
+
+		if (l == i->head && pass_counter++ > KEYHOLE_ISR_PASS_LIMIT) {
+			/* If we hit this, we're dead. */
+			printk(KERN_ERR "keyhole: too much work for "
+				"irq%d\n", irq);
+			break;
+		}
+	} while (l != end);
+
+	spin_unlock(&i->lock);
+
+	DEBUG_INTR("end.\n");
+
+	return IRQ_RETVAL(handled);
+}
+
+/*
+ * To support ISA shared interrupts, we need to have one interrupt
+ * handler that ensures that the IRQ line has been deasserted
+ * before returning.  Failing to do this will result in the IRQ
+ * line being stuck active, and, since ISA irqs are edge triggered,
+ * no more IRQs will be seen.
+ */
+static void serial_do_unlink(struct irq_info *i, struct keyhole_port *up)
+{
+	spin_lock_irq(&i->lock);
+
+	if (!list_empty(i->head)) {
+		if (i->head == &up->list)
+			i->head = i->head->next;
+		list_del(&up->list);
+	} else {
+		BUG_ON(i->head != &up->list);
+		i->head = NULL;
+	}
+
+	spin_unlock_irq(&i->lock);
+}
+
+static int serial_link_irq_chain(struct keyhole_port *up)
+{
+	struct irq_info *i = irq_lists + up->port.irq;
+	int ret, irq_flags = up->port.flags & UPF_SHARE_IRQ ? SA_SHIRQ : 0;
+
+	spin_lock_irq(&i->lock);
+
+	if (i->head) {
+		list_add(&up->list, i->head);
+		spin_unlock_irq(&i->lock);
+
+		ret = 0;
+	} else {
+		INIT_LIST_HEAD(&up->list);
+		i->head = &up->list;
+		spin_unlock_irq(&i->lock);
+
+		ret = request_irq(up->port.irq, keyhole_interrupt,
+				  irq_flags, "serial", i);
+		if (ret < 0)
+			serial_do_unlink(i, up);
+	}
+
+	return ret;
+}
+
+static void serial_unlink_irq_chain(struct keyhole_port *up)
+{
+	struct irq_info *i = irq_lists + up->port.irq;
+
+	BUG_ON(i->head == NULL);
+
+	if (list_empty(i->head))
+		free_irq(up->port.irq, i);
+
+	serial_do_unlink(i, up);
+}
+
+/*
+ * This function is used to handle ports that do not have an interrupt.
+ */
+static void keyhole_timeout(unsigned long data)
+{
+	struct keyhole_port *up = (struct keyhole_port *)data;
+	unsigned int timeout;
+	unsigned int iir;
+
+	DEBUG_PRINTK("@");
+	iir = serial_in(up, UART_IIR);
+	if (!(iir & UART_IIR_NO_INT)) {
+		spin_lock(&up->port.lock);
+		keyhole_handle_port(up, NULL);
+		spin_unlock(&up->port.lock);
+	}
+
+	timeout = up->port.timeout;
+	timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
+	mod_timer(&up->timer, jiffies + timeout);
+}
+/*
+	This function tests whether the transmitter fifo and shifter
+	for the port described by 'port' is empty.  If it is empty,
+	this function should return TIOCSER_TEMT, otherwise return 0.
+	If the port does not support this operation, then it should
+	return TIOCSER_TEMT.
+
+	Locking: none.
+	Interrupts: caller dependent.
+	This call must not sleep
+*/
+static unsigned int keyhole_tx_empty(struct uart_port *port)
+{
+	struct keyhole_port *up = (struct keyhole_port *)port;
+	unsigned long flags;
+	unsigned int ret;
+
+	DEBUG_PRINTK("keyhole_tx_empty()\n");
+	spin_lock_irqsave(&up->port.lock, flags);
+	ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
+	spin_unlock_irqrestore(&up->port.lock, flags);
+	return ret;
+}
+/*
+	Returns the current state of modem control inputs.  The state
+	of the outputs should not be returned, since the core keeps
+	track of their state.  The state information should include:
+		- TIOCM_DCD	state of DCD signal
+		- TIOCM_CTS	state of CTS signal
+		- TIOCM_DSR	state of DSR signal
+		- TIOCM_RI	state of RI signal
+	The bit is set if the signal is currently driven active.  If
+	the port does not support CTS, DCD or DSR, the driver should
+	indicate that the signal is permanently active.  If RI is
+	not available, the signal should not be indicated as active.
+
+	Locking: up->lock taken.
+	Interrupts: locally disabled.
+	This call must not sleep
+*/
+static unsigned int keyhole_get_mctrl(struct uart_port *port)
+{
+	DEBUG_PRINTK("keyhole_get_mctrl()\n");
+	return 0;
+}
+/*
+	This function sets the modem control lines for port described
+	by 'port' to the state described by mctrl.  The relevant bits
+	of mctrl are:
+		- TIOCM_RTS	RTS signal.
+		- TIOCM_DTR	DTR signal.
+		- TIOCM_OUT1	OUT1 signal.
+		- TIOCM_OUT2	OUT2 signal.
+	If the appropriate bit is set, the signal should be driven
+	active.  If the bit is clear, the signal should be driven
+	inactive.
+
+	Locking: up->lock taken.
+	Interrupts: locally disabled.
+	This call must not sleep
+*/
+static void keyhole_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	DEBUG_PRINTK("keyhole_set_mctrl()\n");
+}
+/*
+	Control the transmission of a break signal.  If ctl is
+	nonzero, the break signal should be transmitted.  The signal
+	should be terminated when another call is made with a zero
+	ctl.
+
+	Locking: none.
+	Interrupts: caller dependent.
+	This call must not sleep
+*/
+static void keyhole_break_ctl(struct uart_port *port, int break_state)
+{
+	DEBUG_PRINTK("keyhole_break_ctl()\n");
+}
+/*
+	Grab any interrupt resources and initialise any low level driver
+	state.  Enable the port for reception.  It should not activate
+	RTS nor DTR; this will be done via a separate call to set_mctrl.
+
+	Locking: port_sem taken.
+	Interrupts: globally disabled.
+*/
+static int keyhole_startup(struct uart_port *port)
+{
+	struct keyhole_port *up = (struct keyhole_port *)port;
+	int retval;
+
+	DEBUG_PRINTK("keyhole_startup()\n");
+	// serial_init(up);
+
+	/*
+	 * If the "interrupt" for this port doesn't correspond with any
+	 * hardware interrupt, we use a timer-based system.  The original
+	 * driver used to do this with IRQ0.
+	 */
+	if (!is_real_interrupt(up->port.irq)) {
+		unsigned int timeout = up->port.timeout;
+
+		timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
+
+		up->timer.data = (unsigned long)up;
+		mod_timer(&up->timer, jiffies + timeout);
+	} else {
+		retval = serial_link_irq_chain(up);
+		if (retval)
+			return retval;
+	}
+
+	/*
+	 * Finally, enable interrupts.  Note: Modem status interrupts
+	 * are set via set_termios(), which will be occurring imminently
+	 * anyway, so we don't enable them here.
+	 */
+	up->ier = UART_IER_RLSI | UART_IER_RDI;
+	keyhole_set_ier(up, up->ier);
+
+	/*
+	 * And clear the interrupt registers again for luck.
+	 */
+	serial_reset(up);
+	return 0;
+}
+/*
+	Disable the port, disable any break condition that may be in
+	effect, and free any interrupt resources.  It should not disable
+	RTS nor DTR; this will have already been done via a separate
+	call to set_mctrl.
+
+	Locking: port_sem taken.
+	Interrupts: caller dependent.
+*/
+static void keyhole_shutdown(struct uart_port *port)
+{
+	struct keyhole_port *up = (struct keyhole_port *)port;
+
+	DEBUG_PRINTK("keyhole_shutdown()\n");
+	/*
+	 * Disable interrupts from this port
+	 */
+	up->ier = 0;
+	keyhole_set_ier(up, up->ier);
+
+	/*
+	 * Disable break condition and FIFOs
+	 */
+
+	serial_init(up);
+
+	if (!is_real_interrupt(up->port.irq))
+		del_timer_sync(&up->timer);
+	else
+		serial_unlink_irq_chain(up);
+}
+/*
+	Change the port parameters, including word length, parity, stop
+	bits.  Update read_status_mask and ignore_status_mask to indicate
+	the types of events we are interested in receiving.  Relevant
+	termios->c_cflag bits are:
+		CSIZE	- word size
+		CSTOPB	- 2 stop bits
+		PARENB	- parity enable
+		PARODD	- odd parity (when PARENB is in force)
+		CREAD	- enable reception of characters (if not set,
+			  still receive characters from the port, but
+			  throw them away.
+		CRTSCTS	- if set, enable CTS status change reporting
+		CLOCAL	- if not set, enable modem status change
+			  reporting.
+	Relevant termios->c_iflag bits are:
+		INPCK	- enable frame and parity error events to be
+			  passed to the TTY layer.
+		BRKINT
+		PARMRK	- both of these enable break events to be
+			  passed to the TTY layer.
+
+		IGNPAR	- ignore parity and framing errors
+		IGNBRK	- ignore break errors,  If IGNPAR is also
+			  set, ignore overrun errors as well.
+	The interaction of the iflag bits is as follows (parity error
+	given as an example):
+	Parity error	INPCK	IGNPAR
+	None		n/a	n/a	character received
+	Yes		n/a	0	character discarded
+	Yes		0	1	character received, marked as
+					TTY_NORMAL
+	Yes		1	1	character received, marked as
+					TTY_PARITY
+
+	Other flags may be used (eg, xon/xoff characters) if your
+	hardware supports hardware "soft" flow control.
+
+	Locking: none.
+	Interrupts: caller dependent.
+	This call must not sleep
+*/
+static void
+keyhole_set_termios(struct uart_port *port, struct termios *termios,
+		       struct termios *old)
+{
+	struct keyhole_port *up = (struct keyhole_port *)port;
+	unsigned char cval ;
+	unsigned long flags;
+
+	DEBUG_PRINTK("keyhole_set_termios()\n");
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		cval = UART_LCR_WLEN5;
+		break;
+	case CS6:
+		cval = UART_LCR_WLEN6;
+		break;
+	case CS7:
+		cval = UART_LCR_WLEN7;
+		break;
+	default:
+	case CS8:
+		cval = UART_LCR_WLEN8;
+		break;
+	}
+
+	if (termios->c_cflag & CSTOPB)
+		cval |= UART_LCR_STOP;
+	if (termios->c_cflag & PARENB)
+		cval |= UART_LCR_PARITY;
+	if (!(termios->c_cflag & PARODD))
+		cval |= UART_LCR_EPAR;
+#ifdef CMSPAR
+	if (termios->c_cflag & CMSPAR)
+		cval |= UART_LCR_SPAR;
+#endif
+
+	/*
+	 * Ok, we're now changing the port state.  Do it with
+	 * interrupts disabled.
+	 */
+	spin_lock_irqsave(&up->port.lock, flags);
+
+	/*
+	 * Update the per-port timeout.
+	 */
+	// uart_update_timeout(uport, termios->c_cflag, 57600);
+
+	up->port.read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
+	if (termios->c_iflag & INPCK)
+		up->port.read_status_mask |= UART_LSR_FE | UART_LSR_PE;
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		up->port.read_status_mask |= UART_LSR_BI;
+
+	/*
+	 * Characteres to ignore
+	 */
+	up->port.ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		up->port.ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
+	if (termios->c_iflag & IGNBRK) {
+		up->port.ignore_status_mask |= UART_LSR_BI;
+		/*
+		 * If we're ignoring parity and break indicators,
+		 * ignore overruns too (for real raw support).
+		 */
+		if (termios->c_iflag & IGNPAR)
+			up->port.ignore_status_mask |= UART_LSR_OE;
+	}
+
+	/*
+	 * ignore all characters if CREAD is not set
+	 */
+	if ((termios->c_cflag & CREAD) == 0)
+		up->port.ignore_status_mask |= UART_LSR_DR;
+
+	/*
+	 * CTS flow control flag and modem status interrupts
+	 */
+	up->ier &= ~UART_IER_MSI;
+	if (UART_ENABLE_MS(&up->port, termios->c_cflag))
+		up->ier |= UART_IER_MSI;
+
+	keyhole_set_ier(up, up->ier);
+
+	keyhole_set_mctrl(&up->port, up->port.mctrl);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+/*
+	Perform any power management related activities on the specified
+	port.  State indicates the new state (defined by ACPI D0-D3),
+	oldstate indicates the previous state.  Essentially, D0 means
+	fully on, D3 means powered down.
+
+	This function should not be used to grab any resources.
+
+	This will be called when the port is initially opened and finally
+	closed, except when the port is also the system console.  This
+	will occur even if CONFIG_PM is not set.
+
+	Locking: none.
+	Interrupts: caller dependent.
+*/
+static void
+keyhole_pm(struct uart_port *port, unsigned int state,
+	      unsigned int oldstate)
+{
+	struct keyhole_port *up = (struct keyhole_port *)port;
+
+	DEBUG_PRINTK("keyhole_pm()\n");
+	// 8250
+	// keyhole_set_sleep(p, state != 0);
+
+	if (up->pm)
+		up->pm(port, state, oldstate);
+}
+
+/*
+ * Resource handling.
+ */
+static int
+keyhole_request_std_resource(struct keyhole_port *up)
+{
+	unsigned int size = 8 << up->port.regshift;
+	int ret = 0;
+
+	switch (up->port.iotype) {
+	case UPIO_MEM:
+		if (!up->port.mapbase)
+			break;
+
+		if (!request_mem_region(up->port.mapbase, size, "serial")) {
+			ret = -EBUSY;
+			break;
+		}
+
+		if (up->port.flags & UPF_IOREMAP) {
+			up->port.membase = ioremap(up->port.mapbase, size);
+			if (!up->port.membase) {
+				release_mem_region(up->port.mapbase, size);
+				ret = -ENOMEM;
+			}
+		}
+		break;
+
+	case UPIO_PORT:
+		if (!request_region(up->port.iobase, size, "serial"))
+			ret = -EBUSY;
+		break;
+	}
+	return ret;
+}
+/*
+	Release any memory and IO region resources currently in use by
+	the port.
+
+	Locking: none.
+	Interrupts: caller dependent.
+*/
+static void keyhole_release_port(struct uart_port *port)
+{
+	struct keyhole_port *up = (struct keyhole_port *)port;
+	unsigned int size = 8 << up->port.regshift;
+
+	DEBUG_PRINTK("keyhole_release_port()\n");
+	switch (up->port.iotype) {
+	case UPIO_MEM:
+		if (!up->port.mapbase)
+			break;
+
+		if (up->port.flags & UPF_IOREMAP) {
+			iounmap(up->port.membase);
+			up->port.membase = NULL;
+		}
+
+		release_mem_region(up->port.mapbase, size);
+		break;
+
+	case UPIO_PORT:
+		release_region(up->port.iobase, size);
+		break;
+	}
+}
+/*
+	Request any memory and IO region resources required by the port.
+	If any fail, no resources should be registered when this function
+	returns, and it should return -EBUSY on failure.
+
+	Locking: none.
+	Interrupts: caller dependent.
+*/
+static int keyhole_request_port(struct uart_port *port)
+{
+	struct keyhole_port *up = (struct keyhole_port *)port;
+	DEBUG_PRINTK("keyhole_request_port()\n");
+	return keyhole_request_std_resource(up);
+}
+/*
+	Perform any autoconfiguration steps required for the port.  `type`
+	contains a bit mask of the required configuration.  UART_CONFIG_TYPE
+	indicates that the port requires detection and identification.
+	up->type should be set to the type found, or PORT_UNKNOWN if
+	no port was detected.
+
+	UART_CONFIG_IRQ indicates autoconfiguration of the interrupt signal,
+	which should be probed using standard kernel autoprobing techniques.
+	This is not necessary on platforms where ports have interrupts
+	internally hard wired (eg, system on a chip implementations).
+
+	Locking: none.
+	Interrupts: caller dependent.
+*/
+static void keyhole_config_port(struct uart_port *port, int flags)
+{
+	struct keyhole_port *up = (struct keyhole_port *)port;
+
+	DEBUG_PRINTK("keyhole_config_port()\n");
+	spin_lock_irqsave(&up->port.lock, flags);
+
+	up->port.type = (PORT_KEYHOLE - PORT_KEYHOLE_BASE + 1);
+	up->port.fifosize = uart_config[up->port.type].fifo_size;
+
+	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	/* 8250
+	 * Find the region that we can probe for.  This in turn
+	 * tells us whether we can probe for the type of port.
+	 */
+	keyhole_request_std_resource(up);
+}
+/*
+	Verify the new serial port information contained within serinfo is
+	suitable for this port type.
+
+	Locking: none.
+	Interrupts: caller dependent.
+*/
+static int
+keyhole_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	DEBUG_PRINTK("keyhole_verify_port()\n");
+	if (ser->irq >= NR_IRQS || ser->irq < 0 ||
+	    ser->baud_base < 9600 || ser->type < PORT_UNKNOWN ||
+	    ser->type >= ARRAY_SIZE(uart_config))
+		return -EINVAL;
+	return 0;
+}
+/*
+	Return a pointer to a string constant describing the specified
+	port, or return NULL, in which case the string 'unknown' is
+	substituted.
+
+	Locking: none.
+	Interrupts: caller dependent.
+*/
+static const char *
+keyhole_type(struct uart_port *port)
+{
+	int type = port->type;
+
+	DEBUG_PRINTK("keyhole_type()\n");
+	if (type >= ARRAY_SIZE(uart_config))
+		type = 0;
+	return uart_config[type].name;
+}
+
+static struct uart_ops keyhole_pops = {
+	.tx_empty	= keyhole_tx_empty,
+	.set_mctrl	= keyhole_set_mctrl,
+	.get_mctrl	= keyhole_get_mctrl,
+	.stop_tx	= keyhole_stop_tx,
+	.start_tx	= keyhole_start_tx,
+	.stop_rx	= keyhole_stop_rx,
+	.enable_ms	= keyhole_enable_ms,
+	.break_ctl	= keyhole_break_ctl,
+	.startup	= keyhole_startup,
+	.shutdown	= keyhole_shutdown,
+	.set_termios	= keyhole_set_termios,
+	.pm		= keyhole_pm,
+	.type		= keyhole_type,
+	.release_port	= keyhole_release_port,
+	.request_port	= keyhole_request_port,
+	.config_port	= keyhole_config_port,
+	.verify_port	= keyhole_verify_port,
+};
+
+
+static void __init keyhole_init_ports(void)
+{
+	struct keyhole_port *up;
+	static int first = 1;
+	int i;
+
+	DEBUG_PRINTK("keyhole_init_ports()\n");
+	if (!first)
+		return;
+	first = 0;
+
+#if 0 // 8250
+	for (i = 0; i < UART_NR; i++) {
+		struct keyhole_port *up = &keyhole_ports[i];
+
+		up->port.line = i;
+		spin_lock_init(&up->port.lock);
+
+		init_timer(&up->timer);
+		up->timer.function = keyhole_timeout;
+
+		/*
+		 * ALPHA_KLUDGE_MCR needs to be killed.
+		 */
+		up->mcr_mask = ~ALPHA_KLUDGE_MCR;
+		up->mcr_force = ALPHA_KLUDGE_MCR;
+
+		up->port.ops = &keyhole_pops;
+	}
+#endif
+	for (i = 0, up = keyhole_ports; i < ARRAY_SIZE(old_serial_port) && i <
UART_NR; i++, up++) {
+		up->port.iobase   = old_serial_port[i].port;
+		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
+		up->port.uartclk  = old_serial_port[i].baud_base;
+		up->port.flags    = old_serial_port[i].flags;
+		up->port.membase  = old_serial_port[i].iomem_base;
+		up->port.iotype   = old_serial_port[i].io_type;
+		up->port.regshift = old_serial_port[i].iomem_reg_shift;
+#if 1 // ~8250
+		up->port.ops      = &keyhole_pops;
+#endif
+		dump_port(&up->port);
+	}
+}
+
+static void __init
+keyhole_register_ports(struct uart_driver *drv)
+{
+	int i;
+
+	DEBUG_PRINTK("keyhole_register_ports()\n");
+	keyhole_init_ports();
+
+	for (i = 0; i < UART_NR; i++) {
+		struct keyhole_port *up = &keyhole_ports[i];
+
+#if 1 // ~8250
+		up->port.line = i;
+		up->port.ops = &keyhole_pops;
+		init_timer(&up->timer);
+		up->timer.function = keyhole_timeout;
+#endif
+		uart_add_one_port(drv, &up->port);
+	}
+}
+
+/*
+ *	Print a string to the serial port trying not to disturb
+ *	any possible real use of the port...
+ *
+ *	The console_lock must be held when we get here.
+ */
+static void
+keyhole_console_write(struct console *co, const char *s, unsigned int
count)
+{
+	struct keyhole_port *up = &keyhole_ports[co->index];
+
+	keyhole_set_ier(up, 0);	// disable interrupts
+	DEBUG_PRINTK("#");
+	while (*s && count-- > 0) {
+		keyhole_putchar(up, *s);
+		if (*s == '\n')
+			keyhole_putchar(up, '\r');
+		s++;
+	}
+
+	/*
+	 *	Finally, wait for transmitter to become empty
+	 *	and restore the IER
+	 */
+	//keyhole_wait_for_xmitr_empty(up);
+	keyhole_set_ier(up, up->ier);	// restore interrupts
+}
+
+static int keyhole_console_setup(struct console *co, char *options)
+{
+	struct uart_port *port;
+	int baud = 9600;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	DEBUG_PRINTK("keyhole_console_setup()\n");
+	/*
+	 * Check whether an invalid uart number has been specified, and
+	 * if so, search for the first available port that does have
+	 * console support.
+	 */
+	if (co->index >= UART_NR)
+		co->index = 0;
+	port = &keyhole_ports[co->index].port;
+	if (!port->iobase && !port->membase)
+		return -ENODEV;
+#if 0 // ~m32r
+	/*
+	 * Temporary fix.
+	 */
+	spin_lock_init(&port->lock);
+#endif
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(port, co, baud, parity, bits, flow);
+}
+
+static struct uart_driver keyhole_reg;
+static struct console keyhole_console = {
+	.name		= "ttyS",
+	.write		= keyhole_console_write,
+	.device		= uart_console_device,
+	.setup		= keyhole_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &keyhole_reg,
+};
+
+static int __init keyhole_console_init(void)
+{
+	struct keyhole_port *port = &keyhole_ports[0];
+
+	DEBUG_PRINTK("keyhole_console_init()\n");
+	DEBUG_PRINTK("keyhole_console.flags %x\n",keyhole_console.flags);
+	serial_reset(port);
+	serial_init(port);
+
+	keyhole_init_ports();
+	register_console(&keyhole_console);
+	return 0;
+}
+console_initcall(keyhole_console_init);
+
+#ifdef CONFIG_SERIAL_KEYHOLE_CONSOLE
+#define SERIALKEYHOLE_CONSOLE	&keyhole_console
+#else
+#define SERIALKEYHOLE_CONSOLE	NULL
+#endif
+
+static struct uart_driver keyhole_reg = {
+	.owner			= THIS_MODULE,
+	.driver_name		= "keyhole",
+// 8250	.driver_name		= "serial",
+	.devfs_name		= "tts/",
+	.dev_name		= "ttyS",
+	.major			= TTY_MAJOR,
+	.minor			= 64,
+	.nr			= UART_NR,
+	.cons			= SERIALKEYHOLE_CONSOLE,
+};
+
+int __init early_serial_setup(struct uart_port *port)
+{
+	DEBUG_PRINTK("early_serial_setup()\n");
+	dump_port(port);
+	if (port->line >= ARRAY_SIZE(keyhole_ports))
+		return -ENODEV;
+
+// 8250	keyhole_init_ports();
+	keyhole_ports[port->line].port	= *port;
+	keyhole_ports[port->line].port.ops	= &keyhole_pops;
+	return 0;
+}
+
+/**
+ *	keyhole_suspend_port - suspend one serial port
+ *	@line:  serial line number
+ *      @level: the level of port suspension, as per uart_suspend_port
+ *
+ *	Suspend one serial port.
+ */
+void keyhole_suspend_port(int line)
+{
+	uart_suspend_port(&keyhole_reg, &keyhole_ports[line].port);
+}
+
+/**
+ *	keyhole_resume_port - resume one serial port
+ *	@line:  serial line number
+ *      @level: the level of port resumption, as per uart_resume_port
+ *
+ *	Resume one serial port.
+ */
+void keyhole_resume_port(int line)
+{
+	uart_resume_port(&keyhole_reg, &keyhole_ports[line].port);
+}
+
+static int __init keyhole_init(void)
+{
+	int ret, i;
+
+	printk(KERN_INFO "Serial: keyhole driver $Revision: 0.10 $ " "%d
ports\n", (int) UART_NR);
+
+	for (i = 0; i < NR_IRQS; i++)
+		spin_lock_init(&irq_lists[i].lock);
+
+	ret = uart_register_driver(&keyhole_reg);
+#if 1 // ~8250
+	if (ret >= 0)
+		keyhole_register_ports(&keyhole_reg);
+#endif
+
+	DEBUG_PRINTK("%d=keyhole_init()\n",ret);
+	return ret;
+}
+
+static void __exit keyhole_exit(void)
+{
+	int i;
+
+	DEBUG_PRINTK("keyhole_exit()\n");
+	for (i = 0; i < UART_NR; i++)
+		uart_remove_one_port(&keyhole_reg, &keyhole_ports[i].port);
+
+	uart_unregister_driver(&keyhole_reg);
+}
+
+module_init(keyhole_init);
+module_exit(keyhole_exit);
+
+EXPORT_SYMBOL(keyhole_suspend_port);
+EXPORT_SYMBOL(keyhole_resume_port);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Generic keyhole serial driver $Revision: 0.10 $");
+MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
+
+
diff --git a/drivers/serial/keyhole.h b/drivers/serial/keyhole.h
new file mode 100644
index 0000000..8b13789
--- /dev/null
+++ b/drivers/serial/keyhole.h
@@ -0,0 +1 @@
+
diff --git a/drivers/serial/keyhole_early.c b/drivers/serial/keyhole_early.c
new file mode 100644
index 0000000..10e235e
--- /dev/null
+++ b/drivers/serial/keyhole_early.c
@@ -0,0 +1,178 @@
+/*
+ * Early serial console for Pico Keyhole devices
+ *
+ * (c) Copyright 2005 DLA Systems
+ *	David H. Lynch Jr. <dhlii@dlasys.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Based on the 8250_early.c driver
+ *
+ * This is for use before the serial driver has initialized, in
+ * particular, before the UARTs have been discovered and named.
+ * Instead of specifying the console device as, e.g., "ttyS0",
+ * we locate the device directly by its MMIO or I/O port address.
+ *
+ * The user can specify the device directly, e.g.,
+ *	console=keyhole
+ * or platform code can call early_keyhole_console_init() to set
+ * the early UART device.
+ *
+ * After the normal serial driver starts, we try to locate the
+ * matching ttyS device and start a console there.
+ */
+
+#include <linux/console.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/serial_keyhole.h>
+#include <asm/io.h>
+
+static void dump_port(struct uart_port *p)
+{
+	_printk("early_keyhole: ");
+	_printk("p->iotype:%d ",p->iotype);
+	_printk("p->iobase:%x ",p->iobase);
+	_printk("p->mapbase:%lx ",(unsigned long) p->mapbase);
+	_printk("p->membase:%lx \n",(unsigned long) p->membase);
+}
+
+struct early_keyhole_device {
+	struct uart_port port;
+	char options[16];		/* e.g., 115200n8 */
+};
+
+static struct early_keyhole_device early_device __initdata;
+static int early_keyhole_registered __initdata;
+
+
+//Output one 32bit value thru the keyhole.
+static int __init Koutput(struct early_keyhole_device *kp, unsigned
long cmd, unsigned long kh) {
+	struct uart_port *port = &kp->port;
+
+	// port->membase = XPAR_KEYHOLE;
+	unsigned int status;
+
+	for (;;) {
+		status = serial_in32(XPAR_KEYHOLE, UART_LSR);
+		if ((status & UART_LSR_TXF) == 0) {
+			//careful about the order here. data must be sent last.
+			serial_out32(XPAR_KEYHOLE, UART_LCR,cmd);
+			serial_out32(XPAR_KEYHOLE, UART_TX,kh);    //triggers fifo write
+			return 1;
+		}
+		cpu_relax();
+	}
+	return -1;
+} //Koutput...
+
+static void __init early_keyhole_putc(struct early_keyhole_device *kp,
unsigned char c)
+{
+  	KEYHOLE_DATA kh;
+
+	if (c == '\r') return;
+    	kh.u32 = 0; kh.packetType = KHC_FMTD; kh.countWords = 3;
+	Koutput(kp, KH_BEGIN, kh.u32) ;
+	kh.u32 = 0;
+	kh.asci0 = c;
+        Koutput(kp, KH_STR, kh.u32);
+	Koutput(kp, KH_END, kh.u32);
+}
+
+static void __init early_keyhole_write(struct console *console, const
char *s, unsigned int count)
+{
+	struct early_keyhole_device *kp = &early_device;
+	while (*s && count-- > 0) {
+		if (*s == '\n')
+			early_keyhole_putc(kp, '*');
+		early_keyhole_putc(kp, *s);
+		if (*s == '\n')
+			early_keyhole_putc(kp, '\r');
+		s++;
+	}
+}
+
+static int __init early_keyhole_setup(struct console *console, char
*options) {
+	struct early_keyhole_device *device = &early_device;
+	struct uart_port *port = &device->port;
+
+	_printk("early_keyhole_setup()\n");
+	port->uartclk = BASE_BAUD * 16;
+	port->iotype = UPIO_MEM;
+	port->mapbase = XPAR_KEYHOLE;
+	port->membase = XPAR_KEYHOLE;
+	// port->membase = ioremap(port->mapbase, 64);
+	dump_port(port);
+	return 0;
+}
+
+static struct console early_keyhole_console __initdata = {
+	.name	= "keyhole",
+	.write	= early_keyhole_write,
+	.setup	= early_keyhole_setup,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
+};
+
+static int __init early_keyhole_console_init(void)
+{
+	_printk("early_keyhole_console_init()\n");
+	if (!early_keyhole_registered) {
+		_printk("register_console()\n");
+		register_console(&early_keyhole_console);
+		early_keyhole_registered = 1;
+	}
+	return 0;
+}
+console_initcall(early_keyhole_console_init);
+
+int __init early_serial_console_init(char *cmdline)
+{
+	char *options;
+	int err;
+
+	_printk("early_serial_console_init()\n");
+	options = strstr(cmdline, "console=keyhole");
+	if (!options)
+		return -ENODEV;
+
+	options = strchr(cmdline, ',') + 1;
+	if ((err = early_keyhole_setup(NULL, options)) < 0)
+		return err;
+	return early_keyhole_console_init();
+}
+
+static int __init early_keyhole_console_switch(void)
+{
+	struct early_keyhole_device *device = &early_device;
+	struct uart_port *port = &device->port;
+	int mmio, line;
+
+	_printk("early_keyhole_console_switch()\n");
+	dump_port(port);
+	if (!(early_keyhole_console.flags & CON_ENABLED))
+		return 0;
+
+	_printk("early_keyhole_console_switch(01)\n");
+	/* Try to start the normal driver on a matching line.  */
+	mmio = (port->iotype == UPIO_MEM);
+	line = keyhole_start_console(port, device->options);
+	if (line < 0)
+		_printk("No ttyS device at %s 0x%lx for console\n",
+			mmio ? "MMIO" : "I/O port",
+			mmio ? port->mapbase :
+			    (unsigned long) port->iobase);
+
+	_printk("early_keyhole_console_switch(02)\n");
+	unregister_console(&early_keyhole_console);
+	if (mmio) {
+		iounmap(port->membase);
+		_printk("iounmap(%lx)\n",port->membase);
+	}
+	_printk("early_keyhole_console_switch(03)\n");
+	return 0;
+}
+late_initcall(early_keyhole_console_switch);
diff --git a/drivers/serial/printk.c b/drivers/serial/printk.c
new file mode 100644
index 0000000..5e87489
--- /dev/null
+++ b/drivers/serial/printk.c
@@ -0,0 +1,267 @@
+/*
+ * arch/ppc/kernel/printf.c
+ *
+ * early printk code code (almost) all platforms can use
+ *
+ * Author: David H. Lynch Jr. <dhlii@dlasys.net>
+ *
+ * Derived heavily from arch/ppc/boot/common/misc-common1.c
+ *
+ * 20050 (c) DLA Systems This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <stdarg.h>	/* for va_ bits */
+#include <linux/config.h>
+#include <linux/string.h>
+
+#define putc dbg_putc
+
+#if defined(CONFIG_SERIAL_KEYHOLE_DEBUG)
+
+#include <linux/serial_keyhole.h>
+
+static int MillisecTimeout=1000;
+void
+usleep(int t)
+{
+   int ii, waitTime=100;
+    while(t) {
+    	for (ii=0; ii < MillisecTimeout*1000/waitTime; ii++) {
+	};
+	t--;
+    }
+}
+
+//Output one 32bit value thru the keyhole.
+static int
+keyhole_out(unsigned long cmd, unsigned long kh)
+{
+	unsigned int status;
+
+#if 1
+	for (;;) {
+		status = serial_in32(XPAR_KEYHOLE, UART_LSR);
+		if ((status & UART_LSR_TXF) == 0) {
+			//careful about the order here. data must be sent last.
+			serial_out32(XPAR_KEYHOLE, UART_LCR, cmd);
+			serial_out32(XPAR_KEYHOLE, UART_TX, kh);    //triggers fifo write
+			return 1;
+		}
+        	usleep(100); //wait if ppc2pc fifo is almost full.
+		// cpu_relax();
+	}
+#endif
+	return -1;
+} //keyhole_out...
+
+void
+dbg_putc(unsigned char c)
+{
+  	KEYHOLE_DATA kh;
+	if (c == '\r') return;
+    	kh.u32 = 0; kh.packetType = KHC_FMTD; kh.countWords = 3;
+	keyhole_out(KH_BEGIN, kh.u32) ;
+	kh.u32 = 0;
+	kh.asci0 = c;
+        keyhole_out(KH_STR, kh.u32);
+	keyhole_out(KH_END, kh.u32);
+}
+
+#endif
+
+
+#if defined(CONFIG_SERIAL_UARTLITE_DEBUG)
+#include <linux/serial_uartlite.h>
+void
+dbg_putc(unsigned char c)
+{
+    unsigned int status ;
+    do {
+	    status =  serial_in32(XPAR_UARTLITE, UART_LSR);
+    } while ( status & UART_LSR_TXF);
+    serial_out32(XPAR_UARTLITE, UART_TX, c);
+}
+
+#endif
+
+#define FALSE 0
+#define TRUE  1
+#define is_digit(c) ((c >= '0') && (c <= '9'))
+int
+_cvt(unsigned long val, char *buf, long radix, char *digits)
+{
+	char temp[80];
+	char *cp = temp;
+	int length = 0;
+	if (val == 0)
+	{ /* Special case */
+		*cp++ = '0';
+	} else
+		while (val)
+		{
+			*cp++ = digits[val % radix];
+			val /= radix;
+		}
+	while (cp != temp)
+	{
+		*buf++ = *--cp;
+		length++;
+	}
+	*buf = '\0';
+	return (length);
+}
+
+void
+_vprintk(void(*putc)(const char), const char *fmt0, va_list ap)
+{
+	char c, sign, *cp = 0;
+	int left_prec, right_prec, zero_fill, length = 0, pad, pad_on_right;
+	char buf[32];
+	long val;
+	while ((c = *fmt0++))
+	{
+		if (c == '%')
+		{
+			c = *fmt0++;
+			left_prec = right_prec = pad_on_right = 0;
+			if (c == 'l')
+			{
+				c = *fmt0++;
+			}
+			if (c == '-')
+			{
+				c = *fmt0++;
+				pad_on_right++;
+			}
+			if (c == '0')
+			{
+				zero_fill = TRUE;
+				c = *fmt0++;
+			} else
+			{
+				zero_fill = FALSE;
+			}
+			while (is_digit(c))
+			{
+				left_prec = (left_prec * 10) + (c - '0');
+				c = *fmt0++;
+			}
+			if (c == '.')
+			{
+				c = *fmt0++;
+				zero_fill++;
+				while (is_digit(c))
+				{
+					right_prec = (right_prec * 10) + (c - '0');
+					c = *fmt0++;
+				}
+			} else
+			{
+				right_prec = left_prec;
+			}
+			sign = '\0';
+			switch (c)
+			{
+			case 'd':
+			case 'u':
+			case 'x':
+			case 'X':
+				val = va_arg(ap, long);
+				switch (c)
+				{
+				case 'd':
+					if (val < 0)
+					{
+						sign = '-';
+						val = -val;
+					}
+					length = _cvt(val, buf, 10, "0123456789");
+					break;
+				case 'x':
+					length = _cvt(val, buf, 16, "0123456789abcdef");
+					break;
+				case 'X':
+					length = _cvt(val, buf, 16, "0123456789ABCDEF");
+					break;
+				}
+				cp = buf;
+				break;
+			case 's':
+				cp = va_arg(ap, char *);
+				length = strlen(cp);
+				break;
+			case 'c':
+				c = va_arg(ap, long /*char*/);
+				(*putc)(c);
+				continue;
+			default:
+				(*putc)('?');
+			}
+			pad = left_prec - length;
+			if (sign != '\0')
+			{
+				pad--;
+			}
+			if (zero_fill)
+			{
+				c = '0';
+				if (sign != '\0')
+				{
+					(*putc)(sign);
+					sign = '\0';
+				}
+			} else
+			{
+				c = ' ';
+			}
+			if (!pad_on_right)
+			{
+				while (pad-- > 0)
+				{
+					(*putc)(c);
+				}
+			}
+			if (sign != '\0')
+			{
+				(*putc)(sign);
+			}
+			while (length-- > 0)
+			{
+				(*putc)(c = *cp++);
+				if (c == '\n')
+				{
+					(*putc)('\r');
+				}
+			}
+			if (pad_on_right)
+			{
+				while (pad-- > 0)
+				{
+					(*putc)(c);
+				}
+			}
+		} else
+		{
+			(*putc)(c);
+			if (c == '\n')
+			{
+				(*putc)('\r');
+			}
+		}
+	}
+}
+
+void
+_printk(char const *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	_vprintk(putc, fmt, ap);
+	va_end(ap);
+	return;
+}
+
diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
new file mode 100644
index 0000000..af046b0
--- /dev/null
+++ b/drivers/serial/uartlite.c
@@ -0,0 +1,1536 @@
+/*
+ *  linux/drivers/serial/uartlite.c
+ *
+ *  Driver for uartlite ports
+ *
+ *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
+ *  Based on drivers/serial/8250.c.
+ *
+ *  Author: David H. Lynch Jr. <dhlii@dlasys.net>
+ *  Copyright (C) 2005 DLA Systems
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
 USA
+ *
+ *  $Id: uartlite.c,v 0.10 2005/12/14 10:03:27 dhlii Exp $
+ *
+ * A note about mapbase / membase
+ *
+ *  mapbase is the physical address of the IO port.  Currently, we don't
+ *  support this very well, and it may well be dropped from this driver
+ *  in future.  As such, mapbase should be NULL.
+ *
+ *  membase is an 'ioremapped' cookie.  This is compatible with the old
+ *  serial.c driver, and is currently the preferred form.
+ *
+ *  Todo:
+ *  	KEY_HOLE:
+ *  		UART_LSR_DR needs to be properly defined to receive data
+ *  		UART_IIR needs checked it is mapped to the status register
+ *  		UART_IIR_NO_INT is defined as 0, that should ALWAYS result in
checking for IO
+ *  		UART_LSR_TEMT   is defined as UART_LSR_THRE
+ *  	UART_LITE:
+ *  	BOTH:
+ *  		The following "bits" are defined as 0. This keeps the code nearly
identical to other serial drivers
+ *  		while effectively disabling the relevant features
+ *  		UART_LSR_BI
+ *  		UART_LCR_WLEN5
+ *  		UART_LCR_WLEN6
+ *  		UART_LCR_WLEN7
+ *  		UART_LCR_WLEN8
+ *  		UART_LCR_STOP
+ *  		UART_LCR_PARITY
+ *  		UART_LCR_EPAR
+ *  		UART_LSR_BI
+ *  		UART_IER_MSI	- neither has modem status
+ *
+ *
+ * Things to borrow
+ *  		
+ */
+
+
+#define tx_enabled(port)	((port)->unused[0])
+#define rx_enabled(port)	((port)->unused[1])
+
+
+#include <linux/config.h>
+
+#if defined(CONFIG_SERIAL_UARTLITE_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/tty.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+#include <linux/serial_uartlite.h>
+#include <asm/io.h>
+#include <linux/sysrq.h>
+#include <asm/irq.h>
+/*
+#include <linux/ioport.h>
+#include <linux/serialP.h>
+#include <asm/serial.h>
+#include "uartlite.h"
+#include "uartlite_reg.h"
+*/
+
+
+#define IS_DBG 1
+#define IS_INT 0
+#define IS_TXI 0
+// #define IS_KH 1
+/*
+ * Debugging.
+ */
+#if 0
+#define DEBUG_AUTOCONF(fmt...)	printk(fmt)
+#else
+#define DEBUG_AUTOCONF(fmt...)	do { } while (0)
+#endif
+
+#if 0
+#define DEBUG_INTR(fmt...)	printk(fmt)
+#else
+#define DEBUG_INTR(fmt...)	do { } while (0)
+#endif
+
+#if IS_DBG
+#define DEBUG_PRINTK(fmt...)	_printk(fmt)
+#else
+#define DEBUG_PRINTK(fmt...)	do { } while (0)
+#endif
+
+static void dump_port(struct uart_port *p)
+{
+	DEBUG_PRINTK("uartlite: ");
+	DEBUG_PRINTK("p->line:%d ",p->line);
+	DEBUG_PRINTK("p->iotype:%d ",p->iotype);
+	DEBUG_PRINTK("p->iobase:%x ",p->iobase);
+	DEBUG_PRINTK("p->regshift:%x ",p->regshift);
+	DEBUG_PRINTK("p->flags:%x ",p->flags);
+	DEBUG_PRINTK("p->irq:%x ",p->irq);
+	DEBUG_PRINTK("p->fifosize:%lx ",(unsigned long) p->fifosize);
+	DEBUG_PRINTK("p->mapbase:%lx ",(unsigned long) p->mapbase);
+	DEBUG_PRINTK("p->membase:%lx \n",(unsigned long) p->membase);
+}
+#define UARTLITE_ISR_PASS_LIMIT	256
+#define PORT_UARTLITE_BASE	PORT_UARTLITE
+#define PORT_INDEX(x)	(x - PORT_UARTLITE_BASE + 1)
+
+
+/*
+ * We default to IRQ0 for the "no irq" hack.   Some
+ * machine types want others as well - they're free
+ * to redefine this in their header file.
+ */
+#define is_real_interrupt(irq)	((irq) >= 0)
+
+
+
+/*
+ * SERIAL_PORT_DFNS tells us about built-in ports that have no
+ * standard enumeration mechanism.   Platforms that can find all
+ * serial ports via mechanisms like ACPI or PCI need not supply it.
+ */
+#ifndef SERIAL_PORT_DFNS
+#define SERIAL_PORT_DFNS
+#endif
+
+static struct old_serial_port old_serial_port[] = {
+	SERIAL_PORT_DFNS /* defined in asm/serial.h */
+};
+
+#define UART_NR	CONFIG_SERIAL_UARTLITE_NR_UARTS
+// #define UART_NR	ARRAY_SIZE(old_serial_port)
+
+struct uartlite_port {
+	struct uart_port	port;
+	struct timer_list	timer;		/* "no irq" timer */
+	struct list_head	list;		/* ports on this IRQ */
+	unsigned short		capabilities;	/* port capabilities */
+	unsigned char		ier;
+	unsigned char		lcr;
+	unsigned char		mcr;
+	unsigned char		lsr_break_flag;
+	unsigned int		count;	
+
+	/*
+	 * We provide a per-port pm hook.
+	 */
+	void			(*pm)(struct uart_port *port,
+				      unsigned int state, unsigned int old);
+};
+
+struct irq_info {
+	spinlock_t		lock;
+	struct list_head	*head;
+};
+
+static struct irq_info irq_lists[NR_IRQS];
+
+/*
+ * Here we define the default xmit fifo size used for each type of UART.
+ */
+static const struct serial_uartlite_config uart_config[] = {
+	[PORT_UNKNOWN] = {
+		.name		= "unknown",
+		.fifo_size	= 1,
+		.flags		= 0,
+	},
+#if defined(IS_KH)
+	[PORT_INDEX(PORT_UARTLITE)] = {
+		.name		= "uartlite",
+		.fifo_size	= 1,
+		.flags		= 0,
+	},
+#else
+	[PORT_INDEX(PORT_UARTLITE)] = {
+		.name		= "uartlite",
+		.fifo_size	= 16,
+		.flags		= UART_CAP_FIFO,
+	},
+#endif
+};
+
+static _INLINE_ unsigned int serial_in(struct uartlite_port *up, int
offset)
+{
+	unsigned int value;
+	offset <<= up->port.regshift;
+
+	switch (up->port.iotype) {
+	default:
+		value = (*(volatile unsigned int *) ( up->port.membase + offset));
+		__asm__ __volatile__("eieio");
+		return value;
+	}
+}
+
+static _INLINE_ void
+serial_out(struct uartlite_port *up, int offset, int value)
+{
+	offset <<= up->port.regshift;
+
+	switch (up->port.iotype) {
+	default:
+ 		(*(volatile unsigned int *)( up->port.membase + offset) =value);
+ 		__asm__ __volatile__("eieio");
+		break;
+
+	}
+}
+
+static struct uartlite_port uartlite_ports[UART_NR];
+
+/*
+ *	Wait for transmitter & holding register to empty
+ */
+static inline void
+uartlite_wait_for_xmitr_empty(struct uartlite_port *up)
+{
+	unsigned int status, tmout = 10000;
+
+	/* Wait up to 10ms for the character(s) to be sent. */
+	do {
+		status = serial_in(up, UART_LSR);
+
+		if (status & UART_LSR_BI)
+			up->lsr_break_flag = UART_LSR_BI;
+
+		if (--tmout == 0)
+			break;
+		udelay(1);
+	} while (status & UART_LSR_TXF);
+
+	/* Wait up to 1s for flow control if necessary */
+	if (up->port.flags & UPF_CONS_FLOW) {
+		tmout = 1000000;
+		while (--tmout)
+			udelay(1);
+	}
+}
+
+#if defined(IS_KH)
+
+//Output one 32bit value thru the uartlite.
+void
+uartlite_out(struct uartlite_port *up, unsigned long cmd, unsigned long
kh)
+{
+#if 0
+	
+	uartlite_wait_for_xmitr_empty(up);
+	//careful about the order here. data must be sent last.
+	serial_out(up, UART_LCR,cmd);
+	serial_out(up, UART_TX,kh);    		//triggers fifo write
+	return;
+#else
+	unsigned int status;
+
+	for (;;) {
+		status = serial_in(up, UART_LSR);
+		if ((status & UART_LSR_TXF) == 0) {
+			//careful about the order here. data must be sent last.
+			serial_out(up, UART_LCR, cmd);
+			serial_out(up, UART_TX, kh);    //triggers fifo write
+			return;
+		}
+        	udelay(100); //wait if ppc2pc fifo is almost full.
+		// cpu_relax();
+	}
+#endif
+}
+void
+uartlite_putc(struct uartlite_port *up, unsigned char c)
+{
+  	UARTLITE_DATA kh;
+
+	if (c == '\r') return;
+    	kh.u32 = 0; kh.packetType = KHC_FMTD; kh.countWords = 3;
+	uartlite_out(up,KH_BEGIN, kh.u32) ;
+	kh.u32 = 0;
+	kh.asci0 = c;
+        uartlite_out(up,KH_STR, kh.u32);
+	uartlite_out(up,KH_END, kh.u32);
+}
+
+
+unsigned char
+uartlite_getc(struct uartlite_port *up)
+{
+	return 0;
+}
+
+void
+uartlite_set_ier(struct uartlite_port *up, unsigned int mask)
+{
+}
+#else
+
+void
+uartlite_putc(struct uartlite_port *up, unsigned char c)
+{
+	DEBUG_PRINTK("%c",c);
+	serial_out(up, UART_TX, c);
+	if (c == '\r')
+		up->count = 0;
+	if (up->count >= 85)
+		uartlite_putc(up, '\r');
+}
+void
+uartlite_putchar(struct uartlite_port *up, unsigned char c)
+{
+	uartlite_wait_for_xmitr_empty(up);
+	uartlite_putc(up,c);
+}
+
+unsigned char
+uartlite_getc(struct uartlite_port *up)
+{
+		return serial_in(up, UART_RX);
+}
+
+void
+uartlite_set_ier(struct uartlite_port *up, unsigned int ier)
+{
+	serial_out(up, UART_IER, ier);
+}
+
+#endif
+
+#if 0
+void
+dbg_putc(unsigned char c)
+{
+	//struct uartlite_port *up = &uartlite_ports[0];
+	struct uartlite_port *up = &old_serial_port[1];
+	return ;
+	if (up->port.membase)
+		uartlite_putchar(up,c);
+}
+#endif
+static void serial_reset( struct uartlite_port *up)
+{
+	(void) serial_in(up, UART_LSR);
+#if !defined(IS_KH)
+	(void) serial_in(up, UART_RX);
+#endif
+}
+
+static void serial_init( struct uartlite_port *up)
+{
+
+	up->capabilities = uart_config[up->port.type].flags;
+	up->mcr = 0;
+	up->ier = 0;
+
+
+#if !defined(IS_KH)
+	/*
+	 * Clear the FIFO buffers and disable them.
+	 * (they will be reeanbled in set_termios())
+	 */
+	up->ier &= ~(UART_LCR_RXF | UART_LCR_TXF);
+	uartlite_set_ier(up, up->ier);
+
+	/*
+	 * Clear the interrupt registers.
+	 */
+	(void) serial_in(up, UART_LSR);
+	(void) serial_in(up, UART_RX);
+	if (up->capabilities & UART_CAP_FIFO) {
+		// there is no FIFO enable/diosable for the Uart Lite
+	}
+#endif
+}
+/*
+	Stop transmitting characters.  This might be due to the CTS
+	line becoming inactive or the tty layer indicating we want
+	to stop transmission due to an XOFF character.
+
+	Locking: up->lock taken.
+	Interrupts: locally disabled.
+	This call must not sleep
+*/
+static void uartlite_stop_tx(struct uart_port *port)
+{
+	struct uartlite_port *up = (struct uartlite_port *)port;
+
+	DEBUG_PRINTK("uartlite_stop_tx()\n");
+	if (tx_enabled(port)) {
+		// disable_irq(IRQ_CONTX);
+		tx_enabled(port) = 0;
+	}
+#if 0
+// the key_hole port has no IER port, but it might and it seems useful
to fake it
+	if (up->ier & UART_IER_THRI) {
+		up->ier &= ~UART_IER_THRI;
+		uartlite_set_ier(up, up->ier);
+	}
+#endif
+}
+static _INLINE_ void transmit_chars(struct uartlite_port *up)
+{
+	struct circ_buf *xmit = &up->port.info->xmit;
+	int count;
+
+	//DEBUG_PRINTK("<");
+	//DEBUG_PRINTK("transmit_chars()  %c",up->port.x_char);
+	//DEBUG_PRINTK("%c", up->port.x_char);
+	if (up->port.x_char) {
+		//DEBUG_PRINTK("+");
+		uartlite_putc(up, up->port.x_char);
+		up->port.icount.tx++;
+		up->port.x_char = 0;
+		return;
+	}
+	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
+		//DEBUG_PRINTK("$");
+		uartlite_stop_tx(&up->port);
+		return;
+	}
+
+	count = up->port.fifosize;
+	//DEBUG_PRINTK("count=%d",count);
+	do {
+		//DEBUG_PRINTK("%c",xmit->buf[xmit->tail]);
+		uartlite_putc(up, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		up->port.icount.tx++;
+		if (uart_circ_empty(xmit))
+			break;
+		// while (!serial_in(up, UART_LSR) & UART_LSR_THRE);
+
+	} while (--count > 0);
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&up->port);
+
+	DEBUG_INTR("THRE...");
+
+	if (uart_circ_empty(xmit))
+		uartlite_stop_tx(&up->port);
+#if defined(IS_DBG) && 0
+	DEBUG_PRINTK("\n");
+#endif
+	DEBUG_PRINTK(">");
+}
+/*
+	start transmitting characters.
+
+	Locking: up->lock taken.
+	Interrupts: locally disabled.
+	This call must not sleep
+*/
+
+static void uartlite_start_tx(struct uart_port *port)
+{
+	struct uartlite_port *up = (struct uartlite_port *)port;
+	struct circ_buf *xmit = &up->port.info->xmit;
+	unsigned long flags;
+	
+	DEBUG_PRINTK("uartlite_start_tx()\n");
+
+	if (!tx_enabled(port)) {
+		// enable_irq(IRQ_CONTX);
+		tx_enabled(port) = 1;
+	}
+#if IS_TXI
+	if (!(up->ier & UART_IER_THRI)) {				// are TX interupts enabled ?
+	
+		DEBUG_PRINTK("uartlite_start_tx(01)\n");
+
+		up->ier |= UART_IER_THRI;				// enable them
+		uartlite_set_ier(up, up->ier);
+
+		uartlite_putc(up, xmit->buf[xmit->tail]);		// send 1 character to
kick things
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		up->port.icount.tx++;
+	}
+	//while((serial_in(up, UART_LSR) & UART_EMPTY) != UART_EMPTY);
+#else
+	if (port) {
+		//disable_irq(up->irqs[SCIx_TXI_IRQ]);
+		spin_lock_irqsave(&up->port.lock, flags);
+		transmit_chars(up);
+		spin_unlock_irqrestore(&up->port.lock, flags);
+		//enable_irq(up->irqs[SCIx_TXI_IRQ]);
+	}
+#endif
+}
+
+static void uartlite_stop_rx(struct uart_port *port)
+{
+#if 0
+	if (rx_enabled(port)) {
+		disable_irq(IRQ_CONRX);
+		rx_enabled(port) = 0;
+	}
+#endif	
+	struct uartlite_port *up = (struct uartlite_port *)port;
+
+	DEBUG_PRINTK("uartlite_stop_rx()\n");
+	up->ier &= ~UART_IER_RLSI;					// disable receive interrupts
+	up->port.read_status_mask &= ~UART_LSR_DR;
+	uartlite_set_ier(up, up->ier);
+}
+/*
+	Enable the modem status interrupts.
+
+	Locking: up->lock taken.
+	Interrupts: locally disabled.
+	This call must not sleep
+*/
+static void uartlite_enable_ms(struct uart_port *port)
+{
+	DEBUG_PRINTK("uartlite_enable_ms()\n");
+#if 0
+	struct uartlite_port *up = (struct uartlite_port *)port;
+
+	up->ier |= UART_IER_MSI;					// enable modem status interupts
+	uartlite_set_ier(up, up->ier);
+#endif
+}
+
+static _INLINE_ void
+receive_chars(struct uartlite_port *up, int *status, struct pt_regs *regs)
+{
+	struct tty_struct *tty = up->port.info->tty;
+	unsigned char ch, lsr = *status;
+	int max_count = 256;
+	char flag;
+
+	DEBUG_PRINTK("<");
+	do {
+		/* The following is not allowed by the tty layer and
+		   unsafe. It should be fixed ASAP */
+		if (unlikely(tty->flip.count >= TTY_FLIPBUF_SIZE)) {
+			if (tty->low_latency) {
+				spin_unlock(&up->port.lock);
+				tty_flip_buffer_push(tty);
+				spin_lock(&up->port.lock);
+			}
+			/*
+			 * If this failed then we will throw away the
+			 * bytes but must do so to clear interrupts
+			 */
+		}
+		ch = uartlite_getc(up);
+		flag = TTY_NORMAL;
+		up->port.icount.rx++;
+
+#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
+		/*
+		 * Recover the break flag from console xmit
+		 */
+		if (up->port.line == up->port.cons->index) {
+			lsr |= up->lsr_break_flag;
+			up->lsr_break_flag = 0;
+		}
+#endif
+
+		if (unlikely(lsr & (UART_LSR_BI | UART_LSR_PE |
+				    UART_LSR_FE | UART_LSR_OE))) {
+			/*
+			 * For statistics only
+			 */
+			if (lsr & UART_LSR_BI) {
+				lsr &= ~(UART_LSR_FE | UART_LSR_PE);
+				up->port.icount.brk++;
+				/*
+				 * We do the SysRQ and SAK checking
+				 * here because otherwise the break
+				 * may get masked by ignore_status_mask
+				 * or read_status_mask.
+				 */
+				if (uart_handle_break(&up->port))
+					goto ignore_char;
+			} else if (lsr & UART_LSR_PE)
+				up->port.icount.parity++;
+			else if (lsr & UART_LSR_FE)
+				up->port.icount.frame++;
+			if (lsr & UART_LSR_OE)
+				up->port.icount.overrun++;
+
+			/*
+			 * Mask off conditions which should be ignored.
+			 */
+			lsr &= up->port.read_status_mask;
+
+			if (lsr & UART_LSR_BI) {
+				DEBUG_INTR("handling break....");
+				flag = TTY_BREAK;
+			} else if (lsr & UART_LSR_PE)
+				flag = TTY_PARITY;
+			else if (lsr & UART_LSR_FE)
+				flag = TTY_FRAME;
+		}
+		if (uart_handle_sysrq_char(&up->port, ch, regs))
+			goto ignore_char;
+
+		uart_insert_char(&up->port, lsr, UART_LSR_OE, ch, flag);
+
+	ignore_char:
+		lsr = serial_in(up, UART_LSR);
+	} while ((lsr & UART_LSR_DR) && (max_count-- > 0));
+	spin_unlock(&up->port.lock);
+	tty_flip_buffer_push(tty);
+	spin_lock(&up->port.lock);
+	*status = lsr;
+}
+
+
+/*
+ * This handles the interrupt from one port.
+ */
+static inline void
+uartlite_handle_port(struct uartlite_port *up, struct pt_regs *regs)
+{
+	unsigned int status = serial_in(up, UART_LSR);
+
+	DEBUG_INTR("status = %x...", status);
+
+	// DEBUG_PRINTK("!");
+	DEBUG_PRINTK("status %02x\n", status);
+	if (status & UART_LSR_DR)
+		receive_chars(up, &status, regs);
+#if IS_TXI
+	// if (status & UART_LSR_THRE)
+	if (!(status & UART_LSR_TXF))
+		transmit_chars(up);
+#endif
+}
+
+#if IS_INT
+/*
+ * This is the serial driver's interrupt routine.
+ *
+ * Arjan thinks the old way was overly complex, so it got simplified.
+ * Alan disagrees, saying that need the complexity to handle the weird
+ * nature of ISA shared interrupts.  (This is a special exception.)
+ *
+ * In order to handle ISA shared interrupts properly, we need to check
+ * that all ports have been serviced, and therefore the ISA interrupt
+ * line has been de-asserted.
+ *
+ * This means we need to loop through all ports. checking that they
+ * don't have an interrupt pending.
+ */
+static irqreturn_t uartlite_interrupt(int irq, void *dev_id,
+	struct pt_regs *regs)
+{
+	struct irq_info *i = dev_id;
+	struct list_head *l, *end = NULL;
+	int pass_counter = 0, handled = 0;
+
+	DEBUG_INTR("uartlite_interrupt(%d)...", irq);
+
+	spin_lock(&i->lock);
+
+	l = i->head;
+	do {
+		struct uartlite_port *up;
+		unsigned int iir;
+
+		up = list_entry(l, struct uartlite_port, list);
+
+		iir = serial_in(up, UART_IIR);
+		if (!(iir & UART_IIR_NO_INT)) {
+			spin_lock(&up->port.lock);
+			uartlite_handle_port(up, regs);
+			spin_unlock(&up->port.lock);
+
+			handled = 1;
+
+			end = NULL;
+		} else if (end == NULL)
+			end = l;
+
+		l = l->next;
+
+		if (l == i->head && pass_counter++ > UARTLITE_ISR_PASS_LIMIT) {
+			/* If we hit this, we're dead. */
+			printk(KERN_ERR "uartlite: too much work for "
+				"irq%d\n", irq);
+			break;
+		}
+	} while (l != end);
+
+	spin_unlock(&i->lock);
+
+	DEBUG_INTR("end.\n");
+
+	return IRQ_RETVAL(handled);
+}
+
+/*
+ * To support ISA shared interrupts, we need to have one interrupt
+ * handler that ensures that the IRQ line has been deasserted
+ * before returning.  Failing to do this will result in the IRQ
+ * line being stuck active, and, since ISA irqs are edge triggered,
+ * no more IRQs will be seen.
+ */
+static void serial_do_unlink(struct irq_info *i, struct uartlite_port *up)
+{
+	spin_lock_irq(&i->lock);
+
+	if (!list_empty(i->head)) {
+		if (i->head == &up->list)
+			i->head = i->head->next;
+		list_del(&up->list);
+	} else {
+		BUG_ON(i->head != &up->list);
+		i->head = NULL;
+	}
+
+	spin_unlock_irq(&i->lock);
+}
+
+static int serial_link_irq_chain(struct uartlite_port *up)
+{
+	struct irq_info *i = irq_lists + up->port.irq;
+	int ret, irq_flags = up->port.flags & UPF_SHARE_IRQ ? SA_SHIRQ : 0;
+
+	spin_lock_irq(&i->lock);
+
+	if (i->head) {
+		list_add(&up->list, i->head);
+		spin_unlock_irq(&i->lock);
+
+		ret = 0;
+	} else {
+		INIT_LIST_HEAD(&up->list);
+		i->head = &up->list;
+		spin_unlock_irq(&i->lock);
+
+		ret = request_irq(up->port.irq, uartlite_interrupt,
+				  irq_flags, "serial", i);
+		if (ret < 0)
+			serial_do_unlink(i, up);
+	}
+
+	return ret;
+}
+
+static void serial_unlink_irq_chain(struct uartlite_port *up)
+{
+	struct irq_info *i = irq_lists + up->port.irq;
+
+	BUG_ON(i->head == NULL);
+
+	if (list_empty(i->head))
+		free_irq(up->port.irq, i);
+
+	serial_do_unlink(i, up);
+}
+#endif
+/*
+ * This function is used to handle ports that do not have an interrupt.
+ */
+static void uartlite_timeout(unsigned long data)
+{
+	struct uartlite_port *up = (struct uartlite_port *)data;
+	unsigned int timeout;
+	unsigned int iir;
+
+	// DEBUG_PRINTK("@");
+	// iir = serial_in(up, UART_IIR);
+	// if (!(iir & UART_IIR_NO_INT)) {
+		spin_lock(&up->port.lock);
+		uartlite_handle_port(up, NULL);
+		spin_unlock(&up->port.lock);
+	// }
+
+	timeout = up->port.timeout;
+	timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
+	mod_timer(&up->timer, jiffies + timeout);
+}
+/*
+	This function tests whether the transmitter fifo and shifter
+	for the port described by 'port' is empty.  If it is empty,
+	this function should return TIOCSER_TEMT, otherwise return 0.
+	If the port does not support this operation, then it should
+	return TIOCSER_TEMT.
+
+	Locking: none.
+	Interrupts: caller dependent.
+	This call must not sleep
+*/
+static unsigned int uartlite_tx_empty(struct uart_port *port)
+{
+	struct uartlite_port *up = (struct uartlite_port *)port;
+	unsigned long flags;
+	unsigned int ret;
+
+	DEBUG_PRINTK("uartlite_tx_empty()\n");
+	spin_lock_irqsave(&up->port.lock, flags);
+	ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
+	spin_unlock_irqrestore(&up->port.lock, flags);
+	return ret;
+}
+/*
+	Returns the current state of modem control inputs.  The state
+	of the outputs should not be returned, since the core keeps
+	track of their state.  The state information should include:
+		- TIOCM_DCD	state of DCD signal
+		- TIOCM_CTS	state of CTS signal
+		- TIOCM_DSR	state of DSR signal
+		- TIOCM_RI	state of RI signal
+	The bit is set if the signal is currently driven active.  If
+	the port does not support CTS, DCD or DSR, the driver should
+	indicate that the signal is permanently active.  If RI is
+	not available, the signal should not be indicated as active.
+
+	Locking: up->lock taken.
+	Interrupts: locally disabled.
+	This call must not sleep
+*/
+static unsigned int uartlite_get_mctrl(struct uart_port *port)
+{
+	DEBUG_PRINTK("uartlite_get_mctrl()\n");
+	return 0;
+}
+/*
+	This function sets the modem control lines for port described
+	by 'port' to the state described by mctrl.  The relevant bits
+	of mctrl are:
+		- TIOCM_RTS	RTS signal.
+		- TIOCM_DTR	DTR signal.
+		- TIOCM_OUT1	OUT1 signal.
+		- TIOCM_OUT2	OUT2 signal.
+	If the appropriate bit is set, the signal should be driven
+	active.  If the bit is clear, the signal should be driven
+	inactive.
+
+	Locking: up->lock taken.
+	Interrupts: locally disabled.
+	This call must not sleep
+*/
+static void uartlite_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	DEBUG_PRINTK("uartlite_set_mctrl()\n");
+}
+/*
+	Control the transmission of a break signal.  If ctl is
+	nonzero, the break signal should be transmitted.  The signal
+	should be terminated when another call is made with a zero
+	ctl.
+
+	Locking: none.
+	Interrupts: caller dependent.
+	This call must not sleep
+*/
+static void uartlite_break_ctl(struct uart_port *port, int break_state)
+{
+	DEBUG_PRINTK("uartlite_break_ctl()\n");
+}
+/*
+	Grab any interrupt resources and initialise any low level driver
+	state.  Enable the port for reception.  It should not activate
+	RTS nor DTR; this will be done via a separate call to set_mctrl.
+
+	Locking: port_sem taken.
+	Interrupts: globally disabled.
+*/
+static int uartlite_startup(struct uart_port *port)
+{
+	struct uartlite_port *up = (struct uartlite_port *)port;
+	int retval;
+
+	DEBUG_PRINTK("uartlite_startup()\n");
+	// serial_init(up);
+
+	tx_enabled(port) = 1;
+	rx_enabled(port) = 1;
+
+#if IS_INT
+	/*
+	 * If the "interrupt" for this port doesn't correspond with any
+	 * hardware interrupt, we use a timer-based system.  The original
+	 * driver used to do this with IRQ0.
+	 */
+	if (!is_real_interrupt(up->port.irq)) {
+		unsigned int timeout = up->port.timeout;
+
+		timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
+
+		up->timer.data = (unsigned long)up;
+		mod_timer(&up->timer, jiffies + timeout);
+	} else {
+		retval = serial_link_irq_chain(up);
+		if (retval)
+			return retval;
+	}
+#else
+		unsigned int timeout = up->port.timeout;
+
+		timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
+
+		up->timer.data = (unsigned long)up;
+		mod_timer(&up->timer, jiffies + timeout);
+#endif
+	/*
+	 * Finally, enable interrupts.  Note: Modem status interrupts
+	 * are set via set_termios(), which will be occurring imminently
+	 * anyway, so we don't enable them here.
+	 */
+	up->ier = UART_IER_RLSI | UART_IER_RDI;
+	uartlite_set_ier(up, up->ier);
+
+	/*
+	 * And clear the interrupt registers again for luck.
+	 */
+	serial_reset(up);
+	return 0;
+}
+/*
+	Disable the port, disable any break condition that may be in
+	effect, and free any interrupt resources.  It should not disable
+	RTS nor DTR; this will have already been done via a separate
+	call to set_mctrl.
+
+	Locking: port_sem taken.
+	Interrupts: caller dependent.
+*/
+static void uartlite_shutdown(struct uart_port *port)
+{
+	struct uartlite_port *up = (struct uartlite_port *)port;
+
+	DEBUG_PRINTK("uartlite_shutdown()\n");
+	/*
+	 * Disable interrupts from this port
+	 */
+	up->ier = 0;
+	uartlite_set_ier(up, up->ier);
+
+	/*
+	 * Disable break condition and FIFOs
+	 */
+
+	serial_init(up);
+
+#if IS_INT
+	if (!is_real_interrupt(up->port.irq))
+		del_timer_sync(&up->timer);
+	else
+		serial_unlink_irq_chain(up);
+#else
+		del_timer_sync(&up->timer);
+#endif
+}
+/*
+	Change the port parameters, including word length, parity, stop
+	bits.  Update read_status_mask and ignore_status_mask to indicate
+	the types of events we are interested in receiving.  Relevant
+	termios->c_cflag bits are:
+		CSIZE	- word size
+		CSTOPB	- 2 stop bits
+		PARENB	- parity enable
+		PARODD	- odd parity (when PARENB is in force)
+		CREAD	- enable reception of characters (if not set,
+			  still receive characters from the port, but
+			  throw them away.
+		CRTSCTS	- if set, enable CTS status change reporting
+		CLOCAL	- if not set, enable modem status change
+			  reporting.
+	Relevant termios->c_iflag bits are:
+		INPCK	- enable frame and parity error events to be
+			  passed to the TTY layer.
+		BRKINT
+		PARMRK	- both of these enable break events to be
+			  passed to the TTY layer.
+
+		IGNPAR	- ignore parity and framing errors
+		IGNBRK	- ignore break errors,  If IGNPAR is also
+			  set, ignore overrun errors as well.
+	The interaction of the iflag bits is as follows (parity error
+	given as an example):
+	Parity error	INPCK	IGNPAR
+	None		n/a	n/a	character received
+	Yes		n/a	0	character discarded
+	Yes		0	1	character received, marked as
+					TTY_NORMAL
+	Yes		1	1	character received, marked as
+					TTY_PARITY
+
+	Other flags may be used (eg, xon/xoff characters) if your
+	hardware supports hardware "soft" flow control.
+
+	Locking: none.
+	Interrupts: caller dependent.
+	This call must not sleep
+*/
+static void
+uartlite_set_termios(struct uart_port *port, struct termios *termios,
+		       struct termios *old)
+{
+	struct uartlite_port *up = (struct uartlite_port *)port;
+	unsigned char cval ;
+	unsigned long flags;
+
+	DEBUG_PRINTK("uartlite_set_termios()\n");
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		cval = UART_LCR_WLEN5;
+		break;
+	case CS6:
+		cval = UART_LCR_WLEN6;
+		break;
+	case CS7:
+		cval = UART_LCR_WLEN7;
+		break;
+	default:
+	case CS8:
+		cval = UART_LCR_WLEN8;
+		break;
+	}
+
+	if (termios->c_cflag & CSTOPB)
+		cval |= UART_LCR_STOP;
+	if (termios->c_cflag & PARENB)
+		cval |= UART_LCR_PARITY;
+	if (!(termios->c_cflag & PARODD))
+		cval |= UART_LCR_EPAR;
+#ifdef CMSPAR
+	if (termios->c_cflag & CMSPAR)
+		cval |= UART_LCR_SPAR;
+#endif
+
+	/*
+	 * Ok, we're now changing the port state.  Do it with
+	 * interrupts disabled.
+	 */
+	spin_lock_irqsave(&up->port.lock, flags);
+
+	/*
+	 * Update the per-port timeout.
+	 */
+	// uart_update_timeout(uport, termios->c_cflag, 57600);
+
+	up->port.read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
+	if (termios->c_iflag & INPCK)
+		up->port.read_status_mask |= UART_LSR_FE | UART_LSR_PE;
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		up->port.read_status_mask |= UART_LSR_BI;
+
+	/*
+	 * Characteres to ignore
+	 */
+	up->port.ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		up->port.ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
+	if (termios->c_iflag & IGNBRK) {
+		up->port.ignore_status_mask |= UART_LSR_BI;
+		/*
+		 * If we're ignoring parity and break indicators,
+		 * ignore overruns too (for real raw support).
+		 */
+		if (termios->c_iflag & IGNPAR)
+			up->port.ignore_status_mask |= UART_LSR_OE;
+	}
+
+	/*
+	 * ignore all characters if CREAD is not set
+	 */
+	if ((termios->c_cflag & CREAD) == 0)
+		up->port.ignore_status_mask |= UART_LSR_DR;
+
+	/*
+	 * CTS flow control flag and modem status interrupts
+	 */
+	up->ier &= ~UART_IER_MSI;
+	if (UART_ENABLE_MS(&up->port, termios->c_cflag))
+		up->ier |= UART_IER_MSI;
+
+	uartlite_set_ier(up, up->ier);
+
+	uartlite_set_mctrl(&up->port, up->port.mctrl);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+/*
+	Perform any power management related activities on the specified
+	port.  State indicates the new state (defined by ACPI D0-D3),
+	oldstate indicates the previous state.  Essentially, D0 means
+	fully on, D3 means powered down.
+
+	This function should not be used to grab any resources.
+
+	This will be called when the port is initially opened and finally
+	closed, except when the port is also the system console.  This
+	will occur even if CONFIG_PM is not set.
+
+	Locking: none.
+	Interrupts: caller dependent.
+*/
+static void
+uartlite_pm(struct uart_port *port, unsigned int state,
+	      unsigned int oldstate)
+{
+	struct uartlite_port *up = (struct uartlite_port *)port;
+
+	DEBUG_PRINTK("uartlite_pm()\n");
+	// 8250
+	// uartlite_set_sleep(p, state != 0);
+
+	if (up->pm)
+		up->pm(port, state, oldstate);
+}
+
+/*
+ * Resource handling.
+ */
+static int
+uartlite_request_std_resource(struct uartlite_port *up)
+{
+	unsigned int size = 8 << up->port.regshift;
+	int ret = 0;
+
+	switch (up->port.iotype) {
+	case UPIO_MEM:
+		if (!up->port.mapbase)
+			break;
+
+		if (!request_mem_region(up->port.mapbase, size, "serial")) {
+			ret = -EBUSY;
+			break;
+		}
+
+		if (up->port.flags & UPF_IOREMAP) {
+			up->port.membase = ioremap(up->port.mapbase, size);
+			if (!up->port.membase) {
+				release_mem_region(up->port.mapbase, size);
+				ret = -ENOMEM;
+			}
+		}
+		break;
+
+	case UPIO_PORT:
+		if (!request_region(up->port.iobase, size, "serial"))
+			ret = -EBUSY;
+		break;
+	}
+	return ret;
+}
+/*
+	Release any memory and IO region resources currently in use by
+	the port.
+
+	Locking: none.
+	Interrupts: caller dependent.
+*/
+static void uartlite_release_port(struct uart_port *port)
+{
+	struct uartlite_port *up = (struct uartlite_port *)port;
+	unsigned int size = 8 << up->port.regshift;
+
+	DEBUG_PRINTK("uartlite_release_port()\n");
+	switch (up->port.iotype) {
+	case UPIO_MEM:
+		if (!up->port.mapbase)
+			break;
+
+		if (up->port.flags & UPF_IOREMAP) {
+			iounmap(up->port.membase);
+			up->port.membase = NULL;
+		}
+
+		release_mem_region(up->port.mapbase, size);
+		break;
+
+	case UPIO_PORT:
+		release_region(up->port.iobase, size);
+		break;
+	}
+}
+/*
+	Request any memory and IO region resources required by the port.
+	If any fail, no resources should be registered when this function
+	returns, and it should return -EBUSY on failure.
+
+	Locking: none.
+	Interrupts: caller dependent.
+*/
+static int uartlite_request_port(struct uart_port *port)
+{
+	struct uartlite_port *up = (struct uartlite_port *)port;
+	DEBUG_PRINTK("uartlite_request_port()\n");
+	return uartlite_request_std_resource(up);
+}
+/*
+	Perform any autoconfiguration steps required for the port.  `type`
+	contains a bit mask of the required configuration.  UART_CONFIG_TYPE
+	indicates that the port requires detection and identification.
+	up->type should be set to the type found, or PORT_UNKNOWN if
+	no port was detected.
+
+	UART_CONFIG_IRQ indicates autoconfiguration of the interrupt signal,
+	which should be probed using standard kernel autoprobing techniques.
+	This is not necessary on platforms where ports have interrupts
+	internally hard wired (eg, system on a chip implementations).
+
+	Locking: none.
+	Interrupts: caller dependent.
+*/
+static void uartlite_config_port(struct uart_port *port, int flags)
+{
+	struct uartlite_port *up = (struct uartlite_port *)port;
+
+	DEBUG_PRINTK("uartlite_config_port()\n");
+	spin_lock_irqsave(&up->port.lock, flags);
+
+	up->port.type = (PORT_UARTLITE - PORT_UARTLITE_BASE + 1);
+	up->port.fifosize = uart_config[up->port.type].fifo_size;
+
+	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	/* 8250
+	 * Find the region that we can probe for.  This in turn
+	 * tells us whether we can probe for the type of port.
+	 */
+	uartlite_request_std_resource(up);
+}
+/*
+	Verify the new serial port information contained within serinfo is
+	suitable for this port type.
+
+	Locking: none.
+	Interrupts: caller dependent.
+*/
+static int
+uartlite_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	DEBUG_PRINTK("uartlite_verify_port()\n");
+	if (ser->irq >= NR_IRQS || ser->irq < 0 ||
+	    ser->baud_base < 9600 || ser->type < PORT_UNKNOWN ||
+	    ser->type >= ARRAY_SIZE(uart_config))
+		return -EINVAL;
+	return 0;
+}
+/*
+	Return a pointer to a string constant describing the specified
+	port, or return NULL, in which case the string 'unknown' is
+	substituted.
+
+	Locking: none.
+	Interrupts: caller dependent.
+*/
+static const char *
+uartlite_type(struct uart_port *port)
+{
+	int type = port->type;
+
+	DEBUG_PRINTK("uartlite_type()\n");
+	if (type >= ARRAY_SIZE(uart_config))
+		type = 0;
+	return uart_config[type].name;
+}
+
+static struct uart_ops uartlite_pops = {
+	.tx_empty	= uartlite_tx_empty,
+	.set_mctrl	= uartlite_set_mctrl,
+	.get_mctrl	= uartlite_get_mctrl,
+	.stop_tx	= uartlite_stop_tx,
+	.start_tx	= uartlite_start_tx,
+	.stop_rx	= uartlite_stop_rx,
+	.enable_ms	= uartlite_enable_ms,
+	.break_ctl	= uartlite_break_ctl,
+	.startup	= uartlite_startup,
+	.shutdown	= uartlite_shutdown,
+	.set_termios	= uartlite_set_termios,
+	.pm		= uartlite_pm,
+	.type		= uartlite_type,
+	.release_port	= uartlite_release_port,
+	.request_port	= uartlite_request_port,
+	.config_port	= uartlite_config_port,
+	.verify_port	= uartlite_verify_port,
+};
+
+
+static void __init uartlite_init_ports(void)
+{
+	struct uartlite_port *up;
+	static int first = 1;
+	int i;
+
+	DEBUG_PRINTK("uartlite_init_ports()\n");
+	if (!first)
+		return;
+	first = 0;
+
+	for (i = 0; i < UART_NR; i++) {
+		struct uartlite_port *up = &uartlite_ports[i];
+
+		up->port.line = i;
+		spin_lock_init(&up->port.lock);
+
+		init_timer(&up->timer);
+		up->timer.function = uartlite_timeout;
+		up->port.ops = &uartlite_pops;
+	}
+	for (i = 0, up = uartlite_ports; i < ARRAY_SIZE(old_serial_port) && i
< UART_NR; i++, up++) {
+		up->port.iobase   = old_serial_port[i].port;
+		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
+		up->port.uartclk  = old_serial_port[i].baud_base;
+		up->port.flags    = old_serial_port[i].flags;
+		up->port.membase  = old_serial_port[i].iomem_base;
+		up->port.iotype   = old_serial_port[i].io_type;
+		up->port.regshift = old_serial_port[i].iomem_reg_shift;
+		dump_port(&up->port);
+	}
+}
+
+static void __init
+uartlite_register_ports(struct uart_driver *drv)
+{
+	int i;
+
+	DEBUG_PRINTK("uartlite_register_ports()\n");
+	uartlite_init_ports();
+
+	for (i = 0; i < UART_NR; i++) {
+		struct uartlite_port *up = &uartlite_ports[i];
+
+#if 1 // ~8250
+		up->port.line = i;
+		up->port.ops = &uartlite_pops;
+		init_timer(&up->timer);
+		up->timer.function = uartlite_timeout;
+#endif
+		uart_add_one_port(drv, &up->port);
+	}
+}
+
+/*
+ *	Print a string to the serial port trying not to disturb
+ *	any possible real use of the port...
+ *
+ *	The console_lock must be held when we get here.
+ */
+static void
+uartlite_console_write(struct console *co, const char *s, unsigned int
count)
+{
+	struct uartlite_port *up = &uartlite_ports[co->index];
+
+	uartlite_set_ier(up, 0);	// disable interrupts
+	DEBUG_PRINTK("#");
+	while (*s && count-- > 0) {
+		uartlite_putchar(up, *s);
+		if (*s == '\n')
+			uartlite_putchar(up, '\r');
+		s++;
+	}
+
+	/*
+	 *	Finally, wait for transmitter to become empty
+	 *	and restore the IER
+	 */
+	//uartlite_wait_for_xmitr_empty(up);
+	uartlite_set_ier(up, up->ier);	// restore interrupts
+}
+
+static int uartlite_console_setup(struct console *co, char *options)
+{
+	struct uart_port *port;
+	int baud = 9600;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	DEBUG_PRINTK("uartlite_console_setup()\n");
+	/*
+	 * Check whether an invalid uart number has been specified, and
+	 * if so, search for the first available port that does have
+	 * console support.
+	 */
+	if (co->index >= UART_NR)
+		co->index = 0;
+	port = &uartlite_ports[co->index].port;
+	if (!port->iobase && !port->membase)
+		return -ENODEV;
+#if 0 // ~m32r
+	/*
+	 * Temporary fix.
+	 */
+	spin_lock_init(&port->lock);
+#endif
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(port, co, baud, parity, bits, flow);
+}
+
+static struct uart_driver uartlite_reg;
+static struct console uartlite_console = {
+	.name		= "ttyS",
+	.write		= uartlite_console_write,
+	.device		= uart_console_device,
+	.setup		= uartlite_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &uartlite_reg,
+};
+
+static int __init uartlite_console_init(void)
+{
+	struct uartlite_port *port = &uartlite_ports[0];
+
+	DEBUG_PRINTK("uartlite_console_init()\n");
+	DEBUG_PRINTK("uartlite_console.flags %x\n",uartlite_console.flags);
+	serial_reset(port);
+	serial_init(port);
+
+	uartlite_init_ports();
+	register_console(&uartlite_console);
+	return 0;
+}
+console_initcall(uartlite_console_init);
+
+#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
+#define SERIALUARTLITE_CONSOLE	&uartlite_console
+#else
+#define SERIALUARTLITE_CONSOLE	NULL
+#endif
+
+static struct uart_driver uartlite_reg = {
+	.owner			= THIS_MODULE,
+	.driver_name		= "uartlite",
+// 8250	.driver_name		= "serial",
+	.devfs_name		= "tts/",
+	.dev_name		= "ttyS",
+	.major			= TTY_MAJOR,
+	.minor			= 64,
+	.nr			= UART_NR,
+	.cons			= SERIALUARTLITE_CONSOLE,
+};
+
+int __init early_serial_setup(struct uart_port *port)
+{
+	DEBUG_PRINTK("early_serial_setup()\n");
+	dump_port(port);
+	if (port->line >= ARRAY_SIZE(uartlite_ports))
+		return -ENODEV;
+
+// 8250	uartlite_init_ports();
+	uartlite_ports[port->line].port	= *port;
+	uartlite_ports[port->line].port.ops	= &uartlite_pops;
+	return 0;
+}
+
+/**
+ *	uartlite_suspend_port - suspend one serial port
+ *	@line:  serial line number
+ *      @level: the level of port suspension, as per uart_suspend_port
+ *
+ *	Suspend one serial port.
+ */
+void uartlite_suspend_port(int line)
+{
+	uart_suspend_port(&uartlite_reg, &uartlite_ports[line].port);
+}
+
+/**
+ *	uartlite_resume_port - resume one serial port
+ *	@line:  serial line number
+ *      @level: the level of port resumption, as per uart_resume_port
+ *
+ *	Resume one serial port.
+ */
+void uartlite_resume_port(int line)
+{
+	uart_resume_port(&uartlite_reg, &uartlite_ports[line].port);
+}
+
+static int __init uartlite_init(void)
+{
+	int ret, i;
+
+	printk(KERN_INFO "Serial: uartlite driver $Revision: 0.10 $ " "%d
ports\n", (int) UART_NR);
+
+	for (i = 0; i < NR_IRQS; i++)
+		spin_lock_init(&irq_lists[i].lock);
+
+	ret = uart_register_driver(&uartlite_reg);
+#if 1 // ~8250
+	if (ret >= 0)
+		uartlite_register_ports(&uartlite_reg);
+#endif
+
+	DEBUG_PRINTK("%d=uartlite_init()\n",ret);
+	return ret;
+}
+
+static void __exit uartlite_exit(void)
+{
+	int i;
+
+	DEBUG_PRINTK("uartlite_exit()\n");
+	for (i = 0; i < UART_NR; i++)
+		uart_remove_one_port(&uartlite_reg, &uartlite_ports[i].port);
+
+	uart_unregister_driver(&uartlite_reg);
+}
+
+module_init(uartlite_init);
+module_exit(uartlite_exit);
+
+EXPORT_SYMBOL(uartlite_suspend_port);
+EXPORT_SYMBOL(uartlite_resume_port);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Generic uartlite serial driver $Revision: 0.10 $");
+MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
+
+
diff --git a/drivers/serial/uartlite_early.c
b/drivers/serial/uartlite_early.c
new file mode 100644
index 0000000..bcc6220
--- /dev/null
+++ b/drivers/serial/uartlite_early.c
@@ -0,0 +1,259 @@
+/*
+ * Early serial console for Xilinx UartLite devices
+ *
+ * (c) Copyright 2005 DLA Systems
+ *	David H. Lynch Jr. <dhlii@dlasys.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Based on the 8250_early.c driver
+ *
+ * This is for use before the serial driver has initialized, in
+ * particular, before the UARTs have been discovered and named.
+ * Instead of specifying the console device as, e.g., "ttyS0",
+ * we locate the device directly by its MMIO or I/O port address.
+ *
+ * The user can specify the device directly, e.g.,
+ *	console=uart,io,0x3f8,9600n8
+ *	console=uart,mmio,0xff5e0000,115200n8
+ * or platform code can call early_uart_console_init() to set
+ * the early UART device.
+ *
+ * After the normal serial driver starts, we try to locate the
+ * matching ttyS device and start a console there.
+ */
+
+#include <linux/tty.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/serial.h>
+#include <asm/io.h>
+#include <asm/serial.h>
+#include <linux/serial_uartlite.h>
+
+struct early_uart_device {
+	struct uart_port port;
+	char options[16];		/* e.g., 115200n8 */
+	unsigned int baud;
+};
+
+static struct early_uart_device early_device __initdata;
+static int early_uart_registered __initdata;
+
+static _INLINE_ unsigned int __init serial_in(struct uart_port *up, int
offset)
+{
+	unsigned int value;
+	offset <<= up->port.regshift;
+	switch (up->port.iotype) {
+	default:
+		value = (*(volatile unsigned int *) ( up->port.membase + offset));
+		__asm__ __volatile__("eieio");
+		return value;
+	}
+}
+
+static _INLINE_ void
+__init serial_out(struct uart_port *port, int offset, int value)
+{
+	offset <<= up->port.regshift;
+	switch (up->port.iotype) {
+	default:
+ 		(*(volatile unsigned int *)( up->port.membase + offset) =value);
+ 		__asm__ __volatile__("eieio");
+		break;
+
+	}
+}
+
+static void __init wait_for_xmitr(struct uart_port *port)
+{
+	unsigned int status;
+
+	for (;;) {
+		status = serial_in(port, UART_LSR);
+		if ((status & UART_LSR_TXF) == UART_LSR_TXF)
+			return;
+		cpu_relax();
+	}
+}
+
+static void __init putc(struct uart_port *port, unsigned char c)
+{
+	wait_for_xmitr(port);
+	serial_out(port, UART_TX, c);
+}
+
+static void __init early_uart_write(struct console *console, const char
*s, unsigned int count)
+{
+	struct uart_port *port = &early_device.port;
+#if 0
+	unsigned int ier;
+
+	/* Save the IER and disable interrupts */
+	ier = serial_in(port, UART_IER);
+	serial_out(port, UART_IER, 0);
+#endif
+	while (*s && count-- > 0) {
+		putc(port, *s);
+		if (*s == '\n')
+			putc(port, '\r');
+		s++;
+	}
+
+	/* Wait for transmitter to become empty and restore the IER */
+	wait_for_xmitr(port);
+#if 0
+	serial_out(port, UART_IER, ier);
+#endif
+}
+
+static unsigned int __init probe_baud(struct uart_port *port)
+{
+	return 56700;
+}
+
+static void __init init_port(struct early_uart_device *device)
+{
+#if 0
+	struct uart_port *port = &device->port;
+	unsigned int divisor;
+	unsigned char c;
+	serial_out(port, UART_LCR, 0x3);	/* 8n1 */
+	serial_out(port, UART_IER, 0);		/* no interrupt */
+	serial_out(port, UART_FCR, 0);		/* no fifo */
+	serial_out(port, UART_MCR, 0x3);	/* DTR + RTS */
+
+	divisor = port->uartclk / (16 * device->baud);
+	c = serial_in(port, UART_LCR);
+	serial_out(port, UART_LCR, c | UART_LCR_DLAB);
+	serial_out(port, UART_DLL, divisor & 0xff);
+	serial_out(port, UART_DLM, (divisor >> 8) & 0xff);
+	serial_out(port, UART_LCR, c & ~UART_LCR_DLAB);
+#endif
+}
+
+static int __init parse_options(struct early_uart_device *device, char
*options)
+{
+	struct uart_port *port = &device->port;
+	int mapsize = 64;
+	int mmio, length;
+
+	if (!options)
+		return -ENODEV;
+
+	port->uartclk = BASE_BAUD * 16;
+	if (!strncmp(options, "mmio,", 5)) {
+		port->iotype = UPIO_MEM;
+		port->mapbase = simple_strtoul(options + 5, &options, 0);
+		port->membase = ioremap(port->mapbase, mapsize);
+		if (!port->membase) {
+			printk(KERN_ERR "%s: Couldn't ioremap 0x%lx\n",
+				__FUNCTION__, port->mapbase);
+			return -ENOMEM;
+		}
+		mmio = 1;
+	} else if (!strncmp(options, "io,", 3)) {
+		port->iotype = UPIO_PORT;
+		port->iobase = simple_strtoul(options + 3, &options, 0);
+		mmio = 0;
+	} else
+		return -EINVAL;
+
+	if ((options = strchr(options, ','))) {
+		options++;
+		device->baud = simple_strtoul(options, 0, 0);
+		length = min(strcspn(options, " "), sizeof(device->options));
+		strncpy(device->options, options, length);
+	} else {
+		device->baud = probe_baud(port);
+		snprintf(device->options, sizeof(device->options), "%u",
+			device->baud);
+	}
+
+	printk(KERN_INFO "Early serial console at %s 0x%lx (options '%s')\n",
+		mmio ? "MMIO" : "I/O port",
+		mmio ? port->mapbase : (unsigned long) port->iobase,
+		device->options);
+	return 0;
+}
+
+static int __init early_uart_setup(struct console *console, char *options)
+{
+	struct early_uart_device *device = &early_device;
+	int err;
+
+	if (device->port.membase || device->port.iobase)
+		return 0;
+
+	if ((err = parse_options(device, options)) < 0)
+		return err;
+
+	init_port(device);
+	return 0;
+}
+
+static struct console early_uart_console __initdata = {
+	.name	= "uart",
+	.write	= early_uart_write,
+	.setup	= early_uart_setup,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
+};
+
+static int __init early_uart_console_init(void)
+{
+	if (!early_uart_registered) {
+		register_console(&early_uart_console);
+		early_uart_registered = 1;
+	}
+	return 0;
+}
+console_initcall(early_uart_console_init);
+
+int __init early_serial_console_init(char *cmdline)
+{
+	char *options;
+	int err;
+
+	options = strstr(cmdline, "console=uart,");
+	if (!options)
+		return -ENODEV;
+
+	options = strchr(cmdline, ',') + 1;
+	if ((err = early_uart_setup(NULL, options)) < 0)
+		return err;
+	return early_uart_console_init();
+}
+
+static int __init early_uart_console_switch(void)
+{
+	struct early_uart_device *device = &early_device;
+	struct uart_port *port = &device->port;
+	int mmio, line = -1;
+
+	if (!(early_uart_console.flags & CON_ENABLED))
+		return 0;
+
+	/* Try to start the normal driver on a matching line.  */
+	mmio = (port->iotype == UPIO_MEM);
+#if 0
+	line = uartlite_start_console(port, device->options);
+#endif
+	if (line < 0)
+		printk("No ttyS device at %s 0x%lx for console\n",
+			mmio ? "MMIO" : "I/O port",
+			mmio ? port->mapbase :
+			    (unsigned long) port->iobase);
+
+	unregister_console(&early_uart_console);
+	if (mmio)
+		iounmap(port->membase);
+
+	return 0;
+}
+late_initcall(early_uart_console_switch);
+
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f36f221..1434c20 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -53,7 +53,11 @@ extern int dump_fpu (struct pt_regs *, e
 #ifndef elf_addr_t
 #define elf_addr_t unsigned long
 #endif
-
+#if defined(CONFIG_PICO_DEBUG)
+#define DEBUG_PRINTK(fmt...)	_printk(fmt)
+#else
+#define DEBUG_PRINTK(fmt...)	do { } while (0)
+#endif
 /*
  * If we don't support core dumping, then supply a NULL so we
  * don't even try.
@@ -663,6 +667,7 @@ static int load_elf_binary(struct linux_
 			 */
 			SET_PERSONALITY(loc->elf_ex, ibcs2_interpreter);

+			_printk("load_elf_binary(%s)\n",elf_interpreter);
 			interpreter = open_exec(elf_interpreter);
 			retval = PTR_ERR(interpreter);
 			if (IS_ERR(interpreter))
diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index 1edbcca..cbd3c2f 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -15,6 +15,12 @@
 #include <linux/smp_lock.h>
 #include <linux/err.h>
 #include <linux/fs.h>
+#if defined(CONFIG_PICO_DEBUG)
+#define DEBUG_PRINTK(fmt...)	_printk(fmt)
+#else
+#define DEBUG_PRINTK(fmt...)	do { } while (0)
+#endif
+#define _printk printk

 static int load_script(struct linux_binprm *bprm,struct pt_regs *regs)
 {
@@ -85,6 +91,7 @@ static int load_script(struct linux_binp
 	/*
 	 * OK, now restart the process with the interpreter's dentry.
 	 */
+	_printk("load_script(03) interp=%s\n",interp);
 	file = open_exec(interp);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
diff --git a/fs/exec.c b/fs/exec.c
index 22533cc..5ecdbd1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -56,6 +56,12 @@
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 #endif
+#if defined(CONFIG_PICO_DEBUG)
+#define DEBUG_PRINTK(fmt...)	_printk(fmt)
+#else
+#define DEBUG_PRINTK(fmt...)	do { } while (0)
+#endif
+#define _printk printk

 int core_uses_pid;
 char core_pattern[65] = "core";
@@ -1194,6 +1200,7 @@ int do_execve(char * filename,

 	retval = search_binary_handler(bprm,regs);
 	if (retval >= 0) {
+		_printk("do_execve(08)=%d success\n",retval);
 		free_arg_pages(bprm);

 		/* execve success */
diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
index 6c28ae7..7042033 100644
--- a/include/asm-ppc/ibm4xx.h
+++ b/include/asm-ppc/ibm4xx.h
@@ -51,6 +51,9 @@
 #include <platforms/4xx/xilinx_ml300.h>
 #endif

+#if defined(CONFIG_PICO_E12)
+#include <platforms/4xx/pico_e12.h>
+#endif
 #ifndef __ASSEMBLY__

 #ifdef CONFIG_40x
diff --git a/include/asm-ppc/ocp_ids.h b/include/asm-ppc/ocp_ids.h
index 8ae4b31..5a09b94 100644
--- a/include/asm-ppc/ocp_ids.h
+++ b/include/asm-ppc/ocp_ids.h
@@ -27,6 +27,7 @@
 #define OCP_VENDOR_IBM		0x1014
 #define OCP_VENDOR_MOTOROLA	OCP_VENDOR_FREESCALE
 #define	OCP_VENDOR_XILINX	0x10ee
+#define	OCP_VENDOR_PICO 	0x10ef				// pseudo ID
 #define	OCP_VENDOR_UNKNOWN	0xFFFF

 /* device identification */
diff --git a/include/asm-ppc/reg_booke.h b/include/asm-ppc/reg_booke.h
index 00ad9c7..5221970 100644
--- a/include/asm-ppc/reg_booke.h
+++ b/include/asm-ppc/reg_booke.h
@@ -120,6 +120,11 @@ do {						\
 #elif defined(CONFIG_BOOKE)
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE)
 #endif
+#if defined (CONFIG_PICO_E12)
+// The E12 seems to generate spurious Machine Checks - disable them.
+#undef MSR_KERNEL
+#define MSR_KERNEL	(MSR_RI|MSR_IR|MSR_DR|MSR_CE)
+#endif

 /* Special Purpose Registers (SPRNs)*/
 #define SPRN_DECAR	0x036	/* Decrementer Auto Reload Register */
diff --git a/include/asm-ppc/serial.h b/include/asm-ppc/serial.h
index 485a924..976c1f7 100644
--- a/include/asm-ppc/serial.h
+++ b/include/asm-ppc/serial.h
@@ -38,6 +38,8 @@
 #include <asm/mpc85xx.h>
 #elif defined(CONFIG_RADSTONE_PPC7D)
 #include <platforms/radstone_ppc7d.h>
+#elif defined(CONFIG_PICO_E12)
+#include <platforms/4xx/pico_e12.h>
 #else

 /*
diff --git a/include/asm-ppc/xparameters.h b/include/asm-ppc/xparameters.h
index fe4eac6..c5ef611 100644
--- a/include/asm-ppc/xparameters.h
+++ b/include/asm-ppc/xparameters.h
@@ -16,3 +16,6 @@
 #if defined(CONFIG_XILINX_ML300)
 #include <platforms/4xx/xparameters/xparameters_ml300.h>
 #endif
+#if defined(CONFIG_PICO_E12)
+#include <platforms/4xx/xparameters/xparameters_pico_e12.h>
+#endif
diff --git a/include/linux/serial.h b/include/linux/serial.h
index 33fc8cb..19fd052 100644
--- a/include/linux/serial.h
+++ b/include/linux/serial.h
@@ -182,6 +182,8 @@ struct uart_port;	/* forward declaration
 extern int early_serial_setup(struct uart_port *port);
 extern int early_serial_console_init(char *options);
 extern int serial8250_start_console(struct uart_port *port, char *options);
+extern int uartlite_start_console(struct uart_port *port, char *options);
+extern int keyhole_start_console(struct uart_port *port, char *options);

 #endif /* __KERNEL__ */
 #endif /* _LINUX_SERIAL_H */
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index e3710d7..8a67bcb 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -124,6 +124,11 @@
 /* Hilscher netx */
 #define PORT_NETX	71

+/*Xilinx UartLite */
+#define PORT_UARTLITE   72
+
+/*Pico Keyhole */
+#define PORT_KEYHOLE   73
 #ifdef __KERNEL__

 #include <linux/config.h>
diff --git a/include/linux/serial_keyhole.h b/include/linux/serial_keyhole.h
new file mode 100644
index 0000000..d4d7f66
--- /dev/null
+++ b/include/linux/serial_keyhole.h
@@ -0,0 +1,166 @@
+/*
+ *  linux/include/linux/keyhole.h
+ *
+ *  Driver for Pico keyhole psuedo serial ports
+ *
+ *  Author: David H. Lynch Jr. <dhlii@dlasys.net>
+ *  Copyright (C) 2005 DLA Systems
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *  $Id: keyhole.h,v 0.8 2005/12/15 21:32:30 dhlii Exp $
+ */
+#ifndef _LINUX_SERIAL_KEYHOLE_H
+#define _LINUX_SERIAL_KEYHOLE_H
+
+#include <linux/serial_core.h>
+#include <linux/device.h>
+
+struct old_serial_port {
+	unsigned int uart;
+	unsigned int baud_base;
+	unsigned int port;
+	unsigned int irq;
+	unsigned int flags;
+	unsigned char hub6;
+	unsigned char io_type;
+	unsigned char *iomem_base;
+	unsigned short iomem_reg_shift;
+};
+
+
+struct plat_serialkeyhole_port {
+	unsigned long	iobase;		/* io base address */
+	void __iomem	*membase;	/* ioremap cookie or NULL */
+	unsigned long	mapbase;	/* resource base */
+	unsigned int	irq;		/* interrupt number */
+	unsigned char	regshift;	/* register shift */
+	unsigned char	iotype;		/* UPIO_* */
+	unsigned int	flags;		/* UPF_* flags */
+};
+
+/*
+ * This replaces serial_uart_config in include/linux/serial.h
+ */
+struct serial_keyhole_config {
+	const char	*name;
+	unsigned short	fifo_size;
+	unsigned short	tx_loadsz;
+	unsigned char	fcr;
+	unsigned int	flags;
+};
+
+
+
+#define UART_LCR     		0
+#define UART_LCR_WLEN5     	0
+#define UART_LCR_WLEN6     	0
+#define UART_LCR_WLEN7     	0
+#define UART_LCR_WLEN8     	0
+#define UART_LCR_STOP     	0
+#define UART_LCR_PARITY     	0
+#define UART_LCR_EPAR     	0
+#define UART_TX    		1
+#define UART_LSR		2
+//Bits of status fields
+#define XKH_SR_SOM 		(1 << 0)
+#define XKH_SR_EOM 		(1 << 1)
+#define UART_LSR_THRE   	(1 << 2)
+#define UART_LSR_TEMT   	UART_LSR_THRE
+#define UART_LSR_TXF 		(1 << 3)
+#define UART_LSR_DR		0
+#define UART_LSR_BI		0
+#define UART_LSR_PE		0
+#define UART_LSR_FE		0
+#define UART_LSR_OE		0
+#define UART_IIR		2
+#define UART_IIR_NO_INT 	0
+
+#define UART_CAP_FIFO	(1 << 8)	/* UART has FIFO */
+
+#define UART_IER_THRI 	(1 << 0)
+#define UART_IER_RLSI 	(1 << 1)
+#define UART_IER_RDI 	(1 << 2)
+#define UART_IER_MSI 	(1 << 3)
+#if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
+#define _INLINE_ inline
+#else
+#define _INLINE_
+#endif
+
+#define HIGH_BITS_OFFSET ((sizeof(long)-sizeof(int))*8)
+
+//Values of cmd field in the CMND register.
+enum {KH_BEGIN,        //=0 start of packet. u32 breaks out various
cases (see KHC_xxx below)
+      KH_INT,          //=1 an integer (fmtted I/O)
+      KH_LONG,         //=2 a 64 bit integer (fmtted I/O)
+      KH_STR,          //=3 a string (fmtted I/O)
+      KH_STR1,         //=4 a string (fmtted I/O)
+      KH_FMTTED,       //=5 string at start of formatted I/O (fmtted I/O)
+      KH_LOST,         //=6 data was lost between Pico card and driver
+      KH_BLOCK,        //=7 block of data being transferred, datum =
count. Followed by count kh_elem, then kh_end.
+      KH_ELEM,         //=8 element of block.
+      KH_CHAR,         //=9 character.
+      KH_END=15};      //15 end of command sequence (fmtted I/O, block
transfer, etc)
+
+
+enum {KHC_LOOPBACK=0,  //0 used for testing
+      KHC_MISC,        //1 used to set misc register
+      KHC_VERSION,     //2 retrieve version
+      KHC_TIMEOUT,     //3 set timeout of keyhole
+      KHC_LOAD_PROGRAM,//4 load program. u32=starting sector
+      KHC_AUTOLOAD,    //5 setup autoload (testing)
+      KHC_READ_MEM,    //6 read memory at address specified in param[0]
+      KHC_FMTD,        //7 start of formatted I/O
+      KHC_ERR,         //8 error, followed by error # & 32bit value.
+      KHC_BIN,         //9 binary unformatted packet
+      KHC_EXITTEST,    //10 exit from test program
+      KHC_DEBUG,       //11 set debug from param[0] != 0
+      KHC_WRITE_MEM,   //12 param[0] = address, write upto 255 values
into memory (RAM)
+      KHC_CALL_MEM,    //13 call address at param[0]
+      KHC_VERIFY_MEM,  //14 verify data against memory
+      KHC_CLEAR_MEM,   //15
+      KHC_DUMP_MEM,    //16
+      KHC_LASTCMD      //17
+     };
+
+
+// ----------------- PPC Hi-Lo format -----------------
+//The 32bit keyhole datum has the following structure:
+typedef struct {
+	union {
+		unsigned long         u32;
+           	struct {
+			unsigned long asci0:8,       	//.FF000000 bits
+                            	      asci1:8,        	//.00FF0000 bits
+                                      asci2:8,        	//.0000FF00 bits
+                                      asci3:8;        	//.000000FF bits
+               	};
+           	struct {
+			unsigned long nu:16,         	//.FFFF0000 bits unused
+                               packetType:8,   		//.0000FF00 bits
KHC_values
+                               countWords:8;   		//.000000FF bits
number of 36bit words
+          	};
+	};
+} KEYHOLE_DATA;
+
+//The status port contains a counter and the status of the fifo.
+typedef struct {
+	unsigned long cmd   :4,  //command field from other side
+                      wCount:12, //fifo read count
+                      rCount:12, //fifo write count
+                      status:4;  //see enum below.
+} KEYHOLE_STAT;
+
+#if 1
+#define serial_in32(port, offset) (*(volatile unsigned int *)(port +
(offset << 2))); __asm__ __volatile__("eieio");
+#define serial_out32(port, offset, Value) { (*(volatile unsigned int
*)(port + (offset << 2)) = Value); __asm__ __volatile__("eieio");}
+#else
+#define serial_in32(port, offset) (*(volatile unsigned int *)(port +
(offset*4))); __asm__ __volatile__("eieio");
+#define serial_out32(port, offset, Value) { (*(volatile unsigned int
*)(port + (offset*4)) = Value); __asm__ __volatile__("eieio");}
+#endif
+
+#endif
+
diff --git a/include/linux/serial_uartlite.h
b/include/linux/serial_uartlite.h
new file mode 100644
index 0000000..173ed7a
--- /dev/null
+++ b/include/linux/serial_uartlite.h
@@ -0,0 +1,116 @@
+/*
+ *  linux/include/linux/serial_uartlite.h
+ *
+ *  Driver for Pico Xilinx uartlite serial ports
+ *
+ *  Author: David H. Lynch Jr. <dhlii@dlasys.net>
+ *  Copyright (C) 2005 DLA Systems
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *  $Id: uartlite.h,v 0.8 2005/12/15 21:32:30 dhlii Exp $
+ */
+#ifndef _LINUX_SERIAL_UARTLITE_H
+#define _LINUX_SERIAL_UARTLITE_H
+
+#include <linux/serial_core.h>
+#include <linux/device.h>
+#include <linux/config.h>
+
+struct old_serial_port {
+	unsigned int uart;
+	unsigned int baud_base;
+	unsigned int port;
+	unsigned int irq;
+	unsigned int flags;
+	unsigned char hub6;
+	unsigned char io_type;
+	unsigned char *iomem_base;
+	unsigned short iomem_reg_shift;
+};
+
+
+struct plat_serialuartlite_port {
+	unsigned long	iobase;		/* io base address */
+	void __iomem	*membase;	/* ioremap cookie or NULL */
+	unsigned long	mapbase;	/* resource base */
+	unsigned int	irq;		/* interrupt number */
+	unsigned int	uartclk;	/* UART clock rate */
+	unsigned char	regshift;	/* register shift */
+	unsigned char	iotype;		/* UPIO_* */
+	unsigned char	hub6;
+	unsigned int	flags;		/* UPF_* flags */
+};
+
+/*
+ * This replaces serial_uart_config in include/linux/serial.h
+ */
+struct serial_uartlite_config {
+	const char	*name;
+	unsigned short	fifo_size;
+	unsigned short	tx_loadsz;
+	unsigned int	flags;
+};
+
+
+#define UART_RX			0
+#define UART_TX			1
+#define UART_LSR		2
+#define UART_LSR_DR		(1 << (31-31))
+#define UART_LSR_RXF		(1 << (31-30))
+#define UART_LSR_THRE		(1 << (31-29))
+#define UART_LSR_TEMT		(1 << (31-29))
+#define UART_LSR_TXF		(1 << (31-28))
+#define UART_LSR_OE		(1 << (31-26))
+#define UART_LSR_FE		(1 << (31-25))
+#define UART_LSR_PE		(1 << (31-24))
+#define UART_LSR_BI		0
+
+#define UART_IIR		2
+#define UART_IIR_NO_INT		(1 << (31-27))
+#undef  UART_IIR_NO_INT
+#define UART_IIR_NO_INT		0
+#define UART_MSR		2
+
+#define UART_FCR		3
+#define UART_LCR		3
+#define UART_LCR_TXF    	(1 << (31-30))
+#define UART_LCR_RXF    	(1 << (31-30))
+#define UART_LCR_WLEN5		0
+#define UART_LCR_WLEN6		0
+#define UART_LCR_WLEN7		0
+#define UART_LCR_WLEN8		0
+#define UART_LCR_STOP		0
+#define UART_LCR_PARITY 	0
+#define UART_LCR_EPAR   	0
+#define UART_IER		3
+#define UART_IER_THRI		(1 << (31-27))
+#define UART_IER_RLSI		(1 << (31-27))
+#define UART_IER_MSI		0
+#define UART_IER_RDI		(1 << (31-27))
+
+#define UART_CAP_FIFO	(1 << 8)	/* UART has FIFO */
+
+#if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
+#define _INLINE_ inline
+#else
+#define _INLINE_
+#endif
+
+#define XPAR_UARTLITE 0x40600000
+
+// #define HIGH_BITS_OFFSET ((sizeof(long)-sizeof(int))*8)
+
+//#define XUL_STATUS_REG_OFFSET           8   /* status register, read
only */
+//#define XUL_SR_TX_FIFO_FULL             0x08    /* transmit FIFO full */
+//#define XUL_TX_FIFO_OFFSET              4   /* transmit FIFO, write
only */
+
+// #define serial_in32(port, offset) (*(volatile unsigned int *)(port +
(offset << 2))); __asm__ __volatile__("eieio");
+// #define serial_out32(port, offset, Value) { (*(volatile unsigned int
*)(port) = Value); __asm__ __volatile__("eieio");}
+#define serial_in32(port, offset) (*(volatile unsigned long *)(port +
(offset << 2))); __asm__ __volatile__ ("eieio");
+#define serial_out32(port, offset, value) { (*(volatile unsigned long
*)(port + (offset << 2)) = value); __asm__ __volatile__ ("eieio"); }
+
+#endif
+
diff --git a/init/main.c b/init/main.c
index 27f97f9..08e83be 100644
--- a/init/main.c
+++ b/init/main.c
@@ -54,6 +54,12 @@
 #include <asm/setup.h>
 #include <asm/sections.h>

+#if defined(CONFIG_PICO_DEBUG)
+#define DEBUG_PRINTK(fmt...)	_printk(fmt)
+#else
+#define DEBUG_PRINTK(fmt...)	do { } while (0)
+#endif
+#define _printk printk
 /*
  * This is one of the first .c files built. Error out early
  * if we have compiler trouble..
@@ -634,8 +640,10 @@ static void do_pre_smp_initcalls(void)

 static void run_init_process(char *init_filename)
 {
+	_printk("run_init_process(%s)\n",init_filename);
 	argv_init[0] = init_filename;
 	execve(init_filename, argv_init, envp_init);
+	_printk("<run_init_process()\n");
 }

 static inline void fixup_cpu_present_map(void)
@@ -658,6 +666,7 @@ static inline void fixup_cpu_present_map

 static int init(void * unused)
 {
+	int err = 0;
 	lock_kernel();
 	/*
 	 * init can run on any cpu.
@@ -715,11 +724,27 @@ static int init(void * unused)
 	system_state = SYSTEM_RUNNING;
 	numa_default_policy();

-	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
+	if ((err = sys_open((const char __user *) "/dev/console", O_RDWR, 0))
< 0) {
 		printk(KERN_WARNING "Warning: unable to open an initial console.\n");
-
+		_printk("Warning: unable to open an initial console. %d\n", err);
+	}
+	(void) sys_dup(0);
 	(void) sys_dup(0);
 	(void) sys_dup(0);
+	(void) sys_dup(0);
+
+	// sys_write(1, "This is a console test\n", 23);
+	// sys_write(2, "so is this\n",11);
+
+	//run_init_process("/hello");
+	//run_init_process("/hello-ppc");
+
+	run_init_process("/bin/sash");
+	// run_init_process("/bin/ash.static"); // sort of works
+	// run_init_process("/bin/ash");
+	// run_init_process("/bin/bash");
+	// run_init_process("/bin/sh");
+	// run_init_process("/init.rc");

 	if (ramdisk_execute_command) {
 		run_init_process(ramdisk_execute_command);
diff --git a/kernel/exit.c b/kernel/exit.c
diff --git a/pico b/pico
new file mode 120000
index 0000000..fd8b54b
--- /dev/null
+++ b/pico
@@ -0,0 +1 @@
+/usr/src/linux-pico/pico
\ No newline at end of file
