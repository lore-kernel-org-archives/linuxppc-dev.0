Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41M39x3jVxzF1wr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 02:25:25 +1000 (AEST)
Message-Id: <050c24f2b82d2dcf0007398ec69b7f0b073c3188.1530807556.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1530807556.git.christophe.leroy@c-s.fr>
References: <cover.1530807556.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 16/16] powerpc: split asm/tlbflush.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  5 Jul 2018 16:25:21 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Split asm/tlbflush.h into:
asm/nohash/tlbflush.h
asm/book3s/32/tlbflush.h
asm/book3s/64/tlbflush.h (already existing)

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/tlbflush.h    | 25 +++++++
 arch/powerpc/include/asm/book3s/tlbflush.h       | 11 +++
 arch/powerpc/include/asm/{ => nohash}/tlbflush.h | 42 ++----------
 arch/powerpc/include/asm/tlbflush.h              | 86 ++----------------------
 4 files changed, 45 insertions(+), 119 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/32/tlbflush.h
 create mode 100644 arch/powerpc/include/asm/book3s/tlbflush.h
 copy arch/powerpc/include/asm/{ => nohash}/tlbflush.h (57%)

diff --git a/arch/powerpc/include/asm/book3s/32/tlbflush.h b/arch/powerpc/include/asm/book3s/32/tlbflush.h
new file mode 100644
index 000000000000..068085b709fb
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/32/tlbflush.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_BOOK3S_32_TLBFLUSH_H
+#define _ASM_POWERPC_BOOK3S_32_TLBFLUSH_H
+
+#define MMU_NO_CONTEXT      (0)
+/*
+ * TLB flushing for "classic" hash-MMU 32-bit CPUs, 6xx, 7xx, 7xxx
+ */
+extern void flush_tlb_mm(struct mm_struct *mm);
+extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
+extern void flush_tlb_page_nohash(struct vm_area_struct *vma, unsigned long addr);
+extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+			    unsigned long end);
+extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
+static inline void local_flush_tlb_page(struct vm_area_struct *vma,
+					unsigned long vmaddr)
+{
+	flush_tlb_page(vma, vmaddr);
+}
+static inline void local_flush_tlb_mm(struct mm_struct *mm)
+{
+	flush_tlb_mm(mm);
+}
+
+#endif /* _ASM_POWERPC_TLBFLUSH_H */
diff --git a/arch/powerpc/include/asm/book3s/tlbflush.h b/arch/powerpc/include/asm/book3s/tlbflush.h
new file mode 100644
index 000000000000..dec11de41055
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/tlbflush.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_BOOK3S_TLBFLUSH_H
+#define _ASM_POWERPC_BOOK3S_TLBFLUSH_H
+
+#ifdef CONFIG_PPC64
+#include <asm/book3s/64/tlbflush.h>
+#else
+#include <asm/book3s/32/tlbflush.h>
+#endif
+
+#endif /* _ASM_POWERPC_BOOK3S_TLBFLUSH_H */
diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/nohash/tlbflush.h
similarity index 57%
copy from arch/powerpc/include/asm/tlbflush.h
copy to arch/powerpc/include/asm/nohash/tlbflush.h
index 7d5a157c7832..b1d8fec29169 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/nohash/tlbflush.h
@@ -1,5 +1,6 @@
-#ifndef _ASM_POWERPC_TLBFLUSH_H
-#define _ASM_POWERPC_TLBFLUSH_H
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_TLBFLUSH_H
+#define _ASM_POWERPC_NOHASH_TLBFLUSH_H
 
 /*
  * TLB flushing:
@@ -13,14 +14,8 @@
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
  */
-#ifdef __KERNEL__
 
