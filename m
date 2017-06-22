Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtgm75PnSzDr33
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 22:25:59 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5MCOMGX090288
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 08:25:55 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b8bwqd81e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 08:25:55 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 13:25:53 +0100
Subject: Re: [PATCH V3] cxl: Export library to support IBM XSL
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1498039393-10656-1-git-send-email-clombard@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 22 Jun 2017 14:25:51 +0200
MIME-Version: 1.0
In-Reply-To: <1498039393-10656-1-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0ae158b6-3e80-0730-83ae-15bccf40d113@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Salut Christophe,

Since there's a respin, 2 details below.


> diff --git a/drivers/misc/cxl/cxllib.c b/drivers/misc/cxl/cxllib.c
> new file mode 100644
> index 0000000..4f4c5ca
> --- /dev/null
> +++ b/drivers/misc/cxl/cxllib.c
> @@ -0,0 +1,246 @@
> +/*
> + * Copyright 2017 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <asm/pnv-pci.h>
> +#include <linux/hugetlb.h>
> +#include <linux/sched/mm.h>
> +#include <misc/cxllib.h>

Maybe somebody can comment on this, but I believe the usual order is the 
'linux' headers first, then the 'asm'. Though I don't know if there's a 
valid reason behind it, or just tradition...


> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> index c79e39b..077370f 100644
> --- a/drivers/misc/cxl/fault.c
> +++ b/drivers/misc/cxl/fault.c

> +static int cxl_handle_page_fault(struct cxl_context *ctx,
> +				 struct mm_struct *mm,
> +				 u64 dsisr, u64 dar)
> +{
> +	trace_cxl_pte_miss(ctx, dsisr, dar);
> +
> +	if (cxl_handle_mm_fault(mm, dsisr, dar)) {
> +		cxl_ack_ae(ctx);
> +	} else {
> +		pr_devel("Page fault successfully handled for pe: %i!\n", ctx->pe);
> +		cxl_ops->ack_irq(ctx, CXL_PSL_TFC_An_R, 0);
> +	}
> +
> +	return IRQ_HANDLED;
>   }

Why return IRQ_HANDLED? it's not called from an interrupt handler but 
from the bottom half (actually, I think it's coming from 
cxl_handle_segment_miss(), but it's wrong there as well).

   Fred
