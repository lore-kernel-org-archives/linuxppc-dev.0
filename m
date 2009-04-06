Return-Path: <srostedt@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id BFA65DDE25
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 00:46:05 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc/ftrace: Fix #if that should be #ifdef
From: Steven Rostedt <srostedt@redhat.com>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <db258c8de9d950c23d61abdcd121361a7bb40f75.1239028836.git.michael@ellerman.id.au>
References: <db258c8de9d950c23d61abdcd121361a7bb40f75.1239028836.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Mon, 06 Apr 2009 10:45:52 -0400
Message-Id: <1239029152.4753.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Note, I only use my Red Hat email account to acknowledge who pays me to
do the work. But I'm much more reachable at rostedt@goodmis.org (as it
says in the maintainers file). I may go weeks without reading the RH
email.

On Tue, 2009-04-07 at 00:40 +1000, Michael Ellerman wrote:
> Commit bb7253403f7a4670a128e4c080fd8ea1bd4d5029 (powerpc64,
> ftrace: save toc only on modules for function graph), added a
> 
> Fixes the following warning on 32-bit builds:
>  arch/powerpc/kernel/ftrace.c:562:5: error: "CONFIG_PPC64" is not defined
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Steven Rostedt <rostedt@goodmis.org>

Hmm, maybe I'll keep the "Git Author" as srostedt@redhat.com, and change
the signature to my goodmis account. Maybe that would be less confusing.

-- Steve

> ---
>  arch/powerpc/kernel/ftrace.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
> index e74f2dd..e9d9d38 100644
> --- a/arch/powerpc/kernel/ftrace.c
> +++ b/arch/powerpc/kernel/ftrace.c
> @@ -559,7 +559,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
>  	if (unlikely(atomic_read(&current->tracing_graph_pause)))
>  		return;
>  
> -#if CONFIG_PPC64
> +#ifdef CONFIG_PPC64
>  	/* non core kernel code needs to save and restore the TOC */
>  	if (REGION_ID(self_addr) != KERNEL_REGION_ID)
>  		return_hooker = (unsigned long)&mod_return_to_handler;
