Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GsZC41vPzF1wB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 15:58:11 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id v5-v6so15719610plo.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 22:58:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/2] powerpc/64s: Fix POWER9 DD2.2 and above in cputable
 features
Date: Thu,  5 Apr 2018 15:57:55 +1000
Message-Id: <20180405055755.30090-3-npiggin@gmail.com>
In-Reply-To: <20180405055755.30090-1-npiggin@gmail.com>
References: <20180405055755.30090-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CPU_FTR_POWER9_DD2_1 flag is intended to be set for DD2.1 and
above (which is what the dt_cpu_ftrs setup does). Fix cputable for
DD2.2 to match.

This came about due to patches b5af4f279323 ("powerpc: Add CPU feature
bits for TM bug workarounds on POWER9 v2.2"), and 9e9626ed3a4a
("powerpc/64s: Fix POWER9 DD2.2 and above in DT CPU features") being
in-flight at once. The latter patch fixed dt_cpu_ftrs like this one
does. The former changed cputable to match dt_cpu_ftrs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/cputable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 4e332f3531c5..931dda8be87c 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -467,7 +467,8 @@ static inline void cpu_feature_keys_init(void) { }
 			     (~CPU_FTR_SAO))
 #define CPU_FTRS_POWER9_DD2_0 CPU_FTRS_POWER9
 #define CPU_FTRS_POWER9_DD2_1 (CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD2_1)
-#define CPU_FTRS_POWER9_DD2_2 (CPU_FTRS_POWER9 | CPU_FTR_P9_TM_HV_ASSIST | \
+#define CPU_FTRS_POWER9_DD2_2 (CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD2_1 | \
+			       CPU_FTR_P9_TM_HV_ASSIST | \
 			       CPU_FTR_P9_TM_XER_SO_BUG)
 #define CPU_FTRS_CELL	(CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
-- 
2.16.3
