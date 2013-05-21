Return-Path: <eranian@google.com>
Received: from mail-ob0-x231.google.com (mail-ob0-x231.google.com
 [IPv6:2607:f8b0:4003:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1E4692C00C3
 for <linuxppc-dev@ozlabs.org>; Tue, 21 May 2013 23:55:17 +1000 (EST)
Received: by mail-ob0-f177.google.com with SMTP id wn6so726039obc.22
 for <linuxppc-dev@ozlabs.org>; Tue, 21 May 2013 06:55:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8578.1368699317@ale.ozlabs.ibm.com>
References: <20130503121122.931661809@chello.nl>
 <20130503121256.230745028@chello.nl>
 <CABPqkBTvcQAyXfeiJwpPsNtbs4ffsVguXE631dK_rbzHpwBdOg@mail.gmail.com>
 <20130516090916.GF19669@dyad.programming.kicks-ass.net>
 <8578.1368699317@ale.ozlabs.ibm.com>
Date: Tue, 21 May 2013 15:55:14 +0200
Message-ID: <CABPqkBRpbh4BO7cMBysE+E+n5E_o_KesEhEZ3Wq49B3MeW786A@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf, x86,
 lbr: Demand proper privileges for PERF_SAMPLE_BRANCH_KERNEL
From: Stephane Eranian <eranian@google.com>
To: Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=UTF-8
Cc: "ak@linux.intel.com" <ak@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 16, 2013 at 12:15 PM, Michael Neuling <mikey@neuling.org> wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
>
>> On Wed, May 15, 2013 at 03:37:22PM +0200, Stephane Eranian wrote:
>> > On Fri, May 3, 2013 at 2:11 PM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>> > > We should always have proper privileges when requesting kernel data.
>> > >
>> > > Cc: Andi Kleen <ak@linux.intel.com>
>> > > Cc: eranian@google.com
>> > > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
>> > > Link: http://lkml.kernel.org/n/tip-v0x9ky3ahzr6nm3c6ilwrili@git.kernel.org
>> > > ---
>> > >  arch/x86/kernel/cpu/perf_event_intel_lbr.c |    5 ++++-
>> > >  1 file changed, 4 insertions(+), 1 deletion(-)
>> > >
>> > > --- a/arch/x86/kernel/cpu/perf_event_intel_lbr.c
>> > > +++ b/arch/x86/kernel/cpu/perf_event_intel_lbr.c
>> > > @@ -318,8 +318,11 @@ static void intel_pmu_setup_sw_lbr_filte
>> > >         if (br_type & PERF_SAMPLE_BRANCH_USER)
>> > >                 mask |= X86_BR_USER;
>> > >
>> > > -       if (br_type & PERF_SAMPLE_BRANCH_KERNEL)
>> > > +       if (br_type & PERF_SAMPLE_BRANCH_KERNEL) {
>> > > +               if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
>> > > +                       return -EACCES;
>> > >                 mask |= X86_BR_KERNEL;
>> > > +       }
>> > >
>> > This will prevent regular users from capturing kernel -> kernel branches.
>> > But it won't prevent users from getting kernel -> user branches. Thus
>> > some kernel address will still be captured. I guess they could be eliminated
>> > by the sw_filter.
>> >
>> > When using LBR priv level filtering, the filter applies to the branch target
>> > only.
>>
>> How about something like the below? It also adds the branch flags
>> Mikey wanted for PowerPC.
>
> Peter,
>
> BTW PowerPC also has the ability to filter on conditional branches.  Any
> chance we could add something like the follow to perf also?
>
> Mikey
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index fb104e5..891c769 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -157,8 +157,9 @@ enum perf_branch_sample_type {
>         PERF_SAMPLE_BRANCH_ANY_CALL     = 1U << 4, /* any call branch */
>         PERF_SAMPLE_BRANCH_ANY_RETURN   = 1U << 5, /* any return branch */
>         PERF_SAMPLE_BRANCH_IND_CALL     = 1U << 6, /* indirect calls */
> +       PERF_SAMPLE_BRANCH_CONDITIONAL  = 1U << 7, /* conditional branches */
>
I would use PERF_SAMPLE_BRANCH_COND here.

> -       PERF_SAMPLE_BRANCH_MAX          = 1U << 7, /* non-ABI */
> +       PERF_SAMPLE_BRANCH_MAX          = 1U << 8, /* non-ABI */
>  };
>
>  #define PERF_SAMPLE_BRANCH_PLM_ALL \
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index cdf58ec..5b0b89d 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -676,6 +676,7 @@ static const struct branch_mode branch_modes[] = {
>         BRANCH_OPT("any_call", PERF_SAMPLE_BRANCH_ANY_CALL),
>         BRANCH_OPT("any_ret", PERF_SAMPLE_BRANCH_ANY_RETURN),
>         BRANCH_OPT("ind_call", PERF_SAMPLE_BRANCH_IND_CALL),
> +       BRANCH_OPT("cnd", PERF_SAMPLE_BRANCH_CONDITIONAL),

use "cond"

>         BRANCH_END
>  };
>

And if you do this, you also need to update the x86
perf_event_intel_lbr.c mapping
tables to fill out the entries for PERF_SAMPLE_BRANCH_COND:

        [PERF_SAMPLE_BRANCH_COND]       = LBR_JCC,

And you also need to update intel_pmu_setup_sw_lbr_filter()
to handle the conversion to x86 instructions:

       if (br_type & PERF_SAMPLE_BRANCH_COND)
                mask |= X86_BR_JCC;


You also need to update the perf-record.txt documentation to list cond
as a possible
branch filter.
