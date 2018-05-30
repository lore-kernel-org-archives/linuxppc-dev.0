Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wkPj6hvmzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 18:33:13 +1000 (AEST)
Message-Id: <9904850a3185b63c7f74442858e51c94761f1852.1527668888.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3] powerpc/lib: implement strlen() in assembly
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 May 2018 08:33:09 +0000 (UTC)
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

On a 8xx the time spent in strlen is reduced by 50-60% for long strings.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
Not tested on PPC64.

To avoid trivial conflict, apply on top of serie "[v6 0/2] powerpc/lib: Optimisation of memcmp() and __clear_user() for PPC32".

Changes in v3:
 - Made it common to PPC32 and PPC64

Changes in v2:
 - Moved handling of unaligned strings outside of the main path as it is very unlikely.
 - Removed the verification of the fourth byte in case none of the three first ones are NUL.

 arch/powerpc/include/asm/asm-compat.h |  4 +++
 arch/powerpc/include/asm/string.h     |  1 +
 arch/powerpc/lib/string.S             | 55 +++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index 7f2a7702596c..0e99fe7570c0 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -20,8 +20,10 @@
 
 /* operations for longs and pointers */
 #define PPC_LL		stringify_in_c(ld)
+#define PPC_LLU		stringify_in_c(ldu)
 #define PPC_STL		stringify_in_c(std)
 #define PPC_STLU	stringify_in_c(stdu)
+#define PPC_ROTLI	stringify_in_c(rotldi)
 #define PPC_LCMPI	stringify_in_c(cmpdi)
 #define PPC_LCMPLI	stringify_in_c(cmpldi)
 #define PPC_LCMP	stringify_in_c(cmpd)
@@ -53,8 +55,10 @@
 
 /* operations for longs and pointers */
 #define PPC_LL		stringify_in_c(lwz)
+#define PPC_LLU		stringify_in_c(lwzu)
 #define PPC_STL		stringify_in_c(stw)
 #define PPC_STLU	stringify_in_c(stwu)
+#define PPC_ROTLI	stringify_in_c(rotlwi)
 #define PPC_LCMPI	stringify_in_c(cmpwi)
 #define PPC_LCMPLI	stringify_in_c(cmplwi)
 #define PPC_LCMP	stringify_in_c(cmpw)
diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index 9b8cedf618f4..8fdcb532de72 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -13,6 +13,7 @@
 #define __HAVE_ARCH_MEMCHR
 #define __HAVE_ARCH_MEMSET16
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE
+#define __HAVE_ARCH_STRLEN
 
 extern char * strcpy(char *,const char *);
 extern char * strncpy(char *,const char *, __kernel_size_t);
diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index 4b41970e9ed8..cf8a86c9feb5 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -67,3 +67,58 @@ _GLOBAL(memchr)
 2:	li	r3,0
 	blr
 EXPORT_SYMBOL(memchr)
+
+_GLOBAL(strlen)
+	andi.   r9, r3, (SZL - 1)
+	addi	r10, r3, -SZL
+	bne-	1f
+2:	lis	r6, 0x8080
+	ori	r6, r6, 0x8080		/* r6 = 0x80808080 (himagic) */
+#ifdef CONFIG_PPC64
+	rldimi	r6, r6, 32, 0		/* r6 = 0x8080808080808080 (himagic) */
+#endif
+	PPC_ROTLI  r7, r6, 1 		/* r7 = 0x01010101(01010101) (lomagic)*/
+3:	PPC_LLU	r9, SZL(r10)
+	/* ((x - lomagic) & ~x & himagic) == 0 means no byte in x is NUL */
+	subf	r8, r7, r9
+	andc	r11, r6, r9
+	and.	r8, r8, r11
+	beq+	3b
+#ifdef CONFIG_PPC64
+	rldicl.	r8, r9, 8, 56
+	beq	20f
+	rldicl.	r8, r9, 16, 56
+	beq	21f
+	rldicl.	r8, r9, 24, 56
+	beq	22f
+	rldicl.	r8, r9, 32, 56
+	beq	23f
+	addi	r10, r10, 4
+#endif
+	rlwinm.	r8, r9, 0, 0xff000000
+	beq	20f
+	rlwinm.	r8, r9, 0, 0x00ff0000
+	beq	21f
+	rlwinm.	r8, r9, 0, 0x0000ff00
+	beq	22f
+23:	subf	r3, r3, r10
+	addi	r3, r3, 3
+	blr
+22:	subf	r3, r3, r10
+	addi	r3, r3, 2
+	blr
+21:	subf	r3, r3, r10
+	addi	r3, r3, 1
+	blr
+19:	addi	r10, r10, (SZL - 1)
+20:	subf	r3, r3, r10
+	blr
+
+1:	lbz	r9, SZL(r10)
+	addi	r10, r10, 1
+	cmpwi	cr1, r9, 0
+	andi.	r9, r10, (SZL - 1)
+	beq	cr1, 19b
+	bne	1b
+	b	2b
+EXPORT_SYMBOL(strlen)
-- 
2.13.3
