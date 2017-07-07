Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3q4Y6D8fzDr5V
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jul 2017 19:26:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org, stewart@linux.vnet.ibm.com,
 dja@axtens.net, eranian@google.com, hemant@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: Re: [PATCH v12 01/10] powerpc/powernv: Data structure and macros
 definitions for IMC
In-Reply-To: <1499074673-30576-2-git-send-email-anju@linux.vnet.ibm.com>
References: <1499074673-30576-1-git-send-email-anju@linux.vnet.ibm.com>
 <1499074673-30576-2-git-send-email-anju@linux.vnet.ibm.com>
Date: Fri, 07 Jul 2017 19:26:50 +1000
Message-ID: <87h8yo8un9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Maddy/Anju,

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
> From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>
> Create a new header file to add the data structures and
> macros needed for In-Memory Collection (IMC) counter support.
>
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/imc-pmu.h | 99 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/imc-pmu.h
>
> diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
> new file mode 100644
> index 000000000000..ffaea0b9c13e
> --- /dev/null
> +++ b/arch/powerpc/include/asm/imc-pmu.h
> @@ -0,0 +1,99 @@
> +#ifndef PPC_POWERNV_IMC_PMU_DEF_H
> +#define PPC_POWERNV_IMC_PMU_DEF_H
> +
> +/*
> + * IMC Nest Performance Monitor counter support.
> + *
> + * Copyright (C) 2017 Madhavan Srinivasan, IBM Corporation.
> + *           (C) 2017 Anju T Sudhakar, IBM Corporation.
> + *           (C) 2017 Hemant K Shaw, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or later version.
> + */
> +
> +#include <linux/perf_event.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/io.h>
> +#include <asm/opal.h>
> +
> +/*
> + * For static allocation of some of the structures.
> + */
> +#define IMC_MAX_PMUS			32
> +
> +/*
> + * This macro is used for memory buffer allocation of
> + * event names and event string
> + */
> +#define IMC_MAX_NAME_VAL_LEN		96
> +
> +/*
> + * Currently Microcode supports a max of 256KB of counter memory
> + * in the reserved memory region. Max pages to mmap (considering 4K PAGESIZE).
> + */
> +#define IMC_MAX_PAGES			64

Ideally that sort of detail comes from the device tree. Otherwise old
kernels will be unable to run on new hardware which supports more memory.

Actually looking at where we use it, it seems like we don't it to come
from the device tree.

Seems core IMC only ever uses one page.

Thread IMC gets the size indirectly via the device tree:

	if (of_property_read_u32(parent, "size", &pmu_ptr->counter_mem_size))

So we should be able to dynamically size vbase.

> +/*
> + *Compatbility macros for IMC devices
> + */
> +#define IMC_DTB_COMPAT			"ibm,opal-in-memory-counters"
> +#define IMC_DTB_UNIT_COMPAT		"ibm,imc-counters"
> +
> +/*
> + * Structure to hold memory address information for imc units.
> + */
> +struct imc_mem_info {
> +	u32 id;
> +	u64 *vbase[IMC_MAX_PAGES];
> +};

cheers
