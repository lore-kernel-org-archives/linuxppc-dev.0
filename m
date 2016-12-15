Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfkZh5cyWzDw62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 06:50:51 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBFJo4xH075200
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 14:50:49 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27bucctr7y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 14:50:49 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Thu, 15 Dec 2016 12:50:47 -0700
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: [PATCH v3 5/5] powerpc/mm: unstub radix__vmemmap_remove_mapping()
Date: Thu, 15 Dec 2016 13:50:43 -0600
In-Reply-To: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
Message-Id: <1481831443-22761-6-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use remove_pagetable() and friends for radix vmemmap removal.

We do not require the special-case handling of vmemmap done in the x86
versions of these functions. This is because vmemmap_free() has already
freed the mapped pages, and calls us with an aligned address range.

So, add a few failsafe WARNs, but otherwise the code to remove linear
mappings is already sufficient for vmemmap.

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable-radix.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 315237c..9d1d51e 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -532,6 +532,15 @@ static void remove_pte_table(pte_t *pte_start, unsigned long addr,
 		if (!pte_present(*pte))
 			continue;
 
+		if (!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(next)) {
+			/*
+			 * The vmemmap_free() and remove_section_mapping()
+			 * codepaths call us with aligned addresses.
+			 */
+			WARN_ONCE(1, "%s: unaligned range\n", __func__);
+			continue;
+		}
+
 		spin_lock(&init_mm.page_table_lock);
 		pte_clear(&init_mm, addr, pte);
 		spin_unlock(&init_mm.page_table_lock);
@@ -555,6 +564,12 @@ static void remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
 			continue;
 
 		if (map_page_size == PMD_SIZE) {
+			if (!IS_ALIGNED(addr, PMD_SIZE) ||
+			    !IS_ALIGNED(next, PMD_SIZE)) {
+				WARN_ONCE(1, "%s: unaligned range\n", __func__);
+				continue;
+			}
+
 			spin_lock(&init_mm.page_table_lock);
 			pte_clear(&init_mm, addr, (pte_t *)pmd);
 			spin_unlock(&init_mm.page_table_lock);
@@ -583,6 +598,12 @@ static void remove_pud_table(pud_t *pud_start, unsigned long addr,
 			continue;
 
 		if (map_page_size == PUD_SIZE) {
+			if (!IS_ALIGNED(addr, PUD_SIZE) ||
+			    !IS_ALIGNED(next, PUD_SIZE)) {
+				WARN_ONCE(1, "%s: unaligned range\n", __func__);
+				continue;
+			}
+
 			spin_lock(&init_mm.page_table_lock);
 			pte_clear(&init_mm, addr, (pte_t *)pud);
 			spin_unlock(&init_mm.page_table_lock);
@@ -662,7 +683,7 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
 #ifdef CONFIG_MEMORY_HOTPLUG
 void radix__vmemmap_remove_mapping(unsigned long start, unsigned long page_size)
 {
-	/* FIXME!! intel does more. We should free page tables mapping vmemmap ? */
+	remove_pagetable(start, start + page_size, page_size);
 }
 #endif
 #endif
-- 
1.8.3.1
