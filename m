Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8Ym42NDyzDsxc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 16:43:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v2] powerpc: EX_TABLE macro for exception tables
Date: Thu,  3 Nov 2016 16:43:12 +1100
Message-Id: <1478151792-13500-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

This macro is taken from s390, and allows more flexibility in
changing exception table format.

mpe: Put it in ppc_asm.h and only define one version using stringinfy_in_c().
Add some empty definitions and headers to keep the selftests happy.
Add some missing .previouses in fsl_rio.c and tsi108_pci.c.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/futex.h                   |  14 +-
 arch/powerpc/include/asm/io.h                      |  19 +-
 arch/powerpc/include/asm/ppc_asm.h                 |  10 +
 arch/powerpc/include/asm/uaccess.h                 |  25 +-
 arch/powerpc/include/asm/word-at-a-time.h          |   6 +-
 arch/powerpc/lib/checksum_32.S                     |  47 ++--
 arch/powerpc/lib/checksum_64.S                     |  20 +-
 arch/powerpc/lib/copy_32.S                         |  55 ++---
 arch/powerpc/lib/copyuser_64.S                     | 271 ++++++++++-----------
 arch/powerpc/lib/copyuser_power7.S                 |  20 +-
 arch/powerpc/lib/ldstfp.S                          |  24 +-
 arch/powerpc/lib/sstep.c                           |  15 +-
 arch/powerpc/lib/string.S                          |  11 +-
 arch/powerpc/lib/string_64.S                       |  16 +-
 arch/powerpc/sysdev/fsl_rio.c                      |   6 +-
 arch/powerpc/sysdev/tsi108_pci.c                   |   6 +-
 .../selftests/powerpc/copyloops/asm/ppc_asm.h      |   2 +
 .../selftests/powerpc/primitives/asm/firmware.h    |   0
 .../selftests/powerpc/primitives/asm/ppc_asm.h     |   1 +
 .../selftests/powerpc/primitives/asm/processor.h   |   0
 .../selftests/powerpc/primitives/linux/stringify.h |   0
 21 files changed, 241 insertions(+), 327 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/primitives/asm/firmware.h
 create mode 120000 tools/testing/selftests/powerpc/primitives/asm/ppc_asm.h
 create mode 100644 tools/testing/selftests/powerpc/primitives/asm/processor.h
 create mode 100644 tools/testing/selftests/powerpc/primitives/linux/stringify.h

diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
index 2a9cf845473b..eaada6c92344 100644
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -23,10 +23,8 @@
 "4:	li	%1,%3\n" \
 	"b	3b\n" \
 	".previous\n" \
-	".section __ex_table,\"a\"\n" \
-	".align 3\n" \
-	PPC_LONG "1b,4b,2b,4b\n" \
-	".previous" \
+	EX_TABLE(1b, 4b) \
+	EX_TABLE(2b, 4b) \
 	: "=&r" (oldval), "=&r" (ret) \
 	: "b" (uaddr), "i" (-EFAULT), "r" (oparg) \
 	: "cr0", "memory")
@@ -104,11 +102,9 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 "3:	.section .fixup,\"ax\"\n\
 4:	li	%0,%6\n\
 	b	3b\n\
-	.previous\n\
-	.section __ex_table,\"a\"\n\
-	.align 3\n\
-	" PPC_LONG "1b,4b,2b,4b\n\
-	.previous" \
+	.previous\n"
+	EX_TABLE(1b, 4b)
+	EX_TABLE(2b, 4b)
         : "+r" (ret), "=&r" (prev), "+m" (*uaddr)
         : "r" (uaddr), "r" (oldval), "r" (newval), "i" (-EFAULT)
         : "cc", "memory");
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index f6fda8482f60..5ed292431b5b 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -33,6 +33,7 @@ extern struct pci_dev *isa_bridge_pcidev;
 #include <asm/synch.h>
 #include <asm/delay.h>
 #include <asm/mmu.h>
+#include <asm/ppc_asm.h>
 
 #include <asm-generic/iomap.h>
 
@@ -458,13 +459,10 @@ static inline unsigned int name(unsigned int port)	\
 		"5:	li	%0,-1\n"		\
 		"	b	4b\n"			\
 		".previous\n"				\
-		".section __ex_table,\"a\"\n"		\
-		"	.align	2\n"			\
-		"	.long	0b,5b\n"		\
-		"	.long	1b,5b\n"		\
-		"	.long	2b,5b\n"		\
-		"	.long	3b,5b\n"		\
-		".previous"				\
+		EX_TABLE(0b, 5b)			\
+		EX_TABLE(1b, 5b)			\
+		EX_TABLE(2b, 5b)			\
+		EX_TABLE(3b, 5b)			\
 		: "=&r" (x)				\
 		: "r" (port + _IO_BASE)			\
 		: "memory");  				\
