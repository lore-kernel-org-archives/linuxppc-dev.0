Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0E401A05E7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:17 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 30 Sep 2014 12:39:17 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 752ED2BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:15 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8U2f54D29949968
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:41:05 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8U2dEtH029507
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:15 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 15/21] powerpc/pseries: Decrease message level on EEH
 initialization
Date: Tue, 30 Sep 2014 12:39:04 +1000
Message-Id: <1412044750-24460-15-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As Anton suggested, the patch decreases the message level on EEH
initialization to avoid unnecessary messages if required. Also,
we have unified hint if any of needful RTAS calls is missed, and
then we can check /proc/device-tree to figure out the missed RTAS
calls.

Suggested-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 35 ++++++++--------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 4fc5ff9..a6c7e19 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -88,29 +88,14 @@ static int pseries_eeh_init(void)
 	 * and its variant since the old firmware probably support address
 	 * of domain/bus/slot/function for EEH RTAS operations.
 	 */
-	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE) {
-		pr_warn("%s: RTAS service <ibm,set-eeh-option> invalid\n",
-			__func__);
-		return -EINVAL;
-	} else if (ibm_set_slot_reset == RTAS_UNKNOWN_SERVICE) {
-		pr_warn("%s: RTAS service <ibm,set-slot-reset> invalid\n",
-			__func__);
-		return -EINVAL;
-	} else if (ibm_read_slot_reset_state2 == RTAS_UNKNOWN_SERVICE &&
-		   ibm_read_slot_reset_state == RTAS_UNKNOWN_SERVICE) {
-		pr_warn("%s: RTAS service <ibm,read-slot-reset-state2> and "
-			"<ibm,read-slot-reset-state> invalid\n",
-			__func__);
-		return -EINVAL;
-	} else if (ibm_slot_error_detail == RTAS_UNKNOWN_SERVICE) {
-		pr_warn("%s: RTAS service <ibm,slot-error-detail> invalid\n",
-			__func__);
-		return -EINVAL;
-	} else if (ibm_configure_pe == RTAS_UNKNOWN_SERVICE &&
-		   ibm_configure_bridge == RTAS_UNKNOWN_SERVICE) {
-		pr_warn("%s: RTAS service <ibm,configure-pe> and "
-			"<ibm,configure-bridge> invalid\n",
-			__func__);
+	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE		||
+	    ibm_set_slot_reset == RTAS_UNKNOWN_SERVICE		||
+	    (ibm_read_slot_reset_state2 == RTAS_UNKNOWN_SERVICE &&
+	     ibm_read_slot_reset_state == RTAS_UNKNOWN_SERVICE)	||
+	    ibm_slot_error_detail == RTAS_UNKNOWN_SERVICE	||
+	    (ibm_configure_pe == RTAS_UNKNOWN_SERVICE		&&
+	     ibm_configure_bridge == RTAS_UNKNOWN_SERVICE)) {
+		pr_info("EEH functionality not supported\n");
 		return -EINVAL;
 	}
 
@@ -118,11 +103,11 @@ static int pseries_eeh_init(void)
 	spin_lock_init(&slot_errbuf_lock);
 	eeh_error_buf_size = rtas_token("rtas-error-log-max");
 	if (eeh_error_buf_size == RTAS_UNKNOWN_SERVICE) {
-		pr_warn("%s: unknown EEH error log size\n",
+		pr_info("%s: unknown EEH error log size\n",
 			__func__);
 		eeh_error_buf_size = 1024;
 	} else if (eeh_error_buf_size > RTAS_ERROR_LOG_MAX) {
-		pr_warn("%s: EEH error log size %d exceeds the maximal %d\n",
+		pr_info("%s: EEH error log size %d exceeds the maximal %d\n",
 			__func__, eeh_error_buf_size, RTAS_ERROR_LOG_MAX);
 		eeh_error_buf_size = RTAS_ERROR_LOG_MAX;
 	}
-- 
1.8.3.2
