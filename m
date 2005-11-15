Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 14:34:24 +1100
Message-Id: <1132025664.6094.47.camel@gaston>
Mime-Version: 1.0
Subject: [PATCH] powerpc: Merge align.c (#2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Need testing !!!

This patch merges align.c, the result isn't quite what was in ppc64 nor
what was in ppc32 :) It should implement all the functionalities of both
though. Kumar, since you played with that in the past, I suppose you
have some test cases for verifying that it works properly before I dig
out the 601 machine ? :)

Since it's likely that I won't be able to test all scenario, code
inspection is much welcome.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

No difference, just rebased on current -git

Index: linux-work/arch/powerpc/kernel/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/kernel/Makefile	2005-11-15 13:31:57.000000000 +1100
+++ linux-work/arch/powerpc/kernel/Makefile	2005-11-15 14:31:22.000000000 +1100
@@ -12,7 +12,7 @@
 endif
 
 obj-y				:= semaphore.o cputable.o ptrace.o syscalls.o \
-				   irq.o signal_32.o pmc.o vdso.o
+				   irq.o align.o signal_32.o pmc.o vdso.o
 obj-y				+= vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o binfmt_elf32.o sys_ppc32.o \
 				   signal_64.o ptrace32.o systbl.o \
Index: linux-work/arch/powerpc/kernel/align.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/kernel/align.c	2005-11-15 14:31:22.000000000 +1100
@@ -0,0 +1,513 @@
+/* align.c - handle alignment exceptions for the Power PC.
+ *
+ * Copyright (c) 1996 Paul Mackerras <paulus@cs.anu.edu.au>
+ * Copyright (c) 1998-1999 TiVo, Inc.
+ *   PowerPC 403GCX modifications.
+ * Copyright (c) 1999 Grant Erickson <grant@lcse.umn.edu>
+ *   PowerPC 403GCX/405GP modifications.
+ * Copyright (c) 2001-2002 PPC64 team, IBM Corp
+ *   64-bit and Power4 support
+ * Copyright (c) 2005 Benjamin Herrenschmidt, IBM Corp
+ *                    <benh@kernel.crashing.org>
+ *   Merge ppc32 and ppc64 implementations
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <asm/processor.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/cache.h>
+#include <asm/cputable.h>
+
+struct aligninfo {
+	unsigned char len;
+	unsigned char flags;
+};
+
+#define IS_XFORM(inst)	(((inst) >> 26) == 31)
+#define IS_DSFORM(inst)	(((inst) >> 26) >= 56)
+
+#define INVALID	{ 0, 0 }
+
+#define LD	1	/* load */
+#define ST	2	/* store */
+#define	SE	4	/* sign-extend value */
+#define F	8	/* to/from fp regs */
+#define U	0x10	/* update index register */
+#define M	0x20	/* multiple load/store */
+#define SW	0x40	/* byte swap int or ... */
+#define S	0x40	/* ... single-precision fp */
+#define SX	0x40	/* byte count in XER */
+#define HARD	0x80	/* string, stwcx. */
+
+#define DCBZ	0x5f	/* 8xx/82xx dcbz faults when cache not enabled */
+
+#define SWAP(a, b)	(t = (a), (a) = (b), (b) = t)
+
+/*
+ * The PowerPC stores certain bits of the instruction that caused the
+ * alignment exception in the DSISR register.  This array maps those
+ * bits to information about the operand length and what the
+ * instruction would do.
+ */
+static struct aligninfo aligninfo[128] = {
+	{ 4, LD },		/* 00 0 0000: lwz / lwarx */
+	INVALID,		/* 00 0 0001 */
+	{ 4, ST },		/* 00 0 0010: stw */
+	INVALID,		/* 00 0 0011 */
+	{ 2, LD },		/* 00 0 0100: lhz */
+	{ 2, LD+SE },		/* 00 0 0101: lha */
+	{ 2, ST },		/* 00 0 0110: sth */
+	{ 4, LD+M },		/* 00 0 0111: lmw */
+	{ 4, LD+F+S },		/* 00 0 1000: lfs */
+	{ 8, LD+F },		/* 00 0 1001: lfd */
+	{ 4, ST+F+S },		/* 00 0 1010: stfs */
+	{ 8, ST+F },		/* 00 0 1011: stfd */
+	INVALID,		/* 00 0 1100 */
+	{ 8, LD },		/* 00 0 1101: ld/ldu/lwa */
+	INVALID,		/* 00 0 1110 */
+	{ 8, ST },		/* 00 0 1111: std/stdu */
+	{ 4, LD+U },		/* 00 1 0000: lwzu */
+	INVALID,		/* 00 1 0001 */
+	{ 4, ST+U },		/* 00 1 0010: stwu */
+	INVALID,		/* 00 1 0011 */
+	{ 2, LD+U },		/* 00 1 0100: lhzu */
+	{ 2, LD+SE+U },		/* 00 1 0101: lhau */
+	{ 2, ST+U },		/* 00 1 0110: sthu */
+	{ 4, ST+M },		/* 00 1 0111: stmw */
+	{ 4, LD+F+S+U },	/* 00 1 1000: lfsu */
+	{ 8, LD+F+U },		/* 00 1 1001: lfdu */
+	{ 4, ST+F+S+U },	/* 00 1 1010: stfsu */
+	{ 8, ST+F+U },		/* 00 1 1011: stfdu */
+	INVALID,		/* 00 1 1100 */
+	INVALID,		/* 00 1 1101 */
+	INVALID,		/* 00 1 1110 */
+	INVALID,		/* 00 1 1111 */
+	{ 8, LD },		/* 01 0 0000: ldx */
+	INVALID,		/* 01 0 0001 */
+	{ 8, ST },		/* 01 0 0010: stdx */
+	INVALID,		/* 01 0 0011 */
+	INVALID,		/* 01 0 0100 */
+	{ 4, LD+SE },		/* 01 0 0101: lwax */
+	INVALID,		/* 01 0 0110 */
+	INVALID,		/* 01 0 0111 */
+	{ 4, LD+M+HARD+SX },	/* 01 0 1000: lswx */
+	{ 4, LD+M+HARD },	/* 01 0 1001: lswi */
+	{ 4, ST+M+HARD+SX },	/* 01 0 1010: stswx */
+	{ 4, ST+M+HARD },	/* 01 0 1011: stswi */
+	INVALID,		/* 01 0 1100 */
+	{ 8, LD+U },		/* 01 0 1101: ldu */
+	INVALID,		/* 01 0 1110 */
+	{ 8, ST+U },		/* 01 0 1111: stdu */
+	{ 8, LD+U },		/* 01 1 0000: ldux */
+	INVALID,		/* 01 1 0001 */
+	{ 8, ST+U },		/* 01 1 0010: stdux */
+	INVALID,		/* 01 1 0011 */
+	INVALID,		/* 01 1 0100 */
+	{ 4, LD+SE+U },		/* 01 1 0101: lwaux */
+	INVALID,		/* 01 1 0110 */
+	INVALID,		/* 01 1 0111 */
+	INVALID,		/* 01 1 1000 */
+	INVALID,		/* 01 1 1001 */
+	INVALID,		/* 01 1 1010 */
+	INVALID,		/* 01 1 1011 */
+	INVALID,		/* 01 1 1100 */
+	INVALID,		/* 01 1 1101 */
+	INVALID,		/* 01 1 1110 */
+	INVALID,		/* 01 1 1111 */
+	INVALID,		/* 10 0 0000 */
+	INVALID,		/* 10 0 0001 */
+	INVALID,		/* 10 0 0010: stwcx. */
+	INVALID,		/* 10 0 0011 */
+	INVALID,		/* 10 0 0100 */
+	INVALID,		/* 10 0 0101 */
+	INVALID,		/* 10 0 0110 */
+	INVALID,		/* 10 0 0111 */
+	{ 4, LD+SW },		/* 10 0 1000: lwbrx */
+	INVALID,		/* 10 0 1001 */
+	{ 4, ST+SW },		/* 10 0 1010: stwbrx */
+	INVALID,		/* 10 0 1011 */
+	{ 2, LD+SW },		/* 10 0 1100: lhbrx */
+	{ 4, LD+SE },		/* 10 0 1101  lwa */
+	{ 2, ST+SW },		/* 10 0 1110: sthbrx */
+	INVALID,		/* 10 0 1111 */
+	INVALID,		/* 10 1 0000 */
+	INVALID,		/* 10 1 0001 */
+	INVALID,		/* 10 1 0010 */
+	INVALID,		/* 10 1 0011 */
+	INVALID,		/* 10 1 0100 */
+	INVALID,		/* 10 1 0101 */
+	INVALID,		/* 10 1 0110 */
+	INVALID,		/* 10 1 0111 */
+	INVALID,		/* 10 1 1000 */
+	INVALID,		/* 10 1 1001 */
+	INVALID,		/* 10 1 1010 */
+	INVALID,		/* 10 1 1011 */
+	INVALID,		/* 10 1 1100 */
+	INVALID,		/* 10 1 1101 */
+	INVALID,		/* 10 1 1110 */
+	{ 0, ST+HARD },		/* 10 1 1111: dcbz */
+	{ 4, LD },		/* 11 0 0000: lwzx */
+	INVALID,		/* 11 0 0001 */
+	{ 4, ST },		/* 11 0 0010: stwx */
+	INVALID,		/* 11 0 0011 */
+	{ 2, LD },		/* 11 0 0100: lhzx */
+	{ 2, LD+SE },		/* 11 0 0101: lhax */
+	{ 2, ST },		/* 11 0 0110: sthx */
+	INVALID,		/* 11 0 0111 */
+	{ 4, LD+F+S },		/* 11 0 1000: lfsx */
+	{ 8, LD+F },		/* 11 0 1001: lfdx */
+	{ 4, ST+F+S },		/* 11 0 1010: stfsx */
+	{ 8, ST+F },		/* 11 0 1011: stfdx */
+	INVALID,		/* 11 0 1100 */
+	{ 8, LD+M },		/* 11 0 1101: lmd */
+	INVALID,		/* 11 0 1110 */
+	{ 8, ST+M },		/* 11 0 1111: stmd */
+	{ 4, LD+U },		/* 11 1 0000: lwzux */
+	INVALID,		/* 11 1 0001 */
+	{ 4, ST+U },		/* 11 1 0010: stwux */
+	INVALID,		/* 11 1 0011 */
+	{ 2, LD+U },		/* 11 1 0100: lhzux */
+	{ 2, LD+SE+U },		/* 11 1 0101: lhaux */
+	{ 2, ST+U },		/* 11 1 0110: sthux */
+	INVALID,		/* 11 1 0111 */
+	{ 4, LD+F+S+U },	/* 11 1 1000: lfsux */
+	{ 8, LD+F+U },		/* 11 1 1001: lfdux */
+	{ 4, ST+F+S+U },	/* 11 1 1010: stfsux */
+	{ 8, ST+F+U },		/* 11 1 1011: stfdux */
+	INVALID,		/* 11 1 1100 */
+	INVALID,		/* 11 1 1101 */
+	INVALID,		/* 11 1 1110 */
+	INVALID,		/* 11 1 1111 */
+};
+
+/*
+ * Create a DSISR value from the instruction
+ */
+static inline unsigned make_dsisr(unsigned instr)
+{
+	unsigned dsisr;
+
+
+	/* bits  6:15 --> 22:31 */
+	dsisr = (instr & 0x03ff0000) >> 16;
+
+	if ( IS_XFORM(instr) ) {
+		/* bits 29:30 --> 15:16 */
+		dsisr |= (instr & 0x00000006) << 14;
+		/* bit     25 -->    17 */
+		dsisr |= (instr & 0x00000040) << 8;
+		/* bits 21:24 --> 18:21 */
+		dsisr |= (instr & 0x00000780) << 3;
+	}
+	else {
+		/* bit      5 -->    17 */
+		dsisr |= (instr & 0x04000000) >> 12;
+		/* bits  1: 4 --> 18:21 */
+		dsisr |= (instr & 0x78000000) >> 17;
+		/* bits 30:31 --> 12:13 */
+		if ( IS_DSFORM(instr) )
+			dsisr |= (instr & 0x00000003) << 18;
+	}
+
+	return dsisr;
+}
+
+/*
+ * The dcbz (data cache block zero) instruction
+ * gives an alignment fault if used on non-cacheable
+ * memory.  We handle the fault mainly for the
+ * case when we are running with the cache disabled
+ * for debugging.
+ */
+static int emulate_dcbz(struct pt_regs *regs, unsigned char __user *addr)
+{
+	long __user *p;
+	int i, size;
+
+#ifdef __powerpc64__
+	size = ppc64_caches.dline_size;
+#else
+	size = L1_CACHE_BYTES;
+#endif
+	p = (long __user *) (regs->dar & -size);
+	if (user_mode(regs) && !access_ok(VERIFY_WRITE, p, size))
+		return -EFAULT;
+	for (i = 0; i < size / sizeof(long); ++i)
+		if (__put_user(0, p+i))
+			return -EFAULT;
+	return 1;
+}
+
+/*
+ * Emulate load & store multiple instructions
+ */
+static int emulate_multiple(struct pt_regs *regs, unsigned char __user *addr,
+			    unsigned int reg, unsigned int nb,
+			    unsigned int flags, unsigned int instr)
+{
+	unsigned char *rptr;
+	int nb0, i;
+
+	/*
+	 * We do not try to emulate 8 bytes multiple as they aren't really
+	 * available in our operating environments and we don't try to
+	 * emulate multiples operations in kernel land as they should never
+	 * be used/generated there at least not on unaligned boundaries
+	 */
+	if (unlikely((nb > 4) || !user_mode(regs)))
+		return 0;
+
+	/* lmw, stmw, lswi/x, stswi/x */
+	nb0 = 0;
+	if (flags & HARD) {
+		if (flags & SX) {
+			nb = regs->xer & 127;
+			if (nb == 0)
+				return 1;
+		} else {
+			if (__get_user(instr,
+				       (unsigned int __user *)regs->nip))
+				return -EFAULT;
+			nb = (instr >> 11) & 0x1f;
+			if (nb == 0)
+				nb = 32;
+		}
+		if (nb + reg * 4 > 128) {
+			nb0 = nb + reg * 4 - 128;
+			nb = 128 - reg * 4;
+		}
+	} else {
+		/* lwm, stmw */
+		nb = (32 - reg) * 4;
+	}
+
+	if (!access_ok((flags & ST ? VERIFY_WRITE: VERIFY_READ), addr, nb+nb0))
+		return -EFAULT;	/* bad address */
+
+	rptr = (unsigned char *) &regs->gpr[reg];
+	if (flags & LD) {
+		for (i = 0; i < nb; ++i)
+			if (__get_user(rptr[i], addr + i))
+				return -EFAULT;
+		if (nb0 > 0) {
+			rptr = (unsigned char *) &regs->gpr[0];
+			addr += nb;
+			for (i = 0; i < nb0; ++i)
+				if (__get_user(rptr[i], addr + i))
+					return -EFAULT;
+		}
+		for (; (i & 3) != 0; ++i)
+			rptr[i] = 0;
+	} else {
+		for (i = 0; i < nb; ++i)
+			if (__put_user(rptr[i], addr + i))
+				return -EFAULT;
+		if (nb0 > 0) {
+			rptr = (unsigned char *) &regs->gpr[0];
+			addr += nb;
+			for (i = 0; i < nb0; ++i)
+				if (__put_user(rptr[i], addr + i))
+					return -EFAULT;
+		}
+	}
+	return 1;
+}
+
+
+/*
+ * Called on alignment exception. Attempts to fixup
+ *
+ * Return 1 on success
+ * Return 0 if unable to handle the interrupt
+ * Return -EFAULT if data address is bad
+ */
+
+int fix_alignment(struct pt_regs *regs)
+{
+	unsigned int instr, nb, flags;
+	unsigned int reg, areg;
+	unsigned int dsisr;
+	unsigned char __user *addr;
+	unsigned char __user *p;
+	int ret, t;
+	union {
+		long ll;
+		double dd;
+		unsigned char v[8];
+		struct {
+			unsigned hi32;
+			int	 low32;
+		} x32;
+		struct {
+			unsigned char hi48[6];
+			short	      low16;
+		} x16;
+	} data;
+
+	/*
+	 * We require a complete register set, if not, then our assembly
+	 * is broken
+	 */
+	CHECK_FULL_REGS(regs);
+
+	dsisr = regs->dsisr;
+
+	/* Some processors don't provide us with a DSISR we can use here,
+	 * let's make one up from the instruction
+	 */
+	if (cpu_has_feature(CPU_FTR_NODSISRALIGN)) {
+		unsigned int real_instr;
+		if (unlikely(__get_user(real_instr,
+					(unsigned int __user *)regs->nip)))
+			return -EFAULT;
+		dsisr = make_dsisr(real_instr);
+	}
+
+	/* extract the operation and registers from the dsisr */
+	reg = (dsisr >> 5) & 0x1f;	/* source/dest register */
+	areg = dsisr & 0x1f;		/* register to update */
+	instr = (dsisr >> 10) & 0x7f;
+	instr |= (dsisr >> 13) & 0x60;
+
+	/* Lookup the operation in our table */
+	nb = aligninfo[instr].len;
+	flags = aligninfo[instr].flags;
+
+	/* DAR has the operand effective address */
+	addr = (unsigned char __user *)regs->dar;
+
+	/* A size of 0 indicates an instruction we don't support, with
+	 * the exception of DCBZ which is handled as a special case here
+	 */
+	if (instr == DCBZ)
+		return emulate_dcbz(regs, addr);
+	if (unlikely(nb == 0))
+		return 0;
+
+	/* Load/Store Multiple instructions are handled in their own
+	 * function
+	 */
+	if (flags & M)
+		return emulate_multiple(regs, addr, reg, nb, flags, instr);
+
+	/* Verify the address of the operand */
+	if (unlikely(user_mode(regs) &&
+		     !access_ok((flags & ST ? VERIFY_WRITE : VERIFY_READ),
+				addr, nb)))
+		return -EFAULT;
+
+	/* Force the fprs into the save area so we can reference them */
+	if (flags & F) {
+		/* userland only */
+		if (unlikely(!user_mode(regs)))
+			return 0;
+		flush_fp_to_thread(current);
+	}
+
+	/* If we are loading, get the data from user space, else
+	 * get it from register values
+	 */
+	if (flags & LD) {
+		data.ll = 0;
+		ret = 0;
+		p = addr;
+		switch (nb) {
+		case 8:
+			ret |= __get_user(data.v[0], p++);
+			ret |= __get_user(data.v[1], p++);
+			ret |= __get_user(data.v[2], p++);
+			ret |= __get_user(data.v[3], p++);
+		case 4:
+			ret |= __get_user(data.v[4], p++);
+			ret |= __get_user(data.v[5], p++);
+		case 2:
+			ret |= __get_user(data.v[6], p++);
+			ret |= __get_user(data.v[7], p++);
+			if (unlikely(ret))
+				return -EFAULT;
+		}
+	} else if (flags & F)
+		data.dd = current->thread.fpr[reg];
+	else
+		data.ll = regs->gpr[reg];
+
+	/* Perform other misc operations like sign extension, byteswap,
+	 * or floating point single precision conversion
+	 */
+	switch (flags & ~U) {
+	case LD+SE:	/* sign extend */
+		if ( nb == 2 )
+			data.ll = data.x16.low16;
+		else	/* nb must be 4 */
+			data.ll = data.x32.low32;
+		break;
+	case LD+S:	/* byte-swap */
+	case ST+S:
+		if (nb == 2) {
+			SWAP(data.v[6], data.v[7]);
+		} else {
+			SWAP(data.v[4], data.v[7]);
+			SWAP(data.v[5], data.v[6]);
+		}
+		break;
+
+	/* Single-precision FP load and store require conversions... */
+	case LD+F+S:
+#ifdef CONFIG_PPC_FPU
+		preempt_disable();
+		enable_kernel_fp();
+		cvt_fd((float *)&data.v[4], &data.dd, &current->thread);
+		preempt_enable();
+#else
+		return 0;
+#endif
+		break;
+	case ST+F+S:
+#ifdef CONFIG_PPC_FPU
+		preempt_disable();
+		enable_kernel_fp();
+		cvt_df(&data.dd, (float *)&data.v[4], &current->thread);
+		preempt_enable();
+#else
+		return 0;
+#endif
+		break;
+	}
+
+	/* Store result to memory or update registers */
+	if (flags & ST) {
+		ret = 0;
+		p = addr;
+		switch (nb) {
+		case 8:
+			ret |= __put_user(data.v[0], p++);
+			ret |= __put_user(data.v[1], p++);
+			ret |= __put_user(data.v[2], p++);
+			ret |= __put_user(data.v[3], p++);
+		case 4:
+			ret |= __put_user(data.v[4], p++);
+			ret |= __put_user(data.v[5], p++);
+		case 2:
+			ret |= __put_user(data.v[6], p++);
+			ret |= __put_user(data.v[7], p++);
+		}
+		if (unlikely(ret))
+			return -EFAULT;
+	} else if (flags & F)
+		current->thread.fpr[reg] = data.dd;
+	else
+		regs->gpr[reg] = data.ll;
+
+	/* Update RA as needed */
+	if (flags & U)
+		regs->gpr[areg] = regs->dar;
+
+	return 1;
+}
Index: linux-work/arch/ppc/kernel/Makefile
===================================================================
--- linux-work.orig/arch/ppc/kernel/Makefile	2005-11-11 10:14:48.000000000 +1100
+++ linux-work/arch/ppc/kernel/Makefile	2005-11-15 14:31:22.000000000 +1100
@@ -13,7 +13,7 @@
 extra-y				+= vmlinux.lds
 
 obj-y				:= entry.o traps.o idle.o time.o misc.o \
