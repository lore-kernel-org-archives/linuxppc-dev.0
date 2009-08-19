Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BB9E1B7B6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 11:21:46 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 247D0DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 11:21:45 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/mm: Fix assert_pte_locked to work properly on
	uniprocessor
Date: Tue, 18 Aug 2009 20:21:40 -0500
Message-Id: <1250644900-32133-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the pte_lockptr is a spinlock it gets optimized away on
uniprocessor builds so using spin_is_locked is not correct.  We can use
assert_spin_locked instead and get the proper behavior between UP and
SMP builds.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/mm/pgtable.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 627767d..4b9a27d 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -242,7 +242,7 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	BUG_ON(pud_none(*pud));
 	pmd = pmd_offset(pud, addr);
 	BUG_ON(!pmd_present(*pmd));
-	BUG_ON(!spin_is_locked(pte_lockptr(mm, pmd)));
+	assert_spin_locked(pte_lockptr(mm, pmd));
 }
 #endif /* CONFIG_DEBUG_VM */
 
-- 
1.6.0.6
