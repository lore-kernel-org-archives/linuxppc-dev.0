Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 2815DDDED3
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 17:46:21 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Kevin Diggs <kevdig@hypersurf.com>
Subject: Re: [PATCH 2/4] Add cpufreq driver for the IBM PowerPC 750GX
Date: Thu, 28 Aug 2008 09:46:09 +0200
References: <48B28F23.1000906@hypersurf.com> <200808271334.16712.arnd@arndb.de>
	<48B5C0AD.9040006@hypersurf.com>
In-Reply-To: <48B5C0AD.9040006@hypersurf.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808280946.10077.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 27 August 2008, Kevin Diggs wrote:
> Arnd Bergmann wrote:
> > 
> > Module parameter names should be short, so just "minmax" would
> > be a good name, but better put the module_param() line right
> > after that. If it's a bool type, I would just leave out the
> > initialization.
> > 
> Ok. But leaving out the initialization will make me itch. Should I
> also replace "override_min_core" with "mincore" (or "min_core")? And
> "override_max_core" with "maxcore" (or "max_core")?
> 
> Leaving out the initializations makes me ... uneasy. It's ok to leave
> them out if they are 0?

Yes, that's how global and static variables are defined in C.
Only automatic variables have undefined content.

> > I think the module_exit() function should leave the frequency in a
> > well-defined state, so the easiest way to get there is probably
> > to delete the timer, and then manually set the frequency.
> > 
> I really don't follow you here? If I let the timer fire then the cpu
> (and the cpufreq sub-system) will be left in a well-defined state. I
> don't understand why you want me to delete the timer and then
> basically do manually what it was going to do anyway. There are two
> calls to cpufreq_notify_transition(). One just before the modify_PLL()
> call, with CPUFREQ_PRECHANGE as an argument, and one in the
> pll_switch_cb() routine, with CPUFREQ_POSTCHANGE as an argument. I
> would need to make sure that these are matched up.
> 
> Even without the HRTimer stuff being used the timer fires in less than
> 4 ms (@ 250 HZ). So I can't see the user actually trying to interrupt
> a frequency change. With HRTimers it is 100 us.
> 
> Can we please, please leave this part as is?

I'm still not convinced that it's actually correct if you call complete()
from the other places as well. You have three locations in your code where
you call complete() but only one for INIT_COMPLETION. The part that I don't
understand (and therefore don't expect other readers to understand) is how
the driver guarantees that only one complete() will be called on the
completion variable after it has been initialized.

What I meant with the well-defined state is that after unloading the module,
the CPU frequency should be the same as before loading the module, typically
the maximum frequency, but not the one that was set last.

	Arnd <><
