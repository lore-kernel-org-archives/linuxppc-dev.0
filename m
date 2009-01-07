Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6EB9DE705
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 14:16:55 +1100 (EST)
Subject: Re: [PATCH 7/7] powerpc/64/kdump: Use ppc_save_regs() in
	crash_setup_regs()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081217200935.GG4624@oksana.dev.rtsoft.ru>
References: <20081217200610.GA31887@oksana.dev.rtsoft.ru>
	<20081217200935.GG4624@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 14:16:05 +1100
Message-Id: <1231298165.14860.56.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-12-17 at 23:09 +0300, Anton Vorontsov wrote:
> The patch replaces internal registers dump implementation with
> ppc_save_regs(). From now on PPC64 and PPC32 are using the same
> code for crash_setup_regs().
> 
> NOTE: The old regs dump implementation was capturing SP (r1) directly
> as is, so you could see crash_kexec() function on top of the back-trace.
> But ppc_save_regs() goes up one stack frame, so you'll not see it
> anymore, at the top-level you'll see who actually triggered the crash
> dump instead.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

Note that ppc_save_regs() for some obscure reason isn't saving r1...

Is that a problem for you ? I think we should fix ppc_save_regs()
anyway, it doesn't matter for xmon to save one more register and it will
avoid nasty surprises in the long run.

Can you send an updated patch ?

Thanks !
Ben.

> p.s.
> The patch is the last in the series, so you can easily drop it
> until somebody actually test it (I don't have any PPC64 machine,
> so I'm looking for volunteers. :-)
> 
>  arch/powerpc/include/asm/kexec.h |   55 --------------------------------------
>  1 files changed, 0 insertions(+), 55 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index 6dbffc9..7e06b43 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -48,63 +48,8 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
>  {
>  	if (oldregs)
>  		memcpy(newregs, oldregs, sizeof(*newregs));
> -#ifdef __powerpc64__
> -	else {
> -		/* FIXME Merge this with xmon_save_regs ?? */
> -		unsigned long tmp1, tmp2;
> -		__asm__ __volatile__ (
> -			"std    0,0(%2)\n"
> -			"std    1,8(%2)\n"
> -			"std    2,16(%2)\n"
> -			"std    3,24(%2)\n"
> -			"std    4,32(%2)\n"
> -			"std    5,40(%2)\n"
> -			"std    6,48(%2)\n"
> -			"std    7,56(%2)\n"
> -			"std    8,64(%2)\n"
> -			"std    9,72(%2)\n"
> -			"std    10,80(%2)\n"
> -			"std    11,88(%2)\n"
> -			"std    12,96(%2)\n"
> -			"std    13,104(%2)\n"
> -			"std    14,112(%2)\n"
> -			"std    15,120(%2)\n"
> -			"std    16,128(%2)\n"
> -			"std    17,136(%2)\n"
> -			"std    18,144(%2)\n"
> -			"std    19,152(%2)\n"
> -			"std    20,160(%2)\n"
> -			"std    21,168(%2)\n"
> -			"std    22,176(%2)\n"
> -			"std    23,184(%2)\n"
> -			"std    24,192(%2)\n"
> -			"std    25,200(%2)\n"
> -			"std    26,208(%2)\n"
> -			"std    27,216(%2)\n"
> -			"std    28,224(%2)\n"
> -			"std    29,232(%2)\n"
> -			"std    30,240(%2)\n"
> -			"std    31,248(%2)\n"
> -			"mfmsr  %0\n"
> -			"std    %0, 264(%2)\n"
> -			"mfctr  %0\n"
> -			"std    %0, 280(%2)\n"
> -			"mflr   %0\n"
> -			"std    %0, 288(%2)\n"
> -			"bl     1f\n"
> -		"1:     mflr   %1\n"
> -			"std    %1, 256(%2)\n"
> -			"mtlr   %0\n"
> -			"mfxer  %0\n"
> -			"std    %0, 296(%2)\n"
> -			: "=&r" (tmp1), "=&r" (tmp2)
> -			: "b" (newregs)
> -			: "memory");
> -	}
> -#else
>  	else
>  		ppc_save_regs(newregs);
> -#endif /* __powerpc64__ */
>  }
>  
>  extern void kexec_smp_wait(void);	/* get and clear naca physid, wait for
