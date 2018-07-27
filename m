Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cQf85CkNzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 20:47:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Spirkov <AlexeiS@astrosoft.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: "trivial\@kernel.org" <trivial@kernel.org>,
 "andrew\@ncrmnt.org" <andrew@ncrmnt.org>
Subject: Re: [PATCH] Adds __init annotation at mmu_init_secondary func
In-Reply-To: <AM5PR03MB28499BE4A0B6200F7DA83835C92B0@AM5PR03MB2849.eurprd03.prod.outlook.com>
References: <AM5PR03MB28499BE4A0B6200F7DA83835C92B0@AM5PR03MB2849.eurprd03.prod.outlook.com>
Date: Fri, 27 Jul 2018 20:47:40 +1000
Message-ID: <87tvolrm43.fsf@concordia.ellerman.id.au>
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

Alexey Spirkov <AlexeiS@astrosoft.ru> writes:

> mmu_init_secondary function called at initialization sequence
> but it misses __init annotation. As result modpost warning is generated.
> Some building systems sensitive to such kind of warnings.

What warning are you seeing?

AFAICS it's not called from, nor does it call, any __init code.

So I'm a bit confused.

cheers

> diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
> index 82b1ff7..12d9251 100644
> --- a/arch/powerpc/mm/44x_mmu.c
> +++ b/arch/powerpc/mm/44x_mmu.c
> @@ -229,7 +229,7 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
>  }
>  
>  #ifdef CONFIG_SMP
> -void mmu_init_secondary(int cpu)
> +void __init mmu_init_secondary(int cpu)
>  {
>  	unsigned long addr;
>  	unsigned long memstart = memstart_addr & ~(PPC_PIN_SIZE - 1);
> -- 
> 2.9.5
