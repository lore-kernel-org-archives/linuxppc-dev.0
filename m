Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAEE11A1AB4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 14:37:19 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 09:07:18 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id EDB95394005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 09:07:13 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB13bD0w65863684
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:13 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB13bCtt022050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:13 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V6 15/35] powerpc/booke: Move nohash headers (part 3)
Date: Tue,  1 Dec 2015 09:06:40 +0530
Message-Id: <1448941020-15168-16-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 9b4f9fcd64de..aebb83f84b69 100644
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
 
@@ -637,4 +637,4 @@ static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
 	return true;
 }
 #endif /* __ASSEMBLY__ */
-#endif /* _ASM_POWERPC_PGTABLE_PPC64_H_ */
+#endif /* _ASM_POWERPC_NOHASH_64_PGTABLE_H */
-- 
2.5.0
