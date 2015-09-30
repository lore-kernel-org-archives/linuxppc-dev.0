Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423DB1A04ED
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:05 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 12:29:04 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9FE30357804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:03 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8U2Stc155509040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:03 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8U2SUKM008354
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:28:31 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 15/31] powerpc/booke: Move booke headers (part 3)
Date: Wed, 30 Sep 2015 07:57:08 +0530
Message-Id: <1443580044-30659-16-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 .../include/asm/{pgtable-ppc64-4k.h => nohash/64/pgtable-4k.h} |  0
 .../asm/{pgtable-ppc64-64k.h => nohash/64/pgtable-64k.h}       |  0
 arch/powerpc/include/asm/nohash/64/pgtable.h                   | 10 +++++-----
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/powerpc/include/asm/{pgtable-ppc64-4k.h => nohash/64/pgtable-4k.h} (100%)
 rename arch/powerpc/include/asm/{pgtable-ppc64-64k.h => nohash/64/pgtable-64k.h} (100%)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64-4k.h b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
similarity index 100%
rename from arch/powerpc/include/asm/pgtable-ppc64-4k.h
rename to arch/powerpc/include/asm/nohash/64/pgtable-4k.h
diff --git a/arch/powerpc/include/asm/pgtable-ppc64-64k.h b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
similarity index 100%
rename from arch/powerpc/include/asm/pgtable-ppc64-64k.h
rename to arch/powerpc/include/asm/nohash/64/pgtable-64k.h
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 8f6195f147a4..1b582e56b60c 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -1,14 +1,14 @@
-#ifndef _ASM_POWERPC_PGTABLE_PPC64_H_
-#define _ASM_POWERPC_PGTABLE_PPC64_H_
+#ifndef _ASM_POWERPC_NOHASH_64_PGTABLE_H
+#define _ASM_POWERPC_NOHASH_64_PGTABLE_H
 /*
  * This file contains the functions and defines necessary to modify and use
  * the ppc64 hashed page table.
  */
 
 #ifdef CONFIG_PPC_64K_PAGES
-#include <asm/pgtable-ppc64-64k.h>
+#include <asm/nohash/64/pgtable-64k.h>
 #else
-#include <asm/pgtable-ppc64-4k.h>
+#include <asm/nohash/64/pgtable-4k.h>
 #endif
 #include <asm/barrier.h>
 
@@ -629,4 +629,4 @@ static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
 	return true;
 }
 #endif /* __ASSEMBLY__ */
-#endif /* _ASM_POWERPC_PGTABLE_PPC64_H_ */
+#endif /* _ASM_POWERPC_NOHASH_64_PGTABLE_H */
-- 
2.5.0
