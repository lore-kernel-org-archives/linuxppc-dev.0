Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 63CAFB70BA
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 19:40:40 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id nBH8bqqh023066
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 19:37:52 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBH8ac4E1421528
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 19:36:38 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBH8eacC012227
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 19:40:36 +1100
Message-ID: <4B29EE5F.9020801@linux.vnet.ibm.com>
Date: Thu, 17 Dec 2009 14:09:59 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH -tip tracing/kprobes] PPC: Powerpc port of the kprobe-based
	event tracer
References: <20091216043619.963539987@mars.in.ibm.com>
	<20091216043933.GA9328@in.ibm.com> <13884.1261016575@neuling.org>
In-Reply-To: <13884.1261016575@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Michael Neuling wrote:
>> Index: linux-2.6-tip/arch/powerpc/include/asm/ptrace.h
>> ===================================================================
>> --- linux-2.6-tip.orig/arch/powerpc/include/asm/ptrace.h
>> +++ linux-2.6-tip/arch/powerpc/include/asm/ptrace.h
>> @@ -83,6 +83,7 @@ struct pt_regs {
>>  
>>  #define instruction_pointer(regs) ((regs)->nip)
>>  #define user_stack_pointer(regs) ((regs)->gpr[1])
>> +#define kernel_stack_pointer(regs) ((regs)->gpr[1])
>>  #define regs_return_value(regs) ((regs)->gpr[3])
>>  
>>  #ifdef CONFIG_SMP
>> @@ -131,6 +132,69 @@ do {						
> 			      \
>>  } while (0)
>>  #endif /* __powerpc64__ */
>>  
>> +/* Query offset/name of register from its name/offset */
>> +#include <linux/stddef.h>
>> +#include <linux/thread_info.h>
> 
> Includes should be at the start of the file
> 
The compilation throws many errors when moved to start of the file. This 
file has lots of #ifdef and found this place to be perfect for compilation.

>> +/**
>> + * regs_query_register_name() - query register name from its offset
>> + * @offset:	the offset of a register in struct pt_regs.
>> + *
>> + * regs_query_register_name() returns the name of a register from its
>> + * offset in struct pt_regs. If the @offset is invalid, this returns NULL;
>> + */
>> +const char *regs_query_register_name(unsigned int offset)
>> +{
>> +	const struct pt_regs_offset *roff;
>> +	for (roff = regoffset_table; roff->name != NULL; roff++)
>> +		if (roff->offset == offset)
>> +			return roff->name;
>> +	return NULL;
>> +}
>> +
>> +static const int arg_offs_table[] = {
>> +	[0] = offsetof(struct pt_regs, gpr[3]),
>> +	[1] = offsetof(struct pt_regs, gpr[4]),
>> +	[2] = offsetof(struct pt_regs, gpr[5]),
>> +	[3] = offsetof(struct pt_regs, gpr[6]),
>> +	[4] = offsetof(struct pt_regs, gpr[7]),
>> +	[5] = offsetof(struct pt_regs, gpr[8]),
>> +	[6] = offsetof(struct pt_regs, gpr[9]),
>> +	[7] = offsetof(struct pt_regs, gpr[10])
>> +};
>> +
>> +/**
>> + * regs_get_argument_nth() - get Nth argument at function call
>> + * @regs:	pt_regs which contains registers at function entry.
>> + * @n:		argument number.
>> + *
>> + * regs_get_argument_nth() returns @n th argument of a function call.
>> + * Since usually the kernel stack will be changed right after function entry
> ,
>> + * you must use this at function entry. If the @n th entry is NOT in the
>> + * kernel stack or pt_regs, this returns 0.
>> + */
>> +unsigned long regs_get_argument_nth(struct pt_regs *regs, unsigned int n)
>> +{
>> +	if (n < ARRAY_SIZE(arg_offs_table))
>> +		return *(unsigned long *)((char *)regs + arg_offs_table[n]);
>> +	else {
>> +		/*
>> +		 * If more arguments are passed that can be stored in
>> +		 * registers, the remaining arguments are stored in the
>> +		 * parameter save area located at fixed offset from stack
>> +		 * pointer.
>> +		 * Following the PowerPC ABI, the first few arguments are
>> +		 * actually passed in registers (r3-r10), with equivalent space
>> +		 * left unused in the parameter save area.
>> +		 */
>> +		n += (PARAMETER_SAVE_AREA_OFFSET / sizeof(unsigned long));
>> +		return regs_get_kernel_stack_nth(regs, n);
> 
> How do we handle FP args?

Currently this patch does not support FP args.

> 
>> +	}
>> +}
>> +/*
>>   * does not yet catch signals sent when the child dies.
>>   * in exit.c or in signal.c.
>>   */
>> Index: linux-2.6-tip/kernel/trace/Kconfig
>> ===================================================================
>> --- linux-2.6-tip.orig/kernel/trace/Kconfig
>> +++ linux-2.6-tip/kernel/trace/Kconfig
>> @@ -464,7 +464,7 @@ config BLK_DEV_IO_TRACE
>>  
>>  config KPROBE_EVENT
>>  	depends on KPROBES
>> -	depends on X86
>> +	depends on X86 || PPC
>>  	bool "Enable kprobes-based dynamic events"
>>  	select TRACING
>>  	default y
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>

Thanks for reviewing.

Thanks,
-Mahesh.
