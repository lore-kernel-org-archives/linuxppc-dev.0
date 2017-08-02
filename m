Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMhrd1KxNzDrfk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 15:41:37 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v725f242055650
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 01:41:35 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c361vfpkb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 01:41:34 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 23:41:34 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 15/17] powerpc/mm/pseries: Use HASH_REMOVE hcall in guest
Date: Wed,  2 Aug 2017 11:10:14 +0530
In-Reply-To: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170802054016.8927-16-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/pseries/lpar.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index bfab61d17f6d..04a9618f3b79 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -454,6 +454,27 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	BUG_ON(lpar_rc != H_SUCCESS);
 }
 
+static void __pseries_lpar_hash_invalidate(unsigned long hash, unsigned long vpn,
+					   int psize, int apsize,
+					   int ssize, int local)
+{
+	unsigned long want_v;
+	unsigned long lpar_rc;
+	unsigned long dummy1, dummy2;
+
+	pr_devel("    inval : hash=%lx, vpn=%016lx, psize: %d, local: %d\n",
+		 hash, vpn, psize, local);
+
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
+	lpar_rc = plpar_pte_hash_remove(H_AVPN, hash, want_v, &dummy1, &dummy2);
+	if (lpar_rc == H_NOT_FOUND)
+		return;
+
+	BUG_ON(lpar_rc != H_SUCCESS);
+
+}
+
+
 static void pSeries_lpar_hash_invalidate(unsigned long hash, unsigned long vpn,
 					 int psize, int apsize,
 					 int ssize, int local)
@@ -466,6 +487,9 @@ static void pSeries_lpar_hash_invalidate(unsigned long hash, unsigned long vpn,
 	pr_devel("    inval : hash=%lx, vpn=%016lx, psize: %d, local: %d\n",
 		 hash, vpn, psize, local);
 
+	if (firmware_has_feature(FW_FEATURE_HASH_API))
+		return __pseries_lpar_hash_invalidate(hash, vpn, psize,
+						      apsize, ssize, local);
 	want_v = hpte_encode_avpn(vpn, psize, ssize);
 	slot = __pSeries_lpar_hpte_find(hash, want_v);
 	if (slot < 0)
-- 
2.13.3
