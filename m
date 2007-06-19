Return-Path: <segher@kernel.crashing.org>
Received: from localhost.localhost (dslb-084-056-187-006.pools.arcor-ip.net
	[84.56.187.6]) by ozlabs.org (Postfix) with ESMTP id E58B3DDEF0
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 01:21:50 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC: Prevent data exception in kernel space (32-bit)
Date: Tue, 19 Jun 2007 17:07:04 +0200
Message-Id: <1182265624255-git-send-email-segher@kernel.crashing.org>
Message-Id: <9051d9387cad9fa7d8143dc1816949cbc80696b7.1182264776.git.segher@kernel.crashing.org>
In-Reply-To: <1182171859.21013.3.camel@johannes.berg>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The "is_exec" branch of the protection check in do_page_fault()
didn't do anything on 32-bit PowerPC.  So if a userland program
jumps to a page with Linux protection flags "---p", all the tests
happily fall through, and handle_mm_fault() is called, which in
turn calls handle_pte_fault(), which calls update_mmu_cache(),
which goes flush the dcache to a page with no access rights.

Boom.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Paul Mackerras <paulus@samba.org>
---
Johannes, please test.  Paul, I think you'll want this for .22 still?
If the patch is correct, anyway ;-)

 arch/powerpc/mm/fault.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index bfe9013..115b25f 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -279,14 +279,13 @@ good_area:
 #endif /* CONFIG_8xx */
 
 	if (is_exec) {
-#ifdef CONFIG_PPC64
+#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 		/* protection fault */
 		if (error_code & DSISR_PROTFAULT)
 			goto bad_area;
 		if (!(vma->vm_flags & VM_EXEC))
 			goto bad_area;
-#endif
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#else
 		pte_t *ptep;
 		pmd_t *pmdp;
 
-- 
1.5.2.1.144.gabc40-dirty
