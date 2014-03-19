Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0242.outbound.protection.outlook.com [207.46.163.242])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 33D8F2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 09:05:31 +1100 (EST)
Message-ID: <1395266717.12479.293.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc 32: Provides VIRT_CPU_ACCOUNTING
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Wed, 19 Mar 2014 17:05:17 -0500
In-Reply-To: <20140319215241.236B21A4BDE@localhost.localdomain>
References: <20140319215241.236B21A4BDE@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-19 at 22:52 +0100, Christophe Leroy wrote:
> This patch provides VIRT_CPU_ACCOUTING to PPC32 architecture.
> Unlike PPC64, PPC32 doesn't provide the PACA register. Therefore the
> implementation is similar to the one done in the IA64 architecture.
> It is based on additional information added to the Task Info structure.

PACA isn't a register -- just a convention for how Linux uses a GPR.
Maybe it's time to use it on PPC32 as well?

> Index: b/arch/powerpc/kernel/asm-offsets.c
> ===================================================================
> --- b/arch/powerpc/kernel/asm-offsets.c	(revision 5607)
> +++ b/arch/powerpc/kernel/asm-offsets.c	(revision 5608)
> @@ -167,6 +167,10 @@
>  	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
>  	DEFINE(TI_TASK, offsetof(struct thread_info, task));
>  	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
> +	DEFINE(TI_AC_STAMP, offsetof(struct thread_info, ac_stamp));
> +	DEFINE(TI_AC_LEAVE, offsetof(struct thread_info, ac_leave));
> +	DEFINE(TI_AC_STIME, offsetof(struct thread_info, ac_stime));
> +	DEFINE(TI_AC_UTIME, offsetof(struct thread_info, ac_utime));

Doesn't this need to be protected by #ifdef
CONFIG_VIRT_CPU_ACCOUNTING_NATIVE?

>  
>  #ifdef CONFIG_PPC64
>  	DEFINE(DCACHEL1LINESIZE, offsetof(struct ppc64_caches, dline_size));
> Index: b/arch/powerpc/include/asm/thread_info.h
> ===================================================================
> --- b/arch/powerpc/include/asm/thread_info.h	(revision 5607)
> +++ b/arch/powerpc/include/asm/thread_info.h	(revision 5608)
> @@ -43,6 +43,12 @@
>  	int		cpu;			/* cpu we're on */
>  	int		preempt_count;		/* 0 => preemptable,
>  						   <0 => BUG */
> +#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> +	__u32 ac_stamp;
> +	__u32 ac_leave;
> +	__u32 ac_stime;
> +	__u32 ac_utime;
> +#endif

This isn't uapi; why not use "u32"?

Plus, it should be made clear that this is only used on 32-bit.

>  	struct restart_block restart_block;
>  	unsigned long	local_flags;		/* private flags for thread */
>  
> @@ -58,6 +64,8 @@
>  	.task =		&tsk,			\
>  	.exec_domain =	&default_exec_domain,	\
>  	.cpu =		0,			\
> +	.ac_stime =	0,			\
> +	.ac_utime =	0,			\

Also needs to be ifdeffed -- which isn't going to work in a macro, so
maybe remove the ifdef from the variable declarations, or just let the
fields be initialized to zero by default.  Or add PACA to 32-bit. :-)

-Scott
