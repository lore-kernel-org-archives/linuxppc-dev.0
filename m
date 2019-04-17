Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736E3C282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 15:35:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7B920674
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 15:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7B920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kmX23rB6zDqL5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 01:35:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kmV013Q2zDqMy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 01:33:27 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3HFUZIw030557
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 11:33:25 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rx6ek9b4y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 11:33:24 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Wed, 17 Apr 2019 16:33:22 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Apr 2019 16:33:18 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3HFXHWs52166758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Apr 2019 15:33:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0408D4204D;
 Wed, 17 Apr 2019 15:33:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 971F342042;
 Wed, 17 Apr 2019 15:33:16 +0000 (GMT)
Received: from [9.145.35.200] (unknown [9.145.35.200])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 17 Apr 2019 15:33:16 +0000 (GMT)
Subject: Re: [PATCH v4 4/7] ocxl: Allow external drivers to use OpenCAPI
 contexts
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20190327053137.15173-1-alastair@au1.ibm.com>
 <20190327053137.15173-5-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Wed, 17 Apr 2019 17:33:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327053137.15173-5-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041715-0028-0000-0000-00000361E7E7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041715-0029-0000-0000-0000242124D0
Message-Id: <88e125bf-d499-f31f-628a-f611a84b5509@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-17_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904170104
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Greg Kurz <groug@kaod.org>,
 linux-kernel@vger.kernel.org, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 27/03/2019 à 06:31, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Most OpenCAPI operations require a valid context, so
> exposing these functions to external drivers is necessary.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---


There's a small memory leak in here on context alloc, if we can't get a 
pasid from the IDR. But that's not new to this patch, I just saw it 
because the code was moved around. And since that's the only thing I've 
seen in the full series and it's super long to review, I'll address it 
with a later patch. So:

Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>



