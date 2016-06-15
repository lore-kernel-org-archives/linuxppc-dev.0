Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVKzB0TpCzDqlR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 07:53:57 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5FLnHEw067087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 17:53:56 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23jgmpdj4h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 17:53:55 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 16 Jun 2016 07:53:53 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B469D2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 07:53:50 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5FLro6A14745620
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 07:53:50 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5FLro1v006370
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 07:53:50 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: mikey <mikey@neuling.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] cxl: Make vPHB device node match adapter's
In-reply-to: <1466001736-3074-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1466001736-3074-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Thu, 16 Jun 2016 07:53:49 +1000
Message-Id: <1466027386-sup-9561@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This could probably use a description in the commit message, perhaps
including output showing the before/after difference this makes to
lsvpd, but otherwise it looks fine to me.

@Mikey - this look OK to you?

Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Excerpts from Frederic Barrat's message of 2016-06-15 16:42:16 +0200:
> Tested by cxlflash on bare-metal and powerVM.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/vphb.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
> index cdc7723..012b6aa 100644
> --- a/drivers/misc/cxl/vphb.c
> +++ b/drivers/misc/cxl/vphb.c
> @@ -208,20 +208,19 @@ static struct pci_controller_ops cxl_pci_controller_ops =
>  
>  int cxl_pci_vphb_add(struct cxl_afu *afu)
>  {
> -    struct pci_dev *phys_dev;
> -    struct pci_controller *phb, *phys_phb;
> +    struct pci_controller *phb;
>      struct device_node *vphb_dn;
>      struct device *parent;
>  
> -    if (cpu_has_feature(CPU_FTR_HVMODE)) {
> -        phys_dev = to_pci_dev(afu->adapter->dev.parent);
> -        phys_phb = pci_bus_to_host(phys_dev->bus);
> -        vphb_dn = phys_phb->dn;
> -        parent = &phys_dev->dev;
> -    } else {
> -        vphb_dn = afu->adapter->dev.parent->of_node;
> -        parent = afu->adapter->dev.parent;
> -    }
> +    /* The parent device is the adapter. Reuse the device node of
> +     * the adapter.
> +     * We don't seem to care what device node is used for the vPHB,
> +     * but tools such as lsvpd walk up the device parents looking
> +     * for a valid location code, so we might as well show devices
> +     * attached to the adapter as being located on that adapter.
> +     */
> +    parent = afu->adapter->dev.parent;
> +    vphb_dn = parent->of_node;
>  
>      /* Alloc and setup PHB data structure */
>      phb = pcibios_alloc_controller(vphb_dn);
