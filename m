Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A925DDE1A
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 08:54:14 +1100 (EST)
Message-Id: <6612E7C6-C570-4748-BCEE-AC6733C0BB14@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20071116072149.350ADDDDF4@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] powerpc: Fix 44x Machine Check handling
Date: Fri, 16 Nov 2007 15:54:03 -0600
References: <20071116072149.350ADDDDF4@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 16, 2007, at 1:21 AM, Benjamin Herrenschmidt wrote:

> This removes the old CONFIG_440A which was a pain for multiplatform
> kernel and wasn't set properly by default and replaces it with a
> CPU feature. This makes Machine Check reporting work correctly on
> my Ebony (440GP) board.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> Note: I'm only setting it for 440GX and EPx as the old code did,
> I haven't checked whether other new 440 chips such as SPe also
> need that bit set.
>
> arch/powerpc/kernel/cputable.c     |   10 +++++-----
> arch/powerpc/kernel/head_44x.S     |   11 ++++++-----
> arch/powerpc/kernel/traps.c        |   19 ++++++++-----------
> arch/powerpc/platforms/44x/Kconfig |    5 -----
> include/asm-powerpc/cputable.h     |    3 ++-
> include/asm-powerpc/reg_booke.h    |    2 +-
> 6 files changed, 22 insertions(+), 28 deletions(-)
>
[snip]

> Index: linux-work/include/asm-powerpc/cputable.h
> ===================================================================
> --- linux-work.orig/include/asm-powerpc/cputable.h	2007-11-16  
> 16:14:29.000000000 +1100
> +++ linux-work/include/asm-powerpc/cputable.h	2007-11-16  
> 16:19:35.000000000 +1100
> @@ -138,6 +138,7 @@ extern void do_feature_fixups(unsigned l
> #define CPU_FTR_FPU_UNAVAILABLE		ASM_CONST(0x0000000000800000)
> #define CPU_FTR_UNIFIED_ID_CACHE	ASM_CONST(0x0000000001000000)
> #define CPU_FTR_SPE			ASM_CONST(0x0000000002000000)
> +#define CPU_FTR_440A			ASM_CONST(0x0000000004000000)

Can we be more specific about what this feature really means.

How about something like CPU_FTR_ENH_MCHCK or something like that.

- k
