Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7DBC42C009E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 12:45:13 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 19 Dec 2013 18:45:10 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 238713E40055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 18:45:08 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBK1j5Lk9175546
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 02:45:05 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBK1j7sn026750
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 18:45:07 -0700
Received: from shangw (shangw.cn.ibm.com [9.125.213.121])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with SMTP id
 rBK1j6lr026673
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 18:45:07 -0700
Date: Fri, 20 Dec 2013 09:45:04 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powernv: eeh: add buffer for P7IOC hub error data
Message-ID: <20131220014504.GB10795@shangw.(null)>
References: <20131219231853.GB22418@oc3347516403.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131219231853.GB22418@oc3347516403.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 19, 2013 at 05:18:53PM -0600, Brian W Hart wrote:
>Prevent ioda_eeh_hub_diag() from clobbering itself when called by supplying
>a buffer for P7IOC hub diagnostic data.  Take care to inform OPAL of the
>correct size for the buffer.
>
>Signed-off-by: Brian W Hart <hartb@linux.vnet.ibm.com>
>---
>
>I hope I've understood this correctly.  It looks to me like
>ioda_eeh_hub_data is effectively asking OPAL to clobber its own
>text (via 'data') when it makes the call to retrieve the hub data.
>

Yeah, we should have used following variable as HUB diag-data instead.

static char *hub_diag = NULL;

However, it's not safe to allocate page-sized buffer for "hub_diag".

>Added a hub diagnostic structure per-phb.  Perhaps the diagnostic
>structure better belongs in the phb->diag union, but I wasn't sure whether
>we'd need to carry the hub and PHB diag data at the same time.
>

Please put hub diag-data to struct pnv_phb::diag since we don't need
carry hub and PHB diag-data at same time. With it, please remove
variable "hub_diag" as well.

> arch/powerpc/platforms/powernv/eeh-ioda.c | 4 ++--
> arch/powerpc/platforms/powernv/pci.h      | 2 ++
> 2 files changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
>index 8184ef5..dfd9134 100644
>--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
>+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
>@@ -636,8 +636,8 @@ static void ioda_eeh_hub_diag(struct pci_controller *hose)
> 	struct OpalIoP7IOCErrorData *data;
> 	long rc;
>
>-	data = (struct OpalIoP7IOCErrorData *)ioda_eeh_hub_diag;
>-	rc = opal_pci_get_hub_diag_data(phb->hub_id, data, PAGE_SIZE);
>+	data = (struct OpalIoP7IOCErrorData *)&phb->p7ioc_err;
>+	rc = opal_pci_get_hub_diag_data(phb->hub_id, data, sizeof *data);
> 	if (rc != OPAL_SUCCESS) {
> 		pr_warning("%s: Failed to get HUB#%llx diag-data (%ld)\n",
> 			   __func__, phb->hub_id, rc);
>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>index 911c24e..d1b6d8c 100644
>--- a/arch/powerpc/platforms/powernv/pci.h
>+++ b/arch/powerpc/platforms/powernv/pci.h
>@@ -177,6 +177,8 @@ struct pnv_phb {
> 		unsigned char			blob[PNV_PCI_DIAG_BUF_SIZE];
> 		struct OpalIoP7IOCPhbErrorData	p7ioc;
> 	} diag;
>+
>+	struct OpalIoP7IOCErrorData p7ioc_err;
> };
>
> extern struct pci_ops pnv_pci_ops;

Thanks,
Gavin
