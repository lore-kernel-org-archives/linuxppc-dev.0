Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A38B1A03A0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:24:12 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 20:24:11 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7A9BA2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:24:08 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANAO0YH64618744
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:24:08 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANANZ08013257
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:23:36 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 14/31] powerpc/booke: Move nohash headers (part 2)
Date: Mon, 23 Nov 2015 15:52:23 +0530
Message-Id: <1448274160-28446-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
