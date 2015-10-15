Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17C491A0681
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 15:23:38 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DBF01140180
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 15:23:37 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 15 Oct 2015 14:23:36 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 59E1F2CE8050
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 15:23:34 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9F4NPgS63438848
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 15:23:34 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9F4N1aX008888
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 15:23:01 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/eeh: Fix recursive fenced PHB on Broadcom shiner
 adapter
Date: Thu, 15 Oct 2015 15:22:35 +1100
Message-Id: <1444882955-27601-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Similar to commit b6541db ("powerpc/eeh: Block PCI config access
upon frozen PE"), this blocks the PCI config space of Broadcom
Shiner adapter until PE reset is completed, to avoid recursive
fenced PHB when dumping PCI config registers during the period
of error recovery.

   ~# lspci -ns 0003:03:00.0
   0003:03:00.0 0200: 14e4:168a (rev 10)
   ~# lspci -s 0003:03:00.0
   0003:03:00.0 Ethernet controller: Broadcom Corporation \
                NetXtreme II BCM57800 1/10 Gigabit Ethernet (rev 10)

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 3bb6acb..9819e34 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -443,11 +443,14 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
 	 * that PE to block its config space.
 	 *
 	 * Broadcom Austin 4-ports NICs (14e4:1657)
+	 * Broadcom Shiner 4-ports 1G NICs (14e4:168a)
 	 * Broadcom Shiner 2-ports 10G NICs (14e4:168e)
 	 */
 	if ((pdn->vendor_id == PCI_VENDOR_ID_BROADCOM &&
 	     pdn->device_id == 0x1657) ||
 	    (pdn->vendor_id == PCI_VENDOR_ID_BROADCOM &&
+	     pdn->device_id == 0x168a) ||
+	    (pdn->vendor_id == PCI_VENDOR_ID_BROADCOM &&
 	     pdn->device_id == 0x168e))
 		edev->pe->state |= EEH_PE_CFG_RESTRICTED;
 
-- 
2.1.0
