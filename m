Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE9DA2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 18:47:15 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 31 Jul 2013 02:47:13 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id ECFFF19D8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 02:46:59 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6V8lBeZ106152
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 02:47:11 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6V8lBIo027479
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 02:47:11 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] powerpc/powernv: Needn't IO segment map for PHB3
Date: Wed, 31 Jul 2013 16:47:04 +0800
Message-Id: <1375260424-20777-5-git-send-email-shangw@linux.vnet.ibm.com>
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

PHB3 doesn't support IO ports and we needn't IO segment map for that.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 6386bb4..147f9b7 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1190,22 +1190,23 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	phb->ioda.io_segsize = phb->ioda.io_size / phb->ioda.total_pe;
 	phb->ioda.io_pci_base = 0; /* XXX calculate this ? */
 
-	/* Allocate aux data & arrays
-	 *
-	 * XXX TODO: Don't allocate io segmap on PHB3
-	 */
+	/* Allocate aux data & arrays. We don't have IO ports on PHB3 */
 	size = _ALIGN_UP(phb->ioda.total_pe / 8, sizeof(unsigned long));
 	m32map_off = size;
 	size += phb->ioda.total_pe * sizeof(phb->ioda.m32_segmap[0]);
 	iomap_off = size;
-	size += phb->ioda.total_pe * sizeof(phb->ioda.io_segmap[0]);
+	if (phb->type == PNV_PHB_IODA1) {
+		iomap_off = size;
+		size += phb->ioda.total_pe * sizeof(phb->ioda.io_segmap[0]);
+	}
 	pemap_off = size;
 	size += phb->ioda.total_pe * sizeof(struct pnv_ioda_pe);
 	aux = alloc_bootmem(size);
 	memset(aux, 0, size);
 	phb->ioda.pe_alloc = aux;
 	phb->ioda.m32_segmap = aux + m32map_off;
-	phb->ioda.io_segmap = aux + iomap_off;
+	if (phb->type == PNV_PHB_IODA1)
+		phb->ioda.io_segmap = aux + iomap_off;
 	phb->ioda.pe_array = aux + pemap_off;
 	set_bit(0, phb->ioda.pe_alloc);
 
-- 
1.7.5.4
