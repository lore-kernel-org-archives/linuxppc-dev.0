Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhPqc5QL2zDr4H
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 12:23:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/perf: Fix IMC_MAX_PMU macro
In-Reply-To: <1510346389-16505-2-git-send-email-maddy@linux.vnet.ibm.com>
References: <1510346389-16505-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1510346389-16505-2-git-send-email-maddy@linux.vnet.ibm.com>
Date: Wed, 22 Nov 2017 12:23:56 +1100
Message-ID: <87wp2j2jir.fsf@concordia.ellerman.id.au>
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

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
> index b150f4deaccf..4764e6932cb7 100644
> --- a/arch/powerpc/platforms/powernv/opal-imc.c
> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
> @@ -153,6 +153,22 @@ static void disable_core_pmu_counters(void)
>  	put_online_cpus();
>  }
>  
> +int get_max_nest_dev(void)
> +{
> +	struct device_node *node;
> +	u32 pmu_units, type;
> +
> +	for_each_compatible_node(node, NULL, IMC_DTB_UNIT_COMPAT) {
> +		if (of_property_read_u32(node, "type", &type))
> +			continue;
> +
> +		if (type == IMC_TYPE_CHIP)
> +			pmu_units++;
> +	}
> +
> +	return pmu_units;
> +}

Breaks:

  arch/powerpc/platforms/powernv/opal-imc.c:169:2: error: 'pmu_units' may be used uninitialized in this function [-Werror=maybe-uninitialized]

http://kisskb.ellerman.id.au/kisskb/head/1e59fb813346ee43be2a3a9acf4aac2815af1284/

cheers
