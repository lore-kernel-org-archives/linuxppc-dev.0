Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] perf, x86,
 lbr: Demand proper privileges for PERF_SAMPLE_BRANCH_KERNEL
In-reply-to: <20130516090916.GF19669@dyad.programming.kicks-ass.net>
References: <20130503121122.931661809@chello.nl>
 <20130503121256.230745028@chello.nl>
 <CABPqkBTvcQAyXfeiJwpPsNtbs4ffsVguXE631dK_rbzHpwBdOg@mail.gmail.com>
 <20130516090916.GF19669@dyad.programming.kicks-ass.net>
Date: Thu, 16 May 2013 20:09:36 +1000
Message-ID: <8166.1368698976@ale.ozlabs.ibm.com>
Cc: "ak@linux.intel.com" <ak@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, May 15, 2013 at 03:37:22PM +0200, Stephane Eranian wrote:
> > On Fri, May 3, 2013 at 2:11 PM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> > > We should always have proper privileges when requesting kernel data.
> > >
> > > Cc: Andi Kleen <ak@linux.intel.com>
> > > Cc: eranian@google.com
> > > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > > Link: http://lkml.kernel.org/n/tip-v0x9ky3ahzr6nm3c6ilwrili@git.kernel.org
> > > ---
> > >  arch/x86/kernel/cpu/perf_event_intel_lbr.c |    5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > --- a/arch/x86/kernel/cpu/perf_event_intel_lbr.c
> > > +++ b/arch/x86/kernel/cpu/perf_event_intel_lbr.c
> > > @@ -318,8 +318,11 @@ static void intel_pmu_setup_sw_lbr_filte
> > >         if (br_type & PERF_SAMPLE_BRANCH_USER)
> > >                 mask |= X86_BR_USER;
> > >
> > > -       if (br_type & PERF_SAMPLE_BRANCH_KERNEL)
> > > +       if (br_type & PERF_SAMPLE_BRANCH_KERNEL) {
> > > +               if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
> > > +                       return -EACCES;
> > >                 mask |= X86_BR_KERNEL;
> > > +       }
> > >
> > This will prevent regular users from capturing kernel -> kernel branches.
> > But it won't prevent users from getting kernel -> user branches. Thus
> > some kernel address will still be captured. I guess they could be eliminated
> > by the sw_filter.
> > 
> > When using LBR priv level filtering, the filter applies to the branch target
> > only.
> 
> How about something like the below? It also adds the branch flags
> Mikey wanted for PowerPC.
> 
> ---
>  arch/x86/kernel/cpu/perf_event_intel_lbr.c | 12 +++++++++---
>  include/linux/perf_event.h                 | 10 +++++++---
>  2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/perf_event_intel_lbr.c b/arch/x86/kernel/cpu/perf_event_intel_lbr.c
> index d978353..f44d635 100644
> --- a/arch/x86/kernel/cpu/perf_event_intel_lbr.c
> +++ b/arch/x86/kernel/cpu/perf_event_intel_lbr.c
> @@ -585,17 +585,23 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  
>  		/* if type does not correspond, then discard */
>  		if (type == X86_BR_NONE || (br_sel & type) != type) {
> -			cpuc->lbr_entries[i].from = 0;
> +			cpuc->lbr_entries[i].__delete = 1;
>  			compress = true;
>  		}
> +
> +		/* hide kernel addresses if we're not privileged  */
> +		if (!(br_sel & X86_BR_KERNEL) && kernel_ip(from)) {
> +			cpuc->lbr_entries[i].from = -1L;
> +			cpuc->lbr_entries[i].invalid_from = 1;
> +		}
>  	}
>  
>  	if (!compress)
>  		return;
>  
> -	/* remove all entries with from=0 */
> +	/* remove all entries with __delete */
>  	for (i = 0; i < cpuc->lbr_stack.nr; ) {
> -		if (!cpuc->lbr_entries[i].from) {
> +		if (cpuc->lbr_entries[i].__delete) {
>  			j = i;
>  			while (++j < cpuc->lbr_stack.nr)
>  				cpuc->lbr_entries[j-1] = cpuc->lbr_entries[j];
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index f463a46..7acf1c9 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -77,9 +77,13 @@ struct perf_raw_record {
>  struct perf_branch_entry {
>  	__u64	from;
>  	__u64	to;
> -	__u64	mispred:1,  /* target mispredicted */
> -		predicted:1,/* target predicted */
> -		reserved:62;
> +	__u64	mispred:1,	/* target mispredicted		*/
> +		predicted:1,	/* target predicted		*/
> +		invalid_to:1,	/* @to isn't to be trusted	*/
> +		invalid_from:1, /* @from isn't to be trusted	*/

Thanks Peter.  One possible issue...

When the kernel has to read the branch from memory, there is no way for
it to know that it's the same one that the HW actually executed.  Hence
there's a possibility that the to address is invalid but we can't tell
for sure.

I'm happy to just ignore that and mark calculated to address as valid,
unless you think it would be worthwhile extra information to pass onto
the user?

If we wanted this extra fidelity we could add a possibly_invalid_to:1
flag to your patch but I'm not sure it's worth it to be honest.

mikey
