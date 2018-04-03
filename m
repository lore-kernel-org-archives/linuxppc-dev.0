Return-Path: <prvs=0631b20b45=hegdevasant@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40FbsR2LbrzF1pD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 14:36:55 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w334Y8X5066074
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Apr 2018 00:36:53 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h40g0417n-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 00:36:53 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Tue, 3 Apr 2018 05:36:51 +0100
Subject: Re: [PATCH v2 3/3] powerpc/powernv: Always stop secondaries before
 reboot/shutdown
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20180401103615.15454-1-npiggin@gmail.com>
 <20180401103615.15454-4-npiggin@gmail.com>
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Tue, 3 Apr 2018 10:06:46 +0530
MIME-Version: 1.0
In-Reply-To: <20180401103615.15454-4-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1bcb480a-b396-9e14-c235-41c2d73d95b9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/01/2018 04:06 PM, Nicholas Piggin wrote:
> Currently powernv reboot and shutdown requests just leave secondaries
> to do their own things. This is undesirable because they can trigger
> any number of watchdogs while waiting for reboot, but also we don't
> know what else they might be doing -- they might be causing trouble,
> trampling memory, etc.
> 
> The opal scheduled flash update code already ran into watchdog problems
> due to flashing taking a long time, and it was fixed with 2196c6f1ed
> ("powerpc/powernv: Return secondary CPUs to firmware before FW update"),
> which returns secondaries to opal. It's been found that regular reboots
> can take over 10 seconds, which can result in the hard lockup watchdog
> firing,
> 
>    reboot: Restarting system
>    [  360.038896709,5] OPAL: Reboot request...
>    Watchdog CPU:0 Hard LOCKUP
>    Watchdog CPU:44 detected Hard LOCKUP other CPUS:16
>    Watchdog CPU:16 Hard LOCKUP
>    watchdog: BUG: soft lockup - CPU#16 stuck for 3s! [swapper/16:0]
> 
> This patch removes the special case for flash update, and calls
> smp_send_stop in all cases before calling reboot/shutdown.
> 
> smp_send_stop could return CPUs to OPAL, the main reason not to is
> that the request could come from a NMI that interrupts OPAL code,
> so re-entry to OPAL can cause a number of problems. Putting
> secondaries into simple spin loops improves the chances of a
> successful reboot.
> 
> Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>

Nick,

Patch looks good to me. We have tested this patchset on FSP based system and 
everything looks fine.

Reviewed-by:  Vasant Hegde <hegdevasant@linux.vnet.ibm.com>

-Vasant

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/powerpc/include/asm/opal.h             |  2 +-
>   arch/powerpc/platforms/powernv/opal-flash.c | 28 +---------------------------
>   arch/powerpc/platforms/powernv/setup.c      | 15 +++++----------
>   3 files changed, 7 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index dde60089d0d4..7159e1a6a61a 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -325,7 +325,7 @@ struct rtc_time;
>   extern unsigned long opal_get_boot_time(void);
>   extern void opal_nvram_init(void);
>   extern void opal_flash_update_init(void);
> -extern void opal_flash_term_callback(void);
> +extern void opal_flash_update_print_message(void);
>   extern int opal_elog_init(void);
>   extern void opal_platform_dump_init(void);
>   extern void opal_sys_param_init(void);
> diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
> index 1cb0b895a236..b37015101bf6 100644
> --- a/arch/powerpc/platforms/powernv/opal-flash.c
> +++ b/arch/powerpc/platforms/powernv/opal-flash.c
> @@ -303,26 +303,9 @@ static int opal_flash_update(int op)
>   	return rc;
>   }
> 
> -/* Return CPUs to OPAL before starting FW update */
> -static void flash_return_cpu(void *info)
> -{
> -	int cpu = smp_processor_id();
> -
> -	if (!cpu_online(cpu))
> -		return;
> -
> -	/* Disable IRQ */
> -	hard_irq_disable();
> -
> -	/* Return the CPU to OPAL */
> -	opal_return_cpu();
> -}
> -
>   /* This gets called just before system reboots */
> -void opal_flash_term_callback(void)
> +void opal_flash_update_print_message(void)
>   {
> -	struct cpumask mask;
> -
>   	if (update_flash_data.status != FLASH_IMG_READY)
>   		return;
> 
> @@ -333,15 +316,6 @@ void opal_flash_term_callback(void)
> 
>   	/* Small delay to help getting the above message out */
>   	msleep(500);
> -
> -	/* Return secondary CPUs to firmware */
> -	cpumask_copy(&mask, cpu_online_mask);
> -	cpumask_clear_cpu(smp_processor_id(), &mask);
> -	if (!cpumask_empty(&mask))
> -		smp_call_function_many(&mask,
> -				       flash_return_cpu, NULL, false);
> -	/* Hard disable interrupts */
> -	hard_irq_disable();
>   }
> 
>   /*
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index 5f963286232f..ef8c9ce53a61 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -201,17 +201,12 @@ static void pnv_prepare_going_down(void)
>   	 */
>   	opal_event_shutdown();
> 
> -	/* Soft disable interrupts */
> -	local_irq_disable();
> +	/* Print flash update message if one is scheduled. */
> +	opal_flash_update_print_message();
> 
> -	/*
> -	 * Return secondary CPUs to firwmare if a flash update
> -	 * is pending otherwise we will get all sort of error
> -	 * messages about CPU being stuck etc.. This will also
> -	 * have the side effect of hard disabling interrupts so
> -	 * past this point, the kernel is effectively dead.
> -	 */
> -	opal_flash_term_callback();
> +	smp_send_stop();
> +
> +	hard_irq_disable();
>   }
> 
>   static void  __noreturn pnv_restart(char *cmd)
> 
