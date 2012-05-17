Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D16FFB6FC3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2012 14:28:41 +1000 (EST)
Message-ID: <1337228910.30558.46.camel@pasglop>
Subject: Re: [PATCH powerpc] fix a lockdep complaint in start_secondary
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Date: Thu, 17 May 2012 14:28:30 +1000
In-Reply-To: <1337227263.24471.23.camel@ThinkPad-T420>
References: <1337227263.24471.23.camel@ThinkPad-T420>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>,
 deepthi@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-05-17 at 12:01 +0800, Li Zhong wrote:
> This patch tries to fix following lockdep complaints:

 .../...

> pseries_notify_cpu_idle_add_cpu() actually does
> cpuidle_disable_device(), and then cpuidle_enable_device(), which
> releases and allocates the resources respectively. ( Also, all the data
> are cleared and reinitialized after this cycle). The problem here is:
> something like kzalloc(GFP_KERNEL), wait_for_completion() would have
> problems running here where irqs are still disabled. 

So yes, it looks definitely fishy. I don't have time to study cpuidle
today to check whether that's correct or not so I'm CCing Deepthi
Dharwar who did all that cpuidle work for pseries.

Deepthi, can you check whether that patch is correct ?

> Actually, cpuidle_enable_device() is called for each possible cpu when
> the driver is registered. So I don't think the resources needed to be
> released and allocated each time cpu becomes online. Something like
> cpuidle_reset_device() would be enough to clear and reinitialize the
> data.
> 
> However, after some studying of the data to be cleared, I think it's
> also reasonable to keep the previous data. For example: 
> 
> /sys/devices/system/cpu/cpu#/cpuidle/state#/usage 
>         the number of times this idle state has been entered
> /sys/devices/system/cpu/cpu#/cpuidle/state#/time
>         the amount of time spent in this idle state
> 
> So I think we could just remove the function call doing the
> disable/enable cycle:
> 
> Please correct me if I missed anything. 
> 
> Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/smp.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/smp.c
> b/arch/powerpc/platforms/pseries/smp.c
> index e16bb8d..71706bc 100644
> --- a/arch/powerpc/platforms/pseries/smp.c
> +++ b/arch/powerpc/platforms/pseries/smp.c
> @@ -147,7 +147,6 @@ static void __devinit smp_xics_setup_cpu(int cpu)
>  	set_cpu_current_state(cpu, CPU_STATE_ONLINE);
>  	set_default_offline_state(cpu);
>  #endif
> -	pseries_notify_cpuidle_add_cpu(cpu);
>  }
>  
>  static int __devinit smp_pSeries_kick_cpu(int nr)
