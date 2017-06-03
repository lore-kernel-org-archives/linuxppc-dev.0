Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfss85ckLzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Jun 2017 17:19:24 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id w69so14956819pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Jun 2017 00:19:24 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, christophe.leroy@c-s.fr, paulus@samba.org,
 rashmica.g@gmail.com, labbott@redhat.com,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v2 6/9] powerpc/platform/pseries/lpar: Fix updatepp and
 updateboltedpp
Date: Sat,  3 Jun 2017 17:18:40 +1000
Message-Id: <20170603071843.11966-7-bsingharora@gmail.com>
In-Reply-To: <20170603071843.11966-1-bsingharora@gmail.com>
References: <20170603071843.11966-1-bsingharora@gmail.com>
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
the pp0 bits for both these routines that use H_PROTECT

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 6541d0b..83db643 100644
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
@@ -309,6 +309,11 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 	pr_devel("    update: avpnv=%016lx, hash=%016lx, f=%lx, psize: %d ...",
 		 want_v, slot, flags, psize);
 
+	/*
+	 * Move pp0 and set the mask, pp0 is bit 55
+	 * We ignore the keys for now.
+	 */
+	flags = ((newpp & HPTE_R_PP0) >> 55) | (newpp & 7) | H_AVPN;
 	lpar_rc = plpar_pte_protect(flags, slot, want_v);
 
 	if (lpar_rc == H_NOT_FOUND) {
@@ -379,7 +384,11 @@ static void pSeries_lpar_hpte_updateboltedpp(unsigned long newpp,
 	slot = pSeries_lpar_hpte_find(vpn, psize, ssize);
 	BUG_ON(slot == -1);
 
-	flags = newpp & 7;
+	/*
+	 * Move pp0 and set the mask, pp0 is bit 55
+	 * We ignore the keys for now.
+	 */
+	flags = ((newpp & HPTE_R_PP0) >> 55) | (newpp & 7);
 	lpar_rc = plpar_pte_protect(flags, slot, 0);
 
 	BUG_ON(lpar_rc != H_SUCCESS);
-- 
2.9.3
