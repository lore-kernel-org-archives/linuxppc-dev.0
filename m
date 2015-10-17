Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 692D11A0291
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 21:09:00 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 17 Oct 2015 15:38:57 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 0E17B3940060
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:38:55 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9HA8sRP5636586
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:38:54 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9HA8rvi017157
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:38:54 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V4 14/31] powerpc/booke: Move nohash headers (part 2)
Date: Sat, 17 Oct 2015 15:38:25 +0530
Message-Id: <1445076522-20527-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1445076522-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1445076522-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/{pgtable-ppc32.h => nohash/32/pgtable.h} | 0
 arch/powerpc/include/asm/{pgtable-ppc64.h => nohash/64/pgtable.h} | 2 +-
 arch/powerpc/include/asm/nohash/pgtable.h                         | 8 ++++----
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/powerpc/include/asm/{pgtable-ppc32.h => nohash/32/pgtable.h} (100%)
 rename arch/powerpc/include/asm/{pgtable-ppc64.h => nohash/64/pgtable.h} (99%)

diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
similarity index 100%
rename from arch/powerpc/include/asm/pgtable-ppc32.h
rename to arch/powerpc/include/asm/nohash/32/pgtable.h
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
similarity index 99%
rename from arch/powerpc/include/asm/pgtable-ppc64.h
rename to arch/powerpc/include/asm/nohash/64/pgtable.h
index 6be203d43fd1..9b4f9fcd64de 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -18,7 +18,7 @@
  * Size of EA range mapped by our pagetables.
  */
 #define PGTABLE_EADDR_SIZE (PTE_INDEX_SIZE + PMD_INDEX_SIZE + \
-                	    PUD_INDEX_SIZE + PGD_INDEX_SIZE + PAGE_SHIFT)
+			    PUD_INDEX_SIZE + PGD_INDEX_SIZE + PAGE_SHIFT)
 #define PGTABLE_RANGE (ASM_CONST(1) << PGTABLE_EADDR_SIZE)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 91325997ba25..c0c41a2409d2 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -1,10 +1,10 @@
-#ifndef _ASM_POWERPC_PGTABLE_BOOK3E_H
-#define _ASM_POWERPC_PGTABLE_BOOK3E_H
+#ifndef _ASM_POWERPC_NOHASH_PGTABLE_H
+#define _ASM_POWERPC_NOHASH_PGTABLE_H
 
 #if defined(CONFIG_PPC64)
-#include <asm/pgtable-ppc64.h>
+#include <asm/nohash/64/pgtable.h>
 #else
-#include <asm/pgtable-ppc32.h>
+#include <asm/nohash/32/pgtable.h>
 #endif
 
 #ifndef __ASSEMBLY__
-- 
2.5.0
