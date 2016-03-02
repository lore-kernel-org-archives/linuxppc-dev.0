Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93E721A0B4C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 03:09:56 +1100 (AEDT)
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 2 Mar 2016 16:09:52 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id E248B2190023
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 16:09:33 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u22G9orx55836844
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 16:09:50 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u22G9nDj028741
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 09:09:50 -0700
Subject: Re: [PATCH] cxl: Ignore probes for virtual afu pci devices
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1456724453-10152-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Cc: mikey@neuling.org, Ian Munsie <imunsie@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56D7104C.2000708@linux.vnet.ibm.com>
Date: Wed, 2 Mar 2016 17:09:48 +0100
MIME-Version: 1.0
In-Reply-To: <1456724453-10152-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Vaibhav,

Looks ok to me.
Reviewed-by: fbarrat@linux.vnet.ibm.com

   Fred

Le 29/02/2016 06:40, Vaibhav Jain a écrit :
> Add a check at the beginning of cxl_probe function to ignore virtual pci
> devices created for each afu registered. This fixes the the errors
> messages logged about missing CXL vsec, when cxl probe is unable to
> find necessary vsec entries in device pci config space. The error
> message logged are of the form :
>
> cxl-pci 0004:00:00.0: ABORTING: CXL VSEC not found!
> cxl-pci 0004:00:00.0: cxl_init_adapter failed: -19
>
> Cc: Ian Munsie <imunsie@au1.ibm.com>
> Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>   drivers/misc/cxl/cxl.h  | 2 ++
>   drivers/misc/cxl/pci.c  | 5 +++++
>   drivers/misc/cxl/vphb.c | 9 +++++++++
>   3 files changed, 16 insertions(+)
>
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index a521bc7..68d39f5 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -764,4 +764,6 @@ unsigned int afu_poll(struct file *file, struct poll_table_struct *poll);
>   ssize_t afu_read(struct file *file, char __user *buf, size_t count, loff_t *off);
>   extern const struct file_operations afu_fops;
>
> +/* check if the given pci_dev is on the the cxl vphb bus */
> +bool cxl_pci_is_vphb_device(struct pci_dev *dev);
>   #endif
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 4c1903f..2f219c1 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1278,6 +1278,11 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
>   	int slice;
>   	int rc;
>
> +	if (cxl_pci_is_vphb_device(dev)) {
> +		dev_dbg(&dev->dev, "cxl_init_adapter: Ignoring cxl vphb device\n");
> +		return -ENODEV;
> +	}
> +
>   	if (cxl_verbose)
>   		dump_cxl_config_space(dev);
>
> diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
> index cbd4331..e76a42a 100644
> --- a/drivers/misc/cxl/vphb.c
> +++ b/drivers/misc/cxl/vphb.c
> @@ -296,6 +296,15 @@ void cxl_pci_vphb_remove(struct cxl_afu *afu)
>   	pcibios_free_controller(phb);
>   }
>
> +bool cxl_pci_is_vphb_device(struct pci_dev *dev)
> +{
> +	struct pci_controller *phb;
> +
> +	phb = pci_bus_to_host(dev->bus);
> +
> +	return (phb->ops == &cxl_pcie_pci_ops);
> +}
> +
>   struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev)
>   {
>   	struct pci_controller *phb;
>
