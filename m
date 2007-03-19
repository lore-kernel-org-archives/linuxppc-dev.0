Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89422DDF90
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 06:54:25 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l2JJqfne021812
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:52:41 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2JJsMBu060942
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 13:54:22 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2JJsMqi019888
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 13:54:22 -0600
Date: Mon, 19 Mar 2007 14:54:21 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/11] ppc64: EEH: support ibm,get-config-addr-info2 RTAS call
Message-ID: <20070319195421.GD11532@austin.ibm.com>
References: <20070319194349.GT5151@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070319194349.GT5151@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Provide support for the new ibm,get-config-addr-info2 RTAS token,
whenever it is actually available.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |   44 +++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 9 deletions(-)

Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:19:30.000000000 -0500
+++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:20:31.000000000 -0500
@@ -83,6 +83,7 @@ static int ibm_read_slot_reset_state;
 static int ibm_read_slot_reset_state2;
 static int ibm_slot_error_detail;
 static int ibm_get_config_addr_info;
+static int ibm_get_config_addr_info2;
 static int ibm_configure_bridge;
 
 int eeh_subsystem_enabled;
@@ -744,6 +745,38 @@ struct eeh_early_enable_info {
 	unsigned int buid_lo;
 };
 
+static int get_pe_addr (int config_addr,
+                        struct eeh_early_enable_info *info)
+{
+	unsigned int rets[3];
+	int ret;
+
+	/* Use latest config-addr token on power6 */
+	if (ibm_get_config_addr_info2 != RTAS_UNKNOWN_SERVICE) {
+		/* Make sure we have a PE in hand */
+		ret = rtas_call (ibm_get_config_addr_info2, 4, 2, rets,
+			config_addr, info->buid_hi, info->buid_lo, 1);
+		if (ret || (rets[0]==0))
+			return 0;
+
+		ret = rtas_call (ibm_get_config_addr_info2, 4, 2, rets,
+			config_addr, info->buid_hi, info->buid_lo, 0);
+		if (ret)
+			return 0;
+		return rets[0];
+	}
+
+	/* Use older config-addr token on power5 */
+	if (ibm_get_config_addr_info != RTAS_UNKNOWN_SERVICE) {
+		ret = rtas_call (ibm_get_config_addr_info, 4, 2, rets,
+			config_addr, info->buid_hi, info->buid_lo, 0);
+		if (ret)
+			return 0;
+		return rets[0];
+	}
+	return 0;
+}
+
 /* Enable eeh for the given device node. */
 static void *early_enable_eeh(struct device_node *dn, void *data)
 {
@@ -810,15 +843,7 @@ static void *early_enable_eeh(struct dev
 
 			/* If the newer, better, ibm,get-config-addr-info is supported, 
 			 * then use that instead. */
-			pdn->eeh_pe_config_addr = 0;
-			if (ibm_get_config_addr_info != RTAS_UNKNOWN_SERVICE) {
-				ret = rtas_call (ibm_get_config_addr_info, 4, 2, rets, 
-					pdn->eeh_config_addr, 
-					info->buid_hi, info->buid_lo,
-					0);
-				if (ret == 0)
-					pdn->eeh_pe_config_addr = rets[0];
-			}
+			pdn->eeh_pe_config_addr = get_pe_addr(pdn->eeh_config_addr, info);
 
 			/* Some older systems (Power4) allow the
 			 * ibm,set-eeh-option call to succeed even on nodes
@@ -889,6 +914,7 @@ void __init eeh_init(void)
 	ibm_read_slot_reset_state = rtas_token("ibm,read-slot-reset-state");
 	ibm_slot_error_detail = rtas_token("ibm,slot-error-detail");
 	ibm_get_config_addr_info = rtas_token("ibm,get-config-addr-info");
+	ibm_get_config_addr_info2 = rtas_token("ibm,get-config-addr-info2");
 	ibm_configure_bridge = rtas_token ("ibm,configure-bridge");
 
 	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE)
