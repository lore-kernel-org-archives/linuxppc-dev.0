Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 841492C0097
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 23:49:56 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 20 Aug 2012 09:49:53 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 5A58EC90052
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 09:49:50 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7KDnSBe31981720
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 09:49:28 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7KDnSvE031201
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 09:49:28 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/8] ppc/pnv: initialize DMA for PEs
Date: Mon, 20 Aug 2012 21:49:17 +0800
Message-Id: <1345470561-17785-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1345470561-17785-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1345470561-17785-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: weiyang@linux.vnet.ibm.com, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces additional wrapper function to call the original
implementation so that the DMA can be configured for all existing PEs.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
Reviewed-by: Richard Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 96cdc61..09deab2 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1242,10 +1242,20 @@ static void __devinit pnv_pci_ioda_setup_seg(void)
 	}
 }
 
+static void __devinit pnv_pci_ioda_setup_DMA(void)
+{
+	struct pci_controller *hose, *tmp;
+
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+		pnv_ioda_setup_dma(hose->private_data);
+	}
+}
+
 static void __devinit pnv_pci_ioda_fixup(void)
 {
 	pnv_pci_ioda_setup_PEs();
 	pnv_pci_ioda_setup_seg();
+	pnv_pci_ioda_setup_DMA();
 }
 
 /*
-- 
1.7.5.4
