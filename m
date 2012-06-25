Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 84402B6FAC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 19:44:14 +1000 (EST)
Message-ID: <1340617449.16104.147.camel@pasglop>
Subject: Re: [PATCH] powerpc: Add VDSO version of getcpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Date: Mon, 25 Jun 2012 19:44:09 +1000
In-Reply-To: <20120625115540.2a7ad9c5@kryten>
References: <20120625115540.2a7ad9c5@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-06-25 at 11:55 +1000, Anton Blanchard wrote:
> We had a request for a fast method of getting CPU and NUMA node IDs
> from userspace. Ben suggested we use SPRG3 which is userspace
> readable. This is a quick hack to try that out.
> 
> I have a glibc patch to implement sched_getcpu using this. Testing
> on a POWER7:
> 
> baseline: 538 cycles 
> vdso:      30 cycles
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Outstanding issues:
> 
> - Do we have any KVM issues?

Yes we do. We need to restore SPRG3 somewhere in book3s_hv_rmhandlers.S
or it will remain to the value set by the guest. I suggest storing the
"proper" value in the PACA at boot time so we avoid having to save it
on each guest entry.

On the other hand, paulus was thinking of a hack for some other type
of process that might want to use SPRG3... (and set it using a syscall)
in which case we'd have to disable the getcpu optimization for those and
actually context switch SPRG3.. dunno what happened with that code.

Cheers,
Ben.,


