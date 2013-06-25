Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 831ED2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 15:56:02 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 01:56:00 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D1B60C90044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:55:25 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5P5tQRm253578
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:55:26 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5P5tQH0010731
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 02:55:26 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/10] powerpc/powernv: Hold PCI-CFG and I/O access
Date: Tue, 25 Jun 2013 13:55:15 +0800
Message-Id: <1372139717-14885-9-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While doing recovery from fenced PHB, we need hold the PCI-CFG and
I/O access until the complete PHB reset and BARs restore are done.
The patch addresses that.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c          |   11 +++++++++++
 arch/powerpc/platforms/powernv/eeh-ioda.c |   10 ++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 0974e13..944e225 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -349,12 +349,14 @@ static void *eeh_report_failure(void *data, void *userdata)
  */
 static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 {
+	struct pci_controller *hose;
 	struct timeval tstamp;
 	int cnt, rc;
 
 	/* pcibios will clear the counter; save the value */
 	cnt = pe->freeze_count;
 	tstamp = pe->tstamp;
+	hose = (pe->type & EEH_PE_PHB) ? pe->phb : NULL;
 
 	/*
 	 * We don't remove the corresponding PE instances because
@@ -377,6 +379,15 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	eeh_ops->configure_bridge(pe);
 	eeh_pe_restore_bars(pe);
 
+	/*
+	 * If we're recovering fenced PHB, the PCI-CFG and I/O should
+	 * have been blocked. We need reenable that.
+	 */
+	if (hose) {
+		eeh_ops->set_setting(EEH_SETTING_BLOCK_CFG, 0, hose);
+		eeh_ops->set_setting(EEH_SETTING_BLOCK_IO,  0, hose);
+	}
+
 	/* Give the system 5 seconds to finish running the user-space
 	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes,
 	 * this is a hack, but if we don't do this, and try to bring
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 64c3d1e..23c2442 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -922,7 +922,9 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 				list_for_each_entry_safe(hose, tmp,
 						&hose_list, list_node) {
 					phb = hose->private_data;
-					phb->eeh_state |= PNV_EEH_STATE_REMOVED;
+					phb->eeh_state |= (PNV_EEH_STATE_REMOVED |
+							   PNV_EEH_STATE_IO_BLOCKED |
+							   PNV_EEH_STATE_IO_BLOCKED);
 				}
 
 				WARN(1, "EEH: dead IOC detected\n");
@@ -939,7 +941,9 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 
 				WARN(1, "EEH: dead PHB#%x detected\n",
 				     hose->global_number);
-				phb->eeh_state |= PNV_EEH_STATE_REMOVED;
+				phb->eeh_state |= (PNV_EEH_STATE_REMOVED |
+						   PNV_EEH_STATE_CFG_BLOCKED |
+						   PNV_EEH_STATE_IO_BLOCKED);
 				ret = 3;
 				goto out;
 			} else if (severity == OPAL_EEH_SEV_PHB_FENCED) {
@@ -948,6 +952,8 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 
 				WARN(1, "EEH: fenced PHB#%x detected\n",
 				     hose->global_number);
+				phb->eeh_state |= (PNV_EEH_STATE_CFG_BLOCKED |
+						   PNV_EEH_STATE_IO_BLOCKED);
 				ret = 2;
 				goto out;
 			} else if (severity == OPAL_EEH_SEV_INF)
-- 
1.7.5.4
