Return-Path: <sshtylyov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 4D420DDE0E
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 04:25:57 +1000 (EST)
Message-ID: <461FCB6F.7010504@ru.mvista.com>
Date: Fri, 13 Apr 2007 22:26:55 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [PATCH] add reg and stack dump to booke WD handler
References: <20070413173524.GA17890@blade.az.mvista.com>
In-Reply-To: <20070413173524.GA17890@blade.az.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dave Jiang wrote:
> Have the booke watchdog dump some useful information when triggered. Hopefully
> that'll give the user some hint of what happened rather than just a mysterious
> reboot. 

   Why not do this in drivers/watchdog/booke_wdt.c -- WatchdogHandler() is a weak symbol?
 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index f786222..1af83b7 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1108,9 +1108,42 @@ void unrecoverable_exception(struct pt_regs *regs)
>   */
>  void __attribute__ ((weak)) WatchdogHandler(struct pt_regs *regs)
>  {
> +	unsigned long flags;
> +
>  	/* Generic WatchdogHandler, implement your own */
>  	mtspr(SPRN_TCR, mfspr(SPRN_TCR)&(~TCR_WIE));
> -	return;
> +	oops_enter();
> +
> +	console_verbose();
> +	bust_spinlocks(1);
> +	local_save_flags(flags);
> +
> +	printk(KERN_ERR "PowerPC Book-E Watchdog detected LOCKUP\n");
> +	printk(KERN_ERR "Watchdog exception at PC=%lx MSR=%lx\n",

   This partly duplicates printk() in WatchdogException().

> +			regs->nip, regs->msr);

  These regs are later dumped by show_regs() anyway.

> +#ifdef CONFIG_PREEMPT
> +	printk(KERN_ERR "PREEMPT ");

   Does specifying loglevel on non '\n' terminated lines really make sense?  I suspect all what you'll get will be ugly output with <3> insterted here and there.

> +#endif
> +#ifdef CONFIG_SMP
> +	printk(KERN_ERR "SMP NR_CPUS=%d ", NR_CPUS);
> +#endif
> +#ifdef CONFIG_DEBUG_PAGEALLOC
> +	printk(KERN_ERR "DEBUG_PAGEALLOC ");
> +#endif
> +#ifdef CONFIG_NUMA
> +	printk(KERN_ERR "NUMA ");
> +#endif
> +	printk(KERN_ERR "%s\n", ppc_md.name ? ppc_md.name : "");
> +
> +	print_modules();
> +	show_regs(regs);
> +
> +	bust_spinlocks(0);
> +
> +	printk(KERN_ERR "Wating for hardware watchdog reset...\n");

   A typo here.

> +	/* spin until hardware reset */
> +	while(1)
> +		cpu_relax();

   Not even giving it a chance? That's cruel. :-)
   Seriously, this seems too specific watchdog behavior to be here.

WBR, Sergei