> - This will only work with 64 bit kernels for now, do we need to come up
>   with a scheme for 32 bit?
> 
> - Implement 32 bit userspace version (running on 64 bit kernels)
> 
> Index: linux-build/arch/powerpc/include/asm/reg.h
> ===================================================================
> --- linux-build.orig/arch/powerpc/include/asm/reg.h	2012-06-25 10:05:52.193076424 +1000
> +++ linux-build/arch/powerpc/include/asm/reg.h	2012-06-25 10:09:02.932316659 +1000
> @@ -491,6 +491,7 @@
>  #define SPRN_SPRG1	0x111	/* Special Purpose Register General 1 */
>  #define SPRN_SPRG2	0x112	/* Special Purpose Register General 2 */
>  #define SPRN_SPRG3	0x113	/* Special Purpose Register General 3 */
> +#define SPRN_USPRG3	0x103	/* SPRG3 userspace read */
>  #define SPRN_SPRG4	0x114	/* Special Purpose Register General 4 */
>  #define SPRN_SPRG5	0x115	/* Special Purpose Register General 5 */
>  #define SPRN_SPRG6	0x116	/* Special Purpose Register General 6 */
> @@ -753,14 +754,14 @@
>   * 64-bit server:
>   *	- SPRG0 unused (reserved for HV on Power4)
>   *	- SPRG2 scratch for exception vectors
> - *	- SPRG3 unused (user visible)
> + *	- SPRG3 CPU and NUMA node for VDSO getcpu (user visible)
>   *      - HSPRG0 stores PACA in HV mode
>   *      - HSPRG1 scratch for "HV" exceptions
>   *
>   * 64-bit embedded
>   *	- SPRG0 generic exception scratch
>   *	- SPRG2 TLB exception stack
> - *	- SPRG3 unused (user visible)
> + *	- SPRG3 CPU and NUMA node for VDSO getcpu (user visible)
>   *	- SPRG4 unused (user visible)
>   *	- SPRG6 TLB miss scratch (user visible, sorry !)
>   *	- SPRG7 critical exception scratch
> Index: linux-build/arch/powerpc/kernel/vdso.c
> ===================================================================
> --- linux-build.orig/arch/powerpc/kernel/vdso.c	2012-06-25 10:05:52.229077036 +1000
> +++ linux-build/arch/powerpc/kernel/vdso.c	2012-06-25 10:12:50.256171890 +1000
> @@ -706,6 +706,25 @@ static void __init vdso_setup_syscall_ma
>  	}
>  }
>  
> +#ifdef CONFIG_PPC64
> +int __cpuinit vdso_getcpu_init(void)
> +{
> +	unsigned long cpu, node;
> +
> +	/*
> +	 * SPRG3 contains the CPU in the bottom 32 bits and the NUMA node in the
> +	 * top 32 bits.
> +	 */
> +	cpu = get_cpu();
> +	node = cpu_to_node(cpu);
> +	mtspr(SPRN_SPRG3, cpu | (node << 32));
> +	put_cpu();
> +
> +	return 0;
> +}
> +/* We need to call this before SMP init */
> +early_initcall(vdso_getcpu_init);
> +#endif
>  
>  static int __init vdso_init(void)
>  {
> Index: linux-build/arch/powerpc/kernel/vdso64/Makefile
> ===================================================================
> --- linux-build.orig/arch/powerpc/kernel/vdso64/Makefile	2012-06-25 10:05:52.209076696 +1000
> +++ linux-build/arch/powerpc/kernel/vdso64/Makefile	2012-06-25 10:05:53.737102674 +1000
> @@ -1,6 +1,6 @@
>  # List of files in the vdso, has to be asm only for now
>  
> -obj-vdso64 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o
> +obj-vdso64 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o getcpu.o
>  
>  # Build rules
>  
> Index: linux-build/arch/powerpc/kernel/vdso64/vdso64.lds.S
> ===================================================================
> --- linux-build.orig/arch/powerpc/kernel/vdso64/vdso64.lds.S	2012-06-25 10:05:52.217076832 +1000
> +++ linux-build/arch/powerpc/kernel/vdso64/vdso64.lds.S	2012-06-25 10:05:53.737102674 +1000
> @@ -146,6 +146,7 @@ VERSION
>  		__kernel_sync_dicache;
>  		__kernel_sync_dicache_p5;
>  		__kernel_sigtramp_rt64;
> +		__kernel_getcpu;
>  
>  	local: *;
>  	};
> Index: linux-build/arch/powerpc/kernel/vdso64/getcpu.S
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-build/arch/powerpc/kernel/vdso64/getcpu.S	2012-06-25 10:09:11.796467121 +1000
> @@ -0,0 +1,44 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + *
> + * Copyright (C) IBM Corporation, 2012
> + *
> + * Author: Anton Blanchard <anton@au.ibm.com>
> + */
> +#include <asm/ppc_asm.h>
> +#include <asm/vdso.h>
> +
> +	.text
> +/*
> + * Exact prototype of getcpu
> + *
> + * int __kernel_getcpu(unsigned *cpu, unsigned *node);
> + *
> + */
> +V_FUNCTION_BEGIN(__kernel_getcpu)
> +  .cfi_startproc
> +	mfspr	r5,SPRN_USPRG3
> +	cmpdi	cr0,r3,0
> +	cmpdi	cr1,r4,0
> +	srdi	r6,r5,32
> +	beq	cr0,1f
> +	stw	r5,0(r3)
> +1:	beq	cr1,2f
> +	stw	r6,0(r4)
> +2:	crclr	cr0*4+so
> +	li	r3,0			/* always success */
> +	blr
> +  .cfi_endproc
> +V_FUNCTION_END(__kernel_getcpu)
> Index: linux-build/arch/powerpc/kernel/smp.c
> ===================================================================
> --- linux-build.orig/arch/powerpc/kernel/smp.c	2012-06-25 10:05:52.197076492 +1000
> +++ linux-build/arch/powerpc/kernel/smp.c	2012-06-25 10:13:54.897266908 +1000
> @@ -48,6 +48,7 @@
>  #ifdef CONFIG_PPC64
>  #include <asm/paca.h>
>  #endif
> +#include <asm/vdso.h>
>  #include <asm/debug.h>
>  
>  #ifdef DEBUG
> @@ -570,6 +571,8 @@ void __devinit start_secondary(void *unu
>  #ifdef CONFIG_PPC64
>  	if (system_state == SYSTEM_RUNNING)
>  		vdso_data->processorCount++;
> +
> +	vdso_getcpu_init();
>  #endif
>  	ipi_call_lock();
>  	notify_cpu_starting(cpu);
> Index: linux-build/arch/powerpc/include/asm/vdso.h
> ===================================================================
> --- linux-build.orig/arch/powerpc/include/asm/vdso.h	2012-06-25 10:05:52.181076220 +1000
> +++ linux-build/arch/powerpc/include/asm/vdso.h	2012-06-25 10:05:53.737102674 +1000
> @@ -22,6 +22,8 @@ extern unsigned long vdso64_rt_sigtramp;
>  extern unsigned long vdso32_sigtramp;
>  extern unsigned long vdso32_rt_sigtramp;
>  
> +int __cpuinit vdso_getcpu_init(void);
> +
>  #else /* __ASSEMBLY__ */
>  
>  #ifdef __VDSO64__
