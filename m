Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4B0BB2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 19:03:36 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 15 Jun 2013 05:03:34 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id E6C97C90026
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 05:03:29 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5F93UIA60358776
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 05:03:30 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5F93TN1026088
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 06:03:30 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/27] powerpc/eeh: I/O chip post initialization
Date: Sat, 15 Jun 2013 17:03:04 +0800
Message-Id: <1371286998-2842-14-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The post initialization (struct eeh_ops::post_init) is called after
the EEH probe is done. On the other hand, the EEH core post
initialization is designed to call platform and then I/O chip backend
on PowerNV platform.

The patch adds the backend for I/O chip to notify the platform
that the specific PHB is ready to supply EEH service.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index b9564d5..60ac8fe 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -34,8 +34,27 @@
 #include "powernv.h"
 #include "pci.h"
 
+/**
+ * ioda_eeh_post_init - Chip dependent post initialization
+ * @hose: PCI controller
+ *
+ * The function will be called after eeh PEs and devices
+ * have been built. That means the EEH is ready to supply
+ * service with I/O cache.
+ */
+static int ioda_eeh_post_init(struct pci_controller *hose)
+{
+	struct pnv_phb *phb = hose->private_data;
+
+	/* FIXME: Enable it for PHB3 later */
+	if (phb->type == PNV_PHB_IODA1)
+		phb->eeh_enabled = 1;
+
+	return 0;
+}
+
 struct pnv_eeh_ops ioda_eeh_ops = {
-	.post_init		= NULL,
+	.post_init		= ioda_eeh_post_init,
 	.set_option		= NULL,
 	.get_state		= NULL,
 	.reset			= NULL,
-- 
1.7.5.4
