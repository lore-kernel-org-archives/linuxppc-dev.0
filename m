Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8E69A2C0188
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2013 18:13:11 +1100 (EST)
Received: by mail-pa0-f48.google.com with SMTP id rd3so6196252pab.21
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 23:13:09 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v4 01/10] powerpc/fsl_booke: protect the access to MAS7
Date: Tue, 24 Dec 2013 15:12:03 +0800
Message-Id: <1387869132-12650-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1387869132-12650-1-git-send-email-haokexin@gmail.com>
References: <1387869132-12650-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The e500v1 doesn't implement the MAS7, so we should avoid to access
this register on that implementations. In the current kernel, the
access to MAS7 are protected by either CONFIG_PHYS_64BIT or
MMU_FTR_BIG_PHYS. Since some code are executed before the code
patching, we have to use CONFIG_PHYS_64BIT in these cases.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v4: No change.

v3: Use ifdef CONFIG_PHYS_64BIT for the code running before code patching.

v2: A new patch in v2.

 arch/powerpc/kernel/head_fsl_booke.S | 2 ++
 arch/powerpc/mm/hugetlbpage-book3e.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index f45726a1d963..09921a5197c6 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -82,7 +82,9 @@ _ENTRY(_start);
 	and	r19,r3,r18		/* r19 = page offset */
 	andc	r31,r20,r18		/* r31 = page base */
 	or	r31,r31,r19		/* r31 = devtree phys addr */
+#ifdef CONFIG_PHYS_64BIT
 	mfspr	r30,SPRN_MAS7
+#endif
 
 	li	r25,0			/* phys kernel start (low) */
 	li	r24,0			/* CPU number */
diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/hugetlbpage-book3e.c
index 74551b5e41e5..646c4bffaeba 100644
--- a/arch/powerpc/mm/hugetlbpage-book3e.c
+++ b/arch/powerpc/mm/hugetlbpage-book3e.c
@@ -103,7 +103,8 @@ void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
 	if (mmu_has_feature(MMU_FTR_USE_PAIRED_MAS)) {
 		mtspr(SPRN_MAS7_MAS3, mas7_3);
 	} else {
-		mtspr(SPRN_MAS7, upper_32_bits(mas7_3));
+		if (mmu_has_feature(MMU_FTR_BIG_PHYS))
+			mtspr(SPRN_MAS7, upper_32_bits(mas7_3));
 		mtspr(SPRN_MAS3, lower_32_bits(mas7_3));
 	}
 
-- 
1.8.3.1
