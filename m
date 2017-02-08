Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJ5py0kxRzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 14:12:09 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1839YVk080560
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 22:12:08 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28fr07xdqv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 22:12:05 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 13:12:03 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3E2193578056
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 14:12:01 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v183Br6v35586254
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 14:12:01 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v183BSSt005704
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 14:11:29 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: andrew.donnellan@au1.ibm.com, imunsie@au1.ibm.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2] powerpc/kernel: Remove error message in
 pcibios_setup_phb_resources()
Date: Wed,  8 Feb 2017 14:11:03 +1100
Message-Id: <1486523463-19953-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CAPI driver creates virtual PHB (vPHB) from the CAPI adapter.
The vPHB's IO and memory windows aren't built from device-tree node
as we do for normal PHBs. A error message is thrown in below path
when trying to probe AFUs contained in the adapter. The error message
is confusing and unnecessary.

    cxl_probe()
    pci_init_afu()
    cxl_pci_vphb_add()
    pcibios_scan_phb()
    pcibios_setup_phb_resources()

This removes the error message. We might have the case where the
first memory window on real PHB isn't populated properly because
of error in "ranges" property in the device-tree node. We can check
the device-tree instead for that. This also removes one unnecessary
blank line in the function.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v2: Removes the error message instead of avoiding it
---
 arch/powerpc/kernel/pci-common.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 74bec54..05bfdae 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1559,16 +1559,10 @@ static void pcibios_setup_phb_resources(struct pci_controller *hose,
 	/* Hookup PHB Memory resources */
 	for (i = 0; i < 3; ++i) {
 		res = &hose->mem_resources[i];
-		if (!res->flags) {
-			if (i == 0)
-				printk(KERN_ERR "PCI: Memory resource 0 not set for "
-				       "host bridge %s (domain %d)\n",
-				       hose->dn->full_name, hose->global_number);
+		if (!res->flags)
 			continue;
-		}
-		offset = hose->mem_offset[i];
-
 
+		offset = hose->mem_offset[i];
 		pr_debug("PCI: PHB MEM resource %d = %pR off 0x%08llx\n", i,
 			 res, (unsigned long long)offset);
 
-- 
2.7.4
