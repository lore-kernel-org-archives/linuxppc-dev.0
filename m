Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6A30F2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Dec 2013 12:29:53 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 25 Dec 2013 18:29:50 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6C70019D803E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 18:29:39 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBQ1Tg9u8061228
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Dec 2013 02:29:42 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBQ1Tkj3027600
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 18:29:46 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Remove unnecessary assignment
Date: Thu, 26 Dec 2013 09:29:40 +0800
Message-Id: <1388021380-11387-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't have IO ports on PHB3 and the assignment of variable
"iomap_off" on PHB3 is meaningless. The patch just removes the
unnecessary assignment to the variable. The code change should
have been part of commit c35d2a8c ("powerpc/powernv: Needn't IO
segment map for PHB3").

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index aea45fa..703cac9 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1144,7 +1144,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 {
 	struct pci_controller *hose;
 	struct pnv_phb *phb;
-	unsigned long size, m32map_off, iomap_off, pemap_off;
+	unsigned long size, m32map_off, pemap_off, iomap_off = 0;
 	const __be64 *prop64;
 	const __be32 *prop32;
 	int len;
@@ -1236,7 +1236,6 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	size = _ALIGN_UP(phb->ioda.total_pe / 8, sizeof(unsigned long));
 	m32map_off = size;
 	size += phb->ioda.total_pe * sizeof(phb->ioda.m32_segmap[0]);
-	iomap_off = size;
 	if (phb->type == PNV_PHB_IODA1) {
 		iomap_off = size;
 		size += phb->ioda.total_pe * sizeof(phb->ioda.io_segmap[0]);
-- 
1.7.10.4
