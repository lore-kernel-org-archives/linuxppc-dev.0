Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTKTB3l4nzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 14:28:45 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1N3Shjs077600
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 22:28:43 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28sau41dcf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 22:28:43 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 23 Feb 2017 13:28:35 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E39AD2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 14:28:31 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1N3SNgF54067206
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 14:28:31 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1N3Rxln009751
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 14:27:59 +1100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, frederic.barrat@fr.ibm.com,
 Andrew Donnellan <andonnel@au1.ibm.com>, Ian Munsie <ianmunsi@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Gregory Kurz <KURZGREG@fr.ibm.com>
Subject: [RESEND PATCH] cxl: Route eeh events to all slices for
 pci_channel_io_perm_failure state
Date: Thu, 23 Feb 2017 08:57:26 +0530
Message-Id: <20170223032726.943-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix a boundary condition where in some cases an eeh event with
state == pci_channel_io_perm_failure wont be passed on to a driver
attached to the virtual pci device associated with a slice. This will
happen in case the slice just before (n-1) doesn't have any vPHB bus
associated with it, that results in an early return from
cxl_pci_error_detected callback.

With state==pci_channel_io_perm_failure, the adapter will be removed
irrespective of the return value of cxl_vphb_error_detected. So we now
always return PCI_ERS_RESULT_DISCONNECTED for this case i.e even if
the AFU isn't using a vPHB (currently returns PCI_ERS_RESULT_NONE).

Fixes: e4f5fc001a6("cxl: Do not create vPHB if there are no AFU configuration records")
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---
Resend:	Rephrased the patch description as suggested by Matthew and Andrew
---
drivers/misc/cxl/pci.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 80a87ab..679afc9 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1780,15 +1780,13 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 
 	/* If we're permanently dead, give up. */
 	if (state == pci_channel_io_perm_failure) {
-		/* Tell the AFU drivers; but we don't care what they
-		 * say, we're going away.
-		 */
 		for (i = 0; i < adapter->slices; i++) {
 			afu = adapter->afu[i];
-			/* Only participate in EEH if we are on a virtual PHB */
-			if (afu->phb == NULL)
-				return PCI_ERS_RESULT_NONE;
-			cxl_vphb_error_detected(afu, state);
+			/* Tell the AFU drivers; but we don't care what they
+			 * say, we're going away.
+			 */
+			if (afu->phb != NULL)
+				cxl_vphb_error_detected(afu, state);
 		}
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
-- 
2.9.3
