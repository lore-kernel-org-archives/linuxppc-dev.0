Return-Path: <dhlii@comcast.net>
Received: from rwcrmhc12.comcast.net (rwcrmhc14.comcast.net [216.148.227.154])
	by ozlabs.org (Postfix) with ESMTP id CFA2B6890A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jan 2006 08:40:46 +1100 (EST)
Message-ID: <43C186D2.10505@comcast.net>
Date: Sun, 08 Jan 2006 16:40:34 -0500
From: "David H. Lynch Jr." <dhlii@comcast.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <11359385991901-git-send-email-grant.likely@secretlab.ca>	<43B5E37A.4020008@dlasys.net>	<43B601CC.1000102@secretlab.ca>	<43B6B32A.5060606@dlasys.net>
	<43B95448.3040407@secretlab.ca>
In-Reply-To: <43B95448.3040407@secretlab.ca>
Content-Type: multipart/mixed; boundary="------------050805070302060706010908"
Subject: [RFC] Patches for Xilinx UartLite to 2.6.15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050805070302060706010908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This is against
git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Signed-off-by: David H. Lynch Jr. <dhlii@dlasystems.net>


	Status/Overview:

	This is separated out from a more substantial effort to port Linux to
the Pico E12 - a Xilinx Virtex-4 based PPC405 on a compact flash card.
In that environment the UartLite support code is tested from  boot
support through to a working beta serial/console driver.
	There was a Xilinx UartLite driver done by others (Xilinx or
MontaVista) for Linux 2.4. This is not based on that. This is based
primarily on the 8250 support throughout the kernel - on the assumption
that it is the heaviest used and therefore most likely well tested and
debugged code. However the 8250 is also about the most complex serial
driver with the largest set of special cases, features and work arrounds
- almost none of which are relevant to the Xilinx UartLite. I separately
relied on the m32r_sio driver as an example of a driver that had all the
features I needed for the UartLite without the excess of the 8250. The
relationship of this driver to those two should deliberately be very
obvious on inspection. Where possible defines, registers, functions, ...
were all named to match those of the 8250.
	This driver is only currently tested in the Pico E12, with a single
UartLite without interrupts. I do not currently have access to other
systems with multiple Xilinx UartLites. It is intended to work anywhere
the Xilinux UartLite can be implemented in whatever numbers are desired
- as such it should work interrupt driven for 4 UartLites in uCLinux for
the MicroBlaze, but I have no way to test that. The know working
environment is a single polled UartLite on a PPC405 in a Pico E12.

	Further I am new to Linux porting, and the whole Kernel developers tool
suite and culture. I have tried to make this as conforming to those
norms as possible, but there are certainly ways I have failed. I have
extracted the UartLite driver from the rest of the Pico E12 effort and I
am preparing to submit it as a separate patch. I have verified that it
builds outside of the constraints of a Pico E12. But I have no way of
testing it outside that environment. I hope to be submitting additional
patches for the Virtex-4, the Pico E-12 and the E-12 unique hardware, as
I have them ready.


# Updated but not checked in:
#   (will commit)
#
#	modified: arch/ppc/boot/common/misc-common.c
#	modified: arch/ppc/boot/simple/Makefile
#	modified: arch/ppc/boot/simple/misc-embedded.c
#	modified: arch/ppc/boot/simple/misc.c
#	new file: arch/ppc/boot/simple/uartlite_tty.c
#	modified: arch/ppc/syslib/Makefile
#	modified: arch/ppc/syslib/ppc4xx_setup.c
#	new file: arch/ppc/syslib/uartlite.h
#	new file: arch/ppc/syslib/uartlite_dbg.c
#	modified: drivers/serial/Kconfig
#	modified: drivers/serial/Makefile
#	new file: drivers/serial/uartlite.c
#	new file: drivers/serial/uartlite_early.c
#	modified: include/linux/serial.h
#	modified: include/linux/serial_core.h
#	new file: include/linux/serial_uartlite.h
#
#


--------------050805070302060706010908
Content-Type: text/plain;
 name="uartlite.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uartlite.diff"

diff --git a/arch/ppc/boot/common/misc-common.c b/arch/ppc/boot/common/misc-common.c
index e79e6b3..883bbc7 100644
--- a/arch/ppc/boot/common/misc-common.c
+++ b/arch/ppc/boot/common/misc-common.c
@@ -60,7 +60,8 @@ unsigned char *ISA_io = NULL;
 
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
 extern unsigned long com_port;
 
 extern int serial_tstc(unsigned long com_port);
