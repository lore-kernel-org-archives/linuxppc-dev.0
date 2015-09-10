Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 67D7F1A0796
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2015 16:41:17 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc32: memcpy/memset: only use dcbz once cache is
 enabled
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com, sojkam1@fel.cvut.cz
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20150910064112.7B7791A241C@localhost.localdomain>
Date: Thu, 10 Sep 2015 08:41:12 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

memcpy() and memset() uses instruction dcbz to speed up copy by not
wasting time loading cache line with data that will be overwritten.
Some platform like mpc52xx do no have cache active at startup and
can therefore not use memcpy(). Allthough no part of the code
explicitly uses memcpy(), GCC makes calls to it.

This patch implements fixups linked to the cache.
At startup, the functions implement code that does not use dcbz:
* For memcpy(), dcbz is replaced by dcbtst which is harmless when
cache is not enabled, and which helps a bit (allthough not as much
as dcbz) if cache is already enabled.
* For memset(), it branches inconditionnally to the alternative part
normally used only when setting non-zero value. That part doesn't
use dcbz

Once the initial MMU is set up, in machine_init() we call
do_feature_fixups() which replaces the temporary instructions with
the final ones.

Reported-by: Michal Sojka <sojkam1@fel.cvut.cz>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
changes in v2:
  Using feature-fixups instead of hardcoded call to patch_instruction()
  Handling of memset() added

 arch/powerpc/include/asm/cache.h          |  8 ++++++++
 arch/powerpc/include/asm/feature-fixups.h | 30 ++++++++++++++++++++++++++++++
 arch/powerpc/kernel/setup_32.c            |  3 +++
 arch/powerpc/kernel/vmlinux.lds.S         |  8 ++++++++
 arch/powerpc/lib/copy_32.S                | 16 ++++++++++++++++
 5 files changed, 65 insertions(+)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index a2de4f0..4d51010 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -48,6 +48,10 @@ static inline void logmpp(u64 x)
 
 #endif /* __powerpc64__ && ! __ASSEMBLY__ */
 
+#ifdef CONFIG_PPC32
+#define CACHE_NOW_ON	1
+#endif
+
 #if defined(__ASSEMBLY__)
 /*
  * For a snooping icache, we still need a dummy icbi to purge all the
@@ -64,6 +68,10 @@ static inline void logmpp(u64 x)
 #else
 #define __read_mostly __attribute__((__section__(".data..read_mostly")))
 
+#ifdef CONFIG_PPC32
+extern unsigned int __start___cache_fixup, __stop___cache_fixup;
+#endif
+
 #ifdef CONFIG_6xx
 extern long _get_L2CR(void);
 extern long _get_L3CR(void);
diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index 9a67a38..7f351cd 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -184,4 +184,34 @@ label##3:					       	\
 	FTR_ENTRY_OFFSET label##1b-label##3b;		\
 	.popsection;
 
+/* Cache related sections */
+#define BEGIN_CACHE_SECTION_NESTED(label)	START_FTR_SECTION(label)
+#define BEGIN_CACHE_SECTION			START_FTR_SECTION(97)
+
+#define END_CACHE_SECTION_NESTED(msk, val, label)		\
+	FTR_SECTION_ELSE_NESTED(label)				\
+	MAKE_FTR_SECTION_ENTRY(msk, val, label, __cache_fixup)
+
+#define END_CACHE_SECTION(msk, val)		\
+	END_CACHE_SECTION_NESTED(msk, val, 97)
+
+#define END_CACHE_SECTION_IFSET(msk)	END_CACHE_SECTION((msk), (msk))
+#define END_CACHE_SECTION_IFCLR(msk)	END_CACHE_SECTION((msk), 0)
+
+/* CACHE feature sections with alternatives, use BEGIN_FTR_SECTION to start */
+#define CACHE_SECTION_ELSE_NESTED(label)	FTR_SECTION_ELSE_NESTED(label)
+#define CACHE_SECTION_ELSE	CACHE_SECTION_ELSE_NESTED(97)
+#define ALT_CACHE_SECTION_END_NESTED(msk, val, label)	\
+	MAKE_FTR_SECTION_ENTRY(msk, val, label, __cache_fixup)
+#define ALT_CACHE_SECTION_END_NESTED_IFSET(msk, label)	\
+	ALT_CACHE_SECTION_END_NESTED(msk, msk, label)
+#define ALT_CACHE_SECTION_END_NESTED_IFCLR(msk, label)	\
+	ALT_CACHE_SECTION_END_NESTED(msk, 0, label)
+#define ALT_CACHE_SECTION_END(msk, val)	\
+	ALT_CACHE_SECTION_END_NESTED(msk, val, 97)
+#define ALT_CACHE_SECTION_END_IFSET(msk)	\
+	ALT_CACHE_SECTION_END_NESTED_IFSET(msk, 97)
+#define ALT_CACHE_SECTION_END_IFCLR(msk)	\
+	ALT_CACHE_SECTION_END_NESTED_IFCLR(msk, 97)
+
 #endif /* __ASM_POWERPC_FEATURE_FIXUPS_H */
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 07831ed..41d39da 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -122,6 +122,9 @@ notrace void __init machine_init(u64 dt_ptr)
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
+	do_feature_fixups(CACHE_NOW_ON, &__start___cache_fixup,
+			  &__stop___cache_fixup);
+
 	/* Do some early initialization based on the flat device tree */
 	early_init_devtree(__va(dt_ptr));
 
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 1db6851..3c7dcab 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -148,6 +148,14 @@ SECTIONS
 		__stop___fw_ftr_fixup = .;
 	}
 #endif
+#ifdef CONFIG_PPC32
+	. = ALIGN(8);
+	__cache_fixup : AT(ADDR(__cache_fixup) - LOAD_OFFSET) {
+		__start___cache_fixup = .;
+		*(__cache_fixup)
+		__stop___cache_fixup = .;
+	}
+#endif
 	.init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {
 		INIT_RAM_FS
 	}
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 2ef50c6..c0b8d52 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -87,7 +87,11 @@ _GLOBAL(memset)
 	add	r5,r0,r5
 	subf	r6,r0,r6
 	cmplwi	0,r4,0
+BEGIN_CACHE_SECTION
+	b	2f	/* Use normal procedure until cache is active */
+CACHE_SECTION_ELSE
 	bne	2f	/* Use normal procedure if r4 is not zero */
+ALT_CACHE_SECTION_END_IFCLR(CACHE_NOW_ON)
 
 	clrlwi	r7,r6,32-LG_CACHELINE_BYTES
 	add	r8,r7,r5
@@ -172,7 +176,19 @@ _GLOBAL(memcpy)
 	mtctr	r0
 	beq	63f
 53:
+	/*
+	 * During early init, cache might not be active yet, so dcbz cannot be
+	 * used. We put dcbtst instead of dcbz. If cache is not active, it's
+	 * just like a nop. If cache is active, at least it prefetchs the line
+	 * to be overwritten.
+	 * Will be replaced by dcbz at runtime in machine_init()
+	 */
+BEGIN_CACHE_SECTION
+	dcbtst	r11,r6
+CACHE_SECTION_ELSE
 	dcbz	r11,r6
+ALT_CACHE_SECTION_END_IFCLR(CACHE_NOW_ON)
+
 	COPY_16_BYTES
 #if L1_CACHE_BYTES >= 32
 	COPY_16_BYTES
-- 
2.1.0
