Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 902CB2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 23:17:25 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Jan 2014 17:47:19 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6C6F51258053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 17:48:58 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0SCHAvk52494432
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 17:47:11 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0SCHCQm000985
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 17:47:13 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, stable@vger.kernel.org
Subject: [PATCH] powerpc: thp: Fix crash on mremap
Date: Tue, 28 Jan 2014 17:47:03 +0530
Message-Id: <1390911423-4409-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

This patch fix the below crash

NIP [c00000000004cee4] .__hash_page_thp+0x2a4/0x440
LR [c0000000000439ac] .hash_page+0x18c/0x5e0
...
Call Trace:
[c000000736103c40] [00001ffffb000000] 0x1ffffb000000(unreliable)
[437908.479693] [c000000736103d50] [c0000000000439ac] .hash_page+0x18c/0x5e0
[437908.479699] [c000000736103e30] [c00000000000924c] .do_hash_page+0x4c/0x58

On ppc64 we use the pgtable for storing the hpte slot information and
store address to the pgtable at a constant offset (PTRS_PER_PMD) from
pmd. On mremap, when we switch the pmd, we need to withdraw and deposit
the pgtable again, so that we find the pgtable at PTRS_PER_PMD offset
from new pmd.

We also want to move the withdraw and deposit before the set_pmd so
that, when page fault find the pmd as trans huge we can be sure that
pgtable can be located at the offset.

variant of upstream SHA1: b3084f4db3aeb991c507ca774337c7e7893ed04f
for 3.11 stable series

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/Kconfig                           |  3 +++
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 mm/huge_memory.c                       | 12 ++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 1feb169274fe..c5863b35d054 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -368,6 +368,9 @@ config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 config HAVE_ARCH_SOFT_DIRTY
 	bool
 
+config ARCH_THP_MOVE_PMD_ALWAYS_WITHDRAW
+	bool
+
 config HAVE_MOD_ARCH_SPECIFIC
 	bool
 	help
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 47d9a03dd415..d11a34be018d 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -71,6 +71,7 @@ config PPC_BOOK3S_64
 	select PPC_FPU
 	select PPC_HAVE_PMU_SUPPORT
 	select SYS_SUPPORTS_HUGETLBFS
+	select ARCH_THP_MOVE_PMD_ALWAYS_WITHDRAW
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if PPC_64K_PAGES
 
 config PPC_BOOK3E_64
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 12acb0ba7991..beaa7cc9de75 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1461,8 +1461,20 @@ int move_huge_pmd(struct vm_area_struct *vma, struct vm_area_struct *new_vma,
 
 	ret = __pmd_trans_huge_lock(old_pmd, vma);
 	if (ret == 1) {
+#ifdef CONFIG_ARCH_THP_MOVE_PMD_ALWAYS_WITHDRAW
+		pgtable_t pgtable;
+#endif
 		pmd = pmdp_get_and_clear(mm, old_addr, old_pmd);
 		VM_BUG_ON(!pmd_none(*new_pmd));
+#ifdef CONFIG_ARCH_THP_MOVE_PMD_ALWAYS_WITHDRAW
+		/*
+		 * Archs like ppc64 use pgtable to store per pmd
+		 * specific information. So when we switch the pmd,
+		 * we should also withdraw and deposit the pgtable
+		 */
+		pgtable = pgtable_trans_huge_withdraw(mm, old_pmd);
+		pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
+#endif
 		set_pmd_at(mm, new_addr, new_pmd, pmd_mksoft_dirty(pmd));
 		spin_unlock(&mm->page_table_lock);
 	}
-- 
1.8.5.3
