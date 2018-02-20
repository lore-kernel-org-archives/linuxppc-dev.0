Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmCvk4sZzzDqfm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 08:10:58 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id x18so2582086pln.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 13:10:58 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/9] powerpc/64s: fix CPU_FTRS_POSSIBLE vector features
Date: Wed, 21 Feb 2018 05:08:25 +1000
Message-Id: <20180220190832.1872-3-npiggin@gmail.com>
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

ALTIVEC and VSX features are not default in the POWER CPU feature
sets because they are intended to be enabled by firmware. They
should be added individually to the CPU_FTRS_POSSIBLE set. It
already contains CPU_FTR_VSX, so add ALTIVEC. This becomes
important with a reduced set of supported CPUs.

The _COMP features should be used because they won't be present
if compiled out.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/cputable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 1fb9b1ea4662..27bb8e96ce7a 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -488,8 +488,8 @@ static inline void cpu_feature_keys_init(void) { }
 	    (CPU_FTRS_POWER4 | CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | \
 	     CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | \
 	     CPU_FTRS_POWER8 | CPU_FTRS_POWER8_DD1 | CPU_FTRS_CELL | \
-	     CPU_FTRS_PA6T | CPU_FTR_VSX | CPU_FTRS_POWER9 | \
-	     CPU_FTRS_POWER9_DD1 | CPU_FTRS_POWER9_DD2_1)
+	     CPU_FTRS_PA6T | CPU_FTR_ALTIVEC_COMP | CPU_FTR_VSX_COMP | \
+	     CPU_FTRS_POWER9 | CPU_FTRS_POWER9_DD1 | CPU_FTRS_POWER9_DD2_1)
 #endif
 #else
 enum {
-- 
2.16.1
