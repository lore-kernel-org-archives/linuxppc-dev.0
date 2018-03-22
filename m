Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406WsS0mmJzF1w9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 03:12:27 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2MGC13A021219
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 12:12:25 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gvf88sx7t-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 12:12:24 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 16:12:22 -0000
Subject: Re: [PATCH v2 09/38] cxlflash: Setup AFU acTag range
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1519683513-16731-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1519683669-17075-1-git-send-email-ukrishn@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 22 Mar 2018 17:12:20 +0100
MIME-Version: 1.0
In-Reply-To: <1519683669-17075-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b0be258d-071f-667a-8f56-c132f0cfd304@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 26/02/2018 à 23:21, Uma Krishnan a écrit :
> The OCXL specification supports distributing acTags amongst different
> AFUs and functions on the link. As cxlflash devices are expected to only
> support a single AFU and function, the entire range that was assigned to
> the function is also assigned to the AFU.
> 
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
> Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> ---

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

>   drivers/scsi/cxlflash/ocxl_hw.c | 13 +++++++++++++
>   drivers/scsi/cxlflash/ocxl_hw.h |  2 ++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
> index 2325030..d01847d9 100644
> --- a/drivers/scsi/cxlflash/ocxl_hw.c
> +++ b/drivers/scsi/cxlflash/ocxl_hw.c
> @@ -89,6 +89,9 @@ static int ocxlflash_config_afu(struct pci_dev *pdev, struct ocxl_hw_afu *afu)
>   	struct ocxl_afu_config *acfg = &afu->acfg;
>   	struct ocxl_fn_config *fcfg = &afu->fcfg;
>   	struct device *dev = &pdev->dev;
> +	int count;
> +	int base;
> +	int pos;
>   	int rc = 0;
> 
>   	/* Read AFU config at index 0 */
> @@ -98,6 +101,16 @@ static int ocxlflash_config_afu(struct pci_dev *pdev, struct ocxl_hw_afu *afu)
>   			__func__, rc);
>   		goto out;
>   	}
> +
> +	/* Only one AFU per function is supported, so actag_base is same */
> +	base = afu->fn_actag_base;
> +	count = min_t(int, acfg->actag_supported, afu->fn_actag_enabled);
> +	pos = acfg->dvsec_afu_control_pos;
> +
> +	ocxl_config_set_afu_actag(pdev, pos, base, count);
> +	dev_dbg(dev, "%s: acTag base=%d enabled=%d\n", __func__, base, count);
> +	afu->afu_actag_base = base;
> +	afu->afu_actag_enabled = count;
>   out:
>   	return rc;
>   }
> diff --git a/drivers/scsi/cxlflash/ocxl_hw.h b/drivers/scsi/cxlflash/ocxl_hw.h
> index f6af247..9c675fa 100644
> --- a/drivers/scsi/cxlflash/ocxl_hw.h
> +++ b/drivers/scsi/cxlflash/ocxl_hw.h
> @@ -22,4 +22,6 @@ struct ocxl_hw_afu {
> 
>   	int fn_actag_base;		/* Function acTag base */
>   	int fn_actag_enabled;		/* Function acTag number enabled */
> +	int afu_actag_base;		/* AFU acTag base */
> +	int afu_actag_enabled;		/* AFU acTag number enabled */
>   };
> 
