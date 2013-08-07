Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 560F62C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 11:21:05 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: [PATCH v3 1/7] powerpc/fsl_booke: protect the access to MAS7
Date: Wed, 7 Aug 2013 09:18:29 +0800
Message-ID: <1375838315-27797-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1375838315-27797-1-git-send-email-haokexin@gmail.com>
References: <1375838315-27797-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
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
v3: Use ifdef CONFIG_PHYS_64BIT for the code running before code patching.

v2: A new patch in v2.

 arch/powerpc/kernel/head_fsl_booke.S | 2 ++
 arch/powerpc/mm/hugetlbpage-book3e.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index d10a7ca..304e6f2 100644
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
index 3bc7006..ac63e7e 100644
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
