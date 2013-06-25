Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C33E2C02F8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 20:02:05 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 06:02:02 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id AF29E6E803A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 06:01:56 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PA1BS4305198
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 06:01:11 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PA19es010388
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 07:01:10 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/6] powerpc/eeh: Refactor the output message
Date: Tue, 25 Jun 2013 18:01:00 +0800
Message-Id: <1372154461-29674-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372154461-29674-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372154461-29674-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We needn't the the whole backtrace other than one-line message in
the error reporting interrupt handler. For errors triggered by
access PCI config space or MMIO, we replace "WARN(1, ...)" with
pr_err() and dump_stack().

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c                 |    9 +++++++--
 arch/powerpc/platforms/powernv/eeh-ioda.c |   25 ++++++++++++++++---------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 60deb42..38e4b40 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -324,7 +324,9 @@ static int eeh_phb_check_failure(struct eeh_pe *pe)
 	eeh_serialize_unlock(flags);
 	eeh_send_failure_event(phb_pe);
 
-	WARN(1, "EEH: PHB failure detected\n");
+	pr_err("EEH: PHB#%x failure detected\n",
+		phb_pe->phb->global_number);
+	dump_stack();
 
 	return 1;
 out:
@@ -453,7 +455,10 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	 * a stack trace will help the device-driver authors figure
 	 * out what happened.  So print that out.
 	 */
-	WARN(1, "EEH: failure detected\n");
+	pr_err("EEH: Frozen PE#%x detected on PHB#%x\n",
+		pe->addr, pe->phb->global_number);
+	dump_stack();
+
 	return 1;
 
 dn_unlock:
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 85025d7..0cd1c4a 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -853,11 +853,14 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 					phb->eeh_state |= PNV_EEH_STATE_REMOVED;
 				}
 
-				WARN(1, "EEH: dead IOC detected\n");
+				pr_err("EEH: dead IOC detected\n");
 				ret = 4;
 				goto out;
-			} else if (severity == OPAL_EEH_SEV_INF)
+			} else if (severity == OPAL_EEH_SEV_INF) {
+				pr_info("EEH: IOC informative error "
+					"detected\n");
 				ioda_eeh_hub_diag(hose);
+			}
 
 			break;
 		case OPAL_EEH_PHB_ERROR:
@@ -865,8 +868,8 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 				if (ioda_eeh_get_phb_pe(hose, pe))
 					break;
 
-				WARN(1, "EEH: dead PHB#%x detected\n",
-				     hose->global_number);
+				pr_err("EEH: dead PHB#%x detected\n",
+					hose->global_number);
 				phb->eeh_state |= PNV_EEH_STATE_REMOVED;
 				ret = 3;
 				goto out;
@@ -874,20 +877,24 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 				if (ioda_eeh_get_phb_pe(hose, pe))
 					break;
 
-				WARN(1, "EEH: fenced PHB#%x detected\n",
-				     hose->global_number);
+				pr_err("EEH: fenced PHB#%x detected\n",
+					hose->global_number);
 				ret = 2;
 				goto out;
-			} else if (severity == OPAL_EEH_SEV_INF)
+			} else if (severity == OPAL_EEH_SEV_INF) {
+				pr_info("EEH: PHB#%x informative error "
+					"detected\n",
+					hose->global_number);
 				ioda_eeh_phb_diag(hose);
+			}
 
 			break;
 		case OPAL_EEH_PE_ERROR:
 			if (ioda_eeh_get_pe(hose, frozen_pe_no, pe))
 				break;
 
-			WARN(1, "EEH: Frozen PE#%x on PHB#%x detected\n",
-			     (*pe)->addr, (*pe)->phb->global_number);
+			pr_err("EEH: Frozen PE#%x on PHB#%x detected\n",
+				(*pe)->addr, (*pe)->phb->global_number);
 			ret = 1;
 			goto out;
 		}
-- 
1.7.5.4
