Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17542.28368.426967.127506@cargo.ozlabs.ibm.com>
Date: Wed, 7 Jun 2006 16:14:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc: Implement support for setting
	little-endian mode via prctl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the PowerPC part of the code to allow processes to change
their endian mode via prctl.

This also extends the alignment exception handler to be able to fix up
alignment exceptions that occur in little-endian mode, both for
"PowerPC" little-endian and true little-endian.

We always enter signal handlers in big-endian mode -- the support for
little-endian mode does not amount to the creation of a little-endian
user/kernel ABI.  If the signal handler returns, the endian mode is
restored to what it was when the signal was delivered.

We have two new kernel CPU feature bits, one for PPC little-endian and
one for true little-endian.  Most of the classic 32-bit processors
support PPC little-endian, and this is reflected in the CPU feature
table.  There are two corresponding feature bits reported to userland
in the AT_HWCAP aux vector entry.

This is based on an earlier patch by Anton Blanchard.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index faaec9c..4734b5d 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -35,17 +35,19 @@ #define IS_DSFORM(inst)	(((inst) >> 26) 
 
 #define INVALID	{ 0, 0 }
 
-#define LD	1	/* load */
-#define ST	2	/* store */
-#define	SE	4	/* sign-extend value */
-#define F	8	/* to/from fp regs */
-#define U	0x10	/* update index register */
-#define M	0x20	/* multiple load/store */
-#define SW	0x40	/* byte swap int or ... */
-#define S	0x40	/* ... single-precision fp */
-#define SX	0x40	/* byte count in XER */
+/* Bits in the flags field */
+#define LD	0	/* load */
+#define ST	1	/* store */
+#define	SE	2	/* sign-extend value */
+#define F	4	/* to/from fp regs */
+#define U	8	/* update index register */
+#define M	0x10	/* multiple load/store */
+#define SW	0x20	/* byte swap */
+#define S	0x40	/* single-precision fp or... */
+#define SX	0x40	/* ... byte count in XER */
 #define HARD	0x80	/* string, stwcx. */
 
+/* DSISR bits reported for a DCBZ instruction: */
 #define DCBZ	0x5f	/* 8xx/82xx dcbz faults when cache not enabled */
 
 #define SWAP(a, b)	(t = (a), (a) = (b), (b) = t)
@@ -256,12 +258,16 @@ #else
 #define REG_BYTE(rp, i)		*((u8 *)(rp) + (i))
 #endif
 
