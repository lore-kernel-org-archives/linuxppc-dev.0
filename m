Return-Path: <paulus@ozlabs.org>
Date: Thu, 20 May 2010 22:49:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH] powerpc: Emulate most load and store instructions in
	emulate_step()
Message-ID: <20100520124955.GA29903@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "K.Prasad" <prasad@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This extends the emulate_step() function to handle most of the load
and store instructions implemented on current 64-bit server processors.
The aim is to handle all the load and store instructions used in the
kernel, so this handles the Altivec/VMX lvx and stvx and the VSX
lxv2dx and stxv2dx instructions (implemented in POWER7).

The new code can emulate user mode instructions, and checks the
effective address for a load or store if the saved state is for
user mode.  It doesn't handle little-endian mode at present.

For floating-point, Altivec/VMX and VSX instructions, it checks
that the saved MSR has the enable bit for the relevant facility
set, and if so, assumes that the FP/VMX/VSX registers contain
valid state, and does loads or stores directly to/from the
FP/VMX/VSX registers, using assembly helpers in ldstfp.S.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/lib/Makefile |    4 +-
 arch/powerpc/lib/ldstfp.S |  207 +++++++++++++
 arch/powerpc/lib/sstep.c  |  753 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 937 insertions(+), 27 deletions(-)
 create mode 100644 arch/powerpc/lib/ldstfp.S

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 3040dac..7581dbf 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -18,8 +18,8 @@ obj-$(CONFIG_HAS_IOMEM)	+= devres.o
 
 obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
 			   memcpy_64.o usercopy_64.o mem_64.o string.o
-obj-$(CONFIG_XMON)	+= sstep.o
-obj-$(CONFIG_KPROBES)	+= sstep.o
+obj-$(CONFIG_XMON)	+= sstep.o ldstfp.o
+obj-$(CONFIG_KPROBES)	+= sstep.o ldstfp.o
 
 ifeq ($(CONFIG_PPC64),y)
 obj-$(CONFIG_SMP)	+= locks.o
