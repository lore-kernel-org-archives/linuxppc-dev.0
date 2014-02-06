Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6749A2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 03:09:13 +1100 (EST)
Received: by mail-qa0-f51.google.com with SMTP id f11so3053537qae.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Feb 2014 08:09:11 -0800 (PST)
Date: Thu, 6 Feb 2014 16:09:08 +0000 (GMT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] ARM64: powernv: remove redundant cpuidle_idle_call()
In-Reply-To: <52F3B17E.4040209@linux.vnet.ibm.com>
Message-ID: <alpine.LFD.2.11.1402061607290.1906@knanqh.ubzr>
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
 <1391696188-14540-2-git-send-email-nicolas.pitre@linaro.org>
 <52F3B17E.4040209@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 6 Feb 2014, Preeti U Murthy wrote:

> Hi Nicolas,
> 
> powernv in the subject of the patch?

Crap.  You're right.

That's what you get when posting patches while attending a meeting.



> 
> Regards
> Preeti U Murthy
> On 02/06/2014 07:46 PM, Nicolas Pitre wrote:
> > The core idle loop now takes care of it.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > ---
> >  arch/arm64/kernel/process.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 1c0a9be2ff..9cce0098f4 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -33,7 +33,6 @@
> >  #include <linux/kallsyms.h>
> >  #include <linux/init.h>
> >  #include <linux/cpu.h>
> > -#include <linux/cpuidle.h>
> >  #include <linux/elfcore.h>
> >  #include <linux/pm.h>
> >  #include <linux/tick.h>
> > @@ -94,10 +93,8 @@ void arch_cpu_idle(void)
> >  	 * This should do all the clock switching and wait for interrupt
> >  	 * tricks
> >  	 */
> > -	if (cpuidle_idle_call()) {
> > -		cpu_do_idle();
> > -		local_irq_enable();
> > -	}
> > +	cpu_do_idle();
> > +	local_irq_enable();
> >  }
> > 
> >  #ifdef CONFIG_HOTPLUG_CPU
> > 
> 
