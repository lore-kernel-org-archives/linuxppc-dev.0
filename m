Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmfyl1NzmzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Apr 2016 00:27:59 +1000 (AEST)
In-Reply-To: <20160415120613.1bbdc5d5@kryten>
To: <anton@samba.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>,
 <matt@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org
Subject: Re: [1/3] powerpc: scan_features() updates incorrect bits
Message-Id: <3qmfyk6wGYz9t6X@ozlabs.org>
Date: Sat, 16 Apr 2016 00:27:58 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-15-04 at 02:06:13 UTC, Unknown sender due to SPF wrote:
> The real LE feature entry in the ibm_pa_feature struct has the
> wrong number of elements. Instead of checking for byte 5, bit 0,
> we check for byte 0, bit 0, and we also incorrectly update cpu user
> feature bit 5.
>
> Fixes: 44ae3ab3358e ("powerpc: Free up some CPU feature bits by moving out MMU-related features")

So pulling that apart a bit.

> -	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 5,         0,   0},   (invert 0)
	 ^                ^                    ^          ^    ^
	 cpu feat	  mmu feat	       user feat  byte bit

By checking byte 0 bit 0 (IBM numbering), means we're looking at the "Memory
Management Unit (MMU)" feature - ie. does the CPU have an MMU.

As you'd expect that bit is set on most platforms we care about. I see it set on
a P6 & P7 here running PowerVM, as well as by recent Qemu on P8.

Which means on all those systems we'll be enabling those bits.

As far as the cpu feature bits:

  #define CPU_FTR_REAL_LE			0x00400000

On a guest running on P8 on older qemu which has no ibm,pa-features property I
see:

  cpu_features      = 0x17fc7aec18500249
                                  ^

So it's set, but not by this logic, because it's already in cpu_features for P8.

On Power6, which does have the ibm,pa-feature property with bit 0,0 set:

  cpu_features      = 0x090d1ae018500049
                                  ^

Also set, from the property, but it's also in the Power6 mask by default. So all
we've lost there is the ability to turn it off.


For the MMU feature, we're setting:

  #define PPC_FEATURE_TRUE_LE		0x00000002

Which matches:

  #define MMU_FTR_TYPE_8xx		0x00000002

And on the Power6 I do indeed see:

  mmu_features      = 0x7c000003

Which says I have MMU_FTR_HPTE_TABLE and MMU_FTR_TYPE_8xx.

Luckily it looks like the only place that looks at MMU_FTR_TYPE_8xx is in Book3E
code, so will never be affected by this bug.


Finally the user feature, we're setting 5, ie. 0x4 | 0x1, which is:

#define PPC_FEATURE_PPC_LE		0x00000001

And nothing else, 0x4 is free.

On the Power6, I can see it in /proc/pid/auxv:

00000060  00 00 00 00 00 00 00 10  00 00 00 00 dc 00 74 47  |..............tG|
							 ^
							 0x4 | 0x2 | 0x1

LD_SHOW_AUXV=1 doesn't show it, but that's just because my glibc is old.


Net result:
 - on P6 & P7 (& P8 with newer Qemu) we can't disable CPU_FTR_REAL_LE - but
   luckily we've never wanted to.
 - we're stuffing up mmu_features but it doesn't matter
 - we're advertising PPC_LE when we shouldn't be, but *probably* nothing cares.
 - we're advertising 0x4 in HWCAP which is undefined, but *almost certainly*
   nothing cares.

So that could have been a doozy but turns out not actually that bad. Phew :)

cheers


> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -158,7 +158,7 @@ static struct ibm_pa_feature {
>  	{CPU_FTR_NOEXECUTE, 0, 0,	0, 6, 0},
>  	{CPU_FTR_NODSISRALIGN, 0, 0,	1, 1, 1},
>  	{0, MMU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
> -	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 5, 0, 0},
> +	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 0, 5, 0, 0},
>  	/*
>  	 * If the kernel doesn't support TM (ie. CONFIG_PPC_TRANSACTIONAL_MEM=n),
>  	 * we don't want to turn on CPU_FTR_TM here, so we use CPU_FTR_TM_COMP
