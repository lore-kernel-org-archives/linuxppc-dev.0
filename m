Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zT9zh3ms1zDr50
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jan 2018 20:52:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] powerpc/kernel: Add 'ibm,
 thread-groups' property for CPU allocation
In-Reply-To: <aeffc542-db28-7d1f-3263-52919b2d07c2@linux.vnet.ibm.com>
References: <aeffc542-db28-7d1f-3263-52919b2d07c2@linux.vnet.ibm.com>
Date: Sat, 27 Jan 2018 20:52:16 +1100
Message-ID: <87efmb39yn.fsf@concordia.ellerman.id.au>
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

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index b15bae2..0a49231 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -303,6 +306,71 @@ static void __init check_cpu_feature_properties(unsigned long node)
>  	}
>  }
>  
> +static void __init early_init_setup_thread_group_mask(unsigned long node,
> +						cpumask_t *thread_group_mask)
> +{
> +	const __be32 *thrgrp;
> +	int len, rc = 0;
> +	u32 cc_type = 0, no_split = 0, thr_per_split = 0;
> +	int j, k;
> +
> +	cpumask_clear(thread_group_mask);
> +
> +	thrgrp = of_get_flat_dt_prop(node, "ibm,thread-groups", &len);
> +	if (!thrgrp)
> +		return;

This breaks booting on all my systems.

cheers
