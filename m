Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B9EC22C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 10:33:28 +1100 (EST)
Message-ID: <1382139147.7979.934.camel@snotra.buserror.net>
Subject: Re: [v5][PATCH 6/6] book3e/kgdb: Fix a single stgep case of lazy IRQ
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Fri, 18 Oct 2013 18:32:27 -0500
In-Reply-To: <1371724110-8250-7-git-send-email-tiejun.chen@windriver.com>
References: <1371724110-8250-1-git-send-email-tiejun.chen@windriver.com>
 <1371724110-8250-7-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-06-20 at 18:28 +0800, Tiejun Chen wrote:
> When we're in kgdb_singlestep(), we have to work around to get
> thread_info by copying from the kernel stack before calling
> kgdb_handle_exception(), then copying it back afterwards.
> 
> But for PPC64, we have a lazy interrupt implementation. So after
> copying thread info frome kernle stack, if we need to replay an
> interrupt, we shouldn't restore that previous backup thread info
> to make sure we can replay an interrupt lately with a proper
> thread info.

Explain why copying it would be a problem.

> This patch use __check_irq_replay() to guarantee this process.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/kernel/irq.c  |   10 ++++++++++
>  arch/powerpc/kernel/kgdb.c |    3 ++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index ea185e0..3625453 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -339,7 +339,17 @@ bool prep_irq_for_idle(void)
>  	return true;
>  }
>  
> +notrace unsigned int check_irq_replay(void)
> +{
> +	return __check_irq_replay();
> +}
> +#else
> +notrace unsigned int check_irq_replay(void)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_PPC64 */
> +EXPORT_SYMBOL(check_irq_replay);
>  
>  int arch_show_interrupts(struct seq_file *p, int prec)
>  {
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index cde7818..5b30408 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -152,6 +152,7 @@ static int kgdb_handle_breakpoint(struct pt_regs *regs)
>  }
>  
>  static DEFINE_PER_CPU(struct thread_info, kgdb_thread_info);
> +extern notrace unsigned int check_irq_replay(void);

Please put prototypes in headers rather than C files.  Also, "extern" is
unnecessary on function prototypes.

>  static int kgdb_singlestep(struct pt_regs *regs)
>  {
>  	struct thread_info *thread_info, *exception_thread_info;
> @@ -181,7 +182,7 @@ static int kgdb_singlestep(struct pt_regs *regs)
>  
>  	kgdb_handle_exception(0, SIGTRAP, 0, regs);
>  
> -	if (thread_info != exception_thread_info)
> +	if ((thread_info != exception_thread_info) && (!check_irq_replay()))

Unnecessary parentheses.

Are you sure it's safe to call this here?  Won't __check_irq_replay()
clear the pending event and PACA_IRQ_HARD_DIS?

-Scott
