Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id AB644DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 21:04:50 +1100 (EST)
Date: Fri, 28 Nov 2008 11:04:46 +0100
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] powerpc/pseries: Fix cpu hotplug
Message-ID: <20081128110446.06189716@bull.net>
In-Reply-To: <20081128001433.GI6830@localdomain>
References: <20081127115952.1f7db89d@bull.net>
	<20081128001433.GI6830@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ppc <linuxppc-dev@ozlabs.org>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Paul Mackerras <paulus@samba.org>, Gilles Carry <Gilles.Carry@ext.bull.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


  Hi Nathan,

On Thu, 27 Nov 2008 18:14:33 -0600 Nathan Lynch <ntl@pobox.com> wrote:

> Hi, I have some questions about this patch.
> 
> Sebastien Dugue wrote:
> > 
> >   Currently, pseries_cpu_die() calls msleep() while polling RTAS for
> > the status of the dying cpu.
> > 
> >   However if the cpu that is going down also happens to be the one doing
> > the tick then we're hosed as the tick_do_timer_cpu 'baton' is only passed
> > later on in tick_shutdown() when _cpu_down() does the CPU_DEAD notification.
> > Therefore jiffies won't be updated anymore.
> 
> I confess unfamiliarity with the tick/timer code, but this sounds like
> something that should be addressed earlier in the process of taking
> down a CPU.

  Maybe you're right, at least the tick_do_timer_cpu should be changed earlier
in the down process, but I'm not sure where we can do that.

> 
> 
> >   This patch replaces that msleep() with a cpu_relax() to make sure we're
> > not going to schedule at that point.
> 
> This is a significant change in behavior.  With the msleep(), we poll
> for at least five seconds before giving up; with the cpu_relax(), the
> period will almost certainly be much shorter and we're likely to give
> up too soon in some circumstances.

  Right, I realized a bit late that that would indeed change the
behaviour. On my test box (2 Power6) the msleep call is hit in ~10 % of the
cases and only loop once, but that may not be the case for all the pSeries
out there where a longer delay might be needed.

>  Could be addressed by using
> mdelay(), but...

  Yep, would be better. I'm still wondering why the hang is not systematic
when offlining the tick_do_timer_cpu, I must have missed something in
my analysis and there might be a race somewhere I failed to identify.

> 
> It's just not clear to me how busy-waiting in the __cpu_die() path is
> a legitimate fix.  Is sleeping in this path forbidden now?

  In that case, I think it is if the cpu going down is also doing the
tick.

>  (I notice
> at least native_cpu_die() in x86 does msleep(), btw.)

  Right, as most other arches do, but the thing is that on those, you
cannot offline CPU0, whereas on power (and maybe otheres too) you can.

> 
> As it can take several milliseconds for RTAS to report a CPU
> offline, and the maximum latency of the operation is unspecified, it
> seems inappropriate to tie up the waiting CPU this way.

  Agreed.

> 
> 
> >   With this patch my test box survives a 100k iterations hotplug stress
> > test on _all_ cpus, whereas without it, it quickly dies after ~50 iterations.
> 
> What is the failure (e.g. stack trace, kernel messages)?

  No stack trace, no kernel messages, nothing :( When that happens, the
cpus get stuck in idle and won't reschedule at all.

  I verified that the decrementer is still ticking, hrtimers are still
running but regular timers are stuck. Changing the tick_do_timer_cpu manually
under xmon resurects the box.

  Will have to look at this a bit more.

  Thanks,

  Sebastien.



 
