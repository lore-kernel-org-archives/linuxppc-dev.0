Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xlh3d6MxrzDqjm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 04:15:25 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v83IDVsX001545
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Sep 2017 14:15:23 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2crgmekfhv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Sep 2017 14:15:22 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Sun, 3 Sep 2017 19:15:21 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com
Cc: alistair@popple.id.au
Subject: [PATCH v3 1/2] powerpc/mm: Export flush_all_mm()
Date: Sun,  3 Sep 2017 20:15:12 +0200
Message-Id: <20170903181513.29635-1-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the optimizations introduced by commit a46cc7a90fd8
("powerpc/mm/radix: Improve TLB/PWC flushes"), flush_tlb_mm() no
longer flushes the page walk cache with radix. This patch introduces
flush_all_mm(), which flushes everything, tlb and pwc, for a given mm.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
Changelog:
v3: add comment to explain limitations on hash
v2: this patch is new

 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h  | 20 ++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/tlbflush-radix.h |  3 +++
 arch/powerpc/include/asm/book3s/64/tlbflush.h       | 15 +++++++++++++++
 arch/powerpc/mm/tlb-radix.c                         |  6 ++++--
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
index 2f6373144e2c..2ac45cf85042 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
@@ -65,6 +65,26 @@ static inline void hash__flush_tlb_mm(struct mm_struct *mm)
 {
 }
 
+static inline void hash__local_flush_all_mm(struct mm_struct *mm)
+{
+	/*
+	 * There's no Page Walk Cache for hash, so what is needed is
+	 * the same as flush_tlb_mm(), which doesn't really make sense
+	 * with hash. So the only thing we could do is flush the
+	 * entire LPID! Punt for now, as it's not being used.
+	 */
+}
+
+static inline void hash__flush_all_mm(struct mm_struct *mm)
+{
+	/*
+	 * There's no Page Walk Cache for hash, so what is needed is
+	 * the same as flush_tlb_mm(), which doesn't really make sense
+	 * with hash. So the only thing we could do is flush the
+	 * entire LPID! Punt for now, as it's not being used.
+	 */
+}
+
 static inline void hash__local_flush_tlb_page(struct vm_area_struct *vma,
 					  unsigned long vmaddr)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index 9b433a624bf3..af06c6fe8a9f 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -21,17 +21,20 @@ extern void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long sta
 extern void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 extern void radix__local_flush_tlb_mm(struct mm_struct *mm);
+extern void radix__local_flush_all_mm(struct mm_struct *mm);
 extern void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 extern void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
 					      int psize);
 extern void radix__tlb_flush(struct mmu_gather *tlb);
 #ifdef CONFIG_SMP
 extern void radix__flush_tlb_mm(struct mm_struct *mm);
+extern void radix__flush_all_mm(struct mm_struct *mm);
 extern void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 extern void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
 					int psize);
 #else
 #define radix__flush_tlb_mm(mm)		radix__local_flush_tlb_mm(mm)
+#define radix__flush_all_mm(mm)		radix__local_flush_all_mm(mm)
 #define radix__flush_tlb_page(vma,addr)	radix__local_flush_tlb_page(vma,addr)
 #define radix__flush_tlb_page_psize(mm,addr,p) radix__local_flush_tlb_page_psize(mm,addr,p)
 #endif
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index 72b925f97bab..70760d018bcd 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -57,6 +57,13 @@ static inline void local_flush_tlb_page(struct vm_area_struct *vma,
 	return hash__local_flush_tlb_page(vma, vmaddr);
 }
 
+static inline void local_flush_all_mm(struct mm_struct *mm)
+{
+	if (radix_enabled())
+		return radix__local_flush_all_mm(mm);
+	return hash__local_flush_all_mm(mm);
+}
+
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	if (radix_enabled())
@@ -79,9 +86,17 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 		return radix__flush_tlb_page(vma, vmaddr);
 	return hash__flush_tlb_page(vma, vmaddr);
 }
+
+static inline void flush_all_mm(struct mm_struct *mm)
+{
+	if (radix_enabled())
+		return radix__flush_all_mm(mm);
+	return hash__flush_all_mm(mm);
+}
 #else
 #define flush_tlb_mm(mm)		local_flush_tlb_mm(mm)
 #define flush_tlb_page(vma, addr)	local_flush_tlb_page(vma, addr)
+#define flush_all_mm(mm)		local_flush_all_mm(mm)
 #endif /* CONFIG_SMP */
 /*
  * flush the page walk cache for the address
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index b3e849c4886e..5a1f46eff3a2 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -144,7 +144,7 @@ void radix__local_flush_tlb_mm(struct mm_struct *mm)
 EXPORT_SYMBOL(radix__local_flush_tlb_mm);
 
 #ifndef CONFIG_SMP
-static void radix__local_flush_all_mm(struct mm_struct *mm)
+void radix__local_flush_all_mm(struct mm_struct *mm)
 {
 	unsigned long pid;
 
@@ -154,6 +154,7 @@ static void radix__local_flush_all_mm(struct mm_struct *mm)
 		_tlbiel_pid(pid, RIC_FLUSH_ALL);
 	preempt_enable();
 }
+EXPORT_SYMBOL(radix__local_flush_all_mm);
 #endif /* CONFIG_SMP */
 
 void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
@@ -200,7 +201,7 @@ void radix__flush_tlb_mm(struct mm_struct *mm)
 }
 EXPORT_SYMBOL(radix__flush_tlb_mm);
 
-static void radix__flush_all_mm(struct mm_struct *mm)
+void radix__flush_all_mm(struct mm_struct *mm)
 {
 	unsigned long pid;
 
@@ -216,6 +217,7 @@ static void radix__flush_all_mm(struct mm_struct *mm)
 no_context:
 	preempt_enable();
 }
+EXPORT_SYMBOL(radix__flush_all_mm);
 
 void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
 {
-- 
2.11.0
