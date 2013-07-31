Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B5722C0082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 18:47:12 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 31 Jul 2013 02:47:10 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id DEAF31FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 02:41:45 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6V8l8x6145434
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 02:47:08 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6V8l8St008798
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 02:47:08 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/5] powerpc/powernv: Free PHB instance upon error
Date: Wed, 31 Jul 2013 16:47:00 +0800
Message-Id: <1375260424-20777-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't free PHB instance (struct pnv_phb) on error to creating
the associated PCI controler (struct pci_controller). The patch
fixes that. Also, the output messages have been cleaned for a bit
so that they looks unified for IODA_1/2 cases.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d8140b1..9cccdc7 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1113,7 +1113,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	void *aux;
 	long rc;
 
-	pr_info(" Initializing IODA%d OPAL PHB %s\n", ioda_type, np->full_name);
+	pr_info("Initializing IODA%d OPAL PHB %s\n", ioda_type, np->full_name);
 
 	prop64 = of_get_property(np, "ibm,opal-phbid", NULL);
 	if (!prop64) {
@@ -1124,13 +1124,18 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	pr_debug("  PHB-ID  : 0x%016llx\n", phb_id);
 
 	phb = alloc_bootmem(sizeof(struct pnv_phb));
-	if (phb) {
-		memset(phb, 0, sizeof(struct pnv_phb));
-		phb->hose = hose = pcibios_alloc_controller(np);
+	if (!phb) {
+		pr_err("  Out of memory !\n");
+		return;
 	}
-	if (!phb || !phb->hose) {
-		pr_err("PCI: Failed to allocate PCI controller for %s\n",
+
+	/* Allocate PCI controller */
+	memset(phb, 0, sizeof(struct pnv_phb));
+	phb->hose = hose = pcibios_alloc_controller(np);
+	if (!phb->hose) {
+		pr_err("  Can't allocate PCI controller for %s\n",
 		       np->full_name);
+		free_bootmem((unsigned long)phb, sizeof(struct pnv_phb));
 		return;
 	}
 
-- 
1.7.5.4
