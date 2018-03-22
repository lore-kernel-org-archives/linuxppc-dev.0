Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406WD145ZGzF1y5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 02:43:27 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2MFeYjk142305
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 11:43:24 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gve50msb4-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 11:43:22 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 15:43:20 -0000
Subject: Re: [PATCH v2 06/38] cxlflash: Read host function configuration
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1519683513-16731-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1519683641-16967-1-git-send-email-ukrishn@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 22 Mar 2018 16:43:15 +0100
MIME-Version: 1.0
In-Reply-To: <1519683641-16967-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <152ca9dd-ef12-8ba3-23a0-abbc532b7cf4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 26/02/2018 à 23:20, Uma Krishnan a écrit :
> Per the OCXL specification, the underlying host can have multiple AFUs
> per function with each function supporting its own configuration. The host
> function configuration is read on the initialization path to evaluate the
> number of functions present and identify the features and configuration of
> the functions present. This data is cached for use in later configuration
> steps. Note that for the OCXL hardware supported by the cxlflash driver,
> only one AFU per function is expected.
> 
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
> Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> ---

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   drivers/scsi/cxlflash/ocxl_hw.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   drivers/scsi/cxlflash/ocxl_hw.h |  2 ++
>   2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
> index e3a0a9b..dc32a73 100644
> --- a/drivers/scsi/cxlflash/ocxl_hw.c
> +++ b/drivers/scsi/cxlflash/ocxl_hw.c
> @@ -32,6 +32,35 @@ static void ocxlflash_destroy_afu(void *afu_cookie)
>   }
> 
>   /**
> + * ocxlflash_config_fn() - configure the host function
> + * @pdev:	PCI device associated with the host.
> + * @afu:	AFU associated with the host.
> + *
> + * Return: 0 on success, -errno on failure
> + */
> +static int ocxlflash_config_fn(struct pci_dev *pdev, struct ocxl_hw_afu *afu)
> +{
> +	struct ocxl_fn_config *fcfg = &afu->fcfg;
> +	struct device *dev = &pdev->dev;
> +	int rc = 0;
> +
> +	/* Read DVSEC config of the function */
> +	rc = ocxl_config_read_function(pdev, fcfg);
> +	if (unlikely(rc)) {
> +		dev_err(dev, "%s: ocxl_config_read_function failed rc=%d\n",
> +			__func__, rc);
> +		goto out;
> +	}
> +
> +	/* Only one AFU per function is supported by ocxlflash */
> +	if (fcfg->max_afu_index != 0)
> +		dev_warn(dev, "%s: Unexpected AFU index value %d\n",
> +			 __func__, fcfg->max_afu_index);
> +out:
> +	return rc;
> +}
> +
> +/**
>    * ocxlflash_create_afu() - create the AFU for OCXL
>    * @pdev:	PCI device associated with the host.
>    *
> @@ -41,6 +70,7 @@ static void *ocxlflash_create_afu(struct pci_dev *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct ocxl_hw_afu *afu;
> +	int rc;
> 
>   	afu = kzalloc(sizeof(*afu), GFP_KERNEL);
>   	if (unlikely(!afu)) {
> @@ -50,8 +80,19 @@ static void *ocxlflash_create_afu(struct pci_dev *pdev)
> 
>   	afu->pdev = pdev;
>   	afu->dev = dev;
> +
> +	rc = ocxlflash_config_fn(pdev, afu);
> +	if (unlikely(rc)) {
> +		dev_err(dev, "%s: Function configuration failed rc=%d\n",
> +			__func__, rc);
> +		goto err1;
> +	}
>   out:
>   	return afu;
> +err1:
> +	kfree(afu);
> +	afu = NULL;
> +	goto out;
>   }
> 
>   /* Backend ops to ocxlflash services */
> diff --git a/drivers/scsi/cxlflash/ocxl_hw.h b/drivers/scsi/cxlflash/ocxl_hw.h
> index c7e5c4d..658f420 100644
> --- a/drivers/scsi/cxlflash/ocxl_hw.h
> +++ b/drivers/scsi/cxlflash/ocxl_hw.h
> @@ -16,4 +16,6 @@
>   struct ocxl_hw_afu {
>   	struct pci_dev *pdev;		/* PCI device */
>   	struct device *dev;		/* Generic device */
> +
> +	struct ocxl_fn_config fcfg;	/* DVSEC config of the function */
>   };
> 