>   drivers/misc/ocxl/context.c       | 22 ++++++++++-------
>   drivers/misc/ocxl/file.c          |  8 ++-----
>   drivers/misc/ocxl/ocxl_internal.h |  6 -----
>   include/misc/ocxl.h               | 39 +++++++++++++++++++++++++++++++
>   4 files changed, 55 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
> index c73a859d2224..b60e674ac019 100644
> --- a/drivers/misc/ocxl/context.c
> +++ b/drivers/misc/ocxl/context.c
> @@ -4,15 +4,17 @@
>   #include "trace.h"
>   #include "ocxl_internal.h"
>   
> -struct ocxl_context *ocxl_context_alloc(void)
> -{
> -	return kzalloc(sizeof(struct ocxl_context), GFP_KERNEL);
> -}
> -
> -int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
> +int ocxl_context_alloc(struct ocxl_context **context, struct ocxl_afu *afu,
>   		struct address_space *mapping)
>   {
>   	int pasid;
> +	struct ocxl_context *ctx;
> +
> +	*context = kzalloc(sizeof(struct ocxl_context), GFP_KERNEL);
> +	if (!*context)
> +		return -ENOMEM;
> +
> +	ctx = *context;
>   
>   	ctx->afu = afu;
>   	mutex_lock(&afu->contexts_lock);
> @@ -43,6 +45,7 @@ int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
>   	ocxl_afu_get(afu);
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(ocxl_context_alloc);
>   
>   /*
>    * Callback for when a translation fault triggers an error
> @@ -63,7 +66,7 @@ static void xsl_fault_error(void *data, u64 addr, u64 dsisr)
>   	wake_up_all(&ctx->events_wq);
>   }
>   
> -int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
> +int ocxl_context_attach(struct ocxl_context *ctx, u64 amr, struct mm_struct *mm)
>   {
>   	int rc;
>   
> @@ -75,7 +78,7 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
>   	}
>   
>   	rc = ocxl_link_add_pe(ctx->afu->fn->link, ctx->pasid,
> -			current->mm->context.id, ctx->tidr, amr, current->mm,
> +			mm->context.id, ctx->tidr, amr, mm,
>   			xsl_fault_error, ctx);
>   	if (rc)
>   		goto out;
> @@ -85,6 +88,7 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
>   	mutex_unlock(&ctx->status_mutex);
>   	return rc;
>   }
> +EXPORT_SYMBOL_GPL(ocxl_context_attach);
>   
>   static vm_fault_t map_afu_irq(struct vm_area_struct *vma, unsigned long address,
>   		u64 offset, struct ocxl_context *ctx)
> @@ -243,6 +247,7 @@ int ocxl_context_detach(struct ocxl_context *ctx)
>   	}
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(ocxl_context_detach);
>   
>   void ocxl_context_detach_all(struct ocxl_afu *afu)
>   {
> @@ -280,3 +285,4 @@ void ocxl_context_free(struct ocxl_context *ctx)
>   	ocxl_afu_put(ctx->afu);
>   	kfree(ctx);
>   }
> +EXPORT_SYMBOL_GPL(ocxl_context_free);
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index 7a38ea5af9db..8225892a5d77 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -61,11 +61,7 @@ static int afu_open(struct inode *inode, struct file *file)
>   	if (!info)
>   		return -ENODEV;
>   
> -	ctx = ocxl_context_alloc();
> -	if (!ctx)
> -		return -ENOMEM;
> -
> -	rc = ocxl_context_init(ctx, info->afu, inode->i_mapping);
> +	rc = ocxl_context_alloc(&ctx, info->afu, inode->i_mapping);
>   	if (rc)
>   		return rc;
>   
> @@ -90,7 +86,7 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
>   		return -EINVAL;
>   
>   	amr = arg.amr & mfspr(SPRN_UAMOR);
> -	rc = ocxl_context_attach(ctx, amr);
> +	rc = ocxl_context_attach(ctx, amr, current->mm);
>   	return rc;
>   }
>   
> diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
> index 53b6c64a1bf0..de6c16237742 100644
> --- a/drivers/misc/ocxl/ocxl_internal.h
> +++ b/drivers/misc/ocxl/ocxl_internal.h
> @@ -130,15 +130,9 @@ int ocxl_config_check_afu_index(struct pci_dev *dev,
>    */
>   int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);
>   
> -struct ocxl_context *ocxl_context_alloc(void);
> -int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
> -			struct address_space *mapping);
> -int ocxl_context_attach(struct ocxl_context *ctx, u64 amr);
>   int ocxl_context_mmap(struct ocxl_context *ctx,
>   			struct vm_area_struct *vma);
> -int ocxl_context_detach(struct ocxl_context *ctx);
>   void ocxl_context_detach_all(struct ocxl_afu *afu);
> -void ocxl_context_free(struct ocxl_context *ctx);
>   
>   int ocxl_sysfs_register_afu(struct ocxl_file_info *info);
>   void ocxl_sysfs_unregister_afu(struct ocxl_file_info *info);
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 8bafd748e380..e4704632eac5 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -48,6 +48,7 @@ struct ocxl_fn_config {
>   // These are opaque outside the ocxl driver
>   struct ocxl_afu;
>   struct ocxl_fn;
> +struct ocxl_context;
>   
>   // Device detection & initialisation
>   
> @@ -116,6 +117,44 @@ const struct ocxl_fn_config *ocxl_function_config(struct ocxl_fn *fn);
>    */
>   void ocxl_function_close(struct ocxl_fn *fn);
>   
> +// Context allocation
> +
> +/**
> + * Allocate an OpenCAPI context
> + *
> + * @context: The OpenCAPI context to allocate, must be freed with ocxl_context_free
> + * @afu: The AFU the context belongs to
> + * @mapping: The mapping to unmap when the context is closed (may be NULL)
> + */
> +int ocxl_context_alloc(struct ocxl_context **context, struct ocxl_afu *afu,
> +			struct address_space *mapping);
> +
> +/**
> + * Free an OpenCAPI context
> + *
> + * @ctx: The OpenCAPI context to free
> + */
> +void ocxl_context_free(struct ocxl_context *ctx);
> +
> +/**
> + * Grant access to an MM to an OpenCAPI context
> + * @ctx: The OpenCAPI context to attach
> + * @amr: The value of the AMR register to restrict access
> + * @mm: The mm to attach to the context
> + *
> + * Returns 0 on success, negative on failure
> + */
> +int ocxl_context_attach(struct ocxl_context *ctx, u64 amr,
> +				struct mm_struct *mm);
> +
> +/**
> + * Detach an MM from an OpenCAPI context
> + * @ctx: The OpenCAPI context to attach
> + *
> + * Returns 0 on success, negative on failure
> + */
> +int ocxl_context_detach(struct ocxl_context *ctx);
> +
>   // AFU Metadata
>   
>   /**
> 

