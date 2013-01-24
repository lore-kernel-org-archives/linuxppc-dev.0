Return-Path: <paulus@ozlabs.org>
Date: Thu, 24 Jan 2013 16:05:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf/Power: PERF_EVENT_IOC_ENABLE does not reenable event
Message-ID: <20130124050505.GA14070@drongo>
References: <20130111191117.GA9407@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130111191117.GA9407@us.ibm.com>
Cc: Anton Blanchard <anton@au1.ibm.com>, Maynard Johnson <mpjohn@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 11, 2013 at 11:11:17AM -0800, Sukadev Bhattiprolu wrote:
> If we disable a perf event because we exceeded the specified ->event_limit,
> power_pmu_stop() sets the PERF_HES_STOPPED flag on the event.
> 
> If the application then re-enables the event using PERF_EVENT_IOC_ENABLE
> ioctl, we don't seem to ever clear this STOPPED flag. Consequently, the
> user space is never notified of the event.
> 
> Following message has more background and test case.
> 
>     http://lists.eecs.utk.edu/pipermail/ptools-perfapi/2012-October/002528.html
> 
> The problem reported there does not seem to occur on x86. My unverified theory:
> 
> Both x86 and Power clear the event->hw.state flag to 0 in their ->pmu_start()
> operations. On X86 x86_pmu_start() is called from x86_pmu_enable(). But on
> Power, power_pmu_start() is not called from power_pmu_enable().

This code has changed a lot since I worked on it, but it seems like
x86 has the STOPPED flag set whenever the event isn't currently active
on a hardware counter, whereas we have it set only when the event has
been throttled.

> Used the following test cases to verify that this patch works on latest PAPI.
> 
> 	$ papi.git/src/ctests/nonthread PAPI_TOT_CYC@5000000
> 
> 	$ papi.git/src/ctests/overflow_single_event
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/core-book3s.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index aa2465e..a6faada 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -880,8 +880,16 @@ static int power_pmu_add(struct perf_event *event, int ef_flags)
>  	cpuhw->events[n0] = event->hw.config;
>  	cpuhw->flags[n0] = event->hw.event_base;
>  
> +	/*
> +	 * If this event was disabled in record_and_restart() because we
> +	 * exceeded the ->event_limit, this is probably a good time to
> +	 * re-enable the event ? If we don't reenable the event, we will
> +	 * never notify the user again about this event.
> +	 */

The comment seems a bit tentative. :)  If the PERF_EF_START bit is set
then we are being told to restart the event.

>  	if (!(ef_flags & PERF_EF_START))
>  		event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +	else
> +		event->hw.state &= ~PERF_HES_STOPPED;

This looks fine, though I think you could equally well just set
event->hw.state to 0 in the else clause.  That would clear the
UPTODATE flag too, which is appropriate since we are about to put the
event on a hardware counter.

Paul.
