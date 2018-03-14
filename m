Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401Sqc603vzDqps
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 21:38:20 +1100 (AEDT)
Subject: Re: [PATCH 04/21] powerpc: Mark both tmp variables as unused
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-5-malat@debian.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <3f881ec2-eb0f-77e6-f1c5-95530b8f84ad@c-s.fr>
Date: Wed, 14 Mar 2018 11:38:13 +0100
MIME-Version: 1.0
In-Reply-To: <20180225172236.29650-5-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 25/02/2018 à 18:22, Mathieu Malaterre a écrit :
> Since the value of `tmp` is never intended to be read, declare both `tmp`
> variables as unused. Fix warning (treated as error in W=1):

What about using fault_in_pages_readable() instead ?

Christophe

> 
>    CC      arch/powerpc/kernel/signal_32.o
> arch/powerpc/kernel/signal_32.c: In function ‘sys_swapcontext’:
> arch/powerpc/kernel/signal_32.c:1048:16: error: variable ‘tmp’ set but not used [-Werror=unused-but-set-variable]
>    unsigned char tmp;
>                  ^~~
> arch/powerpc/kernel/signal_32.c: In function ‘sys_debug_setcontext’:
> arch/powerpc/kernel/signal_32.c:1234:16: error: variable ‘tmp’ set but not used [-Werror=unused-but-set-variable]
>    unsigned char tmp;
>                  ^~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/kernel/signal_32.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
> index a46de0035214..492f03451877 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -1045,7 +1045,7 @@ long sys_swapcontext(struct ucontext __user *old_ctx,
>   		     struct ucontext __user *new_ctx,
>   		     int ctx_size, int r6, int r7, int r8, struct pt_regs *regs)
>   {
> -	unsigned char tmp;
> +	unsigned char tmp __maybe_unused;
>   	int ctx_has_vsx_region = 0;
>   
>   #ifdef CONFIG_PPC64
> @@ -1231,7 +1231,7 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
>   {
>   	struct sig_dbg_op op;
>   	int i;
> -	unsigned char tmp;
> +	unsigned char tmp __maybe_unused;
>   	unsigned long new_msr = regs->msr;
>   #ifdef CONFIG_PPC_ADV_DEBUG_REGS
>   	unsigned long new_dbcr0 = current->thread.debug.dbcr0;
> 
