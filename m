Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7E089B6FF4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2012 12:55:43 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 18 May 2012 02:47:08 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4I2ls8534865344
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2012 12:47:55 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4I2t6B7010615
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2012 12:55:06 +1000
Message-ID: <1337309699.2626.11.camel@ThinkPad-T420>
Subject: Re: [PATCH powerpc] fix a lockdep complaint in start_secondary
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Fri, 18 May 2012 10:54:59 +0800
In-Reply-To: <4FB4D14A.20903@linux.vnet.ibm.com>
References: <1337227263.24471.23.camel@ThinkPad-T420>
 <1337228910.30558.46.camel@pasglop> <4FB4D14A.20903@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-05-17 at 15:52 +0530, Deepthi Dharwar wrote:
> On 05/17/2012 09:58 AM, Benjamin Herrenschmidt wrote:
> 
> > On Thu, 2012-05-17 at 12:01 +0800, Li Zhong wrote:
> >> This patch tries to fix following lockdep complaints:
> > 
> >  .../...
> > 
> >> pseries_notify_cpu_idle_add_cpu() actually does
> >> cpuidle_disable_device(), and then cpuidle_enable_device(), which
> >> releases and allocates the resources respectively. ( Also, all the data
> >> are cleared and reinitialized after this cycle). The problem here is:
> >> something like kzalloc(GFP_KERNEL), wait_for_completion() would have
> >> problems running here where irqs are still disabled. 
> 
> 
> This is true when the system is booting up.
> 
> > 
> > So yes, it looks definitely fishy. I don't have time to study cpuidle
> > today to check whether that's correct or not so I'm CCing Deepthi
> > Dharwar who did all that cpuidle work for pseries.
> > 
> > Deepthi, can you check whether that patch is correct ?
> 
> 
> pseries_notify_cpu_idle_add_cpu() is essential to be called for
> hotplug event. So by removing this call completely wouldn't
> support cpus registering under cpuidle on hotplug and default idle is
> executed on those with do not give much powersavings. 

Maybe I missed that part.. would you please give some details how
removing this would prevent powersaving cpuidle being called after
hotplug? 

After rereading the codes, I think ppc_md.power_save() is the one you
mentioned that could give much powersavings? 

It is registered as pSeries_idle(), which calls cpuidle_idle_call(). 
It seems to me that it would still be called after hotplug. 

Or maybe I misunderstood your point? 

> Ideal way it to
> have a notifier in pseries backend driver for hotplug notification and
> then remove this function from here.
> I am currently working on this patch, will post it out soon.
> 
> > 
> >> Actually, cpuidle_enable_device() is called for each possible cpu when
> >> the driver is registered. So I don't think the resources needed to be
> >> released and allocated each time cpu becomes online. Something like
> >> cpuidle_reset_device() would be enough to clear and reinitialize the
> >> data.
> >>
> >> However, after some studying of the data to be cleared, I think it's
> >> also reasonable to keep the previous data. For example: 
> >>
> >> /sys/devices/system/cpu/cpu#/cpuidle/state#/usage 
> >>         the number of times this idle state has been entered
> >> /sys/devices/system/cpu/cpu#/cpuidle/state#/time
> >>         the amount of time spent in this idle state
> >>
> >> So I think we could just remove the function call doing the
> >> disable/enable cycle:
> >>
> >> Please correct me if I missed anything.
> 
> 
> If removed, this would not handle cpu hotplug events for cpuidle.
> 
> 
> >>
> >> Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> >> Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >> ---
> >>  arch/powerpc/platforms/pseries/smp.c |    1 -
> >>  1 files changed, 0 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/arch/powerpc/platforms/pseries/smp.c
> >> b/arch/powerpc/platforms/pseries/smp.c
> >> index e16bb8d..71706bc 100644
> >> --- a/arch/powerpc/platforms/pseries/smp.c
> >> +++ b/arch/powerpc/platforms/pseries/smp.c
> >> @@ -147,7 +147,6 @@ static void __devinit smp_xics_setup_cpu(int cpu)
> >>  	set_cpu_current_state(cpu, CPU_STATE_ONLINE);
> >>  	set_default_offline_state(cpu);
> >>  #endif
> >> -	pseries_notify_cpuidle_add_cpu(cpu);
> >>  }
> >>  
> >>  static int __devinit smp_pSeries_kick_cpu(int nr)
> > 
> > 
> > 
> 
> Cheers,
> Deepthi
