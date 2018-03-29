Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BYlC5Vf9zDrJm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 16:51:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 08/14] powerpc/setup: cpu_to_phys_id array
In-Reply-To: <20180213150824.27689-9-npiggin@gmail.com>
References: <20180213150824.27689-1-npiggin@gmail.com>
 <20180213150824.27689-9-npiggin@gmail.com>
Date: Thu, 29 Mar 2018 16:51:03 +1100
Message-ID: <87r2o31lbs.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> Build an array that finds hardware CPU number from logical CPU
> number in firmware CPU discovery. Use that rather than setting
> paca of other CPUs directly, to begin with. Subsequent patch will
> not have pacas allocated at this point.
> ---
>  arch/powerpc/include/asm/smp.h     |  1 +
>  arch/powerpc/kernel/prom.c         |  7 +++++++
>  arch/powerpc/kernel/setup-common.c | 15 ++++++++++++++-
>  3 files changed, 22 insertions(+), 1 deletion(-)

Added SOB.

> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 4dffef947b8a..5979e34ba90e 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -874,5 +874,12 @@ EXPORT_SYMBOL(cpu_to_chip_id);
>  
>  bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
>  {
> +	/*
> +	 * Early firmware scanning must use this rather than
> +	 * get_hard_smp_processor_id because we don't have pacas allocated
> +	 * until memory topology is discovered.
> +	 */
> +	if (cpu_to_phys_id != NULL)
> +		return (int)phys_id == cpu_to_phys_id[cpu];

This needed an #ifdef CONFIG_SMP.

cheers
