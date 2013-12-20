Return-Path: <hartb@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 47A272C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 06:06:10 +1100 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hartb@linux.vnet.ibm.com>;
 Fri, 20 Dec 2013 12:06:07 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 9356D1FF0028
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 12:05:40 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBKJ652U61669522
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 20:06:05 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBKJ64mW008226
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 12:06:05 -0700
Received: from oc3347516403.ibm.com ([9.80.82.166])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 rBKJ61lG007918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 12:06:04 -0700
Date: Fri, 20 Dec 2013 13:06:01 -0600
From: Brian W Hart <hartb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powernv: eeh: add buffer for P7IOC hub error data
Message-ID: <20131220190601.GC5480@oc3347516403.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

V2: Replace driver-global 'hub_diag' with a per-PHB hub diag structure.

Prevent ioda_eeh_hub_diag() from clobbering itself when called by supplying
a per-PHB buffer for P7IOC hub diagnostic data.  Take care to inform OPAL of
the correct size for the buffer.

Signed-off-by: Brian W Hart <hartb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 15 ++-------------
 arch/powerpc/platforms/powernv/pci.h      |  4 +++-
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 8184ef5..4790275 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -36,7 +36,6 @@
 #include "powernv.h"
 #include "pci.h"
 
-static char *hub_diag = NULL;
 static int ioda_eeh_nb_init = 0;
 
 static int ioda_eeh_event(struct notifier_block *nb,
@@ -140,15 +139,6 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 		ioda_eeh_nb_init = 1;
 	}
 
-	/* We needn't HUB diag-data on PHB3 */
-	if (phb->type == PNV_PHB_IODA1 && !hub_diag) {
-		hub_diag = (char *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-		if (!hub_diag) {
-			pr_err("%s: Out of memory !\n", __func__);
-			return -ENOMEM;
-		}
-	}
-
 #ifdef CONFIG_DEBUG_FS
 	if (phb->dbgfs) {
 		debugfs_create_file("err_injct_outbound", 0600,
@@ -633,11 +623,10 @@ static void ioda_eeh_hub_diag_common(struct OpalIoP7IOCErrorData *data)
 static void ioda_eeh_hub_diag(struct pci_controller *hose)
 {
 	struct pnv_phb *phb = hose->private_data;
-	struct OpalIoP7IOCErrorData *data;
+	struct OpalIoP7IOCErrorData *data = &phb->diag.hub_diag;
 	long rc;
 
-	data = (struct OpalIoP7IOCErrorData *)ioda_eeh_hub_diag;
-	rc = opal_pci_get_hub_diag_data(phb->hub_id, data, PAGE_SIZE);
+	rc = opal_pci_get_hub_diag_data(phb->hub_id, data, sizeof *data);
 	if (rc != OPAL_SUCCESS) {
 		pr_warning("%s: Failed to get HUB#%llx diag-data (%ld)\n",
 			   __func__, phb->hub_id, rc);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 911c24e..1ed8d5f 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -172,11 +172,13 @@ struct pnv_phb {
 		} ioda;
 	};
 
-	/* PHB status structure */
+	/* PHB and hub status structure */
 	union {
 		unsigned char			blob[PNV_PCI_DIAG_BUF_SIZE];
 		struct OpalIoP7IOCPhbErrorData	p7ioc;
+		struct OpalIoP7IOCErrorData 	hub_diag;
 	} diag;
+
 };
 
 extern struct pci_ops pnv_pci_ops;
-- 
1.8.3.1
