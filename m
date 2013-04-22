Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E3ACD2C0297
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:02:45 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 19:50:58 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 87F282CE804A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:02:42 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3MA2aUg52297774
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:02:36 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3MA2f47011947
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:02:41 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, David Gibson <dwg@au1.ibm.com>
Subject: [PATCH -V6 14/27] powerpc: Print page size info during boot
Date: Mon, 22 Apr 2013 15:30:48 +0530
Message-Id: <1366624861-24948-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 33cdc3a..d0eb6d4 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -316,7 +316,7 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 	prop = (u32 *)of_get_flat_dt_prop(node,
 					  "ibm,segment-page-sizes", &size);
 	if (prop != NULL) {
-		DBG("Page sizes from device-tree:\n");
+		pr_info("Page sizes from device-tree:\n");
 		size /= 4;
 		cur_cpu_spec->mmu_features &= ~(MMU_FTR_16M_PAGE);
 		while(size > 0) {
@@ -370,10 +370,10 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 					       "shift=%d\n", base_shift, shift);
 
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
