Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWGLZ1WlZzDqLm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 08:15:01 +1000 (AEST)
Message-ID: <1495404881.3092.141.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add PPC_FEATURE userspace bits for SCV and
 DARN instructions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: benh@ozlabs.au.ibm.com, tuliom@linux.vnet.ibm.com, Steve Munroe
 <sjmunroe@us.ibm.com>, Bill Schmidt <wschmidt@us.ibm.com>, Peter Bergner
 <bergner@us.ibm.com>, Michael Neuling <michael.neuling@au1.ibm.com>
Date: Mon, 22 May 2017 08:14:41 +1000
In-Reply-To: <20170520042949.29359-1-npiggin@gmail.com>
References: <20170520042949.29359-1-npiggin@gmail.com>
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

On Sat, 2017-05-20 at 14:29 +1000, Nicholas Piggin wrote:
> Providing "scv" support to userspace requires kernel support, so it
> must be advertised as independently to the base ISA 3 instruction set.
> 
> The darn instruction relies on firmware enablement, so it has been
> decided to split this out from the core ISA 3 feature as well.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> These uapi changes have been agreed by powerpc toolchain and firmware
> teams. I believe this completes our anticipated requirements for user
> feature advertisement for ISA v3.0B.
> 
>  arch/powerpc/include/uapi/asm/cputable.h | 2 ++
>  arch/powerpc/kernel/cputable.c           | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
> index 3e7ce86d5c13..4d877144f377 100644
> --- a/arch/powerpc/include/uapi/asm/cputable.h
> +++ b/arch/powerpc/include/uapi/asm/cputable.h
> @@ -46,6 +46,8 @@
>  #define PPC_FEATURE2_HTM_NOSC		0x01000000
>  #define PPC_FEATURE2_ARCH_3_00		0x00800000 /* ISA 3.00 */
>  #define PPC_FEATURE2_HAS_IEEE128	0x00400000 /* VSX IEEE Binary Float 128-bit */
> +#define PPC_FEATURE2_DARN		0x00200000 /* darn random number insn */
> +#define PPC_FEATURE2_SCV		0x00100000 /* scv syscall */
>  
>  /*
>   * IMPORTANT!
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index 9b3e88b1a9c8..6f849832a669 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -124,7 +124,8 @@ extern void __restore_cpu_e6500(void);
>  #define COMMON_USER_POWER9	COMMON_USER_POWER8
>  #define COMMON_USER2_POWER9	(COMMON_USER2_POWER8 | \
>  				 PPC_FEATURE2_ARCH_3_00 | \
> -				 PPC_FEATURE2_HAS_IEEE128)
> +				 PPC_FEATURE2_HAS_IEEE128 | \
> +				 PPC_FEATURE2_DARN )
>  
>  #ifdef CONFIG_PPC_BOOK3E_64
>  #define COMMON_USER_BOOKE	(COMMON_USER_PPC64 | PPC_FEATURE_BOOKE)
