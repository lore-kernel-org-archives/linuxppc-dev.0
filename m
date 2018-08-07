Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41l5Th4d55zDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 17:18:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: make CPU selection logic generic in Makefile
In-Reply-To: <273f8ed3e980b9385c6e1b31e17f890ea08ce33c.1528365638.git.christophe.leroy@c-s.fr>
References: <273f8ed3e980b9385c6e1b31e17f890ea08ce33c.1528365638.git.christophe.leroy@c-s.fr>
Date: Tue, 07 Aug 2018 17:18:31 +1000
Message-ID: <874lg6d4qg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> At the time being, when adding a new CPU for selection, both
> Kconfig.cputype and Makefile have to be modified.
>
> This patch moves into Kconfig.cputype the name of the CPU to me
> passed to the -mcpu= argument.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/Makefile                  |  8 +-------
>  arch/powerpc/platforms/Kconfig.cputype | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 9704ab360d39..9a5642552abc 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -175,13 +175,7 @@ ifdef CONFIG_MPROFILE_KERNEL
>      endif
>  endif
>  
> -CFLAGS-$(CONFIG_CELL_CPU) += $(call cc-option,-mcpu=cell)
> -CFLAGS-$(CONFIG_POWER5_CPU) += $(call cc-option,-mcpu=power5)
> -CFLAGS-$(CONFIG_POWER6_CPU) += $(call cc-option,-mcpu=power6)
> -CFLAGS-$(CONFIG_POWER7_CPU) += $(call cc-option,-mcpu=power7)
> -CFLAGS-$(CONFIG_POWER8_CPU) += $(call cc-option,-mcpu=power8)
> -CFLAGS-$(CONFIG_POWER9_CPU) += $(call cc-option,-mcpu=power9)
> -CFLAGS-$(CONFIG_PPC_8xx) += $(call cc-option,-mcpu=860)
> +CFLAGS-$(CONFIG_SPECIAL_CPU_BOOL) += $(call cc-option,-mcpu=$(CONFIG_SPECIAL_CPU))

This looks good.

I'll rename it from "SPECIAL_CPU" to "TARGET_CPU" because that's the
terminology used in the GCC docs, eg:

    -mcpu=name
           Specify the name of the target processor, optionally suffixed by one or more feature modifiers.


cheers
