Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 by lists.ozlabs.org (Postfix) with ESMTP id C85E61A0B87
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 15:20:35 +1100 (AEDT)
Date: Mon, 7 Mar 2016 15:19:52 +1100
From: Anton Blanchard <anton@samba.org>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/process: fix altivec SPR not being saved
Message-ID: <20160307151952.4df95a71@kryten>
In-Reply-To: <1457303588-29173-1-git-send-email-oohall@gmail.com>
References: <1457303588-29173-1-git-send-email-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Oliver,

> In save_sprs() in process.c contains the following test:
> 
> 	if (cpu_has_feature(cpu_has_feature(CPU_FTR_ALTIVEC)))
> 		t->vrsave = mfspr(SPRN_VRSAVE);
> 
> CPU feature with the mask 0x1 is CPU_FTR_COHERENT_ICACHE so the test
> is equivilent to:
> 
> 	if (cpu_has_feature(CPU_FTR_ALTIVEC) &&
> 		cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
> 
> On CPUs without support for both (i.e G5) this results in vrsave not
> being saved between context switches. The vector register
> save/restore code doesn't use VRSAVE to determine which registers to
> save/restore, but the value of VRSAVE is used to determine if altivec
> is being used in several code paths.

Nice catch, not sure how I missed that. As Ben suggests, it should
definitely go to -stable as well.

Feel free to add my sign off:

Signed-off-by: Anton Blanchard <anton@samba.org>

Anton

> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>  arch/powerpc/kernel/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/process.c
> b/arch/powerpc/kernel/process.c index 8224852..5a4d4d1 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -855,7 +855,7 @@ void restore_tm_state(struct pt_regs *regs)
>  static inline void save_sprs(struct thread_struct *t)
>  {
>  #ifdef CONFIG_ALTIVEC
> -	if (cpu_has_feature(cpu_has_feature(CPU_FTR_ALTIVEC)))
> +	if (cpu_has_feature(CPU_FTR_ALTIVEC))
>  		t->vrsave = mfspr(SPRN_VRSAVE);
>  #endif
>  #ifdef CONFIG_PPC_BOOK3S_64
