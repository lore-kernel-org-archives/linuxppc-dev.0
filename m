Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbTMf0R3gzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 16:44:30 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rbTMd24pWz9sCY
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2016 16:44:29 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5O6i6jx037618
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2016 02:44:27 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23rkcferu3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2016 02:44:27 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 24 Jun 2016 16:44:24 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 71A142CE8046
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2016 16:44:22 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5O6iMZq20643852
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2016 16:44:22 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5O6iLNB032429
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2016 16:44:22 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Call opal_pci_poll() if needed
Date: Fri, 24 Jun 2016 16:44:19 +1000
Message-Id: <1466750659-17400-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When issuing PHB reset, OPAL API opal_pci_poll() is called to drive
the state machine in OPAL forward. However, we needn't always call
the function under some circumstances like reset deassert.

This avoids calling opal_pci_poll() when OPAL_SUCCESS is returned
from opal_pci_reset(). Except the overhead introduced by additional
one unnecessary OPAL call, I didn't run into real issue because of
this.

Reported-by: Pridhiviraj Paidipeddi <ppaiddipe@in.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 86544ea..931b305 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -763,7 +763,8 @@ int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
 	 * reset followed by hot reset on root bus. So we also
 	 * need the PCI bus settlement delay.
 	 */
-	rc = pnv_eeh_poll(phb->opal_id);
+	if (rc > 0)
+		rc = pnv_eeh_poll(phb->opal_id);
 	if (option == EEH_RESET_DEACTIVATE) {
 		if (system_state < SYSTEM_RUNNING)
 			udelay(1000 * EEH_PE_RST_SETTLE_TIME);
@@ -806,7 +807,8 @@ static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
 		goto out;
 
 	/* Poll state of the PHB until the request is done */
-	rc = pnv_eeh_poll(phb->opal_id);
+	if (rc > 0)
+		rc = pnv_eeh_poll(phb->opal_id);
 	if (option == EEH_RESET_DEACTIVATE)
 		msleep(EEH_PE_RST_SETTLE_TIME);
 out:
-- 
2.1.0
