Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 50BC42C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 06:07:20 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Thu, 12 Sep 2013 01:28:56 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7E152394005B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 01:36:58 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8BK99D336438016
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 01:39:09 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8BK79Dw023829
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 01:37:10 +0530
Message-ID: <5230CC84.1010503@linux.vnet.ibm.com>
Date: Thu, 12 Sep 2013 01:33:16 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jiang Liu <liuj97@gmail.com>
Subject: Re: [RFC PATCH v2 15/25] smp, ppc: kill SMP single function call
 interrupt
References: <1378915649-16395-1-git-send-email-liuj97@gmail.com>
 <1378915649-16395-16-git-send-email-liuj97@gmail.com>
In-Reply-To: <1378915649-16395-16-git-send-email-liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Jiri Kosina <trivial@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 linuxppc-dev@lists.ozlabs.org, Wang YanQing <udknight@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shaohua Li <shli@kernel.org>,
 Ingo Molnar <mingo@elte.hu>, Jiang Liu <jiang.liu@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/11/2013 09:37 PM, Jiang Liu wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
> 
> Commit 9a46ad6d6df3b54 "smp: make smp_call_function_many() use logic
> similar to smp_call_function_single()" has unified the way to handle
> single and multiple cross-CPU function calls. Now only one interrupt
> is needed for architecture specific code to support generic SMP function
> call interfaces, so kill the redundant single function call interrupt.
> 
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Cc: Jiang Liu <liuj97@gmail.com>
> ---

It turns out that freeing up the IPI slot in powerpc is very useful, since
we actually wanted a slot for some other use-case (and there are only 4 slots
available on powerpc).

Here are the patches which achieve that:
http://marc.info/?l=linuxppc-embedded&m=137886807502898&w=2
http://marc.info/?l=linuxppc-embedded&m=137886811502909&w=2

So, can you kindly consider dropping the powerpc patch from your series,
if that is OK with you? Thanks!

BTW, after doing the powerpc cleanup, even I had thought about killing one
of the smp-function variants in various architectures, but never got around
to do it. But now that you have posted the series which does that, I'll try
to review them.

Thank you!

Regards,
Srivatsa S. Bhat

>  arch/powerpc/include/asm/smp.h |  3 +--
>  arch/powerpc/kernel/smp.c      | 12 +-----------
>  2 files changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
> index 48cfc85..53faa03 100644
> --- a/arch/powerpc/include/asm/smp.h
> +++ b/arch/powerpc/include/asm/smp.h
> @@ -119,8 +119,7 @@ extern int cpu_to_core_id(int cpu);
>   * in /proc/interrupts will be wrong!!! --Troy */
>  #define PPC_MSG_CALL_FUNCTION   0
>  #define PPC_MSG_RESCHEDULE      1
> -#define PPC_MSG_CALL_FUNC_SINGLE	2
> -#define PPC_MSG_DEBUGGER_BREAK  3
> +#define PPC_MSG_DEBUGGER_BREAK  2
> 
>  /* for irq controllers that have dedicated ipis per message (4) */
>  extern int smp_request_message_ipi(int virq, int message);
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 38b0ba6..0c53b10 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -123,12 +123,6 @@ static irqreturn_t reschedule_action(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
> 
> -static irqreturn_t call_function_single_action(int irq, void *data)
> -{
> -	generic_smp_call_function_single_interrupt();
> -	return IRQ_HANDLED;
> -}
> -
>  static irqreturn_t debug_ipi_action(int irq, void *data)
>  {
>  	if (crash_ipi_function_ptr) {
> @@ -146,14 +140,12 @@ static irqreturn_t debug_ipi_action(int irq, void *data)
>  static irq_handler_t smp_ipi_action[] = {
>  	[PPC_MSG_CALL_FUNCTION] =  call_function_action,
>  	[PPC_MSG_RESCHEDULE] = reschedule_action,
> -	[PPC_MSG_CALL_FUNC_SINGLE] = call_function_single_action,
>  	[PPC_MSG_DEBUGGER_BREAK] = debug_ipi_action,
>  };
> 
>  const char *smp_ipi_name[] = {
>  	[PPC_MSG_CALL_FUNCTION] =  "ipi call function",
>  	[PPC_MSG_RESCHEDULE] = "ipi reschedule",
> -	[PPC_MSG_CALL_FUNC_SINGLE] = "ipi call function single",
>  	[PPC_MSG_DEBUGGER_BREAK] = "ipi debugger",
>  };
> 
> @@ -225,8 +217,6 @@ irqreturn_t smp_ipi_demux(void)
>  			generic_smp_call_function_interrupt();
>  		if (all & (1 << (24 - 8 * PPC_MSG_RESCHEDULE)))
>  			scheduler_ipi();
> -		if (all & (1 << (24 - 8 * PPC_MSG_CALL_FUNC_SINGLE)))
> -			generic_smp_call_function_single_interrupt();
>  		if (all & (1 << (24 - 8 * PPC_MSG_DEBUGGER_BREAK)))
>  			debug_ipi_action(0, NULL);
>  #else
> @@ -257,7 +247,7 @@ EXPORT_SYMBOL_GPL(smp_send_reschedule);
> 
>  void arch_send_call_function_single_ipi(int cpu)
>  {
> -	do_message_pass(cpu, PPC_MSG_CALL_FUNC_SINGLE);
> +	do_message_pass(cpu, PPC_MSG_CALL_FUNCTION);
>  }
> 
>  void arch_send_call_function_ipi_mask(const struct cpumask *mask)
> 
