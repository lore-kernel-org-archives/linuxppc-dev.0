Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C85FF2C0090
 for <linuxppc-dev@ozlabs.org>; Sun, 12 Jan 2014 17:14:00 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 11 Jan 2014 23:13:56 -0700
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 093356E803F
 for <linuxppc-dev@ozlabs.org>; Sun, 12 Jan 2014 01:13:51 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0C6DsWo6160774
 for <linuxppc-dev@ozlabs.org>; Sun, 12 Jan 2014 06:13:54 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0C6DsYF027183
 for <linuxppc-dev@ozlabs.org>; Sun, 12 Jan 2014 01:13:54 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc/eeh: Escalate error on non-existing PE
Date: Sun, 12 Jan 2014 14:13:46 +0800
Message-Id: <1389507226-32002-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1389507226-32002-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1389507226-32002-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sometimes, especially in sinario of loading another kernel with kdump,
we got EEH error on non-existing PE. That means the PEEV / PEST in
the corresponding PHB would be messy and we can't handle that case.
The patch escalates the error to fenced PHB so that the PHB could be
rested in order to revoer the errors on non-existing PEs.

Reported-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Tested-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 6971146..0bf6b2b 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -980,12 +980,26 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 
 			break;
 		case OPAL_EEH_PE_ERROR:
-			if (ioda_eeh_get_pe(hose, frozen_pe_no, pe))
-				break;
+			/*
+			 * If we can't find the corresponding PE, the
+			 * PEEV / PEST would be messy. So we force an
+			 * fenced PHB so that it can be recovered.
+			 */
+			if (ioda_eeh_get_pe(hose, frozen_pe_no, pe)) {
+				if (!ioda_eeh_get_phb_pe(hose, pe)) {
+					ret = EEH_NEXT_ERR_FENCED_PHB;
+					pr_err("EEH: Escalated fenced PHB#%x "
+					       "detected\n",
+						hose->global_number);
+				} else {
+					ret = EEH_NEXT_ERR_NONE;
+				}
+			} else {
+				pr_err("EEH: Frozen PE#%x on PHB#%x detected\n",
+					(*pe)->addr, (*pe)->phb->global_number);
+				ret = EEH_NEXT_ERR_FROZEN_PE;
+			}
 
-			pr_err("EEH: Frozen PE#%x on PHB#%x detected\n",
-				(*pe)->addr, (*pe)->phb->global_number);
-			ret = EEH_NEXT_ERR_FROZEN_PE;
 			break;
 		default:
 			pr_warn("%s: Unexpected error type %d\n",
-- 
1.7.10.4
