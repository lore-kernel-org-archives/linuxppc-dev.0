Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 52/63] powerpc: Add little endian support to alignment handler
Date: Wed,  7 Aug 2013 02:02:09 +1000
Message-Id: <1375804940-22050-53-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Handle most unaligned load and store faults in little
endian mode. Strings, multiples and VSX are not supported.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/align.c | 93 ++++++++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index edc179f..0a1a8f2 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -262,6 +262,7 @@ static int emulate_dcbz(struct pt_regs *regs, unsigned char __user *addr)
 
 #define SWIZ_PTR(p)		((unsigned char __user *)((p) ^ swiz))
 
+#ifdef __BIG_ENDIAN__
 static int emulate_multiple(struct pt_regs *regs, unsigned char __user *addr,
 			    unsigned int reg, unsigned int nb,
 			    unsigned int flags, unsigned int instr,
@@ -390,6 +391,7 @@ static int emulate_fp_pair(unsigned char __user *addr, unsigned int reg,
 		return -EFAULT;
 	return 1;	/* exception handled and fixed up */
 }
+#endif
 
 #ifdef CONFIG_SPE
 
@@ -628,7 +630,7 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
 }
 #endif /* CONFIG_SPE */
 
-#ifdef CONFIG_VSX
+#if defined(CONFIG_VSX) && defined(__BIG_ENDIAN__)
 /*
  * Emulate VSX instructions...
  */
@@ -698,18 +700,28 @@ int fix_alignment(struct pt_regs *regs)
 	unsigned int dsisr;
 	unsigned char __user *addr;
 	unsigned long p, swiz;
