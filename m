Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A368AC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 15:43:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2453C2082C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 15:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2453C2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Sdp21M7WzDqJ8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 02:43:22 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Sdm928PxzDqDS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 02:41:44 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2PFcudR138777
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 11:41:42 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rf0ss493a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 11:41:42 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Mon, 25 Mar 2019 15:41:40 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 25 Mar 2019 15:41:37 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2PFfamm48431280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Mar 2019 15:41:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6810A4067;
 Mon, 25 Mar 2019 15:41:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C66DA4064;
 Mon, 25 Mar 2019 15:41:35 +0000 (GMT)
Received: from [9.145.37.149] (unknown [9.145.37.149])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 25 Mar 2019 15:41:35 +0000 (GMT)
Subject: Re: [PATCH v3 6/7] ocxl: move event_fd handling to frontend
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20190320053448.2098-1-alastair@au1.ibm.com>
 <20190325054438.15022-1-alastair@au1.ibm.com>
 <20190325054438.15022-7-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 25 Mar 2019 16:41:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325054438.15022-7-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032515-0020-0000-0000-000003275E85
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032515-0021-0000-0000-000021799583
Message-Id: <f990a76d-76e4-32ac-e618-5bfe2a267cb6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-25_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250116
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



Le 25/03/2019 à 06:44, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Event_fd is only used in the driver frontend, so it does not
> need to exist in the backend code. Relocate it to the frontend
> and provide an opaque mechanism for consumers instead.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>   drivers/misc/ocxl/afu_irq.c       | 76 ++++++++++++++++++-------------
>   drivers/misc/ocxl/file.c          | 22 ++++++++-
>   drivers/misc/ocxl/ocxl_internal.h |  5 --
>   include/misc/ocxl.h               | 46 +++++++++++++++++++
>   4 files changed, 111 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/afu_irq.c b/drivers/misc/ocxl/afu_irq.c
> index 2d410cd6f817..d71e62df7d31 100644
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
> @@ -24,14 +26,43 @@ u64 ocxl_irq_id_to_offset(struct ocxl_context *ctx, int irq_id)
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
> +
> +	rc = 0;
> +	goto unlock;


That goto is too much.


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
> @@ -118,6 +149,8 @@ int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id)
>   	return rc;
>   }
>   
> +EXPORT_SYMBOL_GPL(ocxl_afu_irq_alloc);


nit: checkpatch doesn't like the empty line between the function and its 
symbol export. Also true for a few other symbols in that file.



> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index a8fe0ce4ea67..1b48e9d63abb 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -161,6 +161,52 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr,
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
> + * @free_private: the callback to be called when the IRQ is freed

We should mention free_private can be NULL, in which case it is ignored.

   Fred

