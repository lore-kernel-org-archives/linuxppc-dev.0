Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 85C822C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 00:52:13 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 7 Feb 2014 23:52:08 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0B64B2CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 00:52:06 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s17DWhWY3866956
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Feb 2014 00:32:43 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s17Dq40T019216
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Feb 2014 00:52:05 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, stable@vger.kernel.org
Subject: [PATCH V2] powerpc: thp: Fix crash on mremap
Date: Fri,  7 Feb 2014 19:21:57 +0530
Message-Id: <1391781117-19045-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
for 3.12 stable series

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/Kconfig                           |  3 +++
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 mm/huge_memory.c                       | 12 ++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index af2cc6eabcc7..bca9e7a18bd2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -365,6 +365,9 @@ config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 config HAVE_ARCH_SOFT_DIRTY
 	bool
 
+config ARCH_THP_MOVE_PMD_ALWAYS_WITHDRAW
+	bool
+
 config HAVE_MOD_ARCH_SPECIFIC
 	bool
 	help
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 6704e2e20e6b..0225011231ea 100644
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
index 292a266e0d42..89b7a647f1cb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1474,8 +1474,20 @@ int move_huge_pmd(struct vm_area_struct *vma, struct vm_area_struct *new_vma,
 
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
1.8.3.2
