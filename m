Return-Path: <benh@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CAB51A173B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:52:02 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 7 Mar 2016 13:52:01 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6B5DF2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:51:59 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u273pp3N60948554
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:51:59 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u273pR4X015184
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:51:27 +1100
Message-ID: <1457322662.2943.24.camel@au1.ibm.com>
Subject: Re: [PATCH] powerpc/process: fix altivec SPR not being saved
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 07 Mar 2016 14:51:02 +1100
In-Reply-To: <1457303588-29173-1-git-send-email-oohall@gmail.com>
References: <1457303588-29173-1-git-send-email-oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-03-07 at 09:33 +1100, Oliver O'Halloran wrote:
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
> being
> saved between context switches. The vector register save/restore code
> doesn't use VRSAVE to determine which registers to save/restore,
> but the value of VRSAVE is used to determine if altivec is being used
> in several code paths.

Nice one, should probably go to stable !

> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>  arch/powerpc/kernel/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/process.c
> b/arch/powerpc/kernel/process.c
> index 8224852..5a4d4d1 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -855,7 +855,7 @@ void restore_tm_state(struct pt_regs *regs)
>  static inline void save_sprs(struct thread_struct *t)
>  {
>  #ifdef CONFIG_ALTIVEC
> -	if (cpu_has_feature(cpu_has_feature(CPU_FTR_ALTIVEC)))
> +	if (cpu_has_feature(CPU_FTR_ALTIVEC))
>  		t->vrsave = mfspr(SPRN_VRSAVE);
>  #endif
>  #ifdef CONFIG_PPC_BOOK3S_64
