Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vwLg94yvkzDqC4
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Apr 2017 01:42:13 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v31EckuQ079306
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 1 Apr 2017 10:42:03 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29j8v42xnp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Apr 2017 10:42:02 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 1 Apr 2017 08:42:02 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/mm/radix: Don't do page walk cache flush when
 doing full mm flush
Date: Sat,  1 Apr 2017 20:11:47 +0530
Message-Id: <1491057708-15934-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For fullmm tlb flush, we do a flush with RIC_FLUSH_ALL which will invalidate all
related caches (radix__tlb_flush()). Hence the pwc flush is not needed.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/tlb-radix.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 83dc1ccc2fa1..f3e58bd60d1a 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -129,6 +129,12 @@ void radix__local_flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
 {
 	unsigned long pid;
 	struct mm_struct *mm = tlb->mm;
+	/*
+	 * If we are doing a full mm flush, we will do a tlb flush
+	 * with RIC_FLUSH_ALL later.
+	 */
+	if (tlb->fullmm)
+		return;
 
 	preempt_disable();
 
@@ -195,6 +201,12 @@ void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
 	unsigned long pid;
 	struct mm_struct *mm = tlb->mm;
 
+	/*
+	 * If we are doing a full mm flush, we will do a tlb flush
+	 * with RIC_FLUSH_ALL later.
+	 */
+	if (tlb->fullmm)
+		return;
 	preempt_disable();
 
 	pid = mm->context.id;
-- 
2.7.4
