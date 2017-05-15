Return-Path: <SRS0=6PJf=4V=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRNQW22VvzDqPX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 00:34:59 +1000 (AEST)
Date: Mon, 15 May 2017 10:34:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, linuxppc-dev@lists.ozlabs.org, Olof Johansson
 <olof@lixom.net>
Subject: Re: [patch 09/18] cpufreq/pasemi: Adjust system_state check
Message-ID: <20170515103454.41d69a81@gandalf.local.home>
In-Reply-To: <20170515052403.GX17481@vireshk-i7>
References: <20170514182716.347236777@linutronix.de>
 <20170514183613.160312642@linutronix.de>
 <20170515052403.GX17481@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 15 May 2017 10:54:03 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 14-05-17, 20:27, Thomas Gleixner wrote:
> > To enable smp_processor_id() and might_sleep() debug checks earlier, it's
> > required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.
> > 
> > Adjust the system_state check in pas_cpufreq_cpu_exit() to handle the extra
> > states.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > ---
> >  drivers/cpufreq/pasemi-cpufreq.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/drivers/cpufreq/pasemi-cpufreq.c
> > +++ b/drivers/cpufreq/pasemi-cpufreq.c
> > @@ -226,7 +226,7 @@ static int pas_cpufreq_cpu_exit(struct c
> >  	 * We don't support CPU hotplug. Don't unmap after the system
> >  	 * has already made it to a running state.
> >  	 */
> > -	if (system_state != SYSTEM_BOOTING)
> > +	if (system_state >= SYSTEM_RUNNING)
> >  		return 0;
> >  
> >  	if (sdcasr_mapbase)  
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

This reminds me. My pasemi died. I was trying to see if anyone had an
extra one they could send me ;-)

-- Steve
