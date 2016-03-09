Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1450B1A004C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 20:27:28 +1100 (AEDT)
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 00015140BAC
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 20:27:26 +1100 (AEDT)
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 9 Mar 2016 09:27:23 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0448E219005E
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 09:27:05 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u299RMVU54394904
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Mar 2016 09:27:22 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u298RNFu020625
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Mar 2016 01:27:23 -0700
Subject: Re: [PATCH v3 1/2] cxl: Add mechanism for delivering AFU driver
 specific events
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Matt Ochs <mrochs@us.ibm.com>, Manoj Kumar <kumarmn@us.ibm.com>
References: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56DFEC78.9050704@linux.vnet.ibm.com>
Date: Wed, 9 Mar 2016 10:27:20 +0100
MIME-Version: 1.0
In-Reply-To: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ian,

Le 08/03/2016 02:48, Ian Munsie a écrit :
> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c

...

> +static inline bool ctx_event_pending(struct cxl_context *ctx)
> +{
> +	if (ctx->pending_irq || ctx->pending_fault || ctx->pending_afu_err)
> +		return true;
> +
> +	if (ctx->afu_driver_ops)
> +		return ctx->afu_driver_ops->event_pending(ctx);
> +
> +	return false;
> +}
> +

...

> +
> +	if (ctx->afu_driver_ops && ctx->afu_driver_ops->event_pending(ctx)) {
> +		pr_devel("afu_read delivering AFU driver specific event\n");
> +		event.header.type = CXL_EVENT_AFU_DRIVER;
> +		ctx->afu_driver_ops->deliver_event(ctx, &event, sizeof(event));
> +		WARN_ON(event.header.size > sizeof(event));
> +
> +	} else if (ctx->pending_irq) {


So on afu_read(), we may call afu_driver_ops->event_pending() twice 
before calling afu_driver_ops->deliver_event(). Actually, in the 
(likely) scenario where there's only an afu_driver event pending, we 
*will* call afu_driver_ops->event_pending() twice. Wouldn't it make 
sense to cache it then?

It would also avoid entering
		WARN(1, "afu_read must be buggy\n");
if the driver changes its mind between the 2 calls :-)

   Fred
