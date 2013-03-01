Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1DCEC2C03A3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 01:18:07 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 1 Mar 2013 07:18:02 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 805BD19D8046
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 07:17:56 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r21EHumY364158
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 07:17:56 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r21EHqVg002401
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 07:17:52 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/22] powerpc/eeh: I/O chip post initialization
Date: Fri,  1 Mar 2013 22:17:11 +0800
Message-Id: <1362147440-14096-14-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/eeh-ioda.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index ee1b538..38c1efe 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -42,8 +42,25 @@
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
+	phb->eeh_enabled = 1;
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
