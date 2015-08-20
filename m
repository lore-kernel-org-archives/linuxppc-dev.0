Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E584C1A0175
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 14:54:07 +1000 (AEST)
Message-ID: <1440046447.13406.15.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 14/17] powerpc/book3e-64/kexec: Enable SMP release
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Tiejun Chen <tiejun.chen@intel.com>,
 kexec@lists.infradead.org
Date: Thu, 20 Aug 2015 14:54:07 +1000
In-Reply-To: <1437250134-307-15-git-send-email-scottwood@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
 <1437250134-307-15-git-send-email-scottwood@freescale.com>
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

Hi Scott,

Sorry for the delay. So I'm back to square one on this patch.

On Sat, 2015-07-18 at 15:08 -0500, Scott Wood wrote:
> booted_from_exec is similar to __run_at_load, except that it is set for
> regular kexec as well as kdump.
> 
> The flag is needed because the SMP release mechanism for FSL book3e is
> different from when booting with normal hardware.  In theory we could
> simulate the normal spin table mechanism, but not at the addresses
> U-Boot put in the device tree -- so there'd need to be even more
> communication between the kernel and kexec to set that up.  Since
> there's already a similar flag being set (for kdump only), this seemed
> like a reasonable approach.

Although this is a reasonable approach, I don't think it's the best approach.

AFAICS there's no reason why we can't use a device tree property for this, so I
think we should do that.

It avoids using up space in the low memory area, and also any ambiguities about
whether the value has been set or not.

The reason we used a flag like this for __run_at_load is we need to access that
very early, ie. before we've even relocated the kernel, well before we have
(easy) access to the flattened device tree.

In contrast for this, you don't need to know you're booted from kexec until
much later, so using a device tree property is cleaner and just as easy.

If you want to call it "linux,kexec-boot" or similar that's fine. Equally you
could make it more specific, something like "fsl,avoid-spin-table".


Also below ...

> diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
> index 5152289..4abda43 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -305,10 +310,13 @@ static int smp_85xx_kick_cpu(int nr)
>  		__secondary_hold_acknowledge = -1;
>  	}
>  #endif
> -	flush_spin_table(spin_table);
> -	out_be32(&spin_table->pir, hw_cpu);
> -	out_be32(&spin_table->addr_l, __pa(__early_start));
> -	flush_spin_table(spin_table);
> +
> +	if (have_spin_table) {
> +		flush_spin_table(spin_table);
> +		out_be32(&spin_table->pir, hw_cpu);
> +		out_be32(&spin_table->addr_l, __pa(__early_start));
> +		flush_spin_table(spin_table);
> +	}
>  
>  	/* Wait a bit for the CPU to ack. */
>  	if (!spin_event_timeout(__secondary_hold_acknowledge == hw_cpu,

This looks like it's inside an #ifdef CONFIG_PPC32 block, which doesn't make
sense, so I must be missing a lead-up patch or something? (I looked on the list
but didn't find anything immediately)

cheers