-#ifdef CONFIG_PPC_MMU_NOHASH
 /*
  * TLB flushing for software loaded TLB chips
  *
@@ -55,33 +50,4 @@ extern void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 #define __flush_tlb_page(mm,addr,p,i)	__local_flush_tlb_page(mm,addr,p,i)
 #endif
 
-#elif defined(CONFIG_PPC_STD_MMU_32)
-
-#define MMU_NO_CONTEXT      (0)
-/*
- * TLB flushing for "classic" hash-MMU 32-bit CPUs, 6xx, 7xx, 7xxx
- */
-extern void flush_tlb_mm(struct mm_struct *mm);
-extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
-extern void flush_tlb_page_nohash(struct vm_area_struct *vma, unsigned long addr);
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			    unsigned long end);
-extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
-static inline void local_flush_tlb_page(struct vm_area_struct *vma,
-					unsigned long vmaddr)
-{
-	flush_tlb_page(vma, vmaddr);
-}
-static inline void local_flush_tlb_mm(struct mm_struct *mm)
-{
-	flush_tlb_mm(mm);
-}
-
-#elif defined(CONFIG_PPC_BOOK3S_64)
-#include <asm/book3s/64/tlbflush.h>
-#else
-#error Unsupported MMU type
-#endif
-
-#endif /*__KERNEL__ */
-#endif /* _ASM_POWERPC_TLBFLUSH_H */
+#endif /* _ASM_POWERPC_NOHASH_TLBFLUSH_H */
diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index 7d5a157c7832..61fba43bf8b2 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -1,87 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_POWERPC_TLBFLUSH_H
 #define _ASM_POWERPC_TLBFLUSH_H
 
-/*
- * TLB flushing:
- *
- *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
- *  - flush_tlb_page(vma, vmaddr) flushes one page
- *  - local_flush_tlb_mm(mm, full) flushes the specified mm context on
- *                           the local processor
- *  - local_flush_tlb_page(vma, vmaddr) flushes one page on the local processor
- *  - flush_tlb_page_nohash(vma, vmaddr) flushes one page if SW loaded TLB
- *  - flush_tlb_range(vma, start, end) flushes a range of pages
- *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- */
-#ifdef __KERNEL__
-
-#ifdef CONFIG_PPC_MMU_NOHASH
-/*
- * TLB flushing for software loaded TLB chips
- *
- * TODO: (CONFIG_FSL_BOOKE) determine if flush_tlb_range &
- * flush_tlb_kernel_range are best implemented as tlbia vs
- * specific tlbie's
- */
-
-struct vm_area_struct;
-struct mm_struct;
-
-#define MMU_NO_CONTEXT      	((unsigned int)-1)
-
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			    unsigned long end);
-extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
-
-extern void local_flush_tlb_mm(struct mm_struct *mm);
-extern void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
-
-extern void __local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
-				   int tsize, int ind);
-
-#ifdef CONFIG_SMP
-extern void flush_tlb_mm(struct mm_struct *mm);
-extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
-extern void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
-			     int tsize, int ind);
-#else
-#define flush_tlb_mm(mm)		local_flush_tlb_mm(mm)
-#define flush_tlb_page(vma,addr)	local_flush_tlb_page(vma,addr)
-#define __flush_tlb_page(mm,addr,p,i)	__local_flush_tlb_page(mm,addr,p,i)
-#endif
-
-#elif defined(CONFIG_PPC_STD_MMU_32)
-
-#define MMU_NO_CONTEXT      (0)
-/*
- * TLB flushing for "classic" hash-MMU 32-bit CPUs, 6xx, 7xx, 7xxx
- */
-extern void flush_tlb_mm(struct mm_struct *mm);
-extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
-extern void flush_tlb_page_nohash(struct vm_area_struct *vma, unsigned long addr);
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			    unsigned long end);
-extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
-static inline void local_flush_tlb_page(struct vm_area_struct *vma,
-					unsigned long vmaddr)
-{
-	flush_tlb_page(vma, vmaddr);
-}
-static inline void local_flush_tlb_mm(struct mm_struct *mm)
-{
-	flush_tlb_mm(mm);
-}
-
-#elif defined(CONFIG_PPC_BOOK3S_64)
-#include <asm/book3s/64/tlbflush.h>
+#ifdef CONFIG_PPC_BOOK3S
+#include <asm/book3s/tlbflush.h>
 #else
-#error Unsupported MMU type
-#endif
+#include <asm/nohash/tlbflush.h>
+#endif /* !CONFIG_PPC_BOOK3S */
 
-#endif /*__KERNEL__ */
 #endif /* _ASM_POWERPC_TLBFLUSH_H */
-- 
2.13.3
