Return-Path: <miltonm@sullivan.realtime.net>
Date: Wed, 11 Apr 2007 03:32:47 -0500 (CDT)
Subject: [PATCH 2/8] bootwrapper: smp support code
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-4-02.miltonm@bga.com>
In-Reply-To: <boot-4-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add support code to move cpus around, both a spin loop and c code to move
the cpus before uncompressing and copying the kernel to 0.

The low level code is designed to be included in a crt0 because it may
need to be at a fixed location or there may be other entry point
requirements.

This code supports arbitrary cpu identifiers in the 0-1023 range.

Signed-off-by: Milton Miller <miltonm@bga.com>

--- 
I first had move_slaves_up, then added move_to_here to support loading
at zero where the bss is overwritten by the kernel.  After moving
the slave area from the end to the beginning of the decompressed
kernel when it was not at 0, I started getting crashes.  At that
point, I wrote checkout_slaves_to_kernel.  Debugging checkout_slaves
prompted the kexec-slaves-earlier and kexec-tools purgatory patches.

Note: this works with the 64 bit kernel using head_64.S.   The 32 bit
6xx kernel head_32.S needs the 0x60 slave entry point (it currently uses
something closer to 0xC0) and kexec slave shutdown.

Index: kernel/arch/powerpc/boot/marshal_low.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/marshal_low.S	2007-04-09 04:10:00.000000000 -0500
@@ -0,0 +1,103 @@
+/*
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
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright (C) 2007 IBM Corporation.
+ *
+ * Authors: Milton Miller <miltonm@bga.com>
+ *
+ */
+
+#include "ppc_asm.h"
+
+	.text
+	/*
+	 * This code is designed to be a kexec entry point block.
+	 * That is, it has both code for the master cpu that begins
+	 * at offset 0 as linked into the image, and a sequence of
+	 * 0x100 bytes that, when copied to address 0, forms the
+	 * wait loop for slave cpus.  Each slave should have its
+	 * unique hardware cpu identifier in r3 before entering
+	 * this code.
+	 */
+	.globl	master
+master: b	_zimage_start_plat
+
+	.global slave_wait
+slave_wait:
+	/* r3 cpu id, r4 slaves_wait, r5 cpu bit, r6 cpu mask word offset */
+
+	/* set our bit in the slaves mask  */
+98:	lwarx	r7,r4,r6
+	or	r8,r7,r5
+	stwcx.	r8,r4,r6
+	bne	98b
+
+	and.	r8,r7,r5
+	bnel-	err_slave
+
+99:	lwz	r7,gohere-slave_wait(r4)
+	cmpwi	0,r7,0
+	beq	99b
+	mtctr	r7
+	mr	r4,r7
+	bctr
+
+
+	.global gohere
+gohere:	.long	0			/* when set the slave moves */
+
+
+err_slave:
+	stw	r5,slave_error-slave_wait(4)	/* no locking */
+	blr
+
+	.globl	slave_error		/* set when slave detects error */
+slave_error:
+	.long	0
+
+	/*
+	 * The slaves may be in 32 or 64 bit mode, we don't care
+	 * r3 is the slave cpu number, matching the device tree.
+	 */
+	.org	master+0x60
+	.globl	slave
+slave:	bl	1f
+1:	mflr	r4
+	addi	r4,r4,slave_wait-1b	/* code assumes r4=slave_wait */
+	li	r5,1
+	rlwnm	r5,r5,r3,0,31		/* bit within word */
+	rlwinm	r6,r3,32-5+2,4,29	/* word in array */
+	addi	r6,r6,slaves-slave_wait	/* relative to r4, slave_wait */
+	b	slave_wait
+
+	.org	master+0x80	/* put locked bitmask data in another line */
+	.global	slaves
+slaves:
+
+	.globl slaves_end;
+slaves_end = 0f
+
+#if 0
+	/* today, the 32 bit kernel starts slaves at 0xc0
+	 * but this limits us to cpu to 512 vs 1024
+	 */
+	.org	master+0xc0
+0:	b	slave
+#endif
+
+
+	.org	master+0x100		/* we must fit in 0x100 bytes */
+0:
+
Index: kernel/arch/powerpc/boot/marshal.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/marshal.c	2007-04-09 01:48:53.000000000 -0500
@@ -0,0 +1,283 @@
+/*
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
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright (C) 2007 IBM Corporation.
+ *
+ * Authors: Milton Miller <miltonm@bga.com>
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "reg.h"
+
+extern unsigned int gohere[], master[], slave_wait[], slaves[], slaves_end[];
+extern unsigned int slave_error[1];
+extern unsigned int slave_checkout_begin[], slave_checkout_spin[];
+
+static unsigned int slaves_run_here[SMP_SLAVE_SIZE / sizeof(unsigned int)];
+static unsigned int *slaves_were_here = master;
+static unsigned int *slaves_goto_here = master;
+
+/* check_slave_errors
+ * check if the slaves have set the error flag.
+ */
+static void check_slave_errors(unsigned int *slaves_here)
+{
+	unsigned int *error = slave_error - master + slaves_here;
+
+	if (*error) {
+		printf("WARNING: error detected by one or more slave cpus!!\n\r"
+		"WARNING: This probably means you have duplicate cpu ids\n\r");
+		/* exit() */
+	}
+}
+
+/* wait_slaves_moved - wait for the slaves to catch up
+ * Wait until all slaves that checked in the previous location have
+ * checked into the current location.  Seperate so we can do other
+ * work while we wait for them to catch up.
+ */
+void wait_slaves_moved(void)
+{
+	int offset = slaves - master;
+	int len = sizeof(slaves_end[0]) * (slaves_end - slaves);
+	int printed = 0;
+	unsigned int *to = slaves_goto_here;
+	unsigned int *from = slaves_were_here;
+
+	from += offset;
+	to += offset;
+
+	if (from == to)
+		return;
+
+	while (memcmp(from, to, len)) {
+		if (!printed) {
+			printf("waiting for slave cpus to move...");
+			printed = 1;
+			HMT_LOW;
+			barrier();
+		}
+		/* check from is superset of to */
+	}
+	if (printed) {
+		HMT_MEDIUM;
+		printf("done.\n\r");
+	}
+
+	slaves_were_here = slaves_goto_here;
+}
+
+/* move_slaves_here - move slaves to a specified address.
+ * Tell slaves to go from their current location to a buffer @addr
+ * of %SMP_SLAVE_SIZE bytes somewhere in memory.
+ */
+void move_slaves_here(void *addr)
+{
+	unsigned int *move_slaves_here = addr;
+	unsigned int *tell_them = gohere - master + slaves_goto_here;
+	unsigned int *goto_here = slave_wait - master + move_slaves_here;
+	unsigned int *wait_here = gohere - master + move_slaves_here;
+
+	if (move_slaves_here == slaves_goto_here)
+		return;				/* already there */
+
+	wait_slaves_moved();			/* one move at a time */
+
+	printf("moving slave cpus from %p to %p\n\r", slaves_goto_here,
+		move_slaves_here);
+
+	memcpy(move_slaves_here, master, SMP_SLAVE_SIZE);
+	memset(move_slaves_here + (slaves - master), 0,
+		(slaves_end - slaves) * sizeof(slaves_end[0]));
+	*wait_here = 0;
+
+	flush_cache(move_slaves_here, SMP_SLAVE_SIZE);
+
+	check_slave_errors(slaves_were_here);
+
+	*tell_them = (unsigned int)goto_here;
+	slaves_goto_here = move_slaves_here;
+}
+
+/**
+ * move_slaves_up - move slaves from somewhere low to our bss.
+ * Call before decompressing the kernel to address 0.
+ */
+void move_slaves_up(void)
+{
+	move_slaves_here(slaves_run_here);
+}
+
+/**
+ * slaves_are_low - Assert that the slaves are spinning at 0 and move them
+ * Assert that the slaves are running in a copy of the marshall code
+ * that was copied to address 0.  Ask them to go up to our bss, as we
+ * know we have to move them away from 0.
+ */
+void slaves_are_low(void)
+{
+	slaves_goto_here = slaves_were_here = (void *)0;
+	move_slaves_up();
+}
+
+void delay_a_bit(int count)
+{
+	while(count--) {
+		HMT_LOW;
+		barrier();
+	}
+	HMT_MEDIUM;
+}
+
+/**
+ * wait_slave_checkout - wait for slaves to execute checkout store.
+ * Wait for every slave who checked in at slaves_were_here to
+ * perform the stb to @checkout before the branch to self spin loop.
+ */
+static void wait_slave_checkout(char *checkout)
+{
+	unsigned int *end = slaves_end - master + slaves_were_here;
+	unsigned int *from = slaves - master + slaves_were_here;;
+	unsigned int bit;
+	int i, ncpus = 0;
+	char *waiting = "waiting on slaves to go to kernel...";
+
+	for (i=0; from < end; from++)
+		for (bit = 1; bit; i++, bit <<= 1)
+			if (*from & bit) {
+				ncpus++;
+				while (!checkout[i]) {
+					if (waiting) {
+						printf(waiting);
+						waiting = NULL;
+					}
+					HMT_LOW;
+					barrier();
+				}
+			}
+
+	if (waiting == NULL)
+		printf("done.\n\r");
+
+	printf("moved %d slaves to the kernel.\n\r", ncpus);
+}
+
+
+/**
+ * checkout_slaves_to_kernel - send SMP slaves to the kernel
+ * Actively move slaves spinning on @tell_them to 0x60.  Since we
+ * don't know what code is there, replace it with our one code that
+ * ends with a byte store and branch to self, with the branch at 0x60.
+ * After the stores complete, we can restore the rest of the line,
+ * floush, then restore the remaining line.
+ */
+static void checkout_slaves_to_kernel(unsigned int *tell_them)
+{
+	int to, spin;
+	unsigned int *from, *low, save[SMP_SLAVE_SIZE/sizeof(unsigned int)];
+	char *checkout;
+
+	checkout = malloc(1024);
+	if (checkout == NULL)
+		fatal("can't malloc slave checkout buffer");
+	memset(checkout, 0, 1024);
+
+	low = (unsigned int *)0;
+	memcpy(save, low, SMP_SLAVE_SIZE);
+
+	to = spin = 0x60 / sizeof(int);
+
+	to++;
+	from = slave_checkout_spin;
+	while (from >= slave_checkout_begin)
+		low[--to] = *from--;
+
+	low[0] = (unsigned int)checkout;
+	flush_cache(low, SMP_SLAVE_SIZE);
+
+	*tell_them = (unsigned int)(low + to);
+
+	wait_slave_checkout(checkout);
+
+	/* at this point, all have completed the store at 0x5c and are at
+	 * the branch to self at 0x60.   Restore the rest of the vector,
+	 * flush cache, then do the final store replacing the spin and
+	 * flush again.
+	 */
+	low[0] = save[0];
+	for (;to < spin; to++)
+		low[to] = save[to];
+	flush_cache(low, SMP_SLAVE_SIZE);
+	low[to] = save[to];
+	flush_cache(low, SMP_SLAVE_SIZE);
+
+	asm volatile ("b 1f		;\
+	.globl	slave_checkout_begin 	;\
+	.globl	slave_checkout_spin	;\
+slave_checkout_begin:			;\
+	lwz	7,0(0)			;\
+	li	8,1			;\
+	stbx	8,7,3			;\
+slave_checkout_spin:			;\
+	b	$			;\
+1:");
+
+
+}
+
+/**
+ * send_slaves_to_kernel - send SMP slaves to the kernel
+ * Send slaves to a new kernel which is uncompressed at address @vmlinux_addr.
+ * Copies the first SMP_SLAVE_SIZE bytes of the image to address 0 and
+ * then tells the slaves to go to 0x60.
+ */
+void send_slaves_to_kernel(void *vmlinux_addr)
+{
+	unsigned int *tell_them = gohere - master + slaves_goto_here;
+
+	if ((unsigned long)slaves_goto_here < SMP_SLAVE_SIZE) {
+		if ((unsigned long)vmlinux_addr < SMP_SLAVE_SIZE)
+			fatal("ERROR: slaves were not marshaled before "
+					"decompressing the kernel to 0!\n");
+		move_slaves_up();
+		send_slaves_to_kernel(vmlinux_addr);
+		return;
+	}
+
+	wait_slaves_moved();
+
+	if (vmlinux_addr) {
+		memcpy((void *)0, vmlinux_addr, SMP_SLAVE_SIZE);
+		flush_cache((void *)0, SMP_SLAVE_SIZE);
+	} else {
+		printf("kernel was decompressed to 0\n\r");
+	}
+	check_slave_errors(slaves_goto_here);
+
+#if 1
+	checkout_slaves_to_kernel(tell_them);
+#else
+	*tell_them = 0x60;	/* goto_here */
+
+	/* Since we don't own the new loop, we don't know what acknowledge it
+	 * might or might not have.   We pause here to in hopes they move away.
+	 * If the previous slave location was outside the static kernel size,
+	 * then they will probably be ok.
+	 */
+	flush_cache(tell_them, 0x4);
+	delay_a_bit(1000000);
+#endif
+}
Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-04-09 00:47:06.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-04-09 04:09:38.000000000 -0500
@@ -41,6 +41,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
 		$(addprefix $(obj)/,$(zlibheader))
 
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
+		marshal.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c $(zlib)
 src-plat := of.c