diff --git a/arch/powerpc/lib/ldstfp.S b/arch/powerpc/lib/ldstfp.S
new file mode 100644
index 0000000..a462767
--- /dev/null
+++ b/arch/powerpc/lib/ldstfp.S
@@ -0,0 +1,207 @@
+/*
+ * Floating-point, VMX/Altivec and VSX loads and stores
+ * for use in instruction emulation.
+ *
+ * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+#include <asm/reg.h>
+#include <asm/asm-offsets.h>
+#include <linux/errno.h>
+
+	 .macro	inst32	op
+	 reg = 0
+	 .rept	32
+20:	\op	reg,0,r4
+	b	3f
+	.section __ex_table,"a"
+	PPC_LONG 20b,99f
+	.previous
+	reg = reg + 1
+	.endr
+	.endm
+
+/* Load FP reg N from float at *p.  N is in r3, p in r4. */
+_GLOBAL(do_lfs)
+	mflr	r0
+	mfmsr	r6
+	ori	r7,r6,MSR_FP
+	rlwinm	r3,r3,3,0xf8
+	bcl	20,31,2f
+1:	inst32	lfsx
+2:	mflr	r5
+	mtlr	r0
+	add	r8,r3,r5
+	mtctr	r8
+	li	r3,0
+	mtmsrd	r7
+	isync
+	bctr
+99:	li	r3,-EFAULT
+3:	mtmsrd	r6
+	blr
+
+/* Load FP reg N from double at *p.  N is in r3, p in r4. */
+_GLOBAL(do_lfd)
+	mflr	r0
+	mfmsr	r6
+	ori	r7,r6,MSR_FP
+	rlwinm	r3,r3,3,0xf8
+	bcl	20,31,2f
+1:	inst32	lfdx
+2:	mflr	r5
+	mtlr	r0
+	add	r8,r3,r5
+	mtctr	r8
+	li	r3,0
+	mtmsrd	r7
+	isync
+	bctr
+99:	li	r3,-EFAULT
+3:	mtmsrd	r6
+	blr
+
+
+/* Store FP reg N to float at *p.  N is in r3, p in r4. */
+_GLOBAL(do_stfs)
+	mflr	r0
+	mfmsr	r6
+	ori	r7,r6,MSR_FP
+	rlwinm	r3,r3,3,0xf8
+	bcl	20,31,2f
+1:	inst32	stfsx
+2:	mflr	r5
+	mtlr	r0
+	add	r8,r3,r5
+	mtctr	r8
+	li	r3,0
+	mtmsrd	r7
+	isync
+	bctr
+99:	li	r3,-EFAULT
+3:	mtmsrd	r6
+	blr
+
+/* Store FP reg N to double at *p.  N is in r3, p in r4. */
+_GLOBAL(do_stfd)
+	mflr	r0
+	mfmsr	r6
+	ori	r7,r6,MSR_FP
+	rlwinm	r3,r3,3,0xf8
+	bcl	20,31,2f
+1:	inst32	stfdx
+2:	mflr	r5
+	mtlr	r0
+	add	r8,r3,r5
+	mtctr	r8
+	li	r3,0
+	mtmsrd	r7
+	isync
+	bctr
+99:	li	r3,-EFAULT
+3:	mtmsrd	r6
+	blr
+
+#ifdef CONFIG_ALTIVEC
+/* Load vector reg N from *p.  N is in r3, p in r4. */
+_GLOBAL(do_lvx)
+	mflr	r0
+	mfmsr	r6
+	oris	r7,r6,MSR_VEC@h
+	rlwinm	r3,r3,3,0xf8
+	bcl	20,31,2f
+1:	inst32	lvx
+2:	mflr	r5
+	mtlr	r0
+	add	r8,r3,r5
+	mtctr	r8
+	li	r3,0
+	mtmsrd	r7
+	isync
+	bctr
+3:	mtmsrd	r6
+	blr
+
+/* Store vector reg N to *p.  N is in r3, p in r4. */
+_GLOBAL(do_stvx)
+	mflr	r0
+	mfmsr	r6
+	oris	r7,r6,MSR_VEC@h
+	rlwinm	r3,r3,3,0xf8
+	bcl	20,31,2f
+1:	inst32	stvx
+2:	mflr	r5
+	mtlr	r0
+	add	r8,r3,r5
+	mtctr	r8
+	li	r3,0
+	mtmsrd	r7
+	isync
+	bctr
+99:	li	r3,-EFAULT
+3:	mtmsrd	r6
+	blr
+#endif /* CONFIG_ALTIVEC */
+
+#ifdef CONFIG_VSX
+
+	.macro	inst64	opcode
+	reg = 0
+	.rept	64
+20:	.long	\opcode + ((reg & 0x1f) << 21) + ((reg >> 5) & 1) + (4 << 11)
+	b	3f
+	.section __ex_table,"a"
+	PPC_LONG 20b,99f
+	.previous
+	reg = reg + 1
+	.endr
+	.endm
+
+/* Load VSX reg N from vector doubleword *p.  N is in r3, p in r4. */
+_GLOBAL(do_lxvd2x)
+	mflr	r0
+	mfmsr	r6
+	oris	r7,r6,MSR_VSX@h
+	rlwinm	r3,r3,3,0xf8
+	bcl	20,31,2f
+1:	inst64	PPC_INST_LXVD2X
+2:	mflr	r5
+	mtlr	r0
+	add	r8,r3,r5
+	mtctr	r8
+	li	r3,0
+	mtmsrd	r7
+	isync
+	bctr
+99:	li	r3,-EFAULT
+3:	mtmsrd	r6
+	blr
+
+/* Store VSX reg N to vector doubleword *p.  N is in r3, p in r4. */
+_GLOBAL(do_stxvd2x)
+	mflr	r0
+	mfmsr	r6
+	oris	r7,r6,MSR_VSX@h
+	rlwinm	r3,r3,3,0xf8
+	bcl	20,31,2f
+1:	inst64	PPC_INST_STXVD2X
+2:	mflr	r5
+	mtlr	r0
+	add	r8,r3,r5
+	mtctr	r8
+	li	r3,0
+	mtmsrd	r7
+	isync
+	bctr
+99:	li	r3,-EFAULT
+3:	mtmsrd	r6
+	blr
+
+#endif /* CONFIG_VSX */
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 13b7d54..6313313 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -13,6 +13,8 @@
 #include <linux/ptrace.h>
 #include <asm/sstep.h>
 #include <asm/processor.h>
+#include <asm/uaccess.h>
+#include <asm/cputable.h>
 
 extern char system_call_common[];
 
@@ -24,6 +26,18 @@ extern char system_call_common[];
 #endif
 
 /*
+ * Functions in ldstfp.S
+ */
+extern int do_lfs(int rn, unsigned long ea);
+extern int do_lfd(int rn, unsigned long ea);
+extern int do_stfs(int rn, unsigned long ea);
+extern int do_stfd(int rn, unsigned long ea);
+extern int do_lvx(int rn, unsigned long ea);
+extern int do_stvx(int rn, unsigned long ea);
+extern int do_lxvd2x(int rn, unsigned long ea);
+extern int do_stxvd2x(int rn, unsigned long ea);
+
+/*
  * Determine whether a conditional branch instruction would branch.
  */
 static int __kprobes branch_taken(unsigned int instr, struct pt_regs *regs)