+#define SWIZ_PTR(p)		((unsigned char __user *)((p) ^ swiz))
+
 static int emulate_multiple(struct pt_regs *regs, unsigned char __user *addr,
 			    unsigned int reg, unsigned int nb,
-			    unsigned int flags, unsigned int instr)
+			    unsigned int flags, unsigned int instr,
+			    unsigned long swiz)
 {
 	unsigned long *rptr;
-	unsigned int nb0, i;
+	unsigned int nb0, i, bswiz;
+	unsigned long p;
 
 	/*
 	 * We do not try to emulate 8 bytes multiple as they aren't really
@@ -280,9 +286,12 @@ static int emulate_multiple(struct pt_re
 			if (nb == 0)
 				return 1;
 		} else {
-			if (__get_user(instr,
-				       (unsigned int __user *)regs->nip))
+			unsigned long pc = regs->nip ^ (swiz & 4);
+
+			if (__get_user(instr, (unsigned int __user *)pc))
 				return -EFAULT;
+			if (swiz == 0 && (flags & SW))
+				instr = cpu_to_le32(instr);
 			nb = (instr >> 11) & 0x1f;
 			if (nb == 0)
 				nb = 32;
@@ -300,7 +309,10 @@ static int emulate_multiple(struct pt_re
 		return -EFAULT;	/* bad address */
 
 	rptr = &regs->gpr[reg];
-	if (flags & LD) {
+	p = (unsigned long) addr;
+	bswiz = (flags & SW)? 3: 0;
+
+	if (!(flags & ST)) {
 		/*
 		 * This zeroes the top 4 bytes of the affected registers
 		 * in 64-bit mode, and also zeroes out any remaining
@@ -311,26 +323,28 @@ static int emulate_multiple(struct pt_re
 			memset(&regs->gpr[0], 0,
 			       ((nb0 + 3) / 4) * sizeof(unsigned long));
 
-		for (i = 0; i < nb; ++i)
-			if (__get_user(REG_BYTE(rptr, i), addr + i))
+		for (i = 0; i < nb; ++i, ++p)
+			if (__get_user(REG_BYTE(rptr, i ^ bswiz), SWIZ_PTR(p)))
 				return -EFAULT;
 		if (nb0 > 0) {
 			rptr = &regs->gpr[0];
 			addr += nb;
-			for (i = 0; i < nb0; ++i)
-				if (__get_user(REG_BYTE(rptr, i), addr + i))
+			for (i = 0; i < nb0; ++i, ++p)
+				if (__get_user(REG_BYTE(rptr, i ^ bswiz),
+					       SWIZ_PTR(p)))
 					return -EFAULT;
 		}
 
 	} else {
-		for (i = 0; i < nb; ++i)
-			if (__put_user(REG_BYTE(rptr, i), addr + i))
+		for (i = 0; i < nb; ++i, ++p)
+			if (__put_user(REG_BYTE(rptr, i ^ bswiz), SWIZ_PTR(p)))
 				return -EFAULT;
 		if (nb0 > 0) {
 			rptr = &regs->gpr[0];
 			addr += nb;
-			for (i = 0; i < nb0; ++i)
-				if (__put_user(REG_BYTE(rptr, i), addr + i))
+			for (i = 0; i < nb0; ++i, ++p)
+				if (__put_user(REG_BYTE(rptr, i ^ bswiz),
+					       SWIZ_PTR(p)))
 					return -EFAULT;
 		}
 	}
@@ -352,7 +366,7 @@ int fix_alignment(struct pt_regs *regs)
 	unsigned int reg, areg;
 	unsigned int dsisr;
 	unsigned char __user *addr;
-	unsigned char __user *p;
+	unsigned long p, swiz;
 	int ret, t;
 	union {
 		u64 ll;
@@ -380,11 +394,15 @@ int fix_alignment(struct pt_regs *regs)
 	 * let's make one up from the instruction
 	 */
 	if (cpu_has_feature(CPU_FTR_NODSISRALIGN)) {
-		unsigned int real_instr;
-		if (unlikely(__get_user(real_instr,
-					(unsigned int __user *)regs->nip)))
+		unsigned long pc = regs->nip;
+
+		if (cpu_has_feature(CPU_FTR_PPC_LE) && (regs->msr & MSR_LE))
+			pc ^= 4;
+		if (unlikely(__get_user(instr, (unsigned int __user *)pc)))
 			return -EFAULT;
-		dsisr = make_dsisr(real_instr);
+		if (cpu_has_feature(CPU_FTR_REAL_LE) && (regs->msr & MSR_LE))
+			instr = cpu_to_le32(instr);
+		dsisr = make_dsisr(instr);
 	}
 
 	/* extract the operation and registers from the dsisr */
@@ -397,6 +415,24 @@ int fix_alignment(struct pt_regs *regs)
 	nb = aligninfo[instr].len;
 	flags = aligninfo[instr].flags;
 
+	/* Byteswap little endian loads and stores */
+	swiz = 0;
+	if (regs->msr & MSR_LE) {
+		flags ^= SW;
+		/*
+		 * So-called "PowerPC little endian" mode works by
+		 * swizzling addresses rather than by actually doing
+		 * any byte-swapping.  To emulate this, we XOR each
+		 * byte address with 7.  We also byte-swap, because
+		 * the processor's address swizzling depends on the
+		 * operand size (it xors the address with 7 for bytes,
+		 * 6 for halfwords, 4 for words, 0 for doublewords) but
+		 * we will xor with 7 and load/store each byte separately.
+		 */
+		if (cpu_has_feature(CPU_FTR_PPC_LE))
+			swiz = 7;
+	}
+
 	/* DAR has the operand effective address */
 	addr = (unsigned char __user *)regs->dar;
 
@@ -412,7 +448,8 @@ int fix_alignment(struct pt_regs *regs)
 	 * function
 	 */
 	if (flags & M)
-		return emulate_multiple(regs, addr, reg, nb, flags, instr);
+		return emulate_multiple(regs, addr, reg, nb,
+					flags, instr, swiz);
 
 	/* Verify the address of the operand */
 	if (unlikely(user_mode(regs) &&
@@ -431,51 +468,71 @@ int fix_alignment(struct pt_regs *regs)
 	/* If we are loading, get the data from user space, else
 	 * get it from register values
 	 */
-	if (flags & LD) {
+	if (!(flags & ST)) {
 		data.ll = 0;
 		ret = 0;
-		p = addr;
+		p = (unsigned long) addr;
 		switch (nb) {
 		case 8:
-			ret |= __get_user(data.v[0], p++);
-			ret |= __get_user(data.v[1], p++);
-			ret |= __get_user(data.v[2], p++);
-			ret |= __get_user(data.v[3], p++);
+			ret |= __get_user(data.v[0], SWIZ_PTR(p++));
+			ret |= __get_user(data.v[1], SWIZ_PTR(p++));
+			ret |= __get_user(data.v[2], SWIZ_PTR(p++));
+			ret |= __get_user(data.v[3], SWIZ_PTR(p++));
 		case 4:
-			ret |= __get_user(data.v[4], p++);
-			ret |= __get_user(data.v[5], p++);
+			ret |= __get_user(data.v[4], SWIZ_PTR(p++));
+			ret |= __get_user(data.v[5], SWIZ_PTR(p++));
 		case 2:
-			ret |= __get_user(data.v[6], p++);
-			ret |= __get_user(data.v[7], p++);
+			ret |= __get_user(data.v[6], SWIZ_PTR(p++));
+			ret |= __get_user(data.v[7], SWIZ_PTR(p++));
 			if (unlikely(ret))
 				return -EFAULT;
 		}
-	} else if (flags & F)
+	} else if (flags & F) {
 		data.dd = current->thread.fpr[reg];
-	else
+		if (flags & S) {
+			/* Single-precision FP store requires conversion... */
+#ifdef CONFIG_PPC_FPU
+			preempt_disable();
+			enable_kernel_fp();
+			cvt_df(&data.dd, (float *)&data.v[4], &current->thread);
+			preempt_enable();
+#else
+			return 0;
+#endif
+		}
+	} else
 		data.ll = regs->gpr[reg];
 
-	/* Perform other misc operations like sign extension, byteswap,
+	if (flags & SW) {
+		switch (nb) {
+		case 8:
+			SWAP(data.v[0], data.v[7]);
+			SWAP(data.v[1], data.v[6]);
+			SWAP(data.v[2], data.v[5]);
+			SWAP(data.v[3], data.v[4]);
+			break;
+		case 4:
+			SWAP(data.v[4], data.v[7]);
+			SWAP(data.v[5], data.v[6]);
+			break;
+		case 2:
+			SWAP(data.v[6], data.v[7]);
+			break;
+		}
+	}
+
+	/* Perform other misc operations like sign extension
 	 * or floating point single precision conversion
 	 */
-	switch (flags & ~U) {
+	switch (flags & ~(U|SW)) {
 	case LD+SE:	/* sign extend */
 		if ( nb == 2 )
 			data.ll = data.x16.low16;
 		else	/* nb must be 4 */
 			data.ll = data.x32.low32;
 		break;
-	case LD+S:	/* byte-swap */
-	case ST+S:
-		if (nb == 2) {
-			SWAP(data.v[6], data.v[7]);
-		} else {
-			SWAP(data.v[4], data.v[7]);
-			SWAP(data.v[5], data.v[6]);
-		}
-		break;
 
-	/* Single-precision FP load and store require conversions... */
+	/* Single-precision FP load requires conversion... */
 	case LD+F+S:
 #ifdef CONFIG_PPC_FPU
 		preempt_disable();
@@ -486,34 +543,24 @@ #else
 		return 0;
 #endif
 		break;
-	case ST+F+S:
-#ifdef CONFIG_PPC_FPU
-		preempt_disable();
-		enable_kernel_fp();
-		cvt_df(&data.dd, (float *)&data.v[4], &current->thread);
-		preempt_enable();
-#else
-		return 0;
-#endif
-		break;
 	}
 
 	/* Store result to memory or update registers */
 	if (flags & ST) {
 		ret = 0;
-		p = addr;
+		p = (unsigned long) addr;
 		switch (nb) {
 		case 8:
-			ret |= __put_user(data.v[0], p++);
-			ret |= __put_user(data.v[1], p++);
-			ret |= __put_user(data.v[2], p++);
-			ret |= __put_user(data.v[3], p++);
+			ret |= __put_user(data.v[0], SWIZ_PTR(p++));
+			ret |= __put_user(data.v[1], SWIZ_PTR(p++));
+			ret |= __put_user(data.v[2], SWIZ_PTR(p++));
+			ret |= __put_user(data.v[3], SWIZ_PTR(p++));
 		case 4:
-			ret |= __put_user(data.v[4], p++);
-			ret |= __put_user(data.v[5], p++);
+			ret |= __put_user(data.v[4], SWIZ_PTR(p++));
+			ret |= __put_user(data.v[5], SWIZ_PTR(p++));
 		case 2:
-			ret |= __put_user(data.v[6], p++);
-			ret |= __put_user(data.v[7], p++);
+			ret |= __put_user(data.v[6], SWIZ_PTR(p++));
+			ret |= __put_user(data.v[7], SWIZ_PTR(p++));
 		}
 		if (unlikely(ret))
 			return -EFAULT;
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 0c487ee..2a62d99 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -54,7 +54,8 @@ #define COMMON_USER_POWER5	(COMMON_USER_
 #define COMMON_USER_POWER5_PLUS	(COMMON_USER_PPC64 | PPC_FEATURE_POWER5_PLUS|\
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP)
 #define COMMON_USER_POWER6	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_05 |\
-				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP)
+				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
+				 PPC_FEATURE_TRUE_LE)
 #define COMMON_USER_BOOKE	(PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | \
 				 PPC_FEATURE_BOOKE)
 
@@ -74,7 +75,7 @@ #ifdef CONFIG_PPC64
 		.pvr_value		= 0x00400000,
 		.cpu_name		= "POWER3 (630)",
 		.cpu_features		= CPU_FTRS_POWER3,
-		.cpu_user_features	= COMMON_USER_PPC64,
+		.cpu_user_features	= COMMON_USER_PPC64|PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -87,7 +88,7 @@ #ifdef CONFIG_PPC64
 		.pvr_value		= 0x00410000,
 		.cpu_name		= "POWER3 (630+)",
 		.cpu_features		= CPU_FTRS_POWER3,
-		.cpu_user_features	= COMMON_USER_PPC64,
+		.cpu_user_features	= COMMON_USER_PPC64|PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -306,7 +307,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x00030000,
 		.cpu_name		= "603",
 		.cpu_features		= CPU_FTRS_603,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -317,7 +318,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x00060000,
 		.cpu_name		= "603e",
 		.cpu_features		= CPU_FTRS_603,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -328,7 +329,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x00070000,
 		.cpu_name		= "603ev",
 		.cpu_features		= CPU_FTRS_603,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -339,7 +340,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x00040000,
 		.cpu_name		= "604",
 		.cpu_features		= CPU_FTRS_604,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 2,
@@ -351,7 +352,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x00090000,
 		.cpu_name		= "604e",
 		.cpu_features		= CPU_FTRS_604,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -363,7 +364,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x00090000,
 		.cpu_name		= "604r",
 		.cpu_features		= CPU_FTRS_604,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -375,7 +376,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x000a0000,
 		.cpu_name		= "604ev",
 		.cpu_features		= CPU_FTRS_604,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -387,7 +388,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x00084202,
 		.cpu_name		= "740/750",
 		.cpu_features		= CPU_FTRS_740_NOTAU,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -399,7 +400,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x00080100,
 		.cpu_name		= "750CX",
 		.cpu_features		= CPU_FTRS_750,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -411,7 +412,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x00082200,
 		.cpu_name		= "750CX",
 		.cpu_features		= CPU_FTRS_750,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -423,7 +424,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x00082210,
 		.cpu_name		= "750CXe",
 		.cpu_features		= CPU_FTRS_750,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -435,7 +436,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x00083214,
 		.cpu_name		= "750CXe",
 		.cpu_features		= CPU_FTRS_750,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -447,7 +448,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x00083000,
 		.cpu_name		= "745/755",
 		.cpu_features		= CPU_FTRS_750,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -459,7 +460,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x70000100,
 		.cpu_name		= "750FX",
 		.cpu_features		= CPU_FTRS_750FX1,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -471,7 +472,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x70000200,
 		.cpu_name		= "750FX",
 		.cpu_features		= CPU_FTRS_750FX2,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -483,7 +484,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x70000000,
 		.cpu_name		= "750FX",
 		.cpu_features		= CPU_FTRS_750FX,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -495,7 +496,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x70020000,
 		.cpu_name		= "750GX",
 		.cpu_features		= CPU_FTRS_750GX,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -507,7 +508,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x00080000,
 		.cpu_name		= "740/750",
 		.cpu_features		= CPU_FTRS_740,
-		.cpu_user_features	= COMMON_USER,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -519,7 +520,8 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x000c1101,
 		.cpu_name		= "7400 (1.1)",
 		.cpu_features		= CPU_FTRS_7400_NOTAU,
-		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.cpu_user_features	= COMMON_USER |
+			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -531,7 +533,8 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x000c0000,
 		.cpu_name		= "7400",
 		.cpu_features		= CPU_FTRS_7400,
-		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.cpu_user_features	= COMMON_USER |
+			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -543,7 +546,8 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x800c0000,
 		.cpu_name		= "7410",
 		.cpu_features		= CPU_FTRS_7400,
-		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.cpu_user_features	= COMMON_USER |
+			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -555,7 +559,8 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x80000200,
 		.cpu_name		= "7450",
 		.cpu_features		= CPU_FTRS_7450_20,
-		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.cpu_user_features	= COMMON_USER |
+			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -569,7 +574,8 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x80000201,
 		.cpu_name		= "7450",
 		.cpu_features		= CPU_FTRS_7450_21,
-		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.cpu_user_features	= COMMON_USER |
+			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -583,7 +589,8 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x80000000,
 		.cpu_name		= "7450",
 		.cpu_features		= CPU_FTRS_7450_23,
-		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.cpu_user_features	= COMMON_USER |
+			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -597,7 +604,8 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x80010100,
 		.cpu_name		= "7455",
 		.cpu_features		= CPU_FTRS_7455_1,
-		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.cpu_user_features	= COMMON_USER |
+			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -611,7 +619,8 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x80010200,
 		.cpu_name		= "7455",
 		.cpu_features		= CPU_FTRS_7455_20,
-		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.cpu_user_features	= COMMON_USER |
+			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -625,7 +634,8 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x80010000,
 		.cpu_name		= "7455",
 		.cpu_features		= CPU_FTRS_7455,
-		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.cpu_user_features	= COMMON_USER |
+			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -639,7 +649,8 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x80020100,
 		.cpu_name		= "7447/7457",
 		.cpu_features		= CPU_FTRS_7447_10,
-		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.cpu_user_features	= COMMON_USER |
+			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -653,7 +664,8 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x80020101,
 		.cpu_name		= "7447/7457",
 		.cpu_features		= CPU_FTRS_7447_10,
-		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.cpu_user_features	= COMMON_USER |
+			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -667,7 +679,7 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x80020000,
 		.cpu_name		= "7447/7457",
 		.cpu_features		= CPU_FTRS_7447,
-		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -681,7 +693,8 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x80030000,
 		.cpu_name		= "7447A",
 		.cpu_features		= CPU_FTRS_7447A,
-		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.cpu_user_features	= COMMON_USER |
+			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -695,7 +708,8 @@ #if CLASSIC_PPC
 		.pvr_value		= 0x80040000,
 		.cpu_name		= "7448",
 		.cpu_features		= CPU_FTRS_7447A,
-		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.cpu_user_features	= COMMON_USER |
+			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 2dd47d2..e473245 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -708,6 +708,50 @@ #endif
 	return put_user(val, (unsigned int __user *) adr);
 }
 
+int set_endian(struct task_struct *tsk, unsigned int val)
+{
+	struct pt_regs *regs = tsk->thread.regs;
+
+	if ((val == PR_ENDIAN_LITTLE && !cpu_has_feature(CPU_FTR_REAL_LE)) ||
+	    (val == PR_ENDIAN_PPC_LITTLE && !cpu_has_feature(CPU_FTR_PPC_LE)))
+		return -EINVAL;
+
+	if (regs == NULL)
+		return -EINVAL;
+
+	if (val == PR_ENDIAN_BIG)
+		regs->msr &= ~MSR_LE;
+	else if (val == PR_ENDIAN_LITTLE || val == PR_ENDIAN_PPC_LITTLE)
+		regs->msr |= MSR_LE;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+int get_endian(struct task_struct *tsk, unsigned long adr)
+{
+	struct pt_regs *regs = tsk->thread.regs;
+	unsigned int val;
+
+	if (!cpu_has_feature(CPU_FTR_PPC_LE) &&
+	    !cpu_has_feature(CPU_FTR_REAL_LE))
+		return -EINVAL;
+
+	if (regs == NULL)
+		return -EINVAL;
+
+	if (regs->msr & MSR_LE) {
+		if (cpu_has_feature(CPU_FTR_REAL_LE))
+			val = PR_ENDIAN_LITTLE;
+		else
+			val = PR_ENDIAN_PPC_LITTLE;
+	} else
+		val = PR_ENDIAN_BIG;
+
+	return put_user(val, (unsigned int __user *)adr);
+}
+
 #define TRUNC_PTR(x)	((typeof(x))(((unsigned long)(x)) & 0xffffffff))
 
 int sys_clone(unsigned long clone_flags, unsigned long usp,
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 01e3c08..a885e25 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -419,9 +419,7 @@ static long restore_user_regs(struct pt_
 {
 	long err;
 	unsigned int save_r2 = 0;
-#if defined(CONFIG_ALTIVEC) || defined(CONFIG_SPE)
 	unsigned long msr;
-#endif
 
 	/*
 	 * restore general registers but not including MSR or SOFTE. Also
@@ -430,11 +428,16 @@ #endif
 	if (!sig)
 		save_r2 = (unsigned int)regs->gpr[2];
 	err = restore_general_regs(regs, sr);
+	err |= __get_user(msr, &sr->mc_gregs[PT_MSR]);
 	if (!sig)
 		regs->gpr[2] = (unsigned long) save_r2;
 	if (err)
 		return 1;
 
+	/* if doing signal return, restore the previous little-endian mode */
+	if (sig)
+		regs->msr = (regs->msr & ~MSR_LE) | (msr & MSR_LE);
+
 	/*
 	 * Do this before updating the thread state in
 	 * current->thread.fpr/vr/evr.  That way, if we get preempted
@@ -455,7 +458,7 @@ #ifdef CONFIG_ALTIVEC
 	/* force the process to reload the altivec registers from
 	   current->thread when it next does altivec instructions */
 	regs->msr &= ~MSR_VEC;
-	if (!__get_user(msr, &sr->mc_gregs[PT_MSR]) && (msr & MSR_VEC) != 0) {
+	if (msr & MSR_VEC) {
 		/* restore altivec registers from the stack */
 		if (__copy_from_user(current->thread.vr, &sr->mc_vregs,
 				     sizeof(sr->mc_vregs)))
@@ -472,7 +475,7 @@ #ifdef CONFIG_SPE
 	/* force the process to reload the spe registers from
 	   current->thread when it next does spe instructions */
 	regs->msr &= ~MSR_SPE;
-	if (!__get_user(msr, &sr->mc_gregs[PT_MSR]) && (msr & MSR_SPE) != 0) {
+	if (msr & MSR_SPE) {
 		/* restore spe registers from the stack */
 		if (__copy_from_user(current->thread.evr, &sr->mc_vregs,
 				     ELF_NEVRREG * sizeof(u32)))
@@ -777,6 +780,8 @@ static int handle_rt_signal(unsigned lon
 	regs->gpr[5] = (unsigned long) &rt_sf->uc;
 	regs->gpr[6] = (unsigned long) rt_sf;
 	regs->nip = (unsigned long) ka->sa.sa_handler;
+	/* enter the signal handler in big-endian mode */
+	regs->msr &= ~MSR_LE;
 	regs->trap = 0;
 	return 1;
 
@@ -1047,6 +1052,8 @@ #endif
 	regs->gpr[3] = sig;
 	regs->gpr[4] = (unsigned long) sc;
 	regs->nip = (unsigned long) ka->sa.sa_handler;
+	/* enter the signal handler in big-endian mode */
+	regs->msr &= ~MSR_LE;
 	regs->trap = 0;
 
 	return 1;
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 27f65b9..6801b19 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -141,9 +141,7 @@ #endif
 	unsigned long err = 0;
 	unsigned long save_r13 = 0;
 	elf_greg_t *gregs = (elf_greg_t *)regs;
-#ifdef CONFIG_ALTIVEC
 	unsigned long msr;
-#endif
 	int i;
 
 	/* If this is not a signal return, we preserve the TLS in r13 */
@@ -154,7 +152,12 @@ #endif
 	err |= __copy_from_user(regs, &sc->gp_regs,
 				PT_MSR*sizeof(unsigned long));
 
-	/* skip MSR and SOFTE */
+	/* get MSR separately, transfer the LE bit if doing signal return */
+	err |= __get_user(msr, &sc->gp_regs[PT_MSR]);
+	if (sig)
+		regs->msr = (regs->msr & ~MSR_LE) | (msr & MSR_LE);
+
+	/* skip SOFTE */
 	for (i = PT_MSR+1; i <= PT_RESULT; i++) {
 		if (i == PT_SOFTE)
 			continue;
@@ -179,7 +182,6 @@ #endif
 
 #ifdef CONFIG_ALTIVEC
 	err |= __get_user(v_regs, &sc->v_regs);
-	err |= __get_user(msr, &sc->gp_regs[PT_MSR]);
 	if (err)
 		return err;
 	/* Copy 33 vec registers (vr0..31 and vscr) from the stack */
@@ -410,6 +412,8 @@ static int setup_rt_frame(int signr, str
 
 	/* Set up "regs" so we "return" to the signal handler. */
 	err |= get_user(regs->nip, &funct_desc_ptr->entry);
+	/* enter the signal handler in big-endian mode */
+	regs->msr &= ~MSR_LE;
 	regs->gpr[1] = newsp;
 	err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
 	regs->gpr[3] = signr;
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 064a525..91a6e04 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -658,7 +658,7 @@ static int emulate_instruction(struct pt
 	u32 instword;
 	u32 rd;
 
-	if (!user_mode(regs))
+	if (!user_mode(regs) || (regs->msr & MSR_LE))
 		return -EINVAL;
 	CHECK_FULL_REGS(regs);
 
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 9fcf016..72ded03 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -24,6 +24,9 @@ #define PPC_FEATURE_SMT			0x00004000
 #define PPC_FEATURE_ICACHE_SNOOP	0x00002000
 #define PPC_FEATURE_ARCH_2_05		0x00001000
 
+#define PPC_FEATURE_TRUE_LE		0x00000002
+#define PPC_FEATURE_PPC_LE		0x00000001
+
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
@@ -104,6 +107,8 @@ #define CPU_FTR_NEED_COHERENT		ASM_CONST
 #define CPU_FTR_NO_BTIC			ASM_CONST(0x0000000000040000)
 #define CPU_FTR_BIG_PHYS		ASM_CONST(0x0000000000080000)
 #define CPU_FTR_NODSISRALIGN		ASM_CONST(0x0000000000100000)
+#define CPU_FTR_PPC_LE			ASM_CONST(0x0000000000200000)
+#define CPU_FTR_REAL_LE			ASM_CONST(0x0000000000400000)
 
 #ifdef __powerpc64__
 /* Add the 64b processor unique features in the top half of the word */
@@ -136,6 +141,7 @@ #define CPU_FTR_COHERENT_ICACHE		ASM_CON
 #define CPU_FTR_LOCKLESS_TLBIE		ASM_CONST(0x0)
 #define CPU_FTR_MMCRA_SIHV		ASM_CONST(0x0)
 #define CPU_FTR_CI_LARGE_PAGE		ASM_CONST(0x0)
+#define CPU_FTR_PAUSE_ZERO              ASM_CONST(0x0)
 #define CPU_FTR_PURR			ASM_CONST(0x0)
 #endif
 
@@ -192,92 +198,95 @@ #define CLASSIC_PPC (!defined(CONFIG_8xx
 #define CPU_FTRS_PPC601	(CPU_FTR_COMMON | CPU_FTR_601 | CPU_FTR_HPTE_TABLE)
 #define CPU_FTRS_603	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
-	    CPU_FTR_MAYBE_CAN_NAP)
+	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
 #define CPU_FTRS_604	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
-	    CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON | CPU_FTR_HPTE_TABLE)
+	    CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON | CPU_FTR_HPTE_TABLE | \
+	    CPU_FTR_PPC_LE)
 #define CPU_FTRS_740_NOTAU	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP)
+	    CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
 #define CPU_FTRS_740	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
-	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP)
+	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
+	    CPU_FTR_PPC_LE)
 #define CPU_FTRS_750	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
-	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP)
+	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
+	    CPU_FTR_PPC_LE)
 #define CPU_FTRS_750FX1	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
-	    CPU_FTR_DUAL_PLL_750FX | CPU_FTR_NO_DPM)
+	    CPU_FTR_DUAL_PLL_750FX | CPU_FTR_NO_DPM | CPU_FTR_PPC_LE)
 #define CPU_FTRS_750FX2	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
-	    CPU_FTR_NO_DPM)
+	    CPU_FTR_NO_DPM | CPU_FTR_PPC_LE)
 #define CPU_FTRS_750FX	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
-	    CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS)
+	    CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_PPC_LE)
 #define CPU_FTRS_750GX	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | \
 	    CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
-	    CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS)
+	    CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7400_NOTAU	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE | \
-	    CPU_FTR_MAYBE_CAN_NAP)
+	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7400	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_TAU | CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE | \
-	    CPU_FTR_MAYBE_CAN_NAP)
+	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7450_20	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
-	    CPU_FTR_NEED_COHERENT)
+	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7450_21	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP | \
-	    CPU_FTR_NEED_COHERENT)
+	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7450_23	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
-	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_NEED_COHERENT)
+	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7455_1	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS | \
-	    CPU_FTR_NEED_COHERENT)
+	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7455_20	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP | \
-	    CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS)
+	    CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7455	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
-	    CPU_FTR_NEED_COHERENT)
+	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7447_10	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
-	    CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC)
+	    CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7447	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
-	    CPU_FTR_NEED_COHERENT)
+	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7447A	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
-	    CPU_FTR_NEED_COHERENT)
+	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
 #define CPU_FTRS_82XX	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB)
 #define CPU_FTRS_G2_LE	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | \
