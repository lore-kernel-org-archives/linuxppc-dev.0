Return-Path: <michael.neuling@au1.ibm.com>
From: Michael Neuling <michael.neuling@au1.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf events,
	powerpc: Add POWER7 stalled-cycles-frontend/backend events
In-reply-to: <4E5C6A7D.2010909@linux.vnet.ibm.com>
References: <4E5C6A7D.2010909@linux.vnet.ibm.com>
Date: Fri, 09 Sep 2011 11:38:09 +1000
Message-ID: <25545.1315532289@neuling.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> perf events, powerpc: Add POWER7 stalled-cycles-frontend/backend events
> 
> 	Extent the POWER7 PMU driver with definitions
> 	for generic front-end and back-end stall events.

Anshuman,

Can you explain what these P7 events actually are and how they relate to
Ingo's original comment on this in
8f62242246351b5a4bc0c1f00c0c7003edea128a

    Both events limit performance: most front end stalls tend to be
    caused by branch misprediction or instruction fetch cachemisses,
    backend stalls can be caused by various resource shortages or
    inefficient instruction scheduling.

> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> diff --git a/arch/powerpc/kernel/power7-pmu.c b/arch/powerpc/kernel/power7-pmu.c
> index 593740f..e5d2844 100644
> --- a/arch/powerpc/kernel/power7-pmu.c
> +++ b/arch/powerpc/kernel/power7-pmu.c
> @@ -297,6 +297,8 @@ static void power7_disable_pmc(unsigned int pmc, unsigned long mmcr[])
>  
>  static int power7_generic_events[] = {
>  	[PERF_COUNT_HW_CPU_CYCLES] = 0x1e,
> +	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = 0x100f8, /* GCT_NOSLOT_CYC */

eg. Is this Global Completion Table (GCT) empty?

> +	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = 0x4000a,  /* CMPLU_STALL */

eg. Is this instruction completion stall?

Mikey

>  	[PERF_COUNT_HW_INSTRUCTIONS] = 2,
>  	[PERF_COUNT_HW_CACHE_REFERENCES] = 0xc880,	/* LD_REF_L1_LSU*/
>  	[PERF_COUNT_HW_CACHE_MISSES] = 0x400f0,		/* LD_MISS_L1	*/
> 
> -- 
> Anshuman Khandual 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
