Return-Path: <hollisb@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7232DE03A
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 02:28:05 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2VGS1h1027293
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 12:28:01 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2VGRqY6066798
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 10:27:53 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2VGRqnl016524
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 10:27:52 -0600
Subject: Re: [kvm-ppc-devel] [PATCH] Add idle power save for ppc 4xx
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Jerone Young <jyoung5@us.ibm.com>
In-Reply-To: <10aea37177130bbe5de7.1206969157@thinkpadL>
References: <10aea37177130bbe5de7.1206969157@thinkpadL>
Content-Type: text/plain
Date: Mon, 31 Mar 2008 11:27:51 -0500
Message-Id: <1206980871.5919.5.camel@basalt>
Mime-Version: 1.0
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Reply-To: Hollis Blanchard <hollisb@us.ibm.com>
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
> This patch sets the wait state MSR when power_save is called in
> cpu_idle loop for ppc4xx. This is mainly to help out virtualization
> solutions such as KVM. This way the virtualization soultions are able
> to tell if the guest kernel is idle.
> 
> I have tested this on hardware & KVM virtual guest.
> 
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
> @@ -0,0 +1,24 @@
> +/*
> + * This file contains the power_save function for 4xx CPUs
> + *
> + * added by Jerone Young <jyoung5@us.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <asm/processor.h>
> +#include <asm/machdep.h>
> +
> +void ppc4xx_idle()

void ppc4xx_idle(void)

> +{
> +	unsigned long msr_save;
> +
> +	/* set wait state MSR */
> +	local_irq_enable();
> +	msr_save = mfmsr();
> +	mtmsr(msr_save|MSR_WE);

Why don't you |MSR_WE|MSR_EE at the same time?

> +	local_irq_disable();
> +}

None of the other power_save() implementations need this. In fact many
of them don't even seem to return; they just loop around mtmsr.

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
> 
>  	if (ppc_md.progress)

This belongs in the platform setup code.

-- 
Hollis Blanchard
IBM Linux Technology Center
