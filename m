Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMhqp2MC9zDsQK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 15:40:54 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v725TUa4069585
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 01:40:51 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c37cmm4t4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 01:40:51 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 23:40:51 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 03/17] powerpc/ps3/mm: Add helper for finding hash pte
 slot using hash value
Date: Wed,  2 Aug 2017 11:10:02 +0530
In-Reply-To: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170802054016.8927-4-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will use this in later patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/ps3/htab.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/powerpc/platforms/ps3/htab.c b/arch/powerpc/platforms/ps3/htab.c
index cc2b281a3766..255b7a33fefe 100644
--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -193,6 +193,43 @@ static void ps3_hpte_clear(void)
 	ps3_mm_vas_destroy();
 }
 
+static long ps3_hpte_find(unsigned long hash, unsigned long want_v)
+{
+	unsigned long i, j, result;
+	unsigned long hpte_group;
+	bool secondary_search = false;
+	u64 hpte_v_array[4], hpte_rs;
+
+
+	/* first check primary */
+	hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+
+search_again:
+	for (i = 0; i < HPTES_PER_GROUP; i += 4, hpte_group += 4) {
+
+		result = lv1_read_htab_entries(PS3_LPAR_VAS_ID_CURRENT,
+					       hpte_group & ~0x3UL, &hpte_v_array[0],
+					       &hpte_v_array[1], &hpte_v_array[2],
+					       &hpte_v_array[3], &hpte_rs);
+		/* ignore failures ? */
+		if (result)
+			continue;
+
+		for (j = 0; j < 4; j++) {
+			if (HPTE_V_COMPARE(hpte_v_array[j], want_v) &&
+			    (hpte_v_array[j] & HPTE_V_VALID)) {
+				return hpte_group + j;
+			}
+		}
+	}
+	if (!secondary_search) {
+		hpte_group = (~hash & htab_hash_mask) * HPTES_PER_GROUP;
+		secondary_search = true;
+		goto search_again;
+	}
+	return -1;
+}
+
 void __init ps3_hpte_init(unsigned long htab_size)
 {
 	mmu_hash_ops.hpte_invalidate = ps3_hpte_invalidate;
-- 
2.13.3