-					process.o align.o \
+					process.o \
 					setup.o \
 					ppc_htab.o
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
Index: linux-work/arch/ppc64/kernel/Makefile
===================================================================
--- linux-work.orig/arch/ppc64/kernel/Makefile	2005-11-15 14:30:34.000000000 +1100
+++ linux-work/arch/ppc64/kernel/Makefile	2005-11-15 14:31:37.000000000 +1100
@@ -2,6 +2,6 @@
 # Makefile for the linux ppc64 kernel.
 #
 
-obj-y               +=	idle.o align.o
+obj-y               +=	idle.o
 
 obj-$(CONFIG_PPC_MULTIPLATFORM) += nvram.o
Index: linux-work/include/asm-powerpc/cputable.h
===================================================================
--- linux-work.orig/include/asm-powerpc/cputable.h	2005-11-11 10:14:49.000000000 +1100
+++ linux-work/include/asm-powerpc/cputable.h	2005-11-15 14:31:22.000000000 +1100
@@ -90,6 +90,7 @@
 #define CPU_FTR_NEED_COHERENT		ASM_CONST(0x0000000000020000)
 #define CPU_FTR_NO_BTIC			ASM_CONST(0x0000000000040000)
 #define CPU_FTR_BIG_PHYS		ASM_CONST(0x0000000000080000)
