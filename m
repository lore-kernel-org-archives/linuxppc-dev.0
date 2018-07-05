Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LrcL3Wm0zF0wk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 18:29:06 +1000 (AEST)
Message-Id: <673a470854e8fb1b10b0f1aa38fa41ee3cfff0fa.1530777873.git.christophe.leroy@c-s.fr>
In-Reply-To: <9f98f2bd0e9948b8042773f6190c0416d2577b5e.1530777873.git.christophe.leroy@c-s.fr>
References: <9f98f2bd0e9948b8042773f6190c0416d2577b5e.1530777873.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 3/4] powerpc/lib: implement strlen() in assembly for PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 wei.guo.simon@gmail.com, segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  5 Jul 2018 08:29:02 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The generic implementation of strlen() reads strings byte per byte.

This patch implements strlen() in assembly based on a read of entire
words, in the same spirit as what some other arches and glibc do.

On a 8xx the time spent in strlen is reduced by 3/4 for long strings.

strlen() selftest on an 8xx provides the following values:

Before the patch (ie with the generic strlen() in lib/string.c):

len 256 : time = 1.195055
len 016 : time = 0.083745
len 008 : time = 0.046828
len 004 : time = 0.028390

After the patch:

len 256 : time = 0.272185 ==> 78% improvment
len 016 : time = 0.040632 ==> 51% improvment
len 008 : time = 0.033060 ==> 29% improvment
len 004 : time = 0.029149 ==> 2% degradation

On a 832x:

Before the patch:

len 256 : time = 0.236125
len 016 : time = 0.018136
len 008 : time = 0.011000
len 004 : time = 0.007229

After the patch:

len 256 : time = 0.094950 ==> 60% improvment
len 016 : time = 0.013357 ==> 26% improvment
len 008 : time = 0.010586 ==> 4% improvment
len 004 : time = 0.008784

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
Changes in v7:
 - Reduced the scope to PPC32
 - Modified the missalignment handling to be branchless and loopless

Changes in v6:
 - Reworked for having branchless conclusion

Changes in v5:
 - Fixed for PPC64 LITTLE ENDIAN

Changes in v4:
 - Added alignment of the loop
 - doing the andc only if still not 0 as it happends only for bytes above 0x7f which is pretty rare in a string

Changes in v3:
 - Made it common to PPC32 and PPC64

Changes in v2:
 - Moved handling of unaligned strings outside of the main path as it is very unlikely.
 - Removed the verification of the fourth byte in case none of the three first ones are NUL.

 arch/powerpc/include/asm/string.h |  2 +
 arch/powerpc/lib/Makefile         |  2 +-
 arch/powerpc/lib/strlen_32.S      | 78 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/lib/strlen_32.S

diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index 9b8cedf618f4..1647de15a31e 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -50,6 +50,8 @@ static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
 	return __memset64(p, v, n * 8);
 }
 #else
+#define __HAVE_ARCH_STRLEN
+
 extern void *memset16(uint16_t *, uint16_t, __kernel_size_t);
 #endif
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index d0ca13ad8231..670286808928 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -12,7 +12,7 @@ CFLAGS_REMOVE_feature-fixups.o = $(CC_FLAGS_FTRACE)
 
 obj-y += string.o alloc.o code-patching.o feature-fixups.o
 
-obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o
+obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o strlen_32.o
 
 # See corresponding test in arch/powerpc/Makefile
 # 64-bit linker creates .sfpr on demand for final link (vmlinux),
diff --git a/arch/powerpc/lib/strlen_32.S b/arch/powerpc/lib/strlen_32.S
new file mode 100644
index 000000000000..0a8d3f64d493
--- /dev/null
+++ b/arch/powerpc/lib/strlen_32.S
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * strlen() for PPC32
+ *
+ * Copyright (C) 2018 Christophe Leroy CS Systemes d'Information.
+ *
+ * Inspired from glibc implementation
+ */
+#include <asm/ppc_asm.h>
+#include <asm/export.h>
+#include <asm/cache.h>
+
+	.text
+
+/*
+ * Algorithm:
+ *
+ * 1) Given a word 'x', we can test to see if it contains any 0 bytes
+ *    by subtracting 0x01010101, and seeing if any of the high bits of each
+ *    byte changed from 0 to 1. This works because the least significant
+ *    0 byte must have had no incoming carry (otherwise it's not the least
+ *    significant), so it is 0x00 - 0x01 == 0xff. For all other
+ *    byte values, either they have the high bit set initially, or when
+ *    1 is subtracted you get a value in the range 0x00-0x7f, none of which
+ *    have their high bit set. The expression here is
+ *    (x - 0x01010101) & ~x & 0x80808080), which gives 0x00000000 when
+ *    there were no 0x00 bytes in the word.  You get 0x80 in bytes that
+ *    match, but possibly false 0x80 matches in the next more significant
+ *    byte to a true match due to carries.  For little-endian this is
+ *    of no consequence since the least significant match is the one
+ *    we're interested in, but big-endian needs method 2 to find which
+ *    byte matches.
+ * 2) Given a word 'x', we can test to see _which_ byte was zero by
+ *    calculating ~(((x & ~0x80808080) - 0x80808080 - 1) | x | ~0x80808080).
+ *    This produces 0x80 in each byte that was zero, and 0x00 in all
+ *    the other bytes. The '| ~0x80808080' clears the low 7 bits in each
+ *    byte, and the '| x' part ensures that bytes with the high bit set
+ *    produce 0x00. The addition will carry into the high bit of each byte
+ *    iff that byte had one of its low 7 bits set. We can then just see
+ *    which was the most significant bit set and divide by 8 to find how
+ *    many to add to the index.
+ *    This is from the book 'The PowerPC Compiler Writer's Guide',
+ *    by Steve Hoxey, Faraydon Karim, Bill Hay and Hank Warren.
+ */
+
+_GLOBAL(strlen)
+	andi.   r0, r3, 3
+	lis	r7, 0x0101
+	addi	r10, r3, -4
+	addic	r7, r7, 0x0101	/* r7 = 0x01010101 (lomagic) & clear XER[CA] */
+	rotlwi	r6, r7, 31 	/* r6 = 0x80808080 (himagic) */
+	bne-	3f
+	.balign IFETCH_ALIGN_BYTES
+1:	lwzu	r9, 4(r10)
+2:	subf	r8, r7, r9
+	and.	r8, r8, r6
+	beq+	1b
+	andc.	r8, r8, r9
+	beq+	1b
+	andc	r8, r9, r6
+	orc	r9, r9, r6
+	subfe	r8, r6, r8
+	nor	r8, r8, r9
+	cntlzw	r8, r8
+	subf	r3, r3, r10
+	srwi	r8, r8, 3
+	add	r3, r3, r8
+	blr
+
+	/* Missaligned string: make sure bytes before string are seen not 0 */
+3:	xor	r10, r10, r0
+	orc	r8, r8, r8
+	lwzu	r9, 4(r10)
+	slwi	r0, r0, 3
+	srw	r8, r8, r0
+	orc	r9, r9, r8
+	b	2b
+EXPORT_SYMBOL(strlen)
-- 
2.13.3
