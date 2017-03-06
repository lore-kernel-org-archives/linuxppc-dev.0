Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcFDm2Nv1zDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 20:42:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: sparsemem should be the default on powernv
In-Reply-To: <1488754796.2870.112.camel@kernel.crashing.org>
References: <1488754796.2870.112.camel@kernel.crashing.org>
Date: Mon, 06 Mar 2017 20:41:59 +1100
Message-ID: <87fuiqpwrc.fsf@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> This is especially true of POWER9 where memory between chips is
> discontiguous.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 4940917..c4b4c55 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -580,7 +580,7 @@ config ARCH_SPARSEMEM_ENABLE
>  
>  config ARCH_SPARSEMEM_DEFAULT
>  	def_bool y
> -	depends on (SMP && PPC_PSERIES) || PPC_PS3
> +	depends on (SMP && PPC_PSERIES) || PPC_PS3 || PPC_POWERNV

Why don't we just make it default y for BOOK3S_64?

It's just the default after all, it can still be changed.

cheers
