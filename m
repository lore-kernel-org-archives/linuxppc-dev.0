Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: "Ian Munsie" <imunsie@au1.ibm.com>
Subject: Re: [PATCH] powerpc: Add accounting for Doorbell interrupts
In-reply-to: <1363765332-28461-1-git-send-email-imunsie@au1.ibm.com>
References: <1363765332-28461-1-git-send-email-imunsie@au1.ibm.com>
Date: Thu, 21 Mar 2013 11:28:37 +1100
Message-ID: <3519.1363825717@ale.ozlabs.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This patch adds a new line to /proc/interrupts to account for the
> doorbell interrupts that each hardware thread has received. The total
> interrupt count in /proc/stat will now also include doorbells.

It's probably worth noting in the comment that these are not being
accounted at all currently, even in the existing IPI line in
/proc/interrupts.

Mikey

>  # cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>  16:        551       1267        281        175      XICS Level     IPI
> LOC:       2037       1503       1688       1625   Local timer interrupts
> SPU:          0          0          0          0   Spurious interrupts
> CNT:          0          0          0          0   Performance monitoring interrupts
> MCE:          0          0          0          0   Machine check exceptions
> DBL:         42        550         20         91   Doorbell interrupts
>
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> ---
>  arch/powerpc/include/asm/hardirq.h |    1 +
>  arch/powerpc/kernel/dbell.c        |    2 ++
>  arch/powerpc/kernel/irq.c          |    8 ++++++++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
> index 3147a29..e88c5f2 100644
> --- a/arch/powerpc/include/asm/hardirq.h
> +++ b/arch/powerpc/include/asm/hardirq.h
> @@ -10,6 +10,7 @@ typedef struct {
>  	unsigned int pmu_irqs;
>  	unsigned int mce_exceptions;
>  	unsigned int spurious_irqs;
> +	unsigned int doorbell_irqs;
>  } ____cacheline_aligned irq_cpustat_t;
>  
>  DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
> diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
> index 9ebbc24..d55c76c 100644
> --- a/arch/powerpc/kernel/dbell.c
> +++ b/arch/powerpc/kernel/dbell.c
> @@ -41,6 +41,8 @@ void doorbell_exception(struct pt_regs *regs)
>  
>  	may_hard_irq_enable();
>  
> +	__get_cpu_var(irq_stat).doorbell_irqs++;
> +
>  	smp_ipi_demux();
>  
>  	irq_exit();
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 4f97fe3..3a3c3b9 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -374,6 +374,13 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>  		seq_printf(p, "%10u ", per_cpu(irq_stat, j).mce_exceptions);
>  	seq_printf(p, "  Machine check exceptions\n");
>  
> +	if (cpu_has_feature(CPU_FTR_DBELL)) {
> +		seq_printf(p, "%*s: ", prec, "DBL");
> +		for_each_online_cpu(j)
> +			seq_printf(p, "%10u ", per_cpu(irq_stat, j).doorbell_irqs);
> +		seq_printf(p, "  Doorbell interrupts\n");
> +	}
> +
>  	return 0;
>  }
>  
> @@ -387,6 +394,7 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
>  	sum += per_cpu(irq_stat, cpu).pmu_irqs;
>  	sum += per_cpu(irq_stat, cpu).mce_exceptions;
>  	sum += per_cpu(irq_stat, cpu).spurious_irqs;
> +	sum += per_cpu(irq_stat, cpu).doorbell_irqs;
>  
>  	return sum;
>  }
> -- 
> 1.7.10.4
> 
