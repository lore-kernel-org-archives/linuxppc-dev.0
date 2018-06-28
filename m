Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41GxLy6Y1czF1Rv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 09:48:58 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5SNiYU9069513
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 19:48:57 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jw7jnmewh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 19:48:56 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 29 Jun 2018 00:48:54 +0100
Subject: Re: [PATCH v2 04/10] Revert "cxl: Add kernel APIs to get & set the
 max irqs per context"
To: Frederic Barrat <fbarrat@linux.ibm.com>, alastair@au1.ibm.com,
 vaibhav@linux.ibm.com, clombard@linux.ibm.com, felix@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: huyn@mellanox.com
References: <20180628100509.17413-1-fbarrat@linux.ibm.com>
 <20180628100509.17413-5-fbarrat@linux.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 29 Jun 2018 09:48:48 +1000
MIME-Version: 1.0
In-Reply-To: <20180628100509.17413-5-fbarrat@linux.ibm.com>
Message-Id: <48036124-a7ad-84cf-0f5d-e3f2eb3de99c@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28/06/18 20:05, Frederic Barrat wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Remove abandonned capi support for the Mellanox CX4.
> 
> This reverts commit 79384e4b71240abf50c375eea56060b0d79c242a.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   drivers/misc/cxl/api.c | 27 ---------------------------
>   1 file changed, 27 deletions(-)
> 
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index 34ba67bc41bd..a535c1e6aa92 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -552,30 +552,3 @@ ssize_t cxl_read_adapter_vpd(struct pci_dev *dev, void *buf, size_t count)
>   	return cxl_ops->read_adapter_vpd(afu->adapter, buf, count);
>   }
>   EXPORT_SYMBOL_GPL(cxl_read_adapter_vpd);
> -
> -int cxl_set_max_irqs_per_process(struct pci_dev *dev, int irqs)
> -{
> -	struct cxl_afu *afu = cxl_pci_to_afu(dev);
> -	if (IS_ERR(afu))
> -		return -ENODEV;
> -
> -	if (irqs > afu->adapter->user_irqs)
> -		return -EINVAL;
> -
> -	/* Limit user_irqs to prevent the user increasing this via sysfs */
> -	afu->adapter->user_irqs = irqs;
> -	afu->irqs_max = irqs;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(cxl_set_max_irqs_per_process);
> -
> -int cxl_get_max_irqs_per_process(struct pci_dev *dev)
> -{
> -	struct cxl_afu *afu = cxl_pci_to_afu(dev);
> -	if (IS_ERR(afu))
> -		return -ENODEV;
> -
> -	return afu->irqs_max;
> -}
> -EXPORT_SYMBOL_GPL(cxl_get_max_irqs_per_process);
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
