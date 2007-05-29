Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 20753DDFF9
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 23:24:58 +1000 (EST)
In-Reply-To: <20070529064531.D874CDDF70@ozlabs.org>
References: <20070529064531.D874CDDF70@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B1CC4B3D-D77E-4023-BE92-2A8405998E38@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC/PATCH 2/5] powerpc: Cleanup ptrace bits
Date: Tue, 29 May 2007 08:23:59 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, ulrich.weigand@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 29, 2007, at 1:45 AM, Benjamin Herrenschmidt wrote:

> The powerpc ptrace code has some weirdness, like a ptrace-common.h  
> file that
> is actually ppc64 only and some of the 32 bits code ifdef'ed inside  
> ptrace.c.
>
> There are also separate implementations for things like get/ 
> set_vrregs for
> 32 and 64 bits which is totally unnecessary.
>
> This patch cleans that up a bit by having a ptrace-common.h which  
> contains
> really common code (and makes a lot more code common), and ptrace- 
> ppc32.h and
> ptrace-ppc64.h files that contain the few remaining different bits.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
>  arch/powerpc/kernel/ptrace-common.h |   89 +++++++---------
>  arch/powerpc/kernel/ptrace-ppc32.h  |  100 ++++++++++++++++++
>  arch/powerpc/kernel/ptrace-ppc64.h  |   51 +++++++++
>  arch/powerpc/kernel/ptrace.c        |  198  
> ------------------------------------
>  arch/powerpc/kernel/ptrace32.c      |    1
>  5 files changed, 197 insertions(+), 242 deletions(-)
>
> Index: linux-cell/arch/powerpc/kernel/ptrace-common.h
> ===================================================================
> --- linux-cell.orig/arch/powerpc/kernel/ptrace-common.h	2007-05-29  
> 13:05:55.000000000 +1000
> +++ linux-cell/arch/powerpc/kernel/ptrace-common.h	2007-05-29  
> 16:22:00.000000000 +1000
> @@ -1,5 +1,6 @@
>  /*
>   *    Copyright (c) 2002 Stephen Rothwell, IBM Coproration
> + *    Copyright (c) 2007 Benjamin Herrenschmidt, IBM Coproration
>   *    Extracted from ptrace.c and ptrace32.c
>   *
>   * This file is subject to the terms and conditions of the GNU  
> General
> @@ -7,15 +8,8 @@
>   * this archive for more details.
>   */
>
> -#ifndef _PPC64_PTRACE_COMMON_H
> -#define _PPC64_PTRACE_COMMON_H
> -
> -#include <asm/system.h>
> -
> -/*
> - * Set of msr bits that gdb can change on behalf of a process.
> - */
> -#define MSR_DEBUGCHANGE	(MSR_FE0 | MSR_SE | MSR_BE | MSR_FE1)
> +#ifndef _POWERPC_PTRACE_COMMON_H
> +#define _POWERPC_PTRACE_COMMON_H
>
>  /*
>   * Get contents of register REGNO in task TASK.
> @@ -24,18 +18,18 @@ static inline unsigned long get_reg(stru
>  {
>  	unsigned long tmp = 0;
>
> -	/*
> -	 * Put the correct FP bits in, they might be wrong as a result
> -	 * of our lazy FP restore.
> -	 */

Do we do some different lazy save/restore on ppc64 than ppc32?  I'm  
trying to understand why the comment isn't (or wasn't) valid for  
ppc32 as well.

> +	if (task->thread.regs == NULL)
> +		return -EIO;
> +
>  	if (regno == PT_MSR) {
>  		tmp = ((unsigned long *)task->thread.regs)[PT_MSR];
> -		tmp |= task->thread.fpexc_mode;
> -	} else if (regno < (sizeof(struct pt_regs) / sizeof(unsigned  
> long))) {
> -		tmp = ((unsigned long *)task->thread.regs)[regno];
> +		return PT_MUNGE_MSR(tmp, task);
>  	}
>
> -	return tmp;
> +	if (regno < (sizeof(struct pt_regs) / sizeof(unsigned long)))
> +		return ((unsigned long *)task->thread.regs)[regno];
> +
> +	return -EIO;
>  }
