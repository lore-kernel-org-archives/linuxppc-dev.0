Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C686F1A0295
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 22:18:03 +1100 (AEDT)
Message-ID: <1448968677.18781.1.camel@ellerman.id.au>
Subject: Re: [PATCH 09/19] powerpc: Move part of giveup_fpu,altivec,spe into c
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org, mikey@neuling.org, cyrilbur@gmail.com,
 scottwood@freescale.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 01 Dec 2015 22:17:57 +1100
In-Reply-To: <1446079451-8774-10-git-send-email-anton@samba.org>
References: <1446079451-8774-1-git-send-email-anton@samba.org>
 <1446079451-8774-10-git-send-email-anton@samba.org>
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

On Thu, 2015-10-29 at 11:44 +1100, Anton Blanchard wrote:

> Move the MSR modification into new c functions. Removing it from
> the low level functions will allow us to avoid costly MSR writes
> by batching them up.
> 
> Move the check_if_tm_restore_required() check into these new functions.

> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 5bf8ec2..6bcf82b 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -214,6 +244,20 @@ EXPORT_SYMBOL_GPL(flush_vsx_to_thread);
>  #endif /* CONFIG_VSX */
>  
>  #ifdef CONFIG_SPE
> +void giveup_spe(struct task_struct *tsk)
> +{
> +	u64 oldmsr = mfmsr();
> +	u64 newmsr;
> +
> +	check_if_tm_restore_required(tsk);


We can't be building with SPE and also TM can we? I guess this is harmless as
it will compile to nothing, but it might be confusing to readers.

> +	newmsr = oldmsr | MSR_SPE;
> +	if (oldmsr != newmsr)
> +		mtmsr_isync(newmsr);
> +
> +	__giveup_spe(tsk);
> +}
> +EXPORT_SYMBOL(giveup_spe);
>  
>  void enable_kernel_spe(void)
>  {

cheers