@@ -83,7 +84,8 @@ int tstc(void)
 {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE) 
 	if(keyb_present)
 		return (CRT_tstc() || serial_tstc(com_port));
 	else
@@ -98,7 +100,8 @@ int getc(void)
 	while (1) {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE) 
 		if (serial_tstc(com_port))
 			return (serial_getc(com_port));
 #endif /* serial console */
@@ -115,7 +118,8 @@ putc(const char c)
 
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE) 
 	serial_putc(com_port, c);
 	if ( c == '\n' )
 		serial_putc(com_port, '\r');
@@ -164,7 +168,8 @@ void puts(const char *s)
 	while ( ( c = *s++ ) != '\0' ) {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE) 
 	        serial_putc(com_port, c);
 	        if ( c == '\n' ) serial_putc(com_port, '\r');
 #endif /* serial console */
diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
index 9533f8d..917f3fd 100644
--- a/arch/ppc/boot/simple/Makefile
+++ b/arch/ppc/boot/simple/Makefile
@@ -204,6 +204,7 @@ boot-$(CONFIG_8260)		+= m8260_tty.o
 endif
 boot-$(CONFIG_SERIAL_MPC52xx_CONSOLE)	+= mpc52xx_tty.o
 boot-$(CONFIG_SERIAL_MPSC_CONSOLE)	+= mv64x60_tty.o
+boot-$(CONFIG_SERIAL_UARTLITE_CONSOLE)	+= uartlite_tty.o
 
 LIBS				:= $(common)/lib.a $(bootlib)/lib.a
 ifeq ($(CONFIG_PPC_PREP),y)
diff --git a/arch/ppc/boot/simple/misc-embedded.c b/arch/ppc/boot/simple/misc-embedded.c
index 3865f3f..c0e7b54 100644
--- a/arch/ppc/boot/simple/misc-embedded.c
+++ b/arch/ppc/boot/simple/misc-embedded.c
@@ -90,7 +90,7 @@ load_kernel(unsigned long load_addr, int
 	 * initialize the serial console port.
 	 */
 	embed_config(&bp);
-#if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE)
+#if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) || defined(CONFIG_SERIAL_UARTLITE_CONSOLE) 
 	com_port = serial_init(0, bp);
 #endif
 
@@ -267,7 +267,7 @@ load_kernel(unsigned long load_addr, int
 		rec = (struct bi_record *)((unsigned long)rec + rec->size);
 	}
 	puts("Now booting the kernel\n");
-#if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE)
+#if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) || defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
 	serial_close(com_port);
 #endif
 
diff --git a/arch/ppc/boot/simple/misc.c b/arch/ppc/boot/simple/misc.c
index f415d6c..26666c7 100644
--- a/arch/ppc/boot/simple/misc.c
+++ b/arch/ppc/boot/simple/misc.c
@@ -51,7 +51,8 @@
 #if (defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_VGA_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)) \
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)) \
 	&& !defined(CONFIG_GEMINI)
 #define INTERACTIVE_CONSOLE	1
 #endif
diff --git a/arch/ppc/boot/simple/uartlite_tty.c b/arch/ppc/boot/simple/uartlite_tty.c
new file mode 100644
index 0000000..d08e0f8
--- /dev/null
+++ b/arch/ppc/boot/simple/uartlite_tty.c
@@ -0,0 +1,104 @@
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *  $Id: uartlite.c,v 0.10 2005/12/14 10:03:27 dhlii Exp $
+ *
+ * heavily based on the equivalent 8250 code.
+ * serial_getc is untested
+ *  
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
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index 5b7f2b8..004b0ec 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -86,6 +86,9 @@ endif
 ifeq ($(CONFIG_SERIAL_MPSC_CONSOLE),y)
 obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= mv64x60_dbg.o
 endif
+ifeq ($(CONFIG_SERIAL_UARTLITE_CONSOLE),y)
+obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= uartlite_dbg.o
+endif
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_MPC10X_BRIDGE)	+= mpc10x_common.o ppc_sys.o
 obj-$(CONFIG_MPC10X_OPENPIC)	+= open_pic.o
diff --git a/arch/ppc/syslib/ppc4xx_setup.c b/arch/ppc/syslib/ppc4xx_setup.c
index e83a83f..815bac3 100644
--- a/arch/ppc/syslib/ppc4xx_setup.c
+++ b/arch/ppc/syslib/ppc4xx_setup.c
@@ -41,7 +41,11 @@
 #include <asm/pci-bridge.h>
 #include <asm/bootinfo.h>
 
