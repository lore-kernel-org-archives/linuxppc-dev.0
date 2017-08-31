Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjYtc1zrkzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 17:30:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 4/4] powerpc/smp: Add Power9 scheduler topology
In-Reply-To: <20170629071256.8159-5-oohall@gmail.com>
References: <20170629071256.8159-1-oohall@gmail.com>
 <20170629071256.8159-5-oohall@gmail.com>
Date: Thu, 31 Aug 2017 17:30:15 +1000
Message-ID: <87inh4tcs8.fsf@concordia.ellerman.id.au>
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

Oliver O'Halloran <oohall@gmail.com> writes:

> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 46f071cedf31..7b2ed0d6fc96 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1043,7 +1081,19 @@ void __init smp_cpus_done(unsigned int max_cpus)
>  
>  	dump_numa_cpu_topology();
>  
> -	set_sched_topology(powerpc_topology);
> +	/*
> +	 * If any CPU detects that it's sharing a cache with another CPU then
> +	 * use the deeper topology that is aware of this sharing.
> +	 */
> +	if (shared_caches) {
> +		pr_info("Using shared cache scheduler topology\n");
> +		set_sched_topology(power9_topology);
> +		/* HACK: warn if we're using this on anything by P9 */
> +		WARN_ON((mfspr(SPRN_PVR) & 0xffffff00) != 0x004e0100);

Um, yuck.

Why are we doing that?

cheers
