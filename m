Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D08A2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2012 12:17:55 +1100 (EST)
Message-ID: <508741B3.5000002@windriver.com>
Date: Wed, 24 Oct 2012 09:17:39 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: <benh@kernel.crashing.org>
Subject: Re: [v2][PATCH 1/2] powerpc/kgdb: Fix a single stgep case of lazy IRQ
References: <1350528455-4751-1-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1350528455-4751-1-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, jason.wessel@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Please ignore v2 temporarily since I have to correct something lately.

Sorry for any inconvenience.

Tiejun

On 10/18/2012 10:47 AM, Tiejun Chen wrote:
> When we're in kgdb_singlestep(), we have to work around to get
> thread_info by copying from the kernel stack before calling
> kgdb_handle_exception(), then copying it back afterwards.
>
> But for PPC64, we have a lazy interrupt implementation. So after
> copying thread info frome kernle stack, if we need to replay an
> interrupt, we shouldn't restore that previous backup thread info
> to make sure we can replay an interrupt lately with a proper
> thread info.
>
> This patch use __check_irq_replay() to guarantee this process.
>
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>   arch/powerpc/kernel/irq.c  |   12 +++++++++++-
>   arch/powerpc/kernel/kgdb.c |    7 ++++---
>   2 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 71413f4..a773789 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -332,7 +332,17 @@ bool prep_irq_for_idle(void)
>   	return true;
>   }
>
> -#endif /* CONFIG_PPC64 */
> +notrace unsigned int check_irq_replay(void)
> +{
> +	return __check_irq_replay();
> +}
> +#else /* CONFIG_PPC64 */
> +notrace unsigned int check_irq_replay(void)
> +{
> +	return 0;
> +}
> +#endif /* !CONFIG_PPC64 */
> +EXPORT_SYMBOL(check_irq_replay);
>
>   int arch_show_interrupts(struct seq_file *p, int prec)
>   {
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index c470a40..c4af341 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -151,6 +151,7 @@ static int kgdb_handle_breakpoint(struct pt_regs *regs)
>   	return 1;
>   }
>
> +extern notrace unsigned int check_irq_replay(void);
>   static int kgdb_singlestep(struct pt_regs *regs)
>   {
>   	struct thread_info *thread_info, *exception_thread_info;
> @@ -181,9 +182,9 @@ static int kgdb_singlestep(struct pt_regs *regs)
>
>   	kgdb_handle_exception(0, SIGTRAP, 0, regs);
>
> -	if (thread_info != exception_thread_info)
> -		/* Restore current_thread_info lastly. */
> -		memcpy(exception_thread_info, backup_current_thread_info, sizeof *thread_info);
> +	if ((thread_info != exception_thread_info) && (!check_irq_replay()))
> +		/* Restore current_thread_info lastly only if we don't replay interrupt. */
> +			memcpy(exception_thread_info, backup_current_thread_info, sizeof *thread_info);
>
>   	return 1;
>   }
>