@@ -479,11 +477,8 @@ static inline void name(unsigned int val, unsigned int port) \
 		"0:" op " %0,0,%1\n"			\
 		"1:	sync\n"				\
 		"2:\n"					\
-		".section __ex_table,\"a\"\n"		\
-		"	.align	2\n"			\
-		"	.long	0b,2b\n"		\
-		"	.long	1b,2b\n"		\
-		".previous"				\
+		EX_TABLE(0b, 2b)			\
+		EX_TABLE(1b, 2b)			\
 		: : "r" (val), "r" (port + _IO_BASE)	\
 		: "memory");   	   	   		\
 }
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 28ab87e5b739..6af8852d1f7f 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -780,4 +780,14 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 
 #endif /*  __ASSEMBLY__ */
 
+/*
+ * Helper macro for exception table entries
+ */
+#define EX_TABLE(_fault, _target)		\
+	stringify_in_c(.section __ex_table,"a";)\
+	PPC_LONG_ALIGN stringify_in_c(;)	\
+	PPC_LONG stringify_in_c(_fault;)	\
+	PPC_LONG stringify_in_c(_target;)	\
+	stringify_in_c(.previous)
+
 #endif /* _ASM_POWERPC_PPC_ASM_H */
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index c266227fdd5b..e0b724619c4a 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -7,6 +7,7 @@
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <asm/asm-compat.h>
+#include <asm/ppc_asm.h>
 #include <asm/processor.h>
 #include <asm/page.h>
 
@@ -132,10 +133,7 @@ extern long __put_user_bad(void);
 		"3:	li %0,%3\n"				\
 		"	b 2b\n"					\
 		".previous\n"					\
-		".section __ex_table,\"a\"\n"			\
-			PPC_LONG_ALIGN "\n"			\
-			PPC_LONG "1b,3b\n"			\
-		".previous"					\
+		EX_TABLE(1b, 3b)				\
 		: "=r" (err)					\
 		: "r" (x), "b" (addr), "i" (-EFAULT), "0" (err))
 
@@ -152,11 +150,8 @@ extern long __put_user_bad(void);
 		"4:	li %0,%3\n"				\
 		"	b 3b\n"					\
 		".previous\n"					\
-		".section __ex_table,\"a\"\n"			\
-			PPC_LONG_ALIGN "\n"			\
-			PPC_LONG "1b,4b\n"			\
-			PPC_LONG "2b,4b\n"			\
-		".previous"					\
+		EX_TABLE(1b, 4b)				\
+		EX_TABLE(2b, 4b)				\
 		: "=r" (err)					\
 		: "r" (x), "b" (addr), "i" (-EFAULT), "0" (err))
 #endif /* __powerpc64__ */
@@ -215,10 +210,7 @@ extern long __get_user_bad(void);
 		"	li %1,0\n"			\
 		"	b 2b\n"				\
 		".previous\n"				\
-		".section __ex_table,\"a\"\n"		\
-			PPC_LONG_ALIGN "\n"		\
-			PPC_LONG "1b,3b\n"		\
-		".previous"				\
+		EX_TABLE(1b, 3b)			\
 		: "=r" (err), "=r" (x)			\
 		: "b" (addr), "i" (-EFAULT), "0" (err))
 
@@ -237,11 +229,8 @@ extern long __get_user_bad(void);
 		"	li %1+1,0\n"			\
 		"	b 3b\n"				\
 		".previous\n"				\
-		".section __ex_table,\"a\"\n"		\
-			PPC_LONG_ALIGN "\n"		\
-			PPC_LONG "1b,4b\n"		\
-			PPC_LONG "2b,4b\n"		\
-		".previous"				\
+		EX_TABLE(1b, 4b)			\
+		EX_TABLE(2b, 4b)			\
 		: "=r" (err), "=&r" (x)			\
 		: "b" (addr), "i" (-EFAULT), "0" (err))
 #endif /* __powerpc64__ */
diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index 4afe66aa1400..f3f4710d4ff5 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -7,6 +7,7 @@
 
 #include <linux/kernel.h>
 #include <asm/asm-compat.h>
+#include <asm/ppc_asm.h>
 
 #ifdef __BIG_ENDIAN__
 
@@ -193,10 +194,7 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 #endif
 	"b	2b\n"
 	".previous\n"
-	".section __ex_table,\"a\"\n\t"
-		PPC_LONG_ALIGN "\n\t"
-		PPC_LONG "1b,3b\n"
-	".previous"
+	EX_TABLE(1b, 3b)
 	: [tmp] "=&b" (tmp), [offset] "=&r" (offset), [ret] "=&r" (ret)
 	: [addr] "b" (addr), "m" (*(unsigned long *)addr));
 
diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index ea29a5d67743..9a671c774b22 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -103,17 +103,14 @@ EXPORT_SYMBOL(__csum_partial)
 	adde	r12,r12,r10
 
 #define CSUM_COPY_16_BYTES_EXCODE(n)		\
-.section __ex_table,"a";		\
-	.align	2;			\
-	.long	8 ## n ## 0b,src_error;	\
-	.long	8 ## n ## 1b,src_error;	\
-	.long	8 ## n ## 2b,src_error;	\
-	.long	8 ## n ## 3b,src_error;	\
-	.long	8 ## n ## 4b,dst_error;	\
-	.long	8 ## n ## 5b,dst_error;	\
-	.long	8 ## n ## 6b,dst_error;	\
-	.long	8 ## n ## 7b,dst_error;	\
-	.text
+	EX_TABLE(8 ## n ## 0b, src_error);	\
+	EX_TABLE(8 ## n ## 1b, src_error);	\
+	EX_TABLE(8 ## n ## 2b, src_error);	\
+	EX_TABLE(8 ## n ## 3b, src_error);	\
+	EX_TABLE(8 ## n ## 4b, dst_error);	\
+	EX_TABLE(8 ## n ## 5b, dst_error);	\
+	EX_TABLE(8 ## n ## 6b, dst_error);	\
+	EX_TABLE(8 ## n ## 7b, dst_error);
 
 	.text
 	.stabs	"arch/powerpc/lib/",N_SO,0,0,0f
@@ -263,14 +260,11 @@ dst_error:
 	stw	r0,0(r8)
 	blr
 
-	.section __ex_table,"a"
-	.align	2
-	.long	70b,src_error
-	.long	71b,dst_error
-	.long	72b,src_error
-	.long	73b,dst_error
-	.long	54b,dst_error
-	.text
+	EX_TABLE(70b, src_error);
+	EX_TABLE(71b, dst_error);
+	EX_TABLE(72b, src_error);
+	EX_TABLE(73b, dst_error);
+	EX_TABLE(54b, dst_error);
 
 /*
  * this stuff handles faults in the cacheline loop and branches to either
@@ -291,12 +285,11 @@ dst_error:
 #endif
 #endif
 
-	.section __ex_table,"a"
-	.align	2
-	.long	30b,src_error
-	.long	31b,dst_error
-	.long	40b,src_error
-	.long	41b,dst_error
-	.long	50b,src_error
-	.long	51b,dst_error
+	EX_TABLE(30b, src_error);
+	EX_TABLE(31b, dst_error);
+	EX_TABLE(40b, src_error);
+	EX_TABLE(41b, dst_error);
+	EX_TABLE(50b, src_error);
+	EX_TABLE(51b, dst_error);
+
 EXPORT_SYMBOL(csum_partial_copy_generic)
diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index fd9176671f9f..d0d311e108ff 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -182,34 +182,22 @@ EXPORT_SYMBOL(__csum_partial)
 
 	.macro srcnr
 100:
-	.section __ex_table,"a"
-	.align 3
-	.llong 100b,.Lsrc_error_nr
-	.previous
+	EX_TABLE(100b,.Lsrc_error_nr)
 	.endm
 
 	.macro source
 150:
-	.section __ex_table,"a"
-	.align 3
-	.llong 150b,.Lsrc_error
-	.previous
+	EX_TABLE(150b,.Lsrc_error)
 	.endm
 
 	.macro dstnr
 200:
-	.section __ex_table,"a"
-	.align 3
-	.llong 200b,.Ldest_error_nr
-	.previous
+	EX_TABLE(200b,.Ldest_error_nr)
 	.endm
 
 	.macro dest
 250:
-	.section __ex_table,"a"
-	.align 3
-	.llong 250b,.Ldest_error
-	.previous
+	EX_TABLE(250b,.Ldest_error)
 	.endm
 
 /*
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 40cce33b08d6..ff0d894d7ff9 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -49,17 +49,14 @@
 9 ## n ## 1:					\
 	addi	r5,r5,-(16 * n);		\
 	b	105f;				\
-.section __ex_table,"a";			\
-	.align	2;				\
-	.long	8 ## n ## 0b,9 ## n ## 0b;	\
-	.long	8 ## n ## 1b,9 ## n ## 0b;	\
-	.long	8 ## n ## 2b,9 ## n ## 0b;	\
-	.long	8 ## n ## 3b,9 ## n ## 0b;	\
-	.long	8 ## n ## 4b,9 ## n ## 1b;	\
-	.long	8 ## n ## 5b,9 ## n ## 1b;	\
-	.long	8 ## n ## 6b,9 ## n ## 1b;	\
-	.long	8 ## n ## 7b,9 ## n ## 1b;	\
-	.text
+	EX_TABLE(8 ## n ## 0b,9 ## n ## 0b);	\
+	EX_TABLE(8 ## n ## 1b,9 ## n ## 0b);	\
+	EX_TABLE(8 ## n ## 2b,9 ## n ## 0b);	\
+	EX_TABLE(8 ## n ## 3b,9 ## n ## 0b);	\
+	EX_TABLE(8 ## n ## 4b,9 ## n ## 1b);	\
+	EX_TABLE(8 ## n ## 5b,9 ## n ## 1b);	\
+	EX_TABLE(8 ## n ## 6b,9 ## n ## 1b);	\
+	EX_TABLE(8 ## n ## 7b,9 ## n ## 1b)
 
 	.text
 	.stabs	"arch/powerpc/lib/",N_SO,0,0,0f
@@ -323,13 +320,10 @@ _GLOBAL(__copy_tofrom_user)
 73:	stwu	r9,4(r6)
 	bdnz	72b
 
-	.section __ex_table,"a"
-	.align	2
-	.long	70b,100f
-	.long	71b,101f
-	.long	72b,102f
-	.long	73b,103f
-	.text
+	EX_TABLE(70b,100f)
+	EX_TABLE(71b,101f)
+	EX_TABLE(72b,102f)
+	EX_TABLE(73b,103f)
 
 58:	srwi.	r0,r5,LG_CACHELINE_BYTES /* # complete cachelines */
 	clrlwi	r5,r5,32-LG_CACHELINE_BYTES
@@ -364,10 +358,7 @@ _GLOBAL(__copy_tofrom_user)
 
 53:	dcbt	r3,r4
 54:	dcbz	r11,r6
-	.section __ex_table,"a"
-	.align	2
-	.long	54b,105f
-	.text
+	EX_TABLE(54b,105f)
 /* the main body of the cacheline loop */
 	COPY_16_BYTES_WITHEX(0)
 #if L1_CACHE_BYTES >= 32
@@ -500,15 +491,13 @@ _GLOBAL(__copy_tofrom_user)
 	bdnz	114b
 120:	blr
 
-	.section __ex_table,"a"
-	.align	2
-	.long	30b,108b
-	.long	31b,109b
-	.long	40b,110b
-	.long	41b,111b
-	.long	130b,132b
-	.long	131b,120b
-	.long	112b,120b
-	.long	114b,120b
-	.text
+	EX_TABLE(30b,108b)
+	EX_TABLE(31b,109b)
+	EX_TABLE(40b,110b)
+	EX_TABLE(41b,111b)
+	EX_TABLE(130b,132b)
+	EX_TABLE(131b,120b)
+	EX_TABLE(112b,120b)
+	EX_TABLE(114b,120b)
+
 EXPORT_SYMBOL(__copy_tofrom_user)
diff --git a/arch/powerpc/lib/copyuser_64.S b/arch/powerpc/lib/copyuser_64.S
index 60386b2c99bb..aee6e24e81ab 100644
--- a/arch/powerpc/lib/copyuser_64.S
+++ b/arch/powerpc/lib/copyuser_64.S
@@ -394,70 +394,66 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 192:
 	blr			/* #bytes not copied in r3 */
 
-	.section __ex_table,"a"
-	.align	3
-	.llong	20b,120b
-	.llong	220b,320b
-	.llong	21b,121b
-	.llong	221b,321b
-	.llong	70b,170b
-	.llong	270b,370b
-	.llong	22b,122b
-	.llong	222b,322b
-	.llong	71b,171b
-	.llong	271b,371b
-	.llong	72b,172b
-	.llong	272b,372b
-	.llong	244b,344b
-	.llong	245b,345b
-	.llong	23b,123b
-	.llong	73b,173b
-	.llong	44b,144b
-	.llong	74b,174b
-	.llong	45b,145b
-	.llong	75b,175b
-	.llong	24b,124b
-	.llong	25b,125b
-	.llong	26b,126b
-	.llong	27b,127b
-	.llong	28b,128b
-	.llong	29b,129b
-	.llong	30b,130b
-	.llong	31b,131b
-	.llong	32b,132b
-	.llong	76b,176b
-	.llong	33b,133b
-	.llong	77b,177b
-	.llong	78b,178b
-	.llong	79b,179b
-	.llong	80b,180b
-	.llong	34b,134b
-	.llong	94b,194b
-	.llong	95b,195b
-	.llong	96b,196b
-	.llong	35b,135b
-	.llong	81b,181b
-	.llong	36b,136b
-	.llong	82b,182b
-	.llong	37b,137b
-	.llong	83b,183b
-	.llong	38b,138b
-	.llong	39b,139b
-	.llong	84b,184b
-	.llong	85b,185b
-	.llong	40b,140b
-	.llong	86b,186b
-	.llong	41b,141b
-	.llong	87b,187b
-	.llong	42b,142b
-	.llong	88b,188b
-	.llong	43b,143b
-	.llong	89b,189b
-	.llong	90b,190b
-	.llong	91b,191b
-	.llong	92b,192b
-	
-	.text
+	EX_TABLE(20b,120b)
+	EX_TABLE(220b,320b)
+	EX_TABLE(21b,121b)
+	EX_TABLE(221b,321b)
+	EX_TABLE(70b,170b)
+	EX_TABLE(270b,370b)
+	EX_TABLE(22b,122b)
+	EX_TABLE(222b,322b)
+	EX_TABLE(71b,171b)
+	EX_TABLE(271b,371b)
+	EX_TABLE(72b,172b)
+	EX_TABLE(272b,372b)
+	EX_TABLE(244b,344b)
+	EX_TABLE(245b,345b)
+	EX_TABLE(23b,123b)
+	EX_TABLE(73b,173b)
+	EX_TABLE(44b,144b)
+	EX_TABLE(74b,174b)
+	EX_TABLE(45b,145b)
+	EX_TABLE(75b,175b)
+	EX_TABLE(24b,124b)
+	EX_TABLE(25b,125b)
+	EX_TABLE(26b,126b)
+	EX_TABLE(27b,127b)
+	EX_TABLE(28b,128b)
+	EX_TABLE(29b,129b)
+	EX_TABLE(30b,130b)
+	EX_TABLE(31b,131b)
+	EX_TABLE(32b,132b)
+	EX_TABLE(76b,176b)
+	EX_TABLE(33b,133b)
+	EX_TABLE(77b,177b)
+	EX_TABLE(78b,178b)
+	EX_TABLE(79b,179b)
+	EX_TABLE(80b,180b)
+	EX_TABLE(34b,134b)
+	EX_TABLE(94b,194b)
+	EX_TABLE(95b,195b)
+	EX_TABLE(96b,196b)
+	EX_TABLE(35b,135b)
+	EX_TABLE(81b,181b)
+	EX_TABLE(36b,136b)
+	EX_TABLE(82b,182b)
+	EX_TABLE(37b,137b)
+	EX_TABLE(83b,183b)
+	EX_TABLE(38b,138b)
+	EX_TABLE(39b,139b)
+	EX_TABLE(84b,184b)
+	EX_TABLE(85b,185b)
+	EX_TABLE(40b,140b)
+	EX_TABLE(86b,186b)
+	EX_TABLE(41b,141b)
+	EX_TABLE(87b,187b)
+	EX_TABLE(42b,142b)
+	EX_TABLE(88b,188b)
+	EX_TABLE(43b,143b)
+	EX_TABLE(89b,189b)
+	EX_TABLE(90b,190b)
+	EX_TABLE(91b,191b)
+	EX_TABLE(92b,192b)
 
 /*
  * Routine to copy a whole page of data, optimized for POWER4.
@@ -598,78 +594,77 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 	li	r5,4096
 	b	.Ldst_aligned
 
-	.section __ex_table,"a"
-	.align	3
-	.llong	20b,100b
-	.llong	21b,100b
-	.llong	22b,100b
-	.llong	23b,100b
-	.llong	24b,100b
-	.llong	25b,100b
-	.llong	26b,100b
-	.llong	27b,100b
-	.llong	28b,100b
-	.llong	29b,100b
-	.llong	30b,100b
-	.llong	31b,100b
-	.llong	32b,100b
-	.llong	33b,100b
-	.llong	34b,100b
-	.llong	35b,100b
-	.llong	36b,100b
-	.llong	37b,100b
-	.llong	38b,100b
-	.llong	39b,100b
-	.llong	40b,100b
-	.llong	41b,100b
-	.llong	42b,100b
-	.llong	43b,100b
-	.llong	44b,100b
-	.llong	45b,100b
-	.llong	46b,100b
-	.llong	47b,100b
-	.llong	48b,100b
-	.llong	49b,100b
-	.llong	50b,100b
-	.llong	51b,100b
-	.llong	52b,100b
-	.llong	53b,100b
-	.llong	54b,100b
-	.llong	55b,100b
-	.llong	56b,100b
-	.llong	57b,100b
-	.llong	58b,100b
-	.llong	59b,100b
-	.llong	60b,100b
-	.llong	61b,100b
-	.llong	62b,100b
-	.llong	63b,100b
-	.llong	64b,100b
-	.llong	65b,100b
-	.llong	66b,100b
-	.llong	67b,100b
-	.llong	68b,100b
-	.llong	69b,100b
-	.llong	70b,100b
-	.llong	71b,100b
-	.llong	72b,100b
-	.llong	73b,100b
-	.llong	74b,100b
-	.llong	75b,100b
-	.llong	76b,100b
-	.llong	77b,100b
-	.llong	78b,100b
-	.llong	79b,100b
-	.llong	80b,100b
-	.llong	81b,100b
-	.llong	82b,100b
-	.llong	83b,100b
-	.llong	84b,100b
-	.llong	85b,100b
-	.llong	86b,100b
-	.llong	87b,100b
-	.llong	88b,100b
-	.llong	89b,100b
-	.llong	90b,100b
-	.llong	91b,100b
+	EX_TABLE(20b,100b)
+	EX_TABLE(21b,100b)
+	EX_TABLE(22b,100b)
+	EX_TABLE(23b,100b)
+	EX_TABLE(24b,100b)
+	EX_TABLE(25b,100b)
+	EX_TABLE(26b,100b)
+	EX_TABLE(27b,100b)
+	EX_TABLE(28b,100b)
+	EX_TABLE(29b,100b)
+	EX_TABLE(30b,100b)
+	EX_TABLE(31b,100b)
+	EX_TABLE(32b,100b)
+	EX_TABLE(33b,100b)
+	EX_TABLE(34b,100b)
+	EX_TABLE(35b,100b)
+	EX_TABLE(36b,100b)
+	EX_TABLE(37b,100b)
+	EX_TABLE(38b,100b)
+	EX_TABLE(39b,100b)
+	EX_TABLE(40b,100b)
+	EX_TABLE(41b,100b)
+	EX_TABLE(42b,100b)
+	EX_TABLE(43b,100b)
+	EX_TABLE(44b,100b)
+	EX_TABLE(45b,100b)
+	EX_TABLE(46b,100b)
+	EX_TABLE(47b,100b)
+	EX_TABLE(48b,100b)
+	EX_TABLE(49b,100b)
+	EX_TABLE(50b,100b)
+	EX_TABLE(51b,100b)
+	EX_TABLE(52b,100b)
+	EX_TABLE(53b,100b)
+	EX_TABLE(54b,100b)
+	EX_TABLE(55b,100b)
+	EX_TABLE(56b,100b)
+	EX_TABLE(57b,100b)
+	EX_TABLE(58b,100b)
+	EX_TABLE(59b,100b)
+	EX_TABLE(60b,100b)
+	EX_TABLE(61b,100b)
+	EX_TABLE(62b,100b)
+	EX_TABLE(63b,100b)
+	EX_TABLE(64b,100b)
+	EX_TABLE(65b,100b)
+	EX_TABLE(66b,100b)
+	EX_TABLE(67b,100b)
+	EX_TABLE(68b,100b)
+	EX_TABLE(69b,100b)
+	EX_TABLE(70b,100b)
+	EX_TABLE(71b,100b)
+	EX_TABLE(72b,100b)
+	EX_TABLE(73b,100b)
+	EX_TABLE(74b,100b)
+	EX_TABLE(75b,100b)
+	EX_TABLE(76b,100b)
+	EX_TABLE(77b,100b)
+	EX_TABLE(78b,100b)
+	EX_TABLE(79b,100b)
+	EX_TABLE(80b,100b)
+	EX_TABLE(81b,100b)
+	EX_TABLE(82b,100b)
+	EX_TABLE(83b,100b)
+	EX_TABLE(84b,100b)
+	EX_TABLE(85b,100b)
+	EX_TABLE(86b,100b)
+	EX_TABLE(87b,100b)
+	EX_TABLE(88b,100b)
+	EX_TABLE(89b,100b)
+	EX_TABLE(90b,100b)
+	EX_TABLE(91b,100b)
+
 EXPORT_SYMBOL(__copy_tofrom_user)
diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index da0c568d18c4..a24b4039352c 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -29,35 +29,23 @@
 
 	.macro err1
 100:
-	.section __ex_table,"a"
-	.align 3
-	.llong 100b,.Ldo_err1
-	.previous
+	EX_TABLE(100b,.Ldo_err1)
 	.endm
 
 	.macro err2
 200:
-	.section __ex_table,"a"
-	.align 3
-	.llong 200b,.Ldo_err2
-	.previous
+	EX_TABLE(200b,.Ldo_err2)
 	.endm
 
 #ifdef CONFIG_ALTIVEC
 	.macro err3
 300:
-	.section __ex_table,"a"
-	.align 3
-	.llong 300b,.Ldo_err3
-	.previous
+	EX_TABLE(300b,.Ldo_err3)
 	.endm
 
 	.macro err4
 400:
-	.section __ex_table,"a"
-	.align 3
-	.llong 400b,.Ldo_err4
-	.previous
+	EX_TABLE(400b,.Ldo_err4)
 	.endm
 
 
diff --git a/arch/powerpc/lib/ldstfp.S b/arch/powerpc/lib/ldstfp.S
index 5d0cdbfbe3f2..a58777c1b2cb 100644
--- a/arch/powerpc/lib/ldstfp.S
+++ b/arch/powerpc/lib/ldstfp.S
@@ -21,18 +21,12 @@
 
 #define STKFRM	(PPC_MIN_STKFRM + 16)
 
-	.macro	extab	instr,handler
-	.section __ex_table,"a"
-	PPC_LONG \instr,\handler
-	.previous
-	.endm
-
 	.macro	inst32	op
 reg = 0
 	.rept	32
 20:	\op	reg,0,r4
 	b	3f
-	extab	20b,99f
+	EX_TABLE(20b,99f)
 reg = reg + 1
 	.endr
 	.endm
@@ -100,7 +94,7 @@ _GLOBAL(do_lfs)
 	mr	r3,r9
 	addi	r1,r1,STKFRM
 	blr
-	extab	2b,3b
+	EX_TABLE(2b,3b)
 
 /* Load FP reg N from double at *p.  N is in r3, p in r4. */
 _GLOBAL(do_lfd)
@@ -127,7 +121,7 @@ _GLOBAL(do_lfd)
 	mr	r3,r9
 	addi	r1,r1,STKFRM
 	blr
-	extab	2b,3b
+	EX_TABLE(2b,3b)
 
 /* Store FP reg N to float at *p.  N is in r3, p in r4. */
 _GLOBAL(do_stfs)
@@ -154,7 +148,7 @@ _GLOBAL(do_stfs)
 	mr	r3,r9
 	addi	r1,r1,STKFRM
 	blr
-	extab	2b,3b
+	EX_TABLE(2b,3b)
 
 /* Store FP reg N to double at *p.  N is in r3, p in r4. */
 _GLOBAL(do_stfd)
@@ -181,7 +175,7 @@ _GLOBAL(do_stfd)
 	mr	r3,r9
 	addi	r1,r1,STKFRM
 	blr
-	extab	2b,3b
+	EX_TABLE(2b,3b)
 
 #ifdef CONFIG_ALTIVEC
 /* Get the contents of vrN into v0; N is in r3. */
@@ -248,7 +242,7 @@ _GLOBAL(do_lvx)
 	mr	r3,r9
 	addi	r1,r1,STKFRM
 	blr
-	extab	2b,3b
+	EX_TABLE(2b,3b)
 
 /* Store vector reg N to *p.  N is in r3, p in r4. */
 _GLOBAL(do_stvx)
@@ -276,7 +270,7 @@ _GLOBAL(do_stvx)
 	mr	r3,r9
 	addi	r1,r1,STKFRM
 	blr
-	extab	2b,3b
+	EX_TABLE(2b,3b)
 #endif /* CONFIG_ALTIVEC */
 
 #ifdef CONFIG_VSX
@@ -344,7 +338,7 @@ _GLOBAL(do_lxvd2x)
 	mr	r3,r9
 	addi	r1,r1,STKFRM
 	blr
-	extab	2b,3b
+	EX_TABLE(2b,3b)
 
 /* Store VSX reg N to vector doubleword *p.  N is in r3, p in r4. */
 _GLOBAL(do_stxvd2x)
@@ -372,7 +366,7 @@ _GLOBAL(do_stxvd2x)
 	mr	r3,r9
 	addi	r1,r1,STKFRM
 	blr
-	extab	2b,3b
+	EX_TABLE(2b,3b)
 
 #endif /* CONFIG_VSX */
 
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 3362299b1859..b64287c6793f 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -493,10 +493,7 @@ static int __kprobes do_vsx_store(int rn, int (*func)(int, unsigned long),
 		"3:	li	%0,%4\n"		\
 		"	b	2b\n"			\
 		".previous\n"				\
-		".section __ex_table,\"a\"\n"		\
-			PPC_LONG_ALIGN "\n"		\
-			PPC_LONG "1b,3b\n"		\
-		".previous"				\
+		EX_TABLE(1b, 3b)			\
 		: "=r" (err), "=r" (cr)			\
 		: "r" (x), "r" (addr), "i" (-EFAULT), "0" (err))
 
@@ -508,10 +505,7 @@ static int __kprobes do_vsx_store(int rn, int (*func)(int, unsigned long),
 		"3:	li	%0,%3\n"		\
 		"	b	2b\n"			\
 		".previous\n"				\
-		".section __ex_table,\"a\"\n"		\
-			PPC_LONG_ALIGN "\n"		\
-			PPC_LONG "1b,3b\n"		\
-		".previous"				\
+		EX_TABLE(1b, 3b)			\
 		: "=r" (err), "=r" (x)			\
 		: "r" (addr), "i" (-EFAULT), "0" (err))
 
@@ -523,10 +517,7 @@ static int __kprobes do_vsx_store(int rn, int (*func)(int, unsigned long),
 		"3:	li	%0,%3\n"		\
 		"	b	2b\n"			\
 		".previous\n"				\
-		".section __ex_table,\"a\"\n"		\
-			PPC_LONG_ALIGN "\n"		\
-			PPC_LONG "1b,3b\n"		\
-		".previous"				\
+		EX_TABLE(1b, 3b)			\
 		: "=r" (err)				\
 		: "r" (addr), "i" (-EFAULT), "0" (err))
 
diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index d13e07603519..a787776822d8 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -13,8 +13,6 @@
 #include <asm/ppc_asm.h>
 #include <asm/export.h>
 
-	.section __ex_table,"a"
-	PPC_LONG_ALIGN
 	.text
 	
 /* This clears out any unused part of the destination buffer,
@@ -125,10 +123,9 @@ _GLOBAL(__clear_user)
 92:	mfctr	r3
 	blr
 
-	.section __ex_table,"a"
-	PPC_LONG	11b,90b
-	PPC_LONG	1b,91b
-	PPC_LONG	8b,92b
-	.text
+	EX_TABLE(11b, 90b)
+	EX_TABLE(1b, 91b)
+	EX_TABLE(8b, 92b)
+
 EXPORT_SYMBOL(__clear_user)
 #endif
diff --git a/arch/powerpc/lib/string_64.S b/arch/powerpc/lib/string_64.S
index 57ace356c949..c100f4d5d5d0 100644
--- a/arch/powerpc/lib/string_64.S
+++ b/arch/powerpc/lib/string_64.S
@@ -19,6 +19,7 @@
  */
 
 #include <asm/ppc_asm.h>
+#include <asm/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/export.h>
 
@@ -41,26 +42,17 @@ PPC64_CACHES:
 
 	.macro err1
 100:
-	.section __ex_table,"a"
-	.align 3
-	.llong 100b,.Ldo_err1
-	.previous
+	EX_TABLE(100b,.Ldo_err1)
 	.endm
 
 	.macro err2
 200:
-	.section __ex_table,"a"
-	.align 3
-	.llong 200b,.Ldo_err2
-	.previous
+	EX_TABLE(200b,.Ldo_err2)
 	.endm
 
 	.macro err3
 300:
-	.section __ex_table,"a"
-	.align 3
-	.llong 300b,.Ldo_err3
-	.previous
+	EX_TABLE(300b,.Ldo_err3)
 	.endm
 
 .Ldo_err1:
diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 3cc7cace194a..87fee0c8eb21 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -80,10 +80,8 @@
 		"3:	li %1,-1\n"			\
 		"	li %0,%3\n"			\
 		"	b 2b\n"				\
-		".section __ex_table,\"a\"\n"		\
-			PPC_LONG_ALIGN "\n"		\
-			PPC_LONG "1b,3b\n"		\
-		".text"					\
+		".previous\n"				\
+		EX_TABLE(1b, 3b)			\
 		: "=r" (err), "=r" (x)			\
 		: "b" (addr), "i" (-EFAULT), "0" (err))
 
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 57c971b7839c..53a16aa4d384 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -137,10 +137,8 @@ void tsi108_clear_pci_error(u32 pci_cfg_base)
 		".section .fixup,\"ax\"\n"		\
 		"3:	li %0,-1\n"			\
 		"	b 2b\n"				\
-		".section __ex_table,\"a\"\n"		\
-		"	.align 2\n"			\
-		"	.long 1b,3b\n"			\
-		".text"					\
+		".previous\n"				\
+		EX_TABLE(1b, 3b)			\
 		: "=r"(x) : "r"(addr))
 
 int
diff --git a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
index 50ae7d2091ce..80d34a9ffff4 100644
--- a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
@@ -25,6 +25,8 @@
 
 #define PPC_MTOCRF(A, B)	mtocrf A, B
 
+#define EX_TABLE(x, y)
+
 FUNC_START(enter_vmx_usercopy)
 	li	r3,1
 	blr
diff --git a/tools/testing/selftests/powerpc/primitives/asm/firmware.h b/tools/testing/selftests/powerpc/primitives/asm/firmware.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/selftests/powerpc/primitives/asm/ppc_asm.h b/tools/testing/selftests/powerpc/primitives/asm/ppc_asm.h
new file mode 120000
index 000000000000..66c8193224e9
--- /dev/null
+++ b/tools/testing/selftests/powerpc/primitives/asm/ppc_asm.h
@@ -0,0 +1 @@
+../../../../../../arch/powerpc/include/asm/ppc_asm.h
\ No newline at end of file
diff --git a/tools/testing/selftests/powerpc/primitives/asm/processor.h b/tools/testing/selftests/powerpc/primitives/asm/processor.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/selftests/powerpc/primitives/linux/stringify.h b/tools/testing/selftests/powerpc/primitives/linux/stringify.h
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.7.4