+#define CPU_FTR_NODSISRALIGN  		ASM_CONST(0x0000000000100000)
 
 #ifdef __powerpc64__
 /* Add the 64b processor unique features in the top half of the word */
@@ -97,7 +98,6 @@
 #define CPU_FTR_16M_PAGE      		ASM_CONST(0x0000000200000000)
 #define CPU_FTR_TLBIEL         		ASM_CONST(0x0000000400000000)
 #define CPU_FTR_NOEXECUTE     		ASM_CONST(0x0000000800000000)
-#define CPU_FTR_NODSISRALIGN  		ASM_CONST(0x0000001000000000)
 #define CPU_FTR_IABR  			ASM_CONST(0x0000002000000000)
 #define CPU_FTR_MMCRA  			ASM_CONST(0x0000004000000000)
 #define CPU_FTR_CTRL			ASM_CONST(0x0000008000000000)
@@ -113,7 +113,6 @@
 #define CPU_FTR_16M_PAGE      		ASM_CONST(0x0)
 #define CPU_FTR_TLBIEL         		ASM_CONST(0x0)
 #define CPU_FTR_NOEXECUTE     		ASM_CONST(0x0)
-#define CPU_FTR_NODSISRALIGN  		ASM_CONST(0x0)
 #define CPU_FTR_IABR  			ASM_CONST(0x0)
 #define CPU_FTR_MMCRA  			ASM_CONST(0x0)
 #define CPU_FTR_CTRL			ASM_CONST(0x0)
