Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
 [216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 725AEB70ED
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 06:02:34 +1100 (EST)
Received: from mail153-va3 (localhost [127.0.0.1])	by
 mail153-va3-R.bigfish.com (Postfix) with ESMTP id 1A8C34806C6	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 19:06:46 +0000 (UTC)
Received: from VA3EHSMHS018.bigfish.com (unknown [10.7.14.235])	by
 mail153-va3.bigfish.com (Postfix) with ESMTP id CDAE8300044	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 19:06:45 +0000 (UTC)
Message-ID: <4EC408C1.1040400@freescale.com>
Date: Wed, 16 Nov 2011 13:02:25 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v2 2/7] powerpc/85xx: add HOTPLUG_CPU support
References: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
 <1321437344-19253-2-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1321437344-19253-2-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/16/2011 03:55 AM, Zhao Chenhui wrote:
> +static void __cpuinit smp_85xx_mach_cpu_die(void)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	register u32 tmp;
> +
> +	local_irq_disable();
> +	idle_task_exit();
> +	generic_set_cpu_dead(cpu);
> +	mb();
> +
> +	mtspr(SPRN_TCR, 0);
> +	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);

Clearing these bits in TSR should be unnecessary since we clear TCR --
and doesn't really accomplish anything since the TSR bits can continue
to be set.

If watchdog is in use, we need to set the period to the highest possible
to effectively disable it.

> +	if (cpu_has_feature(CPU_FTR_CAN_NAP)) {

Again, don't check this.  On 85xx, we *always* can and should use nap
here.  At best this is noise, at worst this will cause problems if
CONFIG_BDI_SWITCH is enabled, or if CPU_FTR_CAN_NAP is cleared for any
other reason (e.g. it's not set on e500mc, and the reason isn't that the
nap implementation is different (which it is), but that it's not usable
in the idle loop).

> +static int __cpuinit smp_85xx_kick_cpu(int nr)
> +
>  {
>  	unsigned long flags;
>  	const u64 *cpu_rel_addr;
> -	__iomem u32 *bptr_vaddr;
> +	__iomem struct epapr_spin_table *epapr;

Please don't call this just "epapr".  That's like calling a reference to
any powerpc-specific struct "powerpc".

How about "spin_table"?

> -	out_be32(bptr_vaddr + BOOT_ENTRY_PIR, hw_cpu);
> +	out_be32(&epapr->pir, hw_cpu);
>  #ifdef CONFIG_PPC32
> -	out_be32(bptr_vaddr + BOOT_ENTRY_ADDR_LOWER, __pa(__early_start));
> +#ifdef CONFIG_HOTPLUG_CPU
> +	/* Corresponding to generic_set_cpu_dead() */
> +	generic_set_cpu_up(nr);
> +
> +	if (system_state == SYSTEM_RUNNING) {
> +		out_be32(&epapr->addr_l, 0);
> +
> +		smp_85xx_set_bootpg((u32)(*cpu_rel_addr >> PAGE_SHIFT));

As previously requested, please document why you're setting the boot
page here.  This should really be done when you resume from deep sleep,
rather than here, and should be a restoration of the value that the
register held prior to deep sleep.

>  struct smp_ops_t smp_85xx_ops = {
>  	.kick_cpu = smp_85xx_kick_cpu,
> +	.setup_cpu	= smp_85xx_setup_cpu,
> +#ifdef CONFIG_HOTPLUG_CPU
> +	.cpu_disable	= generic_cpu_disable,
> +	.cpu_die	= generic_cpu_die,
> +#endif

Only fill these fields in on e500v1/v2, until we properly support
e500mc.  Likewise in ppc_md.cpu_die and anywhere else we advertise this
functionality.

> +	of_node_put(np);
> +#ifdef CONFIG_HOTPLUG_CPU
> +	bptr = NULL;
> +	np = of_find_node_by_name(NULL, "ecm-law");
> +	if (!np) {
> +		pr_err("%s: can't find ecm-law node in dts\n", __func__);
> +		return;
> +	}

Look up by compatible, not name.

-Scott
