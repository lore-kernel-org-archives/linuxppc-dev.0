Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyTfy5hm3zDr4Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 03:04:42 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id z6so9771250pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 10:04:42 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, christophe.leroy@c-s.fr, paulus@samba.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v5 3/7] powerpc/platform/pseries/lpar: Fix updatepp and
 updateboltedpp
Date: Thu, 29 Jun 2017 03:04:07 +1000
Message-Id: <20170628170411.28864-4-bsingharora@gmail.com>
In-Reply-To: <20170628170411.28864-1-bsingharora@gmail.com>
References: <20170628170411.28864-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PAPR has pp0 in bit 55, currently we assumed that bit
pp0 is bit 0 (all bits in IBM order). This patch fixes
the pp0 bits for both these routines that use H_PROTECT.

Fixes (e58e87a powerpc/mm: Update _PAGE_KERNEL_RO)

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 6541d0b..2d36571 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -301,7 +301,7 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 				       int ssize, unsigned long inv_flags)
 {
 	unsigned long lpar_rc;
-	unsigned long flags = (newpp & 7) | H_AVPN;
+	unsigned long flags;
 	unsigned long want_v;
 
 	want_v = hpte_encode_avpn(vpn, psize, ssize);
@@ -309,6 +309,15 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 	pr_devel("    update: avpnv=%016lx, hash=%016lx, f=%lx, psize: %d ...",
 		 want_v, slot, flags, psize);
 
+	/*
+	 * Move pp0 and set the mask, pp0 is bit 55
+	 * We ignore the keys for now.
+	 */
+	if (mmu_has_feature(MMU_FTR_KERNEL_RO))
+		flags = ((newpp & HPTE_R_PP0) >> 55) | (newpp & 7) | H_AVPN;
+	else
+		flags = (newpp & 7) | H_AVPN;
+
 	lpar_rc = plpar_pte_protect(flags, slot, want_v);
 
 	if (lpar_rc == H_NOT_FOUND) {
@@ -379,7 +388,15 @@ static void pSeries_lpar_hpte_updateboltedpp(unsigned long newpp,
 	slot = pSeries_lpar_hpte_find(vpn, psize, ssize);
 	BUG_ON(slot == -1);
 
-	flags = newpp & 7;
+	/*
+	 * Move pp0 and set the mask, pp0 is bit 55
+	 * We ignore the keys for now.
+	 */
+	if (mmu_has_feature(MMU_FTR_KERNEL_RO))
+		flags = ((newpp & HPTE_R_PP0) >> 55) | (newpp & 7);
+	else
+		flags = (newpp & 7);
+
 	lpar_rc = plpar_pte_protect(flags, slot, 0);
 
 	BUG_ON(lpar_rc != H_SUCCESS);
-- 
2.9.4
