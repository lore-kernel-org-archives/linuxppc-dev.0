Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMhrh6wJhzDqvS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 15:41:40 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v725f1oO097199
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 01:41:38 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c37cmm5xn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 01:41:37 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 23:41:37 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 16/17] powerpc/mm/pseries: Move slot based bulk remove to
 helper
Date: Wed,  2 Aug 2017 11:10:15 +0530
In-Reply-To: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170802054016.8927-17-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

---
 arch/powerpc/platforms/pseries/lpar.c | 51 +++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 04a9618f3b79..436ec1e725d3 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -632,6 +632,34 @@ static int pSeries_lpar_hpte_removebolted(unsigned long ea,
 	return 0;
 }
 
+static int plpar_bluk_remove(unsigned long *param, int index, unsigned long slot,
+			     unsigned long vpn, unsigned long psize,
+			     unsigned long ssize, int local)
+{
+	unsigned long rc;
+	if (!firmware_has_feature(FW_FEATURE_BULK_REMOVE)) {
+		/*
+		 * lpar doesn't use the passed actual page size
+		 */
+		pSeries_lpar_hpte_invalidate(slot, vpn, psize,
+					     0, ssize, local);
+	} else {
+		param[index] = HBR_REQUEST | HBR_AVPN | slot;
+		param[index+1] = hpte_encode_avpn(vpn, psize,
+						ssize);
+		index += 2;
+		if (index == 8) {
+			rc = plpar_hcall9(H_BULK_REMOVE, param,
+					  param[0], param[1], param[2],
+					  param[3], param[4], param[5],
+					  param[6], param[7]);
+			BUG_ON(rc != H_SUCCESS);
+			index = 0;
+		}
+	}
+	return index;
+}
+
 /*
  * Take a spinlock around flushes to avoid bouncing the hypervisor tlbie
  * lock.
@@ -657,29 +685,12 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 		vpn = batch->vpn[i];
 		pte_iterate_hashed_subpages(vpn, psize, index, shift) {
 			slot = pSeries_lpar_hpte_find(vpn, psize, ssize);
-			if (!firmware_has_feature(FW_FEATURE_BULK_REMOVE)) {
-				/*
-				 * lpar doesn't use the passed actual page size
-				 */
-				pSeries_lpar_hpte_invalidate(slot, vpn, psize,
-							     0, ssize, local);
-			} else {
-				param[pix] = HBR_REQUEST | HBR_AVPN | slot;
-				param[pix+1] = hpte_encode_avpn(vpn, psize,
-								ssize);
-				pix += 2;
-				if (pix == 8) {
-					rc = plpar_hcall9(H_BULK_REMOVE, param,
-						param[0], param[1], param[2],
-						param[3], param[4], param[5],
-						param[6], param[7]);
-					BUG_ON(rc != H_SUCCESS);
-					pix = 0;
-				}
-			}
+			pix = plpar_bluk_remove(param, pix, slot, vpn,
+						psize, ssize, local);
 		} pte_iterate_hashed_end();
 	}
 	if (pix) {
+		/* We have a flush pending */
 		param[pix] = HBR_END;
 		rc = plpar_hcall9(H_BULK_REMOVE, param, param[0], param[1],
 				  param[2], param[3], param[4], param[5],
-- 
2.13.3
