Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DC6C282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 15:38:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345EA20674
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 15:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345EA20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kmby080HzDqKv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 01:38:38 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kmVj0kBDzDqDW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 01:34:04 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3HFUawG140363
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 11:34:03 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rx5xtjwg5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 11:34:02 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Wed, 17 Apr 2019 16:34:00 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Apr 2019 16:33:57 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3HFXuTI59506738
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Apr 2019 15:33:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3910B42041;
 Wed, 17 Apr 2019 15:33:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D099E42049;
 Wed, 17 Apr 2019 15:33:54 +0000 (GMT)
Received: from [9.145.35.200] (unknown [9.145.35.200])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 17 Apr 2019 15:33:54 +0000 (GMT)
Subject: Re: [PATCH v4 6/7] ocxl: move event_fd handling to frontend
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20190327053137.15173-1-alastair@au1.ibm.com>
 <20190327053137.15173-7-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Wed, 17 Apr 2019 17:33:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327053137.15173-7-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041715-0020-0000-0000-00000330E77A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041715-0021-0000-0000-00002183333F
Message-Id: <90cb1f1b-0eaf-ab48-40e5-7a13b97c3041@linux.ibm.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 27/03/2019 à 06:31, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Event_fd is only used in the driver frontend, so it does not
> need to exist in the backend code. Relocate it to the frontend
> and provide an opaque mechanism for consumers instead.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---


Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>


