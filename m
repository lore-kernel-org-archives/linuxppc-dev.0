Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0b631rLKzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 10:15:38 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 5 May 2016 10:15:37 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9E5DB3578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 10:15:35 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u450FRLc6816076
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 May 2016 10:15:35 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u450F2pp014909
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 May 2016 10:15:03 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>
Subject: Re: [PATCH] cxl: Ensure PSL interrupt is configured for contexts with
 no AFU IRQs
In-reply-to: <572A0681.4080703@linux.vnet.ibm.com>
References: <1462337578-15883-1-git-send-email-imunsie@au.ibm.com>
 <572A0681.4080703@linux.vnet.ibm.com>
Date: Thu, 05 May 2016 10:14:34 +1000
Message-Id: <1462406618-sup-6140@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Frederic Barrat's message of 2016-05-05 00:26:09 +1000:
> I believe there's a potential problem there for powerVM guest.
> In afu_allocate_irqs(), the allocation of the bitmap for the AFU 
> interrupts should return NULL (since count = 0). Therefore we'll skip 
> the allocation for the irq names. Yet we need one for the PSL interrupt. 
> I'm not too sure of what the effect of calling cxl_map_irq with a NULL 
> name is (later, in afu_register_hwirqs), but it's likely not very good.
> That is admittedly a latent pb introduced by the powerVM patch, only 
> revealed here.

Actually I believe it should be fine - kcalloc should return
ZERO_SIZE_POINTER, not NULL and the names should still be allocated.
I'm pretty sure we already rely on this for AFUs that don't use any
interrupts per context, otherwise they would fail with -ENOMEM.

> Of course, this is highly theoretical. pHyp only supports cxlflash, so 
> count is not supposed to be null. Still...

Yeah, I was somewhat tempted not to bother coping with this situation in
PowerVM given we don't have any users that need it, but it seemed like a
better idea to make the API's behaviour consistent regardless of the
underlying platform.

> Other than that, the patch looks good to me.

Thanks for the review :)

Cheers,
-Ian
