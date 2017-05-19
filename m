Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTkgy0HSmzDqPj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 20:24:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ivan Mikhaylov <ivan@de.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@ozlabs.au.ibm.com>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/4] arch/powerpc/44x/fsp2: wdt tcr update instead of
 whole rewrite
In-Reply-To: <20170515130754.59363-5-ivan@de.ibm.com>
References: <20170515130754.59363-5-ivan@de.ibm.com>
Date: Fri, 19 May 2017 20:24:44 +1000
Message-ID: <87wp9d5ekz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ivan,

Ivan Mikhaylov <ivan@de.ibm.com> writes:
> Prevent a kernel panic caused by unintentionally clearing TCR
> watchdog bits.  At this point in the kernel boot, the watchdog has
> already been enabled by u-boot.  The original code's attempt to
> write to the TCR register results in an inadvertent clearing of the
> watchdog configuration bits, causing the 476 to reset.
> Panic happens in case of error as silently reboot without any outputs
> on serial.

That sounds reasonable.

> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 2b33cfa..f75e512 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -738,12 +738,28 @@ static int __init get_freq(char *name, int cells, u=
nsigned long *val)
>=20=20
>  static void start_cpu_decrementer(void)
>  {
> +	unsigned int tcr;
>  #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
>  	/* Clear any pending timer interrupts */
>  	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
>=20=20
> +#ifdef CONFIG_FSP2
> +	/*
> +	 * Prevent a kernel panic caused by unintentionally clearing TCR
> +	 * watchdog bits.  At this point in the kernel boot, the watchdog has
> +	 * already been enabled by u-boot.  The original code's attempt to

Don't refer to "the original code", as it doesn't exist anymore now that
we've patched it. Just say something like ".. so we must not clear the
watchdog configuration bits".

> +	 * write to the TCR register results in an inadvertent clearing of the
> +	 * watchdog configuration bits, causing the 440 to reset.
> +	 */
> +	tcr =3D mfspr(SPRN_TCR);
> +	tcr &=3D TCR_WP_MASK; /* clear all bits except for TCR[WP] */
> +	tcr |=3D TCR_DIE; /* enable decrementer */
> +	mtspr(SPRN_TCR, tcr);
> +#else
>  	/* Enable decrementer interrupt */
>  	mtspr(SPRN_TCR, TCR_DIE);
> +#endif
> +
>  #endif /* defined(CONFIG_BOOKE) || defined(CONFIG_40x) */

That breaks the build for other platforms:

  arch/powerpc/kernel/time.c: In function =E2=80=98start_cpu_decrementer=E2=
=80=99:
  arch/powerpc/kernel/time.c:741:15: error: unused variable =E2=80=98tcr=E2=
=80=99 [-Werror=3Dunused-variable]

You can just do something like:

  #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
  	unsigned int tcr;

  #ifdef CONFIG_FSP2
  	tcr =3D mfspr(SPRN_TCR);
  	tcr &=3D TCR_WP_MASK; /* clear all bits except for TCR[WP] */
  #else
  	tcr =3D 0;
  #endif
  	tcr |=3D TCR_DIE; /* enable decrementer */
  	mtspr(SPRN_TCR, TCR_DIE);
  #endif /* defined(CONFIG_BOOKE) || defined(CONFIG_40x) */


Or you could possibly just always leave TCR[WP], is there any case where
it would be correct to clear that?

cheers