>   drivers/misc/ocxl/afu_irq.c       | 74 ++++++++++++++++++-------------
>   drivers/misc/ocxl/file.c          | 22 ++++++++-
>   drivers/misc/ocxl/ocxl_internal.h |  5 ---
>   include/misc/ocxl.h               | 46 +++++++++++++++++++
>   4 files changed, 109 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/afu_irq.c b/drivers/misc/ocxl/afu_irq.c
> index 2d410cd6f817..70f8f1c3929d 100644
> --- a/drivers/misc/ocxl/afu_irq.c
> +++ b/drivers/misc/ocxl/afu_irq.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   // Copyright 2017 IBM Corp.
>   #include <linux/interrupt.h>
> -#include <linux/eventfd.h>
> +#include <asm/pnv-ocxl.h>
>   #include "ocxl_internal.h"
>   #include "trace.h"
>   
> @@ -11,7 +11,9 @@ struct afu_irq {
>   	unsigned int virq;
>   	char *name;
>   	u64 trigger_page;
> -	struct eventfd_ctx *ev_ctx;
> +	irqreturn_t (*handler)(void *private);
> +	void (*free_private)(void *private);
> +	void *private;
>   };
>   
>   int ocxl_irq_offset_to_id(struct ocxl_context *ctx, u64 offset)
> @@ -24,14 +26,44 @@ u64 ocxl_irq_id_to_offset(struct ocxl_context *ctx, int irq_id)
>   	return ctx->afu->irq_base_offset + (irq_id << PAGE_SHIFT);
>   }
>   
> +int ocxl_irq_set_handler(struct ocxl_context *ctx, int irq_id,
> +		irqreturn_t (*handler)(void *private),
> +		void (*free_private)(void *private),
> +		void *private)
> +{
> +	struct afu_irq *irq;
> +	int rc;
> +
> +	mutex_lock(&ctx->irq_lock);
> +	irq = idr_find(&ctx->irq_idr, irq_id);
> +	if (!irq) {
> +		rc = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	irq->handler = handler;
> +	irq->private = private;
> +	irq->free_private = free_private;
> +
> +	rc = 0;
> +	// Fall through to unlock
> +
> +unlock:
> +	mutex_unlock(&ctx->irq_lock);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_irq_set_handler);
> +
>   static irqreturn_t afu_irq_handler(int virq, void *data)
>   {
>   	struct afu_irq *irq = (struct afu_irq *) data;
>   
>   	trace_ocxl_afu_irq_receive(virq);
> -	if (irq->ev_ctx)
> -		eventfd_signal(irq->ev_ctx, 1);
> -	return IRQ_HANDLED;
> +
> +	if (irq->handler)
> +		return irq->handler(irq->private);
> +
> +	return IRQ_HANDLED; // Just drop it on the ground
>   }
>   
>   static int setup_afu_irq(struct ocxl_context *ctx, struct afu_irq *irq)
> @@ -117,6 +149,7 @@ int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id)
>   	kfree(irq);
>   	return rc;
>   }
> +EXPORT_SYMBOL_GPL(ocxl_afu_irq_alloc);
>   
>   static void afu_irq_free(struct afu_irq *irq, struct ocxl_context *ctx)
>   {
> @@ -126,8 +159,8 @@ static void afu_irq_free(struct afu_irq *irq, struct ocxl_context *ctx)
>   				ocxl_irq_id_to_offset(ctx, irq->id),
>   				1 << PAGE_SHIFT, 1);
>   	release_afu_irq(irq);
> -	if (irq->ev_ctx)
> -		eventfd_ctx_put(irq->ev_ctx);
> +	if (irq->free_private)
> +		irq->free_private(irq->private);
>   	ocxl_link_free_irq(ctx->afu->fn->link, irq->hw_irq);
>   	kfree(irq);
>   }
> @@ -148,6 +181,7 @@ int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id)
>   	mutex_unlock(&ctx->irq_lock);
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(ocxl_afu_irq_free);
>   
>   void ocxl_afu_irq_free_all(struct ocxl_context *ctx)
>   {
> @@ -160,31 +194,6 @@ void ocxl_afu_irq_free_all(struct ocxl_context *ctx)
>   	mutex_unlock(&ctx->irq_lock);
>   }
>   
> -int ocxl_afu_irq_set_fd(struct ocxl_context *ctx, int irq_id, int eventfd)
> -{
> -	struct afu_irq *irq;
> -	struct eventfd_ctx *ev_ctx;
> -	int rc = 0;
> -
> -	mutex_lock(&ctx->irq_lock);
> -	irq = idr_find(&ctx->irq_idr, irq_id);
> -	if (!irq) {
> -		rc = -EINVAL;
> -		goto unlock;
> -	}
> -
> -	ev_ctx = eventfd_ctx_fdget(eventfd);
> -	if (IS_ERR(ev_ctx)) {
> -		rc = -EINVAL;
> -		goto unlock;
> -	}
> -
> -	irq->ev_ctx = ev_ctx;
> -unlock:
> -	mutex_unlock(&ctx->irq_lock);
> -	return rc;
> -}
> -
>   u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, int irq_id)
>   {
>   	struct afu_irq *irq;
> @@ -197,3 +206,4 @@ u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, int irq_id)
>   	mutex_unlock(&ctx->irq_lock);
>   	return addr;
>   }
> +EXPORT_SYMBOL_GPL(ocxl_afu_irq_get_addr);
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index 7f5282a3af3a..8aa22893ed76 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -3,6 +3,7 @@
>   #include <linux/fs.h>
>   #include <linux/poll.h>
>   #include <linux/sched/signal.h>
> +#include <linux/eventfd.h>
>   #include <linux/uaccess.h>
>   #include <uapi/misc/ocxl.h>
>   #include <asm/reg.h>
> @@ -183,11 +184,27 @@ static long afu_ioctl_get_features(struct ocxl_context *ctx,
>   			x == OCXL_IOCTL_GET_FEATURES ? "GET_FEATURES" :	\
>   			"UNKNOWN")
>   
> +static irqreturn_t irq_handler(void *private)
> +{
> +	struct eventfd_ctx *ev_ctx = private;
> +
> +	eventfd_signal(ev_ctx, 1);
> +	return IRQ_HANDLED;
> +}
> +
> +static void irq_free(void *private)
> +{
> +	struct eventfd_ctx *ev_ctx = private;
> +
> +	eventfd_ctx_put(ev_ctx);
> +}
> +
>   static long afu_ioctl(struct file *file, unsigned int cmd,
>   		unsigned long args)
>   {
>   	struct ocxl_context *ctx = file->private_data;
>   	struct ocxl_ioctl_irq_fd irq_fd;
> +	struct eventfd_ctx *ev_ctx;
>   	int irq_id;
>   	u64 irq_offset;
>   	long rc;
> @@ -239,7 +256,10 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
>   		if (irq_fd.reserved)
>   			return -EINVAL;
>   		irq_id = ocxl_irq_offset_to_id(ctx, irq_fd.irq_offset);
> -		rc = ocxl_afu_irq_set_fd(ctx, irq_id, irq_fd.eventfd);
> +		ev_ctx = eventfd_ctx_fdget(irq_fd.eventfd);
> +		if (!ev_ctx)
> +			return -EFAULT;
> +		rc = ocxl_irq_set_handler(ctx, irq_id, irq_handler, irq_free, ev_ctx);
>   		break;
>   
>   	case OCXL_IOCTL_GET_METADATA:
> diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
> index 58969467bd5c..97415afd79f3 100644
> --- a/drivers/misc/ocxl/ocxl_internal.h
> +++ b/drivers/misc/ocxl/ocxl_internal.h
> @@ -139,11 +139,6 @@ void ocxl_sysfs_unregister_afu(struct ocxl_file_info *info);
>   
>   int ocxl_irq_offset_to_id(struct ocxl_context *ctx, u64 offset);
>   u64 ocxl_irq_id_to_offset(struct ocxl_context *ctx, int irq_id);
> -int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
> -int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id);
>   void ocxl_afu_irq_free_all(struct ocxl_context *ctx);
> -int ocxl_afu_irq_set_fd(struct ocxl_context *ctx, int irq_id,
> -			int eventfd);
> -u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, int irq_id);
>   
>   #endif /* _OCXL_INTERNAL_H_ */
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index e4704632eac5..dea93885a839 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -155,6 +155,52 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr,
>    */
>   int ocxl_context_detach(struct ocxl_context *ctx);
>   
> +// AFU IRQs
> +
> +/**
> + * Allocate an IRQ associated with an AFU context
> + * @ctx: the AFU context
> + * @irq_id: out, the IRQ ID
> + *
> + * Returns 0 on success, negative on failure
> + */
> +extern int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
> +
> +/**
> + * Frees an IRQ associated with an AFU context
> + * @ctx: the AFU context
> + * @irq_id: the IRQ ID
> + *
> + * Returns 0 on success, negative on failure
> + */
> +extern int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id);
> +
> +/**
> + * Gets the address of the trigger page for an IRQ
> + * This can then be provided to an AFU which will write to that
> + * page to trigger the IRQ.
> + * @ctx: The AFU context that the IRQ is associated with
> + * @irq_id: The IRQ ID
> + *
> + * returns the trigger page address, or 0 if the IRQ is not valid
> + */
> +extern u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, int irq_id);
> +
> +/**
> + * Provide a callback to be called when an IRQ is triggered
> + * @ctx: The AFU context that the IRQ is associated with
> + * @irq_id: The IRQ ID
> + * @handler: the callback to be called when the IRQ is triggered
> + * @free_private: the callback to be called when the IRQ is freed (may be NULL)
> + * @private: Private data to be passed to the callbacks
> + *
> + * Returns 0 on success, negative on failure
> + */
> +int ocxl_irq_set_handler(struct ocxl_context *ctx, int irq_id,
> +		irqreturn_t (*handler)(void *private),
> +		void (*free_private)(void *private),
> +		void *private);
> +
>   // AFU Metadata
>   
>   /**
> 

