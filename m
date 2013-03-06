Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B02352C045D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 17:11:34 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 6 Mar 2013 16:06:41 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0C8E72CE804C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 17:11:04 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r265wRnp9502988
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 16:58:27 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r266B27o015055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 17:11:02 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 15/26] powerpc: Print page size info during boot
Date: Wed,  6 Mar 2013 11:40:16 +0530
Message-Id: <1362550227-575-16-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1362550227-575-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1362550227-575-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index e2f9023..44b0137 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -311,7 +311,7 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 	prop = (u32 *)of_get_flat_dt_prop(node,
 					  "ibm,segment-page-sizes", &size);
 	if (prop != NULL) {
-		DBG("Page sizes from device-tree:\n");
+		pr_info("Page sizes from device-tree:\n");
 		size /= 4;
 		cur_cpu_spec->mmu_features &= ~(MMU_FTR_16M_PAGE);
 		while(size > 0) {
@@ -365,10 +365,10 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
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
