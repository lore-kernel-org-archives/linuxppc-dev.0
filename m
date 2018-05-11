Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40j7761bLHzF0Pl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 21:25:21 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4BBOjSE070787
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 07:25:19 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hwa2f0hs4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 07:25:19 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Fri, 11 May 2018 12:25:17 +0100
Subject: Re: [PATCH v3 1/2] cxl: Set the PBCQ Tunnel BAR register when
 enabling capi mode
To: Philippe Bergheaud <felix@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.ibm.com, benh@au1.ibm.com
References: <20180425110834.16048-1-felix@linux.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Fri, 11 May 2018 13:25:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180425110834.16048-1-felix@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d2d60c31-b987-6f13-0c4e-cf6ef5ed9e25@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 25/04/2018 à 13:08, Philippe Bergheaud a écrit :
> Skiboot used to set the default Tunnel BAR register value when capi mode
> was enabled. This approach was ok for the cxl driver, but prevented other
> drivers from choosing different values.
> 
> Skiboot versions > 5.11 will not set the default value any longer. This
> patch modifies the cxl driver to set/reset the Tunnel BAR register when
> entering/exiting the cxl mode, with pnv_pci_set_tunnel_bar().
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.ibm.com>
> Reviewed-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> ---

ok, so that should work with old skiboot (since we are re-writing the 
value already set) and new skiboot. Thanks!

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


> v2: Restrict tunnel bar setting to power9.
>      Do not fail cxl_configure_adapter() on tunnel bar setting error.
>      Log an info message instead, and continue configuring capi mode.
> 
> v3: No change.
> ---
>   drivers/misc/cxl/pci.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 83f1d08058fc..355c789406f7 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1742,6 +1742,10 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
>   	/* Required for devices using CAPP DMA mode, harmless for others */
>   	pci_set_master(dev);
>   
> +	if (cxl_is_power9())
> +		if (pnv_pci_set_tunnel_bar(dev, 0x00020000E0000000ull, 1))
> +			dev_info(&dev->dev, "Tunneled operations unsupported\n");
> +
>   	if ((rc = pnv_phb_to_cxl_mode(dev, adapter->native->sl_ops->capi_mode)))
>   		goto err;
>   
> @@ -1768,6 +1772,8 @@ static void cxl_deconfigure_adapter(struct cxl *adapter)
>   {
>   	struct pci_dev *pdev = to_pci_dev(adapter->dev.parent);
>   
> +	if (cxl_is_power9())
> +		pnv_pci_set_tunnel_bar(pdev, 0x00020000E0000000ull, 0);
>   	cxl_native_release_psl_err_irq(adapter);
>   	cxl_unmap_adapter_regs(adapter);
>   
> 
