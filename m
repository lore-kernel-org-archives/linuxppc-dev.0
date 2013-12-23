Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DAE972C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 12:33:44 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sun, 22 Dec 2013 18:33:41 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 771B838C8027
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Dec 2013 20:33:36 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBN1XcFj4194744
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 01:33:38 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBN1XcAk017292
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Dec 2013 20:33:38 -0500
Received: from shangw (shangw.cn.ibm.com [9.125.213.121])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with SMTP id
 rBN1XbYD017174
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Dec 2013 20:33:37 -0500
Date: Mon, 23 Dec 2013 09:33:33 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powernv: eeh: add buffer for P7IOC hub error data
Message-ID: <20131223013333.GA7199@shangw.(null)>
References: <20131220190601.GC5480@oc3347516403.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131220190601.GC5480@oc3347516403.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 20, 2013 at 01:06:01PM -0600, Brian W Hart wrote:
>V2: Replace driver-global 'hub_diag' with a per-PHB hub diag structure.
>
>Prevent ioda_eeh_hub_diag() from clobbering itself when called by supplying
>a per-PHB buffer for P7IOC hub diagnostic data.  Take care to inform OPAL of
>the correct size for the buffer.
>
>Signed-off-by: Brian W Hart <hartb@linux.vnet.ibm.com>

Acked-by: Gavin Shan <shangw@linux.vnet.ibm.com>

We also need backport it to stable kernel 3.11+

>---
> arch/powerpc/platforms/powernv/eeh-ioda.c | 15 ++-------------
> arch/powerpc/platforms/powernv/pci.h      |  4 +++-
> 2 files changed, 5 insertions(+), 14 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
>index 8184ef5..4790275 100644
>--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
>+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
>@@ -36,7 +36,6 @@
> #include "powernv.h"
> #include "pci.h"
>
>-static char *hub_diag = NULL;
> static int ioda_eeh_nb_init = 0;
>
> static int ioda_eeh_event(struct notifier_block *nb,
>@@ -140,15 +139,6 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
> 		ioda_eeh_nb_init = 1;
> 	}
>
>-	/* We needn't HUB diag-data on PHB3 */
>-	if (phb->type == PNV_PHB_IODA1 && !hub_diag) {
>-		hub_diag = (char *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
>-		if (!hub_diag) {
>-			pr_err("%s: Out of memory !\n", __func__);
>-			return -ENOMEM;
>-		}
>-	}
>-
> #ifdef CONFIG_DEBUG_FS
> 	if (phb->dbgfs) {
> 		debugfs_create_file("err_injct_outbound", 0600,
>@@ -633,11 +623,10 @@ static void ioda_eeh_hub_diag_common(struct OpalIoP7IOCErrorData *data)
> static void ioda_eeh_hub_diag(struct pci_controller *hose)
> {
> 	struct pnv_phb *phb = hose->private_data;
>-	struct OpalIoP7IOCErrorData *data;
>+	struct OpalIoP7IOCErrorData *data = &phb->diag.hub_diag;
> 	long rc;
>
>-	data = (struct OpalIoP7IOCErrorData *)ioda_eeh_hub_diag;
>-	rc = opal_pci_get_hub_diag_data(phb->hub_id, data, PAGE_SIZE);
>+	rc = opal_pci_get_hub_diag_data(phb->hub_id, data, sizeof *data);
> 	if (rc != OPAL_SUCCESS) {
> 		pr_warning("%s: Failed to get HUB#%llx diag-data (%ld)\n",
> 			   __func__, phb->hub_id, rc);
>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>index 911c24e..1ed8d5f 100644
>--- a/arch/powerpc/platforms/powernv/pci.h
>+++ b/arch/powerpc/platforms/powernv/pci.h
>@@ -172,11 +172,13 @@ struct pnv_phb {
> 		} ioda;
> 	};
>
>-	/* PHB status structure */
>+	/* PHB and hub status structure */
> 	union {
> 		unsigned char			blob[PNV_PCI_DIAG_BUF_SIZE];
> 		struct OpalIoP7IOCPhbErrorData	p7ioc;
>+		struct OpalIoP7IOCErrorData 	hub_diag;
> 	} diag;
>+
> };
>
> extern struct pci_ops pnv_pci_ops;

Thanks,
Gavin
