Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id ED48367B84
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 08:38:17 +1000 (EST)
Date: Tue, 18 Jul 2006 17:34:25 -0500
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH 2/3] powerpc: Instrument Hypervisor Calls: add wrappers
Message-ID: <20060718223425.GB5238@pb15.lixom.net>
References: <20060718204723.GA6104@w-mikek2.ibm.com>
	<20060718204946.GC6104@w-mikek2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060718204946.GC6104@w-mikek2.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 18, 2006 at 01:49:46PM -0700, Mike Kravetz wrote:
> Add wrappers which perform the actual hypervisor call instrumentation.
> --
> Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

NACK.

As I said before, SPRN_PURR doesn't exist on all architecture versions
that supports hypervisor mode. Try booting on a JS20/21 or a POWER4
machine in LPAR mode and you'll see. (Unfortunately I don't have access
to any such hardware myself, so I can't send you oops output to show it).


-Olof

> diff -Naupr linux-2.6.17.6/arch/powerpc/Kconfig.debug linux-2.6.17.6.work/arch/powerpc/Kconfig.debug
> --- linux-2.6.17.6/arch/powerpc/Kconfig.debug	2006-07-15 19:00:43.000000000 +0000
> +++ linux-2.6.17.6.work/arch/powerpc/Kconfig.debug	2006-07-18 19:56:20.000000000 +0000
> @@ -18,6 +18,20 @@ config DEBUG_STACK_USAGE
>  
>  	  This option will slow down process creation somewhat.
>  
> +config HCALL_STATS
> +	bool "Hypervisor call instrumentation"
> +	depends on PPC_PSERIES && DEBUG_FS
> +	help
> +	  Adds code to keep track of the number of hypervisor calls made and
> +	  the amount of time spent in hypervisor calls: both wall time (based
> +	  on time base) and cpu time (based on PURR).  A directory named
> +	  hcall_inst is added at the root of the debugfs filesystem.  Within
> +	  the hcall_inst directory are files that contain CPU specific call
> +	  statistics.
> +
> +	  This option will add a small amount of overhead to all hypervisor
> +	  calls.
> +
>  config DEBUGGER
>  	bool "Enable debugger hooks"
>  	depends on DEBUG_KERNEL
> diff -Naupr linux-2.6.17.6/arch/powerpc/platforms/pseries/Makefile linux-2.6.17.6.work/arch/powerpc/platforms/pseries/Makefile
> --- linux-2.6.17.6/arch/powerpc/platforms/pseries/Makefile	2006-07-15 19:00:43.000000000 +0000
> +++ linux-2.6.17.6.work/arch/powerpc/platforms/pseries/Makefile	2006-07-18 19:56:20.000000000 +0000
> @@ -9,3 +9,4 @@ obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o e
>  
>  obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
>  obj-$(CONFIG_HVCS)		+= hvcserver.o
> +obj-$(CONFIG_HCALL_STATS)	+= hvCall_inst.o
> diff -Naupr linux-2.6.17.6/arch/powerpc/platforms/pseries/hvCall.S linux-2.6.17.6.work/arch/powerpc/platforms/pseries/hvCall.S
> --- linux-2.6.17.6/arch/powerpc/platforms/pseries/hvCall.S	2006-07-15 19:00:43.000000000 +0000
> +++ linux-2.6.17.6.work/arch/powerpc/platforms/pseries/hvCall.S	2006-07-18 19:56:20.000000000 +0000
> @@ -11,7 +11,35 @@
>  #include <asm/hvcall.h>
>  #include <asm/processor.h>
>  #include <asm/ppc_asm.h>
> -	
> +
> +/*
> + * If hcall statistics are desired, all routines are wrapped with code
> + * that does the statistic gathering.
> + */
> +#ifndef CONFIG_HCALL_STATS
> +#define PLPAR_HCALL		plpar_hcall
> +#define PLPAR_HCALL_NORETS	plpar_hcall_norets
> +#define PLPAR_HCALL_8ARG_2RET	plpar_hcall_8arg_2ret
> +#define PLPAR_HCALL_4OUT	plpar_hcall_4out
> +#define PLPAR_HCALL_7ARG_7RET	plpar_hcall_7arg_7ret
> +#define PLPAR_HCALL_9ARG_9RET	plpar_hcall_9arg_9ret
> +#else
> +#define PLPAR_HCALL		plpar_hcall_base
> +#define PLPAR_HCALL_NORETS	plpar_hcall_norets_base
> +#define PLPAR_HCALL_8ARG_2RET	plpar_hcall_8arg_2ret_base
> +#define PLPAR_HCALL_4OUT	plpar_hcall_4out_base
> +#define PLPAR_HCALL_7ARG_7RET	plpar_hcall_7arg_7ret_base
> +#define PLPAR_HCALL_9ARG_9RET	plpar_hcall_9arg_9ret_base
> +
> +/*
> + * A special 'indirect' call to a C based wrapper if statistics are desired.
> + * See plpar_hcall_norets_C function header for more details.
> + */
> +_GLOBAL(plpar_hcall_norets)
> +	b	plpar_hcall_norets_C
> +
> +#endif
> +
>  #define STK_PARM(i)     (48 + ((i)-3)*8)
>  
>  	.text
> @@ -25,7 +53,7 @@
>  			unsigned long *out2,		R9
>  			unsigned long *out3);		R10
>   */
> -_GLOBAL(plpar_hcall)
> +_GLOBAL(PLPAR_HCALL)
>  	HMT_MEDIUM
>  
>  	mfcr	r0
> @@ -52,7 +80,7 @@ _GLOBAL(plpar_hcall)
>  
>  
>  /* Simple interface with no output values (other than status) */
> -_GLOBAL(plpar_hcall_norets)
> +_GLOBAL(PLPAR_HCALL_NORETS)
>  	HMT_MEDIUM
>  
>  	mfcr	r0
> @@ -76,7 +104,7 @@ _GLOBAL(plpar_hcall_norets)
>  			unsigned long arg8,		112(R1)
>  			unsigned long *out1);		120(R1)
>   */
> -_GLOBAL(plpar_hcall_8arg_2ret)
> +_GLOBAL(PLPAR_HCALL_8ARG_2RET)
>  	HMT_MEDIUM
>  
>  	mfcr	r0
> @@ -102,7 +130,7 @@ _GLOBAL(plpar_hcall_8arg_2ret)
>  		 	unsigned long *out3,		R10
>  		 	unsigned long *out4);		112(R1)
>   */
> -_GLOBAL(plpar_hcall_4out)
> +_GLOBAL(PLPAR_HCALL_4OUT)
>  	HMT_MEDIUM
>  
>  	mfcr	r0
> @@ -144,7 +172,7 @@ _GLOBAL(plpar_hcall_4out)
>  			 unsigned long *out6,		102(R1)
>  			 unsigned long *out7);		100(R1)
>  */
> -_GLOBAL(plpar_hcall_7arg_7ret)
> +_GLOBAL(PLPAR_HCALL_7ARG_7RET)
>  	HMT_MEDIUM
>  
>  	mfcr	r0
> @@ -193,7 +221,7 @@ _GLOBAL(plpar_hcall_7arg_7ret)
>  			 unsigned long *out8,		 94(R1)
>  		         unsigned long *out9,            92(R1)
>  */
> -_GLOBAL(plpar_hcall_9arg_9ret)
> +_GLOBAL(PLPAR_HCALL_9ARG_9RET)
>  	HMT_MEDIUM
>  
>  	mfcr	r0
> diff -Naupr linux-2.6.17.6/arch/powerpc/platforms/pseries/hvCall_inst.c linux-2.6.17.6.work/arch/powerpc/platforms/pseries/hvCall_inst.c
> --- linux-2.6.17.6/arch/powerpc/platforms/pseries/hvCall_inst.c	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.17.6.work/arch/powerpc/platforms/pseries/hvCall_inst.c	2006-07-18 19:57:44.000000000 +0000
> @@ -0,0 +1,216 @@
> +/*
> + * Copyright (C) 2006 Mike Kravetz IBM Corporation
> + *
> + * Hypervisor Call Instrumentation
> + *
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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/percpu.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +#include <linux/cpumask.h>
> +#include <asm/hvcall.h>
> +#include <asm/firmware.h>
> +
> +DEFINE_PER_CPU(struct hcall_stats[MAX_HCALL_OPCODES+1], hcall_stats);
> +
> +/*
> + * Common update of the per-CPU/per-hcall statistics
> + */
> +static inline void update_stats(unsigned long opcode,
> +				unsigned long t_tb_before,
> +				unsigned long t_cpu_before)
> +{
> +	unsigned long op_index = opcode >> 2;
> +	struct hcall_stats *hs = &__get_cpu_var(hcall_stats[op_index]);
> +
> +	hs->tb_total += (mftb() - t_tb_before);
> +	hs->cpu_total += (mfspr(SPRN_PURR) - t_cpu_before);
> +	hs->num_calls++;
> +}
> +
> +/*
> + * plpar_hcall wrapper
> + */
> +long plpar_hcall(unsigned long opcode,
> +                 unsigned long arg1,
> +                 unsigned long arg2,
> +                 unsigned long arg3,
> +                 unsigned long arg4,
> +                 unsigned long *out1,
> +                 unsigned long *out2,
> +                 unsigned long *out3)
> +{
> +	long rc;
> +	unsigned long t_tb_before, t_cpu_before;
> +
> +	t_tb_before = mftb();
> +	t_cpu_before = mfspr(SPRN_PURR);
> +	rc = plpar_hcall_base(opcode, arg1, arg2, arg3, arg4, out1, out2, out3);
> +
> +	update_stats(opcode, t_tb_before, t_cpu_before);
> +	return rc;
> +}
> +
> +/*
> + * A C based wrapper for plpar_hcall_norets
> + * The wrapper for plpar_hcall_norets is a special case because the function
> + * takes a variable number of arguments.  It is almost impossible to write a
> + * wrapper for a function that takes a variable number of arguments in C.
> + * Therefore, there is an assembly routine in hvCall.S that simply branches
> + * to this C wrapper.  This 'indirection' takes care of the variable arguments
> + * issue.  This C wrapper has a fixed maximum number of arguments.
> + */
> +long plpar_hcall_norets_C(unsigned long opcode,
> +				unsigned long arg1,
> +				unsigned long arg2,
> +				unsigned long arg3,
> +				unsigned long arg4,
> +				unsigned long arg5,
> +				unsigned long arg6)
> +{
> +	long rc;
> +	unsigned long t_tb_before, t_cpu_before;
> +
> +	t_tb_before = mftb();
> +	t_cpu_before = mfspr(SPRN_PURR);
> +	rc = plpar_hcall_norets_base(opcode, arg1, arg2, arg3, arg4, arg5,
> +				     arg6);
> +
> +	update_stats(opcode, t_tb_before, t_cpu_before);
> +	return rc;
> +}
> +
> +/*
> + * plpar_hcall_8arg_2ret wrapper
> + */
> +long plpar_hcall_8arg_2ret(unsigned long opcode,
> +                           unsigned long arg1,
> +                           unsigned long arg2,
> +                           unsigned long arg3,
> +                           unsigned long arg4,
> +                           unsigned long arg5,
> +                           unsigned long arg6,
> +                           unsigned long arg7,
> +                           unsigned long arg8,
> +                           unsigned long *out1)
> +{
> +	long rc;
> +	unsigned long t_tb_before, t_cpu_before;
> +
> +	t_tb_before = mftb();
> +	t_cpu_before = mfspr(SPRN_PURR);
> +	rc = plpar_hcall_8arg_2ret_base(opcode, arg1, arg2, arg3, arg4, arg5,
> +					arg6, arg7, arg8, out1);
> +
> +	update_stats(opcode, t_tb_before, t_cpu_before);
> +	return rc;
> +}
> +
> +/*
> + * plpar_hcall_4out wrapper
> + */
> +long plpar_hcall_4out(unsigned long opcode,
> +                      unsigned long arg1,
> +                      unsigned long arg2,
> +                      unsigned long arg3,
> +                      unsigned long arg4,
> +                      unsigned long *out1,
> +                      unsigned long *out2,
> +                      unsigned long *out3,
> +                      unsigned long *out4)
> +{
> +	long rc;
> +	unsigned long t_tb_before, t_cpu_before;
> +
> +	t_tb_before = mftb();
> +	t_cpu_before = mfspr(SPRN_PURR);
> +	rc = plpar_hcall_4out_base(opcode, arg1, arg2, arg3, arg4, out1,
> +				   out2, out3, out4);
> +
> +	update_stats(opcode, t_tb_before, t_cpu_before);
> +	return rc;
> +}
> +
> +/*
> + * plpar_hcall_7arg_7ret wrapper
> + */
> +long plpar_hcall_7arg_7ret(unsigned long opcode,
> +                           unsigned long arg1,
> +                           unsigned long arg2,
> +                           unsigned long arg3,
> +                           unsigned long arg4,
> +                           unsigned long arg5,
> +                           unsigned long arg6,
> +                           unsigned long arg7,
> +                           unsigned long *out1,
> +                           unsigned long *out2,
> +                           unsigned long *out3,
> +                           unsigned long *out4,
> +                           unsigned long *out5,
> +                           unsigned long *out6,
> +                           unsigned long *out7)
> +{
> +	long rc;
> +	unsigned long t_tb_before, t_cpu_before;
> +
> +	t_tb_before = mftb();
> +	t_cpu_before = mfspr(SPRN_PURR);
> +	rc = plpar_hcall_7arg_7ret_base(opcode, arg1, arg2, arg3, arg4, arg5,
> +					arg6, arg7, out1, out2, out3, out4,
> +					out5, out6, out7);
> +
> +	update_stats(opcode, t_tb_before, t_cpu_before);
> +	return rc;
> +}
> +
> +/*
> + * plpar_hcall_9arg_9ret wrapper
> + */
> +long plpar_hcall_9arg_9ret(unsigned long opcode,
> +                           unsigned long arg1,
> +                           unsigned long arg2,
> +                           unsigned long arg3,
> +                           unsigned long arg4,
> +                           unsigned long arg5,
> +                           unsigned long arg6,
> +                           unsigned long arg7,
> +                           unsigned long arg8,
> +                           unsigned long arg9,
> +                           unsigned long *out1,
> +                           unsigned long *out2,
> +                           unsigned long *out3,
> +                           unsigned long *out4,
> +                           unsigned long *out5,
> +                           unsigned long *out6,
> +                           unsigned long *out7,
> +                           unsigned long *out8,
> +                           unsigned long *out9)
> +{
> +	long rc;
> +	unsigned long t_tb_before, t_cpu_before;
> +
> +	t_tb_before = mftb();
> +	t_cpu_before = mfspr(SPRN_PURR);
> +	rc = plpar_hcall_9arg_9ret_base(opcode, arg1, arg2, arg3, arg4, arg5,
> +					arg6, arg7, arg8, arg9, out1, out2,
> +					out3, out4, out5, out6, out7, out8,
> +					out9);
> +
> +	update_stats(opcode, t_tb_before, t_cpu_before);
> +	return rc;
> +}
> diff -Naupr linux-2.6.17.6/include/asm-powerpc/hvcall.h linux-2.6.17.6.work/include/asm-powerpc/hvcall.h
> --- linux-2.6.17.6/include/asm-powerpc/hvcall.h	2006-07-18 19:35:00.000000000 +0000
> +++ linux-2.6.17.6.work/include/asm-powerpc/hvcall.h	2006-07-18 19:56:20.000000000 +0000
> @@ -292,6 +292,87 @@ long plpar_hcall_9arg_9ret(unsigned long
>  			   unsigned long *out8,
>  			   unsigned long *out9);
>  
> +
> +/* For hcall instrumentation.  One structure per-hcall, per-CPU */
> +struct hcall_stats {
> +	unsigned long	num_calls;	/* number of calls (on this CPU) */
> +	unsigned long	tb_total;	/* total wall time (mftb) of calls. */
> +	unsigned long	cpu_total;	/* total cpu time (PURR) of calls. */
> +};
> +
> +/* If Hypervisor call instrumentation is enabled, the assembly routine
> + * names are changed from 'plpar_hcall*' to 'plpar_hcall*_base' and
> + * 'plpar_hcall*' routines become instrumented wrappers.  The following
> + * are declarations for the renamed 'plpar_hcall*_base' routines.
> + */
> +long plpar_hcall_base (unsigned long opcode,
> +		       unsigned long arg1,
> +		       unsigned long arg2,
> +		       unsigned long arg3,
> +		       unsigned long arg4,
> +		       unsigned long *out1,
> +		       unsigned long *out2,
> +		       unsigned long *out3);
> +
> +long plpar_hcall_norets_base(unsigned long opcode, ...);
> +
> +long plpar_hcall_8arg_2ret_base(unsigned long opcode,
> +				unsigned long arg1,
> +				unsigned long arg2,
> +				unsigned long arg3,
> +				unsigned long arg4,
> +				unsigned long arg5,
> +				unsigned long arg6,
> +				unsigned long arg7,
> +				unsigned long arg8,
> +				unsigned long *out1);
> +
> +long plpar_hcall_4out_base(unsigned long opcode,
> +			   unsigned long arg1,
> +			   unsigned long arg2,
> +			   unsigned long arg3,
> +			   unsigned long arg4,
> +			   unsigned long *out1,
> +			   unsigned long *out2,
> +			   unsigned long *out3,
> +			   unsigned long *out4);
> +
> +long plpar_hcall_7arg_7ret_base(unsigned long opcode,
> +				unsigned long arg1,
> +				unsigned long arg2,
> +				unsigned long arg3,
> +				unsigned long arg4,
> +				unsigned long arg5,
> +				unsigned long arg6,
> +				unsigned long arg7,
> +				unsigned long *out1,
> +				unsigned long *out2,
> +				unsigned long *out3,
> +				unsigned long *out4,
> +				unsigned long *out5,
> +				unsigned long *out6,
> +				unsigned long *out7);
> +
> +long plpar_hcall_9arg_9ret_base(unsigned long opcode,
> +				unsigned long arg1,
> +				unsigned long arg2,
> +				unsigned long arg3,
> +				unsigned long arg4,
> +				unsigned long arg5,
> +				unsigned long arg6,
> +				unsigned long arg7,
> +				unsigned long arg8,
> +				unsigned long arg9,
> +				unsigned long *out1,
> +				unsigned long *out2,
> +				unsigned long *out3,
> +				unsigned long *out4,
> +				unsigned long *out5,
> +				unsigned long *out6,
> +				unsigned long *out7,
> +				unsigned long *out8,
> +				unsigned long *out9);
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_HVCALL_H */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
