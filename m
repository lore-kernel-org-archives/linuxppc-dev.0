Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2N6N3NG7zDqR3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 06:07:56 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0GJ7gcY041206
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 14:07:54 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28114rf6m8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 14:07:54 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Mon, 16 Jan 2017 14:07:53 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: [PATCH v5 4/4] powerpc/mm: unstub radix__vmemmap_remove_mapping()
Date: Mon, 16 Jan 2017 13:07:46 -0600
In-Reply-To: <1484593666-8001-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1484593666-8001-1-git-send-email-arbab@linux.vnet.ibm.com>
Message-Id: <1484593666-8001-5-git-send-email-arbab@linux.vnet.ibm.com>
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

So, add a few failsafe WARNs, but otherwise the code to remove physical
mappings is already sufficient for vmemmap.

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable-radix.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index cfba666..6d06171 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -521,6 +521,15 @@ static void remove_pte_table(pte_t *pte_start, unsigned long addr,
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
 		pte_clear(&init_mm, addr, pte);
 	}
 }
@@ -540,6 +549,12 @@ static void remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
 			continue;
 
 		if (pmd_huge(*pmd)) {
+			if (!IS_ALIGNED(addr, PMD_SIZE) ||
+			    !IS_ALIGNED(next, PMD_SIZE)) {
+				WARN_ONCE(1, "%s: unaligned range\n", __func__);
+				continue;
+			}
+
 			pte_clear(&init_mm, addr, (pte_t *)pmd);
 			continue;
 		}
@@ -565,6 +580,12 @@ static void remove_pud_table(pud_t *pud_start, unsigned long addr,
 			continue;
 
 		if (pud_huge(*pud)) {
+			if (!IS_ALIGNED(addr, PUD_SIZE) ||
+			    !IS_ALIGNED(next, PUD_SIZE)) {
+				WARN_ONCE(1, "%s: unaligned range\n", __func__);
+				continue;
+			}
+
 			pte_clear(&init_mm, addr, (pte_t *)pud);
 			continue;
 		}
@@ -591,6 +612,12 @@ static void remove_pagetable(unsigned long start, unsigned long end)
 			continue;
 
 		if (pgd_huge(*pgd)) {
+			if (!IS_ALIGNED(addr, PGDIR_SIZE) ||
+			    !IS_ALIGNED(next, PGDIR_SIZE)) {
+				WARN_ONCE(1, "%s: unaligned range\n", __func__);
+				continue;
+			}
+
 			pte_clear(&init_mm, addr, (pte_t *)pgd);
 			continue;
 		}
@@ -630,7 +657,7 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
 #ifdef CONFIG_MEMORY_HOTPLUG
 void radix__vmemmap_remove_mapping(unsigned long start, unsigned long page_size)
 {
-	/* FIXME!! intel does more. We should free page tables mapping vmemmap ? */
+	remove_pagetable(start, start + page_size);
 }
 #endif
 #endif
-- 
1.8.3.1
