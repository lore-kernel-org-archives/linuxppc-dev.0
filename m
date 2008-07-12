Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 84BA4DDED8
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jul 2008 04:00:14 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] reorganize cputypes for PPC64
Date: Sat, 12 Jul 2008 20:00:05 +0200
References: <200807121516.49576.marvin24@gmx.de>
In-Reply-To: <200807121516.49576.marvin24@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200807122000.05966.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 12 July 2008, Marvin wrote:
> attached patch introduces a "processor type" menu similar to ppc32. It 
> _should_ not change anything upto now. 
> 
> The aim is to allow future fine graded cpu optimizations via mcpu/mtune 
> compiler flags and also to clean up the arch Makefile/Kconfig.cputypes (I 
> know this is a minefield).

I tried something similar last year, but failed miserably, because the
complexity cannot really be contained. I still think it's a good idea,
but I'm not sure whether your patch will help at all.

> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index f7efaa9..eebde6c 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -54,35 +54,65 @@ config E200
>  
>  endchoice
>  
> -config POWER4_ONLY
> -       bool "Optimize for POWER4"
> +choice
> +       prompt "Processor Type"
>         depends on PPC64
> +       default TUNE_POWER4
> +       help
> +         There are serveral families of 64 bit PowerPC chips supported.
> +         These include the Power3 to Power6 series, 970, and Cell BE based
> +         CPUs made be IBM.
> +
> +         If unsure, select Power4.
> +
> +config TUNE_POWER3
> +       bool "Power3"
> +
> +config TUNE_POWER4
> +       bool "Power4"
> +
> +config TUNE_970
> +       bool "970/G5"
> +
> +config TUNE_POWER5
> +       bool "Power5"
> +
> +config TUNE_POWER6
> +       bool "Power6"
> +
> +config TUNE_CELL
> +       bool "Cell Broadband Engine"
> +       help
> +         Cause the compiler to optimize for the PPE of the Cell Broadband
> +         Engine. This will make the code run considerably faster on Cell
> +         but somewhat slower on other machines. If the resulting kernel is
> +         built to run only on Cell BE machines, select also OPT_EXCLUSIVE.
> +
> +endchoice

What about the other CPUs? There is also RS64, Power5+, PA6T and Power7.

> +
> +config OPT_EXCLUSIVE
> +       bool "Optimize to run exclusive on selected CPU"
>         default n
> -       ---help---
> -         Cause the compiler to optimize for POWER4/POWER5/PPC970 processors.
> -         The resulting binary will not work on POWER3 or RS64 processors
> -         when compiled with binutils 2.15 or later.
> +       help
> +         Cause the compiler to optimize to run exclusive on the selected
> +         CPU. The resulting binary will probably not work on other CPUs.
> +         
> +         If the compiler/binutils combination does not support the exclusive
> +         optimization, it will try to tune only or fail.
> +         
> +         If you are unsure, select no.

Almost all CPUs are backwards compatible, so the option should not
be labelled 'exclusive'. In general, if you build for PowerX, it will
also run on Power(X+1). 970 is backwards compatible to Power4, Cell
and PA6T are backwards compatible to 970, Power6 is backwards compatible 
to both of these.

Also, there are good reasons to have the -mcpu option different from
-mtune. E.g. you may want to use Power4 compatible instructions but
tune for Power6 in a typical distro kernel.

>  
>  config POWER3
> -       bool
>         depends on PPC64
> -       default y if !POWER4_ONLY
> +       def_bool y if !POWER4_ONLY
>  
>  config POWER4
>         depends on PPC64
>         def_bool y
>  
> -config TUNE_CELL
> -       bool "Optimize for Cell Broadband Engine"
> +config POWER4_ONLY
>         depends on PPC64
> -       help
> -         Cause the compiler to optimize for the PPE of the Cell Broadband
> -         Engine. This will make the code run considerably faster on Cell
> -         but somewhat slower on other machines. This option only changes
> -         the scheduling of instructions, not the selection of instructions
> -         itself, so the resulting kernel will keep running on all other
> -         machines. When building a kernel that is supposed to run only
> -         on Cell, you should also select the POWER4_ONLY option.
> +       def_bool y if TUNE_POWER4 && OPT_EXCLUSIVE
>  
>  config 6xx
>         bool

Tuning for Cell gives a significant performance bonus on cell based machines
with a new compiler, and again, you would typically want to use the Power4
instruction set, but not restrict to Power3 or use all of the Cell instructions.

	Arnd <><
