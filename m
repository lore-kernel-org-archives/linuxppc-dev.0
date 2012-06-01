Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 42251B7006
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2012 07:27:40 +1000 (EST)
Message-ID: <4FC933BF.1020901@freescale.com>
Date: Fri, 1 Jun 2012 16:27:27 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v5 2/5] powerpc/85xx: add HOTPLUG_CPU support
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <1336737235-15370-2-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1336737235-15370-2-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/11/2012 06:53 AM, Zhao Chenhui wrote:
\> +#if defined(CONFIG_FSL_BOOKE) || defined(CONFIG_6xx)
> +extern void __flush_disable_L1(void);
> +#endif

Prototypes aren't normally guarded by ifdefs.

> +static void __cpuinit smp_85xx_mach_cpu_die(void)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	u32 tmp;
> +
> +	local_irq_disable();
> +	idle_task_exit();
> +	generic_set_cpu_dead(cpu);
> +	mb();
> +
> +	mtspr(SPRN_TCR, 0);
> +
> +	__flush_disable_L1();
> +	tmp = (mfspr(SPRN_HID0) & ~(HID0_DOZE|HID0_SLEEP)) | HID0_NAP;
> +	mtspr(SPRN_HID0, tmp);
> +
> +	/* Enter NAP mode. */
> +	tmp = mfmsr();
> +	tmp |= MSR_WE;
> +	mb();
> +	mtmsr(tmp);
> +	isync();

Need isync after writing to HID0.

> +		/*
> +		 * We don't set the BPTR register here upon it points
> +		 * to the boot page properly.
> +		 */
> +		mpic_reset_core(hw_cpu);

That comment's wording is hard to follow -- maybe s/upon it points/since
it already points/

> +		/* wait until core is ready... */
> +		if (!spin_event_timeout(in_be32(&spin_table->addr_l) == 1,
> +						10000, 100)) {
> +			pr_err("%s: timeout waiting for core %d to reset\n",
> +							__func__, hw_cpu);
> +			ret = -ENOENT;
> +			goto out;
> +		}

We need to fix U-Boot to write addr_l last (with an msync beforehand).

> -#ifdef CONFIG_KEXEC
> +#if defined(CONFIG_KEXEC) || defined(CONFIG_HOTPLUG_CPU)

Let's not grow lists like this.  Is there any harm in building it
unconditionally?

-Scott