@@ -273,18 +272,21 @@
 	CPU_FTRS_POWER3_32 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
 	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
 	CPU_FTRS_POWER4_32 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
-	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
+	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE | CPU_FTR_NODSISRALIGN,
 	CPU_FTRS_970_32 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
 	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE | CPU_FTR_ALTIVEC_COMP |
-	    CPU_FTR_MAYBE_CAN_NAP,
+	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN,
 	CPU_FTRS_8XX = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-	CPU_FTRS_40X = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-	CPU_FTRS_44X = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
-	CPU_FTRS_E200 = CPU_FTR_USE_TB,
-	CPU_FTRS_E500 = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
+	CPU_FTRS_40X = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+	    CPU_FTR_NODSISRALIGN,
+	CPU_FTRS_44X = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+	    CPU_FTR_NODSISRALIGN,
+	CPU_FTRS_E200 = CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN,
+	CPU_FTRS_E500 = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+	    CPU_FTR_NODSISRALIGN,
 	CPU_FTRS_E500_2 = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
-	    CPU_FTR_BIG_PHYS,
-	CPU_FTRS_GENERIC_32 = CPU_FTR_COMMON,
+	    CPU_FTR_BIG_PHYS | CPU_FTR_NODSISRALIGN,
+	CPU_FTRS_GENERIC_32 = CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN,
 #ifdef __powerpc64__
 	CPU_FTRS_POWER3 = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_IABR,
