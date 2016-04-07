Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgXl303Q0zDq64
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 16:30:06 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>
Subject: [PATCH V3 2/2] pseries/eeh: Refactor the configure_bridge RTAS tokens
Date: Thu,  7 Apr 2016 16:28:27 +1000
Message-Id: <1460010507-24777-2-git-send-email-ruscur@russell.cc>
In-Reply-To: <1460010507-24777-1-git-send-email-ruscur@russell.cc>
References: <1460010507-24777-1-git-send-email-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The RTAS calls "ibm,configure-pe" and "ibm,configure-bridge" perform the
same actions, however the former can skip configuration if unnecessary.
The existing code treats them as different tokens even though only one
will ever be called.  Refactor this by making a single token that is
assigned during init.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
V3: Reorder commits so the previous patch doesn't depend on this

I had a look at doing the same with some other duplicated tokens but
they had slight differences in semantics so it wasn't helping clarity.
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 405baaf..3998e0f 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -53,7 +53,6 @@ static int ibm_read_slot_reset_state2;
 static int ibm_slot_error_detail;
 static int ibm_get_config_addr_info;
 static int ibm_get_config_addr_info2;
-static int ibm_configure_bridge;
 static int ibm_configure_pe;
 
 /*
@@ -81,7 +80,14 @@ static int pseries_eeh_init(void)
 	ibm_get_config_addr_info2	= rtas_token("ibm,get-config-addr-info2");
 	ibm_get_config_addr_info	= rtas_token("ibm,get-config-addr-info");
 	ibm_configure_pe		= rtas_token("ibm,configure-pe");
-	ibm_configure_bridge		= rtas_token("ibm,configure-bridge");
+
+	/*
+	 * ibm,configure-pe and ibm,configure-bridge have the same semantics,
+	 * however ibm,configure-pe can be faster.  If we can't find
+	 * ibm,configure-pe then fall back to using ibm,configure-bridge.
+	 */
+	if (ibm_configure_pe == RTAS_UNKNOWN_SERVICE)
+		ibm_configure_pe 	= rtas_token("ibm,configure-bridge");
 
 	/*
 	 * Necessary sanity check. We needn't check "get-config-addr-info"
@@ -93,8 +99,7 @@ static int pseries_eeh_init(void)
 	    (ibm_read_slot_reset_state2 == RTAS_UNKNOWN_SERVICE &&
 	     ibm_read_slot_reset_state == RTAS_UNKNOWN_SERVICE)	||
 	    ibm_slot_error_detail == RTAS_UNKNOWN_SERVICE	||
-	    (ibm_configure_pe == RTAS_UNKNOWN_SERVICE		&&
-	     ibm_configure_bridge == RTAS_UNKNOWN_SERVICE)) {
+	    ibm_configure_pe == RTAS_UNKNOWN_SERVICE) {
 		pr_info("EEH functionality not supported\n");
 		return -EINVAL;
 	}
@@ -624,18 +629,9 @@ static int pseries_eeh_configure_bridge(struct eeh_pe *pe)
 		config_addr = pe->addr;
 
 	while (max_wait > 0) {
-		/* Use new configure-pe function, if supported */
-		if (ibm_configure_pe != RTAS_UNKNOWN_SERVICE) {
-			ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
-					config_addr, BUID_HI(pe->phb->buid),
-					BUID_LO(pe->phb->buid));
-		} else if (ibm_configure_bridge != RTAS_UNKNOWN_SERVICE) {
-			ret = rtas_call(ibm_configure_bridge, 3, 1, NULL,
-					config_addr, BUID_HI(pe->phb->buid),
-					BUID_LO(pe->phb->buid));
-		} else {
-			return -EFAULT;
-		}
+		ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
+				config_addr, BUID_HI(pe->phb->buid),
+				BUID_LO(pe->phb->buid));
 
 		if (!ret)
 			return ret;
-- 
2.8.0
