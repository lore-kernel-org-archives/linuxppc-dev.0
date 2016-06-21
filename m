Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYX6T6SkrzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 12:41:21 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rYX6T1rdqz9t0V
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 12:41:21 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L2dKdj041767
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Jun 2016 22:41:18 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23n2ek8qh8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Jun 2016 22:41:18 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 21 Jun 2016 12:41:15 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EEFBE3578052
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 12:41:12 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5L2fBdh65732672
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 12:41:11 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5L2fAVw003599
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 12:41:11 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Exclude MSI region in extended bridge window
Date: Tue, 21 Jun 2016 12:41:05 +1000
Message-Id: <1466476865-13425-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The windows of root port and bridge behind that are extended to
the PHB's windows to accomodate the PCI hotplug happening in
future. The PHB's 64KB 32-bits MSI region is included in bridge's
M32 windows (in hardware) though it's excluded in the corresponding
resource, as the bridge's M32 windows have 1MB as their minimal
alignment. We observed EEH error during system boot when the MSI
region is included in bridge's M32 window.

This excludes top 1MB (including 64KB 32-bits MSI region) region
from bridge's M32 windows when extending them.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index bde7f76..e0a8a92 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3239,6 +3239,7 @@ static void pnv_pci_fixup_bridge_resources(struct pci_bus *bus,
 	struct pnv_phb *phb = hose->private_data;
 	struct pci_dev *bridge = bus->self;
 	struct resource *r, *w;
+	bool msi_region = false;
 	int i;
 
 	/* Check if we need apply fixup to the bridge's windows */
@@ -3259,11 +3260,25 @@ static void pnv_pci_fixup_bridge_resources(struct pci_bus *bus,
 			 (type & IORESOURCE_PREFETCH) &&
 			 phb->ioda.m64_segsize)
 			w = &hose->mem_resources[1];
-		else if (r->flags & type & IORESOURCE_MEM)
+		else if (r->flags & type & IORESOURCE_MEM) {
 			w = &hose->mem_resources[0];
+			msi_region = true;
+		}
 
 		r->start = w->start;
 		r->end = w->end;
+
+		/* The 64KB 32-bits MSI region shouldn't be included in
+		 * the 32-bits bridge window. Otherwise, we can see strange
+		 * issues. One of them is EEH error observed on Garrison.
+		 *
+		 * Exclude top 1MB region which is the minimal alignment of
+		 * 32-bits bridge window.
+		 */
+		if (msi_region) {
+			r->end += 0x10000;
+			r->end -= 0x100000;
+		}
 	}
 }
 
-- 
2.1.0
