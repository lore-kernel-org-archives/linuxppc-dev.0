Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9BF70DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 17:17:41 +1000 (EST)
Subject: Re: [RFC] [PATCH] task_pt_regs for powerpc systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Srinivasa D S <srinivasa@in.ibm.com>
In-Reply-To: <200807071952.27427.srinivasa@in.ibm.com>
References: <200807071952.27427.srinivasa@in.ibm.com>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 16:21:36 +1000
Message-Id: <1215498096.8970.209.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-07 at 19:52 +0530, Srinivasa D S wrote:
> Hi
>  task_pt_regs() macro defines pt_regs for the given task,  this macro is  
> currently not defined for powerpc arch. We need this macro for 
> upcoming utrace features. 
>  Below attached patch  defines this macro for powerpc arch. Please let 
> me know your comments on this.
> 
> Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>

Looks good to me. I'll include it in the next batch.

Cheers,
Ben.

> ---
>  include/asm-powerpc/processor.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-2.6.26-rc9/include/asm-powerpc/processor.h
> ===================================================================
> --- linux-2.6.26-rc9.orig/include/asm-powerpc/processor.h
> +++ linux-2.6.26-rc9/include/asm-powerpc/processor.h
> @@ -214,6 +214,8 @@ struct thread_struct {
>  #define thread_saved_pc(tsk)    \
>          ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
>  
> +#define task_pt_regs(tsk)	((struct pt_regs *)(tsk)->thread.regs)
> +
>  unsigned long get_wchan(struct task_struct *p);
>  
>  #define KSTK_EIP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
