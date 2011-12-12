Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 68FD7B6F7E
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 09:59:06 +1100 (EST)
Message-ID: <1323730739.19891.23.camel@pasglop>
Subject: Re: [PATCH 1/4] powerpc/kprobe: introduce a new thread flag
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Tue, 13 Dec 2011 09:58:59 +1100
In-Reply-To: <1323679853-31751-2-git-send-email-tiejun.chen@windriver.com>
References: <1323679853-31751-1-git-send-email-tiejun.chen@windriver.com>
 <1323679853-31751-2-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-12-12 at 16:50 +0800, Tiejun Chen wrote:
> We need to add a new thread flag, TIF_KPROBE/_TIF_DELAYED_KPROBE,
> for handling kprobe operation while exiting exception.

The basic idea is sane, however the instruction emulation isn't per-se
kprobe specific. It could be used by xmon too for example. I'd rather
use a different name, something like TIF_EMULATE_STACK_STORE or
something like that.

Cheers,
Ben.

> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/include/asm/thread_info.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 836f231..3378734 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -112,6 +112,7 @@ static inline struct thread_info *current_thread_info(void)
>  #define TIF_FREEZE		14	/* Freezing for suspend */
>  #define TIF_SYSCALL_TRACEPOINT	15	/* syscall tracepoint instrumentation */
>  #define TIF_RUNLATCH		16	/* Is the runlatch enabled? */
> +#define TIF_KPROBE		17	/* Is the delayed kprobe operation? */
>  
>  /* as above, but as bit values */
>  #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
> @@ -130,6 +131,7 @@ static inline struct thread_info *current_thread_info(void)
>  #define _TIF_FREEZE		(1<<TIF_FREEZE)
>  #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
>  #define _TIF_RUNLATCH		(1<<TIF_RUNLATCH)
> +#define _TIF_DELAYED_KPROBE	(1<<TIF_KPROBE)
>  #define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
>  				 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT)
>  