+#if defined(CONFIG_SERIAL_8250)
 #include <syslib/gen550.h>
+#elif defined(CONFIG_SERIAL_UARTLITE)
+#include <syslib/uartlite.h>
+#endif
 
 /* Function Prototypes */
 extern void abort(void);
@@ -270,7 +274,11 @@ ppc4xx_init(unsigned long r3, unsigned l
 	ppc_md.setup_io_mappings = ppc4xx_map_io;
 
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
+#if defined(CONFIG_SERIAL_8250)
 	ppc_md.progress = gen550_progress;
+#elif defined(CONFIG_SERIAL_UARTLITE)
+	ppc_md.progress = uartlite_progress;
+#endif
 #endif
 
 #if defined(CONFIG_PCI) && defined(CONFIG_IDE)
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
index 0000000..d666122
--- /dev/null
+++ b/arch/ppc/syslib/uartlite_dbg.c
@@ -0,0 +1,162 @@
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *  $Id: uartlite.c,v 0.10 2005/12/14 10:03:27 dhlii Exp $
+ *
+ *  Heavily based on equivalent 8250 code.
+ *  uartlite_getc() is untested.
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
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 812bae6..eb8b60a 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -396,6 +396,28 @@ config SERIAL_MPSC_CONSOLE
 	help
 	  Say Y here if you want to support a serial console on a Marvell MPSC.
 
+config SERIAL_UARTLITE
+	bool "Xilinx UARTLITE serial port support"
+	depends on PPC32
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
 config SERIAL_PXA
 	bool "PXA serial port support"
 	depends on ARM && ARCH_PXA
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index d7c7c71..54c5343 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -14,9 +14,11 @@ serial-8250-$(CONFIG_HP300) += 8250_hp30
 obj-$(CONFIG_SERIAL_CORE) += serial_core.o
 obj-$(CONFIG_SERIAL_21285) += 21285.o
 obj-$(CONFIG_SERIAL_8250) += 8250.o $(serial-8250-y)
+obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o 
 obj-$(CONFIG_SERIAL_8250_CS) += serial_cs.o
 obj-$(CONFIG_SERIAL_8250_ACORN) += 8250_acorn.o
 obj-$(CONFIG_SERIAL_8250_CONSOLE) += 8250_early.o
+#obj-$(CONFIG_SERIAL_UARTLITE_CONSOLE) += uartlite_early.o
 obj-$(CONFIG_SERIAL_8250_FOURPORT) += 8250_fourport.o
 obj-$(CONFIG_SERIAL_8250_ACCENT) += 8250_accent.o
 obj-$(CONFIG_SERIAL_8250_BOCA) += 8250_boca.o
diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
new file mode 100644
index 0000000..7efe233
--- /dev/null
+++ b/drivers/serial/uartlite.c
@@ -0,0 +1,1333 @@
+/*
+ *  linux/drivers/serial/uartlite.c
+ *
+ *  Driver for uartlite ports
+ *
+ *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
+ *  Based on drivers/serial/8250.c.
+ *  Based on drivers/serial/m32r_sio.c.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
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
+ * The Xilinx UartLite is a fairly simple fixed Baud Rate Uart with a 16 byte Fifo
+ * This driver borrows very heavily from drivers/serial/8250.c on the 
+ * assumption that the 8250 driver is likely to be very heavily tested.
+ * As there is significant complexity to the 8250 driver that has no meaning for the 
+ * Xilinx UartLite I have relied on drivers/serial/m32r_sio.c to work out simplifications.
+ * as much as possible functions, UART registers and bits where named to match the 8250.
+ * 
+ */
+
+
+#define tx_enabled(port)	((port)->unused[0])
+#define rx_enabled(port)	((port)->unused[1])
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
+
+#define IS_INT 0			// enable interupt driven - untested
+#define IS_TXI 0			// interupt driven sends
+
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
+#define UARTLITE_ISR_PASS_LIMIT	256
+#define PORT_UARTLITE_BASE	PORT_UARTLITE
+#define PORT_INDEX(x)	(x - PORT_UARTLITE_BASE + 1)
+
+/*
+ * We default to -1 (0 is actually used) for the "no irq" hack.   Some
+ * machine types want others as well - they're free
+ * to redefine this in their header file.
+ */
+#define is_real_interrupt(irq)	((irq) >= 0)
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
+	[PORT_INDEX(PORT_UARTLITE)] = {
+		.name		= "uartlite",
+		.fifo_size	= 16,
+		.flags		= UART_CAP_FIFO,
+	},
+};
+
+static _INLINE_ unsigned int serial_in(struct uartlite_port *up, int offset)
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
+void
+uartlite_putc(struct uartlite_port *up, unsigned char c)
+{
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
+
+static void serial_reset( struct uartlite_port *up)
+{
+	(void) serial_in(up, UART_LSR);
+	(void) serial_in(up, UART_RX);
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
+		// there is no FIFO enable/disable for the Uart Lite
+	}
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
+	// struct uartlite_port *up = (struct uartlite_port *)port;
+
+	if (tx_enabled(port)) {
+		// disable_irq(IRQ_XXX);	
+		tx_enabled(port) = 0;
+	}
+}
+static _INLINE_ void transmit_chars(struct uartlite_port *up)
+{
+	struct circ_buf *xmit = &up->port.info->xmit;
+	int count;
+
+	if (up->port.x_char) {
+		uartlite_putc(up, up->port.x_char);
+		up->port.icount.tx++;
+		up->port.x_char = 0;
+		return;
+	}
+	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
+		uartlite_stop_tx(&up->port);
+		return;
+	}
+
+	count = up->port.fifosize;
+	do {
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
+#if IS_TXI
+	struct circ_buf *xmit = &up->port.info->xmit;
+#endif
+	unsigned long flags;
+	
+
+	if (!tx_enabled(port)) {
+		// enable_irq(IRQ_XXX);
+		tx_enabled(port) = 1;
+	}
+#if IS_TXI
+	if (!(up->ier & UART_IER_THRI)) {				// are TX interupts enabled ?
+	
+		up->ier |= UART_IER_THRI;				// enable them
+		uartlite_set_ier(up, up->ier);
+
+		uartlite_putc(up, xmit->buf[xmit->tail]);		// send 1 character to kick things
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
+	struct uartlite_port *up = (struct uartlite_port *)port;
+
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
+	if (status & UART_LSR_DR)
+		receive_chars(up, &status, regs);
+#if IS_TXI
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
+	iir = serial_in(up, UART_IIR);
+	if (!(iir & UART_IIR_NO_INT)) {
+		spin_lock(&up->port.lock);
+		uartlite_handle_port(up, NULL);
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
+static unsigned int uartlite_tx_empty(struct uart_port *port)
+{
+	struct uartlite_port *up = (struct uartlite_port *)port;
+	unsigned long flags;
+	unsigned int ret;
+
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
+	int retval = 0;
+
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
+	{
+		unsigned int timeout = up->port.timeout;
+
+		timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
+
+		up->timer.data = (unsigned long)up;
+		mod_timer(&up->timer, jiffies + timeout);
+	}
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
+	return retval;
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
+	static int first = 1;
+	int i;
+
+	if (!first)
+		return;
+	first = 0;
+
+	for (i = 0; i < UART_NR; i++) {
+		if (old_serial_port[i].type == PORT_UARTLITE) {
+			struct uartlite_port *up = &uartlite_ports[i];
+			up->port.line = i;
+			up->port.iobase   = old_serial_port[i].port;
+			up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
+			up->port.uartclk  = old_serial_port[i].baud_base;
+			up->port.flags    = old_serial_port[i].flags;
+			up->port.membase  = old_serial_port[i].iomem_base;
+			up->port.iotype   = old_serial_port[i].io_type;
+			up->port.regshift = old_serial_port[i].iomem_reg_shift;
+			up->port.type   = old_serial_port[i].type;
+			up->port.ops = &uartlite_pops;
+			spin_lock_init(&up->port.lock);
+			init_timer(&up->timer);
+			up->timer.function = uartlite_timeout;
+			// dump_port(&up->port);
+		}
+	}
+}
+
+static void __init
+uartlite_register_ports(struct uart_driver *drv)
+{
+	int i;
+
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
+uartlite_console_write(struct console *co, const char *s, unsigned int count)
+{
+	struct uartlite_port *up = &uartlite_ports[co->index];
+
+	uartlite_set_ier(up, 0);	// disable interrupts
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
+	// dump_port(port);
+	if (port->line >= ARRAY_SIZE(uartlite_ports))
+		return -ENODEV;
+
+	uartlite_init_ports();
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
+	printk(KERN_INFO "Serial: uartlite driver $Revision: 0.10 $ " "%d ports\n", (int) UART_NR);
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
+	return ret;
+}
+
+static void __exit uartlite_exit(void)
+{
+	int i;
+
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
diff --git a/drivers/serial/uartlite_early.c b/drivers/serial/uartlite_early.c
new file mode 100644
index 0000000..1e3696b
--- /dev/null
+++ b/drivers/serial/uartlite_early.c
@@ -0,0 +1,233 @@
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
+static _INLINE_ unsigned int __init serial_in(struct uart_port *up, int offset)
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
+static void __init early_uart_write(struct console *console, const char *s, unsigned int count)
+{
+	struct uart_port *port = &early_device.port;
+	while (*s && count-- > 0) {
+		putc(port, *s);
+		if (*s == '\n')
+			putc(port, '\r');
+		s++;
+	}
+
+	/* Wait for transmitter to become empty and restore the IER */
+	wait_for_xmitr(port);
+}
+
+static unsigned int __init probe_baud(struct uart_port *port)
+{
+	return 56700;
+}
+
+static void __init init_port(struct early_uart_device *device)
+{
+}
+
+static int __init parse_options(struct early_uart_device *device, char *options)
+{
+	struct uart_port *port = &device->port;
+	int mapsize = 64;
+	int mmio, length;
+
+	if (!options)
+		return -ENODEV;
+
+	port->uartclk = BASE_BAUD ;
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
diff --git a/include/linux/serial.h b/include/linux/serial.h
index 33fc8cb..99b8263 100644
--- a/include/linux/serial.h
+++ b/include/linux/serial.h
@@ -182,6 +182,7 @@ struct uart_port;	/* forward declaration
 extern int early_serial_setup(struct uart_port *port);
 extern int early_serial_console_init(char *options);
 extern int serial8250_start_console(struct uart_port *port, char *options);
+extern int uartlite_start_console(struct uart_port *port, char *options);
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_SERIAL_H */
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index e3710d7..053dba4 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -124,6 +124,9 @@
 /* Hilscher netx */
 #define PORT_NETX	71
 
+/*Xilinx UartLite */
+#define PORT_UARTLITE   72
+
 #ifdef __KERNEL__
 
 #include <linux/config.h>
diff --git a/include/linux/serial_uartlite.h b/include/linux/serial_uartlite.h
new file mode 100644
index 0000000..28f92e6
--- /dev/null
+++ b/include/linux/serial_uartlite.h
@@ -0,0 +1,112 @@
+/*
+ *  linux/include/linux/serial_uartlite.h
+ *
+ *  Driver definitions for Xilinx uartlite serial ports
+ *
+ *  Author: David H. Lynch Jr. <dhlii@dlasys.net>
+ *  Copyright (C) 2005 DLA Systems
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *  $Id: uartlite.h,v 0.8 2005/12/15 21:32:30 dhlii Exp $
+ *
+ * Register names bit definititions etc are deliberately named 
+ * the same as the 8250
+ *  
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
+	unsigned int type;
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
+#define UART_LSR_BI		0				// UartLite has no Break Indicator
+
+#define UART_IIR		2
+#define UART_IIR_NO_INT		(1 << (31-27))
+#undef  UART_IIR_NO_INT
+#define UART_IIR_NO_INT		0				// Not present on UartLite
+#define UART_MSR		2
+
+#define UART_FCR		3
+#define UART_LCR		3
+#define UART_LCR_TXF    	(1 << (31-30))
+#define UART_LCR_RXF    	(1 << (31-30))
+#define UART_LCR_WLEN5		0				// UartLite serial parameters are fixed
+#define UART_LCR_WLEN6		0
+#define UART_LCR_WLEN7		0
+#define UART_LCR_WLEN8		0
+#define UART_LCR_STOP		0
+#define UART_LCR_PARITY 	0
+#define UART_LCR_EPAR   	0
+#define UART_IER		3
+#define UART_IER_THRI		(1 << (31-27))
+#define UART_IER_RLSI		(1 << (31-27))
+#define UART_IER_MSI		0				// UartLite has no Modem Status
+#define UART_IER_RDI		(1 << (31-27))
+
+#define UART_CAP_FIFO		(1 << 8)			/* UART has FIFO */
+
+#if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
+#define _INLINE_ inline
+#else
+#define _INLINE_
+#endif
+
+// #define XPAR_UARTLITE 0x40600000
+
+#define serial_in32(port, offset) (*(volatile unsigned long *)(port + (offset << 2))); __asm__ __volatile__ ("eieio");
+#define serial_out32(port, offset, value) { (*(volatile unsigned long *)(port + (offset << 2)) = value); __asm__ __volatile__ ("eieio"); }
+
+#endif // _LINUX_SERIAL_UARTLITE_H
+

--------------050805070302060706010908--
