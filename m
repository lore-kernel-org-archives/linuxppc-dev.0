Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0C9DA2C0209
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 18:34:11 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 18 Jun 2013 04:34:09 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8BBF638C801A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:06 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5I8Y7nE274348
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:07 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5I8Y6Eo021000
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 05:34:07 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/31] powerpc/eeh: Trace PCI bus from PE
Date: Tue, 18 Jun 2013 16:33:29 +0800
Message-Id: <1371544435-4943-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
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
and Device dependent PE. For PCI bus dependent PE, tracing the
corresponding PCI bus from PE (struct eeh_pe) would make the code
more efficient. The patch also enables the retrieval of PCI bus based
on the PCI bus dependent PE.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |    1 +
 arch/powerpc/kernel/eeh_pe.c   |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index acdfcaa..f3b49d6 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -59,6 +59,7 @@ struct eeh_pe {
 	int config_addr;		/* Traditional PCI address	*/
 	int addr;			/* PE configuration address	*/
 	struct pci_controller *phb;	/* Associated PHB		*/
+	struct pci_bus *bus;		/* Top PCI bus for bus PE	*/
 	int check_count;		/* Times of ignored error	*/
 	int freeze_count;		/* Times of froze up		*/
 	int false_positives;		/* Times of reported #ff's	*/
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 3d2dcf5..5bd1637 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
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
+						      struct eeh_dev, list);
+			pe->bus = eeh_dev_to_pci_dev(first_edev)->bus;
+		}
+
 		/* Put the edev to PE */
 		list_add_tail(&edev->list, &pe->edevs);
 		eeh_unlock();
@@ -641,12 +657,18 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 		bus = pe->phb->bus;
 	} else if (pe->type & EEH_PE_BUS ||
 		   pe->type & EEH_PE_DEVICE) {
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
