Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2F8D72C030B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 18:24:25 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 30 May 2013 04:24:23 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 306B438C804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:20 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4U8OKSt268438
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:20 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4U8OJ97022747
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:20 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/23] powerpc/eeh: I/O chip post initialization
Date: Thu, 30 May 2013 16:23:55 +0800
Message-Id: <1369902245-5886-14-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
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
the EEH probe is done. On the other hand, the EEH core post initialization
is designed to call platform and then I/O chip backend on PowerNV
platform.

The patch adds the backend for I/O chip to notify the platform
the specific PHB is ready to supply EEH service.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index b344576..6640d4f 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -43,8 +43,27 @@
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
