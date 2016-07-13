Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDKY5GVWzDqQd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:38:25 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9YEVV078246
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:38:23 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452at789u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:38:23 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:38:22 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8 01/10] powerpc/mm: Add __cpu/__mmu_has_feature
Date: Wed, 13 Jul 2016 15:08:01 +0530
In-Reply-To: <1468402690-5373-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1468402690-5373-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1468402690-5373-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In later patches, we will be switching cpu and mmu feature check to
use static keys. This would require us to have a variant of feature
check that can be used in early boot before jump label is initialized.
This patch adds the same. We also add a variant for radix_enabled()
check

We also update the return type to bool.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 19 +++++++++++++++----
 arch/powerpc/include/asm/cputable.h      | 15 ++++++++++-----
 arch/powerpc/include/asm/mmu.h           | 13 +++++++++++--
 arch/powerpc/xmon/ppc-dis.c              |  1 +
 4 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 6d8306d9aa7a..1bb0e536c76b 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -24,9 +24,20 @@ struct mmu_psize_def {
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 
 #ifdef CONFIG_PPC_RADIX_MMU
-#define radix_enabled() mmu_has_feature(MMU_FTR_TYPE_RADIX)
+static inline bool radix_enabled(void)
+{
+	return mmu_has_feature(MMU_FTR_TYPE_RADIX);
+}
+#define radix_enabled radix_enabled
+
+static inline bool __radix_enabled(void)
+{
+	return __mmu_has_feature(MMU_FTR_TYPE_RADIX);
+}
+#define __radix_enabled __radix_enabled
 #else
 #define radix_enabled() (0)
+#define __radix_enabled() (0)
 #endif
 
 #endif /* __ASSEMBLY__ */
@@ -111,7 +122,7 @@ extern void hash__early_init_mmu(void);
 extern void radix__early_init_mmu(void);
 static inline void early_init_mmu(void)
 {
-	if (radix_enabled())
+	if (__radix_enabled())
 		return radix__early_init_mmu();
 	return hash__early_init_mmu();
 }
@@ -119,7 +130,7 @@ extern void hash__early_init_mmu_secondary(void);
 extern void radix__early_init_mmu_secondary(void);
 static inline void early_init_mmu_secondary(void)
 {
-	if (radix_enabled())
+	if (__radix_enabled())
 		return radix__early_init_mmu_secondary();
 	return hash__early_init_mmu_secondary();
 }
@@ -131,7 +142,7 @@ extern void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 static inline void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 					      phys_addr_t first_memblock_size)
 {
-	if (radix_enabled())
+	if (__radix_enabled())
 		return radix__setup_initial_memory_limit(first_memblock_base,
 						   first_memblock_size);
 	return hash__setup_initial_memory_limit(first_memblock_base,
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index df4fb5faba43..dfdf36bc2664 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -576,12 +576,17 @@ enum {
 };
 #endif /* __powerpc64__ */
 
-static inline int cpu_has_feature(unsigned long feature)
+static inline bool __cpu_has_feature(unsigned long feature)
 {
-	return (CPU_FTRS_ALWAYS & feature) ||
-	       (CPU_FTRS_POSSIBLE
-		& cur_cpu_spec->cpu_features
-		& feature);
+	if (CPU_FTRS_ALWAYS & feature)
+		return true;
+
+	return !!(CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature);
+}
+
+static inline bool cpu_has_feature(unsigned long feature)
+{
+	return __cpu_has_feature(feature);
 }
 
 #define HBP_NUM 1
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 0e7c1a262075..828b92faec91 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -134,9 +134,14 @@ enum {
 		0,
 };
 
-static inline int mmu_has_feature(unsigned long feature)
+static inline bool __mmu_has_feature(unsigned long feature)
 {
-	return (MMU_FTRS_POSSIBLE & cur_cpu_spec->mmu_features & feature);
+	return !!(MMU_FTRS_POSSIBLE & cur_cpu_spec->mmu_features & feature);
+}
+
+static inline bool mmu_has_feature(unsigned long feature)
+{
+	return __mmu_has_feature(feature);
 }
 
 static inline void mmu_clear_feature(unsigned long feature)
@@ -232,5 +237,9 @@ extern void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 #define radix_enabled() (0)
 #endif
 
+#ifndef __radix_enabled
+#define __radix_enabled() (0)
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_MMU_H_ */
diff --git a/arch/powerpc/xmon/ppc-dis.c b/arch/powerpc/xmon/ppc-dis.c
index 89098f320ad5..acad77b4f7b6 100644
--- a/arch/powerpc/xmon/ppc-dis.c
+++ b/arch/powerpc/xmon/ppc-dis.c
@@ -19,6 +19,7 @@ You should have received a copy of the GNU General Public License
 along with this file; see the file COPYING.  If not, write to the Free
 Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.  */
 
+#include <linux/types.h>
 #include <asm/cputable.h>
 #include "nonstdio.h"
 #include "ansidecl.h"
-- 
2.7.4
