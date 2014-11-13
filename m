Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A77011A0100
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 10:47:36 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5C6561400A0
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 10:47:36 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 14 Nov 2014 09:47:35 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1C4ED2CE8062
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 10:47:32 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sADNlGEu20054262
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 10:47:16 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sADNlUMh003426
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 10:47:31 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc/eeh: Refactor eeh_reset_pe()
Date: Fri, 14 Nov 2014 10:47:28 +1100
Message-Id: <1415922450-29581-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch refactors eeh_reset_pe() in order for:

   * Varied return values for different failure cases.
   * Replace pr_err() with pr_warn() and print function name.
   * Coding style cleanup.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 2248a19..967e4a0 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -758,30 +758,37 @@ static void eeh_reset_pe_once(struct eeh_pe *pe)
 int eeh_reset_pe(struct eeh_pe *pe)
 {
 	int flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
-	int i, rc;
+	int i, state, ret;
 
 	/* Take three shots at resetting the bus */
-	for (i=0; i<3; i++) {
+	for (i = 0; i < 3; i++) {
 		eeh_reset_pe_once(pe);
 
 		/*
 		 * EEH_PE_ISOLATED is expected to be removed after
 		 * BAR restore.
 		 */
-		rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
-		if ((rc & flags) == flags)
-			return 0;
+		state = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
+		if ((state & flags) == flags) {
+			ret = 0;
+			goto out;
+		}
 
-		if (rc < 0) {
-			pr_err("%s: Unrecoverable slot failure on PHB#%d-PE#%x",
+		if (state < 0) {
+			pr_warn("%s: Unrecoverable slot failure on PHB#%d-PE#%x",
 				__func__, pe->phb->global_number, pe->addr);
-			return -1;
+			ret = -ENOTRECOVERABLE;
+			goto out;
 		}
-		pr_err("EEH: bus reset %d failed on PHB#%d-PE#%x, rc=%d\n",
-			i+1, pe->phb->global_number, pe->addr, rc);
+
+		/* We might run out of credits */
+		ret = -EIO;
+		pr_warn("%s: Failure %d resetting PHB#%x-PE#%x\n (%d)\n",
+			__func__, state, pe->phb->global_number, pe->addr, (i + 1));
 	}
 
-	return -1;
+out:
+	return ret;
 }
 
 /**
-- 
1.8.3.2
