Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ABC69B701C
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:35 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 28 Feb 2012 06:55:25 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1S5wpUO3067920
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 16:58:51 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1S64JMt018981
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:19 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/21] pSeries platform EEH initialization
Date: Tue, 28 Feb 2012 14:03:54 +0800
Message-Id: <1330409051-8941-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The platform specific EEH operations have been abstracted by
struct eeh_ops. The individual platroms, including pSeries, needs
doing necessary initialization before the platform dependent EEH
operations work properly.

The patch is addressing that and do necessary platform initialization
for pSeries platform. More specificly, it will figure out the tokens
of EEH related RTAS calls.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh.c         |   12 ++++++
 arch/powerpc/platforms/pseries/eeh_pseries.c |   55 ++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index b0e3fb0..bb6de6c 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -1279,6 +1279,18 @@ void __init eeh_init(void)
 {
 	struct device_node *phb, *np;
 	struct eeh_early_enable_info info;
+	int ret;
+
+	/* call platform initialization function */
+	if (!eeh_ops) {
+		pr_warning("%s: Platform EEH operation not found\n",
+			__func__);
+		return;
+	} else if ((ret = eeh_ops->init())) {
+		pr_warning("%s: Failed to call platform init function (%d)\n",
+			__func__, ret);
+		return;
+	}
 
 	raw_spin_lock_init(&confirm_error_lock);
 	spin_lock_init(&slot_errbuf_lock);
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 61a9050..1a9410a 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -45,6 +45,17 @@
 #include <asm/ppc-pci.h>
 #include <asm/rtas.h>
 
+/* RTAS tokens */
+static int ibm_set_eeh_option;
+static int ibm_set_slot_reset;
+static int ibm_read_slot_reset_state;
+static int ibm_read_slot_reset_state2;
+static int ibm_slot_error_detail;
+static int ibm_get_config_addr_info;
+static int ibm_get_config_addr_info2;
+static int ibm_configure_bridge;
+static int ibm_configure_pe;
+
 /**
  * pseries_eeh_init - EEH platform dependent initialization
  *
@@ -52,6 +63,50 @@
  */
 static int pseries_eeh_init(void)
 {
+	/* figure out EEH RTAS function call tokens */
+	ibm_set_eeh_option		= rtas_token("ibm,set-eeh-option");
+	ibm_set_slot_reset		= rtas_token("ibm,set-slot-reset");
+	ibm_read_slot_reset_state2	= rtas_token("ibm,read-slot-reset-state2");
+	ibm_read_slot_reset_state	= rtas_token("ibm,read-slot-reset-state");
+	ibm_slot_error_detail		= rtas_token("ibm,slot-error-detail");
+	ibm_get_config_addr_info2	= rtas_token("ibm,get-config-addr-info2");
+	ibm_get_config_addr_info	= rtas_token("ibm,get-config-addr-info");
+	ibm_configure_pe		= rtas_token("ibm,configure-pe");
+	ibm_configure_bridge		= rtas_token ("ibm,configure-bridge");
+
+	/* necessary sanity check */
+	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE) {
+		pr_warning("%s: RTAS service <ibm,set-eeh-option> invalid\n",
+			__func__);
+		return -EINVAL;
+	} else if (ibm_set_slot_reset == RTAS_UNKNOWN_SERVICE) {
+		pr_warning("%s: RTAS service <ibm, set-slot-reset> invalid\n",
+			__func__);
+		return -EINVAL;
+	} else if (ibm_read_slot_reset_state2 == RTAS_UNKNOWN_SERVICE &&
+		   ibm_read_slot_reset_state == RTAS_UNKNOWN_SERVICE) {
+		pr_warning("%s: RTAS service <ibm,read-slot-reset-state2> and "
+			"<ibm,read-slot-reset-state> invalid\n",
+			__func__);
+		return -EINVAL;
+	} else if (ibm_slot_error_detail == RTAS_UNKNOWN_SERVICE) {
+		pr_warning("%s: RTAS service <ibm,slot-error-detail> invalid\n",
+			__func__);
+		return -EINVAL;
+	} else if (ibm_get_config_addr_info2 == RTAS_UNKNOWN_SERVICE &&
+		   ibm_get_config_addr_info == RTAS_UNKNOWN_SERVICE) {
+		pr_warning("%s: RTAS service <ibm,get-config-addr-info2> and "
+			"<ibm,get-config-addr-info> invalid\n",
+			__func__);
+		return -EINVAL;
+	} else if (ibm_configure_pe == RTAS_UNKNOWN_SERVICE &&
+		   ibm_configure_bridge == RTAS_UNKNOWN_SERVICE) {
+		pr_warning("%s: RTAS service <ibm,configure-pe> and "
+			"<ibm,configure-bridge> invalid\n",
+			__func__);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
1.7.5.4
