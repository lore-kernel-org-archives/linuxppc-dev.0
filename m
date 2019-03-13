Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E807EC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 18:22:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739D22075C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 18:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739D22075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KKvM5kznzDqJk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 05:22:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KKsM5sgpzDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 05:20:54 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2DICj10088885
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 14:20:52 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r75etctx9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 14:20:52 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Wed, 13 Mar 2019 18:20:49 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 13 Mar 2019 18:20:46 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2DIKj8131916208
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2019 18:20:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B69FA405C;
 Wed, 13 Mar 2019 18:20:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA844A4054;
 Wed, 13 Mar 2019 18:20:44 +0000 (GMT)
Received: from [9.145.182.34] (unknown [9.145.182.34])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 13 Mar 2019 18:20:44 +0000 (GMT)
Subject: Re: [PATCH 2/7] ocxl: Allow external drivers to use OpenCAPI contexts
To: "Alastair D'Silva" <alastair@au1.ibm.com>
References: <20190313041524.14644-1-alastair@au1.ibm.com>
 <20190313041524.14644-3-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Wed, 13 Mar 2019 19:20:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313041524.14644-3-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031318-4275-0000-0000-0000031A9469
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031318-4276-0000-0000-00003829041D
Message-Id: <35bec389-2b70-96cb-c5f5-443bf902c9cd@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-13_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=648 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130126
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Greg Kurz <groug@kaod.org>, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Alastair D'Silva <alastair@d-silva.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 13/03/2019 à 05:15, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Most OpenCAPI operations require a valid context, so
> exposing these functions to external drivers is necessary.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---

Patch could also be moved later in the series (same reason as before), but:
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>


>   drivers/misc/ocxl/context.c       |  9 +++++--
>   drivers/misc/ocxl/file.c          |  2 +-
>   drivers/misc/ocxl/ocxl_internal.h |  6 -----
>   include/misc/ocxl.h               | 44 +++++++++++++++++++++++++++++++
>   4 files changed, 52 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
> index 3498a0199bde..1534b56f1db1 100644
> --- a/drivers/misc/ocxl/context.c
> +++ b/drivers/misc/ocxl/context.c
> @@ -8,6 +8,7 @@ struct ocxl_context *ocxl_context_alloc(void)
>   {
>   	return kzalloc(sizeof(struct ocxl_context), GFP_KERNEL);
>   }
> +EXPORT_SYMBOL_GPL(ocxl_context_alloc);
>   
>   int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
>   		struct address_space *mapping)
> @@ -43,6 +44,7 @@ int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
>   	ocxl_afu_get(afu);
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(ocxl_context_init);
>   
>   /*
>    * Callback for when a translation fault triggers an error
> @@ -63,7 +65,7 @@ static void xsl_fault_error(void *data, u64 addr, u64 dsisr)
>   	wake_up_all(&ctx->events_wq);
>   }
>   
> -int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
> +int ocxl_context_attach(struct ocxl_context *ctx, u64 amr, struct mm_struct *mm)
>   {
>   	int rc;
>   
> @@ -75,7 +77,7 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
>   	}
>   
>   	rc = ocxl_link_add_pe(ctx->afu->fn->link, ctx->pasid,
> -			current->mm->context.id, ctx->tidr, amr, current->mm,
> +			mm->context.id, ctx->tidr, amr, mm,
>   			xsl_fault_error, ctx);
>   	if (rc)
>   		goto out;
> @@ -85,6 +87,7 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
>   	mutex_unlock(&ctx->status_mutex);
>   	return rc;
>   }
> +EXPORT_SYMBOL_GPL(ocxl_context_attach);
>   
>   static vm_fault_t map_afu_irq(struct vm_area_struct *vma, unsigned long address,
>   		u64 offset, struct ocxl_context *ctx)
> @@ -243,6 +246,7 @@ int ocxl_context_detach(struct ocxl_context *ctx)
>   	}
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(ocxl_context_detach);
>   
>   void ocxl_context_detach_all(struct ocxl_afu *afu)
>   {
> @@ -280,3 +284,4 @@ void ocxl_context_free(struct ocxl_context *ctx)
>   	ocxl_afu_put(ctx->afu);
>   	kfree(ctx);
>   }
> +EXPORT_SYMBOL_GPL(ocxl_context_free);
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index 16eb8a60d5c7..865b3d176431 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -100,7 +100,7 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
>   		return -EINVAL;
>   
>   	amr = arg.amr & mfspr(SPRN_UAMOR);
> -	rc = ocxl_context_attach(ctx, amr);
> +	rc = ocxl_context_attach(ctx, amr, current->mm);
>   	return rc;
>   }
>   
> diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
> index 06fd98c989c8..779d15ef60b5 100644
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
>   int ocxl_sysfs_add_afu(struct ocxl_afu *afu);
>   void ocxl_sysfs_remove_afu(struct ocxl_afu *afu);
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 3b320c39f0af..ebbfe83cd5a6 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -51,6 +51,7 @@ struct ocxl_fn_config {
>   
>   // These are opaque outside the ocxl driver
>   struct ocxl_afu;
> +struct ocxl_context;
>   
>   enum ocxl_endian {
>   	OCXL_BIG_ENDIAN = 0,    /**< AFU data is big-endian */
> @@ -58,6 +59,49 @@ enum ocxl_endian {
>   	OCXL_HOST_ENDIAN = 2,   /**< AFU data is the same endianness as the host */
>   };
>   
> +/**
> + * Allocate space for a new OpenCAPI context
> + *
> + * Returns NULL on failure
> + */
> +struct ocxl_context *ocxl_context_alloc(void);
> +
> +/**
> + * Initialize an OpenCAPI context
> + *
> + * @ctx: The OpenCAPI context to initialize
> + * @afu: The AFU the context belongs to
> + * @mapping: The mapping to unmap when the context is closed (may be NULL)
> + */
> +int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
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
>   /**
>    * Read a 32 bit value from global MMIO
>    *
> 

