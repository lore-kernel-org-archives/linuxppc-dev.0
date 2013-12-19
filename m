Return-Path: <hartb@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DE2542C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 10:19:07 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hartb@linux.vnet.ibm.com>;
 Thu, 19 Dec 2013 16:19:04 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 696131FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 16:18:37 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBJNIxt59634102
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 00:18:59 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rBJNM7BR016302
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 16:22:07 -0700
Received: from oc3347516403.ibm.com ([9.80.99.21])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 rBJNLx69015967
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 16:22:06 -0700
Date: Thu, 19 Dec 2013 17:18:53 -0600
From: Brian W Hart <hartb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powernv: eeh: add buffer for P7IOC hub error data
Message-ID: <20131219231853.GB22418@oc3347516403.ibm.com>
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

Prevent ioda_eeh_hub_diag() from clobbering itself when called by supplying
a buffer for P7IOC hub diagnostic data.  Take care to inform OPAL of the
correct size for the buffer.

Signed-off-by: Brian W Hart <hartb@linux.vnet.ibm.com>
---

I hope I've understood this correctly.  It looks to me like
ioda_eeh_hub_data is effectively asking OPAL to clobber its own
text (via 'data') when it makes the call to retrieve the hub data.

Added a hub diagnostic structure per-phb.  Perhaps the diagnostic
structure better belongs in the phb->diag union, but I wasn't sure whether
we'd need to carry the hub and PHB diag data at the same time.

 arch/powerpc/platforms/powernv/eeh-ioda.c | 4 ++--
 arch/powerpc/platforms/powernv/pci.h      | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 8184ef5..dfd9134 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -636,8 +636,8 @@ static void ioda_eeh_hub_diag(struct pci_controller *hose)
 	struct OpalIoP7IOCErrorData *data;
 	long rc;
 
-	data = (struct OpalIoP7IOCErrorData *)ioda_eeh_hub_diag;
-	rc = opal_pci_get_hub_diag_data(phb->hub_id, data, PAGE_SIZE);
+	data = (struct OpalIoP7IOCErrorData *)&phb->p7ioc_err;
+	rc = opal_pci_get_hub_diag_data(phb->hub_id, data, sizeof *data);
 	if (rc != OPAL_SUCCESS) {
 		pr_warning("%s: Failed to get HUB#%llx diag-data (%ld)\n",
 			   __func__, phb->hub_id, rc);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 911c24e..d1b6d8c 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -177,6 +177,8 @@ struct pnv_phb {
 		unsigned char			blob[PNV_PCI_DIAG_BUF_SIZE];
 		struct OpalIoP7IOCPhbErrorData	p7ioc;
 	} diag;
+
+	struct OpalIoP7IOCErrorData p7ioc_err;
 };
 
 extern struct pci_ops pnv_pci_ops;
-- 
1.8.3.1
