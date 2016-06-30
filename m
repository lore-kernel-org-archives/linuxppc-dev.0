Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgQnx6ZfxzDrQp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 03:02:29 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UGxIco026070
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 13:02:28 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uuhvae59-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 13:02:27 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 1 Jul 2016 03:02:24 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 301AF2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 03:02:22 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UH2Mcm32506012
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 03:02:22 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UH2LYQ004111
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 03:02:21 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, mikey <mikey@neuling.org>,
 tgrobeck <tgrobeck@us.ibm.com>
Subject: Re: [PATCH] cxl: Ignore CAPI adapters misplaced in switched slots
In-reply-to: <1467287137-25366-1-git-send-email-felix@linux.vnet.ibm.com>
References: <1467287137-25366-1-git-send-email-felix@linux.vnet.ibm.com>
Date: Fri, 01 Jul 2016 03:02:20 +1000
Message-Id: <1467305909-sup-4518@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Philippe - this looks like a decent solution to the problem (and
I intend to use this for the upcoming cx4 support as well).

Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Excerpts from Philippe Bergheaud's message of 2016-06-30 13:45:37 +0200:
> One should not attempt to switch a PHB into CAPI mode if there is
> a switch between the PHB and the adapter. This patch modifies the
> cxl driver to ignore CAPI adapters misplaced in switched slots.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> ---
> This patch fixes Bz 142217.
> 
>  drivers/misc/cxl/pci.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index a08fcc8..2f978ed 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1280,6 +1280,30 @@ static void cxl_pci_remove_adapter(struct cxl *adapter)
>      device_unregister(&adapter->dev);
>  }
>  
> +#define CXL_MAX_PCIEX_PARENT 2
> +
> +static int cxl_slot_is_switched(struct pci_dev *dev)
> +{
> +    struct device_node *np;
> +    int depth = 0;
> +    const __be32 *prop;
> +
> +    if (!(np = pci_device_to_OF_node(dev))) {
> +        pr_err("cxl: np = NULL\n");
> +        return -ENODEV;
> +    }
> +    of_node_get(np);
> +    while (np) {
> +        np = of_get_next_parent(np);
> +        prop = of_get_property(np, "device_type", NULL);
> +        if (!prop || strcmp((char *)prop, "pciex"))
> +            break;
> +        depth++;
> +    }
> +    of_node_put(np);
> +    return (depth > CXL_MAX_PCIEX_PARENT);
> +}
> +
>  static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
>      struct cxl *adapter;
> @@ -1291,6 +1315,11 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
>          return -ENODEV;
>      }
>  
> +    if (cxl_slot_is_switched(dev)) {
> +        dev_dbg(&dev->dev, "cxl_init_adapter: Ignoring switched slot device\n");
> +        return -ENODEV;
> +    }
> +
>      if (cxl_verbose)
>          dump_cxl_config_space(dev);
>  
