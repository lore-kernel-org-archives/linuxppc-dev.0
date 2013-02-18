Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8B6D02C02B0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:28:51 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 15:55:25 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 19EF9E0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 15:59:34 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1IASXir21889086
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 15:58:33 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1IASZL8001112
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:28:37 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 11/17] powerpc: Print page size info during boot
Date: Mon, 18 Feb 2013 15:58:09 +0530
Message-Id: <1361183295-6958-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1361183295-6958-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1361183295-6958-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

This gives hint about different base and actual page size combination
supported by the platform.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index df48ba5..a06b55a 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -314,7 +314,7 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 	prop = (u32 *)of_get_flat_dt_prop(node,
 					  "ibm,segment-page-sizes", &size);
 	if (prop != NULL) {
-		DBG("Page sizes from device-tree:\n");
+		pr_info("Page sizes from device-tree:\n");
 		size /= 4;
 		cur_cpu_spec->mmu_features &= ~(MMU_FTR_16M_PAGE);
 		while(size > 0) {
@@ -364,10 +364,10 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 					continue;
 
 				def->penc[idx] = penc;
-				DBG(" %d: shift=%02x, sllp=%04lx, "
-				    "avpnm=%08lx, tlbiel=%d, penc=%d\n",
-				    idx, shift, def->sllp, def->avpnm,
-				    def->tlbiel, def->penc[idx]);
+				pr_info("base_shift=%d: shift=%d, sllp=0x%04lx,"
+					" avpnm=0x%08lx, tlbiel=%d, penc=%d\n",
+					base_shift, shift, def->sllp,
+					def->avpnm, def->tlbiel, def->penc[idx]);
 			}
 		}
 		return 1;
-- 
1.7.10