Index: kernel/arch/powerpc/boot/reg.h
===================================================================
--- kernel.orig/arch/powerpc/boot/reg.h	2007-04-09 00:47:06.000000000 -0500
+++ kernel/arch/powerpc/boot/reg.h	2007-04-09 01:47:13.000000000 -0500
@@ -19,4 +19,9 @@ static inline u32 mfpvr(void)
 register void *__stack_pointer asm("r1");
 #define get_sp()	(__stack_pointer)
 
+#define HMT_MEDIUM	asm volatile("or 2,2,2")
+#define HMT_LOW		asm volatile("or 1,1,1")
+#define barrier()	asm volatile("":::"memory")
+
+
 #endif	/* _PPC_BOOT_REG_H */
Index: kernel/arch/powerpc/boot/ops.h
===================================================================
--- kernel.orig/arch/powerpc/boot/ops.h	2007-04-09 00:47:18.000000000 -0500
+++ kernel/arch/powerpc/boot/ops.h	2007-04-09 04:09:38.000000000 -0500
@@ -18,6 +18,7 @@
 #define	COMMAND_LINE_SIZE	512
 #define	MAX_PATH_LEN		256
 #define	MAX_PROP_LEN		256 /* What should this be? */
+#define	SMP_SLAVE_SIZE		256 /* Size of SMP slave block, kexec/kernel */
 
 /* Platform specific operations */
 struct platform_ops {
@@ -79,7 +80,14 @@ int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
 void *simple_alloc_init(char *base, u32 heap_size, u32 granularity,
 		u32 max_allocs);
-extern void flush_cache(void *, unsigned long);
+void flush_cache(void *, unsigned long);
+
+/* marshal slave cpus around to kernel */
+void move_slaves_up(void);
+void move_slaves_here(void *where);
+void send_slaves_to_kernel(void *vmlinux_addr);
+void slaves_are_low(void);
+void wait_slaves_moved(void);
 
 static inline void *finddevice(const char *name)
 {
