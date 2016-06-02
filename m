Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL2gx3VnrzDqpM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 19:57:01 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 03:46:43 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/3] powerpc/mm/radix: Update to tlb functions ric argument
Date: Thu,  2 Jun 2016 15:16:28 +0530
Message-Id: <1464860789-3672-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1464860789-3672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1464860789-3672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Radix invalidate control (RIC) is used to control which cache to flush
using tlb instructions. When doing a PID flush, we currently flush
everything including page walk cache. For address range flush, we flush
only the TLB. In the later patch, we add support for flushing only
page walk cache.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/tlb-radix.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index e6b7487ad28f..b33b7c77cfa3 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -19,16 +19,20 @@
 
 static DEFINE_RAW_SPINLOCK(native_tlbie_lock);
 
-static inline void __tlbiel_pid(unsigned long pid, int set)
+#define RIC_FLUSH_TLB 0
+#define RIC_FLUSH_PWC 1
+#define RIC_FLUSH_ALL 2
+
+static inline void __tlbiel_pid(unsigned long pid, int set,
+				unsigned long ric)
 {
-	unsigned long rb,rs,ric,prs,r;
+	unsigned long rb,rs,prs,r;
 
 	rb = PPC_BIT(53); /* IS = 1 */
 	rb |= set << PPC_BITLSHIFT(51);
 	rs = ((unsigned long)pid) << PPC_BITLSHIFT(31);
 	prs = 1; /* process scoped */
 	r = 1;   /* raidx format */
-	ric = 2;  /* invalidate all the caches */
 
 	asm volatile("ptesync": : :"memory");
 	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
@@ -39,25 +43,24 @@ static inline void __tlbiel_pid(unsigned long pid, int set)
 /*
  * We use 128 set in radix mode and 256 set in hpt mode.
  */
-static inline void _tlbiel_pid(unsigned long pid)
+static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 {
 	int set;
 
 	for (set = 0; set < POWER9_TLB_SETS_RADIX ; set++) {
-		__tlbiel_pid(pid, set);
+		__tlbiel_pid(pid, set, ric);
 	}
 	return;
 }
 
-static inline void _tlbie_pid(unsigned long pid)
+static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
 {
-	unsigned long rb,rs,ric,prs,r;
+	unsigned long rb,rs,prs,r;
 
 	rb = PPC_BIT(53); /* IS = 1 */
 	rs = pid << PPC_BITLSHIFT(31);
 	prs = 1; /* process scoped */
 	r = 1;   /* raidx format */
-	ric = 2;  /* invalidate all the caches */
 
 	asm volatile("ptesync": : :"memory");
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
@@ -66,16 +69,15 @@ static inline void _tlbie_pid(unsigned long pid)
 }
 
 static inline void _tlbiel_va(unsigned long va, unsigned long pid,
-			      unsigned long ap)
+			      unsigned long ap, unsigned long ric)
 {
-	unsigned long rb,rs,ric,prs,r;
+	unsigned long rb,rs,prs,r;
 
 	rb = va & ~(PPC_BITMASK(52, 63));
 	rb |= ap << PPC_BITLSHIFT(58);
 	rs = pid << PPC_BITLSHIFT(31);
 	prs = 1; /* process scoped */
 	r = 1;   /* raidx format */
-	ric = 0;  /* no cluster flush yet */
 
 	asm volatile("ptesync": : :"memory");
 	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
@@ -84,16 +86,15 @@ static inline void _tlbiel_va(unsigned long va, unsigned long pid,
 }
 
 static inline void _tlbie_va(unsigned long va, unsigned long pid,
-			     unsigned long ap)
+			     unsigned long ap, unsigned long ric)
 {
-	unsigned long rb,rs,ric,prs,r;
+	unsigned long rb,rs,prs,r;
 
 	rb = va & ~(PPC_BITMASK(52, 63));
 	rb |= ap << PPC_BITLSHIFT(58);
 	rs = pid << PPC_BITLSHIFT(31);
 	prs = 1; /* process scoped */
 	r = 1;   /* raidx format */
-	ric = 0;  /* no cluster flush yet */
 
 	asm volatile("ptesync": : :"memory");
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
@@ -119,7 +120,7 @@ void radix__local_flush_tlb_mm(struct mm_struct *mm)
 	preempt_disable();
 	pid = mm->context.id;
 	if (pid != MMU_NO_CONTEXT)
-		_tlbiel_pid(pid);
+		_tlbiel_pid(pid, RIC_FLUSH_ALL);
 	preempt_enable();
 }
 EXPORT_SYMBOL(radix__local_flush_tlb_mm);
@@ -132,7 +133,7 @@ void radix___local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 	preempt_disable();
 	pid = mm ? mm->context.id : 0;
 	if (pid != MMU_NO_CONTEXT)
-		_tlbiel_va(vmaddr, pid, ap);
+		_tlbiel_va(vmaddr, pid, ap, RIC_FLUSH_TLB);
 	preempt_enable();
 }
 
@@ -169,11 +170,11 @@ void radix__flush_tlb_mm(struct mm_struct *mm)
 
 		if (lock_tlbie)
 			raw_spin_lock(&native_tlbie_lock);
-		_tlbie_pid(pid);
+		_tlbie_pid(pid, RIC_FLUSH_ALL);
 		if (lock_tlbie)
 			raw_spin_unlock(&native_tlbie_lock);
 	} else
-		_tlbiel_pid(pid);
+		_tlbiel_pid(pid, RIC_FLUSH_ALL);
 no_context:
 	preempt_enable();
 }
@@ -193,11 +194,11 @@ void radix___flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 
 		if (lock_tlbie)
 			raw_spin_lock(&native_tlbie_lock);
-		_tlbie_va(vmaddr, pid, ap);
+		_tlbie_va(vmaddr, pid, ap, RIC_FLUSH_TLB);
 		if (lock_tlbie)
 			raw_spin_unlock(&native_tlbie_lock);
 	} else
-		_tlbiel_va(vmaddr, pid, ap);
+		_tlbiel_va(vmaddr, pid, ap, RIC_FLUSH_TLB);
 bail:
 	preempt_enable();
 }
@@ -221,7 +222,7 @@ void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end)
 
 	if (lock_tlbie)
 		raw_spin_lock(&native_tlbie_lock);
-	_tlbie_pid(0);
+	_tlbie_pid(0, RIC_FLUSH_ALL);
 	if (lock_tlbie)
 		raw_spin_unlock(&native_tlbie_lock);
 }
-- 
2.7.4
