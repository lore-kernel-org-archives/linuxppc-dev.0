Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7BE422C00F5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 23:44:41 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 6 May 2013 09:44:38 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 4C96DC90028
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 09:44:35 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r46DiZZb290254
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 May 2013 09:44:35 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r46DiWvV012346
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 May 2013 07:44:34 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH 3/3] powerpc/powernv: Don't configure IO window on PHB3
Date: Mon,  6 May 2013 21:44:18 +0800
Message-Id: <1367847858-6506-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1367847858-6506-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1367847858-6506-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, yinghai@kernel.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We needn't configure IO windows for the corresponding PEs on PHB3
since that doesn't support IO.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 0c3fa29..b4f3edb 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -894,7 +894,9 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
 		    res->start > res->end)
 			continue;
 
-		if (res->flags & IORESOURCE_IO) {
+		/* We needn't setup IO windows for PHB3 */
+		if (!(pe->pbus->bus_flags & PCI_BUS_FLAGS_NO_IO) &&
+		    res->flags & IORESOURCE_IO) {
 			region.start = res->start - phb->ioda.io_pci_base;
 			region.end   = res->end - phb->ioda.io_pci_base;
 			index = region.start / phb->ioda.io_segsize;
-- 
1.7.5.4