@@ -47,15 +61,356 @@ static int __kprobes branch_taken(unsigned int instr, struct pt_regs *regs)
 }
 
 /*
- * Emulate instructions that cause a transfer of control.
+ * Calculate effective address for a D-form instruction
+ */
+static inline unsigned long dform_ea(unsigned int instr, struct pt_regs *regs)
+{
+	int ra;
+	unsigned long ea;
+
+	ra = (instr >> 16) & 0x1f;
+	ea = (signed short) instr;		/* sign-extend */
+	if (ra) {
+		ea += regs->gpr[ra];
+		if (instr & 0x04000000)		/* update forms */
+			regs->gpr[ra] = ea;
+	}
+#ifdef __powerpc64__
+	if (!(regs->msr & MSR_SF))
+		ea &= 0xffffffffUL;
+#endif
+	return ea;
+}
+
+/*
+ * Calculate effective address for a DS-form instruction
+ */
+static inline unsigned long dsform_ea(unsigned int instr, struct pt_regs *regs)
+{
+	int ra;
+	unsigned long ea;
+
+	ra = (instr >> 16) & 0x1f;
+	ea = (signed short) (instr & ~3);	/* sign-extend */
+	if (ra) {
+		ea += regs->gpr[ra];
+		if ((instr & 3) == 1)		/* update forms */
+			regs->gpr[ra] = ea;
+	}
+#ifdef __powerpc64__
+	if (!(regs->msr & MSR_SF))
+		ea &= 0xffffffffUL;
+#endif
+	return ea;
+}
+
+/*
+ * Calculate effective address for an X-form instruction
+ */
+static inline unsigned long xform_ea(unsigned int instr, struct pt_regs *regs)
+{
+	int ra, rb;
+	unsigned long ea;
+
+	ra = (instr >> 16) & 0x1f;
+	rb = (instr >> 11) & 0x1f;
+	ea = regs->gpr[rb];
+	if (ra) {
+		ea += regs->gpr[ra];
+		if (instr & 0x40)		/* update forms */
+			regs->gpr[ra] = ea;
+	}
+#ifdef __powerpc64__
+	if (!(regs->msr & MSR_SF))
+		ea &= 0xffffffffUL;
+#endif
+	return ea;
+}
+
+/*
+ * Return the largest power of 2, not greater than sizeof(unsigned long),
+ * such that x is a multiple of it.
+ */
+static inline unsigned long max_align(unsigned long x)
+{
+	x |= sizeof(unsigned long);
+	return x & -x;		/* isolates rightmost bit */
+}
+
+
+static inline unsigned long byterev_2(unsigned long x)
+{
+	return ((x >> 8) & 0xff) | ((x & 0xff) << 8);
+}
+
+static inline unsigned long byterev_4(unsigned long x)
+{
+	return ((x >> 24) & 0xff) | ((x >> 8) & 0xff00) |
+		((x & 0xff00) << 8) | ((x & 0xff) << 24);
+}
+
+#ifdef __powerpc64__
+static inline unsigned long byterev_8(unsigned long x)
+{
+	return (byterev_4(x) << 32) | byterev_4(x >> 32);
+}
+#endif
+
+static inline int read_mem_aligned(unsigned long *dest, unsigned long ea,
+				   int nb)
+{
+	int err = 0;
+	unsigned long x = 0;
+
+	switch (nb) {
+	case 1:
+		err = __get_user(x, (unsigned char __user *) ea);
+		break;
+	case 2:
+		err = __get_user(x, (unsigned short __user *) ea);
+		break;
+	case 4:
+		err = __get_user(x, (unsigned int __user *) ea);
+		break;
+#ifdef __powerpc64__
+	case 8:
+		err = __get_user(x, (unsigned long __user *) ea);
+		break;
+#endif
+	}
+	if (!err)
+		*dest = x;
+	return err;
+}
+
+static int __kprobes read_mem_unaligned(unsigned long *dest, unsigned long ea,
+					int nb, struct pt_regs *regs)
+{
+	int err;
+	unsigned long x, b, c;
+
+	/* unaligned, do this in pieces */
+	x = 0;
+	for (; nb > 0; nb -= c) {
+		c = max_align(ea);
+		if (c > nb)
+			c = max_align(nb);
+		err = read_mem_aligned(&b, ea, c);
+		if (err)
+			return err;
+		x = (x << (8 * c)) + b;
+		ea += c;
+	}
+	*dest = x;
+	return 0;
+}
+
+/*
+ * Read memory at address ea for nb bytes, return 0 for success
+ * or -EFAULT if an error occurred.
+ */
+static inline int read_mem(unsigned long *dest, unsigned long ea, int nb,
+			   struct pt_regs *regs)
+{
+	if (user_mode(regs) && !access_ok(VERIFY_READ, ea, nb))
+		return -EFAULT;
+	if ((ea & (nb - 1)) == 0)
+		return read_mem_aligned(dest, ea, nb);
+	return read_mem_unaligned(dest, ea, nb, regs);
+}
+
+static inline int write_mem_aligned(unsigned long val, unsigned long ea,
+				    int nb)
+{
+	int err = 0;
+
+	switch (nb) {
+	case 1:
+		err = __put_user(val, (unsigned char __user *) ea);
+		break;
+	case 2:
+		err = __put_user(val, (unsigned short __user *) ea);
+		break;
+	case 4:
+		err = __put_user(val, (unsigned int __user *) ea);
+		break;
+#ifdef __powerpc64__
+	case 8:
+		err = __put_user(val, (unsigned long __user *) ea);
+		break;
+#endif
+	}
+	return err;
+}
+
+static int __kprobes write_mem_unaligned(unsigned long val, unsigned long ea,
+					 int nb, struct pt_regs *regs)
+{
+	int err;
+	unsigned long c;
+
+	/* unaligned or little-endian, do this in pieces */
+	for (; nb > 0; nb -= c) {
+		c = max_align(ea);
+		if (c > nb)
+			c = max_align(nb);
+		err = write_mem_aligned(val >> (nb - c) * 8, ea, c);
+		if (err)
+			return err;
+		++ea;
+	}
+	return 0;
+}
+
+/*
+ * Write memory at address ea for nb bytes, return 0 for success
+ * or -EFAULT if an error occurred.
+ */
+static inline int write_mem(unsigned long val, unsigned long ea, int nb,
+			    struct pt_regs *regs)
+{
+	if (user_mode(regs) && !access_ok(VERIFY_WRITE, ea, nb))
+		return -EFAULT;
+	if ((ea & (nb - 1)) == 0)
+		return write_mem_aligned(val, ea, nb);
+	return write_mem_unaligned(val, ea, nb, regs);
+}
+
+/*
+ * Check the address and alignment, and call func to do the actual
+ * load or store.
+ */
+static int __kprobes do_fp_load(int rn, int (*func)(int, unsigned long),
+				unsigned long ea, int nb,
+				struct pt_regs *regs)
+{
+	int err;
+	unsigned long val[sizeof(double) / sizeof(long)];
+	unsigned long ptr;
+
+	if (user_mode(regs) && !access_ok(VERIFY_READ, ea, nb))
+		return -EFAULT;
+	if ((ea & 3) == 0)
+		return (*func)(rn, ea);
+	ptr = (unsigned long) &val[0];
+	if (sizeof(unsigned long) == 8 || nb == 4) {
+		err = read_mem_unaligned(&val[0], ea, nb, regs);
+		ptr += sizeof(unsigned long) - nb;
+	} else {
+		/* reading a double on 32-bit */
+		err = read_mem_unaligned(&val[0], ea, 4, regs);
+		if (!err)
+			err = read_mem_unaligned(&val[1], ea + 4, 4, regs);
+	}
+	if (err)
+		return err;
+	return (*func)(rn, ptr);
+}
+
+static int __kprobes do_fp_store(int rn, int (*func)(int, unsigned long),
+				 unsigned long ea, int nb,
+				 struct pt_regs *regs)
+{
+	int err;
+	unsigned long val[sizeof(double) / sizeof(long)];
+	unsigned long ptr;
+
+	if (user_mode(regs) && !access_ok(VERIFY_WRITE, ea, nb))
+		return -EFAULT;
+	if ((ea & 3) == 0)
+		return (*func)(rn, ea);
+	ptr = (unsigned long) &val[0];
+	if (sizeof(unsigned long) == 8 || nb == 4) {
+		ptr += sizeof(unsigned long) - nb;
+		err = (*func)(rn, ptr);
+		if (err)
+			return err;
+		err = write_mem_unaligned(val[0], ea, nb, regs);
+	} else {
+		/* writing a double on 32-bit */
+		err = (*func)(rn, ptr);
+		if (err)
+			return err;
+		err = write_mem_unaligned(val[0], ea, 4, regs);
+		if (!err)
+			err = write_mem_unaligned(val[1], ea + 4, 4, regs);
+	}
+	return err;
+}
+
+#ifdef CONFIG_ALTIVEC
+/* For Altivec/VMX, no need to worry about alignment */
+static inline int do_vec_load(int rn, int (*func)(int, unsigned long),
+			      unsigned long ea, struct pt_regs *regs)
+{
+	if (user_mode(regs) && !access_ok(VERIFY_READ, ea & ~0xfUL, 16))
+		return -EFAULT;
+	return (*func)(rn, ea);
+}
+
+static inline int do_vec_store(int rn, int (*func)(int, unsigned long),
+			       unsigned long ea, struct pt_regs *regs)
+{
+	if (user_mode(regs) && !access_ok(VERIFY_WRITE, ea & ~0xfUL, 16))
+		return -EFAULT;
+	return (*func)(rn, ea);
+}
+#endif /* CONFIG_ALTIVEC */
+
+#ifdef CONFIG_VSX
+static int __kprobes do_vsx_load(int rn, int (*func)(int, unsigned long),
+				 unsigned long ea, struct pt_regs *regs)
+{
+	int err;
+	unsigned long val[2];
+
+	if (user_mode(regs) && !access_ok(VERIFY_READ, ea, 16))
+		return -EFAULT;
+	if ((ea & 3) == 0)
+		return (*func)(rn, ea);
+	err = read_mem_unaligned(&val[0], ea, 8, regs);
+	if (!err)
+		err = read_mem_unaligned(&val[1], ea + 8, 8, regs);
+	if (!err)
+		err = (*func)(rn, (unsigned long) &val[0]);
+	return err;
+}
+
+static int __kprobes do_vsx_store(int rn, int (*func)(int, unsigned long),
+				 unsigned long ea, struct pt_regs *regs)
+{
+	int err;
+	unsigned long val[2];
+
+	if (user_mode(regs) && !access_ok(VERIFY_WRITE, ea, 16))
+		return -EFAULT;
+	if ((ea & 3) == 0)
+		return (*func)(rn, ea);
+	err = (*func)(rn, (unsigned long) &val[0]);
+	if (err)
+		return err;
+	err = write_mem_unaligned(val[0], ea, 8, regs);
+	if (!err)
+		err = write_mem_unaligned(val[1], ea + 8, 8, regs);
+	return err;
+}
+#endif /* CONFIG_VSX */
+
+/*
+ * Emulate instructions that cause a transfer of control,
+ * loads and stores, and a few other instructions.
  * Returns 1 if the step was emulated, 0 if not,
  * or -1 if the instruction is one that should not be stepped,
  * such as an rfid, or a mtmsrd that would clear MSR_RI.
  */
 int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 {
-	unsigned int opcode, rs, rb, rd, spr;
+	unsigned int opcode, rs, ra, rb, rd, spr;
 	unsigned long int imm;
+	unsigned long int val;
+	unsigned long int ea;
+	int err;
+	mm_segment_t oldfs;
 
 	opcode = instr >> 26;
 	switch (opcode) {
@@ -78,7 +433,13 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		 * entry code works.  If that is changed, this will
 		 * need to be changed also.
 		 */
+		if (regs->gpr[0] == 0x1ebe &&
+		    cpu_has_feature(CPU_FTR_REAL_LE)) {
+			regs->msr ^= MSR_LE;
+			goto instr_done;
+		}
 		regs->gpr[9] = regs->gpr[13];
+		regs->gpr[10] = MSR_KERNEL;
 		regs->gpr[11] = regs->nip + 4;
 		regs->gpr[12] = regs->msr & MSR_MASK;
 		regs->gpr[13] = (unsigned long) get_paca();
@@ -119,27 +480,35 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		case 0x24:	/* rfid, scary */
 			return -1;
 		}
-	case 31:
-		rd = (instr >> 21) & 0x1f;
+	}
+
+	/* Following cases refer to regs->gpr[], so we need all regs */
+	if (!FULL_REGS(regs))
+		return 0;
+
+	rd = (instr >> 21) & 0x1f;
+	if (opcode == 31) {
 		switch (instr & 0x7fe) {
 		case 0xa6:	/* mfmsr */
+			if (regs->msr & MSR_PR)
+				break;
 			regs->gpr[rd] = regs->msr & MSR_MASK;
-			regs->nip += 4;
-			if ((regs->msr & MSR_SF) == 0)
-				regs->nip &= 0xffffffffUL;
-			return 1;
+			goto instr_done;
 		case 0x124:	/* mtmsr */
+			if (regs->msr & MSR_PR)
+				break;
 			imm = regs->gpr[rd];
 			if ((imm & MSR_RI) == 0)
 				/* can't step mtmsr that would clear MSR_RI */
 				return -1;
 			regs->msr = imm;
-			regs->nip += 4;
-			return 1;
+			goto instr_done;
 #ifdef CONFIG_PPC64
 		case 0x164:	/* mtmsrd */
 			/* only MSR_EE and MSR_RI get changed if bit 15 set */
 			/* mtmsrd doesn't change MSR_HV and MSR_ME */
+			if (regs->msr & MSR_PR)
+				break;
 			imm = (instr & 0x10000)? 0x8002: 0xefffffffffffefffUL;
 			imm = (regs->msr & MSR_MASK & ~imm)
 				| (regs->gpr[rd] & imm);
@@ -147,28 +516,25 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 				/* can't step mtmsrd that would clear MSR_RI */
 				return -1;
 			regs->msr = imm;
-			regs->nip += 4;
-			if ((imm & MSR_SF) == 0)
-				regs->nip &= 0xffffffffUL;
-			return 1;
+			goto instr_done;
 #endif
 		case 0x26:	/* mfcr */
 			regs->gpr[rd] = regs->ccr;
 			regs->gpr[rd] &= 0xffffffffUL;
-			goto mtspr_out;
+			goto instr_done;
 		case 0x2a6:	/* mfspr */
 			spr = (instr >> 11) & 0x3ff;
 			switch (spr) {
 			case 0x20:	/* mfxer */
 				regs->gpr[rd] = regs->xer;
 				regs->gpr[rd] &= 0xffffffffUL;
-				goto mtspr_out;
+				goto instr_done;
 			case 0x100:	/* mflr */
 				regs->gpr[rd] = regs->link;
-				goto mtspr_out;
+				goto instr_done;
 			case 0x120:	/* mfctr */
 				regs->gpr[rd] = regs->ctr;
-				goto mtspr_out;
+				goto instr_done;
 			}
 			break;
 		case 0x378:	/* orx */
@@ -179,7 +545,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 			if (rs == rb) {		/* mr */
 				rd = (instr >> 16) & 0x1f;
 				regs->gpr[rd] = regs->gpr[rs];
-				goto mtspr_out;
+				goto instr_done;
 			}
 			break;
 		case 0x3a6:	/* mtspr */
@@ -187,17 +553,354 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 			switch (spr) {
 			case 0x20:	/* mtxer */
 				regs->xer = (regs->gpr[rd] & 0xffffffffUL);
-				goto mtspr_out;
+				goto instr_done;
 			case 0x100:	/* mtlr */
 				regs->link = regs->gpr[rd];
-				goto mtspr_out;
+				goto instr_done;
 			case 0x120:	/* mtctr */
 				regs->ctr = regs->gpr[rd];
-mtspr_out:
-				regs->nip += 4;
-				return 1;
+				goto instr_done;
 			}
+			break;
 		}
 	}
