Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40MtXG1Y4KzF1qv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2018 19:58:54 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3D9wUkH017548
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2018 05:58:52 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2harpdctms-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2018 05:58:51 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Fri, 13 Apr 2018 10:58:49 +0100
Subject: Re: [PATCH] cxl: Set the PBCQ Tunnel BAR register when enabling capi
 mode
To: Philippe Bergheaud <felix@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.ibm.com, benh@au1.ibm.com
References: <20180412110642.26454-1-felix@linux.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Fri, 13 Apr 2018 11:58:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180412110642.26454-1-felix@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7dd566a4-cc8c-f42a-964a-ea134b534704@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 12/04/2018 à 13:06, Philippe Bergheaud a écrit :
> Skiboot used to set the default Tunnel BAR register value when capi mode
> was enabled. This approach was ok for the cxl driver, but prevented other
> drivers from choosing different values.
> 
> Skiboot versions > 5.11 will not set the default value any longer. This
> patch modifies the cxl driver to set/reset the Tunnel BAR register when
> entering/exiting the cxl mode, with pnv_pci_set_tunnel_bar().
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.ibm.com>
> ---
>   drivers/misc/cxl/pci.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 83f1d08058fc..3beff9188446 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1742,6 +1742,9 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
>   	/* Required for devices using CAPP DMA mode, harmless for others */
>   	pci_set_master(dev);
>   
> +	if ((rc = pnv_pci_set_tunnel_bar(dev, 0x00020000E0000000ull, 1)))
> +		goto err;
> +


Isn't that call going to fail on older skiboot which don't support 
OPAL_PCI_SET_PBCQ_TUNNEL_BAR, i.e. on p8?

   Fred


>   	if ((rc = pnv_phb_to_cxl_mode(dev, adapter->native->sl_ops->capi_mode)))
>   		goto err;
>   
> @@ -1768,6 +1771,7 @@ static void cxl_deconfigure_adapter(struct cxl *adapter)
>   {
>   	struct pci_dev *pdev = to_pci_dev(adapter->dev.parent);
>   
> +	pnv_pci_set_tunnel_bar(pdev, 0x00020000E0000000ull, 0);
>   	cxl_native_release_psl_err_irq(adapter);
>   	cxl_unmap_adapter_regs(adapter);
>   
> 
