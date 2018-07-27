Return-Path: <AlexeiS@astrosoft.ru>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02on0609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe05::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cQsY6TTjzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 20:57:35 +1000 (AEST)
From: Alexey Spirkov <AlexeiS@astrosoft.ru>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: "trivial@kernel.org" <trivial@kernel.org>, "andrew@ncrmnt.org"
 <andrew@ncrmnt.org>
Subject: RE: [PATCH] Adds __init annotation at mmu_init_secondary func
Date: Fri, 27 Jul 2018 10:57:29 +0000
Message-ID: <AM5PR03MB28496A9D6FD7B175312E48F6C92A0@AM5PR03MB2849.eurprd03.prod.outlook.com>
References: <AM5PR03MB28499BE4A0B6200F7DA83835C92B0@AM5PR03MB2849.eurprd03.prod.outlook.com>
 <87tvolrm43.fsf@concordia.ellerman.id.au>
In-Reply-To: <87tvolrm43.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Without any additional option=20

WARNING: modpost: Found 1 section mismatch(es).

If detailed debug is switched on than:

WARNING: vmlinux.o(.text+0x142ac): Section mismatch in reference from the f=
unction mmu_init_secondary() to the function .init.text:ppc44x_pin_tlb()
The function mmu_init_secondary() references
the function __init ppc44x_pin_tlb().
This is often because mmu_init_secondary lacks a __init=20
annotation or the annotation of ppc44x_pin_tlb is wrong.

Best regards,
Alexey Spirkov

-----Original Message-----
From: Michael Ellerman <mpe@ellerman.id.au>=20
Sent: Friday, July 27, 2018 1:48 PM
To: Alexey Spirkov <AlexeiS@astrosoft.ru>; Benjamin Herrenschmidt <benh@ker=
nel.crashing.org>; Paul Mackerras <paulus@samba.org>; linuxppc-dev@lists.oz=
labs.org
Cc: trivial@kernel.org; andrew@ncrmnt.org
Subject: Re: [PATCH] Adds __init annotation at mmu_init_secondary func

Alexey Spirkov <AlexeiS@astrosoft.ru> writes:

> mmu_init_secondary function called at initialization sequence but it=20
> misses __init annotation. As result modpost warning is generated.
> Some building systems sensitive to such kind of warnings.

What warning are you seeing?

AFAICS it's not called from, nor does it call, any __init code.

So I'm a bit confused.

cheers

> diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c=20
> index 82b1ff7..12d9251 100644
> --- a/arch/powerpc/mm/44x_mmu.c
> +++ b/arch/powerpc/mm/44x_mmu.c
> @@ -229,7 +229,7 @@ void setup_initial_memory_limit(phys_addr_t=20
> first_memblock_base,  }
> =20
>  #ifdef CONFIG_SMP
> -void mmu_init_secondary(int cpu)
> +void __init mmu_init_secondary(int cpu)
>  {
>  	unsigned long addr;
>  	unsigned long memstart =3D memstart_addr & ~(PPC_PIN_SIZE - 1);
> --
> 2.9.5
