Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bfch0Z9XzF3XK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 01:31:15 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id t84-v6so4573758pgb.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 08:31:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 03/12] powerpc/64s/hash: move POWER5 < DD2.1 slbie workaround
 where it is needed
Date: Sat, 15 Sep 2018 01:30:47 +1000
Message-Id: <20180914153056.3644-4-npiggin@gmail.com>
In-Reply-To: <20180914153056.3644-1-npiggin@gmail.com>
References: <20180914153056.3644-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The POWER5 < DD2.1 issue is that slbie needs to be issued more than
once. It came in with this change:

ChangeSet@1.1608, 2004-04-29 07:12:31-07:00, david@gibson.dropbear.id.au
  [PATCH] POWER5 erratum workaround

  Early POWER5 revisions (<DD2.1) have a problem requiring slbie
  instructions to be repeated under some circumstances.  The patch below
  adds a workaround (patch made by Anton Blanchard).

The extra slbie in switch_slb is done even for the case where slbia is
called (slb_flush_and_rebolt). I don't believe that is required
because there are other slb_flush_and_rebolt callers which do not
issue the workaround slbie, which would be broken if it was required.

It also seems to be fine inside the isync with the first slbie, as it
is in the kernel stack switch code.

So move this workaround to where it is required. This is not much of
an optimisation because this is the fast path, but it makes the code
more understandable and neater.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 1c7128c63a4b..d952ece3abf7 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -226,7 +226,6 @@ static inline int esids_match(unsigned long addr1, unsigned long addr2)
 void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 {
 	unsigned long offset;
-	unsigned long slbie_data = 0;
 	unsigned long pc = KSTK_EIP(tsk);
 	unsigned long stack = KSTK_ESP(tsk);
 	unsigned long exec_base;
@@ -241,7 +240,9 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	offset = get_paca()->slb_cache_ptr;
 	if (!mmu_has_feature(MMU_FTR_NO_SLBIE_B) &&
 	    offset <= SLB_CACHE_ENTRIES) {
+		unsigned long slbie_data;
 		int i;
+
 		asm volatile("isync" : : : "memory");
 		for (i = 0; i < offset; i++) {
 			slbie_data = (unsigned long)get_paca()->slb_cache[i]
@@ -251,15 +252,14 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 			slbie_data |= SLBIE_C; /* C set for user addresses */
 			asm volatile("slbie %0" : : "r" (slbie_data));
 		}
-		asm volatile("isync" : : : "memory");
-	} else {
-		__slb_flush_and_rebolt();
-	}
 
-	if (!cpu_has_feature(CPU_FTR_ARCH_207S)) {
 		/* Workaround POWER5 < DD2.1 issue */
-		if (offset == 1 || offset > SLB_CACHE_ENTRIES)
+		if (!cpu_has_feature(CPU_FTR_ARCH_207S) && offset == 1)
 			asm volatile("slbie %0" : : "r" (slbie_data));
+
+		asm volatile("isync" : : : "memory");
+	} else {
+		__slb_flush_and_rebolt();
 	}
 
 	get_paca()->slb_cache_ptr = 0;
-- 
2.18.0
