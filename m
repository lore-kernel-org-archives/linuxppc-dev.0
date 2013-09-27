Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 99B432C09B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 20:07:54 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 20:07:53 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9E2A53578055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 20:07:50 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8R9p8Us53018804
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 19:51:08 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8RA7nVk008003
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 20:07:50 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/2] powerpc: Use HPTE constants when updating hpte bits
Date: Fri, 27 Sep 2013 15:37:37 +0530
Message-Id: <1380276458-18833-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Even though we have same value for linux PTE bits and hash PTE pits
use the hash pte bits wen updating hash pte

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/cell/beat_htab.c | 4 ++--
 arch/powerpc/platforms/pseries/lpar.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/beat_htab.c b/arch/powerpc/platforms/cell/beat_htab.c
index c34ee4e..d4d245c 100644
--- a/arch/powerpc/platforms/cell/beat_htab.c
+++ b/arch/powerpc/platforms/cell/beat_htab.c
@@ -111,7 +111,7 @@ static long beat_lpar_hpte_insert(unsigned long hpte_group,
 		DBG_LOW(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
 
 	if (rflags & _PAGE_NO_CACHE)
-		hpte_r &= ~_PAGE_COHERENT;
+		hpte_r &= ~HPTE_R_M;
 
 	raw_spin_lock(&beat_htab_lock);
 	lpar_rc = beat_read_mask(hpte_group);
@@ -337,7 +337,7 @@ static long beat_lpar_hpte_insert_v3(unsigned long hpte_group,
 		DBG_LOW(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
 
 	if (rflags & _PAGE_NO_CACHE)
-		hpte_r &= ~_PAGE_COHERENT;
+		hpte_r &= ~HPTE_R_M;
 
 	/* insert into not-volted entry */
 	lpar_rc = beat_insert_htab_entry3(0, hpte_group, hpte_v, hpte_r,
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 356bc75..450fca2 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -153,7 +153,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 
 	/* Make pHyp happy */
 	if ((rflags & _PAGE_NO_CACHE) && !(rflags & _PAGE_WRITETHRU))
-		hpte_r &= ~_PAGE_COHERENT;
+		hpte_r &= ~HPTE_R_M;
 	if (firmware_has_feature(FW_FEATURE_XCMO) && !(hpte_r & HPTE_R_N))
 		flags |= H_COALESCE_CAND;
 
-- 
1.8.1.2
