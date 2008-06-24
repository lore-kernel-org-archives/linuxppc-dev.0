Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <f05ebfb9b74b4244142895b4252be6a70905e69e.1214271072.git.michael@ellerman.id.au>
In-Reply-To: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 10/14] powerpc: Consolidate feature fixup macros for 64/32 bit
Date: Tue, 24 Jun 2008 11:32:48 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currentl we have three versions of MAKE_FTR_SECTION_ENTRY(), the macro that
generates a feature section entry. There is 64bit version, a 32bit version
and version for 32bit code built with a 64bit kernel.

Rather than triplicating (?) the MAKE_FTR_SECTION_ENTRY() logic, we can
move the 64bit/32bit differences into separate macros, and then only have
one version of MAKE_FTR_SECTION_ENTRY().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 include/asm-powerpc/feature-fixups.h |   54 ++++++++-------------------------
 1 files changed, 13 insertions(+), 41 deletions(-)

diff --git a/include/asm-powerpc/feature-fixups.h b/include/asm-powerpc/feature-fixups.h
index 8597212..35f9278 100644
--- a/include/asm-powerpc/feature-fixups.h
+++ b/include/asm-powerpc/feature-fixups.h
@@ -19,55 +19,27 @@
  * that values will be negative, that is, the fixup table has to be
  * located after the code it fixes up.
  */
-#ifdef CONFIG_PPC64
-
-#ifdef __powerpc64__
-
-/* 64 bits kernel, 64 bits code */
-#define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)	\
-99:							\
-	.section sect,"a";				\
-	.align 3;					\
-98:						       	\
-	.llong msk;					\
-	.llong val;					\
-	.llong label##b-98b;				\
-	.llong 99b-98b;		 			\
-	.previous
-
-#else /* __powerpc64__ */
-
+#if defined(CONFIG_PPC64) && !defined(__powerpc64__)
 /* 64 bits kernel, 32 bits code (ie. vdso32) */
+#define FTR_ENTRY_LONG		.llong
+#define FTR_ENTRY_OFFSET	.long 0xffffffff; .long
+#else
+/* 64 bit kernel 64 bit code, or 32 bit kernel 32 bit code */
+#define FTR_ENTRY_LONG		PPC_LONG
+#define FTR_ENTRY_OFFSET	PPC_LONG
+#endif
+
 #define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)	\
 99:							\
 	.section sect,"a";				\
 	.align 3;					\
 98:						       	\
-	.llong msk;					\
-	.llong val;					\
-	.long 0xffffffff;      				\
-	.long label##b-98b;				\
-	.long 0xffffffff;	       			\
-	.long 99b-98b;		 			\
-	.previous
-
-#endif /* !__powerpc64__ */
-
-#else /* CONFIG_PPC64 */
-
-/* 32 bits kernel, 32 bits code */
-#define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)	\
-99:						       	\
-	.section sect,"a";			       	\
-	.align 2;				       	\
-98:						       	\
-	.long msk;				       	\
-	.long val;				       	\
-	.long label##b-98b;			       	\
-	.long 99b-98b;				       	\
+	FTR_ENTRY_LONG msk;				\
+	FTR_ENTRY_LONG val;				\
+	FTR_ENTRY_OFFSET label##b-98b;			\
+	FTR_ENTRY_OFFSET 99b-98b;		 	\
 	.previous
 
-#endif /* !CONFIG_PPC64 */
 
 
 /* CPU feature dependent sections */
-- 
1.5.5
