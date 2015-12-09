Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC0221A0FE3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 17:18:47 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 8 Dec 2015 23:18:44 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 9CA2B1FF0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 23:06:53 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id tB96IgSC25886728
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Dec 2015 23:18:42 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB96Igih003092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Dec 2015 23:18:42 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH v2 1/3] powerpc/powernv: panic() on OPAL < V3
Date: Wed,  9 Dec 2015 17:18:18 +1100
Message-Id: <1449641900-22089-2-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1449641900-22089-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1449641900-22089-1-git-send-email-stewart@linux.vnet.ibm.com>
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
index 4296d55e88f3..faea1abaa785 100644
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
+		panic("OPAL != V3 detected, no longer supported.\n");
 	}
 
 	/* Reinit all cores with the right endian */
-- 
2.1.4
