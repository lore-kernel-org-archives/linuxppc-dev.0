Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39C4C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 15:15:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772982083D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 15:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772982083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SdB73HVkzDqD4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 02:15:43 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Sd830qQKzDqDZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 02:13:54 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2PFAwnd085610
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 11:13:53 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rf07gn147-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 11:13:52 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Mon, 25 Mar 2019 15:13:50 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 25 Mar 2019 15:13:47 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2PFDj5E62849152
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Mar 2019 15:13:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0CA6A405C;
 Mon, 25 Mar 2019 15:13:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76C63A4054;
 Mon, 25 Mar 2019 15:13:45 +0000 (GMT)
Received: from [9.145.37.149] (unknown [9.145.37.149])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 25 Mar 2019 15:13:45 +0000 (GMT)
Subject: Re: [PATCH v3 4/7] ocxl: Allow external drivers to use OpenCAPI
 contexts
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20190320053448.2098-1-alastair@au1.ibm.com>
 <20190325054438.15022-1-alastair@au1.ibm.com>
 <20190325054438.15022-5-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 25 Mar 2019 16:13:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325054438.15022-5-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032515-0016-0000-0000-00000266EB60
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032515-0017-0000-0000-000032C21BD3
Message-Id: <f59099b1-9f6e-a465-552a-41fa98c17634@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-25_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=942 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250113
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



Le 25/03/2019 à 06:44, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Most OpenCAPI operations require a valid context, so
> exposing these functions to external drivers is necessary.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---

See comment on previous patch regarding merging ocxl_context_alloc() and 
ocxl_context_init(), it would impact the exported symbols.

   Fred


>   drivers/misc/ocxl/context.c       |  9 +++++--
>   drivers/misc/ocxl/file.c          |  2 +-
>   drivers/misc/ocxl/ocxl_internal.h |  6 -----
>   include/misc/ocxl.h               | 45 +++++++++++++++++++++++++++++++
>   4 files changed, 53 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
> index c73a859d2224..8b97b0f19db8 100644
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
> index e6e6121cd9a3..e51578186fd4 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -94,7 +94,7 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
>   		return -EINVAL;
>   
>   	amr = arg.amr & mfspr(SPRN_UAMOR);
> -	rc = ocxl_context_attach(ctx, amr);
> +	rc = ocxl_context_attach(ctx, amr, current->mm);
>   	return rc;
>   }
>   
> diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
> index e04e547df29e..cda1e7667fc8 100644
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
>   int ocxl_sysfs_register_afu(struct ocxl_afu *afu);
>   void ocxl_sysfs_unregister_afu(struct ocxl_afu *afu);
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 8bafd748e380..a8fe0ce4ea67 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -116,6 +116,51 @@ const struct ocxl_fn_config *ocxl_function_config(struct ocxl_fn *fn);
>    */
>   void ocxl_function_close(struct ocxl_fn *fn);
>   
> +// Context allocation
> +
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
>   // AFU Metadata
>   
>   /**
> 

