Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ED4B62C0094
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 23:49:36 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 20 Aug 2012 09:49:33 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 765506E8068
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 09:49:30 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7KDnUXx162344
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 09:49:30 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7KDnTcD023644
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 10:49:29 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/8] ppc/pnv: fix overrunning segment tracing array
Date: Mon, 20 Aug 2012 21:49:19 +0800
Message-Id: <1345470561-17785-7-git-send-email-shangw@linux.vnet.ibm.com>
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

There're 2 arrays introduced to trace which PE has occupied the
corresponding resource (I/O or MMIO) segment. However, we didn't
allocate enough memory for them and that possiblly leads to PE
descriptor corruption.

The patch fixes that by allocating enough memory for those 2 arrays.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
Reviewed-by: Richard Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index adaef11..c856f90 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1411,9 +1411,9 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
 	/* Allocate aux data & arrays */
 	size = _ALIGN_UP(phb->ioda.total_pe / 8, sizeof(unsigned long));
 	m32map_off = size;
-	size += phb->ioda.total_pe;
+	size += phb->ioda.total_pe * sizeof(phb->ioda.m32_segmap[0]);
 	iomap_off = size;
-	size += phb->ioda.total_pe;
+	size += phb->ioda.total_pe * sizeof(phb->ioda.io_segmap[0]);
 	pemap_off = size;
 	size += phb->ioda.total_pe * sizeof(struct pnv_ioda_pe);
 	aux = alloc_bootmem(size);
-- 
1.7.5.4
