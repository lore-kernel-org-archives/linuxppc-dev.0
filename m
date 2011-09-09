Return-Path: <michael.neuling@au1.ibm.com>
From: Michael Neuling <michael.neuling@au1.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf events,
	powerpc: Add POWER7 stalled-cycles-frontend/backend events
In-reply-to: <4E69AFCF.3040404@linux.vnet.ibm.com>
References: <4E5C6A7D.2010909@linux.vnet.ibm.com>
	<25545.1315532289@neuling.org>
	<4E69AFCF.3040404@linux.vnet.ibm.com>
Date: Fri, 09 Sep 2011 16:26:21 +1000
Message-ID: <4880.1315549581@neuling.org>
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

In message <4E69AFCF.3040404@linux.vnet.ibm.com> you wrote:
> On Friday 09 September 2011 07:08 AM, Michael Neuling wrote:
> >> perf events, powerpc: Add POWER7 stalled-cycles-frontend/backend events
> >>
> >> 	Extent the POWER7 PMU driver with definitions
> >> 	for generic front-end and back-end stall events.
> > 
> > Anshuman,
> > 
> > Can you explain what these P7 events actually are and how they relate to
> > Ingo's original comment on this in
> > 8f62242246351b5a4bc0c1f00c0c7003edea128a
> > 
> >     Both events limit performance: most front end stalls tend to be
> >     caused by branch misprediction or instruction fetch cachemisses,
> >     backend stalls can be caused by various resource shortages or
> >     inefficient instruction scheduling.
> > 
> As explained in Ingo's original comment, the exact definitions of the
> stall events are very much processor specific as different things mean
> different in their respective instruction pipeline. These two Power7
> raw events are the closest approximation to the concept detailed in
> Ingo's comment.
> >>
> >> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> >>
> >> diff --git a/arch/powerpc/kernel/power7-pmu.c b/arch/powerpc/kernel/power7
-pmu.c
> >> index 593740f..e5d2844 100644
> >> --- a/arch/powerpc/kernel/power7-pmu.c
> >> +++ b/arch/powerpc/kernel/power7-pmu.c
> >> @@ -297,6 +297,8 @@ static void power7_disable_pmc(unsigned int pmc, unsig
ned long mmcr[])
> >>  
> >>  static int power7_generic_events[] = {
> >>  	[PERF_COUNT_HW_CPU_CYCLES] = 0x1e,
> >> +	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = 0x100f8, /* GCT_NOSLOT_CYC */
> > 
> > eg. Is this Global Completion Table (GCT) empty?
> Yes, it means cycles when the Global Completion Table has no slots from this thread
> > 
> >> + [PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = 0x4000a, /* CMPLU_STALL
*/
> > 
> > eg. Is this instruction completion stall?
> Yes, it means no groups completed and GCT not empty

I agree, I think they match what Ingo is trying to achieve.

Can you add these descriptions to the patch and resubmit please?

If you can find similar events for power4/5/5+/6 that would be great too
submit too.  

FWIW, the patch compiles and runs for me.  

Mikey