-	int ret;
-	union {
+	int ret, i;
+	union data {
 		u64 ll;
 		double dd;
 		unsigned char v[8];
 		struct {
+#ifdef __LITTLE_ENDIAN__
+			int	 low32;
+			unsigned hi32;
+#else
 			unsigned hi32;
 			int	 low32;
+#endif
 		} x32;
 		struct {
+#ifdef __LITTLE_ENDIAN__
+			short	      low16;
+			unsigned char hi48[6];
+#else
 			unsigned char hi48[6];
 			short	      low16;
+#endif
 		} x16;
 	} data;
 
@@ -768,8 +780,9 @@ int fix_alignment(struct pt_regs *regs)
 
 	/* Byteswap little endian loads and stores */
 	swiz = 0;
-	if (regs->msr & MSR_LE) {
+	if ((regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE)) {
 		flags ^= SW;
+#ifdef __BIG_ENDIAN__
 		/*
 		 * So-called "PowerPC little endian" mode works by
 		 * swizzling addresses rather than by actually doing
@@ -782,11 +795,13 @@ int fix_alignment(struct pt_regs *regs)
 		 */
 		if (cpu_has_feature(CPU_FTR_PPC_LE))
 			swiz = 7;
+#endif
 	}
 
 	/* DAR has the operand effective address */
 	addr = (unsigned char __user *)regs->dar;
 
+#ifdef __BIG_ENDIAN__
 #ifdef CONFIG_VSX
 	if ((instruction & 0xfc00003e) == 0x7c000018) {
 		unsigned int elsize;
@@ -806,7 +821,7 @@ int fix_alignment(struct pt_regs *regs)
 			elsize = 8;
 
 		flags = 0;
-		if (regs->msr & MSR_LE)
+		if ((regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE))
 			flags |= SW;
 		if (instruction & 0x100)
 			flags |= ST;
@@ -821,6 +836,9 @@ int fix_alignment(struct pt_regs *regs)
 		return emulate_vsx(addr, reg, areg, regs, flags, nb, elsize);
 	}
 #endif
+#else
+	return -EFAULT;
+#endif
 	/* A size of 0 indicates an instruction we don't support, with
 	 * the exception of DCBZ which is handled as a special case here
 	 */
@@ -835,9 +853,13 @@ int fix_alignment(struct pt_regs *regs)
 	 * function
 	 */
 	if (flags & M) {
+#ifdef __BIG_ENDIAN__
 		PPC_WARN_ALIGNMENT(multiple, regs);
 		return emulate_multiple(regs, addr, reg, nb,
 					flags, instr, swiz);
+#else
+		return -EFAULT;
+#endif
 	}
 
 	/* Verify the address of the operand */
@@ -856,8 +878,12 @@ int fix_alignment(struct pt_regs *regs)
 
 	/* Special case for 16-byte FP loads and stores */
 	if (nb == 16) {
+#ifdef __BIG_ENDIAN__
 		PPC_WARN_ALIGNMENT(fp_pair, regs);
 		return emulate_fp_pair(addr, reg, flags);
+#else
+		return -EFAULT;
+#endif
 	}
 
 	PPC_WARN_ALIGNMENT(unaligned, regs);
@@ -866,24 +892,28 @@ int fix_alignment(struct pt_regs *regs)
 	 * get it from register values
 	 */
 	if (!(flags & ST)) {
-		data.ll = 0;
-		ret = 0;
-		p = (unsigned long) addr;
+		unsigned int start = 0;
+
 		switch (nb) {
-		case 8:
-			ret |= __get_user_inatomic(data.v[0], SWIZ_PTR(p++));
-			ret |= __get_user_inatomic(data.v[1], SWIZ_PTR(p++));
-			ret |= __get_user_inatomic(data.v[2], SWIZ_PTR(p++));
-			ret |= __get_user_inatomic(data.v[3], SWIZ_PTR(p++));
 		case 4:
-			ret |= __get_user_inatomic(data.v[4], SWIZ_PTR(p++));
-			ret |= __get_user_inatomic(data.v[5], SWIZ_PTR(p++));
+			start = offsetof(union data, x32.low32);
+			break;
 		case 2:
-			ret |= __get_user_inatomic(data.v[6], SWIZ_PTR(p++));
-			ret |= __get_user_inatomic(data.v[7], SWIZ_PTR(p++));
-			if (unlikely(ret))
-				return -EFAULT;
+			start = offsetof(union data, x16.low16);
+			break;
 		}
+
+		data.ll = 0;
+		ret = 0;
+		p = (unsigned long)addr;
+
+		for (i = 0; i < nb; i++)
+			ret |= __get_user_inatomic(data.v[start + i],
+						   SWIZ_PTR(p++));
+
+		if (unlikely(ret))
+			return -EFAULT;
+
 	} else if (flags & F) {
 		data.dd = current->thread.TS_FPR(reg);
 		if (flags & S) {
@@ -941,21 +971,24 @@ int fix_alignment(struct pt_regs *regs)
 
 	/* Store result to memory or update registers */
 	if (flags & ST) {
-		ret = 0;
-		p = (unsigned long) addr;
+		unsigned int start = 0;
+
 		switch (nb) {
-		case 8:
-			ret |= __put_user_inatomic(data.v[0], SWIZ_PTR(p++));
-			ret |= __put_user_inatomic(data.v[1], SWIZ_PTR(p++));
-			ret |= __put_user_inatomic(data.v[2], SWIZ_PTR(p++));
-			ret |= __put_user_inatomic(data.v[3], SWIZ_PTR(p++));
 		case 4:
-			ret |= __put_user_inatomic(data.v[4], SWIZ_PTR(p++));
-			ret |= __put_user_inatomic(data.v[5], SWIZ_PTR(p++));
+			start = offsetof(union data, x32.low32);
+			break;
 		case 2:
-			ret |= __put_user_inatomic(data.v[6], SWIZ_PTR(p++));
-			ret |= __put_user_inatomic(data.v[7], SWIZ_PTR(p++));
+			start = offsetof(union data, x16.low16);
+			break;
 		}
+
+		ret = 0;
+		p = (unsigned long)addr;
+
+		for (i = 0; i < nb; i++)
+			ret |= __put_user_inatomic(data.v[start + i],
+						   SWIZ_PTR(p++));
+
 		if (unlikely(ret))
 			return -EFAULT;
 	} else if (flags & F)
-- 
1.8.1.2
