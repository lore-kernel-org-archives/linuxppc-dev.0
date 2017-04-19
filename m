Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w75pd5hd2zDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 12:40:57 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3J2eWoJ009772
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 22:40:47 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29wqpu8bj0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 22:40:47 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 12:40:45 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3J2eZW658917058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 12:40:43 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3J2e6cH032103
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 12:40:07 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Block PCI config access on BCM5719 during
 EEH recovery
Date: Wed, 19 Apr 2017 12:39:43 +1000
Message-Id: <1492569583-908-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Similar to what is done in commit b6541db13952 ("powerpc/eeh: Block
PCI config access upon frozen PE"), we need block PCI config access
for BCM5719 when recovering frozen error on them. Otherwise, an
unexpected recursive fenced PHB error is observed.

   0001:06:00.0 Ethernet controller: Broadcom Corporation \
                NetXtreme BCM5718 Gigabit Ethernet PCIe (rev 10)
   0001:06:00.1 Ethernet controller: Broadcom Corporation \
                NetXtreme BCM5718 Gigabit Ethernet PCIe (rev 10)

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 6fb5522..55a3c5f 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -412,11 +412,14 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
 	 * been set for the PE, we will set EEH_PE_CFG_BLOCKED for
 	 * that PE to block its config space.
 	 *
+	 * Broadcom BCM5718 2-ports NICs (14e4:1656)
 	 * Broadcom Austin 4-ports NICs (14e4:1657)
 	 * Broadcom Shiner 4-ports 1G NICs (14e4:168a)
 	 * Broadcom Shiner 2-ports 10G NICs (14e4:168e)
 	 */
 	if ((pdn->vendor_id == PCI_VENDOR_ID_BROADCOM &&
+	     pdn->device_id == 0x1656) ||
+	    (pdn->vendor_id == PCI_VENDOR_ID_BROADCOM &&
 	     pdn->device_id == 0x1657) ||
 	    (pdn->vendor_id == PCI_VENDOR_ID_BROADCOM &&
 	     pdn->device_id == 0x168a) ||
-- 
2.7.4
