Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYwM53s6kzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 13:53:21 +1100 (AEDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>
Subject: [PATCH V2 1/2] pseries/eeh: Refactor the configure bridge RTAS tokens
Date: Tue, 29 Mar 2016 12:51:50 +1000
Message-Id: <1459219911-14110-1-git-send-email-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The RTAS calls configure-pe and configure-bridge perform the same
actions, however the former can skip configuration if unnecessary.  The
existing code treats them as different tokens even though only one will
ever be called.  Refactor this by making a single token that is assigned
during init.

Cc: <stable@vger.kernel.org> # 3.10-
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index ac3ffd9..231b1df 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -53,7 +53,6 @@ static int ibm_read_slot_reset_state2;
 static int ibm_slot_error_detail;
 static int ibm_get_config_addr_info;
 static int ibm_get_config_addr_info2;
-static int ibm_configure_bridge;
 static int ibm_configure_pe;
 
 /*
@@ -81,7 +80,13 @@ static int pseries_eeh_init(void)
 	ibm_get_config_addr_info2	= rtas_token("ibm,get-config-addr-info2");
 	ibm_get_config_addr_info	= rtas_token("ibm,get-config-addr-info");
 	ibm_configure_pe		= rtas_token("ibm,configure-pe");
-	ibm_configure_bridge		= rtas_token("ibm,configure-bridge");
+
+	/*
+	 * configure-pe and configure-bridge perform the same actions, however
+	 * the former is preferred as it can skip configuration if unnecessary.
+	 */
+	if (ibm_configure_pe == RTAS_UNKNOWN_SERVICE)
+		ibm_configure_pe	= rtas_token("ibm,configure-bridge");
 
 	/*
 	 * Necessary sanity check. We needn't check "get-config-addr-info"
@@ -93,8 +98,7 @@ static int pseries_eeh_init(void)
 	    (ibm_read_slot_reset_state2 == RTAS_UNKNOWN_SERVICE &&
 	     ibm_read_slot_reset_state == RTAS_UNKNOWN_SERVICE)	||
 	    ibm_slot_error_detail == RTAS_UNKNOWN_SERVICE	||
-	    (ibm_configure_pe == RTAS_UNKNOWN_SERVICE		&&
-	     ibm_configure_bridge == RTAS_UNKNOWN_SERVICE)) {
+	    ibm_configure_pe == RTAS_UNKNOWN_SERVICE) {
 		pr_info("EEH functionality not supported\n");
 		return -EINVAL;
 	}
@@ -621,18 +625,9 @@ static int pseries_eeh_configure_bridge(struct eeh_pe *pe)
 	if (pe->addr)
 		config_addr = pe->addr;
 
-	/* Use new configure-pe function, if supported */
-	if (ibm_configure_pe != RTAS_UNKNOWN_SERVICE) {
-		ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
-				config_addr, BUID_HI(pe->phb->buid),
-				BUID_LO(pe->phb->buid));
-	} else if (ibm_configure_bridge != RTAS_UNKNOWN_SERVICE) {
-		ret = rtas_call(ibm_configure_bridge, 3, 1, NULL,
-				config_addr, BUID_HI(pe->phb->buid),
-				BUID_LO(pe->phb->buid));
-	} else {
-		return -EFAULT;
-	}
+	ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
+			config_addr, BUID_HI(pe->phb->buid),
+			BUID_LO(pe->phb->buid));
 
 	if (ret)
 		pr_warn("%s: Unable to configure bridge PHB#%d-PE#%x (%d)\n",
-- 
2.7.4
