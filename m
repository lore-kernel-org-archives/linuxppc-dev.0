Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 459DFDDF7B
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 16:07:07 +1100 (EST)
Date: Wed, 12 Dec 2007 23:12:24 -0600
From: Olof Johansson <olof@lixom.net>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 2/2] kdump shutdown hook support
Message-ID: <20071213051224.GA22378@lixom.net>
References: <1197515777.834799.307108384755.qpush@coopers>
	<20071213031618.DBD207038C@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071213031618.DBD207038C@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, THEMANN@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Thu, Dec 13, 2007 at 02:16:18PM +1100, Michael Neuling wrote:

> Index: clone3/arch/powerpc/kernel/crash.c
> ===================================================================
> --- clone3.orig/arch/powerpc/kernel/crash.c
> +++ clone3/arch/powerpc/kernel/crash.c
> @@ -32,6 +32,8 @@
>  #include <asm/lmb.h>
>  #include <asm/firmware.h>
>  #include <asm/smp.h>
> +#include <asm/system.h>
> +#include <asm/setjmp.h>
>  
>  #ifdef DEBUG
>  #include <asm/udbg.h>
> @@ -45,6 +47,11 @@ int crashing_cpu = -1;
>  static cpumask_t cpus_in_crash = CPU_MASK_NONE;
>  cpumask_t cpus_in_sr = CPU_MASK_NONE;
>  
> +#define CRASH_HANDLER_MAX 1
> +/* NULL terminated list of shutdown handles */
> +static crash_shutdown_t crash_shutdown_handles[CRASH_HANDLER_MAX+1];
> +static DEFINE_SPINLOCK(crash_handers_lock);

How about just using 'handlers' instead of 'handers' and 'handles'? :)

>  static atomic_t enter_on_soft_reset = ATOMIC_INIT(0);
>  
> @@ -285,9 +292,72 @@ static inline void crash_kexec_stop_spus
>  }
>  #endif /* CONFIG_SPU_BASE */
>  
> +/*
> + * Register a function to be called on shutdown.  Only use this if you
> + * can't reset your device in the second kernel.
> + */
> +int crash_shutdown_register(crash_shutdown_t handler)
> +{
> +	unsigned int i, rc;
> +
> +	spin_lock(&crash_handers_lock);
> +	for (i = 0 ; i < CRASH_HANDLER_MAX; i++)
> +		if (!crash_shutdown_handles[i]) {
> +			/* Insert handle at first empty entry */
> +			crash_shutdown_handles[i] = handler;
> +			rc = 0;
> +			break;
> +		}
> +
> +	if (i == CRASH_HANDLER_MAX) {
> +		printk(KERN_ERR "Crash shutdown handles full, "
> +		       "not registered.\n");
> +		rc = 1;
> +	}
> +
> +	spin_unlock(&crash_handers_lock);
> +	return rc;
> +}
> +EXPORT_SYMBOL(crash_shutdown_register);
> +
> +int crash_shutdown_unregister(crash_shutdown_t handler)
> +{
> +	unsigned int i, rc;
> +
> +	spin_lock(&crash_handers_lock);
> +	for (i = 0 ; i < CRASH_HANDLER_MAX; i++)
> +		if (crash_shutdown_handles[i] == handler)
> +			break;
> +
> +	if (i == CRASH_HANDLER_MAX) {
> +		printk(KERN_ERR "Crash shutdown handle not found\n");
> +		rc = 1;
> +	} else {
> +		/* Shift handles down */
> +		for (; crash_shutdown_handles[i]; i++)
> +			crash_shutdown_handles[i] =
> +				crash_shutdown_handles[i+1];
> +		rc = 0;
> +	}
> +
> +	spin_unlock(&crash_handers_lock);
> +	return rc;
> +}
> +EXPORT_SYMBOL(crash_shutdown_unregister);
> +
> +static unsigned long crash_shutdown_buf[SETJMP_BUF_LEN];
> +
> +static int handle_fault(struct pt_regs *regs)
> +{
> +	longjmp(crash_shutdown_buf, 1);
> +	return 0;
> +}
> +
>  void default_machine_crash_shutdown(struct pt_regs *regs)
>  {
> -	unsigned int irq;
> +	unsigned int i;
> +	int (*old_handler)(struct pt_regs *regs);
> +
>  
>  	/*
>  	 * This function is only called after the system
> @@ -301,15 +371,37 @@ void default_machine_crash_shutdown(stru
>  	 */
>  	hard_irq_disable();
>  
> -	for_each_irq(irq) {
> -		struct irq_desc *desc = irq_desc + irq;
> +	for_each_irq(i) {
> +		struct irq_desc *desc = irq_desc + i;
>  
>  		if (desc->status & IRQ_INPROGRESS)
> -			desc->chip->eoi(irq);
> +			desc->chip->eoi(i);
>  
>  		if (!(desc->status & IRQ_DISABLED))
> -			desc->chip->disable(irq);
> +			desc->chip->disable(i);
> +	}
> +
> +	/*
> +	 * Call registered shutdown routines savely.  Swap out
> +	 * __debugger_fault_handler, and replace on exit.
> +	 */
> +	old_handler = __debugger_fault_handler;
> +	__debugger_fault_handler = handle_fault;
> +	for (i = 0; crash_shutdown_handles[i]; i++) {
> +		if (setjmp(crash_shutdown_buf) == 0) {
> +			/*
> +			 * Insert syncs and delay to ensure
> +			 * instructions in the dangerous region don't
> +			 * leak away from this protected region.
> +			 */
> +			asm volatile("sync; isync");
> +			/* dangerous region */
> +			crash_shutdown_handles[i]();
> +			asm volatile("sync; isync");
> +			__delay(SETJMP_MACHINE_CHECK_DELAY);

Where is this defined?

> +		}
>  	}
> +	__debugger_fault_handler = old_handler;
>  
>  	/*
>  	 * Make a note of crashing cpu. Will be used in machine_kexec
> Index: clone3/include/asm-powerpc/kexec.h
> ===================================================================
> --- clone3.orig/include/asm-powerpc/kexec.h
> +++ clone3/include/asm-powerpc/kexec.h
> @@ -123,6 +123,9 @@ struct pt_regs;
>  extern void default_machine_kexec(struct kimage *image);
>  extern int default_machine_kexec_prepare(struct kimage *image);
>  extern void default_machine_crash_shutdown(struct pt_regs *regs);
> +typedef void (*crash_shutdown_t)(void);
> +extern int crash_shutdown_register(crash_shutdown_t handler);
> +extern int crash_shutdown_unregister(crash_shutdown_t handler);
>  
>  extern void machine_kexec_simple(struct kimage *image);
>  extern void crash_kexec_secondary(struct pt_regs *regs);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
