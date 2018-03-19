Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404VG442wZzF1ZB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 19:53:15 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/boot: Remove duplicate typedefs from libfdt_env.h
To: Mark Greer <mgreer@animalcreek.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20180316215443.2807-1-mgreer@animalcreek.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <e710d9d7-232b-6420-96a7-8167dd91b824@c-s.fr>
Date: Mon, 19 Mar 2018 09:53:09 +0100
MIME-Version: 1.0
In-Reply-To: <20180316215443.2807-1-mgreer@animalcreek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 16/03/2018 à 22:54, Mark Greer a écrit :
> When building a uImage or zImage using ppc6xx_defconfig and some other
> defconfigs, the following error occurs:
> 
>    BOOTCC  arch/powerpc/boot/fdt.o
>    In file included from arch/powerpc/boot/fdt.c:51:0:
>    ../arch/powerpc/boot/libfdt_env.h:10:13: error: redefinition of typedef 'uint32_t'
>    ../arch/powerpc/boot/types.h:21:13: note: previous declaration of 'uint32_t' was here
>    ../arch/powerpc/boot/libfdt_env.h:11:13: error: redefinition of typedef 'uint64_t'
>    ../arch/powerpc/boot/types.h:22:13: note: previous declaration of 'uint64_t' was here
>    ../arch/powerpc/boot/Makefile:210: recipe for target 'arch/powerpc/boot/fdt.o' failed
>    make[2]: *** [arch/powerpc/boot/fdt.o] Error 1
> 
> The problem is that commit 656ad58ef19e (powerpc/boot: Add OPAL console
> to epapr wrappers) adds typedefs for uint32_t and uint64_t to type.h but
> doesn't remove the pre-existing (and now duplicate) typedefs from
> libfdt_env.h.  Fix the error by removing the duplicat typedefs from
> libfdt_env.h
> 
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Oliver O'Halloran <oohall@gmail.com>
> Signed-off-by: Mark Greer <mgreer@animalcreek.com>
> ---
> Having said all of that, commit 656ad58ef19e (powerpc/boot: Add OPAL
> console to epapr wrappers) went into mainline back in 2016 so, AFAICT,
> this has been broken since then.  That seems unlikely so I must be
> missing something...  Any ideas what that is?

I just compiled uImage for ppc6xx_defconfig, and I don't get such error.
I looked at what gcc -E outputs, u32 is defined twice but it doesn't 
seems to bother GCC.

What version of GCC do you use ?
I tried with 5.4.0 and 4.6.3, both seems to work.

Christophe

> 
> I built all of the defconfigs that I had toolchains handy for (really
> just old-fashioned ppc32, non-booke) so I didn't test everything.
> Compile tested only as I no longer have any relevant hardware.
> 
> Based on git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux fixes
> currently at e4b79900222b (powerpc/64s: Fix NULL AT_BASE_PLATFORM when
> using DT CPU features).
> 
>   arch/powerpc/boot/libfdt_env.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/libfdt_env.h b/arch/powerpc/boot/libfdt_env.h
> index f52c31b1f48f..2a0c8b1bf147 100644
> --- a/arch/powerpc/boot/libfdt_env.h
> +++ b/arch/powerpc/boot/libfdt_env.h
> @@ -7,8 +7,6 @@
>   
>   #include "of.h"
>   
> -typedef u32 uint32_t;
> -typedef u64 uint64_t;
>   typedef unsigned long uintptr_t;
>   
>   typedef __be16 fdt16_t;
> 
