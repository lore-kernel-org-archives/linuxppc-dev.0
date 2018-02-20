Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmFCj1Tg5zF1Bn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 09:09:53 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id ay8so8213810plb.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 14:09:52 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 8/9] powerpc/64s/le: refine feature sets for little endian
 builds
Date: Wed, 21 Feb 2018 05:08:31 +1000
Message-Id: <20180220190832.1872-9-npiggin@gmail.com>
In-Reply-To: <20180220190832.1872-1-npiggin@gmail.com>
References: <20180220190832.1872-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reduces vmlinux text size by 1kB and data by 1.5kB with
a small build!

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/cputable.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 8907f44df708..cb423f2a5696 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -479,6 +479,13 @@ static inline void cpu_feature_keys_init(void) { }
 #ifdef CONFIG_PPC_BOOK3E
 #define CPU_FTRS_POSSIBLE	(CPU_FTRS_E6500 | CPU_FTRS_E5500)
 #else
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define CPU_FTRS_POSSIBLE	\
+	    (CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | \
+	     CPU_FTRS_POWER8 | CPU_FTRS_POWER8_DD1 | \
+	     CPU_FTR_ALTIVEC_COMP | CPU_FTR_VSX_COMP | \
+	     CPU_FTRS_POWER9 | CPU_FTRS_POWER9_DD1 | CPU_FTRS_POWER9_DD2_1)
+#else
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | \
 	     CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | \
@@ -486,6 +493,7 @@ static inline void cpu_feature_keys_init(void) { }
 	     CPU_FTRS_PA6T | CPU_FTR_ALTIVEC_COMP | CPU_FTR_VSX_COMP | \
 	     CPU_FTRS_POWER9 | CPU_FTRS_POWER9_DD1 | CPU_FTRS_POWER9_DD2_1)
 #endif
+#endif
 #else
 enum {
 	CPU_FTRS_POSSIBLE =
@@ -531,6 +539,13 @@ enum {
 #ifdef CONFIG_PPC_BOOK3E
 #define CPU_FTRS_ALWAYS		(CPU_FTRS_E6500 & CPU_FTRS_E5500)
 #else
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define CPU_FTRS_ALWAYS \
+	    (CPU_FTRS_POWER7 & CPU_FTRS_POWER8E & \
+	     CPU_FTRS_POWER8 & CPU_FTRS_POWER8_DD1 & \
+	     CPU_FTRS_POWER9 & CPU_FTRS_POWER9_DD1 & CPU_FTRS_POWER9_DD2_1 & \
+	     CPU_FTRS_POSSIBLE & ~CPU_FTR_HVMODE)
+#else
 #define CPU_FTRS_ALWAYS		\
 	    (CPU_FTRS_PPC970 & CPU_FTRS_POWER5 & \
 	     CPU_FTRS_POWER6 & CPU_FTRS_POWER7 & CPU_FTRS_CELL & \
@@ -538,6 +553,7 @@ enum {
 	     CPU_FTRS_POWER8_DD1 & ~CPU_FTR_HVMODE & CPU_FTRS_POSSIBLE & \
 	     CPU_FTRS_POWER9 & CPU_FTRS_POWER9_DD1 & CPU_FTRS_POWER9_DD2_1)
 #endif
+#endif
 #else
 enum {
 	CPU_FTRS_ALWAYS =
-- 
2.16.1
