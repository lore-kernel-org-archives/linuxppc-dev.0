Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL2dm3cTBzDqxm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 19:55:08 +1000 (AEST)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 03:44:56 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/radix: Make the pid unsigned long
Date: Thu,  2 Jun 2016 15:14:48 +0530
Message-Id: <1464860688-2085-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Semantic Issue: comparison of constant 18446744073709551615 with
expression of type 'unsigned int' is always false.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/tlb-radix.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 7f2fa82bd155..0484fcdca00a 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -115,7 +115,7 @@ static inline void _tlbie_va(unsigned long va, unsigned long pid,
  */
 void radix__local_flush_tlb_mm(struct mm_struct *mm)
 {
-	unsigned int pid;
+	unsigned long pid;
 
 	preempt_disable();
 	pid = mm->context.id;
@@ -128,7 +128,7 @@ EXPORT_SYMBOL(radix__local_flush_tlb_mm);
 void radix___local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 			    unsigned long ap, int nid)
 {
-	unsigned int pid;
+	unsigned long pid;
 
 	preempt_disable();
 	pid = mm ? mm->context.id : 0;
@@ -158,7 +158,7 @@ static int mm_is_core_local(struct mm_struct *mm)
 
 void radix__flush_tlb_mm(struct mm_struct *mm)
 {
-	unsigned int pid;
+	unsigned long pid;
 
 	preempt_disable();
 	pid = mm->context.id;
@@ -207,7 +207,7 @@ EXPORT_SYMBOL(radix__flush_tlb_mm_pwc);
 void radix___flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 		       unsigned long ap, int nid)
 {
-	unsigned int pid;
+	unsigned long pid;
 
 	preempt_disable();
 	pid = mm ? mm->context.id : 0;
-- 
2.7.4
