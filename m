Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406YWL547VzF1xV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 04:26:54 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2MHQhVH120665
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:26:52 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gvghg90nm-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:26:52 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 17:26:49 -0000
Subject: Re: [PATCH v2 19/38] cxlflash: Support AFU state toggling
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1519683513-16731-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1519683763-17438-1-git-send-email-ukrishn@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 22 Mar 2018 18:26:46 +0100
MIME-Version: 1.0
In-Reply-To: <1519683763-17438-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <06297d09-4dfa-1269-3fe1-a6971731e1fb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 26/02/2018 à 23:22, Uma Krishnan a écrit :
> The AFU should be enabled following a successful configuration and
> disabled near the end of the cleanup path.
> 
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
> Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> ---

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   drivers/scsi/cxlflash/ocxl_hw.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
> index 67f0252..364e7a5 100644
> --- a/drivers/scsi/cxlflash/ocxl_hw.c
> +++ b/drivers/scsi/cxlflash/ocxl_hw.c
> @@ -342,12 +342,18 @@ static void ocxlflash_unconfig_afu(struct ocxl_hw_afu *afu)
>   static void ocxlflash_destroy_afu(void *afu_cookie)
>   {
>   	struct ocxl_hw_afu *afu = afu_cookie;
> +	int pos;
> 
>   	if (!afu)
>   		return;
> 
>   	ocxlflash_release_context(afu->ocxl_ctx);
>   	idr_destroy(&afu->idr);
> +
> +	/* Disable the AFU */
> +	pos = afu->acfg.dvsec_afu_control_pos;
> +	ocxl_config_set_afu_state(afu->pdev, pos, 0);
> +
>   	ocxlflash_unconfig_afu(afu);
>   	kfree(afu);
>   }
> @@ -492,6 +498,9 @@ static int ocxlflash_config_afu(struct pci_dev *pdev, struct ocxl_hw_afu *afu)
>   			__func__, rc);
>   		goto out;
>   	}
> +
> +	/* Enable the AFU */
> +	ocxl_config_set_afu_state(pdev, acfg->dvsec_afu_control_pos, 1);
>   out:
>   	return rc;
>   }
> 
