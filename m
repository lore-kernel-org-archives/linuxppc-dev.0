Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9B1C32C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Mar 2014 21:48:25 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 15 Mar 2014 16:18:18 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2342EE0045
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Mar 2014 16:22:04 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2FAm5kG3604970
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Mar 2014 16:18:05 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2FAmEsH019417
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Mar 2014 16:18:14 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, Rik van Riel <riel@redhat.com>
Subject: [PATCH] powerpc/mm: Make sure a local_irq_disable prevent a parallel
 THP split
Date: Sat, 15 Mar 2014 16:17:58 +0530
Message-Id: <1394880478-770-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We have generic code like the one in get_futex_key that assume that
a local_irq_disable prevents a parallel THP split. Support that by
adding a dummy smp call function after setting _PAGE_SPLITTING. Code
paths like get_user_pages_fast still need to check for _PAGE_SPLITTING
after disabling IRQ which indicate that a parallel THP splitting is
ongoing. Now if they don't find _PAGE_SPLITTING set, then we can be
sure that parallel split will now block in pmdp_splitting flush
until we enables IRQ

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable_64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 62bf5e8e78da..f6ce1f111f5b 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -647,6 +647,11 @@ void pmdp_splitting_flush(struct vm_area_struct *vma,
 		if (old & _PAGE_HASHPTE)
 			hpte_do_hugepage_flush(vma->vm_mm, address, pmdp);
 	}
+	/*
+	 * This ensures that generic code that rely on IRQ disabling
+	 * to prevent a parallel THP split work as expected.
+	 */
+	kick_all_cpus_sync();
 }
 
 /*
-- 
1.8.3.2
