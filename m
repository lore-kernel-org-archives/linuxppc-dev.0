Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6A2BB140086
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 00:46:11 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Use 64k io pages when we never see an HEA
Date: Tue,  1 Apr 2014 15:46:05 +0200
Message-Id: <1396359965-19515-1-git-send-email-agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we never get around to seeing an HEA ethernet adapter, there's
no point in restricting ourselves to 4k IO page size.

This speeds up IO maps when CONFIG_IBMEBUS is disabled.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/mm/hash_utils_64.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index d766d6e..c0ef976 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -445,6 +445,20 @@ static void mmu_psize_set_default_penc(void)
 			mmu_psize_defs[bpsize].penc[apsize] = -1;
 }
 
+static bool might_have_hea(void)
+{
+	/*
+	 * The HEA ethernet adapter requires awareness of the
+	 * GX bus. Without that awareness we can easily assume
+	 * we will never see an HEA ethernet device.
+	 */
+#ifdef CONFIG_IBMEBUS
+	return true;
+#else
+	return false;
+#endif
+}
+
 static void __init htab_init_page_sizes(void)
 {
 	int rc;
@@ -499,10 +513,11 @@ static void __init htab_init_page_sizes(void)
 			mmu_linear_psize = MMU_PAGE_64K;
 		if (mmu_has_feature(MMU_FTR_CI_LARGE_PAGE)) {
 			/*
-			 * Don't use 64k pages for ioremap on pSeries, since
-			 * that would stop us accessing the HEA ethernet.
+			 * When running on pSeries using 64k pages for ioremap
+			 * would stop us accessing the HEA ethernet. So if we
+			 * have the chance of ever seeing one, stay at 4k.
 			 */
-			if (!machine_is(pseries))
+			if (!might_have_hea() || !machine_is(pseries))
 				mmu_io_psize = MMU_PAGE_64K;
 		} else
 			mmu_ci_restrictions = 1;
-- 
1.8.1.4
