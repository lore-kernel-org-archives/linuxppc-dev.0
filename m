Return-Path: <meissner@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56FE2B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 19:13:55 +1000 (EST)
Date: Fri, 20 May 2011 11:13:46 +0200
From: Marcus Meissner <meissner@suse.de>
To: benh@kernel.crashing.org, paulus@samba.org,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: PATCH: powerpc: remove unused variable assignment
Message-ID: <20110520091346.GC29499@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

gcc 4.6 with -Werror does not like setting but not using variables
anymore.

So remove it, it does not seem necessary.

Signed-off-by: Marcus Meissner <meissner@suse.de>

Ciao, Marcus
---
 arch/powerpc/include/asm/pgtable-ppc64.h |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 2b09cd5..c3d39de 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -257,21 +257,17 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
 {
-	unsigned long old;
-
        	if ((pte_val(*ptep) & _PAGE_RW) == 0)
        		return;
-	old = pte_update(mm, addr, ptep, _PAGE_RW, 0);
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
+	pte_update(mm, addr, ptep, _PAGE_RW, 1);
 }
 
 /*
-- 
1.7.4.1
