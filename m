Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5Z5S4WWhzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 15:48:44 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6A5maDS077871
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 01:48:42 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bjufq7qev-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 01:48:42 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 10 Jul 2017 15:48:40 +1000
Subject: Re: [PATCH 1/4] powerpc/powernv: handle the platform error reboot in
 ppc_md.restart
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: skiboot@lists.ozlabs.org
References: <20170705040422.20933-1-npiggin@gmail.com>
 <20170705040422.20933-2-npiggin@gmail.com>
 <20170707035611.6a9e60b6@roar.ozlabs.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 10 Jul 2017 11:18:35 +0530
MIME-Version: 1.0
In-Reply-To: <20170707035611.6a9e60b6@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <6e0ddb0b-a877-1840-5f7d-e8b06faee6a7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/06/2017 11:26 PM, Nicholas Piggin wrote:
> On Wed,  5 Jul 2017 14:04:19 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
> 
>> Unrecovered MCE and HMI errors are sent through a special restart
>> OPAL call to log the platform error. The downside is that they don't
>> go through normal crash paths, so they don't give much information
>> to the Linux console.
>>
>> Change this by allowing them to set an error which then causes the
>> normal restart handler to use the platform error call. Have MCE and HMI
>> handlers set this and then use the normal panic path for unrecoverable
>> cases.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Mahesh brought up a couple of good points about this offline.
> Firstly that some HMI erorrs will stop the TB, second that if
> crash dumps are registered then we will not get to the platform
> reboot code from panic.
> 
> So it was a nice idea, but it seems to be just a bit too hard to
> do exactly what we want in the panic path. So the other option is
> put some of the printk and console flushing into the opal platform
> error handler.
> 
> It's not really ideal to duplicate this code here... but it's better
> than not printing anything.
> 
> Patch 2 won't be able to just call die() for kernel context now, but
> it will have to check in_interrupt(), panic_on_oops, etc. to make
> sure die() doesn't panic. But that should be okay.
> 
> This is what I have. If there are no great objections I'll repost
> a v2 series with this.

Looks good to me. Just one minor suggestion/comment below.

> 
> ---
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 588fb1c23af9..182dab435aad 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -50,7 +50,7 @@ int64_t opal_tpo_write(uint64_t token, uint32_t year_mon_day,
>  		       uint32_t hour_min);
>  int64_t opal_cec_power_down(uint64_t request);
>  int64_t opal_cec_reboot(void);
> -int64_t opal_cec_reboot2(uint32_t reboot_type, char *diag);
> +int64_t opal_cec_reboot2(uint32_t reboot_type, const char *diag);
>  int64_t opal_read_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
>  int64_t opal_write_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
>  int64_t opal_handle_interrupt(uint64_t isn, __be64 *outstanding_event_mask);
> diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
> index 88f3c61eec95..d78fed728cdf 100644
> --- a/arch/powerpc/platforms/powernv/opal-hmi.c
> +++ b/arch/powerpc/platforms/powernv/opal-hmi.c
> @@ -30,6 +30,8 @@
>  #include <asm/cputable.h>
>  #include <asm/machdep.h>
> 
> +#include "powernv.h"
> +
>  static int opal_hmi_handler_nb_init;
>  struct OpalHmiEvtNode {
>  	struct list_head list;
> @@ -267,8 +269,6 @@ static void hmi_event_handler(struct work_struct *work)
>  	spin_unlock_irqrestore(&opal_hmi_evt_lock, flags);
> 
>  	if (unrecoverable) {
> -		int ret;
> -
>  		/* Pull all HMI events from OPAL before we panic. */
>  		while (opal_get_msg(__pa(&msg), sizeof(msg)) == OPAL_SUCCESS) {
>  			u32 type;
> @@ -284,23 +284,7 @@ static void hmi_event_handler(struct work_struct *work)
>  			print_hmi_event_info(hmi_evt);
>  		}
> 
> -		/*
> -		 * Unrecoverable HMI exception. We need to inform BMC/OCC
> -		 * about this error so that it can collect relevant data
> -		 * for error analysis before rebooting.
> -		 */
> -		ret = opal_cec_reboot2(OPAL_REBOOT_PLATFORM_ERROR,
> -			"Unrecoverable HMI exception");
> -		if (ret == OPAL_UNSUPPORTED) {
> -			pr_emerg("Reboot type %d not supported\n",
> -						OPAL_REBOOT_PLATFORM_ERROR);
> -		}
> -
> -		/*
> -		 * Fall through and panic if opal_cec_reboot2() returns
> -		 * OPAL_UNSUPPORTED.
> -		 */
> -		panic("Unrecoverable HMI exception");
> +		pnv_platform_error_reboot(NULL, "Unrecoverable HMI exception");
>  	}
>  }
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 59684b4af4d1..ccbcfa22bacf 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -25,6 +25,10 @@
>  #include <linux/memblock.h>
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
> +#include <linux/printk.h>
> +#include <linux/kmsg_dump.h>
> +#include <linux/console.h>
> +#include <linux/sched/debug.h>
> 
>  #include <asm/machdep.h>
>  #include <asm/opal.h>
> @@ -421,10 +425,57 @@ static int opal_recover_mce(struct pt_regs *regs,
>  	return recovered;
>  }
> 
> +void pnv_platform_error_reboot(struct pt_regs *regs, const char *msg)
> +{
> +	/*
> +	 * This is mostly taken from kernel/panic.c, but tries to do
> +	 * relatively minimal work. Don't use delay functions (TB may
> +	 * be broken), don't crash dump (need to set a firmware log),
> +	 * don't run notifiers. We do want to get some information to
> +	 * Linux console.
> +	 */
> +	smp_send_stop();
> +
> +	console_verbose();
> +	bust_spinlocks(1);
> +	pr_emerg("Hardware platform error: %s\n", msg);
> +	if (regs)
> +		show_regs(regs);
> +	printk_safe_flush_on_panic();
> +	kmsg_dump(KMSG_DUMP_PANIC);
> +	bust_spinlocks(0);
> +	debug_locks_off();
> +	console_flush_on_panic();
> +
> +	/*
> +	 * Don't bother to shut things down because this will
> +	 * xstop the system.
> +	 */
> +	if (opal_cec_reboot2(OPAL_REBOOT_PLATFORM_ERROR, msg)
> +						== OPAL_UNSUPPORTED) {
> +		pr_emerg("Reboot type %d not supported for %s\n",
> +				OPAL_REBOOT_PLATFORM_ERROR, msg);
> +	}
> +
> +	/*
> +	 * We reached here. There can be three possibilities:
> +	 * 1. We are running on a firmware level that do not support
> +	 *    opal_cec_reboot2()
> +	 * 2. We are running on a firmware level that do not support
> +	 *    OPAL_REBOOT_PLATFORM_ERROR reboot type.
> +	 * 3. We are running on FSP based system that does not need
> +	 *    opal to trigger checkstop explicitly for error analysis.
> +	 *    The FSP PRD component would have already got notified
> +	 *    about this error through other channels.
> +	 */
> +

Not sure if looping forever unconditionally here is better idea. How
about we check panic_timeout and decide whether to reboot or fall
through for loop ?

	if (panic_timeout != 0)
		emergency_restart();

> +	for (;;)
> +		;> +}

Thanks,
-Mahesh.
