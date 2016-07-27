Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxtZ5Y9lzDrLP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:18:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: [PATCH v3 09/21] powerpc/kernel: Convert cpu_has_feature() to
 returning bool
Date: Thu, 28 Jul 2016 00:18:05 +1000
Message-Id: <1469629097-30859-9-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The intention is that the result is only used as a boolean, so enforce
that by changing the return type to bool.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

v3: Split out.

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index df4fb5faba43..7bb87017d9db 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -2,6 +2,7 @@
 #define __ASM_POWERPC_CPUTABLE_H
 
 
+#include <linux/types.h>
 #include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
 #include <uapi/asm/cputable.h>
@@ -576,12 +577,10 @@ enum {
 };
 #endif /* __powerpc64__ */
 
-static inline int cpu_has_feature(unsigned long feature)
+static inline bool cpu_has_feature(unsigned long feature)
 {
-	return (CPU_FTRS_ALWAYS & feature) ||
-	       (CPU_FTRS_POSSIBLE
-		& cur_cpu_spec->cpu_features
-		& feature);
+	return !!((CPU_FTRS_ALWAYS & feature) ||
+		  (CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature));
 }
 
 #define HBP_NUM 1
-- 
2.7.4
