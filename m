Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D5CD62C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 06:41:47 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 29 Jan 2014 01:11:43 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 1ABA2E0056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 01:14:47 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0SJff3t8716604
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 01:11:42 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0SJfei3006700
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 01:11:40 +0530
Message-ID: <52E807F0.8070508@linux.vnet.ibm.com>
Date: Tue, 28 Jan 2014 13:41:36 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/3] powerpc/pseries: Update dynamic cache nodes for
 suspend/resume operation
References: <1390420717-23907-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1390420717-23907-3-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1390420717-23907-3-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/22/2014 01:58 PM, Tyrel Datwyler wrote:
> From: Haren Myneni <hbabu@us.ibm.com>
> 
> From: Haren Myneni <hbabu@us.ibm.com>
> 
> pHyp can change cache nodes for suspend/resume operation. The current code
> updates the device tree after all non boot CPUs are enabled. Hence, we do not
> modify the cache list based on the latest cache nodes. Also we do not remove
> cache entries for the primary CPU.
> 
> This patch removes the cache list for the boot CPU, updates the device tree
> before enabling nonboot CPUs and adds cache list for the boot cpu.
> 
> Signed-off-by: Haren Myneni <hbabu@us.ibm.com>
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/rtas.h |  4 ++++
>  arch/powerpc/kernel/rtas.c      | 17 +++++++++++++++++
>  arch/powerpc/kernel/time.c      |  6 ++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> index 9bd52c6..da9d733 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -283,6 +283,10 @@ extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
> 
>  #ifdef CONFIG_PPC_PSERIES
>  extern int pseries_devicetree_update(s32 scope);
> +extern void post_mobility_fixup(void);
> +extern void update_dynamic_configuration(void);
> +#else /* !CONFIG_PPC_PSERIES */
> +void update_dynamic_configuration(void) { }
>  #endif
> 
>  #ifdef CONFIG_PPC_RTAS_DAEMON
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 4cf674d..8249eb2 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -43,6 +43,7 @@
>  #include <asm/time.h>
>  #include <asm/mmu.h>
>  #include <asm/topology.h>
> +#include "cacheinfo.h"
> 
>  struct rtas_t rtas = {
>  	.lock = __ARCH_SPIN_LOCK_UNLOCKED
> @@ -972,6 +973,22 @@ out:
>  	free_cpumask_var(offline_mask);
>  	return atomic_read(&data.error);
>  }
> +
> +/*
> + * The device tree cache nodes can be modified during suspend/ resume.
> + * So delete all cache entries and recreate them again after the device tree
> + * update.
> + * We already deleted cache entries for notboot CPUs before suspend. So delete
> + * entries for the primary CPU, recreate entries after the device tree update.
> + * We can create entries for nonboot CPU when enable them later.
> + */
> +
> +void update_dynamic_configuration(void)
> +{
> +	cacheinfo_cpu_offline(smp_processor_id());
> +	post_mobility_fixup();
> +	cacheinfo_cpu_online(smp_processor_id());
> +}
>  #else /* CONFIG_PPC_PSERIES */
>  int rtas_ibm_suspend_me(struct rtas_args *args)
>  {
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index b3b1441..5f1ca28 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -69,6 +69,7 @@
>  #include <asm/vdso_datapage.h>
>  #include <asm/firmware.h>
>  #include <asm/cputime.h>
> +#include <asm/rtas.h>
> 
>  /* powerpc clocksource/clockevent code */
> 
> @@ -592,6 +593,11 @@ void arch_suspend_enable_irqs(void)
>  	generic_suspend_enable_irqs();
>  	if (ppc_md.suspend_enable_irqs)
>  		ppc_md.suspend_enable_irqs();
> +	/*
> +	 * Update configuration which can be modified based on devicetree
> +	 * changes during resume.
> +	 */
> +	update_dynamic_configuration();

Instead of creating this new routine update_dynamic_reconfiguration() for
pseries systems only, shouldn't we be defining ppc_md.suspend_enable_irqs
for pseries. I think this could be done in platforms/pseries/suspend.c

-Nathan

>  }
>  #endif
> 
