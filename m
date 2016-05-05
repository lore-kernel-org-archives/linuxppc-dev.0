Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0kkC046lzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 15:58:58 +1000 (AEST)
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 5 May 2016 06:58:54 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 551DD219004D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 06:58:29 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u455wqsV6488510
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 May 2016 05:58:52 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u455wqkl022594
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 23:58:52 -0600
Subject: Re: [PATCH] cxl: Ensure PSL interrupt is configured for contexts with
 no AFU IRQs
To: Ian Munsie <imunsie@au1.ibm.com>
References: <1462337578-15883-1-git-send-email-imunsie@au.ibm.com>
 <572A0681.4080703@linux.vnet.ibm.com>
 <1462406618-sup-6140@x230.ozlabs.ibm.com>
Cc: mikey <mikey@neuling.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <572AE11B.7010509@linux.vnet.ibm.com>
Date: Thu, 5 May 2016 07:58:51 +0200
MIME-Version: 1.0
In-Reply-To: <1462406618-sup-6140@x230.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 05/05/2016 02:14, Ian Munsie a écrit :
> Excerpts from Frederic Barrat's message of 2016-05-05 00:26:09 +1000:
>> I believe there's a potential problem there for powerVM guest.
>> In afu_allocate_irqs(), the allocation of the bitmap for the AFU
>> interrupts should return NULL (since count = 0). Therefore we'll skip
>> the allocation for the irq names. Yet we need one for the PSL interrupt.
>> I'm not too sure of what the effect of calling cxl_map_irq with a NULL
>> name is (later, in afu_register_hwirqs), but it's likely not very good.
>> That is admittedly a latent pb introduced by the powerVM patch, only
>> revealed here.
>
> Actually I believe it should be fine - kcalloc should return
> ZERO_SIZE_POINTER, not NULL and the names should still be allocated.
> I'm pretty sure we already rely on this for AFUs that don't use any
> interrupts per context, otherwise they would fail with -ENOMEM.

You're right, all is fine.

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

   Fred
