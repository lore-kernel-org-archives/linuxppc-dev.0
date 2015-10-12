Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D5BE1A0754
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 05:40:32 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 00:10:30 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id AEC04125801B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:11 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9CIeQmM1311110
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:26 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9CIePAM013225
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:26 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v3 04/31] powerpc/mm: make a separate copy for book3s (part 2)
Date: Tue, 13 Oct 2015 00:09:48 +0530
Message-Id: <1444675215-19484-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Keep it separate to make rebasing easier

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 4 ++--
 arch/powerpc/include/asm/book3s/64/pgtable.h | 6 +++---
 arch/powerpc/include/asm/pgtable-ppc32.h     | 2 --
 arch/powerpc/include/asm/pgtable-ppc64.h     | 4 ----
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 1a58a05be99c..a7738dfbe7e5 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_PGTABLE_PPC32_H
-#define _ASM_POWERPC_PGTABLE_PPC32_H
+#ifndef _ASM_POWERPC_BOOK3S_32_PGTABLE_H
+#define _ASM_POWERPC_BOOK3S_32_PGTABLE_H
 
 #include <asm-generic/pgtable-nopmd.h>
 
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 4c61db6adcde..cdd5284d9eaa 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_PGTABLE_PPC64_H_
-#define _ASM_POWERPC_PGTABLE_PPC64_H_
+#ifndef _ASM_POWERPC_BOOK3S_64_PGTABLE_H_
+#define _ASM_POWERPC_BOOK3S_64_PGTABLE_H_
 /*
  * This file contains the functions and defines necessary to modify and use
  * the ppc64 hashed page table.
@@ -623,4 +623,4 @@ static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
 	return true;
 }
 #endif /* __ASSEMBLY__ */
-#endif /* _ASM_POWERPC_PGTABLE_PPC64_H_ */
+#endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index 1a58a05be99c..aac6547b0823 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -115,8 +115,6 @@ extern int icache_44x_need_flush;
 #include <asm/pte-fsl-booke.h>
 #elif defined(CONFIG_8xx)
 #include <asm/pte-8xx.h>
-#else /* CONFIG_6xx */
-#include <asm/book3s/32/hash.h>
 #endif
 
 /* And here we include common definitions */
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index b36a932abdfb..1ef0fea32e1e 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -97,11 +97,7 @@
 /*
  * Include the PTE bits definitions
  */
-#ifdef CONFIG_PPC_BOOK3S
-#include <asm/book3s/64/hash.h>
-#else
 #include <asm/pte-book3e.h>
-#endif
 #include <asm/pte-common.h>
 
 #ifdef CONFIG_PPC_MM_SLICES
-- 
2.5.0
