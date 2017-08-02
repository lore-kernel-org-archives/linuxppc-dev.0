Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMhrX1prFzDrfk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 15:41:32 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v725f3UB088959
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 01:41:30 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c32gxg2qs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 01:41:30 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 23:41:29 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 14/17] powerpc/mm/pseries: Use HASH_PROTECT hcall in guest
Date: Wed,  2 Aug 2017 11:10:13 +0530
In-Reply-To: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170802054016.8927-15-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/pseries/lpar.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index e28e62f6afba..bfab61d17f6d 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -388,15 +388,20 @@ static long pSeries_lpar_hash_updatepp(unsigned long hash,
 	unsigned long want_v;
 
 	want_v = hpte_encode_avpn(vpn, psize, ssize);
-
 	pr_devel("    update: avpnv=%016lx, hash=%016lx, f=%lx, psize: %d ...",
 		 want_v, hash, flags, psize);
 
+	if (firmware_has_feature(FW_FEATURE_HASH_API)) {
+		lpar_rc = plpar_pte_hash_protect(flags, hash, want_v);
+		goto err_out;
+	}
 	slot = __pSeries_lpar_hpte_find(hash, want_v);
 	if (slot < 0)
 		return -1;
 
 	lpar_rc = plpar_pte_protect(flags, slot, want_v);
+
+err_out:
 	if (lpar_rc == H_NOT_FOUND) {
 		pr_devel("not found !\n");
 		return -1;
-- 
2.13.3
