Return-Path: <hartb@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A25512C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 10:14:21 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hartb@linux.vnet.ibm.com>;
 Thu, 19 Dec 2013 16:14:19 -0700
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 07720C90026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 18:14:15 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBJNEGaA8716792
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 23:14:16 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBJNEGDv026431
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 18:14:16 -0500
Received: from oc3347516403.ibm.com ([9.80.99.21])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 rBJNE8Z3025928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 18:14:16 -0500
Date: Thu, 19 Dec 2013 17:14:07 -0600
From: Brian W Hart <hartb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powernv: eeh: fix possible buffer overrun in
 ioda_eeh_phb_diag()
Message-ID: <20131219231407.GA22418@oc3347516403.ibm.com>
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

PHB diagnostic buffer may be smaller than PAGE_SIZE, especially when
PAGE_SIZE > 4KB.

Signed-off-by: Brian W Hart <hartb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 02245ce..8184ef5 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -820,14 +820,15 @@ static void ioda_eeh_phb_diag(struct pci_controller *hose)
 	struct OpalIoPhbErrorCommon *common;
 	long rc;
 
-	common = (struct OpalIoPhbErrorCommon *)phb->diag.blob;
-	rc = opal_pci_get_phb_diag_data2(phb->opal_id, common, PAGE_SIZE);
+	rc = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
+					 PNV_PCI_DIAG_BUF_SIZE);
 	if (rc != OPAL_SUCCESS) {
 		pr_warning("%s: Failed to get diag-data for PHB#%x (%ld)\n",
 			    __func__, hose->global_number, rc);
 		return;
 	}
 
+	common = (struct OpalIoPhbErrorCommon *)phb->diag.blob;
 	switch (common->ioType) {
 	case OPAL_PHB_ERROR_DATA_TYPE_P7IOC:
 		ioda_eeh_p7ioc_phb_diag(hose, common);
-- 
1.8.3.1
