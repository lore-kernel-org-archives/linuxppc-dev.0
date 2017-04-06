Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzFhB1d3XzDqLm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 18:08:10 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v367wjUJ021340
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 04:07:58 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29ngh2ccdm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Apr 2017 04:07:58 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 6 Apr 2017 02:07:56 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org, dja@axtens.net,
 eranian@google.com, Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 01/11] powerpc/powernv: Data structure and macros
 definitions
In-Reply-To: <1491231308-15282-2-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491231308-15282-2-git-send-email-maddy@linux.vnet.ibm.com>
Date: Thu, 06 Apr 2017 18:07:42 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87tw62hsc1.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:

> From: Hemant Kumar <hemant@linux.vnet.ibm.com>
>
> Create new header file "imc-pmu.h" to add the data structures
> and macros needed for IMC pmu support.
>
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/imc-pmu.h | 68 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/imc-pmu.h
>
> diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
> new file mode 100644
> index 000000000000..a3d4f1bf9492
> --- /dev/null
> +++ b/arch/powerpc/include/asm/imc-pmu.h
> @@ -0,0 +1,68 @@
> +#ifndef PPC_POWERNV_IMC_PMU_DEF_H
> +#define PPC_POWERNV_IMC_PMU_DEF_H
> +
> +/*
> + * IMC Nest Performance Monitor counter support.
> + *
> + * Copyright (C) 2016 Madhavan Srinivasan, IBM Corporation.
> + *           (C) 2016 Hemant K Shaw, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +#include <linux/perf_event.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/io.h>
> +#include <asm/opal.h>
> +
> +#define IMC_MAX_CHIPS			32
> +#define IMC_MAX_PMUS			32
> +#define IMC_MAX_PMU_NAME_LEN		256

Why do we need a max length? We get the actual lengths from the device
tree, so we know at each point in time what the length of any new string
should be, right?

Otherwise you appear to be, in the general case, using 10x the memory
than you could.

-- 
Stewart Smith
OPAL Architect, IBM.
