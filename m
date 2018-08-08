Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lsQl37BzzDrbj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 23:18:38 +1000 (AEST)
Message-Id: <7dabf1cbde67a346a187881d4f0bd17347e0334a.1533732583.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: Fix address space layout randomization (ASLR)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  8 Aug 2018 13:18:34 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Today, when stack size is set to unlimited (ulimit -s unlimited),
mmap() doesn't randomise the stack address returned by mmap()

This patch fixes it by applying the random factor on
TASK_UNMAPPED_BASE when setting mm->mmap_base

Link: https://github.com/linuxppc/linux/issues/59
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/mmap.c  | 4 ++--
 arch/powerpc/mm/slice.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index b24ce40acd47..07de04c4fb56 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -201,7 +201,7 @@ static void radix__arch_pick_mmap_layout(struct mm_struct *mm,
 					struct rlimit *rlim_stack)
 {
 	if (mmap_is_legacy(rlim_stack)) {
-		mm->mmap_base = TASK_UNMAPPED_BASE;
+		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
 		mm->get_unmapped_area = radix__arch_get_unmapped_area;
 	} else {
 		mm->mmap_base = mmap_base(random_factor, rlim_stack);
@@ -233,7 +233,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 	 * bit is set, or if the expected stack growth is unlimited:
 	 */
 	if (mmap_is_legacy(rlim_stack)) {
-		mm->mmap_base = TASK_UNMAPPED_BASE;
+		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
 		mm->get_unmapped_area = arch_get_unmapped_area;
 	} else {
 		mm->mmap_base = mmap_base(random_factor, rlim_stack);
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 205fe557ca10..cc1af565b813 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -329,7 +329,7 @@ static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
 	info.align_mask = PAGE_MASK & ((1ul << pshift) - 1);
 	info.align_offset = 0;
 
-	addr = TASK_UNMAPPED_BASE;
+	addr = mm->mmap_base;
 	/*
 	 * Check till the allow max value for this mmap request
 	 */
-- 
2.13.3
