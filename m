Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bfcd1GWYzF3X6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 01:31:13 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id h79-v6so4470966pfk.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 08:31:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 02/12] powerpc/64s/hash: avoid the POWER5 < DD2.1 slb
 invalidate workaround on POWER8/9
Date: Sat, 15 Sep 2018 01:30:46 +1000
Message-Id: <20180914153056.3644-3-npiggin@gmail.com>
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

I only have POWER8/9 to test, so just remove it for those.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/entry_64.S | 2 ++
 arch/powerpc/mm/slb.c          | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2206912ea4f0..77a888bfcb53 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -672,7 +672,9 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 
 	isync
 	slbie	r6
+BEGIN_FTR_SECTION
 	slbie	r6		/* Workaround POWER5 < DD2.1 issue */
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	slbmte	r7,r0
 	isync
 2:
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 2f162c6e52d4..1c7128c63a4b 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -256,9 +256,11 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 		__slb_flush_and_rebolt();
 	}
 
-	/* Workaround POWER5 < DD2.1 issue */
-	if (offset == 1 || offset > SLB_CACHE_ENTRIES)
-		asm volatile("slbie %0" : : "r" (slbie_data));
+	if (!cpu_has_feature(CPU_FTR_ARCH_207S)) {
+		/* Workaround POWER5 < DD2.1 issue */
+		if (offset == 1 || offset > SLB_CACHE_ENTRIES)
+			asm volatile("slbie %0" : : "r" (slbie_data));
+	}
 
 	get_paca()->slb_cache_ptr = 0;
 	copy_mm_to_paca(mm);
-- 
2.18.0
