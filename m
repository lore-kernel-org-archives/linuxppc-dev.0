Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 0707ADE57E
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 03:07:23 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1754205pyg.27
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 10:07:22 -0700 (PDT)
Subject: Re: [PATCH] Add idle power save for ppc 4xx
From: Josh Boyer <jwboyer@gmail.com>
To: Jerone Young <jyoung5@us.ibm.com>
In-Reply-To: <10aea37177130bbe5de7.1206969157@thinkpadL>
References: <10aea37177130bbe5de7.1206969157@thinkpadL>
Content-Type: text/plain
Date: Mon, 31 Mar 2008 12:07:17 -0500
Message-Id: <1206983237.12155.60.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-03-31 at 08:12 -0500, Jerone Young wrote:
> # HG changeset patch
> # User Jerone Young <jyoung5@us.ibm.com>
> # Date 1206969060 18000
> # Node ID 10aea37177130bbe5de7bee6ec06d9010bc5da1f
> # Parent  1506aa38ddabb0bf73fff3ac3f3db5f9ef6458cc
> Add idle power save for ppc 4xx
> 
> This patch sets the wait state MSR when power_save is called in cpu_idle loop for ppc4xx. This is mainly to help out virtualization solutions such as KVM. This way the virtualization soultions are able to tell if the guest kernel is idle.
> 
> I have tested this on hardware & KVM virtual guest.

I'm not overly thrilled with adding this to all of 4xx.  It doesn't
actually save much power at all (1% on a project that actually measured
it with an amp meter recently) and there's really no other benefit to
doing it outside of the virtual guest case.

I'm assuming you pass a dtb to the virtual guest when you start it up.
Could you define a property in the CPU node there that can be parsed to
use the power_save function instead of always making it the default?

> Signed-off-by: Jerone Young <jyoung5@us.ibm.com>
> 
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsy
>  obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
>  obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
>  obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
> +obj-$(CONFIG_4xx)		+= idle_4xx.o
>  obj-$(CONFIG_TAU)		+= tau_6xx.o
>  obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o \
>  				   swsusp_$(CONFIG_WORD_SIZE).o
> diff --git a/arch/powerpc/kernel/idle_4xx.c b/arch/powerpc/kernel/idle_4xx.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/powerpc/kernel/idle_4xx.c

Can this be added to sysdev/ppc4xx_soc.c instead?

> +#include <asm/processor.h>
> +#include <asm/machdep.h>
> +
> +void ppc4xx_idle()
> +{
> +	unsigned long msr_save;
> +
> +	/* set wait state MSR */
> +	local_irq_enable();
> +	msr_save = mfmsr();
> +	mtmsr(msr_save|MSR_WE);
> +	local_irq_disable();
> +}

I agree with Hollis on both the MSR_WE|MSR_EE and removing the
local_irq_disable changes.

> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -132,6 +132,10 @@ void __init machine_init(unsigned long d
>  	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
>  	    cpu_has_feature(CPU_FTR_CAN_NAP))
>  		ppc_md.power_save = ppc6xx_idle;
> +#endif
> +
> +#ifdef CONFIG_4xx
> +	ppc_md.power_save = ppc4xx_idle;
>  #endif

I agree this belongs in platform setup code.  Finding the right spot for
it might be a bit of a challenge.

josh