Index: linux-work/arch/ppc64/kernel/align.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/align.c	2005-11-15 14:30:34.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,396 +0,0 @@
-/* align.c - handle alignment exceptions for the Power PC.
- *
- * Copyright (c) 1996 Paul Mackerras <paulus@cs.anu.edu.au>
- * Copyright (c) 1998-1999 TiVo, Inc.
- *   PowerPC 403GCX modifications.
- * Copyright (c) 1999 Grant Erickson <grant@lcse.umn.edu>
- *   PowerPC 403GCX/405GP modifications.
- * Copyright (c) 2001-2002 PPC64 team, IBM Corp
- *   64-bit and Power4 support
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <asm/processor.h>
-#include <asm/uaccess.h>
-#include <asm/system.h>
-#include <asm/cache.h>
-#include <asm/cputable.h>
-
-struct aligninfo {
-	unsigned char len;
-	unsigned char flags;
-};
-
-#define IS_XFORM(inst)	(((inst) >> 26) == 31)
-#define IS_DSFORM(inst)	(((inst) >> 26) >= 56)
-
-#define INVALID	{ 0, 0 }
-
-#define LD	1	/* load */
-#define ST	2	/* store */
-#define	SE	4	/* sign-extend value */
-#define F	8	/* to/from fp regs */
-#define U	0x10	/* update index register */
-#define M	0x20	/* multiple load/store */
-#define SW	0x40	/* byte swap */
-
-#define DCBZ	0x5f	/* 8xx/82xx dcbz faults when cache not enabled */
-
-/*
- * The PowerPC stores certain bits of the instruction that caused the
- * alignment exception in the DSISR register.  This array maps those
- * bits to information about the operand length and what the
- * instruction would do.
- */
-static struct aligninfo aligninfo[128] = {
-	{ 4, LD },		/* 00 0 0000: lwz / lwarx */
-	INVALID,		/* 00 0 0001 */
-	{ 4, ST },		/* 00 0 0010: stw */
-	INVALID,		/* 00 0 0011 */
-	{ 2, LD },		/* 00 0 0100: lhz */
-	{ 2, LD+SE },		/* 00 0 0101: lha */
-	{ 2, ST },		/* 00 0 0110: sth */
-	{ 4, LD+M },		/* 00 0 0111: lmw */
-	{ 4, LD+F },		/* 00 0 1000: lfs */
-	{ 8, LD+F },		/* 00 0 1001: lfd */
-	{ 4, ST+F },		/* 00 0 1010: stfs */
-	{ 8, ST+F },		/* 00 0 1011: stfd */
-	INVALID,		/* 00 0 1100 */
-	{ 8, LD },		/* 00 0 1101: ld */
-	INVALID,		/* 00 0 1110 */
-	{ 8, ST },		/* 00 0 1111: std */
-	{ 4, LD+U },		/* 00 1 0000: lwzu */
-	INVALID,		/* 00 1 0001 */
-	{ 4, ST+U },		/* 00 1 0010: stwu */
-	INVALID,		/* 00 1 0011 */
-	{ 2, LD+U },		/* 00 1 0100: lhzu */
-	{ 2, LD+SE+U },		/* 00 1 0101: lhau */
-	{ 2, ST+U },		/* 00 1 0110: sthu */
-	{ 4, ST+M },		/* 00 1 0111: stmw */
-	{ 4, LD+F+U },		/* 00 1 1000: lfsu */
-	{ 8, LD+F+U },		/* 00 1 1001: lfdu */
-	{ 4, ST+F+U },		/* 00 1 1010: stfsu */
-	{ 8, ST+F+U },		/* 00 1 1011: stfdu */
-	INVALID,		/* 00 1 1100 */
-	INVALID,		/* 00 1 1101 */
-	INVALID,		/* 00 1 1110 */
-	INVALID,		/* 00 1 1111 */
-	{ 8, LD },		/* 01 0 0000: ldx */
-	INVALID,		/* 01 0 0001 */
-	{ 8, ST },		/* 01 0 0010: stdx */
-	INVALID,		/* 01 0 0011 */
-	INVALID,		/* 01 0 0100 */
-	{ 4, LD+SE },		/* 01 0 0101: lwax */
-	INVALID,		/* 01 0 0110 */
-	INVALID,		/* 01 0 0111 */
-	{ 0, LD },		/* 01 0 1000: lswx */
-	{ 0, LD },		/* 01 0 1001: lswi */
-	{ 0, ST },		/* 01 0 1010: stswx */
-	{ 0, ST },		/* 01 0 1011: stswi */
-	INVALID,		/* 01 0 1100 */
-	{ 8, LD+U },		/* 01 0 1101: ldu */
-	INVALID,		/* 01 0 1110 */
-	{ 8, ST+U },		/* 01 0 1111: stdu */
-	{ 8, LD+U },		/* 01 1 0000: ldux */
-	INVALID,		/* 01 1 0001 */
-	{ 8, ST+U },		/* 01 1 0010: stdux */
-	INVALID,		/* 01 1 0011 */
-	INVALID,		/* 01 1 0100 */
-	{ 4, LD+SE+U },		/* 01 1 0101: lwaux */
-	INVALID,		/* 01 1 0110 */
-	INVALID,		/* 01 1 0111 */
-	INVALID,		/* 01 1 1000 */
-	INVALID,		/* 01 1 1001 */
-	INVALID,		/* 01 1 1010 */
-	INVALID,		/* 01 1 1011 */
-	INVALID,		/* 01 1 1100 */
-	INVALID,		/* 01 1 1101 */
-	INVALID,		/* 01 1 1110 */
-	INVALID,		/* 01 1 1111 */
-	INVALID,		/* 10 0 0000 */
-	INVALID,		/* 10 0 0001 */
-	{ 0, ST },		/* 10 0 0010: stwcx. */
-	INVALID,		/* 10 0 0011 */
-	INVALID,		/* 10 0 0100 */
-	INVALID,		/* 10 0 0101 */
-	INVALID,		/* 10 0 0110 */
-	INVALID,		/* 10 0 0111 */
-	{ 4, LD+SW },		/* 10 0 1000: lwbrx */
-	INVALID,		/* 10 0 1001 */
-	{ 4, ST+SW },		/* 10 0 1010: stwbrx */
-	INVALID,		/* 10 0 1011 */
-	{ 2, LD+SW },		/* 10 0 1100: lhbrx */
-	{ 4, LD+SE },		/* 10 0 1101  lwa */
-	{ 2, ST+SW },		/* 10 0 1110: sthbrx */
-	INVALID,		/* 10 0 1111 */
-	INVALID,		/* 10 1 0000 */
-	INVALID,		/* 10 1 0001 */
-	INVALID,		/* 10 1 0010 */
-	INVALID,		/* 10 1 0011 */
-	INVALID,		/* 10 1 0100 */
-	INVALID,		/* 10 1 0101 */
-	INVALID,		/* 10 1 0110 */
-	INVALID,		/* 10 1 0111 */
-	INVALID,		/* 10 1 1000 */
-	INVALID,		/* 10 1 1001 */
-	INVALID,		/* 10 1 1010 */
-	INVALID,		/* 10 1 1011 */
-	INVALID,		/* 10 1 1100 */
-	INVALID,		/* 10 1 1101 */
-	INVALID,		/* 10 1 1110 */
-	{ L1_CACHE_BYTES, ST },	/* 10 1 1111: dcbz */
-	{ 4, LD },		/* 11 0 0000: lwzx */
-	INVALID,		/* 11 0 0001 */
-	{ 4, ST },		/* 11 0 0010: stwx */
-	INVALID,		/* 11 0 0011 */
-	{ 2, LD },		/* 11 0 0100: lhzx */
-	{ 2, LD+SE },		/* 11 0 0101: lhax */
-	{ 2, ST },		/* 11 0 0110: sthx */
-	INVALID,		/* 11 0 0111 */
-	{ 4, LD+F },		/* 11 0 1000: lfsx */
-	{ 8, LD+F },		/* 11 0 1001: lfdx */
-	{ 4, ST+F },		/* 11 0 1010: stfsx */
-	{ 8, ST+F },		/* 11 0 1011: stfdx */
-	INVALID,		/* 11 0 1100 */
-	{ 8, LD+M },		/* 11 0 1101: lmd */
-	INVALID,		/* 11 0 1110 */
-	{ 8, ST+M },		/* 11 0 1111: stmd */
-	{ 4, LD+U },		/* 11 1 0000: lwzux */
-	INVALID,		/* 11 1 0001 */
-	{ 4, ST+U },		/* 11 1 0010: stwux */
-	INVALID,		/* 11 1 0011 */
-	{ 2, LD+U },		/* 11 1 0100: lhzux */
-	{ 2, LD+SE+U },		/* 11 1 0101: lhaux */
-	{ 2, ST+U },		/* 11 1 0110: sthux */
-	INVALID,		/* 11 1 0111 */
-	{ 4, LD+F+U },		/* 11 1 1000: lfsux */
-	{ 8, LD+F+U },		/* 11 1 1001: lfdux */
-	{ 4, ST+F+U },		/* 11 1 1010: stfsux */
-	{ 8, ST+F+U },		/* 11 1 1011: stfdux */
-	INVALID,		/* 11 1 1100 */
-	INVALID,		/* 11 1 1101 */
-	INVALID,		/* 11 1 1110 */
-	INVALID,		/* 11 1 1111 */
-};
-
-#define SWAP(a, b)	(t = (a), (a) = (b), (b) = t)
-
-static inline unsigned make_dsisr(unsigned instr)
-{
-	unsigned dsisr;
-	
-	/* create a DSISR value from the instruction */
-	dsisr = (instr & 0x03ff0000) >> 16;			/* bits  6:15 --> 22:31 */
-	
-	if ( IS_XFORM(instr) ) {
-		dsisr |= (instr & 0x00000006) << 14;		/* bits 29:30 --> 15:16 */
-		dsisr |= (instr & 0x00000040) << 8;		/* bit     25 -->    17 */
-		dsisr |= (instr & 0x00000780) << 3;		/* bits 21:24 --> 18:21 */
-	}
-	else {
-		dsisr |= (instr & 0x04000000) >> 12;		/* bit      5 -->    17 */
-		dsisr |= (instr & 0x78000000) >> 17;		/* bits  1: 4 --> 18:21 */
-		if ( IS_DSFORM(instr) ) {
-			dsisr |= (instr & 0x00000003) << 18;	/* bits 30:31 --> 12:13 */
-		}
-	}
-	
-	return dsisr;
-}
-
-int
-fix_alignment(struct pt_regs *regs)
-{
-	unsigned int instr, nb, flags;
-	int t;
-	unsigned long reg, areg;
-	unsigned long i;
-	int ret;
-	unsigned dsisr;
-	unsigned char __user *addr;
-	unsigned char __user *p;
-	unsigned long __user *lp;
-	union {
-		long ll;
-		double dd;
-		unsigned char v[8];
-		struct {
-			unsigned hi32;
-			int	 low32;
-		} x32;
-		struct {
-			unsigned char hi48[6];
-			short	      low16;
-		} x16;
-	} data;
-
-	/*
-	 * Return 1 on success
-	 * Return 0 if unable to handle the interrupt
-	 * Return -EFAULT if data address is bad
-	 */
-
-	dsisr = regs->dsisr;
-
-	if (cpu_has_feature(CPU_FTR_NODSISRALIGN)) {
-	    unsigned int real_instr;
-	    if (__get_user(real_instr, (unsigned int __user *)regs->nip))
-		return 0;
-	    dsisr = make_dsisr(real_instr);
-	}
-
-	/* extract the operation and registers from the dsisr */
-	reg = (dsisr >> 5) & 0x1f;	/* source/dest register */
-	areg = dsisr & 0x1f;		/* register to update */
-	instr = (dsisr >> 10) & 0x7f;
-	instr |= (dsisr >> 13) & 0x60;
-
-	/* Lookup the operation in our table */
-	nb = aligninfo[instr].len;
-	flags = aligninfo[instr].flags;
-
-	/* DAR has the operand effective address */
-	addr = (unsigned char __user *)regs->dar;
-
-	/* A size of 0 indicates an instruction we don't support */
-	/* we also don't support the multiples (lmw, stmw, lmd, stmd) */
-	if ((nb == 0) || (flags & M))
-		return 0;		/* too hard or invalid instruction */
-
-	/*
-	 * Special handling for dcbz
-	 * dcbz may give an alignment exception for accesses to caching inhibited
-	 * storage
-	 */
-	if (instr == DCBZ)
-		addr = (unsigned char __user *) ((unsigned long)addr & -L1_CACHE_BYTES);
-
-	/* Verify the address of the operand */
-	if (user_mode(regs)) {
-		if (!access_ok((flags & ST? VERIFY_WRITE: VERIFY_READ), addr, nb))
-			return -EFAULT;	/* bad address */
-	}
-
-	/* Force the fprs into the save area so we can reference them */
-	if (flags & F) {
-		if (!user_mode(regs))
-			return 0;
-		flush_fp_to_thread(current);
-	}
-	
-	/* If we are loading, get the data from user space */
-	if (flags & LD) {
-		data.ll = 0;
-		ret = 0;
-		p = addr;
-		switch (nb) {
-		case 8:
-			ret |= __get_user(data.v[0], p++);
-			ret |= __get_user(data.v[1], p++);
-			ret |= __get_user(data.v[2], p++);
-			ret |= __get_user(data.v[3], p++);
-		case 4:
-			ret |= __get_user(data.v[4], p++);
-			ret |= __get_user(data.v[5], p++);
-		case 2:
-			ret |= __get_user(data.v[6], p++);
-			ret |= __get_user(data.v[7], p++);
-			if (ret)
-				return -EFAULT;
-		}
-	}
-	
-	/* If we are storing, get the data from the saved gpr or fpr */
-	if (flags & ST) {
-		if (flags & F) {
-			if (nb == 4) {
-				/* Doing stfs, have to convert to single */
-				preempt_disable();
-				enable_kernel_fp();
-				cvt_df(&current->thread.fpr[reg], (float *)&data.v[4], &current->thread);
-				disable_kernel_fp();
-				preempt_enable();
-			}
-			else
-				data.dd = current->thread.fpr[reg];
-		}
-		else 
-			data.ll = regs->gpr[reg];
-	}
-	
-	/* Swap bytes as needed */
-	if (flags & SW) {
-		if (nb == 2)
-			SWAP(data.v[6], data.v[7]);
-		else {	/* nb must be 4 */
-			SWAP(data.v[4], data.v[7]);
-			SWAP(data.v[5], data.v[6]);
-		}
-	}
-	
-	/* Sign extend as needed */
-	if (flags & SE) {
-		if ( nb == 2 )
-			data.ll = data.x16.low16;
-		else	/* nb must be 4 */
-			data.ll = data.x32.low32;
-	}
-	
-	/* If we are loading, move the data to the gpr or fpr */
-	if (flags & LD) {
-		if (flags & F) {
-			if (nb == 4) {
-				/* Doing lfs, have to convert to double */
-				preempt_disable();
-				enable_kernel_fp();
-				cvt_fd((float *)&data.v[4], &current->thread.fpr[reg], &current->thread);
-				disable_kernel_fp();
-				preempt_enable();
-			}
-			else
-				current->thread.fpr[reg] = data.dd;
-		}
-		else
-			regs->gpr[reg] = data.ll;
-	}
-	
-	/* If we are storing, copy the data to the user */
-	if (flags & ST) {
-		ret = 0;
-		p = addr;
-		switch (nb) {
-		case 128:	/* Special case - must be dcbz */
-			lp = (unsigned long __user *)p;
-			for (i = 0; i < L1_CACHE_BYTES / sizeof(long); ++i)
-				ret |= __put_user(0, lp++);
-			break;
-		case 8:
-			ret |= __put_user(data.v[0], p++);
-			ret |= __put_user(data.v[1], p++);
-			ret |= __put_user(data.v[2], p++);
-			ret |= __put_user(data.v[3], p++);
-		case 4:
-			ret |= __put_user(data.v[4], p++);
-			ret |= __put_user(data.v[5], p++);
-		case 2:
-			ret |= __put_user(data.v[6], p++);
-			ret |= __put_user(data.v[7], p++);
-		}
-		if (ret)
-			return -EFAULT;
-	}
-	
-	/* Update RA as needed */
-	if (flags & U) {
-		regs->gpr[areg] = regs->dar;
-	}
-
-	return 1;
-}
-
