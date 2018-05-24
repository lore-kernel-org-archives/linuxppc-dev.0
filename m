Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sF0300PpzF1Px
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 02:17:22 +1000 (AEST)
Message-Id: <54d0574dbb33251ba241620d038b716d90fe0632.1527178313.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: implement strlen() in assembly
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 24 May 2018 16:17:17 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The generic implementation of strlen() reads strings byte per byte.

This patch implements strlen() in assembly for PPC32 based on
a read of entire words, in the same spirit as what some other
arches and glibc do.

For long strings, the time spent in strlen is reduced by 50-60%

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Applies after the patch 'powerpc/lib: move PPC32 specific functions out of string.S'

 arch/powerpc/include/asm/string.h |  3 +++
 arch/powerpc/lib/string_32.S      | 40 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index 0f41686b6243..23ee2a0f2b21 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -15,6 +15,9 @@
 #define __HAVE_ARCH_MEMCHR
 #define __HAVE_ARCH_MEMSET16
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE
+#ifdef CONFIG_PPC32
+#define __HAVE_ARCH_STRLEN
+#endif
 
 extern char * strcpy(char *,const char *);
 extern __kernel_size_t strlen(const char *);
diff --git a/arch/powerpc/lib/string_32.S b/arch/powerpc/lib/string_32.S
index c4e70123d245..31575a698c97 100644
--- a/arch/powerpc/lib/string_32.S
+++ b/arch/powerpc/lib/string_32.S
@@ -62,6 +62,46 @@ _GLOBAL(memcmp)
 	blr
 EXPORT_SYMBOL(memcmp)
 
+_GLOBAL(strlen)
+	andi.   r9, r3, 3
+	addi	r10, r3, -4
+	beq+	2f
+1:	lbz	r9, 4(r10)
+	addi	r10, r10, 1
+	cmpwi	cr0, r9, 0
+	beq	19f
+	andi.	r9, r10, 3
+	bne	1b
+2:	lis	r6, 0x8080
+	ori	r6, r6, 0x8080
+	rlwinm	r7, r6, 1, 0xffffffff
+3:	lwzu	r9, 4(r10)
+	subf	r8, r7, r9
+	andc	r11, r6, r9
+	and.	r8, r8, r11
+	beq+	3b
+	rlwinm.	r8, r9, 0, 0xff000000
+	beq	20f
+	rlwinm.	r8, r9, 0, 0x00ff0000
+	beq	21f
+	rlwinm.	r8, r9, 0, 0x0000ff00
+	beq	22f
+	rlwinm.	r8, r9, 0, 0x000000ff
+	bne	3b
+23:	subf	r3, r3, r10
+	addi	r3, r3, 3
+	blr
+22:	subf	r3, r3, r10
+	addi	r3, r3, 2
+	blr
+21:	subf	r3, r3, r10
+	addi	r3, r3, 1
+	blr
+19:	addi	r10, r10, 3
+20:	subf	r3, r3, r10
+	blr
+EXPORT_SYMBOL(strlen)
+
 CACHELINE_BYTES = L1_CACHE_BYTES
 LG_CACHELINE_BYTES = L1_CACHE_SHIFT
 CACHELINE_MASK = (L1_CACHE_BYTES-1)
-- 
2.13.3
