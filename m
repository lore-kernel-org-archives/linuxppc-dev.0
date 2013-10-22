Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6F0132C03BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 22:41:18 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 22 Oct 2013 17:11:16 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 5F68D9584CC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 17:00:06 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9MBVPJY20381756
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 17:01:25 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9MBSXIl023012
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 16:58:33 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, linux-mm@kvack.org
Subject: [RFC PATCH 1/9] powerpc: Use HPTE constants when updating hpte bits
Date: Tue, 22 Oct 2013 16:58:12 +0530
Message-Id: <1382441300-1513-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1382441300-1513-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1382441300-1513-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/pseries/lpar.c   | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

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
index 356bc75..c8fbef23 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -153,7 +153,8 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 
 	/* Make pHyp happy */
 	if ((rflags & _PAGE_NO_CACHE) && !(rflags & _PAGE_WRITETHRU))
-		hpte_r &= ~_PAGE_COHERENT;
+		hpte_r &= ~HPTE_R_M;
+
 	if (firmware_has_feature(FW_FEATURE_XCMO) && !(hpte_r & HPTE_R_N))
 		flags |= H_COALESCE_CAND;
 
-- 
1.8.3.2
