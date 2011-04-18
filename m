Return-Path: <psomas@cslab.ece.ntua.gr>
Received: from diomedes.noc.ntua.gr (diomedes.noc.ntua.gr [147.102.222.220])
	by ozlabs.org (Postfix) with ESMTP id B3C0EB6FF6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Apr 2011 02:48:36 +1000 (EST)
From: Stratos Psomadakis <psomas@cslab.ece.ntua.gr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ppc64: fix build error when compiling with gcc-4.6.0
Date: Mon, 18 Apr 2011 19:38:59 +0300
Message-Id: <1303144739-4407-2-git-send-email-psomas@cslab.ece.ntua.gr>
In-Reply-To: <1303144739-4407-1-git-send-email-psomas@cslab.ece.ntua.gr>
References: <1303144739-4407-1-git-send-email-psomas@cslab.ece.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stratos Psomadakis <psomas@cslab.ece.ntua.gr>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

variable 'old' is set but not used, which results to a warning
(-Werror=unused-but-set-variable) when compiling with gcc-4.6.0, and subsequent
build failure.
Remove the variable 'old', since it's not used anyway.

---
 arch/powerpc/include/asm/pgtable-ppc64.h |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 2b09cd5..a49d592 100644
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
+  		return;
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
1.7.4.1
