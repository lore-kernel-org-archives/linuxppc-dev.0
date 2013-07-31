Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 57B092C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 18:47:16 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 31 Jul 2013 02:47:13 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 7A4DD1FF001C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 02:41:48 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6V8lBNp148940
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 02:47:11 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6V8l9ar030834
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 02:47:10 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] powerpc/powernv: Check primary PHB through ID
Date: Wed, 31 Jul 2013 16:47:02 +0800
Message-Id: <1375260424-20777-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1375260424-20777-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1375260424-20777-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The index of one specific PCI controller (struct pci_controller::
global_number) can tell that it's primary one or not. So we needn't
additional variable for that and just remove it.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index f472228..829047b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1104,7 +1104,6 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 				  u64 hub_id, int ioda_type)
 {
 	struct pci_controller *hose;
-	static int primary = 1;
 	struct pnv_phb *phb;
 	unsigned long size, m32map_off, iomap_off, pemap_off;
 	const u64 *prop64;
@@ -1164,8 +1163,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 		phb->model = PNV_PHB_MODEL_UNKNOWN;
 
 	/* Parse 32-bit and IO ranges (if any) */
-	pci_process_bridge_OF_ranges(phb->hose, np, primary);
-	primary = 0;
+	pci_process_bridge_OF_ranges(hose, np, !hose->global_number);
 
 	/* Get registers */
 	phb->regs = of_iomap(np, 0);
-- 
1.7.5.4
