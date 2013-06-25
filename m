Return-Path: <michael@ellerman.id.au>
Date: Tue, 25 Jun 2013 12:08:42 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 40/45] powerpc, irq: Use GFP_ATOMIC allocations in atomic
 context
Message-ID: <20130625020842.GD14051@concordia>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
 <20130623134657.19094.93687.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130623134657.19094.93687.stgit@srivatsabhat.in.ibm.com>
Cc: peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, walken@google.com, mingo@kernel.org,
 linux-arch@vger.kernel.org, vincent.guittot@linaro.org,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 Ian Munsie <imunsie@au1.ibm.com>, namhyung@kernel.org, tglx@linutronix.de,
 laijs@cn.fujitsu.com, zhong@linux.vnet.ibm.com, netdev@vger.kernel.org,
 oleg@redhat.com, sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 23, 2013 at 07:17:00PM +0530, Srivatsa S. Bhat wrote:
> The function migrate_irqs() is called with interrupts disabled
> and hence its not safe to do GFP_KERNEL allocations inside it,
> because they can sleep. So change the gfp mask to GFP_ATOMIC.

OK so it gets there via:
  __stop_machine()
    take_cpu_down()
      __cpu_disable()
        smp_ops->cpu_disable()
          generic_cpu_disable()
            migrate_irqs()

> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index ea185e0..ca39bac 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -412,7 +412,7 @@ void migrate_irqs(void)
>  	cpumask_var_t mask;
>  	const struct cpumask *map = cpu_online_mask;
>  
> -	alloc_cpumask_var(&mask, GFP_KERNEL);
> +	alloc_cpumask_var(&mask, GFP_ATOMIC);

We're not checking for allocation failure, which we should be.

But this code is only used on powermac and 85xx, so it should probably
just be a TODO to fix this up to handle the failure.

cheers
