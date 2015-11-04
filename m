Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 369CC1A0B7C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 23:35:27 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 22:35:23 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0016B2BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 23:35:18 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4CZAhR50200722
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 23:35:18 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4CYj3o029583
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 23:34:46 +1100
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: on crash, kexec'ed kernel needs all CPUs are
 online
To: Laurent Vivier <lvivier@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <1444935658-27319-1-git-send-email-lvivier@redhat.com>
Cc: dgibson@redhat.com, thuth@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-ID: <5639FB4A.7020508@linux.vnet.ibm.com>
Date: Wed, 4 Nov 2015 18:04:18 +0530
MIME-Version: 1.0
In-Reply-To: <1444935658-27319-1-git-send-email-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/16/2015 12:30 AM, Laurent Vivier wrote:
> On kexec, all secondary offline CPUs are onlined before
> starting the new kernel, this is not done in the case of kdump.
>
> If kdump is configured and a kernel crash occurs whereas
> some secondaries CPUs are offline (SMT=off),
> the new kernel is not able to start them and displays some
> "Processor X is stuck.".
>
> Starting with POWER8, subcore logic relies on all threads of
> core being booted. So, on startup kernel tries to start all
> threads, and asks OPAL (or RTAS) to start all CPUs (including
> threads). If a CPU has been offlined by the previous kernel,
> it has not been returned to OPAL, and thus OPAL cannot restart
> it: this CPU has been lost...
>
> Signed-off-by: Laurent Vivier<lvivier@redhat.com>


Hi Laurent,

Sorry for jumping too late into this.
Are you seeing this issue even with the below patches:

pseries:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c1caae3de46a072d0855729aed6e793e536a4a55

opal/powernv:
https://github.com/open-power/skiboot/commit/9ee56b5

Thanks
Hari

> ---
>   arch/powerpc/kernel/crash.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
> index 51dbace..3ca9452 100644
> --- a/arch/powerpc/kernel/crash.c
> +++ b/arch/powerpc/kernel/crash.c
> @@ -19,6 +19,7 @@
>   #include <linux/delay.h>
>   #include <linux/irq.h>
>   #include <linux/types.h>
> +#include <linux/cpu.h>
>   
>   #include <asm/processor.h>
>   #include <asm/machdep.h>
> @@ -299,11 +300,30 @@ int crash_shutdown_unregister(crash_shutdown_t handler)
>   }
>   EXPORT_SYMBOL(crash_shutdown_unregister);
>   
> +/*
> + * The next kernel will try to start all secondary CPUs and if
> + * there are not online it will fail to start them.
> + *
> + */
> +static void wake_offline_cpus(void)
> +{
> +	int cpu = 0;
> +
> +	for_each_present_cpu(cpu) {
> +		if (!cpu_online(cpu)) {
> +			pr_info("kexec: Waking offline cpu %d.\n", cpu);
> +			cpu_up(cpu);
> +		}
> +	}
> +}
> +
>   void default_machine_crash_shutdown(struct pt_regs *regs)
>   {
>   	unsigned int i;
>   	int (*old_handler)(struct pt_regs *regs);
>   
> +	wake_offline_cpus();
> +
>   	/*
>   	 * This function is only called after the system
>   	 * has panicked or is otherwise in a critical state.
