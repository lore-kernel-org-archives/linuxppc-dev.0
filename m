Return-Path: <fweisbec@gmail.com>
Received: from mail-wg0-x22e.google.com (mail-wg0-x22e.google.com
 [IPv6:2a00:1450:400c:c00::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2660F2C00E0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 23:30:56 +1000 (EST)
Received: by mail-wg0-f46.google.com with SMTP id k13so1622163wgh.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 06:30:50 -0700 (PDT)
Date: Thu, 25 Jul 2013 15:30:46 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 4/5] cpuidle/ppc: CPU goes tickless if there are no
 arch-specific constraints
Message-ID: <20130725133044.GA7400@somewhere>
References: <20130725090016.12500.28888.stgit@preeti.in.ibm.com>
 <20130725090302.12500.42998.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130725090302.12500.42998.stgit@preeti.in.ibm.com>
Cc: rjw@sisk.pl, shangw@linux.vnet.ibm.com, arnd@arndb.de,
 linux-pm@vger.kernel.org, geoff@infradead.org, rostedt@goodmis.org,
 deepthi@linux.vnet.ibm.com, paul.gortmaker@windriver.com, paulus@samba.org,
 srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
 john.stultz@linaro.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 chenhui.zhao@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 25, 2013 at 02:33:02PM +0530, Preeti U Murthy wrote:
> In the current design of timer offload framework, the broadcast cpu should
> *not* go into tickless idle so as to avoid missed wakeups on CPUs in deep idle states.
> 
> Since we prevent the CPUs entering deep idle states from programming the lapic of the
> broadcast cpu for their respective next local events for reasons mentioned in
> PATCH[3/5], the broadcast CPU checks if there are any CPUs to be woken up during
> each of its timer interrupt programmed to its local events.
> 
> With tickless idle, the broadcast CPU might not get a timer interrupt till after
> many ticks which can result in missed wakeups on CPUs in deep idle states. By
> disabling tickless idle, worst case, the tick_sched hrtimer will trigger a
> timer interrupt every period to check for broadcast.
> 
> However the current setup of tickless idle does not let us make the choice
> of tickless on individual cpus. NOHZ_MODE_INACTIVE which disables tickless idle,
> is a system wide setting. Hence resort to an arch specific call to check if a cpu
> can go into tickless idle.

Hi Preeti,

I'm not exactly sure why you can't enter the broadcast CPU in dynticks idle mode.
I read in the previous patch that's because in dynticks idle mode the broadcast
CPU deactivates its lapic so it doesn't receive the IPI. But may be I misunderstood.
Anyway that's not good for powersaving.

Also when an arch wants to prevent a CPU from entering dynticks idle mode, it typically
use arch_needs_cpu(). May be that could fit for you as well?

Thanks.
