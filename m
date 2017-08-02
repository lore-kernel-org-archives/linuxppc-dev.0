Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMhqk49YhzDrhD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 15:40:50 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v725TgL5047338
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 01:40:48 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c332s6t3k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 01:40:47 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 23:40:47 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 02/17] powerpc/pseries: Update hpte find helper to take
 hash value
Date: Wed,  2 Aug 2017 11:10:01 +0530
In-Reply-To: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170802054016.8927-3-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The helper now also does secondary hash search so that we can use this in other
functions.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 495ba4e7336d..edab68d9f9f3 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -328,15 +328,21 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 	return 0;
 }
 
-static long __pSeries_lpar_hpte_find(unsigned long want_v, unsigned long hpte_group)
+static long __pSeries_lpar_hpte_find(unsigned long hash, unsigned long want_v)
 {
 	long lpar_rc;
 	unsigned long i, j;
+	unsigned long hpte_group;
+	bool secondary_search = false;
 	struct {
 		unsigned long pteh;
 		unsigned long ptel;
 	} ptes[4];
 
+	/* first check primary */
+	hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+
+search_again:
 	for (i = 0; i < HPTES_PER_GROUP; i += 4, hpte_group += 4) {
 
 		lpar_rc = plpar_pte_read_4(0, hpte_group, (void *)ptes);
@@ -346,31 +352,31 @@ static long __pSeries_lpar_hpte_find(unsigned long want_v, unsigned long hpte_gr
 		for (j = 0; j < 4; j++) {
 			if (HPTE_V_COMPARE(ptes[j].pteh, want_v) &&
 			    (ptes[j].pteh & HPTE_V_VALID))
-				return i + j;
+				return hpte_group + j;
 		}
 	}
-
+	if (!secondary_search) {
+		hpte_group = (~hash & htab_hash_mask) * HPTES_PER_GROUP;
+		secondary_search = true;
+		goto search_again;
+	}
 	return -1;
 }
 
 static long pSeries_lpar_hpte_find(unsigned long vpn, int psize, int ssize)
 {
 	long slot;
-	unsigned long hash;
-	unsigned long want_v;
-	unsigned long hpte_group;
+	unsigned long hash, want_v;
 
 	hash = hpt_hash(vpn, mmu_psize_defs[psize].shift, ssize);
 	want_v = hpte_encode_avpn(vpn, psize, ssize);
-
-	/* Bolted entries are always in the primary group */
-	hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-	slot = __pSeries_lpar_hpte_find(want_v, hpte_group);
+	slot = __pSeries_lpar_hpte_find(hash, want_v);
 	if (slot < 0)
 		return -1;
-	return hpte_group + slot;
+	return slot;
 }
 
+
 static void pSeries_lpar_hpte_updateboltedpp(unsigned long newpp,
 					     unsigned long ea,
 					     int psize, int ssize)
-- 
2.13.3
