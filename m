Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 523AD2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 12:35:50 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 19 Dec 2013 20:35:47 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 1974FC90041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 20:35:42 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBK1ZhVY6947274
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 01:35:43 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBK1ZhEV004470
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 20:35:43 -0500
Received: from shangw (shangw.cn.ibm.com [9.125.213.121])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with SMTP id
 rBK1Zg1j004419
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 20:35:42 -0500
Date: Fri, 20 Dec 2013 09:35:39 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powernv: eeh: fix possible buffer overrun in
 ioda_eeh_phb_diag()
Message-ID: <20131220013539.GA10795@shangw.(null)>
References: <20131219231407.GA22418@oc3347516403.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131219231407.GA22418@oc3347516403.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 19, 2013 at 05:14:07PM -0600, Brian W Hart wrote:
>PHB diagnostic buffer may be smaller than PAGE_SIZE, especially when
>PAGE_SIZE > 4KB.
>

I think you're talking about that PAGE_SIZE could be configured
to have variable size (e.g. 4KB). So it's not safe to pass PAGE_SIZE
to OPAL API opal_pci_get_phb_diag_data2(). Instead, we should pass
PNV_PCI_DIAG_BUF_SIZE and it makes sense to me :-)

Also, it needs to be backported to stable kernel as well.

>Signed-off-by: Brian W Hart <hartb@linux.vnet.ibm.com>

Acked-by: Gavin Shan <shangw@linux.vnet.ibm.com>

>---
> arch/powerpc/platforms/powernv/eeh-ioda.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
>index 02245ce..8184ef5 100644
>--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
>+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
>@@ -820,14 +820,15 @@ static void ioda_eeh_phb_diag(struct pci_controller *hose)
> 	struct OpalIoPhbErrorCommon *common;
> 	long rc;
>
>-	common = (struct OpalIoPhbErrorCommon *)phb->diag.blob;
>-	rc = opal_pci_get_phb_diag_data2(phb->opal_id, common, PAGE_SIZE);
>+	rc = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
>+					 PNV_PCI_DIAG_BUF_SIZE);
> 	if (rc != OPAL_SUCCESS) {
> 		pr_warning("%s: Failed to get diag-data for PHB#%x (%ld)\n",
> 			    __func__, hose->global_number, rc);
> 		return;
> 	}
>
>+	common = (struct OpalIoPhbErrorCommon *)phb->diag.blob;
> 	switch (common->ioType) {
> 	case OPAL_PHB_ERROR_DATA_TYPE_P7IOC:
> 		ioda_eeh_p7ioc_phb_diag(hose, common);

Thanks,
Gavin
