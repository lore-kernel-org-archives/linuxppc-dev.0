Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406WnP6ch0zF1wh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 03:08:57 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2MG8jXh041441
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 12:08:53 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gve4gwm3v-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 12:08:52 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 16:08:41 -0000
Subject: Re: [PATCH v2 08/38] cxlflash: Read host AFU configuration
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1519683513-16731-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1519683660-17039-1-git-send-email-ukrishn@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 22 Mar 2018 17:08:37 +0100
MIME-Version: 1.0
In-Reply-To: <1519683660-17039-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3e9e68ae-d1d3-9ba6-75d8-f4d8a3e3c407@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 26/02/2018 à 23:21, Uma Krishnan a écrit :
> The host AFU configuration is read on the initialization path to identify
> the features and configuration of the AFU. This data is cached for use in
> later configuration steps.
> 
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
> Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> ---
>   drivers/scsi/cxlflash/ocxl_hw.c | 34 ++++++++++++++++++++++++++++++++++
>   drivers/scsi/cxlflash/ocxl_hw.h |  1 +
>   2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
> index 39cccb7..2325030 100644
> --- a/drivers/scsi/cxlflash/ocxl_hw.c
> +++ b/drivers/scsi/cxlflash/ocxl_hw.c
> @@ -76,6 +76,33 @@ static int ocxlflash_config_fn(struct pci_dev *pdev, struct ocxl_hw_afu *afu)
>   }
> 
>   /**
> + * ocxlflash_config_afu() - configure the host AFU
> + * @pdev:	PCI device associated with the host.
> + * @afu:	AFU associated with the host.
> + *
> + * Must be called _after_ host function configuration.
> + *
> + * Return: 0 on success, -errno on failure
> + */
> +static int ocxlflash_config_afu(struct pci_dev *pdev, struct ocxl_hw_afu *afu)
> +{
> +	struct ocxl_afu_config *acfg = &afu->acfg;
> +	struct ocxl_fn_config *fcfg = &afu->fcfg;
> +	struct device *dev = &pdev->dev;
> +	int rc = 0;
> +
> +	/* Read AFU config at index 0 */
> +	rc = ocxl_config_read_afu(pdev, fcfg, acfg, 0);


Looking at other patches around this one, there's really the assumption 
that we have only one AFU (which is fine). So similar to another 
comment, we could harden that the AFU image really looks like what we 
expect. Here, we read the config at index 0. Just a suggestion that 
ocxl_fn_config gives you the maximum index of AFUs for the function
	ocxl_fn_config->max_afu_index

So it should be 0 for cxlflash.

   Fred


> +	if (unlikely(rc)) {
> +		dev_err(dev, "%s: ocxl_config_read_afu failed rc=%d\n",
> +			__func__, rc);
> +		goto out;
> +	}
> +out:
> +	return rc;
> +}
> +
> +/**
>    * ocxlflash_create_afu() - create the AFU for OCXL
>    * @pdev:	PCI device associated with the host.
>    *
> @@ -102,6 +129,13 @@ static void *ocxlflash_create_afu(struct pci_dev *pdev)
>   			__func__, rc);
>   		goto err1;
>   	}
> +
> +	rc = ocxlflash_config_afu(pdev, afu);
> +	if (unlikely(rc)) {
> +		dev_err(dev, "%s: AFU configuration failed rc=%d\n",
> +			__func__, rc);
> +		goto err1;
> +	}
>   out:
>   	return afu;
>   err1:
> diff --git a/drivers/scsi/cxlflash/ocxl_hw.h b/drivers/scsi/cxlflash/ocxl_hw.h
> index 190d71a..f6af247 100644
> --- a/drivers/scsi/cxlflash/ocxl_hw.h
> +++ b/drivers/scsi/cxlflash/ocxl_hw.h
> @@ -18,6 +18,7 @@ struct ocxl_hw_afu {
>   	struct device *dev;		/* Generic device */
> 
>   	struct ocxl_fn_config fcfg;	/* DVSEC config of the function */
> +	struct ocxl_afu_config acfg;	/* AFU configuration data */
> 
>   	int fn_actag_base;		/* Function acTag base */
>   	int fn_actag_enabled;		/* Function acTag number enabled */
> 
