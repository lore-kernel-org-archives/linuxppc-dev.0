Return-Path: <mgreer@mvista.com>
Date: Wed, 19 Jul 2006 16:12:44 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/6] bootwrapper: Add non-OF serial console support
Message-ID: <20060719231244.GE3887@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

 io.h      |   53 ++++++++++++++++++++++++++++
 ns16550.c |  117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 serial.c  |   89 +++++++++++++++++++++++++++++++++++++++++++++++
 util.S    |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 360 insertions(+)
--

diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h
new file mode 100644
index 0000000..05c5348
--- /dev/null
+++ b/arch/powerpc/boot/io.h
@@ -0,0 +1,53 @@
+#ifndef _IO_H
+#define __IO_H
+/*
+ * Low-level I/O routines.
+ *
+ * Copied from <file:include/asm-powerpc/io.h>
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
index 0000000..661cfff
--- /dev/null
+++ b/arch/powerpc/boot/ns16550.c
@@ -0,0 +1,117 @@
+/*
+ * 16550 serial console support.
+ *
+ * Copied from <file:arch/ppc/boot/common/ns16550.c>
+ * Fdt code, etc. added by Mark A. Greer <mgreer@mvista.com>
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
+int
+ns16550_get_dt_info(struct serial_console_data *scdp)
+{
+	u64 addr;
+	u32 reg[2], reg_shift;
+	void *devp;
+	char path[MAX_PATH_LEN+1], compat[MAX_PATH_LEN+1];
+
+	scdp->base = NULL;
+	scdp->reg_shift = 0;
+
+	if ((devp = finddevice("/chosen"))
+			&& (getprop(devp, "linux,stdout-path", path,
+					sizeof(path)) > 0)
+			&& (devp = finddevice(path))
+			&& (getprop(devp, "compatible", compat, sizeof(compat))
+				> 0)
+			&& !strcmp(compat, "ns16550")
+			&& (getprop(devp, "reg", reg, sizeof(reg))
+				== sizeof(reg))) {
+
+		addr = ops->dt_ops->translate_addr(path, reg, sizeof(reg));
+		scdp->base = (unsigned char *)((u32)addr & 0xffffffffu);
+
+		if (getprop(devp, "reg_shift", &reg_shift, sizeof(reg_shift))
+				== sizeof(reg_shift))
+			scdp->reg_shift = reg_shift;
+		return 0;
+	}
+	return -1;
+}
+
+static int
+ns16550_open(void)
+{
+	struct serial_console_data *scdp = ops->console_ops->data;
+
+	if (ns16550_get_dt_info(scdp) < 0)
+		return -1;
+
+	out_8(scdp->base + (UART_FCR << scdp->reg_shift), 0x06);
+	return 0;
+}
+
+static void
+ns16550_putc(unsigned char c)
+{
+	struct serial_console_data *scdp = ops->console_ops->data;
+	while ((in_8(scdp->base + (UART_LSR << scdp->reg_shift))
+							& UART_LSR_THRE) == 0);
+	out_8(scdp->base, c);
+}
+
+static unsigned char
+ns16550_getc(void)
+{
+	struct serial_console_data *scdp = ops->console_ops->data;
+	while ((in_8(scdp->base + (UART_LSR << scdp->reg_shift))
+							& UART_LSR_DR) == 0);
+	return in_8(scdp->base);
+}
+
+static u8
+ns16550_tstc(void)
+{
+	struct serial_console_data *scdp = ops->console_ops->data;
+	return ((in_8(scdp->base + (UART_LSR << scdp->reg_shift)) & UART_LSR_DR)
+			!= 0);
+}
+
+static struct serial_console_data ns16550_scd;
+static struct console_ops ns16550_console_ops;
+
+struct console_ops *
+ns16550_init(void)
+{
+	ns16550_scd.open = ns16550_open;
+	ns16550_scd.putc = ns16550_putc;
+	ns16550_scd.getc = ns16550_getc;
+	ns16550_scd.tstc = ns16550_tstc;
+	ns16550_scd.close = NULL;
+	ns16550_scd.base = NULL;
+	ns16550_scd.reg_shift = 0;
+
+	ns16550_console_ops.open = serial_open;
+	ns16550_console_ops.write = serial_write;
+	ns16550_console_ops.edit_cmdline = serial_edit_cmdline;
+	ns16550_console_ops.close = serial_close;
+	ns16550_console_ops.data = &ns16550_scd;
+
+	return &ns16550_console_ops;
+}
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
new file mode 100644
index 0000000..6d064cb
--- /dev/null
+++ b/arch/powerpc/boot/serial.c
@@ -0,0 +1,89 @@
+/*
+ * Generic serial console support
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * Code in serial_edit_cmdline() copied from <file:arch/ppc/boot/simple/misc.c>
+ * and was written by Matt Porter <mporter@kernel.crashing.org>.
+ *
+ * 2001,2006 (c) MontaVista, Software, Inc.  This file is licensed under
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
+int
+serial_open(void)
+{
+	struct serial_console_data *scdp = ops->console_ops->data;
+	return scdp->open();
+}
+
+void
+serial_write(char *buf, int len)
+{
+	struct serial_console_data *scdp = ops->console_ops->data;
+
+	while (*buf != '\0')
+		scdp->putc(*buf++);
+}
+
+void
+serial_edit_cmdline(char *buf, int len)
+{
+	int timer = 0, count;
+	char ch, *cp;
+	struct serial_console_data *scdp = ops->console_ops->data;
+
+	cp = buf;
+	count = strlen(buf);
+	cp = &buf[count];
+	count++;
+
+	while (timer++ < 5*1000) {
+		if (scdp->tstc()) {
+			while ((ch = scdp->getc()) != '\n' && ch != '\r') {
+				/* Test for backspace/delete */
+				if (ch == '\b' || ch == '\177') {
+					if (cp != buf) {
+						cp--;
+						count--;
+						printf("\b \b");
+					}
+				/* Test for ^x/^u (and wipe the line) */
+				} else if (ch == '\030' || ch == '\025') {
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
+void
+serial_close(void)
+{
+	struct serial_console_data *scdp = ops->console_ops->data;
+
+	if (scdp->close)
+		scdp->close();
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
