Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2365A140098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 17:04:15 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 10 Apr 2014 17:04:13 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2C6372CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 17:04:11 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3A73u6r11075874
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 17:03:56 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3A74ArJ008565
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 17:04:10 +1000
Message-ID: <53464268.5090201@linux.vnet.ibm.com>
Date: Thu, 10 Apr 2014 12:34:08 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/60] powerpc/powernv: Return secondary CPUs to firmware
 before FW update
References: <1397063935-30478-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
In-Reply-To: <1397063935-30478-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/09/2014 10:48 PM, Vasant Hegde wrote:
> Firmware update on PowerNV platform takes several minutes. During
> this time one CPU is stuck in FW and the kernel complains about "soft
> lockups".
>

Ben,

Sorry for the confusion in subject line.. Its just 1 patch.. not 1/60 .

-Vasant

> This patch returns all secondary CPUs to firmware before starting
> firmware update process.
>
> [ Reworked a bit and cleaned up -- BenH ]
>
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>   arch/powerpc/include/asm/opal.h             |  1 +
>   arch/powerpc/platforms/powernv/opal-flash.c | 47 ++++++++++++++++++++++++++---
>   arch/powerpc/platforms/powernv/setup.c      | 25 +++++++++++++--
>   3 files changed, 66 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 05a23d0..5c34170 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -922,6 +922,7 @@ extern unsigned long opal_get_boot_time(void);
>   extern void opal_nvram_init(void);
>   extern int opal_elog_register_init(void);
>   extern void opal_flash_init(void);
> +extern void opal_flash_term_callback(void);
>   extern int opal_elog_init(void);
>   extern void opal_platform_dump_init(void);
>   extern void opal_sys_param_init(void);
> diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
> index 16e571b..11ab43f 100644
> --- a/arch/powerpc/platforms/powernv/opal-flash.c
> +++ b/arch/powerpc/platforms/powernv/opal-flash.c
> @@ -20,6 +20,7 @@
>   #include <linux/mm.h>
>   #include <linux/vmalloc.h>
>   #include <linux/pagemap.h>
> +#include <linux/delay.h>
>
>   #include <asm/opal.h>
>
> @@ -388,11 +389,6 @@ static int opal_flash_update(int op)
>   			(sg->num_entries * sizeof(struct opal_sg_entry) + 16);
>   	}
>
> -	pr_alert("FLASH: Image is %u bytes\n", image_data.size);
> -	pr_alert("FLASH: Image update requested\n");
> -	pr_alert("FLASH: Image will be updated during system reboot\n");
> -	pr_alert("FLASH: This will take several minutes. Do not power off!\n");
> -
>   flash:
>   	rc = opal_update_flash(addr);
>
> @@ -400,6 +396,47 @@ invalid_img:
>   	return rc;
>   }
>
> +/* Return CPUs to OPAL before starting FW update */
> +static void flash_return_cpu(void *info)
> +{
> +	int cpu = smp_processor_id();
> +
> +	if (!cpu_online(cpu))
> +		return;
> +
> +	/* Disable IRQ */
> +	hard_irq_disable();
> +
> +	/* Return the CPU to OPAL */
> +	opal_return_cpu();
> +}
> +
> +/* This gets called just before system reboots */
> +void opal_flash_term_callback(void)
> +{
> +	struct cpumask mask;
> +
> +	if (update_flash_data.status != FLASH_IMG_READY)
> +		return;
> +
> +	pr_alert("FLASH: Flashing new firmware\n");
> +	pr_alert("FLASH: Image is %u bytes\n", image_data.size);
> +	pr_alert("FLASH: Performing flash and reboot/shutdown\n");
> +	pr_alert("FLASH: This will take several minutes. Do not power off!\n");
> +
> +	/* Small delay to help getting the above message out */
> +	msleep(500);
> +
> +	/* Return secondary CPUs to firmware */
> +	cpumask_copy(&mask, cpu_online_mask);
> +	cpumask_clear_cpu(smp_processor_id(), &mask);
> +	if (!cpumask_empty(&mask))
> +		smp_call_function_many(&mask,
> +				       flash_return_cpu, NULL, false);
> +	/* Hard disable interrupts */
> +	hard_irq_disable();
> +}
> +
>   /*
>    * Show candidate image status
>    */
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index 1735678..42c16a6 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -98,11 +98,32 @@ static void pnv_show_cpuinfo(struct seq_file *m)
>   	of_node_put(root);
>   }
>
> +static void pnv_prepare_going_down(void)
> +{
> +	/*
> +	 * Disable all notifiers from OPAL, we can't
> +	 * service interrupts anymore anyway
> +	 */
> +	opal_notifier_disable();
> +
> +	/* Soft disable interrupts */
> +	local_irq_disable();
> +
> +	/*
> +	 * Return secondary CPUs to firwmare if a flash update
> +	 * is pending otherwise we will get all sort of error
> +	 * messages about CPU being stuck etc.. This will also
> +	 * have the side effect of hard disabling interrupts so
> +	 * past this point, the kernel is effectively dead.
> +	 */
> +	opal_flash_term_callback();
> +}
> +
>   static void  __noreturn pnv_restart(char *cmd)
>   {
>   	long rc = OPAL_BUSY;
>
> -	opal_notifier_disable();
> +	pnv_prepare_going_down();
>
>   	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
>   		rc = opal_cec_reboot();
> @@ -119,7 +140,7 @@ static void __noreturn pnv_power_off(void)
>   {
>   	long rc = OPAL_BUSY;
>
> -	opal_notifier_disable();
> +	pnv_prepare_going_down();
>
>   	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
>   		rc = opal_cec_power_down(0);
>
