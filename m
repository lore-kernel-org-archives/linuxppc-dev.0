Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EDD112C0323
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 20:21:32 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 04:20:57 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 448163E40039
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 04:20:35 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5JAKr9f147332
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 04:20:53 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5JAKrCj015327
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 04:20:53 -0600
Date: Wed, 19 Jun 2013 18:20:47 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/31] powerpc/eeh: Trace PCI bus from PE
Message-ID: <20130619102047.GA8210@shangw.(null)>
References: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1371544435-4943-6-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
In-Reply-To: <1371544435-4943-6-git-send-email-shangw@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 18, 2013 at 04:33:29PM +0800, Gavin Shan wrote:
>There're several types of PEs can be supported for now: PHB, Bus
>and Device dependent PE. For PCI bus dependent PE, tracing the
>corresponding PCI bus from PE (struct eeh_pe) would make the code
>more efficient. The patch also enables the retrieval of PCI bus based
>on the PCI bus dependent PE.
>
>Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>---

Please use the updated [5/31] in the attachment.

Thanks,
Gavin


--qMm9M+Fa2AknHoGS
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0005-powerpc-eeh-Trace-PCI-bus-from-PE.patch"

>From ebfc469dc8fa0748571c5fc9766b5606ce5d8620 Mon Sep 17 00:00:00 2001
From: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Wed, 19 Jun 2013 14:11:43 +0800
Subject: [PATCH 05/31] powerpc/eeh: Trace PCI bus from PE

There're several types of PEs can be supported for now: PHB, Bus
and Device dependent PE. For PCI bus dependent PE, tracing the
corresponding PCI bus from PE (struct eeh_pe) would make the code
more efficient. The patch also enables the retrieval of PCI bus based
on the PCI bus dependent PE.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |    1 +
 arch/powerpc/kernel/eeh_pe.c   |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

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
index 3d2dcf5..c963667 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -365,6 +365,17 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	pe->config_addr	= edev->config_addr;
 
 	/*
+	 * While doing PE reset, we probably hot-reset the
+	 * upstream bridge. However, the PCI devices including
+	 * the associated EEH devices might be removed when EEH
+	 * core is doing recovery. So that won't safe to retrieve
+	 * the bridge through downstream EEH device. We have to
+	 * trace the parent PCI bus, then the upstream bridge.
+	 */
+	if (eeh_probe_mode_dev())
+		pe->bus = eeh_dev_to_pci_dev(edev)->bus;
+
+	/*
 	 * Put the new EEH PE into hierarchy tree. If the parent
 	 * can't be found, the newly created PE will be attached
 	 * to PHB directly. Otherwise, we have to associate the
@@ -641,12 +652,18 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
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


--qMm9M+Fa2AknHoGS--
