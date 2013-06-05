Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 988ED2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 17:34:41 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 5 Jun 2013 03:34:38 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 60EBF38C8045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 03:34:35 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r557YaIU48955594
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 03:34:36 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r557YX0k021628
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 04:34:35 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/27] powerpc/eeh: Fix fetching bus for single-dev-PE
Date: Wed,  5 Jun 2013 15:34:02 +0800
Message-Id: <1370417668-16832-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Steve Best <sbest@us.ibm.com>, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While running Linux as guest on top of phyp, we possiblly have
PE that includes single PCI device. However, we didn't return
its PCI bus correctly and it leads to failure on recovery from
EEH errors for single-dev-PE. The patch fixes the issue.

Cc: <stable@vger.kernel.org> # v3.7+
Cc: Steve Best <sbest@us.ibm.com>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_pe.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index fe43d1a..9d4a9e8 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -639,7 +639,8 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 
 	if (pe->type & EEH_PE_PHB) {
 		bus = pe->phb->bus;
-	} else if (pe->type & EEH_PE_BUS) {
+	} else if (pe->type & EEH_PE_BUS ||
+		   pe->type & EEH_PE_DEVICE) {
 		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
 		pdev = eeh_dev_to_pci_dev(edev);
 		if (pdev)
-- 
1.7.5.4
