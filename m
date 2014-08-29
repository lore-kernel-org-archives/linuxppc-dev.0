Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 by lists.ozlabs.org (Postfix) with ESMTP id 0794B1A006A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Aug 2014 01:06:08 +1000 (EST)
In-Reply-To: <20140829091437.832C41ABD65@localhost.localdomain>
References: <20140829091437.832C41ABD65@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
Subject: Re: [PATCH v2 02/19] powerpc/8xx: Use SCRATCH0 and SCRATCH1 also for
 TLB handlers
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OF79DA9719.90FA0859-ONC1257D43.0052506D-C1257D43.0052F4B4@transmode.se>
Date: Fri, 29 Aug 2014 17:06:05 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> wrote on 2014/08/29 11:14:37:
> 
> SCRATCH0 and SCRATCH1 are only used in Exceptions prologs where no other
> exception can happen. There is therefore no need to preserve them 
accross
> TLB handlers, we can use them there as in other exceptions. One of the
> advantages is that they do not suffer CPU6 errata unlike M_TW register.

Really nice! Some comments below

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> ---
>  arch/powerpc/kernel/head_8xx.S |  104 
++++++++++++----------------------
>  1 files changed, 36 insertions(+), 68 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_8xx.S 
b/arch/powerpc/kernel/head_8xx.S
> index 1329c5a..3af6db1 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -104,12 +104,15 @@ turn_on_mmu:
>   * task's thread_struct.
>   */
>  #define EXCEPTION_PROLOG   \
> -   mtspr   SPRN_SPRG_SCRATCH0,r10;   \
> -   mtspr   SPRN_SPRG_SCRATCH1,r11;   \
> -   mfcr   r10;      \
> +   EXCEPTION_PROLOG_0;   \
>     EXCEPTION_PROLOG_1;   \
>     EXCEPTION_PROLOG_2
> 
> +#define EXCEPTION_PROLOG_0   \
> +   mtspr   SPRN_SPRG_SCRATCH0,r10;   \
> +   mtspr   SPRN_SPRG_SCRATCH1,r11;   \
> +   mfcr   r10
> +
>  #define EXCEPTION_PROLOG_1   \
>     mfspr   r11,SPRN_SRR1;      /* check whether user or kernel */ \
>     andi.   r11,r11,MSR_PR;   \
> @@ -145,6 +148,14 @@ turn_on_mmu:
>     SAVE_2GPRS(7, r11)
> 
>  /*
> + * Exception exit code.
> + */
> +#define EXCEPTION_EPILOG_0   \
> +   mtcr   r10;      \
> +   mfspr   r10,SPRN_SPRG_SCRATCH0;   \
> +   mfspr   r11,SPRN_SPRG_SCRATCH1
> +
> +/*
>   * Note: code which follows this uses cr0.eq (set if from kernel),
>   * r11, r12 (SRR0), and r9 (SRR1).
>   *
> @@ -293,16 +304,8 @@ InstructionTLBMiss:
>  #ifdef CONFIG_8xx_CPU6
>     stw   r3, 8(r0)

Perhaps you can use SPRN_DAR to stash R3 now that it is free ?

     Jocke