@@ -307,7 +316,7 @@ #define CPU_FTRS_E500_2	(CPU_FTR_SPLIT_I
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 #ifdef __powerpc64__
 #define CPU_FTRS_POWER3	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_IABR)
+	    CPU_FTR_HPTE_TABLE | CPU_FTR_IABR | CPU_FTR_PPC_LE)
 #define CPU_FTRS_RS64	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_IABR | \
 	    CPU_FTR_MMCRA | CPU_FTR_CTRL)
@@ -325,7 +334,7 @@ #define CPU_FTRS_POWER6 (CPU_FTR_SPLIT_I
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
-	    CPU_FTR_PURR | CPU_FTR_CI_LARGE_PAGE)
+	    CPU_FTR_PURR | CPU_FTR_CI_LARGE_PAGE | CPU_FTR_REAL_LE)
 #define CPU_FTRS_CELL	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
diff --git a/include/asm-powerpc/processor.h b/include/asm-powerpc/processor.h
index 93f83ef..02b56f2 100644
--- a/include/asm-powerpc/processor.h
+++ b/include/asm-powerpc/processor.h
@@ -212,6 +212,12 @@ #define SET_FPEXC_CTL(tsk, val) set_fpex
 extern int get_fpexc_mode(struct task_struct *tsk, unsigned long adr);
 extern int set_fpexc_mode(struct task_struct *tsk, unsigned int val);
 
+#define GET_ENDIAN(tsk, adr) get_endian((tsk), (adr))
+#define SET_ENDIAN(tsk, val) set_endian((tsk), (val))
+
+extern int get_endian(struct task_struct *tsk, unsigned long adr);
+extern int set_endian(struct task_struct *tsk, unsigned int val);
+
 static inline unsigned int __unpack_fe01(unsigned long msr_bits)
 {
 	return ((msr_bits & MSR_FE0) >> 10) | ((msr_bits & MSR_FE1) >> 8);
