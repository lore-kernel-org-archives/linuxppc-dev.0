Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXNQq3zByzDqLw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 18:52:51 +1000 (AEST)
Subject: Re: [PATCH] powerpc: Use reg.h values for program check reason codes
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170816065024.24459-1-cyrilbur@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <52bb17c2-e555-562d-1340-f4e9be11ffe2@c-s.fr>
Date: Wed, 16 Aug 2017 10:52:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170816065024.24459-1-cyrilbur@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Le 16/08/2017 à 08:50, Cyril Bur a écrit :
> Small amount of #define duplication, makes sense for these to be in
> reg.h.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Looks similar to the following applies commit, doesn't it ?

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=merge&id=d30a5a5262ca64d58aa07fb2ecd7f992df83b4bc

Christophe

> ---
>   arch/powerpc/include/asm/reg.h |  1 +
>   arch/powerpc/kernel/traps.c    | 10 +++++-----
>   2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index a3b6575c7842..c22b1ae5ad03 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -675,6 +675,7 @@
>   					  * may not be recoverable */
>   #define	  SRR1_WS_DEEPER	0x00020000 /* Some resources not maintained */
>   #define	  SRR1_WS_DEEP		0x00010000 /* All resources maintained */
> +#define   SRR1_PROGTMBAD	0x00200000 /* TM Bad Thing */
>   #define   SRR1_PROGFPE		0x00100000 /* Floating Point Enabled */
>   #define   SRR1_PROGILL		0x00080000 /* Illegal instruction */
>   #define   SRR1_PROGPRIV		0x00040000 /* Privileged instruction */
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 1f7ec178db05..0a5ddaea8bf1 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -416,11 +416,11 @@ static inline int check_io_access(struct pt_regs *regs)
>      exception is in the MSR. */
>   #define get_reason(regs)	((regs)->msr)
>   #define get_mc_reason(regs)	((regs)->msr)
> -#define REASON_TM		0x200000
> -#define REASON_FP		0x100000
> -#define REASON_ILLEGAL		0x80000
> -#define REASON_PRIVILEGED	0x40000
> -#define REASON_TRAP		0x20000
> +#define REASON_TM		SRR1_PROGTMBAD
> +#define REASON_FP		SRR1_PROGFPE
> +#define REASON_ILLEGAL		SRR1_PROGILL
> +#define REASON_PRIVILEGED	SRR1_PROGPRIV
> +#define REASON_TRAP		SRR1_PROGTRAP
>   
>   #define single_stepping(regs)	((regs)->msr & MSR_SE)
>   #define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
> 
