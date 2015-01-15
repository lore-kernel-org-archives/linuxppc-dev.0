Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0124.outbound.protection.outlook.com [207.46.100.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 793561A0D60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 17:46:17 +1100 (AEDT)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>, Scott Wood
 <scottwood@freescale.com>, York Sun <yorksun@freescale.com>,
 "LeoLi@freescale.com" <LeoLi@freescale.com>
Subject: RE: [PATCH] fsl/smp: add low power boot support to replace spin boot
Date: Thu, 15 Jan 2015 06:46:10 +0000
Message-ID: <BN1PR03MB188237FB2847D837505D3BC9D4E0@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1421301930-10035-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1421301930-10035-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

U-boot patch link:
http://patchwork.ozlabs.org/patch/429265/

Regards,
-Dongsheng

> -----Original Message-----
> From: Dongsheng Wang [mailto:dongsheng.wang@freescale.com]
> Sent: Thursday, January 15, 2015 2:06 PM
> To: Wood Scott-B07421; Sun York-R58495; Li Yang-Leo-R58472
> Cc: linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
> Subject: [PATCH] fsl/smp: add low power boot support to replace spin boot
>=20
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> U-boot put non-boot cpus into an low power state(PW10/PW20 or DOZE) when =
cpu
> powered up. To exit low power state kernel will send DOORBELL or MPIC-IPI
> signal to all those CPUs.
>=20
> e500/e500v2 use mpic to send IPI signal.
> e500mc and later use doorbell to send IPI signal.
>=20
> This feature tested on:
> POWER UP TEST:
> P1022DS(e500v2),96k times.
> P4080(e500mc),  110k times.
> T1024(e5500),   83k times.
> T4240(e6500),   150k times.
>=20
> CPU HOTPLUG TEST:
> P1022DS(e500v2),1.4 million times.
> P4080(e500mc),  1.8 million times.
> T1024(e5500),   1.3 million times.
> T4240(e6500),   1.1 million times.
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/m=
pic.h
> index 754f93d..8af6a25 100644
> --- a/arch/powerpc/include/asm/mpic.h
> +++ b/arch/powerpc/include/asm/mpic.h
> @@ -474,6 +474,15 @@ extern int mpic_cpu_get_priority(void);
>  /* Set the current cpu priority for this cpu */
>  extern void mpic_cpu_set_priority(int prio);
>=20
> +/* Set cpu priority */
> +void mpic_set_cpu_priority(int nr, int prio);
> +
> +/* Set cpu EOI */
> +void mpic_cpu_eoi_write(int cpu);
> +
> +/* CPU ACK interrupt */
> +void mpic_cpu_ack(int cpu);
> +
>  /* Request IPIs on primary mpic */
>  extern void mpic_request_ipis(void);
>=20
> diff --git a/arch/powerpc/platforms/85xx/smp.c
> b/arch/powerpc/platforms/85xx/smp.c
> index d7c1e69..6c54632 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -193,6 +193,30 @@ static int smp_85xx_kick_cpu(int nr)
>  	const u64 *cpu_rel_addr;
>  	__iomem struct epapr_spin_table *spin_table;
>  	struct device_node *np;
> +
> +	/*
> +	 * DOORBELL:
> +	 * When kernel kick one of cpus, all cpus will be wakenup. To make
> +	 * sure that only the target cpu is effected, other cpus (by checking
> +	 * spin_table->addr_l) should go back to low power state.
> +	 *
> +	 * U-boot has renumber the cpu PIR Why we need to set all of PIR to
> +	 * the same value?
> +	 * A: Before kernel kicking cpu, the doorbell message was not configure=
d
> +	 * for target cpu(cpu_messages->data). If we try to send a
> +	 * non-configured message to target cpu, it cannot correctly receive
> +	 * doorbell interrput. So SET ALL OF CPU'S PIR to the same value to
> +	 * let all cpus catch the interrupt.
> +	 *
> +	 * Why set PIR to zero?
> +	 * A: U-boot cannot know how many cpus will be kicked up(Kernel allow u=
s
> +	 * to configure NR_CPUS) and IPI is a per_cpu variable, u-boot cannot
> +	 * set a appropriate PIR for every cpu, but the boot cpu(CPU0) always b=
e
> +	 * there. U-boot set PIR to zero as a default PIR ID for each CPU, so
> +	 * initialize the kick_cpus to 0.
> +	 */
> +	u32 kick_cpus =3D 0;
> +
>  	int hw_cpu =3D get_hard_smp_processor_id(nr);
>  	int ioremappable;
>  	int ret =3D 0;
> @@ -251,8 +275,7 @@ static int smp_85xx_kick_cpu(int nr)
>  		spin_table =3D phys_to_virt(*cpu_rel_addr);
>=20
>  	local_irq_save(flags);
> -#ifdef CONFIG_PPC32
> -#ifdef CONFIG_HOTPLUG_CPU
> +#if defined(CONFIG_PPC32) && defined(CONFIG_HOTPLUG_CPU)
>  	/* Corresponding to generic_set_cpu_dead() */
>  	generic_set_cpu_up(nr);
>=20
> @@ -292,11 +315,58 @@ static int smp_85xx_kick_cpu(int nr)
>  		__secondary_hold_acknowledge =3D -1;
>  	}
>  #endif
> +
>  	flush_spin_table(spin_table);
> -	out_be32(&spin_table->pir, hw_cpu);
> +	/*
> +	 * U-boot will wait kernel send eoi to MPIC, after EOI has send
> +	 * kernel will set PIR for uboot, let uboot know EOI has send.
> +	 */
> +	out_be32(&spin_table->pir, 0);
> +
> +#ifdef CONFIG_PPC32
>  	out_be32(&spin_table->addr_l, __pa(__early_start));
> +#else
> +	out_be64((u64 *)(&spin_table->addr_h),
> +		 __pa(ppc_function_entry(generic_secondary_smp_init)));
> +#endif
>  	flush_spin_table(spin_table);
>=20
> +	/*
> +	 * e500, e500v2 need to use MPIC to send IPI signal, so we need to
> +	 * open IPI firstly.
> +	 */
> +	if (!cpu_has_feature(CPU_FTR_DBELL)) {
> +		mpic_set_cpu_priority(nr, 0);
> +		kick_cpus =3D nr;
> +	}
> +
> +	/* Let cpu exit low power state, and from u-boot jump to kernel */
> +	arch_send_call_function_single_ipi(kick_cpus);
> +
> +	/*
> +	 * Let we ACK interrput and Send EOI signal to finish INT server
> +	 * U-boot has read EPR to ACK interrput when MPIC work in external
> +	 * proxy mode. Without the external proxy facility, we need to read
> +	 * MPIC ACK register.
> +	 *
> +	 * There just ACK interrput, we don't need to get the interrupt vector
> +	 * and to handle it. Because there just IPI or DOORBELL interrupt to
> +	 * make u-boot exit low power state and jump to kernel.
> +	 */
> +	mpic_cpu_ack(nr);
> +	/* Send EOI to clear ISR bit to remove interrupt from service */
> +	mpic_cpu_eoi_write(nr);
> +
> +	/* After wakeup CPU disable IPI, IPI will be opened in setup_cpu */
> +	if (!cpu_has_feature(CPU_FTR_DBELL))
> +		mpic_set_cpu_priority(nr, 0xf);
> +
> +	/* After EOI finish, let we release cpu */
> +	flush_spin_table(spin_table);
> +	out_be32(&spin_table->pir, hw_cpu);
> +	flush_spin_table(spin_table);
> +
> +#ifdef CONFIG_PPC32
>  	/* Wait a bit for the CPU to ack. */
>  	if (!spin_event_timeout(__secondary_hold_acknowledge =3D=3D hw_cpu,
>  					10000, 100)) {
> @@ -308,12 +378,6 @@ static int smp_85xx_kick_cpu(int nr)
>  out:
>  #else
>  	smp_generic_kick_cpu(nr);
> -
> -	flush_spin_table(spin_table);
> -	out_be32(&spin_table->pir, hw_cpu);
> -	out_be64((u64 *)(&spin_table->addr_h),
> -		__pa(ppc_function_entry(generic_secondary_smp_init)));
> -	flush_spin_table(spin_table);
>  #endif
>=20
>  	local_irq_restore(flags);
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index c4648ad..b2ba47e 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -658,6 +658,21 @@ static inline void mpic_eoi(struct mpic *mpic)
>  	(void)mpic_cpu_read(MPIC_INFO(CPU_WHOAMI));
>  }
>=20
> +void mpic_cpu_eoi_write(int cpu)
> +{
> +	struct mpic *mpic =3D mpic_primary;
> +
> +	_mpic_write(mpic->reg_type, &mpic->cpuregs[cpu], MPIC_INFO(CPU_EOI), 0)=
;
> +	_mpic_read(mpic->reg_type, &mpic->cpuregs[cpu], MPIC_INFO(CPU_WHOAMI));
> +}
> +
> +void mpic_cpu_ack(int cpu)
> +{
> +	struct mpic *mpic =3D mpic_primary;
> +
> +	_mpic_read(mpic->reg_type, &mpic->cpuregs[cpu], MPIC_INFO(CPU_INTACK));
> +}
> +
>  /*
>   * Linux descriptor level callbacks
>   */
> @@ -1778,6 +1793,16 @@ void mpic_cpu_set_priority(int prio)
>  	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), prio);
>  }
>=20
> +void mpic_set_cpu_priority(int nr, int prio)
> +{
> +	struct mpic *mpic =3D mpic_primary;
> +	int hw_cpu =3D get_hard_smp_processor_id(nr);
> +
> +	prio &=3D MPIC_CPU_TASKPRI_MASK;
> +	_mpic_write(mpic->reg_type, &mpic->cpuregs[hw_cpu],
> +		    MPIC_INFO(CPU_CURRENT_TASK_PRI), prio);
> +}
> +
>  void mpic_teardown_this_cpu(int secondary)
>  {
>  	struct mpic *mpic =3D mpic_primary;
> --
> 2.1.0.27.g96db324
