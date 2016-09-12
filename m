Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXXTq45QtzDsMB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 12:54:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mroos@linux.ee
Subject: [PATCH] powerpc/kernel: Fix size of NUM_CPU_FTR_KEYS on 32-bit
Date: Mon, 12 Sep 2016 12:54:50 +1000
Message-Id: <1473648890-17909-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The number of CPU feature keys is meant to map 1:1 to the number of CPU
feature flags defined in cputable.h, and the latter must fit in an
unsigned long.

In commit 4db7327194db ("powerpc: Add option to use jump label for
cpu_has_feature()"), I incorrectly defined NUM_CPU_FTR_KEYS to 64.

There should be no real adverse consequences of this bug, other than us
allocating too many keys.

Fix it by using BITS_PER_LONG.

Fixes: 4db7327194db ("powerpc: Add option to use jump label for cpu_has_feature()")
Tested-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cpu_has_feature.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cpu_has_feature.h b/arch/powerpc/include/asm/cpu_has_feature.h
index 2ef55f8968a2..b312b152461b 100644
--- a/arch/powerpc/include/asm/cpu_has_feature.h
+++ b/arch/powerpc/include/asm/cpu_has_feature.h
@@ -15,7 +15,7 @@ static inline bool early_cpu_has_feature(unsigned long feature)
 #ifdef CONFIG_JUMP_LABEL_FEATURE_CHECKS
 #include <linux/jump_label.h>
 
-#define NUM_CPU_FTR_KEYS	64
+#define NUM_CPU_FTR_KEYS	BITS_PER_LONG
 
 extern struct static_key_true cpu_feature_keys[NUM_CPU_FTR_KEYS];
 
-- 
2.7.4
