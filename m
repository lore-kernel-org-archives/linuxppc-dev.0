Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7r8H2m02zDqJC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 17:28:47 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3K7Noil024580
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 03:28:36 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x7543u4a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 03:28:36 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 20 Apr 2017 01:28:35 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Madhavan Srinivasan <masriniv@in.ibm.com>,
 Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH] powerpc/mm/radix: Optimize tlbiel flush
Date: Thu, 20 Apr 2017 12:58:25 +0530
Message-Id: <1492673305-29526-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For a page walk cache flush, we don't need to loop with set number. The set
number is ignored with RIC=1 (pwc flush).

For RIC=2 (flush all), inorder to flush implementation dependent caches, we can
ignore the set number. Hence we do a RIC=2 flush with set no: 0, so we do both
the tlb flush for set 0 and the implementation dependent cache flushes. This is
then followed with tbl flush for set 1-127

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Note: not yet tested.

 arch/powerpc/mm/tlb-radix.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index b68b5219cf45..b827aef38b90 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -43,12 +43,30 @@ static inline void __tlbiel_pid(unsigned long pid, int set,
  */
 static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 {
-	int set;
+	int set = 0;
 
 	asm volatile("ptesync": : :"memory");
-	for (set = 0; set < POWER9_TLB_SETS_RADIX ; set++) {
-		__tlbiel_pid(pid, set, ric);
+	if (ric == RIC_FLUSH_ALL) {
+		ric = RIC_FLUSH_TLB;
+		set = 1;
+		/* Use set 0 to flush all */
+		__tlbiel_pid(pid, 0, RIC_FLUSH_ALL);
 	}
+
+	for (; set < POWER9_TLB_SETS_RADIX ; set++)
+		__tlbiel_pid(pid, set, ric);
+
+	asm volatile("ptesync": : :"memory");
+	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
+}
+
+static inline void _tlbiel_pwc(unsigned long pid)
+{
+	asm volatile("ptesync": : :"memory");
+	/*
+	 * for PWC flush, we don't look at set number
+	 */
+	__tlbiel_pid(pid, 0, RIC_FLUSH_PWC);
 	asm volatile("ptesync": : :"memory");
 	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
 }
@@ -140,7 +158,7 @@ void radix__local_flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
 
 	pid = mm->context.id;
 	if (pid != MMU_NO_CONTEXT)
-		_tlbiel_pid(pid, RIC_FLUSH_PWC);
+		_tlbiel_pwc(pid);
 
 	preempt_enable();
 }
@@ -222,7 +240,7 @@ void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
 		if (lock_tlbie)
 			raw_spin_unlock(&native_tlbie_lock);
 	} else
-		_tlbiel_pid(pid, RIC_FLUSH_PWC);
+		_tlbiel_pwc(pid);
 no_context:
 	preempt_enable();
 }
-- 
2.7.4
