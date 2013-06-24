Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 1/2] powerpc,
 perf: Ignore separate BHRB privilege state filter request
In-reply-to: <1370843609-32618-2-git-send-email-khandual@linux.vnet.ibm.com>
References: <1370843609-32618-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1370843609-32618-2-git-send-email-khandual@linux.vnet.ibm.com>
Date: Mon, 24 Jun 2013 17:19:28 +1000
Message-ID: <32383.1372058368@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> Completely ignore BHRB privilege state filter request as we are
> already configuring that with privilege state filtering attribute
> for the accompanying PMU event. This would help achieve cleaner
> user space interaction for BHRB.
> 
> This patch fixes a situation like this
> 
> Before patch:-
> ------------
> ./perf record -j any -e branch-misses:k ls
> Error:
> The sys_perf_event_open() syscall returned with 95 (Operation not
> supported) for event (branch-misses:k).
> /bin/dmesg may provide additional information.
> No CONFIG_PERF_EVENTS=y kernel support configured?
> 
> Here 'perf record' actually copies over ':k' filter request into BHRB
> privilege state filter config and our previous check in kernel would
> fail that.
> 
> After patch:-
> -------------
> ./perf record -j any -e branch-misses:k ls
> perf  perf.data  perf.data.old  test-mmap-ring
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.002 MB perf.data (~102 samples)]
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Acked-by: Michael Neuling <mikey@neuling.org>


> ---
>  arch/powerpc/perf/power8-pmu.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
> index f7d1c4f..371c6e7 100644
> --- a/arch/powerpc/perf/power8-pmu.c
> +++ b/arch/powerpc/perf/power8-pmu.c
> @@ -523,18 +523,13 @@ static int power8_generic_events[] = {
>  static u64 power8_bhrb_filter_map(u64 branch_sample_type)
>  {
>  	u64 pmu_bhrb_filter = 0;
> -	u64 br_privilege = branch_sample_type & ONLY_PLM;
>  
> -	/* BHRB and regular PMU events share the same prvillege state
> +	/* BHRB and regular PMU events share the same privilege state
>  	 * filter configuration. BHRB is always recorded along with a
> -	 * regular PMU event. So privilege state filter criteria for BHRB
> -	 * and the companion PMU events has to be the same. As a default
> -	 * "perf record" tool sets all privillege bits ON when no filter
> -	 * criteria is provided in the command line. So as along as all
> -	 * privillege bits are ON or they are OFF, we are good to go.
> +	 * regular PMU event. As the privilege state filter is handled
> +	 * in the basic PMC configuration of the accompanying regular
> +	 * PMU event, we ignore any separate BHRB specific request.
>  	 */
> -	if ((br_privilege != 7) && (br_privilege != 0))
> -		return -1;
>  
>  	/* No branch filter requested */
>  	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
> -- 
> 1.7.11.7
> 
