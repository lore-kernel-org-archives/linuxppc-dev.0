Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxtd0WKtzDrLR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:18:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: [PATCH v3 11/21] powerpc/mm: Add __cpu/__mmu_has_feature()
Date: Thu, 28 Jul 2016 00:18:07 +1000
Message-Id: <1469629097-30859-11-git-send-email-mpe@ellerman.id.au>
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

In later patches, we will be switching cpu and mmu feature checks to
use static keys. For checks in early boot before jump label is
initialized we need a variant of cpu/mmu_has_feature() that doesn't use
jump labels. So create those called, unimaginatively,
__cpu/__mmu_has_feature().

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h |  7 ++++++-
 arch/powerpc/include/asm/mmu.h      | 17 ++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

v3: Don't change any logic.
    Bool conversions were split out.
    Don't convert any call sites in this patch.

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 7bb87017d9db..85a6797f9231 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -577,12 +577,17 @@ enum {
 };
 #endif /* __powerpc64__ */
 
-static inline bool cpu_has_feature(unsigned long feature)
+static inline bool __cpu_has_feature(unsigned long feature)
 {
 	return !!((CPU_FTRS_ALWAYS & feature) ||
 		  (CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature));
 }
 
+static inline bool cpu_has_feature(unsigned long feature)
+{
+	return __cpu_has_feature(feature);
+}
+
 #define HBP_NUM 1
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index f413b3213a3b..e3eff365e55d 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -135,11 +135,16 @@ enum {
 		0,
 };
 
-static inline bool mmu_has_feature(unsigned long feature)
+static inline bool __mmu_has_feature(unsigned long feature)
 {
 	return !!(MMU_FTRS_POSSIBLE & cur_cpu_spec->mmu_features & feature);
 }
 
+static inline bool mmu_has_feature(unsigned long feature)
+{
+	return __mmu_has_feature(feature);
+}
+
 static inline void mmu_clear_feature(unsigned long feature)
 {
 	cur_cpu_spec->mmu_features &= ~feature;
@@ -168,11 +173,21 @@ static inline bool radix_enabled(void)
 {
 	return mmu_has_feature(MMU_FTR_TYPE_RADIX);
 }
+
+static inline bool __radix_enabled(void)
+{
+	return __mmu_has_feature(MMU_FTR_TYPE_RADIX);
+}
 #else
 static inline bool radix_enabled(void)
 {
 	return false;
 }
+
+static inline bool __radix_enabled(void)
+{
+	return false;
+}
 #endif
 
 #endif /* !__ASSEMBLY__ */
-- 
2.7.4
