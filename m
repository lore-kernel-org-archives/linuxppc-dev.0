Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E628A2C018D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 05:52:05 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 29 Apr 2013 01:15:49 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 598243940023
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 01:22:01 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3SJpuPr11337998
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 01:21:56 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3SJpxvt002441
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 05:52:00 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, dwg@au1.ibm.com,
 linux-mm@kvack.org
Subject: [PATCH -V7 10/10] powerpc: disable assert_pte_locked
Date: Mon, 29 Apr 2013 01:21:51 +0530
Message-Id: <1367178711-8232-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1367178711-8232-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1367178711-8232-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
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

With THP we set pmd to none, before we do pte_clear. Hence we can't
walk page table to get the pte lock ptr and verify whether it is locked.
THP do take pte lock before calling pte_clear. So we don't change the locking
rules here. It is that we can't use page table walking to check whether
pte locks are help with THP.

NOTE: This needs to be re-written. Not to be merged upstream.
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 214130a..d77f94f 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -224,6 +224,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 #ifdef CONFIG_DEBUG_VM
 void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 {
+#if 0
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
@@ -237,6 +238,7 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	pmd = pmd_offset(pud, addr);
 	BUG_ON(!pmd_present(*pmd));
 	assert_spin_locked(pte_lockptr(mm, pmd));
+#endif
 }
 #endif /* CONFIG_DEBUG_VM */
 
-- 
1.8.1.2
