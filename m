Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 650FA2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 18:47:16 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 31 Jul 2013 02:47:14 -0600
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A6C8638C8045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 04:47:08 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6V8lABU097408
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 04:47:10 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6V8l90C014073
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 05:47:09 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] powerpc/powernv: Fetch PHB bus range from dev-tree
Date: Wed, 31 Jul 2013 16:47:01 +0800
Message-Id: <1375260424-20777-2-git-send-email-shangw@linux.vnet.ibm.com>
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

The patch enables fetching bus range from device-tree for the
specific PHB. If we can't get that from device-tree, the default
range [0 255] will be used.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9cccdc7..f472228 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1109,6 +1109,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	unsigned long size, m32map_off, iomap_off, pemap_off;
 	const u64 *prop64;
 	const u32 *prop32;
+	int len;
 	u64 phb_id;
 	void *aux;
 	long rc;
@@ -1140,9 +1141,15 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	}
 
 	spin_lock_init(&phb->lock);
-	/* XXX Use device-tree */
-	hose->first_busno = 0;
-	hose->last_busno = 0xff;
+	prop32 = of_get_property(np, "bus-range", &len);
+	if (prop32 && len == 8) {
+		hose->first_busno = prop32[0];
+		hose->last_busno = prop32[1];
+	} else {
+		pr_warn("  Broken <bus-range> on %s\n", np->full_name);
+		hose->first_busno = 0;
+		hose->last_busno = 0xff;
+	}
 	hose->private_data = phb;
 	phb->hub_id = hub_id;
 	phb->opal_id = phb_id;
-- 
1.7.5.4
