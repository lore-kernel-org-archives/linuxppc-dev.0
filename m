Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fv5k5szjzF28m
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 02:03:38 +1000 (AEST)
In-Reply-To: <20180316215443.2807-1-mgreer@animalcreek.com>
To: Mark Greer <mgreer@animalcreek.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Mark Greer <mgreer@animalcreek.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: powerpc/boot: Remove duplicate typedefs from libfdt_env.h
Message-Id: <40Fv5k0q97z9s0p@ozlabs.org>
Date: Wed,  4 Apr 2018 02:03:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-03-16 at 21:54:43 UTC, Mark Greer wrote:
> When building a uImage or zImage using ppc6xx_defconfig and some other
> defconfigs, the following error occurs:
> 
>   BOOTCC  arch/powerpc/boot/fdt.o
>   In file included from arch/powerpc/boot/fdt.c:51:0:
>   ../arch/powerpc/boot/libfdt_env.h:10:13: error: redefinition of typedef 'uint32_t'
>   ../arch/powerpc/boot/types.h:21:13: note: previous declaration of 'uint32_t' was here
>   ../arch/powerpc/boot/libfdt_env.h:11:13: error: redefinition of typedef 'uint64_t'
>   ../arch/powerpc/boot/types.h:22:13: note: previous declaration of 'uint64_t' was here
>   ../arch/powerpc/boot/Makefile:210: recipe for target 'arch/powerpc/boot/fdt.o' failed
>   make[2]: *** [arch/powerpc/boot/fdt.o] Error 1
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

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/147704534e2de30dd47171d55240c3

cheers
