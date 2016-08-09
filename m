Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7yZf0JJkzDqdv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 01:17:45 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u79FE5O7129076
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 11:17:44 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24na7h145w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 11:17:43 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Tue, 9 Aug 2016 09:17:42 -0600
Subject: Re: [PATCH] cxl: Set psl_fir_cntl to production environment value
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
References: <1470650268-25085-1-git-send-email-fbarrat@linux.vnet.ibm.com>
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Date: Tue, 9 Aug 2016 10:17:35 -0500
MIME-Version: 1.0
In-Reply-To: <1470650268-25085-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <20371186-2e15-a80e-2cff-090185fba4fa@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

On 8/8/2016 4:57 AM, Frederic Barrat wrote:
> Switch the setting of psl_fir_cntl from debug to production
> environment recommended value. It mostly affects the PSL behavior when
> an error is raised in psl_fir1/2.
>
> Tested with cxlflash.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/pci.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index d152e2d..4be25c4 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -379,7 +379,7 @@ static int calc_capp_routing(struct pci_dev *dev, u64 *chipid, u64 *capp_unit_id
>
>  static int init_implementation_adapter_psl_regs(struct cxl *adapter, struct pci_dev *dev)
>  {
> -	u64 psl_dsnctl;
> +	u64 psl_dsnctl, psl_fircntl;
>  	u64 chipid;
>  	u64 capp_unit_id;
>  	int rc;
> @@ -398,8 +398,11 @@ static int init_implementation_adapter_psl_regs(struct cxl *adapter, struct pci_
>  	cxl_p1_write(adapter, CXL_PSL_RESLCKTO, 0x20000000200ULL);
>  	/* snoop write mask */
>  	cxl_p1_write(adapter, CXL_PSL_SNWRALLOC, 0x00000000FFFFFFFFULL);
> -	/* set fir_accum */
> -	cxl_p1_write(adapter, CXL_PSL_FIR_CNTL, 0x0800000000000000ULL);
> +	/* set fir_cntl to recommended value for production env */
> +	psl_fircntl = (0x2ULL << (63-3)); /* ce_report */
> +	psl_fircntl |= (0x1ULL << (63-6)); /* FIR_report */
> +	psl_fircntl |= 0x1ULL; /* ce_thresh */
> +	cxl_p1_write(adapter, CXL_PSL_FIR_CNTL, psl_fircntl);
>  	/* for debugging with trace arrays */
>  	cxl_p1_write(adapter, CXL_PSL_TRACE, 0x0000FF7C00000000ULL);
>
