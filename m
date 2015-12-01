Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 371171A0295
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 22:23:01 +1100 (AEDT)
Message-ID: <1448968980.18781.3.camel@ellerman.id.au>
Subject: Re: [PATCH 07/19] powerpc: Create mtmsrd_isync()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org, mikey@neuling.org, cyrilbur@gmail.com,
 scottwood@freescale.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 01 Dec 2015 22:23:00 +1100
In-Reply-To: <1446079451-8774-8-git-send-email-anton@samba.org>
References: <1446079451-8774-1-git-send-email-anton@samba.org>
 <1446079451-8774-8-git-send-email-anton@samba.org>
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

On Thu, 2015-10-29 at 11:43 +1100, Anton Blanchard wrote:

> mtmsrd_isync() will do an mtmsrd followed by an isync on older
> processors. On newer processors we avoid the isync via a feature fixup.
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index ef64219..5bf8ec2 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -130,7 +130,10 @@ void enable_kernel_fp(void)
>  		check_if_tm_restore_required(current);
>  		giveup_fpu(current);
>  	} else {
> -		giveup_fpu(NULL);	/* just enables FP for kernel */
> +		u64 oldmsr = mfmsr();
> +
> +		if (!(oldmsr & MSR_FP))
> +			mtmsr_isync(oldmsr | MSR_FP);

You seem to do this pattern at all call sites.

So should we instead have a helper that makes sure an MSR bit(s) is/are set?

Maybe:

static inline void msr_enable(unsigned long enable_bits)
{
	u64 val, msr = mfmsr();

	if (msr & enable_bits)
		return;

	val = msr | enable_bits;
	asm volatile(__MTMSR " %0; " ASM_FTR_IFCLR("isync", "nop", %1) : :
			"r" (val), "i" (CPU_FTR_ARCH_206) : "memory");
}


Thoughts?

cheers
