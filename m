Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1CEB32C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 18:47:15 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 31 Jul 2013 04:47:13 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3521338C8027
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 04:47:10 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6V8lBig079832
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 04:47:11 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6V8lA6o014144
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 05:47:11 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] powerpc/powernv: Pick up correct number of PEs
Date: Wed, 31 Jul 2013 16:47:03 +0800
Message-Id: <1375260424-20777-4-git-send-email-shangw@linux.vnet.ibm.com>
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

Usually, the property "ibm,opal-num-pes" of PHB dev-tree node
indicates the number of total PEs. If that property isn't existing
or valid, we should fall back to pick the correct number of total
PEs according to PHB type: IODA1 or IODA2.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 829047b..6386bb4 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1172,11 +1172,14 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 
 	/* Initialize more IODA stuff */
 	prop32 = of_get_property(np, "ibm,opal-num-pes", NULL);
-	if (!prop32)
-		phb->ioda.total_pe = 1;
-	else
+	if (prop32)
 		phb->ioda.total_pe = *prop32;
-
+	else if (phb->type == PNV_PHB_IODA1)
+		phb->ioda.total_pe = 128;
+	else if (phb->type == PNV_PHB_IODA2)
+		phb->ioda.total_pe = 256;
+	else
+		phb->ioda.total_pe = 1;
 	phb->ioda.m32_size = resource_size(&hose->mem_resources[0]);
 	/* FW Has already off top 64k of M32 space (MSI space) */
 	phb->ioda.m32_size += 0x10000;
-- 
1.7.5.4
