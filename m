Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7B581A01DF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 19:48:09 +1100 (EST)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Wed, 8 Oct 2014 09:48:05 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3FDFC17D804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 09:50:16 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s988m2Ld51249232
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Oct 2014 08:48:02 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s988m2WS019077
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Oct 2014 02:48:02 -0600
Message-ID: <1412758077.4479.14.camel@TP420>
Subject: Re: [PATCH] powerpc: Reimplement __get_SP() as a function not a define
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Date: Wed, 08 Oct 2014 16:47:57 +0800
In-Reply-To: <20141001151000.0d754938@kryten>
References: <20141001151000.0d754938@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 三, 2014-10-01 at 15:10 +1000, Anton Blanchard wrote:
> Li Zhong points out an issue with our current __get_SP()
> implementation. If ftrace function tracing is enabled (ie -pg
> profiling using _mcount) we spill a stack frame on 64bit all the
> time.
> 
> If a function calls __get_SP() and later calls a function that is
> tail call optimised, we will pop the stack frame and the value
> returned by __get_SP() is no longer valid. An example from Li can
> be found in save_stack_trace -> save_context_stack:
> 
> c0000000000432c0 <.save_stack_trace>:
> c0000000000432c0:       mflr    r0
> c0000000000432c4:       std     r0,16(r1)
> c0000000000432c8:       stdu    r1,-128(r1) <-- stack frame for _mcount
> c0000000000432cc:       std     r3,112(r1)
> c0000000000432d0:       bl      <._mcount>
> c0000000000432d4:       nop
> 
> c0000000000432d8:       mr      r4,r1 <-- __get_SP()
> 
> c0000000000432dc:       ld      r5,632(r13)
> c0000000000432e0:       ld      r3,112(r1)
> c0000000000432e4:       li      r6,1
> 
> c0000000000432e8:       addi    r1,r1,128 <-- pop stack frame
> 
> c0000000000432ec:       ld      r0,16(r1)
> c0000000000432f0:       mtlr    r0
> c0000000000432f4:       b       <.save_context_stack> <-- tail call optimized
> 
> save_context_stack ends up with a stack pointer below the current
> one, and it is likely to be scribbled over.
> 
> Fix this by making __get_SP() a function which returns the
> callers stack frame. Also replace inline assembly which grabs
> the stack pointer in save_stack_trace and show_stack with
> __get_SP().
> 
> Reported-by: Li Zhong <zhong@linux.vnet.ibm.com>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/include/asm/reg.h   | 3 +--
>  arch/powerpc/kernel/misc.S       | 4 ++++
>  arch/powerpc/kernel/process.c    | 2 +-
>  arch/powerpc/kernel/stacktrace.c | 2 +-
>  4 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 0c05059..0f973c0 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1264,8 +1264,7 @@ static inline unsigned long mfvtb (void)
>  
>  #define proc_trap()	asm volatile("trap")
>  
> -#define __get_SP()	({unsigned long sp; \
> -			asm volatile("mr %0,1": "=r" (sp)); sp;})
> +extern unsigned long __get_SP(void);

It seems that some module code is using __get_SP, e.g. xfs in the
example below:
ERROR: ".__get_SP" [fs/xfs/xfs.ko] undefined!

Maybe we need export this symbol in arch/powerpc/kernel/ppc_ksyms.c? 

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 48d17d6f..eebd4e4 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -207,3 +207,5 @@ EXPORT_SYMBOL_GPL(mmu_psize_defs);
 #ifdef CONFIG_EPAPR_PARAVIRT
 EXPORT_SYMBOL(epapr_hypercall_start);
 #endif
+
+EXPORT_SYMBOL(__get_SP);

With the above compiling error fixed, this patch solved the SP issue I saw, so 

Tested-by: Li Zhong <zhong@linux.vnet.ibm.com>

>  
>  extern unsigned long scom970_read(unsigned int address);
>  extern void scom970_write(unsigned int address, unsigned long value);
> diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
> index 7ce26d4..120deb7 100644
> --- a/arch/powerpc/kernel/misc.S
> +++ b/arch/powerpc/kernel/misc.S
> @@ -114,3 +114,7 @@ _GLOBAL(longjmp)
>  	mtlr	r0
>  	mr	r3,r4
>  	blr
> +
> +_GLOBAL(__get_SP)
> +	PPC_LL	r3,0(r1)
> +	blr
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index aa1df89..3cc6439 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1545,7 +1545,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
>  		tsk = current;
>  	if (sp == 0) {
>  		if (tsk == current)
> -			asm("mr %0,1" : "=r" (sp));
> +			sp = __get_SP();
>  		else
>  			sp = tsk->thread.ksp;
>  	}
> diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
> index 3d30ef1..7f65bae 100644
> --- a/arch/powerpc/kernel/stacktrace.c
> +++ b/arch/powerpc/kernel/stacktrace.c
> @@ -50,7 +50,7 @@ void save_stack_trace(struct stack_trace *trace)
>  {
>  	unsigned long sp;
>  
> -	asm("mr %0,1" : "=r" (sp));
> +	sp = __get_SP();
>  
>  	save_context_stack(trace, sp, current, 1);
>  }
