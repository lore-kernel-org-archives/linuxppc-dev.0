Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19EA91A03BC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 15:45:49 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 26 Nov 2015 23:45:48 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0DF3B38C803B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:45:46 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAR4jjVv19791946
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 04:45:45 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAR4jjsR012066
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:45:45 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH 1/4] powerpc/powernv: panic() on OPAL < V3
Date: Fri, 27 Nov 2015 15:45:23 +1100
Message-Id: <1448599526-31073-2-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The OpenPower Abstraction Layer firmware went through a couple
of iterations in the lab before being released. What we now know
as OPAL advertises itself as OPALv3.

OPALv2 and OPALv1 never made it outside the lab, and the possibility
of anyone at all ever building a mainline kernel today and expecting
it to boot on such hardware is zero.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 4296d55e88f3..ad691fc15309 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -103,11 +103,8 @@ int __init early_init_dt_scan_opal(unsigned long node,
 		powerpc_firmware_features |= FW_FEATURE_OPALv2;
 		powerpc_firmware_features |= FW_FEATURE_OPALv3;
 		pr_info("OPAL V3 detected !\n");
-	} else if (of_flat_dt_is_compatible(node, "ibm,opal-v2")) {
-		powerpc_firmware_features |= FW_FEATURE_OPALv2;
-		pr_info("OPAL V2 detected !\n");
 	} else {
-		pr_info("OPAL V1 detected !\n");
+		panic("OPAL != V3 detected, no longer supported.\n")
 	}
 
 	/* Reinit all cores with the right endian */
-- 
2.1.4
