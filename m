Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B6301A0754
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 21:08:56 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 17 Oct 2015 15:38:54 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id BBD0F1258065
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:38:38 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9HA8oqK12386538
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:38:51 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9HA8oKb016917
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:38:50 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V4 03/31] powerpc/mm: make a separate copy for book3s
Date: Sat, 17 Oct 2015 15:38:14 +0530
Message-Id: <1445076522-20527-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

In this patch we do:
cp pgtable-ppc32.h book3s/32/pgtable.h
cp pgtable-ppc64.h book3s/64/pgtable.h

This enable us to do further changes to hash specific config.
We will change the page table format for 64bit hash in later patches.

Acked-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 .../include/asm/{pgtable-ppc32.h => book3s/32/pgtable.h}       |  0
 .../include/asm/{pgtable-ppc64.h => book3s/64/pgtable.h}       |  0
 arch/powerpc/include/asm/book3s/pgtable.h                      | 10 ++++++++++
 arch/powerpc/include/asm/mmu-hash64.h                          |  2 +-
 arch/powerpc/include/asm/pgtable.h                             |  4 ++++
 5 files changed, 15 insertions(+), 1 deletion(-)
 copy arch/powerpc/include/asm/{pgtable-ppc32.h => book3s/32/pgtable.h} (100%)
 copy arch/powerpc/include/asm/{pgtable-ppc64.h => book3s/64/pgtable.h} (100%)
 create mode 100644 arch/powerpc/include/asm/book3s/pgtable.h

diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
similarity index 100%
copy from arch/powerpc/include/asm/pgtable-ppc32.h
copy to arch/powerpc/include/asm/book3s/32/pgtable.h
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
similarity index 100%
copy from arch/powerpc/include/asm/pgtable-ppc64.h
copy to arch/powerpc/include/asm/book3s/64/pgtable.h
diff --git a/arch/powerpc/include/asm/book3s/pgtable.h b/arch/powerpc/include/asm/book3s/pgtable.h
new file mode 100644
index 000000000000..a8d8e5152bd4
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/pgtable.h
@@ -0,0 +1,10 @@
+#ifndef _ASM_POWERPC_BOOK3S_PGTABLE_H
+#define _ASM_POWERPC_BOOK3S_PGTABLE_H
+
+#ifdef CONFIG_PPC64
+#include <asm/book3s/64/pgtable.h>
+#else
+#include <asm/book3s/32/pgtable.h>
+#endif
+
+#endif
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index ba3342bbdbda..7352d3f212df 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -21,7 +21,7 @@
  * need for various slices related matters. Note that this isn't the
  * complete pgtable.h but only a portion of it.
  */
-#include <asm/pgtable-ppc64.h>
+#include <asm/book3s/64/pgtable.h>
 #include <asm/bug.h>
 #include <asm/processor.h>
 
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index b64b4212b71f..c304d0767919 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -13,11 +13,15 @@ struct mm_struct;
 
 #endif /* !__ASSEMBLY__ */
 
+#ifdef CONFIG_PPC_BOOK3S
+#include <asm/book3s/pgtable.h>
+#else
 #if defined(CONFIG_PPC64)
 #  include <asm/pgtable-ppc64.h>
 #else
 #  include <asm/pgtable-ppc32.h>
 #endif
+#endif /* !CONFIG_PPC_BOOK3S */
 
 /*
  * We save the slot number & secondary bit in the second half of the
-- 
2.5.0
