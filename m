Return-Path: <psomas@cslab.ece.ntua.gr>
Received: from diomedes.noc.ntua.gr (diomedes.noc.ntua.gr [147.102.222.220])
	by ozlabs.org (Postfix) with ESMTP id D3EE5B7140
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  8 May 2011 00:11:40 +1000 (EST)
From: Stratos Psomadakis <psomas@cslab.ece.ntua.gr>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] ppc64: Fix compiler warning in pgtable-ppc64.h
	[-Wunused-but-set-variable]
Date: Sat,  7 May 2011 17:11:31 +0300
Message-Id: <1304777491-7947-3-git-send-email-psomas@cslab.ece.ntua.gr>
In-Reply-To: <1304777491-7947-1-git-send-email-psomas@cslab.ece.ntua.gr>
References: <1304777491-7947-1-git-send-email-psomas@cslab.ece.ntua.gr>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The variable 'old' is set but not used in the wrprotect functions in
arch/powerpc/include/asm/pgtable-ppc64.h, which can trigger a compiler warning.

Remove the variable, since it's not used anyway.

Signed-off-by: Stratos Psomadakis <psomas@ece.ntua.gr>
---
 arch/powerpc/include/asm/pgtable-ppc64.h |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 2b09cd5..0b27dba 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -257,21 +257,20 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
 {
-	unsigned long old;
 
-       	if ((pte_val(*ptep) & _PAGE_RW) == 0)
-       		return;
-	old = pte_update(mm, addr, ptep, _PAGE_RW, 0);
+	if ((pte_val(*ptep) & _PAGE_RW) == 0)
+		return;
+
+	pte_update(mm, addr, ptep, _PAGE_RW, 0);
 }
 
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
-	unsigned long old;
-
 	if ((pte_val(*ptep) & _PAGE_RW) == 0)
 		return;
-	old = pte_update(mm, addr, ptep, _PAGE_RW, 1);
+
+	pte_update(mm, addr, ptep, _PAGE_RW, 1);
 }
 
 /*
-- 
1.5.6.5
