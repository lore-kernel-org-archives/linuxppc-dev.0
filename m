Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B5CA62C02A2
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 01:17:38 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 1 Mar 2013 07:17:35 -0700
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A3CCA6E8039
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 09:17:30 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r21EHV3h61407374
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:17:31 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r21EHUwF007433
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 11:17:31 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/22] powerpc/eeh: Trace PCI bus from PE
Date: Fri,  1 Mar 2013 22:17:03 +0800
Message-Id: <1362147440-14096-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There're several types of PEs can be supported for now: PHB, Bus
Device. For PCI bus dependent PE, tracing the corresponding PCI
bus from PE (struct eeh_pe) would make the code more efficient.

The patch also enables the retrieval of PCI bus based on the
PCI device dependent PE.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h          |    1 +
 arch/powerpc/platforms/pseries/eeh_pe.c |   25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 9230aa4..557d82a 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -62,6 +62,7 @@ struct eeh_pe {
 	int check_count;		/* Times of ignored error	*/
 	int freeze_count;		/* Times of froze up		*/
 	int false_positives;		/* Times of reported #ff's	*/
+	struct pci_bus *bus;		/* Top PCI bus for bus PE	*/
 	struct eeh_pe *parent;		/* Parent PE			*/
 	struct list_head child_list;	/* Link PE to the child list	*/
 	struct list_head edevs;		/* Link list of EEH devices	*/
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index 93ed9cb..03f8223 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -304,6 +304,7 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
 int eeh_add_to_parent_pe(struct eeh_dev *edev)
 {
 	struct eeh_pe *pe, *parent;
+	struct eeh_dev *first_edev;
 
 	eeh_lock();
 
@@ -326,6 +327,21 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 		pe->type = EEH_PE_BUS;
 		edev->pe = pe;
 
+		/*
+		 * For PCI bus sensitive PE, we can reset the parent
+		 * bridge in order for hot-reset. However, the PCI
+		 * devices including the associated EEH devices might
+		 * be removed when EEH core is doing recovery. So that
+		 * won't safe to retrieve the bridge through downstream
+		 * EEH device. We have to trace the parent PCI bus, then
+		 * the parent bridge explicitly.
+		 */
+		if (eeh_probe_mode_dev() && !pe->bus) {
+			first_edev = list_first_entry(&pe->edevs,
+						struct eeh_dev, list);
+			pe->bus = eeh_dev_to_pci_dev(first_edev)->bus;
+		}
+
 		/* Put the edev to PE */
 		list_add_tail(&edev->list, &pe->edevs);
 		eeh_unlock();
@@ -639,13 +655,20 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 
 	if (pe->type & EEH_PE_PHB) {
 		bus = pe->phb->bus;
-	} else if (pe->type & EEH_PE_BUS) {
+	} else if (pe->type & EEH_PE_BUS ||
+		   pe->type & EEH_PE_DEVICE) {
+		if (pe->bus) {
+			bus = pe->bus;
+			goto out;
+		}
+
 		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
 		pdev = eeh_dev_to_pci_dev(edev);
 		if (pdev)
 			bus = pdev->bus;
 	}
 
+out:
 	eeh_unlock();
 
 	return bus;
-- 
1.7.5.4
