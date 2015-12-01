Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B6691A0CC6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 14:37:18 +1100 (AEDT)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 09:07:17 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 97C84E0062
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 09:07:54 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB13bDlJ20840490
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:13 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB13bCJB022071
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:13 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V6 16/35] powerpc/booke: Move nohash headers (part 4)
Date: Tue,  1 Dec 2015 09:06:41 +0530
Message-Id: <1448941020-15168-17-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h             | 16 ++++++++--------
 arch/powerpc/include/asm/{ => nohash/32}/pte-40x.h       |  0
 arch/powerpc/include/asm/{ => nohash/32}/pte-44x.h       |  0
 arch/powerpc/include/asm/{ => nohash/32}/pte-8xx.h       |  0
 arch/powerpc/include/asm/{ => nohash/32}/pte-fsl-booke.h |  0
 arch/powerpc/include/asm/nohash/64/pgtable.h             |  2 +-
 arch/powerpc/include/asm/{ => nohash}/pte-book3e.h       |  0
 7 files changed, 9 insertions(+), 9 deletions(-)
 rename arch/powerpc/include/asm/{ => nohash/32}/pte-40x.h (100%)
 rename arch/powerpc/include/asm/{ => nohash/32}/pte-44x.h (100%)
 rename arch/powerpc/include/asm/{ => nohash/32}/pte-8xx.h (100%)
 rename arch/powerpc/include/asm/{ => nohash/32}/pte-fsl-booke.h (100%)
 rename arch/powerpc/include/asm/{ => nohash}/pte-book3e.h (100%)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index fbb23c54b998..c82cbf52d19e 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_PGTABLE_PPC32_H
-#define _ASM_POWERPC_PGTABLE_PPC32_H
+#ifndef _ASM_POWERPC_NOHASH_32_PGTABLE_H
+#define _ASM_POWERPC_NOHASH_32_PGTABLE_H
 
 #include <asm-generic/pgtable-nopmd.h>
 
@@ -106,15 +106,15 @@ extern int icache_44x_need_flush;
  */
 
 #if defined(CONFIG_40x)
-#include <asm/pte-40x.h>
+#include <asm/nohash/32/pte-40x.h>
 #elif defined(CONFIG_44x)
-#include <asm/pte-44x.h>
+#include <asm/nohash/32/pte-44x.h>
 #elif defined(CONFIG_FSL_BOOKE) && defined(CONFIG_PTE_64BIT)
-#include <asm/pte-book3e.h>
+#include <asm/nohash/pte-book3e.h>
 #elif defined(CONFIG_FSL_BOOKE)
-#include <asm/pte-fsl-booke.h>
+#include <asm/nohash/32/pte-fsl-booke.h>
 #elif defined(CONFIG_8xx)
-#include <asm/pte-8xx.h>
+#include <asm/nohash/32/pte-8xx.h>
 #endif
 
 /* And here we include common definitions */
@@ -340,4 +340,4 @@ extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep,
 
 #endif /* !__ASSEMBLY__ */
 
-#endif /* _ASM_POWERPC_PGTABLE_PPC32_H */
+#endif /* __ASM_POWERPC_NOHASH_32_PGTABLE_H */
diff --git a/arch/powerpc/include/asm/pte-40x.h b/arch/powerpc/include/asm/nohash/32/pte-40x.h
similarity index 100%
rename from arch/powerpc/include/asm/pte-40x.h
rename to arch/powerpc/include/asm/nohash/32/pte-40x.h
diff --git a/arch/powerpc/include/asm/pte-44x.h b/arch/powerpc/include/asm/nohash/32/pte-44x.h
similarity index 100%
rename from arch/powerpc/include/asm/pte-44x.h
rename to arch/powerpc/include/asm/nohash/32/pte-44x.h
diff --git a/arch/powerpc/include/asm/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
similarity index 100%
rename from arch/powerpc/include/asm/pte-8xx.h
rename to arch/powerpc/include/asm/nohash/32/pte-8xx.h
diff --git a/arch/powerpc/include/asm/pte-fsl-booke.h b/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h
similarity index 100%
rename from arch/powerpc/include/asm/pte-fsl-booke.h
rename to arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index aebb83f84b69..c24e03f22655 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -97,7 +97,7 @@
 /*
  * Include the PTE bits definitions
  */
-#include <asm/pte-book3e.h>
+#include <asm/nohash/pte-book3e.h>
 #include <asm/pte-common.h>
 
 #ifdef CONFIG_PPC_MM_SLICES
diff --git a/arch/powerpc/include/asm/pte-book3e.h b/arch/powerpc/include/asm/nohash/pte-book3e.h
similarity index 100%
rename from arch/powerpc/include/asm/pte-book3e.h
rename to arch/powerpc/include/asm/nohash/pte-book3e.h
-- 
2.5.0
