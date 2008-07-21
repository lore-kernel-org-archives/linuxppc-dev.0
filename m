Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 70ADFDDEE8
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 19:40:47 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [3/5] replace CONFIG_POWER4 by CONFIG_PPC64
Date: Mon, 21 Jul 2008 11:40:38 +0200
References: <200807210845.20778.marvin24@gmx.de>
In-Reply-To: <200807210845.20778.marvin24@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807211140.38926.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 21 July 2008, Marvin wrote:
> diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
> index c53145f..c3509c8 100644
> --- a/arch/powerpc/mm/ppc_mmu_32.c
> +++ b/arch/powerpc/mm/ppc_mmu_32.c
> @@ -74,7 +74,7 @@ unsigned long p_mapped_by_bats(phys_addr_t pa)
> =A0
> =A0unsigned long __init mmu_mapin_ram(void)
> =A0{
> -#ifdef CONFIG_POWER4
> +#ifdef CONFIG_PPC64
> =A0=A0=A0=A0=A0=A0=A0=A0return 0;
> =A0#else
> =A0=A0=A0=A0=A0=A0=A0=A0unsigned long tot, bl, done;

ppc_mmu_32 is 32-bit only, so you can kill this #ifdef.

> diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputabl=
e.h
> index 0ef9abc..97fdbaf 100644
> --- a/include/asm-powerpc/cputable.h
> +++ b/include/asm-powerpc/cputable.h
> @@ -257,7 +257,7 @@ extern void do_feature_fixups(unsigned long value, vo=
id=20
> *fixup_start,
>  #endif
> =20
>  #define CLASSIC_PPC (!defined(CONFIG_8xx) && !defined(CONFIG_4xx) && \
> -		     !defined(CONFIG_POWER4) && !defined(CONFIG_BOOKE))
> +		     !defined(CONFIG_PPC64) && !defined(CONFIG_BOOKE))
> =20

This would be more logical in the opposite way:

#define CLASSIC_PPC (defined(CONFIG_PPC32) && !defined(CONFIG_8xx)
		     && !defined(CONFIG_4xx) && !defined(CONFIG_BOOKE))

	Arnd <><
