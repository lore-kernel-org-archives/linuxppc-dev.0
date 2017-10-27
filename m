Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yNVlX6q7zzDrcf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 15:10:16 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9R492IH036380
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 00:10:14 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2duuqmvm58-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 00:10:14 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 26 Oct 2017 22:10:13 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 16/16] powerpc/mm/pseries: Use HASH_BULK_REMOVE hcall in guest
Date: Fri, 27 Oct 2017 09:38:33 +0530
In-Reply-To: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20171027040833.3644-17-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 40 ++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 4ea9224cbeb6..6dffdf654a28 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -684,19 +684,43 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	for (i = 0; i < number; i++) {
 		vpn = batch->vpn[i];
 		pte_iterate_hashed_subpages(vpn, psize, index, shift) {
-			long slot;
-
-			slot = pSeries_lpar_hpte_find(vpn, psize, ssize);
-			if (slot < 0)
-				continue;
-			pix = plpar_bluk_remove(param, pix, slot, vpn,
-						psize, ssize, local);
+			if (!firmware_has_feature(FW_FEATURE_HASH_API)) {
+				long slot;
+
+				slot = pSeries_lpar_hpte_find(vpn, psize, ssize);
+				if (slot < 0)
+					continue;
+				pix = plpar_bluk_remove(param, pix, slot, vpn,
+							  psize, ssize, local);
+			} else {
+				unsigned long hash;
+				hash = hpt_hash(vpn, mmu_psize_defs[psize].shift, ssize);
+				/* trim the top bits, we overload them below */
+				hash &= MAX_HTAB_MASK;
+				param[pix] = HBR_REQUEST | HBR_AVPN | hash;
+				param[pix+1] = hpte_encode_avpn(vpn, psize, ssize);
+				pix += 2;
+				if (pix == 8) {
+					rc = plpar_hcall9(H_HASH_BULK_REMOVE, param,
+							  param[0], param[1], param[2],
+							  param[3], param[4], param[5],
+							  param[6], param[7]);
+					BUG_ON(rc != H_SUCCESS);
+					pix = 0;
+				}
+			}
 		} pte_iterate_hashed_end();
 	}
 	if (pix) {
+		unsigned long hcall;
+
 		/* We have a flush pending */
 		param[pix] = HBR_END;
-		rc = plpar_hcall9(H_BULK_REMOVE, param, param[0], param[1],
+		if (!firmware_has_feature(FW_FEATURE_HASH_API))
+			hcall = H_BULK_REMOVE;
+		else
+			hcall = H_HASH_BULK_REMOVE;
+		rc = plpar_hcall9(hcall, param, param[0], param[1],
 				  param[2], param[3], param[4], param[5],
 				  param[6], param[7]);
 		BUG_ON(rc != H_SUCCESS);
-- 
2.13.6
