Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDxk1nypzDqBg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:26:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 09/70] powerpc/mm: Convert pte_user() to static inline
Date: Fri, 29 Apr 2016 23:25:32 +1000
Message-Id: <1461936393-10131-9-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In a subsequent patch we want to add a second definition of pte_user().
Before we do that, make the signature clear, ie. it takes a pte_t and
returns bool.

We move it up inside the existing #ifndef __ASSEMBLY__ block, but
otherwise it's a straight conversion.

Convert the call in settlbcam(), which passes an unsigned long, to pass
a pte_t.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/pte-common.h | 17 ++++++++++-------
 arch/powerpc/mm/fsl_booke_mmu.c       |  2 +-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 9f5dea58b0db..5f457535573b 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -76,6 +76,16 @@
  */
 #ifndef __ASSEMBLY__
 extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
+
+/*
+ * Don't just check for any non zero bits in __PAGE_USER, since for book3e
+ * and PTE_64BIT, PAGE_KERNEL_X contains _PAGE_BAP_SR which is also in
+ * _PAGE_USER.  Need to explicitly match _PAGE_BAP_UR bit in that case too.
+ */
+static inline bool pte_user(pte_t pte)
+{
+	return (pte_val(pte) & _PAGE_USER) == _PAGE_USER;
+}
 #endif /* __ASSEMBLY__ */
 
 /* Location of the PFN in the PTE. Most 32-bit platforms use the same
@@ -184,13 +194,6 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
 /* Make modules code happy. We don't set RO yet */
 #define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
 
-/*
- * Don't just check for any non zero bits in __PAGE_USER, since for book3e
- * and PTE_64BIT, PAGE_KERNEL_X contains _PAGE_BAP_SR which is also in
- * _PAGE_USER.  Need to explicitly match _PAGE_BAP_UR bit in that case too.
- */
-#define pte_user(val)		((val & _PAGE_USER) == _PAGE_USER)
-
 /* Advertise special mapping type for AGP */
 #define PAGE_AGP		(PAGE_KERNEL_NC)
 #define HAVE_PAGE_AGP
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index a1b2713f6e96..139dec421e57 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -135,7 +135,7 @@ static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 		TLBCAM[index].MAS7 = (u64)phys >> 32;
 
 	/* Below is unlikely -- only for large user pages or similar */
-	if (pte_user(flags)) {
+	if (pte_user(__pte(flags))) {
 	   TLBCAM[index].MAS3 |= MAS3_UX | MAS3_UR;
 	   TLBCAM[index].MAS3 |= ((flags & _PAGE_RW) ? MAS3_UW : 0);
 	}
-- 
2.5.0
