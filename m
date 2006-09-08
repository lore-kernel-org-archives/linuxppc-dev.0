Return-Path: <mgreer@mvista.com>
Date: Thu, 7 Sep 2006 20:39:11 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 4/6] bootwrapper: Add non-OF serial console support
Message-ID: <20060908033911.GD5203@mag.az.mvista.com>
References: <20060719231244.GE3887@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060719231244.GE3887@mag.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for serial I/O to the bootwrapper.

It is broken into 2 layers.  The first layer is generic serial
operations that calls uart-specific routines to do the actual I/O.
The second layer contains support for a 16550 compatible uart.

The division allows support for other serial devices to be easily
added in the future (e.g., the Marvell MPSC and the Freescale CPM).

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

 io.h      |   53 ++++++++++++++++++++
 ns16550.c |   81 +++++++++++++++++++++++++++++++
 serial.c  |  159 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 util.S    |  101 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 394 insertions(+)
--

diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h
new file mode 100644
index 0000000..32974ed
--- /dev/null
+++ b/arch/powerpc/boot/io.h
@@ -0,0 +1,53 @@
+#ifndef _IO_H
+#define __IO_H
+/*
+ * Low-level I/O routines.
+ *
+ * Copied from <file:include/asm-powerpc/io.h> (which has no copyright)
+ */
+static inline int in_8(const volatile unsigned char *addr)
+{
+	int ret;
+
+	__asm__ __volatile__("lbz%U1%X1 %0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "m" (*addr));
+	return ret;
+}
+
+static inline void out_8(volatile unsigned char *addr, int val)
+{
+	__asm__ __volatile__("stb%U0%X0 %1,%0; sync"
+			     : "=m" (*addr) : "r" (val));
+}
+
+static inline unsigned in_le32(const volatile unsigned *addr)
+{
+	unsigned ret;
+
+	__asm__ __volatile__("lwbrx %0,0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "r" (addr), "m" (*addr));
+	return ret;
+}
+
+static inline unsigned in_be32(const volatile unsigned *addr)
+{
+	unsigned ret;
+
+	__asm__ __volatile__("lwz%U1%X1 %0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "m" (*addr));
+	return ret;
+}
+
+static inline void out_le32(volatile unsigned *addr, int val)
+{
+	__asm__ __volatile__("stwbrx %1,0,%2; sync" : "=m" (*addr)
+			     : "r" (val), "r" (addr));
+}
+
+static inline void out_be32(volatile unsigned *addr, int val)
+{
+	__asm__ __volatile__("stw%U0%X0 %1,%0; sync"
+			     : "=m" (*addr) : "r" (val));
+}
+
+#endif /* _IO_H */
diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
new file mode 100644
index 0000000..06a6d32
--- /dev/null
+++ b/arch/powerpc/boot/ns16550.c
@@ -0,0 +1,81 @@
+/*
+ * 16550 serial console support.
+ *
+ * Original copied from <file:arch/ppc/boot/common/ns16550.c>
+ * (which had no copyright)
+ * Modifications: 2006 (c) MontaVista Software, Inc.
+ *
+ * Modified by: Mark A. Greer <mgreer@mvista.com>
+ */
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "string.h"
+#include "stdio.h"
+#include "io.h"
+#include "ops.h"
+
+#define UART_DLL	0	/* Out: Divisor Latch Low */
+#define UART_DLM	1	/* Out: Divisor Latch High */
+#define UART_FCR	2	/* Out: FIFO Control Register */
+#define UART_LCR	3	/* Out: Line Control Register */
+#define UART_MCR	4	/* Out: Modem Control Register */
+#define UART_LSR	5	/* In:  Line Status Register */
+#define UART_LSR_THRE	0x20	/* Transmit-hold-register empty */
+#define UART_LSR_DR	0x01	/* Receiver data ready */
+#define UART_MSR	6	/* In:  Modem Status Register */
+#define UART_SCR	7	/* I/O: Scratch Register */
+
+static unsigned char *reg_base;
+static u8 reg_shift;
+
+static int ns16550_open(void)
+{
+	out_8(reg_base + (UART_FCR << reg_shift), 0x06);
+	return 0;
+}
+
+static void ns16550_putc(unsigned char c)
+{
+	while ((in_8(reg_base + (UART_LSR << reg_shift)) & UART_LSR_THRE) == 0);
+	out_8(reg_base, c);
+}
+
+static unsigned char ns16550_getc(void)
+{
+	while ((in_8(reg_base + (UART_LSR << reg_shift)) & UART_LSR_DR) == 0);
+	return in_8(reg_base);
+}
+
+static u8 ns16550_tstc(void)
+{
+	return ((in_8(reg_base + (UART_LSR << reg_shift)) & UART_LSR_DR) != 0);
+}
+
+int ns16550_console_probe_init(char *compat, void *devp, char *path,
+		struct serial_console_data *scdp)
+{
+	u64 addr;
+	u32 reg[2];
+
+	if (strcmp("ns16550", compat))
+		return 0; /* Not my device */
+
+	if (getprop(devp, "reg", reg, sizeof(reg)) != sizeof(reg))
+		return -1; /* dt must be horked so fail */
+
+	addr = dt_ops.translate_addr(path, reg, sizeof(reg));
+	reg_base = (unsigned char *)((u32)addr & 0xffffffffu);
+
+	if (getprop(devp, "reg_shift", &reg_shift, sizeof(reg_shift))
+			!= sizeof(reg_shift))
+		reg_shift = 0;
+
+	scdp->open = ns16550_open;
+	scdp->putc = ns16550_putc;
+	scdp->getc = ns16550_getc;
+	scdp->tstc = ns16550_tstc;
+	scdp->close = NULL;
+
+	return 1; /* My device and I initialized okay */
+}
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
new file mode 100644
index 0000000..368cce8
--- /dev/null
+++ b/arch/powerpc/boot/serial.c
@@ -0,0 +1,159 @@
+/*
+ * Generic serial console support
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * Code in serial_edit_cmdline() copied from <file:arch/ppc/boot/simple/misc.c>
+ * and was written by Matt Porter <mporter@kernel.crashing.org>.
+ *
+ * 2001,2006 (c) MontaVista Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "string.h"
+#include "stdio.h"
+#include "io.h"
+#include "ops.h"
+
+extern void udelay(long delay);
+
+static int serial_open(void)
+{
+	struct serial_console_data *scdp = console_ops.data;
+	return scdp->open();
+}
+
+static void serial_write(char *buf, int len)
+{
+	struct serial_console_data *scdp = console_ops.data;
+
+	while (*buf != '\0')
+		scdp->putc(*buf++);
+}
+
+static void serial_edit_cmdline(char *buf, int len)
+{
+	int timer = 0, count;
+	char ch, *cp;
+	struct serial_console_data *scdp = console_ops.data;
+
+	cp = buf;
+	count = strlen(buf);
+	cp = &buf[count];
+	count++;
+
+	while (timer++ < 5*1000) {
+		if (scdp->tstc()) {
+			while (((ch = scdp->getc()) != '\n') && (ch != '\r')) {
+				/* Test for backspace/delete */
+				if ((ch == '\b') || (ch == '\177')) {
+					if (cp != buf) {
+						cp--;
+						count--;
+						printf("\b \b");
+					}
+				/* Test for ^x/^u (and wipe the line) */
+				} else if ((ch == '\030') || (ch == '\025')) {
+					while (cp != buf) {
+						cp--;
+						count--;
+						printf("\b \b");
+					}
+				} else if (count < len) {
+						*cp++ = ch;
+						count++;
+						scdp->putc(ch);
+				}
+			}
+			break;  /* Exit 'timer' loop */
+		}
+		udelay(1000);  /* 1 msec */
+	}
+	*cp = 0;
+}
+
+static void serial_close(void)
+{
+	struct serial_console_data *scdp = console_ops.data;
+
+	if (scdp->close)
+		scdp->close();
+}
+
+static int serial_get_stdout_info(void **devpp, char *path)
+{
+	void *devp;
+	char devtype[MAX_PROP_LEN];
+
+	devp = finddevice("/chosen");
+	if ((devp != NULL) && (getprop(devp, "linux,stdout-path", path,
+					MAX_PATH_LEN) > 0)) {
+		/* Check that device_type of stdout device is serial */
+		devp = finddevice(path);
+		if ((devp != NULL) && (getprop(devp, "device_type", devtype,
+						sizeof(devtype)) > 0)
+				&& !strcmp(devtype, "serial")) {
+			*devpp = devp;
+			/* *path param is set as well */
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+/* Add "weak" definition for each serial driver */
+int __attribute__ ((weak)) ns16550_console_probe_init(char *compat, void *devp,
+		char *path, struct serial_console_data *scdp)
+{
+	return 0; /* "not mine" */
+}
+
+static struct serial_console_data serial_cd;
+
+/* Node's "compatible" property determines which serial driver to use */
+int serial_console_init(void)
+{
+	void *devp;
+	int rc;
+	char path[MAX_PATH_LEN], compat[MAX_PROP_LEN];
+
+	if (serial_get_stdout_info(&devp, path))
+		goto fail;
+
+	if (getprop(devp, "compatible", compat, sizeof(compat)) < 0)
+		goto fail;
+
+	/* Call various serial driver probe routines.
+	 * DO NOT put the routine addresses into a table because they
+	 * will not be relocated.
+	 *
+	 * Probe routine return values:
+	 * 	-1: driver owns the device but init failed
+	 * 	 0: driver does not own the device
+	 * 	 1: driver owns the device and initialized it okay
+	 */
+	rc = ns16550_console_probe_init(compat, devp, path, &serial_cd);
+	/* Do something like:
+	 * if (rc == 0)
+	 *	rc = next_console_probe_init(compat, devp, path, &serial_cd);
+	 * if (rc == 0)
+	 *	...
+	 */
+
+	if (rc == 1) {
+		console_ops.open = serial_open;
+		console_ops.write = serial_write;
+		console_ops.edit_cmdline = serial_edit_cmdline;
+		console_ops.close = serial_close;
+		console_ops.data = &serial_cd;
+
+		return 0;
+	}
+fail:
+	return -1;
+}
diff --git a/arch/powerpc/boot/util.S b/arch/powerpc/boot/util.S
new file mode 100644
index 0000000..b8e1c23
--- /dev/null
+++ b/arch/powerpc/boot/util.S
@@ -0,0 +1,101 @@
+/*
+ * Copied from <file:arch/powerpc/kernel/misc_32.S>
+ *
+ * This file contains miscellaneous low-level functions.
+ *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
+ *
+ * Largely rewritten by Cort Dougan (cort@cs.nmt.edu)
+ * and Paul Mackerras.
+ *
+ * kexec bits:
+ * Copyright (C) 2002-2003 Eric Biederman  <ebiederm@xmission.com>
+ * GameCube/ppc32 port Copyright (C) 2004 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+#include "ppc_asm.h"
+
+#define SPRN_PVR        0x11F   /* Processor Version Register */
+
+	.text
+/*
+ * complement mask on the msr then "or" some values on.
+ *     _nmask_and_or_msr(nmask, value_to_or)
+ */
+	.globl _nmask_and_or_msr
+_nmask_and_or_msr:
+	mfmsr	r0		/* Get current msr */
+	andc	r0,r0,r3	/* And off the bits set in r3 (first parm) */
+	or	r0,r0,r4	/* Or on the bits in r4 (second parm) */
+	SYNC			/* Some chip revs have problems here... */
+	mtmsr	r0		/* Update machine state */
+	isync
+	blr			/* Done */
+
+/* udelay (on non-601 processors) needs to know the period of the
+ * timebase in nanoseconds.  This used to be hardcoded to be 60ns
+ * (period of 66MHz/4).  Now a variable is used that is initialized to
+ * 60 for backward compatibility, but it can be overridden as necessary
+ * with code something like this:
+ *    extern unsigned long timebase_period_ns;
+ *    timebase_period_ns = 1000000000 / bd->bi_tbfreq;
+ */
+	.data
+	.globl timebase_period_ns
+timebase_period_ns:
+	.long	60
+
+	.text
+/*
+ * Delay for a number of microseconds
+ */
+	.globl	udelay
+udelay:
+	mfspr	r4,SPRN_PVR
+	srwi	r4,r4,16
+	cmpwi	0,r4,1		/* 601 ? */
+	bne	.udelay_not_601
+00:	li	r0,86	/* Instructions / microsecond? */
+	mtctr	r0
+10:	addi	r0,r0,0 /* NOP */
+	bdnz	10b
+	subic.	r3,r3,1
+	bne	00b
+	blr
+
+.udelay_not_601:
+	mulli	r4,r3,1000	/* nanoseconds */
+	/*  Change r4 to be the number of ticks using:
+	 *	(nanoseconds + (timebase_period_ns - 1 )) / timebase_period_ns
+	 *  timebase_period_ns defaults to 60 (16.6MHz) */
+	mflr	r5
+	bl	0f
+0:	mflr	r6
+	mtlr	r5
+	lis	r5,0b@ha
+	addi	r5,r5,0b@l
+	subf	r5,r5,r6	/* In case we're relocated */
+	addis	r5,r5,timebase_period_ns@ha
+	lwz	r5,timebase_period_ns@l(r5)
+	add	r4,r4,r5
+	addi	r4,r4,-1
+	divw	r4,r4,r5	/* BUS ticks */
+1:	mftbu	r5
+	mftb	r6
+	mftbu	r7
+	cmpw	0,r5,r7
+	bne	1b		/* Get [synced] base time */
+	addc	r9,r6,r4	/* Compute end time */
+	addze	r8,r5
+2:	mftbu	r5
+	cmpw	0,r5,r8
+	blt	2b
+	bgt	3f
+	mftb	r6
+	cmpw	0,r6,r9
+	blt	2b
+3:	blr