-	return 0;
+
+	/*
+	 * Following cases are for loads and stores, so bail out
+	 * if we're in little-endian mode.
+	 */
+	if (regs->msr & MSR_LE)
+		return 0;
+
+	/*
+	 * Make sure access_ok() checks against TASK_SIZE
+	 */
+	oldfs = get_fs();
+	set_fs(USER_DS);
+
+	switch (opcode) {
+	case 31:
+		switch (instr & 0x7fe) {
+#ifdef __powerpc64__
+		case 0x2a:	/* ldx */
+		case 0x6a:	/* ldux */
+			err = read_mem(&regs->gpr[rd], xform_ea(instr, regs),
+				       8, regs);
+			goto ldst_done;
+#endif
+
+		case 0x2e:	/* lwzx */
+		case 0x6e:	/* lwzux */
+			err = read_mem(&regs->gpr[rd], xform_ea(instr, regs),
+				       4, regs);
+			goto ldst_done;
+
+		case 0xae:	/* lbzx */
+		case 0xee:	/* lbzux */
+			err = read_mem(&regs->gpr[rd], xform_ea(instr, regs),
+				       1, regs);
+			goto ldst_done;
+
+#ifdef CONFIG_ALTIVEC
+		case 0xce:	/* lvx */
+		case 0x2ce:	/* lvxl */
+			if (!(regs->msr & MSR_VEC))
+				break;
+			ea = xform_ea(instr, regs);
+			err = do_vec_load(rd, do_lvx, ea, regs);
+			goto ldst_done;
+
+		case 0x1ce:	/* stvx */
+		case 0x3ce:	/* stvxl */
+			if (!(regs->msr & MSR_VEC))
+				break;
+			ea = xform_ea(instr, regs);
+			err = do_vec_store(rd, do_stvx, ea, regs);
+			goto ldst_done;
+#endif /* CONFIG_ALTIVEC */
+
+#ifdef __powerpc64__
+		case 0x12a:	/* stdx */
+		case 0x16a:	/* stdux */
+			val = regs->gpr[rd];
+			err = write_mem(val, xform_ea(instr, regs), 8, regs);
+			goto ldst_done;
+#endif
+
+		case 0x12e:	/* stwx */
+		case 0x16e:	/* stwux */
+			val = regs->gpr[rd];
+			err = write_mem(val, xform_ea(instr, regs), 4, regs);
+			goto ldst_done;
+
+		case 0x1ae:	/* stbx */
+		case 0x1ee:	/* stbux */
+			val = regs->gpr[rd];
+			err = write_mem(val, xform_ea(instr, regs), 1, regs);
+			goto ldst_done;
+
+		case 0x22e:	/* lhzx */
+		case 0x26e:	/* lhzux */
+			err = read_mem(&regs->gpr[rd], xform_ea(instr, regs),
+				       2, regs);
+			goto ldst_done;
+
+#ifdef __powerpc64__
+		case 0x2aa:	/* lwax */
+		case 0x2ea:	/* lwaux */
+			err = read_mem(&regs->gpr[rd], xform_ea(instr, regs),
+				       8, regs);
+			if (!err)
+				regs->gpr[rd] = (signed int) regs->gpr[rd];
+			goto ldst_done;
+#endif
+
+		case 0x2ae:	/* lhax */
+		case 0x2ee:	/* lhaux */
+			err = read_mem(&regs->gpr[rd], xform_ea(instr, regs),
+				       2, regs);
+			if (!err)
+				regs->gpr[rd] = (signed short) regs->gpr[rd];
+			goto ldst_done;
+
+		case 0x32e:	/* sthx */
+		case 0x36e:	/* sthux */
+			val = regs->gpr[rd];
+			err = write_mem(val, xform_ea(instr, regs), 2, regs);
+			goto ldst_done;
+
+#ifdef __powerpc64__
+		case 0x428:	/* ldbrx */
+			err = read_mem(&val, xform_ea(instr, regs), 8, regs);
+			if (!err)
+				regs->gpr[rd] = byterev_8(val);
+			goto ldst_done;
+
+#endif
+
+		case 0x42c:	/* lwbrx */
+			err = read_mem(&val, xform_ea(instr, regs), 4, regs);
+			if (!err)
+				regs->gpr[rd] = byterev_4(val);
+			goto ldst_done;
+
+		case 0x42e:	/* lfsx */
+		case 0x46e:	/* lfsux */
+			if (!(regs->msr & MSR_FP))
+				break;
+			ea = xform_ea(instr, regs);
+			err = do_fp_load(rd, do_lfs, ea, 4, regs);
+			goto ldst_done;
+
+		case 0x4ae:	/* lfdx */
+		case 0x4ee:	/* lfdux */
+			if (!(regs->msr & MSR_FP))
+				break;
+			ea = xform_ea(instr, regs);
+			err = do_fp_load(rd, do_lfd, ea, 8, regs);
+			goto ldst_done;
+
+		case 0x52e:	/* stfsx */
+		case 0x56e:	/* stfsux */
+			if (!(regs->msr & MSR_FP))
+				break;
+			ea = xform_ea(instr, regs);
+			err = do_fp_store(rd, do_stfs, ea, 4, regs);
+			goto ldst_done;
+
+		case 0x5ae:	/* stfdx */
+		case 0x5ee:	/* stfdux */
+			if (!(regs->msr & MSR_FP))
+				break;
+			ea = xform_ea(instr, regs);
+			err = do_fp_store(rd, do_stfd, ea, 8, regs);
+			goto ldst_done;
+
+#ifdef __powerpc64__
+		case 0x528:	/* stdbrx */
+			val = byterev_8(regs->gpr[rd]);
+			err = write_mem(val, xform_ea(instr, regs), 8, regs);
+			goto ldst_done;
+
+#endif
+		case 0x52c:	/* stwbrx */
+			val = byterev_4(regs->gpr[rd]);
+			err = write_mem(val, xform_ea(instr, regs), 4, regs);
+			goto ldst_done;
+
+		case 0x62c:	/* lhbrx */
+			err = read_mem(&val, xform_ea(instr, regs), 2, regs);
+			if (!err)
+				regs->gpr[rd] = byterev_2(val);
+			goto ldst_done;
+
+		case 0x72c:	/* sthbrx */
+			val = byterev_2(regs->gpr[rd]);
+			err = write_mem(val, xform_ea(instr, regs), 2, regs);
+			goto ldst_done;
+
+#ifdef CONFIG_VSX
+		case 0x698:	/* lxvd2x */
+		case 0x6d8:	/* lxvd2ux */
+			if (!(regs->msr & MSR_VSX))
+				break;
+			rd |= (instr & 1) << 5;
+			ea = xform_ea(instr, regs);
+			err = do_vsx_load(rd, do_lxvd2x, ea, regs);
+			goto ldst_done;
+
+		case 0x798:	/* stxvd2x */
+		case 0x7d8:	/* stxvd2ux */
+			if (!(regs->msr & MSR_VSX))
+				break;
+			rd |= (instr & 1) << 5;
+			ea = xform_ea(instr, regs);
+			err = do_vsx_store(rd, do_stxvd2x, ea, regs);
+			goto ldst_done;
+
+#endif /* CONFIG_VSX */
+		}
+		break;
+
+	case 32:	/* lwz */
+	case 33:	/* lwzu */
+		err = read_mem(&regs->gpr[rd], dform_ea(instr, regs), 4, regs);
+		goto ldst_done;
+
+	case 34:	/* lbz */
+	case 35:	/* lbzu */
+		err = read_mem(&regs->gpr[rd], dform_ea(instr, regs), 1, regs);
+		goto ldst_done;
+
+	case 36:	/* stw */
+	case 37:	/* stwu */
+		val = regs->gpr[rd];
+		err = write_mem(val, dform_ea(instr, regs), 4, regs);
+		goto ldst_done;
+
+	case 38:	/* stb */
+	case 39:	/* stbu */
+		val = regs->gpr[rd];
+		err = write_mem(val, dform_ea(instr, regs), 1, regs);
+		goto ldst_done;
+
+	case 40:	/* lhz */
+	case 41:	/* lhzu */
+		err = read_mem(&regs->gpr[rd], dform_ea(instr, regs), 2, regs);
+		goto ldst_done;
+
+	case 42:	/* lha */
+	case 43:	/* lhau */
+		err = read_mem(&regs->gpr[rd], dform_ea(instr, regs), 2, regs);
+		if (!err)
+			regs->gpr[rd] = (signed short) regs->gpr[rd];
+		goto ldst_done;
+
+	case 44:	/* sth */
+	case 45:	/* sthu */
+		err = write_mem(val, dform_ea(instr, regs), 2, regs);
+		goto ldst_done;
+
+	case 46:	/* lmw */
+		ra = (instr >> 16) & 0x1f;
+		if (ra >= rd)
+			break;		/* invalid form, ra in range to load */
+		ea = dform_ea(instr, regs);
+		do {
+			err = read_mem(&regs->gpr[rd], ea, 4, regs);
+			if (err)
+				return 0;
+			ea += 4;
+		} while (++rd < 32);
+		goto instr_done;
+
+	case 47:	/* stmw */
+		ea = dform_ea(instr, regs);
+		do {
+			err = write_mem(regs->gpr[rd], ea, 4, regs);
+			if (err)
+				return 0;
+			ea += 4;
+		} while (++rd < 32);
+		goto instr_done;
+
+	case 48:	/* lfs */
+	case 49:	/* lfsu */
+		if (!(regs->msr & MSR_FP))
+			break;
+		ea = dform_ea(instr, regs);
+		err = do_fp_load(rd, do_lfs, ea, 4, regs);
+		goto ldst_done;
+
+	case 50:	/* lfd */
+	case 51:	/* lfdu */
+		if (!(regs->msr & MSR_FP))
+			break;
+		ea = dform_ea(instr, regs);
+		err = do_fp_load(rd, do_lfd, ea, 8, regs);
+		goto ldst_done;
+
+	case 52:	/* stfs */
+	case 53:	/* stfsu */
+		if (!(regs->msr & MSR_FP))
+			break;
+		ea = dform_ea(instr, regs);
+		err = do_fp_store(rd, do_stfs, ea, 4, regs);
+		goto ldst_done;
+
+	case 54:	/* stfd */
+	case 55:	/* stfdu */
+		if (!(regs->msr & MSR_FP))
+			break;
+		ea = dform_ea(instr, regs);
+		err = do_fp_store(rd, do_stfd, ea, 8, regs);
+		goto ldst_done;
+
+#ifdef __powerpc64__
+	case 58:	/* ld[u], lwa */
+		switch (instr & 3) {
+		case 0:		/* ld */
+			err = read_mem(&regs->gpr[rd], dsform_ea(instr, regs),
+				       8, regs);
+			goto ldst_done;
+		case 1:		/* ldu */
+			err = read_mem(&regs->gpr[rd], dsform_ea(instr, regs),
+				       8, regs);
+			goto ldst_done;
+		case 2:		/* lwa */
+			err = read_mem(&regs->gpr[rd], dsform_ea(instr, regs),
+				       4, regs);
+			if (!err)
+				regs->gpr[rd] = (signed int) regs->gpr[rd];
+			goto ldst_done;
+		}
+		break;
+
+	case 62:	/* std[u] */
+		val = regs->gpr[rd];
+		switch (instr & 3) {
+		case 0:		/* ld */
+			err = write_mem(val, dsform_ea(instr, regs), 8, regs);
+			goto ldst_done;
+		case 1:		/* ldu */
+			err = write_mem(val, dsform_ea(instr, regs), 8, regs);
+			goto ldst_done;
+		}
+		break;
+#endif /* __powerpc64__ */
+
+	}
+	err = -EINVAL;
+
+ldst_done:
+	set_fs(oldfs);
+	if (err)
+		return 0;	/* invoke DSI if -EFAULT? */
+instr_done:
+	regs->nip += 4;
+#ifdef __powerpc64__
+	if ((regs->msr & MSR_SF) == 0)
+		regs->nip &= 0xffffffffUL;
+#endif
+	return 1;
 }
-- 
1.7.0.4
